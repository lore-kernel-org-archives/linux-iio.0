Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:16637 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758353AbcDHPHw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 8 Apr 2016 11:07:52 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v4 1/1] iio:magnetometer:ak8975: triggered buffer support
Date: Fri, 8 Apr 2016 17:09:08 +0200
Message-ID: <c4f84b6daad4068e390e2ed3ab39269ecfe23656.1460127559.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1460127559.git.gregor.boirie@parrot.com>
References: <cover.1460127559.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This will be used together with an external trigger (e.g hrtimer based
software trigger).

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/magnetometer/Kconfig  |   2 +
 drivers/iio/magnetometer/ak8975.c | 135 +++++++++++++++++++++++++++++++-------
 2 files changed, 112 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 021dc53..d9834ed 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -9,6 +9,8 @@ config AK8975
 	tristate "Asahi Kasei AK 3-Axis Magnetometer"
 	depends on I2C
 	depends on GPIOLIB || COMPILE_TEST
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Asahi Kasei AK8975, AK8963,
 	  AK09911 or AK09912 3-Axis Magnetometer.
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 48d127a..1e68981 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -36,6 +36,12 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/regulator/consumer.h>
+
 /*
  * Register definitions, as well as various shifts and masks to get at the
  * individual fields of the registers.
@@ -633,22 +639,15 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
 	return ret > 0 ? 0 : -ETIME;
 }
 
-/*
- * Emits the raw flux value for the x, y, or z axis.
- */
-static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
+static int ak8975_start_read_axis(struct ak8975_data *data,
+				  const struct i2c_client *client)
 {
-	struct ak8975_data *data = iio_priv(indio_dev);
-	struct i2c_client *client = data->client;
-	int ret;
-
-	mutex_lock(&data->lock);
-
 	/* Set up the device for taking a sample. */
-	ret = ak8975_set_mode(data, MODE_ONCE);
+	int ret = ak8975_set_mode(data, MODE_ONCE);
+
 	if (ret < 0) {
 		dev_err(&client->dev, "Error in setting operating mode\n");
-		goto exit;
+		return ret;
 	}
 
 	/* Wait for the conversion to complete. */
@@ -659,7 +658,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	else
 		ret = wait_conversion_complete_polled(data);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	/* This will be executed only for non-interrupt based waiting case */
 	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
@@ -667,32 +666,45 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 					       data->def->ctrl_regs[ST2]);
 		if (ret < 0) {
 			dev_err(&client->dev, "Error in reading ST2\n");
-			goto exit;
+			return ret;
 		}
 		if (ret & (data->def->ctrl_masks[ST2_DERR] |
 			   data->def->ctrl_masks[ST2_HOFL])) {
 			dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
-			ret = -EINVAL;
-			goto exit;
+			return -EINVAL;
 		}
 	}
 
-	/* Read the flux value from the appropriate register
-	   (the register is specified in the iio device attributes). */
-	ret = i2c_smbus_read_word_data(client, data->def->data_regs[index]);
-	if (ret < 0) {
-		dev_err(&client->dev, "Read axis data fails\n");
+	return 0;
+}
+
+/* Retrieve raw flux value for one of the x, y, or z axis.  */
+static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
+{
+	struct ak8975_data *data = iio_priv(indio_dev);
+	const struct i2c_client *client = data->client;
+	const struct ak_def *def = data->def;
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	ret = ak8975_start_read_axis(data, client);
+	if (ret)
+		goto exit;
+
+	ret = i2c_smbus_read_word_data(client, def->data_regs[index]);
+	if (ret < 0)
 		goto exit;
-	}
 
 	mutex_unlock(&data->lock);
 
 	/* Clamp to valid range. */
-	*val = clamp_t(s16, ret, -data->def->range, data->def->range);
+	*val = clamp_t(s16, ret, -def->range, def->range);
 	return IIO_VAL_INT;
 
 exit:
 	mutex_unlock(&data->lock);
+	dev_err(&client->dev, "Error in reading axis\n");
 	return ret;
 }
 
@@ -722,12 +734,22 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
 			     BIT(IIO_CHAN_INFO_SCALE),			\
 		.address = index,					\
+		.scan_index = index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_CPU				\
+		}							\
 	}
 
 static const struct iio_chan_spec ak8975_channels[] = {
 	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
+
 static const struct iio_info ak8975_info = {
 	.read_raw = &ak8975_read_raw,
 	.driver_module = THIS_MODULE,
@@ -756,6 +778,56 @@ static const char *ak8975_match_acpi_device(struct device *dev,
 	return dev_name(dev);
 }
 
+static void ak8975_fill_buffer(struct iio_dev *indio_dev)
+{
+	struct ak8975_data *data = iio_priv(indio_dev);
+	const struct i2c_client *client = data->client;
+	const struct ak_def *def = data->def;
+	int ret;
+	s16 buff[8]; /* 3 x 16 bits axis values + 1 aligned 64 bits timestamp */
+
+	mutex_lock(&data->lock);
+
+	ret = ak8975_start_read_axis(data, client);
+	if (ret)
+		goto unlock;
+
+	/*
+	 * For each axis, read the flux value from the appropriate register
+	 * (the register is specified in the iio device attributes).
+	 */
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							def->data_regs[0],
+							3 * sizeof(buff[0]),
+							(u8 *)buff);
+	if (ret < 0)
+		goto unlock;
+
+	mutex_unlock(&data->lock);
+
+	/* Clamp to valid range. */
+	buff[0] = clamp_t(s16, le16_to_cpu(buff[0]), -def->range, def->range);
+	buff[1] = clamp_t(s16, le16_to_cpu(buff[1]), -def->range, def->range);
+	buff[2] = clamp_t(s16, le16_to_cpu(buff[2]), -def->range, def->range);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buff, iio_get_time_ns());
+	return;
+
+unlock:
+	mutex_unlock(&data->lock);
+	dev_err(&client->dev, "Error in reading axes block\n");
+}
+
+static irqreturn_t ak8975_handle_trigger(int irq, void *p)
+{
+	const struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	ak8975_fill_buffer(indio_dev);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int ak8975_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -845,15 +917,27 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->channels = ak8975_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
 	indio_dev->info = &ak8975_info;
+	indio_dev->available_scan_masks = ak8975_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 
-	err = iio_device_register(indio_dev);
-	if (err)
+	err = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
+					 NULL);
+	if (err) {
+		dev_err(&client->dev, "triggered buffer setup failed\n");
 		goto power_off;
+	}
+
+	err = iio_device_register(indio_dev);
+	if (err) {
+		dev_err(&client->dev, "device register failed\n");
+		goto cleanup_buffer;
+	}
 
 	return 0;
 
+cleanup_buffer:
+	iio_triggered_buffer_cleanup(indio_dev);
 power_off:
 	ak8975_power_off(client);
 	return err;
@@ -864,6 +948,7 @@ static int ak8975_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	ak8975_power_off(client);
 
 	return 0;
-- 
2.1.4

