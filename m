Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50318 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab3KQOOL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:11 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 08/11] iio:adc:ad7793: Use the read_avail callback to provide the scale and sampling frequency interfaces.
Date: Sun, 17 Nov 2013 15:14:59 +0000
Message-Id: <1384701302-26564-9-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is preferred over the previous approach of custom attributes as
it allows in kernel access to these values.  This is useful for consumers
of IIO channels.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/ad7793.c | 178 ++++++++++++++++++++++++++---------------------
 1 file changed, 97 insertions(+), 81 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 9fd85b0032a6..a0ea25876059 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -157,8 +157,7 @@ struct ad7793_state {
 	u16				int_vref_mv;
 	u16				mode;
 	u16				conf;
-	u32				scale_avail[8][2];
-
+	int				scale_avail[16];
 	struct ad_sigma_delta		sd;
 
 };
@@ -326,14 +325,14 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 		goto out;
 
 	/* Populate available ADC input ranges */
-	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
+	for (i = 0; i < ARRAY_SIZE(st->scale_avail) / 2; i++) {
 		scale_uv = ((u64)vref_mv * 100000000)
 			>> (st->chip_info->channels[0].scan_type.realbits -
 			(!!(st->conf & AD7793_CONF_UNIPOLAR) ? 0 : 1));
 		scale_uv >>= i;
 
-		st->scale_avail[i][1] = do_div(scale_uv, 100000000) * 10;
-		st->scale_avail[i][0] = scale_uv;
+		st->scale_avail[i * 2 + 1] = do_div(scale_uv, 100000000) * 10;
+		st->scale_avail[i * 2 + 0] = scale_uv;
 	}
 
 	return 0;
@@ -345,55 +344,16 @@ out:
 static const u16 ad7793_sample_freq_avail[16] = {0, 470, 242, 123, 62, 50, 39,
 					33, 19, 17, 16, 12, 10, 8, 6, 4};
 
+static const int ad7793_sample_freq_avail_packed[] = { 470, 242, 123, 62,
+						       50, 39, 33, 19,
+						       17, 16, 12, 10,
+						       8, 6, 4};
+
 static const u16 ad7797_sample_freq_avail[16] = {0, 0, 0, 123, 62, 50, 0,
 					33, 0, 17, 16, 12, 10, 8, 6, 4};
 
-
-
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
-	"470 242 123 62 50 39 33 19 17 16 12 10 8 6 4");
-
-static IIO_CONST_ATTR_NAMED(sampling_frequency_available_ad7797,
-	sampling_frequency_available, "123 62 50 33 17 16 12 10 8 6 4");
-
-static ssize_t ad7793_show_scale_available(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7793_state *st = iio_priv(indio_dev);
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
-static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available,
-		in_voltage-voltage_scale_available, S_IRUGO,
-		ad7793_show_scale_available, NULL, 0);
-
-static struct attribute *ad7793_attributes[] = {
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group ad7793_attribute_group = {
-	.attrs = ad7793_attributes,
-};
-
-static struct attribute *ad7797_attributes[] = {
-	&iio_const_attr_sampling_frequency_available_ad7797.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group ad7797_attribute_group = {
-	.attrs = ad7797_attributes,
-};
+static const int ad7797_sample_freq_avail_packed[] = {123, 62, 50,
+					33, 17, 16, 12, 10, 8, 6, 4};
 
 static int ad7793_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
@@ -419,9 +379,9 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 		case IIO_VOLTAGE:
 			if (chan->differential) {
 				*val = st->
-					scale_avail[(st->conf >> 8) & 0x7][0];
+					scale_avail[((st->conf >> 8) & 0x7) * 2 + 0];
 				*val2 = st->
-					scale_avail[(st->conf >> 8) & 0x7][1];
+					scale_avail[((st->conf >> 8) & 0x7) * 2 + 1];
 				return IIO_VAL_INT_PLUS_NANO;
 			} else {
 				/* 1170mV / 2^23 * 6 */
@@ -484,8 +444,8 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		ret = -EINVAL;
-		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
-			if (val2 == st->scale_avail[i][1]) {
+		for (i = 0; i < ARRAY_SIZE(st->scale_avail) / 2; i++)
+			if (val2 == st->scale_avail[i * 2 + 1]) {
 				ret = 0;
 				tmp = st->conf;
 				st->conf &= ~AD7793_CONF_GAIN(-1);
@@ -529,20 +489,63 @@ static int ad7793_write_raw_get_fmt(struct iio_dev *indio_dev,
 	return IIO_VAL_INT_PLUS_NANO;
 }
 
+static int ad7793_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals,
+			     int *type,
+			     int *length,
+			     long mask_el)
+{
+	struct ad7793_state *st = iio_priv(indio_dev);
+
+	switch (mask_el) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = ARRAY_SIZE(ad7793_sample_freq_avail_packed);
+		*vals =  ad7793_sample_freq_avail_packed;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*length = 16;
+		*vals = st->scale_avail;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7797_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals,
+			     int *type,
+			     int *length,
+			     long mask_el)
+{
+	switch (mask_el) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = ARRAY_SIZE(ad7797_sample_freq_avail_packed);
+		*vals =  ad7797_sample_freq_avail_packed;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ad7793_info = {
 	.read_raw = &ad7793_read_raw,
+	.read_avail = &ad7793_read_avail,
 	.write_raw = &ad7793_write_raw,
 	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
-	.attrs = &ad7793_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad7797_info = {
 	.read_raw = &ad7793_read_raw,
+	.read_avail = &ad7797_read_avail,
 	.write_raw = &ad7793_write_raw,
 	.write_raw_get_fmt = &ad7793_write_raw_get_fmt,
-	.attrs = &ad7793_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 	.driver_module = THIS_MODULE,
 };
@@ -550,68 +553,81 @@ static const struct iio_info ad7797_info = {
 #define DECLARE_AD7793_CHANNELS(_name, _b, _sb, _s) \
 const struct iio_chan_spec _name##_channels[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), (_s), \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), (_s), \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), (_s), \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), (_s), \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	AD_SD_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s), \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	AD_SD_SUPPLY_CHANNEL(5, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), (_s), \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(6), \
 }
 
 #define DECLARE_AD7795_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_DIFF_CHANNEL(3, 3, 3, AD7795_CH_AIN4P_AIN4M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_DIFF_CHANNEL(4, 4, 4, AD7795_CH_AIN5P_AIN5M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_DIFF_CHANNEL(5, 5, 5, AD7795_CH_AIN6P_AIN6M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_SHORTED_CHANNEL(6, 0, AD7795_CH_AIN1M_AIN1M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	AD_SD_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0),	\
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0),	\
 	AD_SD_SUPPLY_CHANNEL(8, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(9), \
 }
 
+/* AD7797 is the only device not to provide scale_available */
 #define DECLARE_AD7797_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	AD_SD_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	AD_SD_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0),	\
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0),	\
 	AD_SD_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
 #define DECLARE_AD7799_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SCALE)), \
 	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	AD_SD_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0, \
-	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(5), \
 }
 
-- 
1.8.4.2

