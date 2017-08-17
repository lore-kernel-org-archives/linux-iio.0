Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34389 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdHQLfG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2017 07:35:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id x43so7937133wrb.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Aug 2017 04:35:05 -0700 (PDT)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, daniel.baluta@gmail.com, amsfield22@gmail.com
Cc: linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH v2] iio: chemical: ccs811: Add triggered buffer support
Date: Thu, 17 Aug 2017 14:34:29 +0300
Message-Id: <1502969669-23582-1-git-send-email-narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A software trigger such as hrtimer can be used to capture the data
that will be stored in the buffer.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Alison Schofield <amsfield22@gmail.com>
Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
Changes in v2:
  - Remove initialization of "shift" field with 0 in structure
  - Remove taking the lock inside the trigger handler
  - Replace devm_iio_triggered_buffer_setup with the non-devm*
    function, in order to safely do the cleanup
  - Add cleanup for triggered-buffer, inside remove function
  - Put device in idle mode in case of error, in probe function
  - Add error message, in case data can't be read, inside trigger handler

 drivers/iio/chemical/Kconfig  |  2 ++
 drivers/iio/chemical/ccs811.c | 76 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 4d799b5..5cb5be7 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -24,6 +24,8 @@ config ATLAS_PH_SENSOR
 config CCS811
 	tristate "AMS CCS811 VOC sensor"
 	depends on I2C
+    select IIO_BUFFER
+    select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here to build I2C interface support for the AMS
 	  CCS811 VOC (Volatile Organic Compounds) sensor
diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 8dbb5ed..840a6cb 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -21,6 +21,9 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 #include <linux/module.h>

 #define CCS811_STATUS		0x00
@@ -76,25 +79,42 @@ struct ccs811_data {
 	{
 		.type = IIO_CURRENT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE)
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = -1,
 	}, {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE)
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = -1,
 	}, {
 		.type = IIO_CONCENTRATION,
 		.channel2 = IIO_MOD_CO2,
 		.modified = 1,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_OFFSET) |
-				      BIT(IIO_CHAN_INFO_SCALE)
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
 	}, {
 		.type = IIO_CONCENTRATION,
 		.channel2 = IIO_MOD_VOC,
 		.modified = 1,
 		.info_mask_separate =  BIT(IIO_CHAN_INFO_RAW) |
-				       BIT(IIO_CHAN_INFO_SCALE)
+				       BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };

 /*
@@ -253,6 +273,31 @@ static int ccs811_read_raw(struct iio_dev *indio_dev,
 	.driver_module = THIS_MODULE,
 };

+static irqreturn_t ccs811_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ccs811_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	s16 buf[8]; /* s16 eCO2 + s16 TVOC + padding + 8 byte timestamp */
+	int ret;
+
+	ret = i2c_smbus_read_i2c_block_data(client, CCS811_ALG_RESULT_DATA, 4,
+					    (u8 *)&buf);
+	if (ret != 4) {
+		dev_err(&client->dev, "cannot read sensor data\n");
+		goto err;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+					   iio_get_time_ns(indio_dev));
+
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int ccs811_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -305,7 +350,27 @@ static int ccs811_probe(struct i2c_client *client,
 	indio_dev->channels = ccs811_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ccs811_channels);

-	return iio_device_register(indio_dev);
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+					 ccs811_trigger_handler, NULL);
+
+	if (ret < 0) {
+		dev_err(&client->dev, "triggered buffer setup failed\n");
+		goto err_poweroff;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to register iio device\n");
+		goto err_buffer_cleanup;
+	}
+	return 0;
+
+err_buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
+err_poweroff:
+	i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE, CCS811_MODE_IDLE);
+
+	return ret;
 }

 static int ccs811_remove(struct i2c_client *client)
@@ -313,6 +378,7 @@ static int ccs811_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);

 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);

 	return i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE,
 					 CCS811_MODE_IDLE);
--
1.9.1

