Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH V4 7/7] iio: mma8452: Add support for interrupt driven
 triggers.
To: Peter Meerwald <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>
Date: Wed, 13 May 2015 12:26:50 +0200
Message-ID: <20150513102650.27803.25835.stgit@localhost>
In-Reply-To: <20150513102635.27803.99054.stgit@localhost>
References: <20150513102635.27803.99054.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Implement interrupt driven trigger for data ready.
This allows more efficient access to the sample data.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/iio/accel/mma8452.c |   85 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 79 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 5f2977f..e568d34 100644
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
@@ -66,6 +68,7 @@
 #define MMA8452_DATA_CFG_FS_8G 2
 #define MMA8452_DATA_CFG_HPF_MASK BIT(4)
 
+#define MMA8452_INT_DRDY	BIT(0)
 #define MMA8452_INT_TRANS	BIT(5)
 
 #define MMA8452_DEVICE_ID 0x2a
@@ -577,18 +580,24 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
 	struct mma8452_data *data = iio_priv(indio_dev);
+	int ret = IRQ_NONE;
 	int src;
 
 	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
 	if (src < 0)
 		return IRQ_NONE;
 
+	if (src & MMA8452_INT_DRDY) {
+		iio_trigger_poll_chained(indio_dev->trig);
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
@@ -714,6 +723,60 @@ static const struct iio_info mma8452_info = {
 
 static const unsigned long mma8452_scan_masks[] = {0x7, 0};
 
+static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					      bool state)
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
+	trig = devm_iio_trigger_alloc(&data->client->dev, "%s-dev%d",
+				      indio_dev->name,
+				      indio_dev->id);
+	if (!trig)
+		return -ENOMEM;
+
+	trig->dev.parent = &data->client->dev;
+	trig->ops = &mma8452_trigger_ops;
+	iio_trigger_set_drvdata(trig, indio_dev);
+
+	ret = iio_trigger_register(trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = trig;
+	return 0;
+}
+
+static void mma8452_trigger_cleanup(struct iio_dev *indio_dev)
+{
+	if (indio_dev->trig)
+		iio_trigger_unregister(indio_dev->trig);
+}
+
 static int mma8452_reset(struct i2c_client *client)
 {
 	int i;
@@ -794,7 +857,8 @@ static int mma8452_probe(struct i2c_client *client,
 		 * enabled until userspace asks for it by
 		 * mma8452_write_event_config()
 		 */
-		int supported_interrupts = MMA8452_INT_TRANS;
+		int supported_interrupts = MMA8452_INT_DRDY | MMA8452_INT_TRANS;
+		int enabled_interrupts = MMA8452_INT_TRANS;
 
 		/* Assume wired to INT1 pin */
 		ret = i2c_smbus_write_byte_data(client,
@@ -805,7 +869,11 @@ static int mma8452_probe(struct i2c_client *client,
 
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
@@ -815,12 +883,12 @@ static int mma8452_probe(struct i2c_client *client,
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
 
 	if (client->irq) {
 		ret = devm_request_threaded_irq(&client->dev,
@@ -840,6 +908,10 @@ static int mma8452_probe(struct i2c_client *client,
 
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
+
+trigger_cleanup:
+	mma8452_trigger_cleanup(indio_dev);
+
 	return ret;
 }
 
@@ -849,6 +921,7 @@ static int mma8452_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
+	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
 
 	return 0;
