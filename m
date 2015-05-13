Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH V4 6/7] iio: mma8452: Add highpass filter configuration.
To: Peter Meerwald <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>
Date: Wed, 13 May 2015 12:26:48 +0200
Message-ID: <20150513102648.27803.92023.stgit@localhost>
In-Reply-To: <20150513102635.27803.99054.stgit@localhost>
References: <20150513102635.27803.99054.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Allow the cutoff frequency of the high pass filter to be configured.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/iio/accel/mma8452.c |  137 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 196dc42..5f2977f 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -29,9 +29,12 @@
 #define MMA8452_INT_SRC 0x0c
 #define MMA8452_WHO_AM_I 0x0d
 #define MMA8452_DATA_CFG 0x0e
+#define MMA8452_HP_FILTER_CUTOFF 0x0f
+#define MMA8452_HP_FILTER_CUTOFF_SEL_MASK	(BIT(0) | BIT(1))
 #define MMA8452_TRANSIENT_CFG 0x1d
 #define MMA8452_TRANSIENT_CFG_ELE		BIT(4)
 #define MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
+#define MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
 #define MMA8452_TRANSIENT_SRC 0x1e
 #define MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
 #define MMA8452_TRANSIENT_SRC_YTRANSE		BIT(3)
@@ -61,6 +64,7 @@
 #define MMA8452_DATA_CFG_FS_2G 0
 #define MMA8452_DATA_CFG_FS_4G 1
 #define MMA8452_DATA_CFG_FS_8G 2
+#define MMA8452_DATA_CFG_HPF_MASK BIT(4)
 
 #define MMA8452_INT_TRANS	BIT(5)
 
@@ -158,6 +162,18 @@ static const int mma8452_transient_time_step_us[8] = {
 	20000
 };
 
+/* Datasheet table 18 (normal mode) */
+static const int mma8452_hp_filter_cutoff[8][4][2] = {
+	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },		/* 800 Hz sample */
+	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },		/* 400 Hz sample */
+	{ {8, 0}, {4, 0}, {2, 0}, {1, 0} },		/* 200 Hz sample */
+	{ {4, 0}, {2, 0}, {1, 0}, {0, 500000} },	/* 100 Hz sample */
+	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} },	/* 50 Hz sample */
+	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} },	/* 12.5 Hz sample */
+	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} },	/* 6.25 Hz sample */
+	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} }	/* 1.56 Hz sample */
+};
+
 static ssize_t mma8452_show_samp_freq_avail(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -172,9 +188,23 @@ static ssize_t mma8452_show_scale_avail(struct device *dev,
 		ARRAY_SIZE(mma8452_scales));
 }
 
+static ssize_t mma8452_show_hp_cutoff_avail(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct mma8452_data *data = iio_priv(indio_dev);
+	int i = mma8452_get_odr_index(data);
+
+	return mma8452_show_int_plus_micros(buf, mma8452_hp_filter_cutoff[i],
+		ARRAY_SIZE(mma8452_hp_filter_cutoff[0]));
+}
+
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mma8452_show_samp_freq_avail);
 static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
 	mma8452_show_scale_avail, NULL, 0);
+static IIO_DEVICE_ATTR(in_accel_filter_high_pass_3db_frequency_available,
+			S_IRUGO, mma8452_show_hp_cutoff_avail, NULL, 0);
 
 static int mma8452_get_samp_freq_index(struct mma8452_data *data,
 	int val, int val2)
@@ -190,6 +220,31 @@ static int mma8452_get_scale_index(struct mma8452_data *data,
 		ARRAY_SIZE(mma8452_scales), val, val2);
 }
 
+static int mma8452_get_hp_filter_index(struct mma8452_data *data,
+				       int val, int val2)
+{
+	int i = mma8452_get_odr_index(data);
+
+	return mma8452_get_int_plus_micros_index(mma8452_hp_filter_cutoff[i],
+		ARRAY_SIZE(mma8452_scales[0]), val, val2);
+}
+
+static int mma8452_read_hp_filter(struct mma8452_data *data, int *hz, int *uHz)
+{
+	int i, ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, MMA8452_HP_FILTER_CUTOFF);
+	if (ret < 0)
+		return ret;
+
+	i = mma8452_get_odr_index(data);
+	ret &= MMA8452_HP_FILTER_CUTOFF_SEL_MASK;
+	*hz = mma8452_hp_filter_cutoff[i][ret][0];
+	*uHz = mma8452_hp_filter_cutoff[i][ret][1];
+
+	return 0;
+}
+
 static int mma8452_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -228,6 +283,16 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		*val = sign_extend32(ret, 7);
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		if (data->data_cfg & MMA8452_DATA_CFG_HPF_MASK) {
+			ret = mma8452_read_hp_filter(data, val, val2);
+			if (ret < 0)
+				return ret;
+		} else {
+			*val = 0;
+			*val2 = 0;
+		}
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 	return -EINVAL;
 }
