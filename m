Return-Path: <SRS0=wnnm=3Q=linux.intel.com=srinivas.pandruvada@kernel.org>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] iio: hid-sensor-hub: Implement batch mode
Date: Fri,  7 Apr 2017 19:22:06 -0700
Message-Id: <20170408022206.17963-1-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

HID sensor hubs using Integrated Senor Hub (ISH) has added capability to
support batch mode. This allows host processor to go to sleep for extended
duration, while the sensor hub is storing samples in its internal buffers.

'Commit f4f4673b7535 ("iio: add support for hardware fifo")' implements
feature in IIO core to implement such feature. This feature is used in
bmc150-accel-core.c to implement batch mode. This implementation allows
software device buffer watermark to be used as a hint to adjust hardware
FIFO.

But HID sensor hubs don't allow to change internal buffer size of FIFOs.
Instead an additional usage id to set "maximum report latency" is defined.
This allows host to go to sleep upto this latency period without getting
any report. Since there is no ABI to set this latency, a new attribute
"hwfifo_timeout" is added so that user mode can specify a latency.

This change checks presence of usage id to get/set maximum report latency
and if present, it will expose hwfifo_timeout.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
- Fifo timeout can be in fractions also.
- Restore latency on resume from S3.

Changed compared to RFC:
- Removed min/max Fifo size attributes
- Removed flush callback. Since this usage id is not present in any hubs,
we can add later when we have some HW to test. This was causing some
ugliness.
- Moved the hwfifo_timout documentation to sysfs-bus-iio

 Documentation/ABI/testing/sysfs-bus-iio            | 11 +++
 .../iio/common/hid-sensors/hid-sensor-attributes.c | 44 ++++++++++++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 80 ++++++++++++++++++++++
 include/linux/hid-sensor-hub.h                     |  5 ++
 include/linux/hid-sensor-ids.h                     |  3 +
 5 files changed, 143 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 530809c..b09f373 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1424,6 +1424,17 @@ Description:
 		guarantees that the hardware fifo is flushed to the device
 		buffer.
 
+What:		/sys/bus/iio/devices/iio:device*/buffer/hwfifo_timeout
+KernelVersion:	4.12
+Contact:	linux-iio@vger.kernel.org
+Description:
+		A read/write property to provide capability to delay reporting of
+		samples till a timeout is reached. This allows host processors to
+		sleep, while the sensor is storing samples in its internal fifo.
+		The maximum timeout in seconds can be specified by setting
+		hwfifo_timeout.The current delay can be read by reading
+		hwfifo_timeout. A value of 0 means that there is no timout.
+
 What:		/sys/bus/iio/devices/iio:deviceX/buffer/hwfifo_watermark
 KernelVersion: 4.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index efd3151..89c3f9c 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -393,6 +393,48 @@ int hid_sensor_get_reporting_interval(struct hid_sensor_hub_device *hsdev,
 
 }
 
+static void hid_sensor_get_report_latency_info(struct hid_sensor_hub_device *hsdev,
+					       u32 usage_id,
+					       struct hid_sensor_common *st)
+{
+	sensor_hub_input_get_attribute_info(hsdev, HID_FEATURE_REPORT,
+					    usage_id,
+					    HID_USAGE_SENSOR_PROP_REPORT_LATENCY,
+					    &st->report_latency);
+
+	hid_dbg(hsdev->hdev, "Report latency attributes: %x:%x\n",
+		st->report_latency.index, st->report_latency.report_id);
+}
+
+int hid_sensor_get_report_latency(struct hid_sensor_common *st)
+{
+	int ret;
+	int value;
+
+	ret = sensor_hub_get_feature(st->hsdev, st->report_latency.report_id,
+				     st->report_latency.index, sizeof(value),
+				     &value);
+	if (ret < 0)
+		return ret;
+
+	return value;
+}
+EXPORT_SYMBOL(hid_sensor_get_report_latency);
+
+int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency_ms)
+{
+	return sensor_hub_set_feature(st->hsdev, st->report_latency.report_id,
+				      st->report_latency.index,
+				      sizeof(latency_ms), &latency_ms);
+}
+EXPORT_SYMBOL(hid_sensor_set_report_latency);
+
+bool hid_sensor_batch_mode_supported(struct hid_sensor_common *st)
+{
+	return st->report_latency.index > 0 && st->report_latency.report_id > 0;
+}
+EXPORT_SYMBOL(hid_sensor_batch_mode_supported);
+
 int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 					u32 usage_id,
 					struct hid_sensor_common *st)
@@ -432,6 +474,8 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 	} else
 		st->timestamp_ns_scale = 1000000000;
 
