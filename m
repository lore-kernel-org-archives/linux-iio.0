Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37018 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab3J3WtM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 30 Oct 2013 18:49:12 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 3/8] iio: hid-sensors: gyro : Add sensitivity
Date: Wed, 30 Oct 2013 15:48:48 -0700
Message-Id: <1383173333-18618-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1383173333-18618-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1383173333-18618-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A number of Properties that can be applied to Data Fields are per data
field basis or for all data fields. Adding sensitivity field for all
gyro fields, which is most commonly used in currently available
sensor hubs.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 11 +++++++++++
 include/linux/hid-sensor-ids.h        |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 74bbed7..d665ec3 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -261,6 +261,17 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
 			st->gyro[1].index, st->gyro[1].report_id,
 			st->gyro[2].index, st->gyro[2].report_id);
 
+	/* Set Sensitivity field ids, when there is no individual modifier */
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_DATA_ANGL_VELOCITY,
+			&st->common_attributes.sensitivity);
+		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
+			st->common_attributes.sensitivity.index,
+			st->common_attributes.sensitivity.report_id);
+	}
 	return ret;
 }
 
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index bd97d60..6473d93 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -34,6 +34,7 @@
 
 /* Gyro 3D: (200076) */
 #define HID_USAGE_SENSOR_GYRO_3D				0x200076
+#define HID_USAGE_SENSOR_DATA_ANGL_VELOCITY			0x200456
 #define HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS			0x200457
 #define HID_USAGE_SENSOR_ANGL_VELOCITY_Y_AXIS			0x200458
 #define HID_USAGE_SENSOR_ANGL_VELOCITY_Z_AXIS			0x200459
-- 
1.8.3.2

