Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 4/5] iio: ltr501: Add interrupt rate control support
Date: Fri, 17 Apr 2015 22:15:13 -0700
Message-Id: <709a0e764028d29c238abe3451c394e0d63c6d5c.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added rate control support for ALS and proximity
threshold interrupts.Also, Added support to modify
and read ALS & proximity sensor sampling frequency.

LTR-501 supports interrupt rate control using persistence
register settings. Writing <n> to persistence register
would generate interrupt only if there are <n> consecutive
data values outside the threshold range.

Since we don't have any existing ABI's to directly
control the persistence register count, we have implemented
the rate control using IIO_EV_INFO_PERIOD. _period event
attribute represents the amount of time in seconds an
event should be true for the device to generate the
interrupt. So using _period value and device frequency,
persistence count is calculated in driver using following
logic.

count =  period / measurement_rate

If the given period is not a multiple of measurement rate then
we round up the value to next multiple.

This patch also handles change to persistence count whenever
there is change in frequency.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 389 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 382 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 8ead137..d635ff4 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -9,7 +9,7 @@
  *
  * 7-bit I2C slave address 0x23
  *
- * TODO: measurement rate, IR LED characteristics
+ * TODO: IR LED characteristics
  */
 
 #include <linux/module.h>
@@ -29,6 +29,7 @@
 
 #define LTR501_ALS_CONTR 0x80 /* ALS operation mode, SW reset */
 #define LTR501_PS_CONTR 0x81 /* PS operation mode */
+#define LTR501_PS_MEAS_RATE 0x84 /* measurement rate*/
 #define LTR501_ALS_MEAS_RATE 0x85 /* ALS integ time, measurement rate*/
 #define LTR501_PART_ID 0x86
 #define LTR501_MANUFAC_ID 0x87
@@ -41,6 +42,7 @@
 #define LTR501_PS_THRESH_LOW 0x92 /* 11 bit, ps lower threshold */
 #define LTR501_ALS_THRESH_UP 0x97 /* 16 bit, ALS upper threshold */
 #define LTR501_ALS_THRESH_LOW 0x99 /* 16 bit, ALS lower threshold */
+#define LTR501_INTR_PRST 0x9e /* ps thresh, als thresh */
 #define LTR501_MAX_REG 0x9f
 
 #define LTR501_ALS_CONTR_SW_RESET BIT(2)
@@ -58,6 +60,9 @@
 #define LTR501_PS_THRESH_MASK 0x7ff
 #define LTR501_ALS_THRESH_MASK 0xffff
 
+#define LTR501_ALS_DEF_PERIOD 500000
+#define LTR501_PS_DEF_PERIOD 100000
+
 #define LTR501_REGMAP_NAME "ltr501_regmap"
 
 static int int_time_mapping[] = {100000, 50000, 200000, 400000};
@@ -65,17 +70,119 @@ static int int_time_mapping[] = {100000, 50000, 200000, 400000};
 static struct reg_field reg_it = REG_FIELD(LTR501_ALS_MEAS_RATE, 3, 4);
 static struct reg_field reg_als_intr = REG_FIELD(LTR501_INTR, 0, 0);
 static struct reg_field reg_ps_intr = REG_FIELD(LTR501_INTR, 1, 1);
+static struct reg_field reg_als_rate = REG_FIELD(LTR501_ALS_MEAS_RATE, 0, 2);
+static struct reg_field reg_ps_rate = REG_FIELD(LTR501_PS_MEAS_RATE, 0, 3);
+static struct reg_field reg_als_prst = REG_FIELD(LTR501_INTR_PRST, 0, 3);
+static struct reg_field reg_ps_prst = REG_FIELD(LTR501_INTR_PRST, 4, 7);
+
+struct ltr501_samp_table {
+	int freq_val;  /* repetition frequency in micro HZ*/
+	int time_val; /* repetition rate in micro seconds */
+};
 
 struct ltr501_data {
 	struct i2c_client *client;
 	struct mutex lock_als, lock_ps;
 	u8 als_contr, ps_contr;
+	int als_period, ps_period; /* period in micro seconds */
 	struct regmap *regmap;
 	struct regmap_field *reg_it;
 	struct regmap_field *reg_als_intr;
 	struct regmap_field *reg_ps_intr;
+	struct regmap_field *reg_als_rate;
+	struct regmap_field *reg_ps_rate;
+	struct regmap_field *reg_als_prst;
+	struct regmap_field *reg_ps_prst;
+};
+
+static struct ltr501_samp_table als_sampling_table[] = {
+			{20000000, 50000}, {10000000, 100000},
+			{5000000, 200000}, {2000000, 500000},
+			{1000000, 1000000}, {500000, 2000000},
+			{500000, 2000000}, {500000, 2000000}
+};
+
+static struct ltr501_samp_table ps_sampling_table[] = {
+			{20000000, 50000}, {14285714, 70000},
+			{10000000, 100000}, {5000000, 200000},
+			{2000000, 500000}, {1000000, 1000000},
+			{500000, 2000000}, {500000, 2000000},
+			{500000, 2000000}
 };
 
