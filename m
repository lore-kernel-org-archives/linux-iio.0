Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Irina Tirdea
	<irina.tirdea@intel.com>, Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v2 5/5] iio:magnetometer:ak8975: triggered buffer support
Date: Thu, 3 Mar 2016 11:44:07 +0100
Message-ID: <49f851580f1e33c8753921f66935cf92bf40c62f.1457001111.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1457001111.git.gregor.boirie@parrot.com>
References: <cover.1457001111.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This will be used together with an external trigger (e.g hrtimer based
software trigger).

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/magnetometer/Kconfig  |   2 +
 drivers/iio/magnetometer/ak8975.c | 150 +++++++++++++++++++++++++++++++-------
 2 files changed, 125 insertions(+), 27 deletions(-)

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
index 95c68952..9559ab8 100644
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
@@ -617,22 +623,15 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
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
-	if (ret < 0) {
+	int ret = ak8975_set_mode(data, MODE_ONCE);
+
+	if (ret) {
 		dev_err(&client->dev, "Error in setting operating mode\n");
-		goto exit;
+		return ret;
 	}
 
 	/* Wait for the conversion to complete. */
@@ -643,7 +642,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	else
 		ret = wait_conversion_complete_polled(data);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	/* This will be executed only for non-interrupt based waiting case */
 	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
@@ -651,32 +650,46 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
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
+/*
+ * Retrieve raw flux value for one of the x, y, or z axis.
+ */
+static int ak8975_read_axis(struct ak8975_data *data, int index, int *val)
+{
+	int ret;
+	const struct i2c_client *client = data->client;
+	const struct ak_def *def = data->def;
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
 
@@ -689,7 +702,7 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return ak8975_read_axis(indio_dev, chan->address, val);
+		return ak8975_read_axis(data, chan->address, val);
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = data->raw_to_gauss[chan->address];
@@ -728,12 +741,25 @@ static const struct attribute_group ak8975_attrs_group = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
 			     BIT(IIO_CHAN_INFO_SCALE),			\
 		.address = index,					\
+		.scan_index = index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.shift = 0,					\
+			.endianness = IIO_CPU				\
+		}							\
 	}
 
 static const struct iio_chan_spec ak8975_channels[] = {
-	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
+	AK8975_CHANNEL(X, 0),
+	AK8975_CHANNEL(Y, 1),
+	AK8975_CHANNEL(Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
+
 static const struct iio_info ak8975_info = {
 	.read_raw = &ak8975_read_raw,
 	.driver_module = THIS_MODULE,
@@ -768,6 +794,51 @@ static const char *ak8975_match_acpi_device(struct device *dev,
 	return dev_name(dev);
 }
 
+static irqreturn_t ak8975_handle_trigger(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
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
+	goto exit;
+
+unlock:
+	mutex_unlock(&data->lock);
+	dev_err(&client->dev, "Error in reading axes block\n");
+exit:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int ak8975_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -867,9 +938,33 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = ak8975_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
+	indio_dev->available_scan_masks = ak8975_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
-	return devm_iio_device_register(&client->dev, indio_dev);
+
+	err = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
+					 NULL);
+	if (err) {
+		dev_err(&client->dev, "triggered buffer setup failed\n");
+		return err;
+	}
+
+	err = iio_device_register(indio_dev);
+	if (!err)
+		return 0;
+
+	iio_triggered_buffer_cleanup(indio_dev);
+	dev_err(&client->dev, "device register failed\n");
+	return err;
+}
+
+static int ak8975_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	return 0;
 }
 
 static const struct i2c_device_id ak8975_id[] = {
@@ -903,6 +998,7 @@ static struct i2c_driver ak8975_driver = {
 		.acpi_match_table = ACPI_PTR(ak_acpi_match),
 	},
 	.probe		= ak8975_probe,
+	.remove		= ak8975_remove,
 	.id_table	= ak8975_id,
 };
 module_i2c_driver(ak8975_driver);
-- 
2.1.4
