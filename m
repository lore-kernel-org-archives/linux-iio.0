Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:33865 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935453AbcJ1BRL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Oct 2016 21:17:11 -0400
From: Song Hongyan <hongyan.song@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH] iio: hid-sensor-als: Add realtime data type parse support
Date: Fri, 28 Oct 2016 01:20:06 +0000
Message-Id: <1477617606-29362-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In parse report function it only support to parse absolute data type
reported. Some platforms which report realtime data cannot be parsed,
they will get "Invalid Argument" when try to get sensor data.

Add realtime data type support to match different platforms.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/iio/light/hid-sensor-als.c | 11 +++++++++++
 include/linux/hid-sensor-ids.h     |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 8bb1f90..3b3aa66 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -252,6 +252,17 @@ static int als_parse_report(struct platform_device *pdev,
 			st->common_attributes.sensitivity.index,
 			st->common_attributes.sensitivity.report_id);
 	}
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT |
+			HID_USAGE_SENSOR_LIGHT_ILLUM,
+			&st->common_attributes.sensitivity);
+		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
+			st->common_attributes.sensitivity.index,
+			st->common_attributes.sensitivity.report_id);
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index f2ee90a..755f5e2 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -141,6 +141,7 @@
 /* Per data field properties */
 #define HID_USAGE_SENSOR_DATA_MOD_NONE					0x00
 #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		0x1000
+#define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT		0xE000
 
 /* Power state enumerations */
 #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x200850
-- 
1.9.1