+static unsigned int ltr501_match_samp_freq(struct ltr501_samp_table *table,
+					   int len, int val, int val2)
+{
+	int i, freq;
+
+	freq = val * 1000000 + val2;
+
+	for (i = 0; i < len; i++) {
+		if (table[i].freq_val == freq)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int ltr501_read_samp_freq(struct regmap_field *field,
+			   struct ltr501_samp_table *freq,
+			   int len, int *val, int *val2)
+{
+	int ret, i;
+
+	ret = regmap_field_read(field, &i);
+	if (ret < 0)
+		return ret;
+
+	if (i < 0 || i >= len)
+		return -EINVAL;
+
+	*val = freq[i].freq_val / 1000000;
+	*val2 = freq[i].freq_val % 1000000;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int ltr501_write_samp_freq(struct ltr501_data *data,
+				struct regmap_field *field,
+				struct ltr501_samp_table *freq,
+				int len, int val, int val2)
+{
+	int i, ret;
+
+	i = ltr501_match_samp_freq(als_sampling_table,
+				   ARRAY_SIZE(als_sampling_table),
+				   val, val2);
+
+	if (i < 0)
+		return i;
+
+	mutex_lock(&data->lock_als);
+	ret = regmap_field_write(data->reg_als_rate, i);
+	mutex_unlock(&data->lock_als);
+
+	return ret;
+}
+
+static int ltr501_read_samp_rate(struct regmap_field *field,
+			   struct ltr501_samp_table *table,
+			   int len, int *val)
+{
+	int ret, i;
+
+	ret = regmap_field_read(field, &i);
+	if (ret < 0)
+		return ret;
+
+	if (i < 0 || i >= len)
+		return -EINVAL;
+
+	*val = table[i].time_val;
+
+	return IIO_VAL_INT;
+}
+
 static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
 {
 	int tries = 100;
@@ -172,6 +279,116 @@ static int ltr501_read_ps(struct ltr501_data *data)
 	return status;
 }
 
+static int ltr501_read_intr_prst(struct ltr501_data *data,
+				 enum iio_chan_type type,
+				 int *val2)
+{
+	int ret, rate, prst;
+
+	switch (type) {
+	case IIO_INTENSITY:
+		ret = regmap_field_read(data->reg_als_prst, &prst);
+		if (ret < 0)
+			return ret;
+
+		ret = ltr501_read_samp_rate(data->reg_als_rate,
+					    als_sampling_table,
+					    ARRAY_SIZE(als_sampling_table),
+					    &rate);
+
+		if (ret < 0)
+			return ret;
+		*val2 = rate * prst;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_PROXIMITY:
+		ret = regmap_field_read(data->reg_ps_prst, &prst);
+		if (ret < 0)
+			return ret;
+
+		ret = ltr501_read_samp_rate(data->reg_ps_rate,
+					    ps_sampling_table,
+					    ARRAY_SIZE(ps_sampling_table),
+					    &rate);
+
+		if (ret < 0)
+			return ret;
+
+		*val2 = rate * prst;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int ltr501_write_intr_prst(struct ltr501_data *data,
+				 enum iio_chan_type type,
+				  int val, int val2)
+{
+	int ret, rate, new_val;
+	unsigned long period;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	/* period in microseconds */
+	period = ((val * 1000000) + val2);
+
+	switch (type) {
+	case IIO_INTENSITY:
+		ret = ltr501_read_samp_rate(data->reg_als_rate,
+					    als_sampling_table,
+					    ARRAY_SIZE(als_sampling_table),
+					    &rate);
+		if (ret < 0)
+			return ret;
+
+		/* period should be atleast equal to rate */
+		if (period < rate)
+			return -EINVAL;
+
+		new_val = DIV_ROUND_UP(period, rate);
+		if (new_val < 0 || new_val > 0x0f)
+			return -EINVAL;
+
+		mutex_lock(&data->lock_als);
+		ret = regmap_field_write(data->reg_als_prst, new_val);
+		mutex_unlock(&data->lock_als);
+		if (ret >= 0)
+			data->als_period = period;
+
+		return ret;
+	case IIO_PROXIMITY:
+		ret = ltr501_read_samp_rate(data->reg_ps_rate,
+					    ps_sampling_table,
+					    ARRAY_SIZE(ps_sampling_table),
+					    &rate);
+		if (ret < 0)
+			return ret;
+
+		/* period should be atleast equal to rate */
+		if (period < rate)
+			return -EINVAL;
+
+		new_val = DIV_ROUND_UP(period, rate);
+		if (new_val < 0 || new_val > 0x0f)
+			return -EINVAL;
+
+		mutex_lock(&data->lock_ps);
+		ret = regmap_field_write(data->reg_ps_prst, new_val);
+		mutex_unlock(&data->lock_ps);
+		if (ret >= 0)
+			data->ps_period = period;
+
+		return ret;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
 static const struct iio_event_spec ltr501_als_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -184,7 +401,8 @@ static const struct iio_event_spec ltr501_als_event_spec[] = {
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_PERIOD),
 	},
 
 };
@@ -201,7 +419,8 @@ static const struct iio_event_spec ltr501_pxs_event_spec[] = {
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_PERIOD),
 	},
 };
 
@@ -228,7 +447,8 @@ static const struct iio_chan_spec ltr501_channels[] = {
 	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0,
 		ltr501_als_event_spec, ARRAY_SIZE(ltr501_als_event_spec)),
 	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
-		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_INT_TIME),
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_INT_TIME) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		NULL, 0),
 	{
 		.type = IIO_PROXIMITY,
@@ -314,6 +534,23 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_INTENSITY:
+			ret = ltr501_read_samp_freq(data->reg_als_rate,
+						als_sampling_table,
+						ARRAY_SIZE(als_sampling_table),
+						val, val2);
+			return ret;
+		case IIO_PROXIMITY:
+			ret = ltr501_read_samp_freq(data->reg_ps_rate,
+						ps_sampling_table,
+						ARRAY_SIZE(ps_sampling_table),
+						val, val2);
+			return ret;
+		default:
+			return -EINVAL;
+		}
 	}
 	return -EINVAL;
 }
