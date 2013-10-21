Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28089 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab3JUVB0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 21 Oct 2013 17:01:26 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/9] iio: hid-sensors: Add connection type
Date: Mon, 21 Oct 2013 14:01:10 -0700
Message-Id: <1382389277-7932-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1382389277-7932-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some sensor hub firmware are very strict about the connection type
setting. The connection type specifies whether it is an integrated
or external sensor hub.
By default choosing integrated type unless changed via a module
param.
Also a fix a minor typo for POWER_STATE.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 12 +++++++++---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c    |  8 ++++++++
 include/linux/hid-sensor-hub.h                         |  1 +
 include/linux/hid-sensor-ids.h                         |  6 +++++-
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 75b5473..dacd98d 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -226,7 +226,7 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 
 	sensor_hub_input_get_attribute_info(hsdev,
 					HID_FEATURE_REPORT, usage_id,
-					HID_USAGE_SENSOR_PROY_POWER_STATE,
+					HID_USAGE_SENSOR_PROT_POWER_STATE,
 					&st->power_state);
 
 	sensor_hub_input_get_attribute_info(hsdev,
@@ -234,11 +234,17 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 			HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS,
 			 &st->sensitivity);
 
-	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x\n",
+	sensor_hub_input_get_attribute_info(hsdev,
+				HID_FEATURE_REPORT, usage_id,
+				HID_USAGE_SENSOR_PROP_SENSOR_CONNECTION_TYPE,
+				&st->conn_type);
+
+	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x %x:%x\n",
 			st->poll.index, st->poll.report_id,
 			st->report_state.index, st->report_state.report_id,
 			st->power_state.index, st->power_state.report_id,
-			st->sensitivity.index, st->sensitivity.report_id);
+			st->sensitivity.index, st->sensitivity.report_id,
+			st->conn_type.index, st->conn_type.report_id);
 
 	return 0;
 }
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index dbc9141..8d98ef8 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -34,6 +34,10 @@ module_param(hid_sensor_named_array_base, int, 0644);
 MODULE_PARM_DESC(hid_sensor_named_array_base,
 	"HID SENSOR NAMED ARRAY BASE (0 or 1).");
 
+static int hid_sensor_conn_type = HID_USAGE_SENSOR_PROP_CONNEC_TYPE_PC_INT_ENUM;
+module_param(hid_sensor_conn_type, int, 0644);
+MODULE_PARM_DESC(hid_sensor_conn_type, "HID SENSOR CONNECT TYPE (1 to 3).");
+
 static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 						bool state)
 {
@@ -68,6 +72,10 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					st->report_state.index,
 					(s32)report_state);
 
+	sensor_hub_set_feature(st->hsdev, st->conn_type.report_id,
+					st->conn_type.index,
+					hid_sensor_conn_type);
+
 	return 0;
 }
 
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index a265af2..084a682 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -188,6 +188,7 @@ struct hid_sensor_common {
 	struct hid_sensor_hub_attribute_info report_state;
 	struct hid_sensor_hub_attribute_info power_state;
 	struct hid_sensor_hub_attribute_info sensitivity;
+	struct hid_sensor_hub_attribute_info conn_type;
 };
 
 /* Convert from hid unit expo to regular exponent */
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 8323775..714e3e1 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -106,6 +106,7 @@
 #define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND		0x15
 
 /* Common selectors */
+#define HID_USAGE_SENSOR_PROP_SENSOR_CONNECTION_TYPE		0x200309
 #define HID_USAGE_SENSOR_PROP_REPORT_INTERVAL			0x20030E
 #define HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS			0x20030F
 #define HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT		0x200310
@@ -115,7 +116,10 @@
 #define HID_USAGE_SENSOR_PROP_RANGE_MAXIMUM			0x200314
 #define HID_USAGE_SENSOR_PROP_RANGE_MINIMUM			0x200315
 #define HID_USAGE_SENSOR_PROP_REPORT_STATE			0x200316
-#define HID_USAGE_SENSOR_PROY_POWER_STATE			0x200319
+#define HID_USAGE_SENSOR_PROT_POWER_STATE			0x200319
+
+/* Default connection type */
+#define HID_USAGE_SENSOR_PROP_CONNEC_TYPE_PC_INT_ENUM		0x01
 
 /* Power state enumerations */
 #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM		0x00
-- 
1.8.3.1

