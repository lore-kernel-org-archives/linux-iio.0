Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	ldewangan@nvidia.com,
	shubhrajyoti@ti.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/24] staging:iio:magnetometer:ak8975 convert to iio_chan_spec + cleanups.
Date: Wed, 29 Jun 2011 12:51:41 +0100
Message-Id: <1309348316-7699-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
References: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

iio_chan_spec conversion is straight forward.

Other changes:
* use i2c_smbus_write_byte_data in write_data
* c99 isms to setup various structures.
* move the comment about the scale factor and kill off trivial access func.
* make mode setting code use a bool rather than a ulong.

Ultimately I'd like to get rid of that mode bit entirely and handle it through
core pm routines, but have left it for now.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/magnetometer/ak8975.c |  213 ++++++++++++++---------------
 1 files changed, 102 insertions(+), 111 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 33919e8..d37730d 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -31,7 +31,6 @@
 #include <linux/gpio.h>
 
 #include "../iio.h"
-#include "magnet.h"
 
 /*
  * Register definitions, as well as various shifts and masks to get at the
@@ -93,38 +92,28 @@ struct ak8975_data {
 	struct mutex		lock;
 	u8			asa[3];
 	long			raw_to_gauss[3];
-	unsigned long		mode;
+	bool			mode;
 	u8			reg_cache[AK8975_MAX_REGS];
 	int			eoc_gpio;
 	int			eoc_irq;
 };
 
+static const int ak8975_index_to_reg[] = {
+	AK8975_REG_HXL, AK8975_REG_HYL, AK8975_REG_HZL,
+};
+
 /*
  * Helper function to write to the I2C device's registers.
  */
 static int ak8975_write_data(struct i2c_client *client,
 			     u8 reg, u8 val, u8 mask, u8 shift)
 {
-	u8 regval;
-	struct i2c_msg msg;
-	u8 w_data[2];
-	int ret = 0;
-
 	struct ak8975_data *data = i2c_get_clientdata(client);
+	u8 regval;
+	int ret;
 
-	regval = data->reg_cache[reg];
-	regval &= ~mask;
-	regval |= val << shift;
-
-	w_data[0] = reg;
-	w_data[1] = regval;
-
-	msg.addr = client->addr;
-	msg.flags = 0;
-	msg.len = 2;
-	msg.buf = w_data;
-
-	ret = i2c_transfer(client->adapter, &msg, 1);
+	regval = (data->reg_cache[reg] & ~mask) | (val << shift);
+	ret = i2c_smbus_write_byte_data(client, reg, regval);
 	if (ret < 0) {
 		dev_err(&client->dev, "Write to device fails status %x\n", ret);
 		return ret;
@@ -140,21 +129,20 @@ static int ak8975_write_data(struct i2c_client *client,
 static int ak8975_read_data(struct i2c_client *client,
 			    u8 reg, u8 length, u8 *buffer)
 {
-	struct i2c_msg msg[2];
-	u8 w_data[2];
 	int ret;
-
-	w_data[0] = reg;
-
-	msg[0].addr = client->addr;
-	msg[0].flags = I2C_M_NOSTART;	/* set repeated start and write */
-	msg[0].len = 1;
-	msg[0].buf = w_data;
-
-	msg[1].addr = client->addr;
-	msg[1].flags = I2C_M_RD;
-	msg[1].len = length;
-	msg[1].buf = buffer;
+	struct i2c_msg msg[2] = {
+		{
+			.addr = client->addr,
+			.flags = I2C_M_NOSTART,
+			.len = 1,
+			.buf = &reg,
+		}, {
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = length,
+			.buf = buffer,
+		}
+	};
 
 	ret = i2c_transfer(client->adapter, msg, 2);
 	if (ret < 0) {
@@ -204,8 +192,41 @@ static int ak8975_setup(struct i2c_client *client)
 		return ret;
 	}
 
-	/* Precalculate scale factor for each axis and
-	   store in the device data. */
+/*
+ * Precalculate scale factor (in Gauss units) for each axis and
+ * store in the device data.
+ *
+ * This scale factor is axis-dependent, and is derived from 3 calibration
+ * factors ASA(x), ASA(y), and ASA(z).
+ *
+ * These ASA values are read from the sensor device at start of day, and
+ * cached in the device context struct.
+ *
+ * Adjusting the flux value with the sensitivity adjustment value should be
+ * done via the following formula:
+ *
+ * Hadj = H * ( ( ( (ASA-128)*0.5 ) / 128 ) + 1 )
+ *
+ * where H is the raw value, ASA is the sensitivity adjustment, and Hadj
+ * is the resultant adjusted value.
+ *
+ * We reduce the formula to:
+ *
+ * Hadj = H * (ASA + 128) / 256
+ *
+ * H is in the range of -4096 to 4095.  The magnetometer has a range of
+ * +-1229uT.  To go from the raw value to uT is:
+ *
+ * HuT = H * 1229/4096, or roughly, 3/10.
+ *
+ * Since 1uT = 100 gauss, our final scale factor becomes:
+ *
+ * Hadj = H * ((ASA + 128) / 256) * 3/10 * 100
+ * Hadj = H * ((ASA + 128) * 30 / 256
+ *
+ * Since ASA doesn't change, we cache the resultant scale factor into the
+ * device context in ak8975_setup().
+ */
 	data->raw_to_gauss[0] = ((data->asa[0] + 128) * 30) >> 8;
 	data->raw_to_gauss[1] = ((data->asa[1] + 128) * 30) >> 8;
 	data->raw_to_gauss[2] = ((data->asa[2] + 128) * 30) >> 8;
@@ -222,7 +243,7 @@ static ssize_t show_mode(struct device *dev, struct device_attribute *devattr,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ak8975_data *data = iio_priv(indio_dev);
 
-	return sprintf(buf, "%lu\n", data->mode);
+	return sprintf(buf, "%u\n", data->mode);
 }
 
 /*
@@ -235,26 +256,22 @@ static ssize_t store_mode(struct device *dev, struct device_attribute *devattr,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ak8975_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
-	unsigned long oval;
+	bool value;
 	int ret;
 
 	/* Convert mode string and do some basic sanity checking on it.
 	   only 0 or 1 are valid. */
-	if (strict_strtoul(buf, 10, &oval))
-		return -EINVAL;
-
-	if (oval > 1) {
-		dev_err(dev, "mode value is not supported\n");
-		return -EINVAL;
-	}
+	ret = strtobool(buf, &value);
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&data->lock);
 
 	/* Write the mode to the device. */
-	if (data->mode != oval) {
+	if (data->mode != value) {
 		ret = ak8975_write_data(client,
 					AK8975_REG_CNTL,
-					(u8)oval,
+					(u8)value,
 					AK8975_REG_CNTL_MODE_MASK,
 					AK8975_REG_CNTL_MODE_SHIFT);
 
@@ -263,7 +280,7 @@ static ssize_t store_mode(struct device *dev, struct device_attribute *devattr,
 			mutex_unlock(&data->lock);
 			return ret;
 		}
-		data->mode = oval;
+		data->mode = value;
 	}
 
 	mutex_unlock(&data->lock);
@@ -271,50 +288,6 @@ static ssize_t store_mode(struct device *dev, struct device_attribute *devattr,
 	return count;
 }
 
-/*
- * Emits the scale factor to bring the raw value into Gauss units.
- *
- * This scale factor is axis-dependent, and is derived from 3 calibration
- * factors ASA(x), ASA(y), and ASA(z).
- *
- * These ASA values are read from the sensor device at start of day, and
- * cached in the device context struct.
- *
- * Adjusting the flux value with the sensitivity adjustment value should be
- * done via the following formula:
- *
- * Hadj = H * ( ( ( (ASA-128)*0.5 ) / 128 ) + 1 )
- *
- * where H is the raw value, ASA is the sensitivity adjustment, and Hadj
- * is the resultant adjusted value.
- *
- * We reduce the formula to:
- *
- * Hadj = H * (ASA + 128) / 256
- *
- * H is in the range of -4096 to 4095.  The magnetometer has a range of
- * +-1229uT.  To go from the raw value to uT is:
- *
- * HuT = H * 1229/4096, or roughly, 3/10.
- *
- * Since 1uT = 100 gauss, our final scale factor becomes:
- *
- * Hadj = H * ((ASA + 128) / 256) * 3/10 * 100
- * Hadj = H * ((ASA + 128) * 30 / 256
- *
- * Since ASA doesn't change, we cache the resultant scale factor into the
- * device context in ak8975_setup().
- */
-static ssize_t show_scale(struct device *dev, struct device_attribute *devattr,
-			  char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ak8975_data *data = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(devattr);
-
-	return sprintf(buf, "%ld\n", data->raw_to_gauss[this_attr->address]);
-}
-
 static int wait_conversion_complete_gpio(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
@@ -371,13 +344,10 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
 /*
  * Emits the raw flux value for the x, y, or z axis.
  */
-static ssize_t show_raw(struct device *dev, struct device_attribute *devattr,
-			char *buf)
+static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ak8975_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(devattr);
 	u16 meas_reg;
 	s16 raw;
 	u8 read_status;
@@ -429,7 +399,8 @@ static ssize_t show_raw(struct device *dev, struct device_attribute *devattr,
 
 	/* Read the flux value from the appropriate register
 	   (the register is specified in the iio device attributes). */
-	ret = ak8975_read_data(client, this_attr->address, 2, (u8 *)&meas_reg);
+	ret = ak8975_read_data(client, ak8975_index_to_reg[index],
+			       2, (u8 *)&meas_reg);
 	if (ret < 0) {
 		dev_err(&client->dev, "Read axis data fails\n");
 		goto exit;
@@ -442,30 +413,48 @@ static ssize_t show_raw(struct device *dev, struct device_attribute *devattr,
 
 	/* Clamp to valid range. */
 	raw = clamp_t(s16, raw, -4096, 4095);
-
-	return sprintf(buf, "%d\n", raw);
+	*val = raw;
+	return IIO_VAL_INT;
 
 exit:
 	mutex_unlock(&data->lock);
 	return ret;
 }
 
+static int ak8975_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2,
+			   long mask)
+{
+	struct ak8975_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case 0:
+		return ak8975_read_axis(indio_dev, chan->address, val);
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		*val = data->raw_to_gauss[chan->address];
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+#define AK8975_CHANNEL(axis, index)					\
+	{								\
+		.type = IIO_MAGN,					\
+		.modified = 1,						\
+		.channel2 = IIO_MOD_##axis,				\
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SEPARATE),	\
+		.address = index,					\
+	}
+
+static const struct iio_chan_spec ak8975_channels[] = {
+	AK8975_CHANNEL(X, 0), AK8975_CHANNEL(Y, 1), AK8975_CHANNEL(Z, 2),
+};
+
 static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode, store_mode, 0);
-static IIO_DEV_ATTR_MAGN_X_SCALE(S_IRUGO, show_scale, NULL, 0);
-static IIO_DEV_ATTR_MAGN_Y_SCALE(S_IRUGO, show_scale, NULL, 1);
-static IIO_DEV_ATTR_MAGN_Z_SCALE(S_IRUGO, show_scale, NULL, 2);
-static IIO_DEV_ATTR_MAGN_X(show_raw, AK8975_REG_HXL);
-static IIO_DEV_ATTR_MAGN_Y(show_raw, AK8975_REG_HYL);
-static IIO_DEV_ATTR_MAGN_Z(show_raw, AK8975_REG_HZL);
 
 static struct attribute *ak8975_attr[] = {
 	&iio_dev_attr_mode.dev_attr.attr,
-	&iio_dev_attr_magn_x_scale.dev_attr.attr,
-	&iio_dev_attr_magn_y_scale.dev_attr.attr,
-	&iio_dev_attr_magn_z_scale.dev_attr.attr,
-	&iio_dev_attr_magn_x_raw.dev_attr.attr,
-	&iio_dev_attr_magn_y_raw.dev_attr.attr,
-	&iio_dev_attr_magn_z_raw.dev_attr.attr,
 	NULL
 };
 
@@ -475,6 +464,7 @@ static struct attribute_group ak8975_attr_group = {
 
 static const struct iio_info ak8975_info = {
 	.attrs = &ak8975_attr_group,
+	.read_raw = &ak8975_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
@@ -530,6 +520,7 @@ static int ak8975_probe(struct i2c_client *client,
 	data->eoc_irq = client->irq;
 	data->eoc_gpio = eoc_gpio;
 	indio_dev->dev.parent = &client->dev;
+	indio_dev->channels = ak8975_channels;
 	indio_dev->info = &ak8975_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-- 
1.7.3.4