@@ -334,7 +571,7 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 			       int val, int val2, long mask)
 {
 	struct ltr501_data *data = iio_priv(indio_dev);
-	int i;
+	int i, ret, freq_val, freq_val2;
 
 	if (iio_buffer_enabled(indio_dev))
 		return -EBUSY;
@@ -376,6 +613,57 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_INTENSITY:
+			ret = ltr501_read_samp_freq(data->reg_als_rate,
+						als_sampling_table,
+						ARRAY_SIZE(als_sampling_table),
+						&freq_val, &freq_val2);
+			ret = ltr501_write_samp_freq(data, data->reg_als_rate,
+						als_sampling_table,
+						ARRAY_SIZE(als_sampling_table),
+						val, val2);
+			if (ret < 0)
+				return ret;
+
+			/* update persistence count when changing frequency */
+			ret = ltr501_write_intr_prst(data, chan->type,
+						     0, data->als_period);
+
+			if (ret < 0)
+				return ltr501_write_samp_freq(data,
+						data->reg_als_rate,
+						als_sampling_table,
+						ARRAY_SIZE(als_sampling_table),
+						freq_val, freq_val2);
+			return ret;
+		case IIO_PROXIMITY:
+			ret = ltr501_read_samp_freq(data->reg_ps_rate,
+						ps_sampling_table,
+						ARRAY_SIZE(ps_sampling_table),
+						&freq_val, &freq_val2);
+			ret = ltr501_write_samp_freq(data, data->reg_ps_rate,
+						ps_sampling_table,
+						ARRAY_SIZE(ps_sampling_table),
+						val, val2);
+			if (ret < 0)
+				return ret;
+
+			/* update persistence count when changing frequency */
+			ret = ltr501_write_intr_prst(data, chan->type,
+						     0, data->ps_period);
+
+			if (ret < 0)
+				return ltr501_write_samp_freq(data,
+						data->reg_ps_rate,
+						ps_sampling_table,
+						ARRAY_SIZE(ps_sampling_table),
+						freq_val, freq_val2);
+			return ret;
+		default:
+			return -EINVAL;
+		}
 	}
 	return -EINVAL;
 }
