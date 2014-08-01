Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 2/2] iio: accel: kxcjk-1013: Set adjustable range
Date: Fri,  1 Aug 2014 09:49:22 -0700
Message-Id: <1406911762-6503-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1406911762-6503-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1406911762-6503-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This chip can support 3 different ranges. Allowing range specification.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 100 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 035ba23..3c86706 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -82,6 +82,7 @@ struct kxcjk1013_data {
 	struct mutex mutex;
 	s16 buffer[8];
 	u8 odr_bits;
+	u8 range;
 	bool active_high_intr;
 	bool trigger_on;
 };
@@ -97,6 +98,12 @@ enum kxcjk1013_mode {
 	OPERATION,
 };
 
+enum kxcjk1013_range {
+	KXCJK1013_RANGE_2G,
+	KXCJK1013_RANGE_4G,
+	KXCJK1013_RANGE_8G,
+};
+
 static const struct {
 	int val;
 	int val2;
@@ -116,6 +123,14 @@ static const struct {
 			   {0x02, 21000}, {0x03, 11000}, {0x04, 6400},
 			   {0x05, 3900}, {0x06, 2700}, {0x07, 2100} };
 
+static const struct {
+	u16 scale;
+	u8 gsel_0;
+	u8 gsel_1;
+} KXCJK1013_scale_table[] = { {9582, 0, 0},
+			      {19163, 0, 1},
+			      {38326, 1, 0} };
+
 static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 			      enum kxcjk1013_mode mode)
 {
@@ -161,6 +176,32 @@ static int kxcjk1013_get_mode(struct kxcjk1013_data *data,
 	return 0;
 }
 
+static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
+		return ret;
+	}
+
+	ret |= (KXCJK1013_scale_table[range_index].gsel_0 << 3);
+	ret |= (KXCJK1013_scale_table[range_index].gsel_1 << 4);
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					KXCJK1013_REG_CTRL1,
+					ret);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
+		return ret;
+	}
+
+	data->range = range_index;
+
+	return -EINVAL;
+}
+
 static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 {
 	int ret;
@@ -183,10 +224,6 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 		return ret;
 	}
 
-	/* Setting range to 4G */
-	ret |= KXCJK1013_REG_CTRL1_BIT_GSEL0;
-	ret &= ~KXCJK1013_REG_CTRL1_BIT_GSEL1;
-
 	/* Set 12 bit mode */
 	ret |= KXCJK1013_REG_CTRL1_BIT_RES;
 
@@ -197,6 +234,14 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 		return ret;
 	}
 
+	/* Setting range to 4G */
+	ret = kxcjk1013_set_range(data, KXCJK1013_RANGE_4G);
+	if (ret < 0)
+		return ret;
+
+	data->range = KXCJK1013_RANGE_4G;
+
+
 	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_DATA_CTRL);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_data_ctrl\n");
@@ -417,6 +462,40 @@ static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)
 	return ret;
 }
 
+static int kxcjk1013_set_scale(struct kxcjk1013_data *data, int val)
+{
+	int ret, i;
+	enum kxcjk1013_mode store_mode;
+
+
+	for (i = 0; i < ARRAY_SIZE(KXCJK1013_scale_table); ++i) {
+		if (KXCJK1013_scale_table[i].scale == val) {
+
+			ret = kxcjk1013_get_mode(data, &store_mode);
+			if (ret < 0)
+				return ret;
+
+			ret = kxcjk1013_set_mode(data, STANDBY);
+			if (ret < 0)
+				return ret;
+
+			ret = kxcjk1013_set_range(data, i);
+			if (ret < 0)
+				return ret;
+
+			if (store_mode == OPERATION) {
+				ret = kxcjk1013_set_mode(data, OPERATION);
+				if (ret)
+					return ret;
+			}
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan, int *val,
 			      int *val2, long mask)
@@ -453,7 +532,7 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		*val2 = 19163; /* range +-4g (4/2047*9.806650) */
+		*val2 = KXCJK1013_scale_table[data->range].scale;
 		return IIO_VAL_INT_PLUS_MICRO;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -480,6 +559,14 @@ static int kxcjk1013_write_raw(struct iio_dev *indio_dev,
 		ret = kxcjk1013_set_odr(data, val, val2);
 		mutex_unlock(&data->mutex);
 		break;
+	case IIO_CHAN_INFO_SCALE:
+		if (val)
+			return -EINVAL;
+
+		mutex_lock(&data->mutex);
+		ret = kxcjk1013_set_scale(data, val2);
+		mutex_unlock(&data->mutex);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -501,8 +588,11 @@ static int kxcjk1013_validate_trigger(struct iio_dev *indio_dev,
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 	"0.781000 1.563000 3.125000 6.250000 12.500000 25 50 100 200 400 800 1600");
 
+static IIO_CONST_ATTR(in_accel_scale_available, "0.009582 0.019163 0.038326");
+
 static struct attribute *kxcjk1013_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
 	NULL,
 };
 
-- 
1.9.1
