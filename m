Return-Path: <eraretuya@gmail.com>
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org,
	outreachy-kernel@googlegroups.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH] staging: iio: cdc: ad7746: implement IIO_CHAN_INFO_SAMP_FREQ
Date: Sat,  8 Oct 2016 22:56:00 +0800
Message-Id: <1475938560-11700-1-git-send-email-eraretuya@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

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
 drivers/staging/iio/cdc/ad7746.c | 169 ++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 98 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 5771d4ee..52c84a3 100644
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
@@ -354,102 +356,11 @@ static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
 		       S_IWUSR, NULL, ad7746_start_gain_calib, CIN2);
 static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
 		       S_IWUSR, NULL, ad7746_start_gain_calib, VIN);
-
-static ssize_t ad7746_show_cap_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
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
-
-	for (i = 0; i < ARRAY_SIZE(ad7746_cap_filter_rate_table); i++)
-		if (data >= ad7746_cap_filter_rate_table[i][0])
-			break;
-
-	if (i >= ARRAY_SIZE(ad7746_cap_filter_rate_table))
-		i = ARRAY_SIZE(ad7746_cap_filter_rate_table) - 1;
-
-	mutex_lock(&indio_dev->mlock);
-	chip->config &= ~AD7746_CONF_CAPFS(0x7);
-	chip->config |= AD7746_CONF_CAPFS(i);
-	mutex_unlock(&indio_dev->mlock);
-
-	return len;
-}
-
-static ssize_t ad7746_show_vt_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
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
-
-	for (i = 0; i < ARRAY_SIZE(ad7746_vt_filter_rate_table); i++)
-		if (data >= ad7746_vt_filter_rate_table[i][0])
-			break;
-
-	if (i >= ARRAY_SIZE(ad7746_vt_filter_rate_table))
-		i = ARRAY_SIZE(ad7746_vt_filter_rate_table) - 1;
-
-	mutex_lock(&indio_dev->mlock);
-	chip->config &= ~AD7746_CONF_VTFS(0x3);
-	chip->config |= AD7746_CONF_VTFS(i);
-	mutex_unlock(&indio_dev->mlock);
-
-	return len;
-}
-
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
@@ -472,7 +383,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	int ret, reg;
+	int ret, reg, i;
 
 	mutex_lock(&indio_dev->mlock);
 
@@ -547,6 +458,51 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 
 		ret = 0;
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_CAPACITANCE:
+			if (val2) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			for (i = 0; i <
+			     ARRAY_SIZE(ad7746_cap_filter_rate_table); i++)
+				if (val >= ad7746_cap_filter_rate_table[i][0])
+					break;
+
+			if (i >= ARRAY_SIZE(ad7746_cap_filter_rate_table))
+				i = ARRAY_SIZE(ad7746_cap_filter_rate_table) -
+					1;
+
+			chip->config &= ~AD7746_CONF_CAPFS(0x7);
+			chip->config |= AD7746_CONF_CAPFS(i);
+
+			break;
+		case IIO_VOLTAGE:
+			if (val2) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			for (i = 0; i <
+			     ARRAY_SIZE(ad7746_vt_filter_rate_table); i++)
+				if (val >= ad7746_vt_filter_rate_table[i][0])
+					break;
+
+			if (i >= ARRAY_SIZE(ad7746_vt_filter_rate_table))
+				i = ARRAY_SIZE(ad7746_vt_filter_rate_table) -
+					1;
+
+			chip->config &= ~AD7746_CONF_VTFS(0x3);
+			chip->config |= AD7746_CONF_VTFS(i);
+
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -667,6 +623,23 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
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
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.7.4
