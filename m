Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31105 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755878Ab3KFAMD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Nov 2013 19:12:03 -0500
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 3/5] iio: hid-sensors: light/als : Add sensitivity
Date: Tue,  5 Nov 2013 16:11:36 -0800
Message-Id: <1383696698-24974-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1383696698-24974-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <a>
 <1383696698-24974-1-git-send-email-srinivas.pandruvada@linux.intel.com>
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
index 8e8b9d7..621541f 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -229,6 +229,17 @@ static int als_parse_report(struct platform_device *pdev,
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
index b00ed85..880e3fa 100644
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

