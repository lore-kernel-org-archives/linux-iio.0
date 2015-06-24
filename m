Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 2/2] iio: accel: Add sampling rate support for STK8312
Date: Wed, 24 Jun 2015 17:01:49 +0300
Message-Id: <1435154509-16865-2-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1435154509-16865-1-git-send-email-tiberiu.a.breana@intel.com>
References: <1435154509-16865-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added support for setting the STK8312 accelerometer's
sampling rate.

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
v5: no new changes
v4: no new changes
v3: no new changes
v2: replaced stk8312_samp_freq_table with a struct for better readability
---
 drivers/iio/accel/stk8312.c | 96 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index be58d66..c2bd144 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -29,6 +29,7 @@
 #define STK8312_REG_ZOUT		0x02
 #define STK8312_REG_INTSU		0x06
 #define STK8312_REG_MODE		0x07
+#define STK8312_REG_SR			0x08
 #define STK8312_REG_STH			0x13
 #define STK8312_REG_RESET		0x20
 #define STK8312_REG_AFECTRL		0x24
@@ -41,6 +42,8 @@
 #define STK8312_DREADY_BIT		0x10
 #define STK8312_INT_MODE		0xC0
 #define STK8312_RNG_MASK		0xC0
+#define STK8312_SR_MASK			0x07
+#define STK8312_SR_400HZ_IDX		0
 #define STK8312_RNG_SHIFT		6
 #define STK8312_READ_RETRIES		16
 #define STK8312_ALL_CHANNEL_MASK	7
@@ -65,20 +68,29 @@ static const int stk8312_scale_table[][2] = {
 	{0, 461600}, {1, 231100}
 };
 
-#define STK8312_ACCEL_CHANNEL(index, reg, axis) {		\
-	.type = IIO_ACCEL,					\
-	.address = reg,						\
-	.modified = 1,						\
-	.channel2 = IIO_MOD_##axis,				\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
-	.scan_index = index,					\
-	.scan_type = {						\
-		.sign = 's',					\
-		.realbits = 8,					\
-		.storagebits = 8,				\
-		.endianness = IIO_CPU,				\
-	},							\
+static const struct {
+	u16 val;
+	u32 val2;
+} stk8312_samp_freq_table[] = {
+	{400, 0}, {200, 0}, {100, 0}, {50, 0}, {25, 0},
+	{12, 500000}, {6, 250000}, {3, 125000}
+};
+
+#define STK8312_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 8,						\
+		.storagebits = 8,					\
+		.endianness = IIO_CPU,					\
+	},								\
 }
 
 static const struct iio_chan_spec stk8312_channels[] = {
@@ -92,6 +104,7 @@ struct stk8312_data {
 	struct i2c_client *client;
 	struct mutex lock;
 	int range;
+	u8 sample_rate_idx;
 	u8 mode;
 	struct iio_trigger *dready_trig;
 	bool dready_trigger_on;
@@ -100,8 +113,11 @@ struct stk8312_data {
 
 static IIO_CONST_ATTR(in_accel_scale_available, STK8312_SCALE_AVAIL);
 
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("3.125 6.25 12.5 25 50 100 200 400");
+
 static struct attribute *stk8312_attributes[] = {
 	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
 };
 
@@ -220,6 +236,39 @@ static const struct iio_trigger_ops stk8312_trigger_ops = {
 	.owner = THIS_MODULE,
 };
 
+static int stk8312_set_sample_rate(struct stk8312_data *data, int rate)
+{
+	int ret;
+	u8 masked_reg;
+	u8 mode;
+	struct i2c_client *client = data->client;
+
+	if (rate == data->sample_rate_idx)
+		return 0;
+
+	mode = data->mode;
+	/* We need to go in standby mode to modify registers */
+	ret = stk8312_set_mode(data, STK8312_MODE_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_byte_data(client, STK8312_REG_SR);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to set sampling rate\n");
+		return ret;
+	}
+
+	masked_reg = (ret & (~STK8312_SR_MASK)) | rate;
+
+	ret = i2c_smbus_write_byte_data(client, STK8312_REG_SR, masked_reg);
+	if (ret < 0)
+		dev_err(&client->dev, "failed to set sampling rate\n");
+	else
+		data->sample_rate_idx = rate;
+
+	return stk8312_set_mode(data, mode);
+}
+
 static int stk8312_set_range(struct stk8312_data *data, u8 range)
 {
 	int ret;
@@ -303,6 +352,10 @@ static int stk8312_read_raw(struct iio_dev *indio_dev,
 		*val = stk8312_scale_table[data->range - 1][0];
 		*val2 = stk8312_scale_table[data->range - 1][1];
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = stk8312_samp_freq_table[data->sample_rate_idx].val;
+		*val2 = stk8312_samp_freq_table[data->sample_rate_idx].val2;
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
 	return -EINVAL;
@@ -333,6 +386,20 @@ static int stk8312_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->lock);
 
 		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		for (i = 0; i < ARRAY_SIZE(stk8312_samp_freq_table); i++)
+			if (val == stk8312_samp_freq_table[i].val &&
+			    val2 == stk8312_samp_freq_table[i].val2) {
+				index = i;
+				break;
+			}
+		if (index < 0)
+			return -EINVAL;
+		mutex_lock(&data->lock);
+		ret = stk8312_set_sample_rate(data, index);
+		mutex_unlock(&data->lock);
+
+		return ret;
 	}
 
 	return -EINVAL;
@@ -479,6 +546,7 @@ static int stk8312_probe(struct i2c_client *client,
 		dev_err(&client->dev, "failed to reset sensor\n");
 		return ret;
 	}
+	data->sample_rate_idx = STK8312_SR_400HZ_IDX;
 	ret = stk8312_set_range(data, 1);
 	if (ret < 0)
 		return ret;
-- 
1.9.1
