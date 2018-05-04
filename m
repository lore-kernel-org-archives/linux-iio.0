Return-Path: <SRS0=zzH2=HX=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	drew.paterson@ams.com
Subject: [PATCH v2 07/11] staging: iio: tsl2x7x: support 2.72 and 2.73 ALS increments
Date: Thu,  3 May 2018 22:53:15 -0400
Message-Id: <20180504025319.28953-8-masneyb@onstation.org>
In-Reply-To: <20180504025319.28953-1-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The driver assumed that the ALS increment was 2.72 ms, and the upper
range was 696 ms. Some other supported devices use 2.73 ms - 699 ms.
This patch adds support for the multiple ranges.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
I debated whether or not this change should even be included. I feel
pretty confident that I can cleanly fold the tsl2583 driver into this
driver once the staging graduation is done. Those devices have an ALS
range of 2.7 ms - 688.5 ms.

 drivers/staging/iio/light/tsl2x7x.c | 50 +++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 9b32054713fb..e3e37501829f 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -209,9 +209,9 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
 };
 
 static const struct tsl2x7x_settings tsl2x7x_default_settings = {
-	.als_time = 255, /* 2.73 ms */
+	.als_time = 255, /* 2.72 / 2.73 ms */
 	.als_gain = 0,
-	.prox_time = 255, /* 2.73 ms */
+	.prox_time = 255, /* 2.72 / 2.73 ms */
 	.prox_gain = 0,
 	.wait_time = 255,
 	.als_prox_config = 0,
@@ -245,6 +245,24 @@ static const s16 tsl2x7x_prox_gain[] = {
 	8
 };
 
+struct tsl2x7x_int_time {
+	int increment_us;
+	char *display_range;
+};
+
+static const struct tsl2x7x_int_time tsl2x7x_int_time[] = {
+	[tsl2571] = { 2720, "0.00272 - 0.696" },
+	[tsl2671] = { 2720, "0.00272 - 0.696" },
+	[tmd2671] = { 2720, "0.00272 - 0.696" },
+	[tsl2771] = { 2720, "0.00272 - 0.696" },
+	[tmd2771] = { 2720, "0.00272 - 0.696" },
+	[tsl2572] = { 2730, "0.00273 - 0.699" },
+	[tsl2672] = { 2730, "0.00273 - 0.699" },
+	[tmd2672] = { 2730, "0.00273 - 0.699" },
+	[tsl2772] = { 2730, "0.00273 - 0.699" },
+	[tmd2772] = { 2730, "0.00273 - 0.699" },
+};
+
 /* Channel variations */
 enum {
 	ALS,
@@ -626,7 +644,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 
 	/* set chip time scaling and saturation */
 	als_count = 256 - chip->settings.als_time;
-	als_time_us = als_count * 2720;
+	als_time_us = als_count * tsl2x7x_int_time[chip->id].increment_us;
 	chip->als_saturation = als_count * 768; /* 75% of full scale */
 	chip->als_gain_time_scale = als_time_us *
 		tsl2x7x_als_gain[chip->settings.als_gain];
@@ -764,8 +782,16 @@ static IIO_CONST_ATTR(in_intensity0_calibscale_available, "1 8 16 120");
 
 static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
 
-static IIO_CONST_ATTR(in_intensity0_integration_time_available,
-		".00272 - .696");
+static ssize_t
+in_intensity0_integration_time_available_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			tsl2x7x_int_time[chip->id].display_range);
+}
 
 static ssize_t in_illuminance0_target_input_show(struct device *dev,
 						 struct device_attribute *attr,
@@ -1124,7 +1150,8 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = 0;
-		*val2 = (256 - chip->settings.als_time) * 2720;
+		*val2 = (256 - chip->settings.als_time) *
+			tsl2x7x_int_time[chip->id].increment_us;
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
 	default:
@@ -1184,7 +1211,8 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 		chip->settings.als_gain_trim = val;
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
-		chip->settings.als_time = 256 - (val2 / 2720);
+		chip->settings.als_time = 256 -
+			(val2 / tsl2x7x_int_time[chip->id].increment_us);
 		break;
 	default:
 		return -EINVAL;
@@ -1193,6 +1221,8 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 	return tsl2x7x_invoke_change(indio_dev);
 }
 
+static DEVICE_ATTR_RO(in_intensity0_integration_time_available);
+
 static DEVICE_ATTR_RW(in_illuminance0_target_input);
 
 static DEVICE_ATTR_WO(in_illuminance0_calibrate);
@@ -1266,7 +1296,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
 
 static struct attribute *tsl2x7x_ALS_device_attrs[] = {
 	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
-	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
+	&dev_attr_in_intensity0_integration_time_available.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
@@ -1280,7 +1310,7 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
 	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
-	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
+	&dev_attr_in_intensity0_integration_time_available.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
@@ -1295,7 +1325,7 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
 
 static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
 	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
-	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
+	&dev_attr_in_intensity0_integration_time_available.attr,
 	&dev_attr_in_illuminance0_target_input.attr,
 	&dev_attr_in_illuminance0_calibrate.attr,
 	&dev_attr_in_illuminance0_lux_table.attr,
-- 
2.14.3
