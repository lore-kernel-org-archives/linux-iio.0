Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:34797 "EHLO fe2.pruts.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbcIJTT7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Sep 2016 15:19:59 -0400
From: Ico Doornekamp <ico@pruts.nl>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Ico Doornekamp <ico@pruts.nl>
Subject: [PATCH] iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ
Date: Sat, 10 Sep 2016 21:19:46 +0200
Message-Id: <20160910191946.30105-1-ico@pruts.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Moved functionality from IIO_DEV_ATTR_SAMP_FREQ attribute into
IIO_CHAN_INFO_SAMP_FREQ handlers. Added sca3000_write_raw() to allow
writing the element as well.

Signed-off-by: Ico Doornekamp <ico@pruts.nl>
---

Up for review.

I'm not happy with gotos jumping out of switches, so sca3000_write_raw() needs
some fiddling to properly release the lock in the error path. Maybe it's better
to create functions for handling the IIO_CHAN_INFO_SAMP_FREQ case instead of
mixing it all into the switch?

Is there any way IIO_DEV_ATTR_SAMP_FREQ_AVAIL fits into the IIO_CHAN_INFO
elements, or should it stay the way it is currently implemented?

Maybe I should just stick to fixing white space issues...

 drivers/staging/iio/accel/sca3000_core.c | 218 ++++++++++++++-----------------
 1 file changed, 96 insertions(+), 122 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 61f3241..d80f61b 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -443,6 +443,35 @@ static u8 sca3000_addresses[3][3] = {
 	       SCA3000_MD_CTRL_OR_Z},
 };
 
+/**
+ * __sca3000_get_base_freq() obtain mode specific base frequency
+ *
+ * lock must be held
+ **/
+static inline int __sca3000_get_base_freq(struct sca3000_state *st,
+					  const struct sca3000_chip_info *info,
+					  int *base_freq)
+{
+	int ret;
+
+	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
+	if (ret)
+		goto error_ret;
+	switch (0x03 & st->rx[0]) {
+	case SCA3000_MEAS_MODE_NORMAL:
+		*base_freq = info->measurement_mode_freq;
+		break;
+	case SCA3000_MEAS_MODE_OP_1:
+		*base_freq = info->option_mode_1_freq;
+		break;
+	case SCA3000_MEAS_MODE_OP_2:
+		*base_freq = info->option_mode_2_freq;
+		break;
+	}
+error_ret:
+	return ret;
+}
+
 static int sca3000_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val,
@@ -495,11 +524,77 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 		*val = -214;
 		*val2 = 600000;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&st->lock);
+		ret = __sca3000_get_base_freq(st, st->info, val);
+		if (ret) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+		ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
+		mutex_unlock(&st->lock);
+		if (ret < 0)
+			return ret;
+		if (*val > 0)
+			switch (ret & 0x03) {
+			case SCA3000_OUT_CTRL_BUF_DIV_2:
+				*val /= 2;
+				break;
+			case SCA3000_OUT_CTRL_BUF_DIV_4:
+				*val /= 4;
+				break;
+		}
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
 }
 
