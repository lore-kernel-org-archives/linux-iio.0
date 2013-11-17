Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50319 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab3KQOOM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:12 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 09/11] iio:adc:ad7791 Provide sampling frequency and scale_available access via core.
Date: Sun, 17 Nov 2013 15:15:00 +0000
Message-Id: <1384701302-26564-10-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Doing it this way instead of using custom attributes makes these elements
accessible to in kernel consumers of the IIO channels.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/ad7791.c | 106 ++++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index a5abc1c2453e..a01c0bb8aa0d 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -68,23 +68,30 @@
 #define DECLARE_AD7787_CHANNELS(name, bits, storagebits) \
 const struct iio_chan_spec name[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
-		(bits), (storagebits), 0, 0, 0, 0), \
-	AD_SD_CHANNEL(1, 1, AD7791_CH_AIN2, (bits), (storagebits), 0, 0, 0, 0), \
+		(bits), (storagebits), 0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
+	AD_SD_CHANNEL(1, 1, AD7791_CH_AIN2, (bits), (storagebits), 0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	AD_SD_SHORTED_CHANNEL(2, 0, AD7791_CH_AIN1N_AIN1N, \
-		(bits), (storagebits), 0, 0, 0, 0), \
+		(bits), (storagebits), 0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	AD_SD_SUPPLY_CHANNEL(3, 2, AD7791_CH_AVDD_MONITOR,  \
-		(bits), (storagebits), 0, 0, 0, 0), \
+		(bits), (storagebits), 0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(4), \
 }
 
 #define DECLARE_AD7791_CHANNELS(name, bits, storagebits) \
 const struct iio_chan_spec name[] = { \
 	AD_SD_DIFF_CHANNEL(0, 0, 0, AD7791_CH_AIN1P_AIN1N, \
-		(bits), (storagebits), 0, 0, 0, 0), \
+		(bits), (storagebits), 0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	AD_SD_SHORTED_CHANNEL(1, 0, AD7791_CH_AIN1N_AIN1N, \
-		(bits), (storagebits), 0, 0, 0, 0), \
+		(bits), (storagebits), 0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	AD_SD_SUPPLY_CHANNEL(2, 1, AD7791_CH_AVDD_MONITOR, \
-		(bits), (storagebits), 0, 0, 0, 0), \
+		(bits), (storagebits), 0, \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ), BIT(IIO_CHAN_INFO_SAMP_FREQ), 0), \
 	IIO_CHAN_SOFT_TIMESTAMP(3), \
 }
 
@@ -197,10 +204,21 @@ static const struct ad_sigma_delta_info ad7791_sigma_delta_info = {
 	.read_mask = BIT(3),
 };
 
+static const int ad7791_samp_freqs[] = {
+       120, 0,
+       100, 0,
+       33, 300000,
+       20, 0,
+       16, 600000,
+       16, 700000,
+       13, 300000,
+       9, 500000 };
+
 static int ad7791_read_raw(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, int *val, int *val2, long info)
 {
 	struct ad7791_state *st = iio_priv(indio_dev);
+	unsigned int rate;
 	bool unipolar = !!(st->mode & AD7791_MODE_UNIPOLAR);
 
 	switch (info) {
@@ -239,36 +257,19 @@ static int ad7791_read_raw(struct iio_dev *indio_dev,
 			*val2 = chan->scan_type.realbits - 1;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		rate = st->filter & AD7791_FILTER_RATE_MASK;
+		*val = ad7791_samp_freqs[2 * rate];
+		*val2 = ad7791_samp_freqs[2 * rate + 1];
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
 	return -EINVAL;
 }
 
-static const char * const ad7791_sample_freq_avail[] = {
-	[AD7791_FILTER_RATE_120] = "120",
-	[AD7791_FILTER_RATE_100] = "100",
-	[AD7791_FILTER_RATE_33_3] = "33.3",
-	[AD7791_FILTER_RATE_20] = "20",
-	[AD7791_FILTER_RATE_16_6] = "16.6",
-	[AD7791_FILTER_RATE_16_7] = "16.7",
-	[AD7791_FILTER_RATE_13_3] = "13.3",
-	[AD7791_FILTER_RATE_9_5] = "9.5",
-};
-
-static ssize_t ad7791_read_frequency(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static int ad7791_write_raw(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, int val, int val2, long info)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7791_state *st = iio_priv(indio_dev);
-	unsigned int rate = st->filter & AD7791_FILTER_RATE_MASK;
-
-	return sprintf(buf, "%s\n", ad7791_sample_freq_avail[rate]);
-}
-
-static ssize_t ad7791_write_frequency(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7791_state *st = iio_priv(indio_dev);
 	int i, ret;
 
@@ -281,9 +282,9 @@ static ssize_t ad7791_write_frequency(struct device *dev,
 
 	ret = -EINVAL;
 
-	for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++) {
-		if (sysfs_streq(ad7791_sample_freq_avail[i], buf)) {
-
+	for (i = 0; i < ARRAY_SIZE(ad7791_samp_freqs) / 2; i++) {
+		if ((val == ad7791_samp_freqs[2 * i]) &&
+		    (val2 == ad7791_samp_freqs[2 * i + 1])) {
 			mutex_lock(&indio_dev->mlock);
 			st->filter &= ~AD7791_FILTER_RATE_MASK;
 			st->filter |= i;
@@ -295,28 +296,31 @@ static ssize_t ad7791_write_frequency(struct device *dev,
 		}
 	}
 
-	return ret ? ret : len;
+	return ret;
 }
 
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		ad7791_read_frequency,
-		ad7791_write_frequency);
-
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("120 100 33.3 20 16.7 16.6 13.3 9.5");
-
-static struct attribute *ad7791_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group ad7791_attribute_group = {
-	.attrs = ad7791_attributes,
-};
+static int ad7791_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals,
+			     int *type,
+			     int *length,
+			     long mask_el)
+{
+	switch (mask_el) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*length = ARRAY_SIZE(ad7791_samp_freqs);
+		*vals =  ad7791_samp_freqs;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
 
 static const struct iio_info ad7791_info = {
 	.read_raw = &ad7791_read_raw,
-	.attrs = &ad7791_attribute_group,
+	.read_avail = &ad7791_read_avail,
+	.write_raw = &ad7791_write_raw,
 	.validate_trigger = ad_sd_validate_trigger,
 	.driver_module = THIS_MODULE,
 };
-- 
1.8.4.2

