Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:49480 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbdCXCbE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Mar 2017 22:31:04 -0400
From: Song Hongyan <hongyan.song@intel.com>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH] iio: hid-sensor-attributes: Fix sensor property setting failure.
Date: Fri, 24 Mar 2017 18:53:48 +0800
Message-Id: <1490352828-40203-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When system bootup without get sensor property, set sensor
property will be fail.

If no get_feature operation done before set_feature, the sensor
properties will all be the initialized value, which is not the
same with sensor real properties. When set sensor property it will
write back to sensor the changed perperty data combines with other
sensor properties data, it is not right and may be dangerous.

In order to get all sensor properties, choose to read one of the sensor
property(no matter read any sensor peroperty, driver will get all
the peroperties and return the requested one).

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 7afdac42..01e02b9 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -379,6 +379,8 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 {
 
 	struct hid_sensor_hub_attribute_info timestamp;
+	s32 value;
+	int ret;
 
 	hid_sensor_get_reporting_interval(hsdev, usage_id, st);
 
@@ -417,6 +419,14 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 		st->sensitivity.index, st->sensitivity.report_id,
 		timestamp.index, timestamp.report_id);
 
+	ret = sensor_hub_get_feature(hsdev,
+				st->power_state.report_id,
+				st->power_state.index, sizeof(value), &value);
+	if (ret < 0)
+		return ret;
+	if (value < 0)
+		return -EINVAL;
+
 	return 0;
 }
 EXPORT_SYMBOL(hid_sensor_parse_common_attributes);
-- 
1.9.1

