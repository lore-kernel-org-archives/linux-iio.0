Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:34264 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbdI3BJb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Sep 2017 21:09:31 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 2/3] staging: iio: tsl2x7x: migrate in_illuminance0_integration_time sysfs attribute to iio_chan_spec
Date: Fri, 29 Sep 2017 21:09:20 -0400
Message-Id: <20170930010921.15447-3-masneyb@onstation.org>
In-Reply-To: <20170930010921.15447-1-masneyb@onstation.org>
References: <20170930010921.15447-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver explicitly creates the in_illuminance0_integration_time sysfs
attribute outside the IIO core. This attribute is available in the IIO
core so this patches migrates the attribute to be created by
the iio_chan_spec.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1 (Jul 9 2017):
- Use MIN_ITIME instead of hardcoded 3 in tsl2x7x_write_raw()

 drivers/staging/iio/light/tsl2x7x.c | 65 ++++++++++---------------------------
 1 file changed, 17 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index e340ea624e5c..e6a71f5fc9cb 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -898,45 +898,6 @@ static ssize_t in_proximity0_calibscale_available_show(struct device *dev,
 		return snprintf(buf, PAGE_SIZE, "%s\n", "1 2 4 8");
 }
 
-static ssize_t in_illuminance0_integration_time_show(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
-{
-	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
-	int y, z;
-
-	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->settings.als_time) + 1;
-	z = y * TSL2X7X_MIN_ITIME;
-	y /= 1000;
-	z %= 1000;
-
-	return snprintf(buf, PAGE_SIZE, "%d.%03d\n", y, z);
-}
-
-static ssize_t in_illuminance0_integration_time_store(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
-	struct tsl2x7x_parse_result result;
-	int ret;
-
-	ret = iio_str_to_fixpoint(buf, 100, &result.integer, &result.fract);
-	if (ret)
-		return ret;
-
-	result.fract /= 3;
-	chip->settings.als_time = TSL2X7X_MAX_TIMER_CNT - (u8)result.fract;
-
-	dev_info(&chip->client->dev, "%s: als time = %d",
-		 __func__, chip->settings.als_time);
-
-	tsl2x7x_invoke_change(indio_dev);
-
-	return IIO_VAL_INT_PLUS_MICRO;
-}
-
 static IIO_CONST_ATTR(in_illuminance0_integration_time_available,
 		".00272 - .696");
 
@@ -1377,7 +1338,11 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 		*val = chip->settings.als_gain_trim;
 		ret = IIO_VAL_INT;
 		break;
-
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = (TSL2X7X_MAX_TIMER_CNT - chip->settings.als_time) + 1;
+		*val2 = ((*val * TSL2X7X_MIN_ITIME) % 1000) / 1000;
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -1453,7 +1418,13 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		chip->settings.als_gain_trim = val;
 		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		chip->settings.als_time =
+			TSL2X7X_MAX_TIMER_CNT - (val2 / TSL2X7X_MIN_ITIME);
 
+		dev_info(&chip->client->dev, "%s: als time = %d",
+			 __func__, chip->settings.als_time);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1465,8 +1436,6 @@ static DEVICE_ATTR_RO(in_proximity0_calibscale_available);
 
 static DEVICE_ATTR_RO(in_illuminance0_calibscale_available);
 
-static DEVICE_ATTR_RW(in_illuminance0_integration_time);
-
 static DEVICE_ATTR_RW(in_illuminance0_target_input);
 
 static DEVICE_ATTR_WO(in_illuminance0_calibrate);
@@ -1546,7 +1515,6 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 
 static struct attribute *tsl2x7x_ALS_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&dev_attr_in_illuminance0_integration_time.attr,
 	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1561,7 +1529,6 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&dev_attr_in_illuminance0_integration_time.attr,
 	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1578,7 +1545,6 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
 	&dev_attr_in_illuminance0_calibscale_available.attr,
-	&dev_attr_in_illuminance0_integration_time.attr,
 	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
@@ -1711,7 +1677,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+					      BIT(IIO_CHAN_INFO_INT_TIME),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
@@ -1750,7 +1717,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED)
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+					      BIT(IIO_CHAN_INFO_INT_TIME),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
@@ -1798,7 +1766,8 @@ static const struct tsl2x7x_chip_info tsl2x7x_chip_info_tbl[] = {
 			.type = IIO_LIGHT,
 			.indexed = 1,
 			.channel = 0,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+					      BIT(IIO_CHAN_INFO_INT_TIME),
 			}, {
 			.type = IIO_INTENSITY,
 			.indexed = 1,
-- 
2.13.5

