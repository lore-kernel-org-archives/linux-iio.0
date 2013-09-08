Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37541 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab3IHM5U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 08:57:20 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5/5] iio:temperature:tmp006 put sampling_frequency in info_mask_shared_by_all
Date: Sun,  8 Sep 2013 14:57:21 +0100
Message-Id: <1378648641-28280-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1378648641-28280-1-git-send-email-jic23@kernel.org>
References: <1378648641-28280-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Doing this makes it possible to access this control from within the kernel.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/temperature/tmp006.c | 57 +++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 64ccde3..4e95097 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -70,12 +70,16 @@ static int tmp006_read_measurement(struct tmp006_data *data, u8 reg)
 	return i2c_smbus_read_word_swapped(data->client, reg);
 }
 
+static const int tmp006_freqs[5][2] = { {4, 0}, {2, 0}, {1, 0},
+					{0, 500000}, {0, 250000} };
+
 static int tmp006_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *channel, int *val,
 			    int *val2, long mask)
 {
 	struct tmp006_data *data = iio_priv(indio_dev);
 	s32 ret;
+	int cr;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -106,6 +110,12 @@ static int tmp006_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		cr = (data->config & TMP006_CONFIG_CR_MASK)
+			>> TMP006_CONFIG_CR_SHIFT;
+		*val = tmp006_freqs[cr][0];
+		*val2 = tmp006_freqs[cr][1];
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		break;
 	}
@@ -113,48 +123,32 @@ static int tmp006_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static const char * const tmp006_freqs[] = { "4", "2", "1", "0.5", "0.25" };
-
-static ssize_t tmp006_show_freq(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct tmp006_data *data = iio_priv(dev_to_iio_dev(dev));
-	int cr = (data->config & TMP006_CONFIG_CR_MASK)
-		>> TMP006_CONFIG_CR_SHIFT;
-	return sprintf(buf, "%s\n", tmp006_freqs[cr]);
-}
-
-static ssize_t tmp006_store_freq(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t len)
+static int tmp006_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tmp006_data *data = iio_priv(indio_dev);
 	int i;
-	bool found = false;
 
 	for (i = 0; i < ARRAY_SIZE(tmp006_freqs); i++)
-		if (sysfs_streq(buf, tmp006_freqs[i])) {
-			found = true;
-			break;
-		}
-	if (!found)
-		return -EINVAL;
+		if ((val == tmp006_freqs[i][0]) &&
+		    (val2 == tmp006_freqs[i][1])) {
+			data->config &= ~TMP006_CONFIG_CR_MASK;
+			data->config |= i << TMP006_CONFIG_CR_SHIFT;
 
-	data->config &= ~TMP006_CONFIG_CR_MASK;
-	data->config |= i << TMP006_CONFIG_CR_SHIFT;
+			return i2c_smbus_write_word_swapped(data->client,
+							    TMP006_CONFIG,
+							    data->config);
 
-	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
-		data->config);
+		}
+	return -EINVAL;
 }
 
-static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR,
-			tmp006_show_freq, tmp006_store_freq);
-
 static IIO_CONST_ATTR(sampling_frequency_available, "4 2 1 0.5 0.25");
 
 static struct attribute *tmp006_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
 };
@@ -168,16 +162,19 @@ static const struct iio_chan_spec tmp006_channels[] = {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	}
 };
 
 static const struct iio_info tmp006_info = {
 	.read_raw = tmp006_read_raw,
+	.write_raw = tmp006_write_raw,
 	.attrs = &tmp006_attribute_group,
 	.driver_module = THIS_MODULE,
 };
-- 
1.8.4

