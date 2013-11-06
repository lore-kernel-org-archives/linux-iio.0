Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40240 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755880Ab3KFAMD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Nov 2013 19:12:03 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 1/5] iio: hid-sensors: accelerometer: Add sensitivity
Date: Tue,  5 Nov 2013 16:11:34 -0800
Message-Id: <1383696698-24974-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <a>
References: <a>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A number of Properties that can be applied to Data Fields are per data
field basis or for all data fields. Adding sensitivity field for all
accelerometer fields, which is most commonly used in currently
available sensor hubs.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 12 ++++++++++++
 include/linux/hid-sensor-ids.h          |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 1cae4e9..3dcdbad 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -262,6 +262,18 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 			st->accel[1].index, st->accel[1].report_id,
 			st->accel[2].index, st->accel[2].report_id);
 
+	/* Set Sensitivity field ids, when there is no individual modifier */
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_DATA_ACCELERATION,
+			&st->common_attributes.sensitivity);
+		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
+			st->common_attributes.sensitivity.index,
+			st->common_attributes.sensitivity.report_id);
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 4f945d3..38a832c 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -23,6 +23,7 @@
 
 /* Accel 3D (200073) */
 #define HID_USAGE_SENSOR_ACCEL_3D				0x200073
+#define HID_USAGE_SENSOR_DATA_ACCELERATION			0x200452
 #define HID_USAGE_SENSOR_ACCEL_X_AXIS				0x200453
 #define HID_USAGE_SENSOR_ACCEL_Y_AXIS				0x200454
 #define HID_USAGE_SENSOR_ACCEL_Z_AXIS				0x200455
@@ -117,4 +118,8 @@
 #define HID_USAGE_SENSOR_PROP_REPORT_STATE			0x200316
 #define HID_USAGE_SENSOR_PROY_POWER_STATE			0x200319
 
+/* Per data field properties */
+#define HID_USAGE_SENSOR_DATA_MOD_NONE				0x00
+#define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS	0x1000
+
 #endif
-- 
1.8.3.1

