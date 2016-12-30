Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44378 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751333AbcL3BAp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 29 Dec 2016 20:00:45 -0500
From: Song Hongyan <hongyan.song@intel.com>
To: linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH 2/4] iio: hid-sensors: API add max_sample_frequency
Date: Fri, 30 Dec 2016 17:23:10 +0800
Message-Id: <1483089792-11324-2-git-send-email-hongyan.song@intel.com>
In-Reply-To: <1483089792-11324-1-git-send-email-hongyan.song@intel.com>
References: <1483089792-11324-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This interface is used to help user to set sampling
frequency to an acceptable range.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 35 ++++++++++++++++++++--
 include/linux/hid-sensor-hub.h                     |  4 ++-
 include/linux/hid-sensor-ids.h                     |  1 +
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index b5beea53..ad30814 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -194,6 +194,30 @@ int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
 }
 EXPORT_SYMBOL(hid_sensor_read_samp_freq_value);
 
+int hid_sensor_read_max_samp_freq_value(struct hid_sensor_common *st,
+				int *val1, int *val2)
+{
+	s32 value;
+	int ret;
+
+	ret = sensor_hub_get_feature(st->hsdev,
+				st->min_report_inter.report_id,
+				st->min_report_inter.index, sizeof(value),
+				&value);
+	if (ret < 0 || value < 0)
+		return -EINVAL;
+
+	if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
+		simple_div(1000, value, val1, val2);
+	else if (st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
+		simple_div(1, value, val1, val2);
+	else
+		return -EINVAL;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+EXPORT_SYMBOL(hid_sensor_read_max_samp_freq_value);
+
 int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 				int val1, int val2)
 {
@@ -382,11 +406,18 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 			HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS,
 			 &st->sensitivity);
 
-	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x\n",
+	sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_PROP_MIN_REPORT_INTER,
+			&st->min_report_inter);
+
+	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x, %x:%x\n",
 			st->poll.index, st->poll.report_id,
 			st->report_state.index, st->report_state.report_id,
 			st->power_state.index, st->power_state.report_id,
-			st->sensitivity.index, st->sensitivity.report_id);
+			st->sensitivity.index, st->sensitivity.report_id,
+			st->min_report_inter.index,
+			st->min_report_inter.report_id);
 
 	return 0;
 }
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index dd85f35..3410777 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -236,6 +236,7 @@ struct hid_sensor_common {
 	struct hid_sensor_hub_attribute_info report_state;
 	struct hid_sensor_hub_attribute_info power_state;
 	struct hid_sensor_hub_attribute_info sensitivity;
+	struct hid_sensor_hub_attribute_info min_report_inter;
 	struct work_struct work;
 };
 
@@ -261,7 +262,8 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 					int val1, int val2);
 int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
 					int *val1, int *val2);
-
+int hid_sensor_read_max_samp_freq_value(struct hid_sensor_common *st,
+					int *val1, int *val2);
 int hid_sensor_get_usage_index(struct hid_sensor_hub_device *hsdev,
 				u32 report_id, int field_index, u32 usage_id);
 
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index b6778fd2..3e56e50 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -140,6 +140,7 @@
 #define HID_USAGE_SENSOR_PROP_RANGE_MINIMUM			0x200315
 #define HID_USAGE_SENSOR_PROP_REPORT_STATE			0x200316
 #define HID_USAGE_SENSOR_PROY_POWER_STATE			0x200319
+#define HID_USAGE_SENSOR_PROP_MIN_REPORT_INTER			0x200304
 
 /* Per data field properties */
 #define HID_USAGE_SENSOR_DATA_MOD_NONE					0x00
-- 
1.9.1

