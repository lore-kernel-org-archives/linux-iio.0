Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43098 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbaFVT6U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 22 Jun 2014 15:58:20 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: kristina.martsenko@gmail.com, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/7] iio: gyro: adis16136 switch sampling frequency attr to core support.
Date: Sun, 22 Jun 2014 20:59:43 +0100
Message-Id: <1403467186-26639-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1403467186-26639-1-git-send-email-jic23@kernel.org>
References: <1403467186-26639-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

By using the info_mask_shared_by_all element of the channel spec, acce
to the sampling frequency becomes available to in kernel users of the
driver.  It also shortens and simplifies the code.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/gyro/adis16136.c | 58 ++++++--------------------------------------
 1 file changed, 8 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 591bd55..4ed96d0 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -197,45 +197,6 @@ static int adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
 	return 0;
 }
 
-static ssize_t adis16136_write_frequency(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adis16136 *adis16136 = iio_priv(indio_dev);
-	unsigned int val;
-	int ret;
-
-	ret = kstrtouint(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	if (val == 0)
-		return -EINVAL;
-
-	ret = adis16136_set_freq(adis16136, val);
-
-	return ret ? ret : len;
-}
-
-static ssize_t adis16136_read_frequency(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct adis16136 *adis16136 = iio_priv(indio_dev);
-	unsigned int freq;
-	int ret;
-
-	ret = adis16136_get_freq(adis16136, &freq);
-	if (ret < 0)
-		return ret;
-
-	return sprintf(buf, "%d\n", freq);
-}
-
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-				  adis16136_read_frequency,
-				  adis16136_write_frequency);
-
 static const unsigned adis16136_3db_divisors[] = {
 	[0] = 2, /* Special case */
 	[1] = 6,
@@ -324,6 +285,8 @@ static int adis16136_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		return adis16136_get_filter(indio_dev, val);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return adis16136_get_freq(adis16136, val);
 	default:
 		return -EINVAL;
 	}
@@ -340,6 +303,10 @@ static int adis16136_write_raw(struct iio_dev *indio_dev,
 			ADIS16136_REG_GYRO_OFF2, val);
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		return adis16136_set_filter(indio_dev, val);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0 || val2 != 0)
+			return -EINVAL;
+		return adis16136_set_freq(adis16136, val);
 	default:
 		break;
 	}
@@ -361,7 +328,7 @@ static const struct iio_chan_spec adis16136_channels[] = {
 			BIT(IIO_CHAN_INFO_CALIBBIAS) |
 			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
-
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = ADIS16136_REG_GYRO_OUT2,
 		.scan_index = ADIS16136_SCAN_GYRO,
 		.scan_type = {
@@ -376,6 +343,7 @@ static const struct iio_chan_spec adis16136_channels[] = {
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = ADIS16136_REG_TEMP_OUT,
 		.scan_index = ADIS16136_SCAN_TEMP,
 		.scan_type = {
@@ -388,18 +356,8 @@ static const struct iio_chan_spec adis16136_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
-static struct attribute *adis16136_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group adis16136_attribute_group = {
-	.attrs = adis16136_attributes,
-};
-
 static const struct iio_info adis16136_info = {
 	.driver_module = THIS_MODULE,
-	.attrs = &adis16136_attribute_group,
 	.read_raw = &adis16136_read_raw,
 	.write_raw = &adis16136_write_raw,
 	.update_scan_mode = adis_update_scan_mode,
-- 
2.0.0

