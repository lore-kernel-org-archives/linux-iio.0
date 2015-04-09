Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v3 5/6] iio: ltr501: Add interrupt rate control support
Date: Wed,  8 Apr 2015 17:06:09 -0700
Message-Id: <7c41c43719bd0672124d216a9f1d3188523e5977.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1428537814.git.sathyanarayanan.kuppuswamy@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added rate control support for ALS and proximity
threshold interrupts.

Setting <n> to ALS intr_persist sysfs node would
generate interrupt whenever ALS data cross either
upper or lower threshold limits <n> number of times.
Similarly setting <m> to proximity intr_persist sysfs
node would genere interrupt whenever proximity data falls
outside threshold limit <m> number of times.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/iio/light/ltr501.c | 121 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 8672962..1b314f3 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -39,6 +39,7 @@
 #define LTR501_PS_THRESH_LOW 0x92 /* 11 bit, ps lower threshold */
 #define LTR501_ALS_THRESH_UP 0x97 /* 16 bit, ALS upper threshold */
 #define LTR501_ALS_THRESH_LOW 0x99 /* 16 bit, ALS lower threshold */
+#define LTR501_INTR_PRST 0x9e /* ps thresh, als thresh */
 
 #define LTR501_ALS_CONTR_SW_RESET BIT(2)
 #define LTR501_CONTR_PS_GAIN_MASK (BIT(3) | BIT(2))
@@ -65,6 +66,9 @@
 #define LTR501_INTR_MODE_ALS BIT(1)
 #define LTR501_INTR_MODE_ALS_PS 3
 
+#define LTR501_INTR_PRST_ALS_MASK 0x0f
+#define LTR501_INTR_PRST_PS_MASK 0xf0
+
 #define LTR501_PS_DATA_MASK 0x7ff
 #define LTR501_PS_THRESH_MASK 0x7ff
 #define LTR501_ALS_THRESH_MASK 0xffff
@@ -127,6 +131,70 @@ static int ltr501_read_ps(struct ltr501_data *data)
 	return i2c_smbus_read_word_data(data->client, LTR501_PS_DATA);
 }
 
+static int ltr501_read_intr_prst(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 int *val)
+{
+	struct ltr501_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		mutex_lock(&data->lock_als);
+		ret = i2c_smbus_read_byte_data(data->client, LTR501_INTR_PRST);
+		mutex_unlock(&data->lock_als);
+		if (ret >= 0)
+			*val = ret & LTR501_INTR_PRST_ALS_MASK;
+		break;
+	case IIO_PROXIMITY:
+		mutex_lock(&data->lock_ps);
+		ret = i2c_smbus_read_byte_data(data->client, LTR501_INTR_PRST);
+		mutex_unlock(&data->lock_ps);
+		if (ret >= 0)
+			*val = (ret & LTR501_INTR_PRST_PS_MASK) >> 4;
+		break;
+	default:
+		break;
+	}
+
+	return ret < 0 ? ret : IIO_VAL_INT;
+}
+
+static int ltr501_write_intr_prst(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  u8 new_val)
+{
+	struct ltr501_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	ret = i2c_smbus_read_byte_data(data->client, LTR501_INTR_PRST);
+	if (ret < 0)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		mutex_lock(&data->lock_als);
+		new_val = (ret & ~LTR501_INTR_PRST_ALS_MASK) |
+				(new_val & LTR501_INTR_PRST_ALS_MASK);
+		ret = i2c_smbus_write_byte_data(data->client,
+						LTR501_INTR_PRST, new_val);
+		mutex_unlock(&data->lock_als);
+		break;
+	case IIO_PROXIMITY:
+		mutex_lock(&data->lock_ps);
+		new_val = (ret & ~LTR501_INTR_PRST_PS_MASK) |
+				((new_val << 4) & LTR501_INTR_PRST_PS_MASK);
+		ret = i2c_smbus_write_byte_data(data->client,
+						LTR501_INTR_PRST, new_val);
+		mutex_unlock(&data->lock_ps);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static const struct iio_event_spec ltr501_als_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -141,7 +209,8 @@ static const struct iio_event_spec ltr501_als_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_PERSISTENCE),
 	},
 
 };
@@ -160,7 +229,8 @@ static const struct iio_event_spec ltr501_pxs_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
+				 BIT(IIO_EV_INFO_PERSISTENCE),
 	},
 };
 
@@ -423,6 +493,49 @@ static int ltr501_write_thresh(struct iio_dev *indio_dev,
 	return ret < 0 ? ret : IIO_VAL_INT;
 }
 
+static int ltr501_read_event(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     enum iio_event_type type,
+			     enum iio_event_direction dir,
+			     enum iio_event_info info,
+			     int *val, int *val2)
+{
+	*val2 = 0;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return ltr501_read_thresh(indio_dev, chan, type, dir,
+					  info, val, val2);
+	case IIO_EV_INFO_PERSISTENCE:
+		return ltr501_read_intr_prst(indio_dev, chan, val);
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT;
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
+		return ltr501_write_thresh(indio_dev, chan, type, dir,
+					   info, val, val2);
+	case IIO_EV_INFO_PERSISTENCE:
+		return ltr501_write_intr_prst(indio_dev, chan, val);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
 static int ltr501_read_event_config(struct iio_dev *indio_dev,
 		const struct iio_chan_spec *chan,
 		enum iio_event_type type,
@@ -502,8 +615,8 @@ static const struct iio_info ltr501_info = {
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
-- 
1.9.1