+	hid_sensor_get_report_latency_info(hsdev, usage_id, st);
+
 	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x %x:%x\n",
 		st->poll.index, st->poll.report_id,
 		st->report_state.index, st->report_state.report_id,
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 0b5dea0..16ade0a 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -26,9 +26,84 @@
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/sysfs.h>
 #include "hid-sensor-trigger.h"
 
+static ssize_t _hid_sensor_set_report_latency(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+	int integer, fract, ret;
+	int latency;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &integer, &fract);
+	if (ret)
+		return ret;
+
+	latency = integer * 1000 + fract / 1000;
+	ret = hid_sensor_set_report_latency(attrb, latency);
+	if (ret < 0)
+		return len;
+
+	attrb->latency_ms = hid_sensor_get_report_latency(attrb);
+
+	return len;
+}
+
+static ssize_t _hid_sensor_get_report_latency(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+	int latency;
+
+	latency = hid_sensor_get_report_latency(attrb);
+	if (latency < 0)
+		return latency;
+
+	return sprintf(buf, "%d.%06u\n", latency / 1000, (latency % 1000) * 1000);
+}
+
+static ssize_t _hid_sensor_get_fifo_state(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+	int latency;
+
+	latency = hid_sensor_get_report_latency(attrb);
+	if (latency < 0)
+		return latency;
+
+	return sprintf(buf, "%d\n", !!latency);
+}
+
+static IIO_DEVICE_ATTR(hwfifo_timeout, 0644,
+		       _hid_sensor_get_report_latency,
+		       _hid_sensor_set_report_latency, 0);
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       _hid_sensor_get_fifo_state, NULL, 0);
+
+static const struct attribute *hid_sensor_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	NULL,
+};
+
+static void hid_sensor_setup_batch_mode(struct iio_dev *indio_dev,
+					struct hid_sensor_common *st)
+{
+	if (!hid_sensor_batch_mode_supported(st))
+		return;
+
+	iio_buffer_set_attrs(indio_dev->buffer, hid_sensor_fifo_attributes);
+}
+
 static int _hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 {
 	int state_val;
@@ -141,6 +216,9 @@ static void hid_sensor_set_power_work(struct work_struct *work)
 				       sizeof(attrb->raw_hystersis),
 				       &attrb->raw_hystersis);
 
+	if (attrb->latency_ms > 0)
+		hid_sensor_set_report_latency(attrb, attrb->latency_ms);
+
 	_hid_sensor_power_state(attrb, true);
 }
 
@@ -192,6 +270,8 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
 	attrb->trigger = trig;
 	indio_dev->trig = iio_trigger_get(trig);
 
+	hid_sensor_setup_batch_mode(indio_dev, attrb);
+
 	ret = pm_runtime_set_active(&indio_dev->dev);
 	if (ret)
 		goto error_unreg_trigger;
diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
index f32d7c3..fc7aae6 100644
--- a/include/linux/hid-sensor-hub.h
+++ b/include/linux/hid-sensor-hub.h
@@ -233,12 +233,14 @@ struct hid_sensor_common {
 	atomic_t user_requested_state;
 	int poll_interval;
 	int raw_hystersis;
+	int latency_ms;
 	struct iio_trigger *trigger;
 	int timestamp_ns_scale;
 	struct hid_sensor_hub_attribute_info poll;
 	struct hid_sensor_hub_attribute_info report_state;
 	struct hid_sensor_hub_attribute_info power_state;
 	struct hid_sensor_hub_attribute_info sensitivity;
+	struct hid_sensor_hub_attribute_info report_latency;
 	struct work_struct work;
 };
 
@@ -276,5 +278,8 @@ s32 hid_sensor_read_poll_value(struct hid_sensor_common *st);
 
 int64_t hid_sensor_convert_timestamp(struct hid_sensor_common *st,
 				     int64_t raw_value);
+bool hid_sensor_batch_mode_supported(struct hid_sensor_common *st);
+int hid_sensor_set_report_latency(struct hid_sensor_common *st, int latency);
+int hid_sensor_get_report_latency(struct hid_sensor_common *st);
 
 #endif
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 30c7dc4..d7caf8c 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -142,6 +142,9 @@
 #define HID_USAGE_SENSOR_PROP_REPORT_STATE			0x200316
 #define HID_USAGE_SENSOR_PROY_POWER_STATE			0x200319
 
+/* Batch mode selectors */
+#define HID_USAGE_SENSOR_PROP_REPORT_LATENCY			0x20031B
+
 /* Per data field properties */
 #define HID_USAGE_SENSOR_DATA_MOD_NONE					0x00
 #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS		0x1000
-- 
2.9.3
