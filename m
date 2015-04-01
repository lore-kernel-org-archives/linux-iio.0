Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v1 2/3] iio: ltr501: Add interrupt rate control support
Date: Tue, 31 Mar 2015 19:55:20 -0700
Message-Id: <212b45fac712e84a3cf0bc5955def7d1b683a6bd.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 drivers/iio/light/ltr501.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 16c3f7a..e8f5019 100644
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
@@ -126,6 +130,75 @@ static int ltr501_read_ps(struct ltr501_data *data)
 	return i2c_smbus_read_word_data(data->client, LTR501_PS_DATA);
 }
 
+static ssize_t ltr501_read_intr_prst(struct iio_dev *indio_dev,
+				   uintptr_t private,
+				   const struct iio_chan_spec *chan,
+				   char *buf)
+{
+	struct ltr501_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		mutex_lock(&data->lock_als);
+		ret = i2c_smbus_read_byte_data(data->client, LTR501_INTR_PRST);
+		mutex_unlock(&data->lock_als);
+		return ret < 0 ? ret : sprintf(buf, "%u\n",
+				ret & LTR501_INTR_PRST_ALS_MASK);
+	case IIO_PROXIMITY:
+		mutex_lock(&data->lock_ps);
+		ret = i2c_smbus_read_byte_data(data->client, LTR501_INTR_PRST);
+		mutex_unlock(&data->lock_ps);
+		return ret < 0 ? ret : sprintf(buf, "%u\n",
+				(ret & LTR501_INTR_PRST_PS_MASK) >> 4);
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t ltr501_write_intr_prst(struct iio_dev *indio_dev,
+				    uintptr_t private,
+				    const struct iio_chan_spec *chan,
+				    const char *buf, size_t len)
+{
+	struct ltr501_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+	u8 new_val;
+
+	ret = kstrtou8(buf, 10, &new_val);
+	if (ret)
+		return ret;
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
+					LTR501_INTR_PRST, new_val);
+		mutex_unlock(&data->lock_als);
+		break;
+	case IIO_PROXIMITY:
+		mutex_lock(&data->lock_ps);
+		new_val = (ret & ~LTR501_INTR_PRST_PS_MASK) |
+				((new_val << 4) & LTR501_INTR_PRST_PS_MASK);
+		ret = i2c_smbus_write_byte_data(data->client,
+					LTR501_INTR_PRST, new_val);
+		mutex_unlock(&data->lock_ps);
+		break;
+	default:
+		break;
+	}
+
+	return ret < 0 ? ret : len;
+}
+
 static const struct iio_event_spec ltr501_als_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -163,6 +236,16 @@ static const struct iio_event_spec ltr501_pxs_event_spec[] = {
 	},
 };
 
+static const struct iio_chan_spec_ext_info ltr501_ext_info[] = {
+	{
+		.name = "intr_persist",
+		.read = ltr501_read_intr_prst,
+		.write = ltr501_write_intr_prst,
+		.shared = IIO_SHARED_BY_TYPE,
+	},
+	{},
+};
+
 #define LTR501_INTENSITY_CHANNEL(_idx, _addr, _mod, _shared) { \
 	.type = IIO_INTENSITY, \
 	.modified = 1, \
@@ -179,6 +262,7 @@ static const struct iio_event_spec ltr501_pxs_event_spec[] = {
 	}, \
 	.event_spec = ltr501_als_event_spec,\
 	.num_event_specs = ARRAY_SIZE(ltr501_als_event_spec),\
+	.ext_info = ltr501_ext_info,\
 }
 
 static const struct iio_chan_spec ltr501_channels[] = {
@@ -199,6 +283,7 @@ static const struct iio_chan_spec ltr501_channels[] = {
 		},
 		.event_spec = ltr501_pxs_event_spec,
 		.num_event_specs = ARRAY_SIZE(ltr501_pxs_event_spec),
+		.ext_info = ltr501_ext_info,
 	},
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
-- 
1.9.1
