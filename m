Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50317 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab3KQOOL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:11 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/11] iio:adc:ad7793: use samp_freq element of info_mask_shared_by_all.
Date: Sun, 17 Nov 2013 15:14:58 +0000
Message-Id: <1384701302-26564-8-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This replaces the previous use of a custom attribute to create the same
interface.  One big advantage is that this allows in kernel access.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/ad7793.c | 124 +++++++++++++++++------------------------------
 1 file changed, 45 insertions(+), 79 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 0af42b693eb4..9fd85b0032a6 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -348,60 +348,7 @@ static const u16 ad7793_sample_freq_avail[16] = {0, 470, 242, 123, 62, 50, 39,
 static const u16 ad7797_sample_freq_avail[16] = {0, 0, 0, 123, 62, 50, 0,
 					33, 0, 17, 16, 12, 10, 8, 6, 4};
 
-static ssize_t ad7793_read_frequency(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7793_state *st = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n",
-	       st->chip_info->sample_freq_avail[AD7793_MODE_RATE(st->mode)]);
-}
-
-static ssize_t ad7793_write_frequency(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7793_state *st = iio_priv(indio_dev);
-	long lval;
-	int i, ret;
-
-	mutex_lock(&indio_dev->mlock);
-	if (iio_buffer_enabled(indio_dev)) {
-		mutex_unlock(&indio_dev->mlock);
-		return -EBUSY;
-	}
-	mutex_unlock(&indio_dev->mlock);
 
-	ret = kstrtol(buf, 10, &lval);
-	if (ret)
-		return ret;
-
-	if (lval == 0)
-		return -EINVAL;
-
-	ret = -EINVAL;
-
-	for (i = 0; i < 16; i++)
-		if (lval == st->chip_info->sample_freq_avail[i]) {
-			mutex_lock(&indio_dev->mlock);
-			st->mode &= ~AD7793_MODE_RATE(-1);
-			st->mode |= AD7793_MODE_RATE(i);
-			ad_sd_write_reg(&st->sd, AD7793_REG_MODE,
-					 sizeof(st->mode), st->mode);
-			mutex_unlock(&indio_dev->mlock);
-			ret = 0;
-		}
-
-	return ret ? ret : len;
-}
-
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		ad7793_read_frequency,
-		ad7793_write_frequency);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 	"470 242 123 62 50 39 33 19 17 16 12 10 8 6 4");
@@ -430,7 +377,6 @@ static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available,
 		ad7793_show_scale_available, NULL, 0);
 
 static struct attribute *ad7793_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
 	NULL
@@ -441,7 +387,6 @@ static const struct attribute_group ad7793_attribute_group = {
 };
 
 static struct attribute *ad7797_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available_ad7797.dev_attr.attr,
 	NULL
 };
@@ -512,6 +457,10 @@ static int ad7793_read_raw(struct iio_dev *indio_dev,
 			*val -= offset;
 		}
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->chip_info->
+			sample_freq_avail[AD7793_MODE_RATE(st->mode)];
+		return IIO_VAL_INT;
 	}
 	return -EINVAL;
 }
@@ -551,6 +500,20 @@ static int ad7793_write_raw(struct iio_dev *indio_dev,
 				break;
 			}
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val == 0)
+			return -EINVAL;
+
+		ret = -EINVAL;
+		for (i = 0; i < 16; i++)
+			if (val == st->chip_info->sample_freq_avail[i]) {
+				st->mode &= ~AD7793_MODE_RATE(-1);
+				st->mode |= AD7793_MODE_RATE(i);
+				ad_sd_write_reg(&st->sd, AD7793_REG_MODE,
+						sizeof(st->mode), st->mode);
+				ret = 0;
+			}
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -587,65 +550,68 @@ static const struct iio_info ad7797_info = {
 #define DECLARE_AD7793_CHANNELS(_name, _b, _sb, _s) \
 const struct iio_chan_spec _name##_channels[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), (_s), \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), (_s), \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), (_s), \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), (_s), \
-	0, 0, 0), \
-	AD_SD_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s), 0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	AD_SD_TEMP_CHANNEL(4, AD7793_CH_TEMP, (_b), (_sb), (_s), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_SUPPLY_CHANNEL(5, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), (_s), \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(6), \
 }
 
 #define DECLARE_AD7795_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_DIFF_CHANNEL(3, 3, 3, AD7795_CH_AIN4P_AIN4M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_DIFF_CHANNEL(4, 4, 4, AD7795_CH_AIN5P_AIN5M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_DIFF_CHANNEL(5, 5, 5, AD7795_CH_AIN6P_AIN6M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_SHORTED_CHANNEL(6, 0, AD7795_CH_AIN1M_AIN1M, (_b), (_sb), 0, \
-	0, 0, 0), \
-	AD_SD_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0, 0, 0, 0),	\
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	AD_SD_TEMP_CHANNEL(7, AD7793_CH_TEMP, (_b), (_sb), 0, \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0),	\
 	AD_SD_SUPPLY_CHANNEL(8, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(9), \
 }
 
 #define DECLARE_AD7797_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_SHORTED_CHANNEL(1, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0, \
-	0, 0, 0), \
-	AD_SD_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0, 0, 0, 0),	\
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
+	AD_SD_TEMP_CHANNEL(2, AD7793_CH_TEMP, (_b), (_sb), 0, \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0),	\
 	AD_SD_SUPPLY_CHANNEL(3, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
 #define DECLARE_AD7799_CHANNELS(_name, _b, _sb) \
 const struct iio_chan_spec _name##_channels[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7793_CH_AIN1P_AIN1M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_DIFF_CHANNEL(1, 1, 1, AD7793_CH_AIN2P_AIN2M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_DIFF_CHANNEL(2, 2, 2, AD7793_CH_AIN3P_AIN3M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_SHORTED_CHANNEL(3, 0, AD7793_CH_AIN1M_AIN1M, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	AD_SD_SUPPLY_CHANNEL(4, 3, AD7793_CH_AVDD_MONITOR, (_b), (_sb), 0, \
-	0, 0, 0), \
+	BIT(IIO_CHAN_INFO_SAMP_FREQ), 0, 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(5), \
 }
 
-- 
1.8.4.2

