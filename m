Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35624 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbGOHnz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2015 03:43:55 -0400
From: Reyad Attiyat <reyad.attiyat@gmail.com>
To: jic23@kernel.org, srinivas.pandruvada@linux.intel.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Reyad Attiyat <reyad.attiyat@gmail.com>
Subject: [PATCH] hid_sensor_magn_3d: Fix scale for rotation from north channels
Date: Wed, 15 Jul 2015 02:43:18 -0500
Message-Id: <1436946198-10395-1-git-send-email-reyad.attiyat@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some devices on a hid sensor hub will not report a measurement unit. This
causes the rotation from north channels to have an incorrect scale value.
This patch will set the unit to degrees if the maximum value is 360 when
the unit exponent value is accounted for.

Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 19 ++++++++++++++++
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 26 +++++++++++++++++++++-
 include/linux/hid-sensor-hub.h                     |  4 ++++
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index e81f434..3c79847 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -46,6 +46,7 @@ static struct {
 
 	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000},
 	{HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0},
+	{HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_DEGREES, 1, 0},
 
 	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453},
 	{HID_USAGE_SENSOR_INCLINOMETER_3D,
@@ -317,6 +318,24 @@ static void adjust_exponent_micro(int *val0, int *val1, int scale0,
 	}
 }
 
+void hid_sensor_get_unit_expo_fraction(
+		struct hid_sensor_hub_attribute_info *attr_info,
+		int *num, int *denom)
+{
+	s32 exp = hid_sensor_convert_exponent(attr_info->unit_expo);
+
+	if (exp == 0) {
+		*num = *denom = 1;
+	} else if (exp < 0) {
+		*num = 1;
+		*denom = pow_10(abs(exp));
+	} else if (exp > 0) {
+		*num = pow_10(exp);
+		*denom = 1;
+	}
+}
+EXPORT_SYMBOL(hid_sensor_get_unit_expo_fraction);
+
 int hid_sensor_format_scale(u32 usage_id,
 			struct hid_sensor_hub_attribute_info *attr_info,
 			int *val0, int *val1)
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index d8a0c8d..173d2f5 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -311,6 +311,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 	int i;
 	int attr_count = 0;
 	struct iio_chan_spec *_channels;
+	struct hid_sensor_hub_attribute_info *first_channel_attr_info;
 
 	/* Scan for each usage attribute supported */
 	for (i = 0; i < MAGN_3D_CHANNEL_MAX; i++) {
@@ -389,9 +390,32 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "magn_3d Setup %d IIO channels\n",
 			*chan_count);
 
+	first_channel_attr_info = &(st->magn[_channels[0].address]);
+
+	/* Try and set unit based off exponent, logical min and max */
+	if (!first_channel_attr_info->units) {
+		int num, denom;
+		s32 log_min = first_channel_attr_info->logical_minimum;
+		s32 log_max = first_channel_attr_info->logical_maximum;
+
+		dev_dbg(&pdev->dev, "magn_3d Units not set. Unit Expo %d Logical Min: %d Max: %d\n",
+					first_channel_attr_info->unit_expo,
+					log_min, log_max);
+
+		hid_sensor_get_unit_expo_fraction(first_channel_attr_info,
+						&num, &denom);
+
+		/* Check for unit Degrees */
+		if (log_min == 0 && num == 1 && (log_max == 360 * denom)) {
+			first_channel_attr_info->units =
+					HID_USAGE_SENSOR_UNITS_DEGREES;
+			dev_dbg(&pdev->dev, "magn_3d Set units to degrees.");
+		}
+
+	}
 	st->scale_precision = hid_sensor_format_scale(
 				HID_USAGE_SENSOR_COMPASS_3D,
-				&st->magn[CHANNEL_SCAN_INDEX_X],
+				first_channel_attr_info,
 				&st->scale_pre_decml, &st->scale_post_decml);
 
 	/* Set Sensitivity field ids, when there is no individual modifier */
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 0042bf3..627fd68 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -267,6 +267,10 @@ int hid_sensor_format_scale(u32 usage_id,
 			    struct hid_sensor_hub_attribute_info *attr_info,
 			    int *val0, int *val1);
 
+void hid_sensor_get_unit_expo_fraction(
+			struct hid_sensor_hub_attribute_info *attr_info,
+			int *num, int *denom);
+
 s32 hid_sensor_read_poll_value(struct hid_sensor_common *st);
 
 #endif
-- 
2.4.3

