Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36838 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdHQLjh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2017 07:39:37 -0400
Received: by mail-wr0-f194.google.com with SMTP id y67so7950217wrb.3
        for <linux-iio@vger.kernel.org>; Thu, 17 Aug 2017 04:39:37 -0700 (PDT)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, daniel.baluta@gmail.com, amsfield22@gmail.com
Cc: linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH] iio: chemical: ccs811: Add support for data ready trigger
Date: Thu, 17 Aug 2017 14:39:26 +0300
Message-Id: <1502969966-23791-1-git-send-email-narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add data ready trigger for hardware interrupts that notify us when
new measurement samples are available.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
Note: This patch depends on:
[PATCH v2] iio: chemical: ccs811: Add triggered buffer support

 drivers/iio/chemical/ccs811.c | 93 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index b59994d..0fd617a 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/module.h>
@@ -60,8 +61,13 @@
 #define CCS811_MODE_IAQ_60SEC	0x30
 #define CCS811_MODE_RAW_DATA	0x40

+#define CCS811_MEAS_MODE_THRESH		BIT(2)
+#define CCS811_MEAS_MODE_INTERRUPT	BIT(3)
+
 #define CCS811_VOLTAGE_MASK	0x3FF

+#define CCS811_IRQ_NAME "ccs811_irq"
+
 struct ccs811_reading {
 	__be16 co2;
 	__be16 voc;
@@ -74,6 +80,7 @@ struct ccs811_data {
 	struct i2c_client *client;
 	struct mutex lock; /* Protect readings */
 	struct ccs811_reading buffer;
+	struct iio_trigger *drdy_trig;
 };

 static const struct iio_chan_spec ccs811_channels[] = {
@@ -274,6 +281,54 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
 	.driver_module = THIS_MODULE,
 };

+static int ccs811_set_trigger_state(struct iio_trigger *trig,
+				    bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct ccs811_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, CCS811_MEAS_MODE);
+	if (ret < 0)
+		return ret;
+
+	if (state)
+		ret |= CCS811_MEAS_MODE_INTERRUPT;
+	else
+		ret &= ~CCS811_MEAS_MODE_INTERRUPT;
+
+	if (data->drdy_trig == trig)
+		ret &= ~CCS811_MEAS_MODE_THRESH;
+
+	return i2c_smbus_write_byte_data(data->client, CCS811_MEAS_MODE, ret);
+}
+
+static const struct iio_trigger_ops ccs811_trigger_ops = {
+	.set_trigger_state = ccs811_set_trigger_state,
+	.owner = THIS_MODULE,
+};
+
+static irqreturn_t ccs811_interrupt_handler(int irq, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct ccs811_data *data = iio_priv(indio_dev);
+	u16 buf[8]; /* u16 eCO2 + u16 TVOC + padding + 8 byte timestamp */
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(data->client,
+					    CCS811_ALG_RESULT_DATA, 4,
+					    (u8 *)&buf);
+	if (ret != 4) {
+		dev_err(&data->client->dev, "cannot read sensor data\n");
+		goto err;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+					   iio_get_time_ns(indio_dev));
+err:
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t ccs811_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -347,16 +402,48 @@ static int ccs811_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
 	indio_dev->info = &ccs811_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;

 	indio_dev->channels = ccs811_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ccs811_channels);

+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL,
+						ccs811_interrupt_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						CCS811_IRQ_NAME, indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "irq request error %d\n", -ret);
+			goto err_poweroff;
+		}
+
+		data->drdy_trig = devm_iio_trigger_alloc(&client->dev,
+							 "%s-dev%d",
+							 indio_dev->name,
+							 indio_dev->id);
+		if (!data->drdy_trig) {
+			ret = -ENOMEM;
+			goto err_poweroff;
+		}
+
+		data->drdy_trig->dev.parent = &client->dev;
+		data->drdy_trig->ops = &ccs811_trigger_ops;
+		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
+		indio_dev->trig = data->drdy_trig;
+		iio_trigger_get(indio_dev->trig);
+		ret = iio_trigger_register(data->drdy_trig);
+		if (ret)
+			goto err_poweroff;
+	}
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 					 ccs811_trigger_handler, NULL);

 	if (ret < 0) {
 		dev_err(&client->dev, "triggered buffer setup failed\n");
-		goto err_poweroff;
+		goto err_trigger_unregister;
 	}

 	ret = iio_device_register(indio_dev);
@@ -368,6 +455,8 @@ static int ccs811_probe(struct i2c_client *client,

 err_buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
+err_trigger_unregister:
+	iio_trigger_unregister(data->drdy_trig);
 err_poweroff:
 	i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE, CCS811_MODE_IDLE);

@@ -377,9 +466,11 @@ static int ccs811_probe(struct i2c_client *client,
 static int ccs811_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ccs811_data *data = iio_priv(indio_dev);

 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
+	iio_trigger_unregister(data->drdy_trig);

 	return i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE,
 					 CCS811_MODE_IDLE);
--
1.9.1

