Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50320 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab3KQOOM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:12 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 10/11] staging:iio:adc:ad7192 use infomask* to provide access to sampling frequency and scale_available
Date: Sun, 17 Nov 2013 15:15:01 +0000
Message-Id: <1384701302-26564-11-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Doing it this way rather than via custom attributes makes this information
available to in kernel consumers of the IIO channels.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7192.c | 166 ++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 99 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 75187fc8e4b4..804062aa64a0 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -142,7 +142,7 @@ struct ad7192_state {
 	u32				f_order;
 	u32				mode;
 	u32				conf;
-	u32				scale_avail[8][2];
+	u32				scale_avail[8 * 2];
 	u8				gpocon;
 	u8				devid;
 
@@ -289,14 +289,14 @@ static int ad7192_setup(struct ad7192_state *st,
 		goto out;
 
 	/* Populate available ADC input ranges */
-	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
+	for (i = 0; i < ARRAY_SIZE(st->scale_avail) / 2; i++) {
 		scale_uv = ((u64)st->int_vref_mv * 100000000)
 			>> (indio_dev->channels[0].scan_type.realbits -
 			((st->conf & AD7192_CONF_UNIPOLAR) ? 0 : 1));
 		scale_uv >>= i;
 
-		st->scale_avail[i][1] = do_div(scale_uv, 100000000) * 10;
-		st->scale_avail[i][0] = scale_uv;
+		st->scale_avail[i * 2 + 1] = do_div(scale_uv, 100000000) * 10;
+		st->scale_avail[i * 2 + 0] = scale_uv;
 	}
 
 	return 0;
@@ -305,82 +305,6 @@ out:
 	return ret;
 }
 
-static ssize_t ad7192_read_frequency(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7192_state *st = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n", st->mclk /
-			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode)));
-}
-
-static ssize_t ad7192_write_frequency(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7192_state *st = iio_priv(indio_dev);
-	unsigned long lval;
-	int div, ret;
-
-	ret = kstrtoul(buf, 10, &lval);
-	if (ret)
-		return ret;
-	if (lval == 0)
-		return -EINVAL;
-
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
-		return -EBUSY;
-	}
-
-	div = st->mclk / (lval * st->f_order * 1024);
-	if (div < 1 || div > 1023) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	st->mode &= ~AD7192_MODE_RATE(-1);
-	st->mode |= AD7192_MODE_RATE(div);
-	ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
-
-out:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret ? ret : len;
-}
-
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		ad7192_read_frequency,
-		ad7192_write_frequency);
-
-static ssize_t ad7192_show_scale_available(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7192_state *st = iio_priv(indio_dev);
-	int i, len = 0;
-
-	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
-		len += sprintf(buf + len, "%d.%09u ", st->scale_avail[i][0],
-			       st->scale_avail[i][1]);
-
-	len += sprintf(buf + len, "\n");
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
-			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
-
-static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
-		       ad7192_show_scale_available, NULL, 0);
-
 static ssize_t ad7192_show_ac_excitation(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -457,9 +381,6 @@ static IIO_DEVICE_ATTR(ac_excitation_en, S_IRUGO | S_IWUSR,
 		       AD7192_REG_MODE);
 
 static struct attribute *ad7192_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
-	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
@@ -470,9 +391,6 @@ static const struct attribute_group ad7192_attribute_group = {
 };
 
 static struct attribute *ad7195_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
-	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	NULL
 };
@@ -502,8 +420,8 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			mutex_lock(&indio_dev->mlock);
-			*val = st->scale_avail[AD7192_CONF_GAIN(st->conf)][0];
-			*val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf)][1];
+			*val = st->scale_avail[AD7192_CONF_GAIN(st->conf) * 2 + 0];
+			*val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf) * 2 + 1];
 			mutex_unlock(&indio_dev->mlock);
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_TEMP:
@@ -522,11 +440,34 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 		if (chan->type == IIO_TEMP)
 			*val -= 273 * ad7192_get_temp_scale(unipolar);
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val =  st->mclk /
+			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode));
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
 }
 
+static int ad7192_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals,
+			     int *type,
+			     int *length,
+			     long mask_el)
+{
+	struct ad7192_state *st = iio_priv(indio_dev);
+
+	switch (mask_el) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = st->scale_avail;
+		*length = ARRAY_SIZE(st->scale_avail);
+		*type = IIO_VAL_INT;
+		break;
+	}
+	return -EINVAL;
+}
+
 static int ad7192_write_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int val,
