Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Irina Tirdea
	<irina.tirdea@intel.com>, Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 6/6] iio:magnetometer:ak8975: triggered buffer support
Date: Wed, 2 Mar 2016 12:10:28 +0100
Message-ID: <a41adb99826589314dbbb11f72382a72ef6a2074.1456916271.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1456916271.git.gregor.boirie@parrot.com>
References: <cover.1456916271.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

This will be used together with an external trigger (e.g hrtimer based
software trigger).
Samples of current acquisition round are cached in RAM in order to allow
simultaneous userspace access to buffer content and synchronous
"read_raw" API.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/magnetometer/Kconfig  |   2 +
 drivers/iio/magnetometer/ak8975.c | 206 ++++++++++++++++++++++++++++++++------
 2 files changed, 178 insertions(+), 30 deletions(-)

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
index 89a8ece..530347c 100644
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
@@ -358,9 +364,13 @@ static const struct ak_def ak_def_array[AK_MAX_TYPE] = {
 
 /*
  * Per-instance context data for the device.
+ *
+ * Note : buff holds cached values of channel samples. It is large enough to
+ *        contain 3 x 16 bits axes values and 1 x aligned 64 bits timestamp.
  */
 struct ak8975_data {
 	struct i2c_client	*client;
+	s16			buff[8];
 	const struct ak_def	*def;
 	struct mutex		lock;
 	u8			asa[3];
@@ -617,22 +627,15 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
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
@@ -643,7 +646,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	else
 		ret = wait_conversion_complete_polled(data);
 	if (ret < 0)
-		goto exit;
+		return ret;
 
 	/* This will be executed only for non-interrupt based waiting case */
 	if (ret & data->def->ctrl_masks[ST1_DRDY]) {
@@ -651,29 +654,61 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
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
+	return 0;
+}
+
+static int ak8975_fetch_axis(const struct i2c_client *client,
+			     const struct ak_def *def,
+			     int index,
+			     s16 *axis)
+{
+	int ret = i2c_smbus_read_word_data(client, def->data_regs[index]);
+
 	if (ret < 0) {
-		dev_err(&client->dev, "Read axis data fails\n");
-		goto exit;
+		dev_err(&client->dev, "Axis data fetch failed\n");
+		return ret;
+	}
+
+	/* Clamp to valid range. */
+	*axis = clamp_t(s16, le16_to_cpu((s16)ret), -def->range, def->range);
+	return 0;
+}
+
+/*
+ * Retrieve raw flux value for one of the x, y, or z axis.
+ */
+static int ak8975_read_axis(struct iio_dev *indio_dev, struct ak8975_data *data,
+			    int index, int *val)
+{
+	int ret;
+	s16 *axis = &data->buff[index];
+
+	mutex_lock(&data->lock);
+
+	if (!iio_buffer_enabled(indio_dev)) {
+		const struct i2c_client *client = data->client;
+
+		ret = ak8975_start_read_axis(data, client);
+		if (ret)
+			goto exit;
+
+		ret = ak8975_fetch_axis(client, data->def, index, axis);
+		if (ret < 0)
+			goto exit;
 	}
 
 	mutex_unlock(&data->lock);
 
-	/* Clamp to valid range. */
-	*val = clamp_t(s16, le16_to_cpu((s16)ret), -data->def->range,
-		       data->def->range);
+	*val = *axis;
 	return IIO_VAL_INT;
 
 exit:
@@ -690,10 +725,10 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		return ak8975_read_axis(indio_dev, chan->address, val);
+		return ak8975_read_axis(indio_dev, data, chan->scan_index, val);
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		*val2 = data->raw_to_gauss[chan->address];
+		*val2 = data->raw_to_gauss[chan->scan_index];
 		return IIO_VAL_INT_PLUS_MICRO;
 	}
 	return -EINVAL;
@@ -728,13 +763,25 @@ static const struct attribute_group ak8975_attrs_group = {
 		.channel2 = IIO_MOD_##axis,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
 			     BIT(IIO_CHAN_INFO_SCALE),			\
-		.address = index,					\
+		.scan_index = index,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.shift = 0,					\
+			.endianness = IIO_LE				\
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
@@ -769,6 +816,80 @@ static const char *ak8975_match_acpi_device(struct device *dev,
 	return dev_name(dev);
 }
 
+static int ak8975_fetch_all(const struct i2c_client *client,
+			    struct ak8975_data *data)
+{
+	int ret;
+	s16 x, y, z;
+
+	ret = ak8975_start_read_axis(data, client);
+	if (ret)
+		return ret;
+
+	/*
+	 * For each axis, read the flux value from the appropriate register
+	 * (the register is specified in the iio device attributes).
+	 * Use a temporary storage to preserve 3D coordinate consistency.
+	 */
+	ret = ak8975_fetch_axis(client, data->def, 0, &x);
+	if (ret)
+		return ret;
+	ret = ak8975_fetch_axis(client, data->def, 1, &y);
+	if (ret)
+		return ret;
+	ret = ak8975_fetch_axis(client, data->def, 2, &z);
+	if (ret)
+		return ret;
+
+	data->buff[0] = x;
+	data->buff[1] = y;
+	data->buff[2] = z;
+
+	return 0;
+}
+
+static int ak8975_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ak8975_data *data = iio_priv(indio_dev);
+	int ret;
+
+	/*
+	 * Update channels so that a client getting samples through read_raw
+	 * retrieves valid data when buffering has just been enabled but first
+	 * sampling round is not yet completed.
+	 */
+	mutex_lock(&data->lock);
+	ret = ak8975_fetch_all(data->client, data);
+	mutex_unlock(&data->lock);
+	if (ret)
+		return ret;
+
+	return iio_triggered_buffer_postenable(indio_dev);
+}
+
+static const struct iio_buffer_setup_ops ak8975_buffer_ops = {
+	.postenable = ak8975_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable
+};
+
+static irqreturn_t ak8975_handle_trigger(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ak8975_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = ak8975_fetch_all(data->client, data);
+	mutex_unlock(&data->lock);
+
+	if (!ret)
+		iio_push_to_buffers_with_timestamp(indio_dev, data->buff,
+						   iio_get_time_ns());
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int ak8975_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -868,9 +989,33 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = ak8975_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
+	indio_dev->available_scan_masks = ak8975_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
-	return devm_iio_device_register(&client->dev, indio_dev);
+
+	err = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
+					 &ak8975_buffer_ops);
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
@@ -904,6 +1049,7 @@ static struct i2c_driver ak8975_driver = {
 		.acpi_match_table = ACPI_PTR(ak_acpi_match),
 	},
 	.probe		= ak8975_probe,
+	.remove		= ak8975_remove,
 	.id_table	= ak8975_id,
 };
 module_i2c_driver(ak8975_driver);
-- 
2.1.4
