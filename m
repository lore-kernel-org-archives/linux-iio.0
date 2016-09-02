Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34094 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932495AbcIBRXU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 13:23:20 -0400
Date: Fri, 2 Sep 2016 10:23:17 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] iio: humidity: hdc100x: add triggered buffer support for
 HDC100X
Message-ID: <20160902172311.GA12607@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Triggered buffer support uses the HDC100X's dual acquisition mode
to read both humidity and temperature in one shot.

This patch depends on
	447136effbf4 ("iio: humidity: hdc100x: fix sensor data reads of
		       temp and humidity")

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---

Changes in v4:
 - unlock private lock if claim_direct_mode fails (kbuild robot reported)
 - move unlock to err: out path in trigger handler (kbuild robot inspired)

Changes in v3:
 Thanks for the review Jonathan
 - This patch now depends on 
   447136effbf4 ("iio: humidity: hdc100x: fix sensor data reads of temp
   and humidity")
 - remove i2c functionality check, done in dependent patch
 - remove unused define HDC100X_ALL_CHANNEL_MASK
 - define and use available_scan_masks to demux between temp &/or humid
   data in buffered mode
 - changed timestamp channel scan_index from 3 to 2.
 - put back private data lock in read_raw
   (we'll lock private data lock and claim_direct_mode on raw reads)
 - remove unneeded NULL parameters in iio_buffer_setup_ops
 - add private data lock on buffered read
   We are going to allow configuration changes while the sensor is in
   buffered mode.  We need to allow the toggling of the Heater Enable bit
   because the heater only functions during measurements. The lock will
   ensure that the config change and buffer read transaction do not collide.
 - blank lines added for readability per reviewer 

Changes in v2:  
 Thanks for the review Peter
 - switched endianness from IIO_CPU to IIO_BE
 - use only one buffer in the handler
 - simplify selection of temp &/or humidity to push to buffer


 drivers/iio/humidity/Kconfig   |   2 +
 drivers/iio/humidity/hdc100x.c | 130 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index f155386..5a25569 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -25,6 +25,8 @@ config DHT11
 config HDC100X
 	tristate "TI HDC100x relative humidity and temperature sensor"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for the Texas Instruments
 	  HDC1000 and HDC1008 relative humidity and temperature sensors.
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index e0c9c70..265c34d 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -22,11 +22,15 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define HDC100X_REG_TEMP			0x00
 #define HDC100X_REG_HUMIDITY			0x01
 
 #define HDC100X_REG_CONFIG			0x02
+#define HDC100X_REG_CONFIG_ACQ_MODE		BIT(12)
 #define HDC100X_REG_CONFIG_HEATER_EN		BIT(13)
 
 struct hdc100x_data {
@@ -87,22 +91,40 @@ static const struct iio_chan_spec hdc100x_channels[] = {
 			BIT(IIO_CHAN_INFO_SCALE) |
 			BIT(IIO_CHAN_INFO_INT_TIME) |
 			BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
 		.address = HDC100X_REG_HUMIDITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_INT_TIME)
+			BIT(IIO_CHAN_INFO_INT_TIME),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_BE,
+		},
 	},
 	{
 		.type = IIO_CURRENT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.extend_name = "heater",
 		.output = 1,
+		.scan_index = -1,
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static const unsigned long hdc100x_scan_masks[] = {0x3, 0};
+
 static int hdc100x_update_config(struct hdc100x_data *data, int mask, int val)
 {
 	int tmp = (~mask & data->config) | val;
@@ -183,7 +205,14 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
 			*val = hdc100x_get_heater_status(data);
 			ret = IIO_VAL_INT;
 		} else {
+			ret = iio_device_claim_direct_mode(indio_dev);
+			if (ret) {
+				mutex_unlock(&data->lock);
+				return ret;
+			}
+
 			ret = hdc100x_get_measurement(data, chan);
+			iio_device_release_direct_mode(indio_dev);
 			if (ret >= 0) {
 				*val = ret;
 				ret = IIO_VAL_INT;
@@ -246,6 +275,78 @@ static int hdc100x_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct hdc100x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	/* Buffer is enabled. First set ACQ Mode, then attach poll func */
+	mutex_lock(&data->lock);
+	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
+				    HDC100X_REG_CONFIG_ACQ_MODE);
+	mutex_unlock(&data->lock);
+	if (ret)
+		return ret;
+
+	return iio_triggered_buffer_postenable(indio_dev);
+}
+
+static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct hdc100x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	/* First detach poll func, then reset ACQ mode. OK to disable buffer */
+	ret = iio_triggered_buffer_predisable(indio_dev);
+	if (ret)
+		return ret;
+
+	mutex_lock(&data->lock);
+	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops hdc_buffer_setup_ops = {
+	.postenable  = hdc100x_buffer_postenable,
+	.predisable  = hdc100x_buffer_predisable,
+};
+
+static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct hdc100x_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int delay = data->adc_int_us[0] + data->adc_int_us[1];
+	int ret;
+	s16 buf[8];  /* 2x s16 + padding + 8 byte timestamp */
+
+	/* dual read starts at temp register */
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_write_byte(client, HDC100X_REG_TEMP);
+	if (ret < 0) {
+		dev_err(&client->dev, "cannot start measurement\n");
+		goto err;
+	}
+	usleep_range(delay, delay + 1000);
+
+	ret = i2c_master_recv(client, (u8 *)buf, 4);
+	if (ret < 0) {
+		dev_err(&client->dev, "cannot read sensor data\n");
+		goto err;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+					   iio_get_time_ns(indio_dev));
+err:
+	mutex_unlock(&data->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info hdc100x_info = {
 	.read_raw = hdc100x_read_raw,
 	.write_raw = hdc100x_write_raw,
@@ -258,6 +359,7 @@ static int hdc100x_probe(struct i2c_client *client,
 {
 	struct iio_dev *indio_dev;
 	struct hdc100x_data *data;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
 				     I2C_FUNC_SMBUS_BYTE | I2C_FUNC_I2C))
@@ -279,12 +381,35 @@ static int hdc100x_probe(struct i2c_client *client,
 
 	indio_dev->channels = hdc100x_channels;
 	indio_dev->num_channels = ARRAY_SIZE(hdc100x_channels);
+	indio_dev->available_scan_masks = hdc100x_scan_masks;
 
 	/* be sure we are in a known state */
 	hdc100x_set_it_time(data, 0, hdc100x_int_time[0][0]);
 	hdc100x_set_it_time(data, 1, hdc100x_int_time[1][0]);
+	hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
+
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+					 hdc100x_trigger_handler,
+					 &hdc_buffer_setup_ops);
+	if (ret < 0) {
+		dev_err(&client->dev, "iio triggered buffer setup failed\n");
+		return ret;
+	}
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		iio_triggered_buffer_cleanup(indio_dev);
+
+	return ret;
+}
+
+static int hdc100x_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 
-	return devm_iio_device_register(&client->dev, indio_dev);
+	return 0;
 }
 
 static const struct i2c_device_id hdc100x_id[] = {
@@ -298,6 +423,7 @@ static struct i2c_driver hdc100x_driver = {
 		.name	= "hdc100x",
 	},
 	.probe = hdc100x_probe,
+	.remove = hdc100x_remove,
 	.id_table = hdc100x_id,
 };
 module_i2c_driver(hdc100x_driver);
-- 
2.1.4

