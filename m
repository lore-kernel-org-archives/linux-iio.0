Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: accel: Add sampling rate support for STK8BA50
Date: Wed, 10 Jun 2015 15:11:19 +0300
Message-Id: <1433938279-4350-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added support for setting the STK8BA50 accelerometer's
sampling rate.

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/accel/stk8ba50.c | 56 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 93de7d0..7a67fb1 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -21,6 +21,7 @@
 #define STK8BA50_REG_YOUT			0x04
 #define STK8BA50_REG_ZOUT			0x06
 #define STK8BA50_REG_RANGE			0x0F
+#define STK8BA50_REG_BWSEL			0x10
 #define STK8BA50_REG_POWMODE			0x11
 #define STK8BA50_REG_SWRST			0x14
 
@@ -30,6 +31,7 @@
 #define STK8BA50_DATA_SHIFT			6
 #define STK8BA50_RESET_CMD			0xB6
 #define STK8BA50_2G_RANGE_IDX			0
+#define STK8BA50_SR_1792HZ_IDX			7
 
 #define STK8BA50_DRIVER_NAME			"stk8ba50"
 
@@ -58,19 +60,30 @@ static const struct {
 	{3, 38400}, {5, 76700}, {8, 153400}, {12, 306900}
 };
 
+/* Sample rates are stored as { <register value>, <Hz value> } */
+static const struct {
+	u8 reg_val;
+	u16 samp_freq;
+} stk8ba50_samp_freq_table[] = {
+	{8,  14},  {9,  25},  {10, 56},  {11, 112},
+	{12, 224}, {13, 448}, {14, 896}, {15, 1792}
+};
+
 struct stk8ba50_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	int range;
+	u8 sample_rate_idx;
 };
 
-#define STK8BA50_ACCEL_CHANNEL(reg, axis) {			\
-	.type = IIO_ACCEL,					\
-	.address = reg,						\
-	.modified = 1,						\
-	.channel2 = IIO_MOD_##axis,				\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+#define STK8BA50_ACCEL_CHANNEL(reg, axis) {				\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 }
 
 static const struct iio_chan_spec stk8ba50_channels[] = {
@@ -81,8 +94,11 @@ static const struct iio_chan_spec stk8ba50_channels[] = {
 
 static IIO_CONST_ATTR(in_accel_scale_available, STK8BA50_SCALE_AVAIL);
 
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("14 25 56 112 224 448 896 1792");
+
 static struct attribute *stk8ba50_attributes[] = {
 	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
 
@@ -120,6 +136,11 @@ static int stk8ba50_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = stk8ba50_scale_table[data->range].scale_val;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = stk8ba50_samp_freq_table
+				[data->sample_rate_idx].samp_freq;
+		*val2 = 0;
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
 	return -EINVAL;
@@ -157,6 +178,25 @@ static int stk8ba50_write_raw(struct iio_dev *indio_dev,
 			data->range = index;
 
 		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < ARRAY_SIZE(stk8ba50_samp_freq_table); i++)
+			if (val == stk8ba50_samp_freq_table[i].samp_freq) {
+				index = i;
+				break;
+			}
+		if (index < 0)
+			return -EINVAL;
+
+		ret = i2c_smbus_write_byte_data(data->client,
+				STK8BA50_REG_BWSEL,
+				stk8ba50_samp_freq_table[index].reg_val);
+		if (ret < 0)
+			dev_err(&data->client->dev,
+					"failed to set sampling rate\n");
+		else
+			data->sample_rate_idx = index;
+
+		return ret;
 	}
 
 	return -EINVAL;
@@ -231,6 +271,8 @@ static int stk8ba50_probe(struct i2c_client *client,
 
 	/* The default range is +/-2g */
 	data->range = STK8BA50_2G_RANGE_IDX;
+	/* The default sampling rate is 1792 Hz (maximum) */
+	data->sample_rate_idx = STK8BA50_SR_1792HZ_IDX;
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-- 
1.9.1
