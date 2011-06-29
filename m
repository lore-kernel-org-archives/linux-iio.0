Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	ldewangan@nvidia.com,
	shubhrajyoti@ti.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/24] staging:iio:magnetometer:hmc5843 iio_chan_spec conversion.
Date: Wed, 29 Jun 2011 12:51:42 +0100
Message-Id: <1309348316-7699-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
References: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   95 +++++++++++++++-------------
 1 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index b44c273a..b1ab569 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -24,7 +24,6 @@
 #include <linux/types.h>
 #include "../iio.h"
 #include "../sysfs.h"
-#include "magnet.h"
 
 #define HMC5843_I2C_ADDRESS			0x1E
 
@@ -62,9 +61,9 @@
 /*
  * Device status
  */
-#define	DATA_READY  				0x01
-#define	DATA_OUTPUT_LOCK  			0x02
-#define	VOLTAGE_REGULATOR_ENABLED  		0x04
+#define	DATA_READY				0x01
+#define	DATA_OUTPUT_LOCK			0x02
+#define	VOLTAGE_REGULATOR_ENABLED		0x04
 
 /*
  * Mode register configuration
@@ -89,22 +88,16 @@
 /*
  * Device Configutration
  */
-#define	CONF_NORMAL  				0x00
+#define	CONF_NORMAL				0x00
 #define	CONF_POSITIVE_BIAS			0x01
 #define	CONF_NEGATIVE_BIAS			0x02
 #define	CONF_NOT_USED				0x03
 #define	MEAS_CONF_MASK				0x03
 
-static const char *regval_to_scale[] = {
-	"0.0000006173",
-	"0.0000007692",
-	"0.0000010309",
-	"0.0000012821",
-	"0.0000018868",
-	"0.0000021739",
-	"0.0000025641",
-	"0.0000035714",
+static int hmc5843_regval_to_nanoscale[] = {
+	6173, 7692, 10309, 12821, 18868, 21739, 25641, 35714
 };
+
 static const int regval_to_input_field_mg[] = {
 	700,
 	1000,
@@ -115,7 +108,7 @@ static const int regval_to_input_field_mg[] = {
 	4500,
 	6500
 };
-static const char *regval_to_samp_freq[] = {
+static const char * const regval_to_samp_freq[] = {
 	"0.5",
 	"1",
 	"2",
@@ -150,37 +143,28 @@ static s32 hmc5843_configure(struct i2c_client *client,
 }
 
 /* Return the measurement value from the  specified channel */
-static ssize_t hmc5843_read_measurement(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int hmc5843_read_measurement(struct iio_dev *indio_dev,
+				    int address,
+				    int *val)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
-	s16 coordinate_val;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct hmc5843_data *data = iio_priv(indio_dev);
 	s32 result;
 
 	mutex_lock(&data->lock);
-
 	result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
 	while (!(result & DATA_READY))
 		result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
 
-	result = i2c_smbus_read_word_data(client, this_attr->address);
+	result = i2c_smbus_read_word_data(client, address);
 	mutex_unlock(&data->lock);
 	if (result < 0)
 		return -EINVAL;
 
-	coordinate_val	= (s16)swab16((u16)result);
-	return sprintf(buf, "%d\n", coordinate_val);
+	*val	= (s16)swab16((u16)result);
+	return IIO_VAL_INT;
 }
-static IIO_DEV_ATTR_MAGN_X(hmc5843_read_measurement,
-		HMC5843_DATA_OUT_X_MSB_REG);
-static IIO_DEV_ATTR_MAGN_Y(hmc5843_read_measurement,
-		HMC5843_DATA_OUT_Y_MSB_REG);
-static IIO_DEV_ATTR_MAGN_Z(hmc5843_read_measurement,
-		HMC5843_DATA_OUT_Z_MSB_REG);
+
 
 /*
  * From the datasheet
@@ -336,7 +320,7 @@ static s32 hmc5843_set_rate(struct i2c_client *client,
 	reg_val = (data->meas_conf) |  (rate << RATE_OFFSET);
 	if (rate >= RATE_NOT_USED) {
 		dev_err(&client->dev,
-			"This data output rate is not supported \n");
+			"This data output rate is not supported\n");
 		return -EINVAL;
 	}
 	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
@@ -467,28 +451,46 @@ static IIO_DEVICE_ATTR(magn_range,
 			set_range,
 			HMC5843_CONFIG_REG_B);
 
-static ssize_t show_scale(struct device *dev,
-			struct device_attribute *attr,
-			char *buf)
+static int hmc5843_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2,
+			    long mask)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hmc5843_data *data = iio_priv(indio_dev);
-	return strlen(strcpy(buf, regval_to_scale[data->range]));
+
+	switch (mask) {
+	case 0:
+		return hmc5843_read_measurement(indio_dev,
+						chan->address,
+						val);
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		*val = 0;
+		*val2 = hmc5843_regval_to_nanoscale[data->range];
+		return IIO_VAL_INT_PLUS_NANO;
+	};
+	return -EINVAL;
 }
-static IIO_DEVICE_ATTR(magn_scale,
-			S_IRUGO,
-			show_scale,
-			NULL , 0);
+
+#define HMC5843_CHANNEL(axis, add)					\
+	{								\
+		.type = IIO_MAGN,					\
+		.modified = 1,						\
+		.channel2 = IIO_MOD_##axis,				\
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),		\
+		.address = add						\
+	}
+
+static const struct iio_chan_spec hmc5843_channels[] = {
+	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_X_MSB_REG),
+	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_Y_MSB_REG),
+	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_Z_MSB_REG),
+};
 
 static struct attribute *hmc5843_attributes[] = {
 	&iio_dev_attr_meas_conf.dev_attr.attr,
 	&iio_dev_attr_operating_mode.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_dev_attr_magn_range.dev_attr.attr,
-	&iio_dev_attr_magn_scale.dev_attr.attr,
-	&iio_dev_attr_magn_x_raw.dev_attr.attr,
-	&iio_dev_attr_magn_y_raw.dev_attr.attr,
-	&iio_dev_attr_magn_z_raw.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
 };
@@ -530,6 +532,7 @@ static void hmc5843_init_client(struct i2c_client *client)
 
 static const struct iio_info hmc5843_info = {
 	.attrs = &hmc5843_group,
+	.read_raw = &hmc5843_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
@@ -558,6 +561,8 @@ static int hmc5843_probe(struct i2c_client *client,
 	hmc5843_init_client(client);
 
 	indio_dev->info = &hmc5843_info;
+	indio_dev->name = id->name;
+	indio_dev->channels = hmc5843_channels;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	err = iio_device_register(indio_dev);
-- 
1.7.3.4
