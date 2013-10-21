Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/9] iio: hid-sensors: accelerometer: Add sensitivity
Date: Mon, 21 Oct 2013 14:01:11 -0700
Message-Id: <1382389277-7932-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

A number of Properties that can be applied to Data Fields are per data
field basis or for all data fields. Adding sensitivity field for all
accelerometer fields, which is most commonly used in currently
available sensor hubs.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 12 ++++++++++++
 include/linux/hid-sensor-ids.h          |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 46d22f3..501caaf 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -261,6 +261,18 @@ static int accel_3d_parse_report(struct platform_device *pdev,
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
index 714e3e1..d9efa2b 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -23,6 +23,7 @@
 
 /* Accel 3D (200073) */
 #define HID_USAGE_SENSOR_ACCEL_3D				0x200073
+#define HID_USAGE_SENSOR_DATA_ACCELERATION			0x200452
 #define HID_USAGE_SENSOR_ACCEL_X_AXIS				0x200453
 #define HID_USAGE_SENSOR_ACCEL_Y_AXIS				0x200454
 #define HID_USAGE_SENSOR_ACCEL_Z_AXIS				0x200455
-- 
1.8.3.1