+static int sca3000_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct sca3000_state *st = iio_priv(indio_dev);
+	int ret, base_freq;
+	int ctrlval;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2)
+			return -EINVAL;
+		mutex_lock(&st->lock);
+		/* What mode are we in? */
+		ret = __sca3000_get_base_freq(st, st->info, &base_freq);
+		if (ret) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+		ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+		ctrlval = ret & ~0x03; /* clear the bits */
+
+		if (val == base_freq / 2) {
+			ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_2;
+		} else if (val == base_freq / 4) {
+			ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_4;
+		} else if (val != base_freq) {
+			mutex_unlock(&st->lock);
+			return -EINVAL;
+		}
+		ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
+					     ctrlval);
+		mutex_unlock(&st->lock);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 /**
  * sca3000_read_av_freq() sysfs function to get available frequencies
  *
@@ -548,133 +643,12 @@ error_ret:
 	return ret;
 }
 
-/**
- * __sca3000_get_base_freq() obtain mode specific base frequency
- *
- * lock must be held
- **/
-static inline int __sca3000_get_base_freq(struct sca3000_state *st,
-					  const struct sca3000_chip_info *info,
-					  int *base_freq)
-{
-	int ret;
-
-	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
-	if (ret)
-		goto error_ret;
-	switch (0x03 & st->rx[0]) {
-	case SCA3000_MEAS_MODE_NORMAL:
-		*base_freq = info->measurement_mode_freq;
-		break;
-	case SCA3000_MEAS_MODE_OP_1:
-		*base_freq = info->option_mode_1_freq;
-		break;
-	case SCA3000_MEAS_MODE_OP_2:
-		*base_freq = info->option_mode_2_freq;
-		break;
-	}
-error_ret:
-	return ret;
-}
-
-/**
- * sca3000_read_frequency() sysfs interface to get the current frequency
- **/
-static ssize_t sca3000_read_frequency(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret, len = 0, base_freq = 0, val;
-
-	mutex_lock(&st->lock);
-	ret = __sca3000_get_base_freq(st, st->info, &base_freq);
-	if (ret)
-		goto error_ret_mut;
-	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
-	mutex_unlock(&st->lock);
-	if (ret < 0)
-		goto error_ret;
-	val = ret;
-	if (base_freq > 0)
-		switch (val & 0x03) {
-		case 0x00:
-		case 0x03:
-			len = sprintf(buf, "%d\n", base_freq);
-			break;
-		case 0x01:
-			len = sprintf(buf, "%d\n", base_freq / 2);
-			break;
-		case 0x02:
-			len = sprintf(buf, "%d\n", base_freq / 4);
-			break;
-	}
-
-	return len;
-error_ret_mut:
-	mutex_unlock(&st->lock);
-error_ret:
-	return ret;
-}
-
-/**
- * sca3000_set_frequency() sysfs interface to set the current frequency
- **/
-static ssize_t sca3000_set_frequency(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf,
-				     size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret, base_freq = 0;
-	int ctrlval;
-	int val;
-
-	ret = kstrtoint(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	mutex_lock(&st->lock);
-	/* What mode are we in? */
-	ret = __sca3000_get_base_freq(st, st->info, &base_freq);
-	if (ret)
-		goto error_free_lock;
-
-	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
-	if (ret < 0)
-		goto error_free_lock;
-	ctrlval = ret;
-	/* clear the bits */
-	ctrlval &= ~0x03;
-
-	if (val == base_freq / 2) {
-		ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_2;
-	} else if (val == base_freq / 4) {
-		ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_4;
-	} else if (val != base_freq) {
-		ret = -EINVAL;
-		goto error_free_lock;
-	}
-	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
-				     ctrlval);
-error_free_lock:
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
-}
-
 /*
  * Should only really be registered if ring buffer support is compiled in.
  * Does no harm however and doing it right would add a fair bit of complexity
  */
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sca3000_read_av_freq);
 
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-			      sca3000_read_frequency,
-			      sca3000_set_frequency);
-
 /**
  * sca3000_read_thresh() - query of a threshold
  **/
@@ -751,7 +725,6 @@ static struct attribute *sca3000_attributes[] = {
 	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
 	&iio_dev_attr_measurement_mode.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	NULL,
 };
 
@@ -1086,6 +1059,7 @@ error_ret:
 static const struct iio_info sca3000_info = {
 	.attrs = &sca3000_attribute_group,
 	.read_raw = &sca3000_read_raw,
+	.write_raw = &sca3000_write_raw,
 	.event_attrs = &sca3000_event_attribute_group,
 	.read_event_value = &sca3000_read_thresh,
 	.write_event_value = &sca3000_write_thresh,
-- 
2.9.3

