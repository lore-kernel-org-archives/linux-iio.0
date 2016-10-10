Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33275 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbcJJKBt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2016 06:01:49 -0400
Received: by mail-pa0-f67.google.com with SMTP id hh10so6916061pac.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Oct 2016 03:01:49 -0700 (PDT)
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v2] staging: iio: cdc: ad7746: implement IIO_CHAN_INFO_SAMP_FREQ
Date: Mon, 10 Oct 2016 18:01:31 +0800
Message-Id: <1476093691-10720-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver predates the availability of IIO_CHAN_INFO_SAMP_FREQ
attribute wherein usage has some advantages like it can be accessed by
in-kernel consumers as well as reduces the code size.

Therefore, use IIO_CHAN_INFO_SAMP_FREQ to implement the
sampling_frequency attribute instead of using IIO_DEVICE_ATTR() macro.

Move code from the functions associated with IIO_DEVICE_ATTR() into
respective read and write hooks with the mask set to
IIO_CHAN_INFO_SAMP_FREQ.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
Change in v2:
* Re-use and modify the store functions to serve as write_raw handlers
  for the sampling_frequency attribute

 drivers/staging/iio/cdc/ad7746.c | 120 ++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 5771d4ee..f41251c 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -122,7 +122,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.indexed = 1,
 		.channel = 0,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_EXT_VIN,
 	},
@@ -132,7 +133,8 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.channel = 1,
 		.extend_name = "supply",
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = AD7746_REG_VT_DATA_HIGH << 8 |
 			AD7746_VTSETUP_VTMD_VDD_MON,
 	},
@@ -159,7 +161,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
-		BIT(IIO_CHAN_INFO_SCALE),
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = AD7746_REG_CAP_DATA_HIGH << 8,
 	},
 	[CIN1_DIFF] = {
@@ -171,7 +173,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
-		BIT(IIO_CHAN_INFO_SCALE),
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CAPDIFF
 	},
@@ -182,7 +184,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
-		BIT(IIO_CHAN_INFO_SCALE),
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CIN2,
 	},
@@ -195,7 +197,7 @@ static const struct iio_chan_spec ad7746_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 		BIT(IIO_CHAN_INFO_CALIBSCALE) | BIT(IIO_CHAN_INFO_OFFSET),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS) |
-		BIT(IIO_CHAN_INFO_SCALE),
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
 			AD7746_CAPSETUP_CAPDIFF | AD7746_CAPSETUP_CIN2,
 	}
@@ -355,101 +357,47 @@ static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
 static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
 		       S_IWUSR, NULL, ad7746_start_gain_calib, VIN);
 
-static ssize_t ad7746_show_cap_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *chip,
+					      int val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n", ad7746_cap_filter_rate_table[
-			(chip->config >> 3) & 0x7][0]);
-}
-
-static ssize_t ad7746_store_cap_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	u8 data;
-	int ret, i;
-
-	ret = kstrtou8(buf, 10, &data);
-	if (ret < 0)
-		return ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ad7746_cap_filter_rate_table); i++)
-		if (data >= ad7746_cap_filter_rate_table[i][0])
+		if (val >= ad7746_cap_filter_rate_table[i][0])
 			break;
 
 	if (i >= ARRAY_SIZE(ad7746_cap_filter_rate_table))
 		i = ARRAY_SIZE(ad7746_cap_filter_rate_table) - 1;
 
-	mutex_lock(&indio_dev->mlock);
 	chip->config &= ~AD7746_CONF_CAPFS(0x7);
 	chip->config |= AD7746_CONF_CAPFS(i);
-	mutex_unlock(&indio_dev->mlock);
 
-	return len;
+	return 0;
 }
 
-static ssize_t ad7746_show_vt_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int ad7746_store_vt_filter_rate_setup(struct ad7746_chip_info *chip,
+					     int val)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n", ad7746_vt_filter_rate_table[
-			(chip->config >> 6) & 0x3][0]);
-}
-
-static ssize_t ad7746_store_vt_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	u8 data;
-	int ret, i;
-
-	ret = kstrtou8(buf, 10, &data);
-	if (ret < 0)
-		return ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ad7746_vt_filter_rate_table); i++)
-		if (data >= ad7746_vt_filter_rate_table[i][0])
+		if (val >= ad7746_vt_filter_rate_table[i][0])
 			break;
 
 	if (i >= ARRAY_SIZE(ad7746_vt_filter_rate_table))
 		i = ARRAY_SIZE(ad7746_vt_filter_rate_table) - 1;
 
-	mutex_lock(&indio_dev->mlock);
 	chip->config &= ~AD7746_CONF_VTFS(0x3);
 	chip->config |= AD7746_CONF_VTFS(i);
-	mutex_unlock(&indio_dev->mlock);
 
-	return len;
+	return 0;
 }
 
-static IIO_DEVICE_ATTR(in_capacitance_sampling_frequency,
-		       S_IRUGO | S_IWUSR, ad7746_show_cap_filter_rate_setup,
-			ad7746_store_cap_filter_rate_setup, 0);
-
-static IIO_DEVICE_ATTR(in_voltage_sampling_frequency,
-		       S_IRUGO | S_IWUSR, ad7746_show_vt_filter_rate_setup,
-		       ad7746_store_vt_filter_rate_setup, 0);
-
 static IIO_CONST_ATTR(in_voltage_sampling_frequency_available, "50 31 16 8");
 static IIO_CONST_ATTR(in_capacitance_sampling_frequency_available,
 		       "91 84 50 26 16 13 11 9");
 
 static struct attribute *ad7746_attributes[] = {
-	&iio_dev_attr_in_capacitance_sampling_frequency.dev_attr.attr,
-	&iio_dev_attr_in_voltage_sampling_frequency.dev_attr.attr,
 	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
 	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
@@ -547,6 +495,23 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 
 		ret = 0;
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		switch (chan->type) {
+		case IIO_CAPACITANCE:
+			ret = ad7746_store_cap_filter_rate_setup(chip, val);
+			break;
+		case IIO_VOLTAGE:
+			ret = ad7746_store_vt_filter_rate_setup(chip, val);
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -667,6 +632,21 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
 		}
 
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_CAPACITANCE:
+			*val = ad7746_cap_filter_rate_table[
+					(chip->config >> 3) & 0x7][0];
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_VOLTAGE:
+			*val = ad7746_vt_filter_rate_table[
+					(chip->config >> 6) & 0x3][0];
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.7.4