@@ -269,12 +334,31 @@ fail:
 	return ret;
 }
 
+static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
+					   int val, int val2)
+{
+	int i, reg;
+
+	i = mma8452_get_hp_filter_index(data, val, val2);
+	if (i < 0)
+		return -EINVAL;
+
+	reg = i2c_smbus_read_byte_data(data->client,
+				       MMA8452_HP_FILTER_CUTOFF);
+	if (reg < 0)
+		return reg;
+	reg &= ~MMA8452_HP_FILTER_CUTOFF_SEL_MASK;
+	reg |= i;
+
+	return mma8452_change_config(data, MMA8452_HP_FILTER_CUTOFF, reg);
+}
+
 static int mma8452_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
-	int i;
+	int i, ret;
 
 	if (iio_buffer_enabled(indio_dev))
 		return -EBUSY;
@@ -302,6 +386,19 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		return mma8452_change_config(data, MMA8452_OFF_X +
 			chan->scan_index, val);
+
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		if (val == 0 && val2 == 0) {
+			data->data_cfg &= ~MMA8452_DATA_CFG_HPF_MASK;
+		} else {
+			data->data_cfg |= MMA8452_DATA_CFG_HPF_MASK;
+			ret = mma8452_set_hp_filter_frequency(data, val, val2);
+			if (ret < 0)
+				return ret;
+		}
+		return mma8452_change_config(data, MMA8452_DATA_CFG,
+						data->data_cfg);
+
 	default:
 		return -EINVAL;
 	}
@@ -339,6 +436,22 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
 		*val2 = us % USEC_PER_SEC;
 		return IIO_VAL_INT_PLUS_MICRO;
 
+	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
+		ret = i2c_smbus_read_byte_data(data->client,
+					       MMA8452_TRANSIENT_CFG);
+		if (ret < 0)
+			return ret;
+
+		if (ret & MMA8452_TRANSIENT_CFG_HPF_BYP) {
+			*val = 0;
+			*val2 = 0;
+		} else {
+			ret = mma8452_read_hp_filter(data, val, val2);
+			if (ret < 0)
+				return ret;
+		}
+		return IIO_VAL_INT_PLUS_MICRO;
+
 	default:
 		return -EINVAL;
 	}
@@ -352,7 +465,7 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
 				int val, int val2)
 {
 	struct mma8452_data *data = iio_priv(indio_dev);
-	int steps;
+	int ret, reg, steps;
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
@@ -369,6 +482,22 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
 
 		return mma8452_change_config(data, MMA8452_TRANSIENT_COUNT,
 					     steps);
+	case IIO_EV_INFO_HIGH_PASS_FILTER_3DB:
+		reg = i2c_smbus_read_byte_data(data->client,
+					       MMA8452_TRANSIENT_CFG);
+		if (reg < 0)
+			return reg;
+
+		if (val == 0 && val2 == 0) {
+			reg |= MMA8452_TRANSIENT_CFG_HPF_BYP;
+		} else {
+			reg &= ~MMA8452_TRANSIENT_CFG_HPF_BYP;
+			ret = mma8452_set_hp_filter_frequency(data, val, val2);
+			if (ret < 0)
+				return ret;
+		}
+		return mma8452_change_config(data, MMA8452_TRANSIENT_CFG, reg);
+
 	default:
 		return -EINVAL;
 	}
@@ -538,7 +667,8 @@ static struct attribute_group mma8452_event_attribute_group = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
 		BIT(IIO_CHAN_INFO_CALIBBIAS), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
-		BIT(IIO_CHAN_INFO_SCALE), \
+		BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY), \
 	.scan_index = idx, \
 	.scan_type = { \
 		.sign = 's', \
@@ -561,6 +691,7 @@ static const struct iio_chan_spec mma8452_channels[] = {
 static struct attribute *mma8452_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_filter_high_pass_3db_frequency_available.dev_attr.attr,
 	NULL
 };
 
