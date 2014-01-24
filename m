Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54241 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbaAXCuj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 23 Jan 2014 21:50:39 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org, jkosina@suse.cz
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] hid: hid-sensor-hub: Add selector api
Date: Thu, 23 Jan 2014 18:50:21 -0800
Message-Id: <1390531822-7640-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In some report descriptors, they leave holes in the selectors. In
this case if we use hardcoded selector values, this will result
in invalid values. For example, if there is selectors defined for
Power State from OFF to D0 to D3. We can't use indexes of these states
if some states are not implemented or not present in the report decriptors.
In this case, we need to get the indexes from report descriptors.

One API is added to get the index of a selector. This API will
search for usage id in the field usage list and return the index.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c   | 22 ++++++++++++++++++++++
 include/linux/hid-sensor-hub.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 46f4480..ad2b869 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -291,6 +291,28 @@ err_free:
 }
 EXPORT_SYMBOL_GPL(sensor_hub_input_attr_get_raw_value);
 
+int hid_sensor_get_usage_index(struct hid_sensor_hub_device *hsdev,
+				u32 report_id, int field_index, u32 usage_id)
+{
+	struct hid_report *report;
+	struct hid_field *field;
+	int i;
+
+	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
+	if (!report || (field_index >= report->maxfield))
+		goto done_proc;
+
+	field = report->field[field_index];
+	for (i = 0; i < field->maxusage; ++i) {
+		if (field->usage[i].hid == usage_id)
+			return field->usage[i].usage_index;
+	}
+
+done_proc:
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(hid_sensor_get_usage_index);
+
 int sensor_hub_input_get_attribute_info(struct hid_sensor_hub_device *hsdev,
 				u8 type,
 				u32 usage_id,
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index b914ca3..205eba0 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -218,4 +218,7 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
 int hid_sensor_read_samp_freq_value(struct hid_sensor_common *st,
 					int *val1, int *val2);
 
+int hid_sensor_get_usage_index(struct hid_sensor_hub_device *hsdev,
+				u32 report_id, int field_index, u32 usage_id);
+
 #endif
-- 
1.8.3.2

