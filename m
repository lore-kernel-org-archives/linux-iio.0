Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] iio: accel: hid-sensor-accel-3d: Add timestamp
Date: Mon, 28 Nov 2016 14:41:16 -0800
Message-Id: <1480372876-15915-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added timestamp channel. With this change, each sample has a timestamp.
This timestamp can be from the sensor hub when present or local kernel
timestamp. HID sensors can send timestamp with input data using usage id
HID_USAGE_SENSOR_TIME_TIMESTAMP. This timestamp value is converted to
nano seconds before pushing this sample to the iio core.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
	Convert timestamp to nano seconds before pushing sample to IIO.


 drivers/iio/accel/hid-sensor-accel-3d.c            | 32 ++++++++++++++-----
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 36 +++++++++++++++++++---
 include/linux/hid-sensor-hub.h                     |  4 +++
 include/linux/hid-sensor-ids.h                     |  1 +
 4 files changed, 60 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index ab1e238..39de79c 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -42,11 +42,13 @@ struct accel_3d_state {
 	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info accel[ACCEL_3D_CHANNEL_MAX];
-	u32 accel_val[ACCEL_3D_CHANNEL_MAX];
+	/* Reserve for 3 channels + padding + timestamp */
+	u32 accel_val[ACCEL_3D_CHANNEL_MAX + 3];
 	int scale_pre_decml;
 	int scale_post_decml;
 	int scale_precision;
 	int value_offset;
+	int64_t timestamp;
 };
 
 static const u32 accel_3d_addresses[ACCEL_3D_CHANNEL_MAX] = {
@@ -87,7 +89,8 @@ static const struct iio_chan_spec accel_3d_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_Z,
-	}
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
 /* Adjust channel real bits based on report descriptor */
@@ -192,11 +195,11 @@ static const struct iio_info accel_3d_info = {
 };
 
 /* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data,
-	int len)
+static void hid_sensor_push_data(struct iio_dev *indio_dev, void *data,
+				 int len, int64_t timestamp)
 {
 	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, data);
+	iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
 }
 
 /* Callback handler to send event after all samples are received and captured */
@@ -208,10 +211,17 @@ static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct accel_3d_state *accel_state = iio_priv(indio_dev);
 
 	dev_dbg(&indio_dev->dev, "accel_3d_proc_event\n");
-	if (atomic_read(&accel_state->common_attributes.data_ready))
+	if (atomic_read(&accel_state->common_attributes.data_ready)) {
+		if (!accel_state->timestamp)
+			accel_state->timestamp = iio_get_time_ns(indio_dev);
+
 		hid_sensor_push_data(indio_dev,
-				accel_state->accel_val,
-				sizeof(accel_state->accel_val));
+				     accel_state->accel_val,
+				     sizeof(accel_state->accel_val),
+				     accel_state->timestamp);
+
+		accel_state->timestamp = 0;
+	}
 
 	return 0;
 }
@@ -236,6 +246,12 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 						*(u32 *)raw_data;
 		ret = 0;
 	break;
+	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
+		accel_state->timestamp =
+			hid_sensor_convert_timestamp(
+					&accel_state->common_attributes,
+					*(int64_t *)raw_data);
+	break;
 	default:
 		break;
 	}
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index b5beea53..66e650a 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -58,6 +58,10 @@ static struct {
 
 	{HID_USAGE_SENSOR_PRESSURE, 0, 100, 0},
 	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL, 0, 1000000},
+
+	{HID_USAGE_SENSOR_TIME_TIMESTAMP, 0, 1000000000, 0},
+	{HID_USAGE_SENSOR_TIME_TIMESTAMP, HID_USAGE_SENSOR_UNITS_MILLISECOND,
+		1000000, 0},
 };
 
 static int pow_10(unsigned power)
@@ -343,6 +347,13 @@ int hid_sensor_format_scale(u32 usage_id,
 }
 EXPORT_SYMBOL(hid_sensor_format_scale);
 
+int64_t hid_sensor_convert_timestamp(struct hid_sensor_common *st,
+				     int64_t raw_value)
+{
+	return st->timestamp_ns_scale * raw_value;
+}
+EXPORT_SYMBOL(hid_sensor_convert_timestamp);
+
 static
 int hid_sensor_get_reporting_interval(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
@@ -364,6 +375,7 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 					struct hid_sensor_common *st)
 {
 
+	struct hid_sensor_hub_attribute_info timestamp;
 
 	hid_sensor_get_reporting_interval(hsdev, usage_id, st);
 
@@ -382,11 +394,25 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 			HID_USAGE_SENSOR_PROP_SENSITIVITY_ABS,
 			 &st->sensitivity);
 
-	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x\n",
-			st->poll.index, st->poll.report_id,
-			st->report_state.index, st->report_state.report_id,
-			st->power_state.index, st->power_state.report_id,
-			st->sensitivity.index, st->sensitivity.report_id);
+	sensor_hub_input_get_attribute_info(hsdev,
+					    HID_INPUT_REPORT, usage_id,
+					    HID_USAGE_SENSOR_TIME_TIMESTAMP,
+					    &timestamp);
+	if (timestamp.index >= 0 && timestamp.report_id) {
+		int val0, val1;
+
+		hid_sensor_format_scale(HID_USAGE_SENSOR_TIME_TIMESTAMP,
+					&timestamp, &val0, &val1);
+		st->timestamp_ns_scale = val0;
+	} else
+		st->timestamp_ns_scale = 1000000000;
+
+	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x %x:%x\n",
+		st->poll.index, st->poll.report_id,
+		st->report_state.index, st->report_state.report_id,
+		st->power_state.index, st->power_state.report_id,
+		st->sensitivity.index, st->sensitivity.report_id,
+		timestamp.index, timestamp.report_id);
 
 	return 0;
 }
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index dd85f35..7ef111d 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -232,6 +232,7 @@ struct hid_sensor_common {
 	atomic_t data_ready;
 	atomic_t user_requested_state;
 	struct iio_trigger *trigger;
+	int timestamp_ns_scale;
 	struct hid_sensor_hub_attribute_info poll;
 	struct hid_sensor_hub_attribute_info report_state;
 	struct hid_sensor_hub_attribute_info power_state;
@@ -271,4 +272,7 @@ int hid_sensor_format_scale(u32 usage_id,
 
 s32 hid_sensor_read_poll_value(struct hid_sensor_common *st);
 
+int64_t hid_sensor_convert_timestamp(struct hid_sensor_common *st,
+				     int64_t raw_value);
+
 #endif
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index f2ee90a..9a3a9db 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -95,6 +95,7 @@
 #define HID_USAGE_SENSOR_TIME_HOUR				0x200525
 #define HID_USAGE_SENSOR_TIME_MINUTE				0x200526
 #define HID_USAGE_SENSOR_TIME_SECOND				0x200527
+#define HID_USAGE_SENSOR_TIME_TIMESTAMP				0x200529
 
 /* Units */
 #define HID_USAGE_SENSOR_UNITS_NOT_SPECIFIED			0x00
-- 
2.7.4
