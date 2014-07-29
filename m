Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mta1.parkeon.com ([91.121.43.66]:49230 "EHLO mta1.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136AbaG2JBr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 29 Jul 2014 05:01:47 -0400
Subject: [PATCH V2 8/8] iio: mma8452: Add support for interrupt driven
 triggers.
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: pmeerw@pmeerw.net
Date: Tue, 29 Jul 2014 11:01:45 +0200
Message-ID: <20140729090145.4618.72768.stgit@localhost>
In-Reply-To: <20140729090128.4618.92936.stgit@localhost>
References: <20140729090128.4618.92936.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Implement interrupt driven trigger for data ready.
This allows more efficient access to the sample data.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/iio/accel/mma8452.c |   91 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 62589f9..7ccc369 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -18,6 +18,8 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/events.h>
 #include <linux/delay.h>
@@ -555,18 +557,24 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
 	struct mma8452_data *data = iio_priv(indio_dev);
+	int ret = IRQ_NONE;
 	int src;
 
 	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
 	if (src < 0)
 		return IRQ_NONE;
 
+	if (src & MMA8452_INT_DRDY) {
+		iio_trigger_poll_chained(indio_dev->trig, iio_get_time_ns());
+		ret = IRQ_HANDLED;
+	}
+
 	if (src & MMA8452_INT_TRANS) {
 		mma8452_transient_interrupt(indio_dev);
-		return IRQ_HANDLED;
+		ret = IRQ_HANDLED;
 	}
 
-	return IRQ_NONE;
+	return ret;
 }
 
 static irqreturn_t mma8452_trigger_handler(int irq, void *p)
@@ -699,6 +707,67 @@ static const struct iio_info mma8452_info = {
 
 static const unsigned long mma8452_scan_masks[] = {0x7, 0};
 
+static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
+		bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct mma8452_data *data = iio_priv(indio_dev);
+	int reg;
+
+	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
+	if (reg < 0)
+		return reg;
+
+	if (state)
+		reg |= MMA8452_INT_DRDY;
+	else
+		reg &= ~MMA8452_INT_DRDY;
+
+	return mma8452_change_config(data, MMA8452_CTRL_REG4, reg);
+}
+
+static const struct iio_trigger_ops mma8452_trigger_ops = {
+	.set_trigger_state = mma8452_data_rdy_trigger_set_state,
+	.owner = THIS_MODULE,
+};
+
+static int mma8452_trigger_setup(struct iio_dev *indio_dev)
+{
+	struct mma8452_data *data = iio_priv(indio_dev);
+	struct iio_trigger *trig;
+	int ret;
+
+	trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
+						indio_dev->id);
+	if (!trig)
+		return -ENOMEM;
+
+	trig->dev.parent = &data->client->dev;
+	trig->ops = &mma8452_trigger_ops;
+	iio_trigger_set_drvdata(trig, indio_dev);
+
+	ret = iio_trigger_register(trig);
+	if (ret)
+		goto err_trigger_free;
+
+	indio_dev->trig = trig;
+
+	return 0;
+
+err_trigger_free:
+	iio_trigger_free(trig);
+
+	return ret;
+}
+
+static void mma8452_trigger_cleanup(struct iio_dev *indio_dev)
+{
+	if (indio_dev->trig) {
+		iio_trigger_unregister(indio_dev->trig);
+		iio_trigger_free(indio_dev->trig);
+	}
+}
+
 static int mma8452_reset(struct i2c_client *client)
 {
 	int i;
@@ -772,7 +841,8 @@ static int mma8452_probe(struct i2c_client *client,
 		return ret;
 
 	if (client->irq) {
-		int supported_interrupts = MMA8452_INT_TRANS;
+		int supported_interrupts = MMA8452_INT_DRDY | MMA8452_INT_TRANS;
+		int enabled_interrupts = MMA8452_INT_TRANS;
 
 		/* Assume wired to INT1 pin */
 		ret = i2c_smbus_write_byte_data(client,
@@ -783,7 +853,11 @@ static int mma8452_probe(struct i2c_client *client,
 
 		ret = i2c_smbus_write_byte_data(client,
 						MMA8452_CTRL_REG4,
-						supported_interrupts);
+						enabled_interrupts);
+		if (ret < 0)
+			return ret;
+
+		ret = mma8452_trigger_setup(indio_dev);
 		if (ret < 0)
 			return ret;
 	}
@@ -793,12 +867,12 @@ static int mma8452_probe(struct i2c_client *client,
 	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
 		data->ctrl_reg1);
 	if (ret < 0)
-		return ret;
+		goto trigger_cleanup;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		mma8452_trigger_handler, NULL);
 	if (ret < 0)
-		return ret;
+		goto trigger_cleanup;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
@@ -820,6 +894,10 @@ device_cleanup:
 
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
+
+trigger_cleanup:
+	mma8452_trigger_cleanup(indio_dev);
+
 	return ret;
 }
 
@@ -829,6 +907,7 @@ static int mma8452_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
+	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
 
 	return 0;

