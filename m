Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10524 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751649Ab3JUVB1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 21 Oct 2013 17:01:27 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 5/9] iio: hid-sensors: light/als : Add sensitivity
Date: Mon, 21 Oct 2013 14:01:13 -0700
Message-Id: <1382389277-7932-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A number of Properties that can be applied to Data Fields are per data
field basis or for all data fields. Adding sensitivity field for all
als fields, which is most commonly used in currently available
sensor hubs.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/light/hid-sensor-als.c | 11 +++++++++++
 include/linux/hid-sensor-ids.h     |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index e59d00c..524f829 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -228,6 +228,17 @@ static int als_parse_report(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum.index,
 			st->als_illum.report_id);
 
+	/* Set Sensitivity field ids, when there is no individual modifier */
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_DATA_LIGHT,
+			&st->common_attributes.sensitivity);
+		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
+			st->common_attributes.sensitivity.index,
+			st->common_attributes.sensitivity.report_id);
+	}
 	return ret;
 }
 
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 73cd4ee..3f349fa 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -30,6 +30,7 @@
 
 /* ALS (200041) */
 #define HID_USAGE_SENSOR_ALS					0x200041
+#define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
 
 /* Gyro 3D: (200076) */
-- 
1.8.3.1

