Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37022 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459Ab3J3WtM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 30 Oct 2013 18:49:12 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 5/8] iio: hid-sensors: magnetometer : Add sensitivity
Date: Wed, 30 Oct 2013 15:48:50 -0700
Message-Id: <1383173333-18618-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1383173333-18618-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1383173333-18618-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A number of Properties that can be applied to Data Fields are per data
field basis or for all data fields. Adding sensitivity field for all
magnetometer fields, which is most commonly used in currently available
sensor hubs.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index ff7b9da..db9f27b 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -262,6 +262,18 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 			st->magn[1].index, st->magn[1].report_id,
 			st->magn[2].index, st->magn[2].report_id);
 
+	/* Set Sensitivity field ids, when there is no individual modifier */
+	if (st->common_attributes.sensitivity.index < 0) {
+		sensor_hub_input_get_attribute_info(hsdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
+			HID_USAGE_SENSOR_DATA_ORIENTATION,
+			&st->common_attributes.sensitivity);
+		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
+			st->common_attributes.sensitivity.index,
+			st->common_attributes.sensitivity.report_id);
+	}
+
 	return ret;
 }
 
-- 
1.8.3.2