@@ -499,6 +787,55 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ltr501_read_event(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     enum iio_event_type type,
+			     enum iio_event_direction dir,
+			     enum iio_event_info info,
+			     int *val, int *val2)
+{
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return ltr501_read_thresh(indio_dev, chan, type, dir,
+					  info, val, val2);
+	case IIO_EV_INFO_PERIOD:
+		ret = ltr501_read_intr_prst(iio_priv(indio_dev),
+					    chan->type, val2);
+		*val = *val2 / 1000000;
+		*val2 = *val2 % 1000000;
+		return ret;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int ltr501_write_event(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir,
+			      enum iio_event_info info,
+			      int val, int val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val2 != 0)
+			return -EINVAL;
+		return ltr501_write_thresh(indio_dev, chan, type, dir,
+					   info, val, val2);
+	case IIO_EV_INFO_PERIOD:
+		return ltr501_write_intr_prst(iio_priv(indio_dev), chan->type,
+					      val, val2);
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
 static int ltr501_read_event_config(struct iio_dev *indio_dev,
 		const struct iio_chan_spec *chan,
 		enum iio_event_type type,
@@ -557,11 +894,13 @@ static int ltr501_write_event_config(struct iio_dev *indio_dev,
 static IIO_CONST_ATTR(in_proximity_scale_available, "1 0.25 0.125 0.0625");
 static IIO_CONST_ATTR(in_intensity_scale_available, "1 0.005");
 static IIO_CONST_ATTR_INT_TIME_AVAIL("0.05 0.1 0.2 0.4");
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("20 10 5 2 1 0.5");
 
 static struct attribute *ltr501_attributes[] = {
 	&iio_const_attr_in_proximity_scale_available.dev_attr.attr,
 	&iio_const_attr_in_intensity_scale_available.dev_attr.attr,
 	&iio_const_attr_integration_time_available.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
 };
 
@@ -580,8 +919,8 @@ static const struct iio_info ltr501_info = {
 	.read_raw = ltr501_read_raw,
 	.write_raw = ltr501_write_raw,
 	.attrs = &ltr501_attribute_group,
-	.read_event_value	= &ltr501_read_thresh,
-	.write_event_value	= &ltr501_write_thresh,
+	.read_event_value	= &ltr501_read_event,
+	.write_event_value	= &ltr501_write_event,
 	.read_event_config	= &ltr501_read_event_config,
 	.write_event_config	= &ltr501_write_event_config,
 	.driver_module = THIS_MODULE,
@@ -694,6 +1033,14 @@ static int ltr501_init(struct ltr501_data *data)
 
 	data->ps_contr = status | LTR501_CONTR_ACTIVE;
 
+	ret = ltr501_read_intr_prst(data, IIO_INTENSITY, &data->als_period);
+	if (ret < 0)
+		return ret;
+
+	ret = ltr501_read_intr_prst(data, IIO_PROXIMITY, &data->ps_period);
+	if (ret < 0)
+		return ret;
+
 	return ltr501_write_contr(data, data->als_contr, data->ps_contr);
 }
 
@@ -764,6 +1111,34 @@ static int ltr501_probe(struct i2c_client *client,
 		return PTR_ERR(data->reg_ps_intr);
 	}
 
+	data->reg_als_rate = devm_regmap_field_alloc(&client->dev, regmap,
+						      reg_als_rate);
+	if (IS_ERR(data->reg_als_rate)) {
+		dev_err(&client->dev, "ALS samp rate field init failed.\n");
+		return PTR_ERR(data->reg_als_rate);
+	}
+
+	data->reg_ps_rate = devm_regmap_field_alloc(&client->dev, regmap,
+						      reg_ps_rate);
+	if (IS_ERR(data->reg_ps_rate)) {
+		dev_err(&client->dev, "PS samp rate field init failed.\n");
+		return PTR_ERR(data->reg_ps_rate);
+	}
+
+	data->reg_als_prst = devm_regmap_field_alloc(&client->dev, regmap,
+						      reg_als_prst);
+	if (IS_ERR(data->reg_als_prst)) {
+		dev_err(&client->dev, "ALS prst reg field init failed\n");
+		return PTR_ERR(data->reg_als_prst);
+	}
+
+	data->reg_ps_prst = devm_regmap_field_alloc(&client->dev, regmap,
+						      reg_ps_prst);
+	if (IS_ERR(data->reg_ps_prst)) {
+		dev_err(&client->dev, "PS prst reg field init failed.\n");
+		return PTR_ERR(data->reg_ps_prst);
+	}
+
 	ret = regmap_read(data->regmap, LTR501_PART_ID, &partid);
 	if (ret < 0)
 		return ret;
-- 
1.9.1