@@ -534,7 +475,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 			       long mask)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
-	int ret, i;
+	int ret, i, div;
 	unsigned int tmp;
 
 	mutex_lock(&indio_dev->mlock);
@@ -546,8 +487,8 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		ret = -EINVAL;
-		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
-			if (val2 == st->scale_avail[i][1]) {
+		for (i = 0; i < ARRAY_SIZE(st->scale_avail) / 2; i++)
+			if (val2 == st->scale_avail[i * 2 + 1]) {
 				ret = 0;
 				tmp = st->conf;
 				st->conf &= ~AD7192_CONF_GAIN(-1);
@@ -560,6 +501,23 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 				break;
 			}
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2 != 0) {
+			ret = -EINVAL;
+			break;
+		}
+		div = st->mclk / (val * st->f_order * 1024);
+		if (div < 1 || div > 1023) {
+			ret = -EINVAL;
+			break;
+		}
+
+		st->mode &= ~AD7192_MODE_RATE(-1);
+		st->mode |= AD7192_MODE_RATE(div);
+		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		ret = 0;
+		break;
+		
 	default:
 		ret = -EINVAL;
 	}
@@ -578,6 +536,7 @@ static int ad7192_write_raw_get_fmt(struct iio_dev *indio_dev,
 
 static const struct iio_info ad7192_info = {
 	.read_raw = &ad7192_read_raw,
+	.read_avail = &ad7192_read_avail,
 	.write_raw = &ad7192_write_raw,
 	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
 	.attrs = &ad7192_attribute_group,
@@ -587,6 +546,7 @@ static const struct iio_info ad7192_info = {
 
 static const struct iio_info ad7195_info = {
 	.read_raw = &ad7192_read_raw,
+	.read_avail = &ad7192_read_avail,
 	.write_raw = &ad7192_write_raw,
 	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
 	.attrs = &ad7195_attribute_group,
@@ -595,14 +555,22 @@ static const struct iio_info ad7195_info = {
 };
 
 static const struct iio_chan_spec ad7192_channels[] = {
-	AD_SD_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M, 24, 32, 0, 0, 0, 0),
-	AD_SD_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M, 24, 32, 0, 0, 0, 0),
-	AD_SD_TEMP_CHANNEL(2, AD7192_CH_TEMP, 24, 32, 0, 0, 0, 0),
-	AD_SD_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M, 24, 32, 0, 0, 0, 0),
-	AD_SD_CHANNEL(4, 1, AD7192_CH_AIN1, 24, 32, 0, 0, 0, 0),
-	AD_SD_CHANNEL(5, 2, AD7192_CH_AIN2, 24, 32, 0, 0, 0, 0),
-	AD_SD_CHANNEL(6, 3, AD7192_CH_AIN3, 24, 32, 0, 0, 0, 0),
-	AD_SD_CHANNEL(7, 4, AD7192_CH_AIN4, 24, 32, 0, 0, 0, 0),
+	AD_SD_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M, 24, 32, 0,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, BIT(IIO_CHAN_INFO_SCALE)),
+	AD_SD_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M, 24, 32, 0, 
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, BIT(IIO_CHAN_INFO_SCALE)),
+	AD_SD_TEMP_CHANNEL(2, AD7192_CH_TEMP, 24, 32, 0,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0),
+	AD_SD_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M, 24, 32, 0,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, BIT(IIO_CHAN_INFO_SCALE)),
+	AD_SD_CHANNEL(4, 1, AD7192_CH_AIN1, 24, 32, 0,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, BIT(IIO_CHAN_INFO_SCALE)),
+	AD_SD_CHANNEL(5, 2, AD7192_CH_AIN2, 24, 32, 0,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, BIT(IIO_CHAN_INFO_SCALE)),
+	AD_SD_CHANNEL(6, 3, AD7192_CH_AIN3, 24, 32, 0,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, BIT(IIO_CHAN_INFO_SCALE)),
+	AD_SD_CHANNEL(7, 4, AD7192_CH_AIN4, 24, 32, 0,
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, BIT(IIO_CHAN_INFO_SCALE)),
 	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
-- 
1.8.4.2

