Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41668 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbaDEQoO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Apr 2014 12:44:14 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, sr@denx.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/6] staging:iio:adc:spear_adc use info_mask_shared_by_all for samp freq
Date: Sat,  5 Apr 2014 17:45:12 +0100
Message-Id: <1396716315-2465-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1396716315-2465-1-git-send-email-jic23@kernel.org>
References: <1396716315-2465-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using the core support makes this element available to in kernel users as
well as to userspace under exactly the same interface as before.  The
intent is to move all sampling frequency control to this approach
throughout IIO.

Drop unused clk_high and clk_low whilst we are at it.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Stefan Roese <sr@denx.de>
---
 drivers/staging/iio/adc/spear_adc.c | 92 +++++++++++++------------------------
 1 file changed, 33 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index c4e928b..44a129f 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -168,16 +168,48 @@ static int spear_read_raw(struct iio_dev *indio_dev,
 		*val = info->vref_external;
 		*val2 = SPEAR_ADC_DATA_BITS;
 		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = info->current_clk;
+		return IIO_VAL_INT;
 	}
 
 	return -EINVAL;
 }
 
+static int spear_adc_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	struct spear_adc_info *info = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	mutex_lock(&indio_dev->mlock);
+
+	if ((val < SPEAR_ADC_CLK_MIN) ||
+		(val > SPEAR_ADC_CLK_MAX) ||
+		(val2 != 0)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	spear_adc_set_clk(info, val);
+
+out:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
+}
+
 #define SPEAR_ADC_CHAN(idx) {				\
 	.type = IIO_VOLTAGE,				\
 	.indexed = 1,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 	.channel = idx,					\
 }
 
@@ -219,67 +251,9 @@ static int spear_adc_configure(struct spear_adc_info *info)
 	return 0;
 }
 
-static ssize_t spear_adc_read_frequency(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct spear_adc_info *info = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n", info->current_clk);
-}
-
-static ssize_t spear_adc_write_frequency(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf,
-					 size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct spear_adc_info *info = iio_priv(indio_dev);
-	u32 clk_high, clk_low, count;
-	u32 apb_clk = clk_get_rate(info->clk);
-	unsigned long lval;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &lval);
-	if (ret)
-		return ret;
-
-	mutex_lock(&indio_dev->mlock);
-
-	if ((lval < SPEAR_ADC_CLK_MIN) || (lval > SPEAR_ADC_CLK_MAX)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	count = (apb_clk + lval - 1) / lval;
-	clk_low = count / 2;
-	clk_high = count - clk_low;
-	info->current_clk = apb_clk / count;
-	spear_adc_set_clk(info, lval);
-
-out:
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret ? ret : len;
-}
-
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-			      spear_adc_read_frequency,
-			      spear_adc_write_frequency);
-
-static struct attribute *spear_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group spear_attribute_group = {
-	.attrs = spear_attributes,
-};
-
 static const struct iio_info spear_adc_iio_info = {
 	.read_raw = &spear_read_raw,
-	.attrs = &spear_attribute_group,
+	.write_raw = &spear_adc_write_raw,
 	.driver_module = THIS_MODULE,
 };
 
-- 
1.9.0

