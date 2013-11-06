Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40240 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755780Ab3KFAMC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Nov 2013 19:12:02 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 2/5] iio: hid-sensors: gyro : Add sensitivity
Date: Tue,  5 Nov 2013 16:11:35 -0800
Message-Id: <1383696698-24974-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1383696698-24974-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <a>
 <1383696698-24974-1-git-send-email-srinivas.pandruvada@linux.intel.com>
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
index e54f0f4..59d6bc3 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -262,6 +262,17 @@ static int gyro_3d_parse_report(struct platform_device *pdev,
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
index 38a832c..b00ed85 100644
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
1.8.3.1

