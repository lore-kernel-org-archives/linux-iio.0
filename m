Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27507 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbdCPB6K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Mar 2017 21:58:10 -0400
From: Song Hongyan <hongyan.song@intel.com>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com,
        Song Hongyan <hongyan.song@intel.com>
Subject: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC sensor support
Date: Thu, 16 Mar 2017 18:20:52 +0800
Message-Id: <1489659652-35608-1-git-send-email-hongyan.song@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As accelerometer sensor becomes more and more popular, there are more
user scenarios have been developed, "Hinge" is a very important usecase
which needs two accelerometer sensors to calculate the included angle
of keyboard and screen.
In this case, two accelerometer sensors will be exposed. Currently,
IIO interface hasn't other way to distinguish two sensors with same
sensor type, except sensor name. So a new sensor name "accel_2nd_3d"
is added for secondary accelerometer sensor.

In HID level, connection type is a good common property to
differentiate two sensors with same sensor type.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c            | 35 ++++++++++++++++++++--
 .../iio/common/hid-sensors/hid-sensor-attributes.c |  5 ++++
 include/linux/hid-sensor-hub.h                     |  1 +
 include/linux/hid-sensor-ids.h                     |  1 +
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index ca5759c..cc4366e 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -31,6 +31,13 @@
 #include <linux/iio/triggered_buffer.h>
 #include "../common/hid-sensors/hid-sensor-trigger.h"
 
+enum connection_type {
+	CONN_PC_INTEGRATED_SEL,
+	CONN_PC_ATTACHED_SEL,
+	CONN_PC_EXTERNAL_SEL,
+	CONN_TYPE_MAX,
+};
+
 enum accel_3d_channel {
 	CHANNEL_SCAN_INDEX_X,
 	CHANNEL_SCAN_INDEX_Y,
@@ -343,6 +350,19 @@ static int accel_3d_parse_report(struct platform_device *pdev,
 	return ret;
 }
 
+int connection_type_check(struct hid_sensor_common *st, int *conn_tp)
+{
+	int ret;
+
+	ret = sensor_hub_get_feature(st->hsdev, st->conn_type.report_id,
+		st->conn_type.index, sizeof(*conn_tp), conn_tp);
+
+	if (ret < 0 || conn_tp < 0)
+		return -EINVAL;
+
+	return ret;
+}
+
 /* Function to initialize the processing for usage id */
 static int hid_accel_3d_probe(struct platform_device *pdev)
 {
@@ -352,6 +372,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	struct accel_3d_state *accel_state;
 	const struct iio_chan_spec *channel_spec;
 	int channel_size;
+	s32 conn_type;
 
 	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
 
@@ -367,11 +388,9 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 	accel_state->common_attributes.pdev = pdev;
 
 	if (hsdev->usage == HID_USAGE_SENSOR_ACCEL_3D) {
-		name = "accel_3d";
 		channel_spec = accel_3d_channels;
 		channel_size = sizeof(accel_3d_channels);
 	} else {
-		name = "gravity";
 		channel_spec = gravity_channels;
 		channel_size = sizeof(gravity_channels);
 	}
@@ -387,6 +406,18 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to duplicate channels\n");
 		return -ENOMEM;
 	}
+
+	ret = connection_type_check(&accel_state->common_attributes,
+				&conn_type);
+
+	if (hsdev->usage == HID_USAGE_SENSOR_ACCEL_3D) {
+		if (conn_type == CONN_PC_EXTERNAL_SEL)
+			name = "accel_2nd_3d";
+		else
+			name = "accel_3d";
+	} else
+		name = "gravity";
+
 	ret = accel_3d_parse_report(pdev, hsdev,
 				(struct iio_chan_spec *)indio_dev->channels,
 				hsdev->usage, accel_state);
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 4f280ae..cc2ce2a 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -400,6 +400,11 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 			 &st->sensitivity);
 
 	sensor_hub_input_get_attribute_info(hsdev,
+					HID_FEATURE_REPORT, usage_id,
+					HID_USAGE_SENSOR_PROP_CONN_TYPE,
+					&st->conn_type);
+
+	sensor_hub_input_get_attribute_info(hsdev,
 					    HID_INPUT_REPORT, usage_id,
 					    HID_USAGE_SENSOR_TIME_TIMESTAMP,
 					    &timestamp);
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index 7ef111d..08756a9 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -237,6 +237,7 @@ struct hid_sensor_common {
 	struct hid_sensor_hub_attribute_info report_state;
 	struct hid_sensor_hub_attribute_info power_state;
 	struct hid_sensor_hub_attribute_info sensitivity;
+	struct hid_sensor_hub_attribute_info conn_type;
 	struct work_struct work;
 };
 
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 719c928..2d349f7 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -135,6 +135,7 @@
 #define HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND		0x15
 
 /* Common selectors */
+#define HID_USAGE_SENSOR_PROP_CONN_TYPE				0x200309
 #define HID_USAGE_SENSOR_PROP_REPORT_INTERVAL			0x20030E
 #define HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS			0x20030F
 #define HID_USAGE_SENSOR_PROP_SENSITIVITY_RANGE_PCT		0x200310
-- 
1.9.1

