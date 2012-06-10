Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jiri Kosina <jkosina@suse.cz>,
	Srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 4/8] HID-Sensors: Common attributes and interfaces
Date: Sat,  9 Jun 2012 18:53:14 -0700
Message-Id: <1339293198-10404-5-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

From: Srinivas pandruvada <srinivas.pandruvada@intel.com>

Added IIO buffer interface and trigger functions, which can be
used by all sensors. In addition a set of interface functions
for setting common attributes for all sensors like polling
interval, sensitivity and activate etc.

Signed-off-by: Srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/staging/hid-sensors/Kconfig                |    3 +
 drivers/staging/hid-sensors/Makefile               |    3 +
 .../staging/hid-sensors/hid-sensor-attributes.c    |  169 ++++++++++++++++++++
 .../staging/hid-sensors/hid-sensor-attributes.h    |   51 ++++++
 drivers/staging/hid-sensors/hid-sensor-buffer.c    |   98 +++++++++++
 drivers/staging/hid-sensors/hid-sensor-interface.h |   11 ++
 drivers/staging/hid-sensors/hid-sensor-trigger.c   |   83 ++++++++++
 7 files changed, 418 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-attributes.h
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-buffer.c
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-trigger.c

diff --git a/drivers/staging/hid-sensors/Kconfig b/drivers/staging/hid-sensors/Kconfig
index 787aa74..537fd92 100644
--- a/drivers/staging/hid-sensors/Kconfig
+++ b/drivers/staging/hid-sensors/Kconfig
@@ -5,6 +5,9 @@
 menuconfig HID_SENSORS
 	tristate "HID Sensor Core"
 	select USB_HID
+	select IIO
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
 	  Support for HID Sensor hub based on HID 1.12 sensor usage table
 
diff --git a/drivers/staging/hid-sensors/Makefile b/drivers/staging/hid-sensors/Makefile
index 13591b2..123e7fa 100644
--- a/drivers/staging/hid-sensors/Makefile
+++ b/drivers/staging/hid-sensors/Makefile
@@ -6,4 +6,7 @@ ccflags-y += -Idrivers/staging
 ccflags-$(CONFIG_HID_SENSOR_DEBUG) += -DDEBUG
 
 hid-sensors-y := hid-sensor-hub.o
+hid-sensors-y += hid-sensor-attributes.o
+hid-sensors-y += hid-sensor-buffer.o
+hid-sensors-y += hid-sensor-trigger.o
 obj-$(CONFIG_HID_SENSORS) += hid-sensors.o
diff --git a/drivers/staging/hid-sensors/hid-sensor-attributes.c b/drivers/staging/hid-sensors/hid-sensor-attributes.c
new file mode 100644
index 0000000..71eda1f
--- /dev/null
+++ b/drivers/staging/hid-sensors/hid-sensor-attributes.c
@@ -0,0 +1,169 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#include "iio/iio.h"
+#include "iio/sysfs.h"
+#include "hid-sensor-ids.h"
+#include "hid-sensor-interface.h"
+
+#define MAXIMUM_SAMP_FREQUENCY 1000
+
+ssize_t hid_sensor_read_samp_freq(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	__s32 value;
+	int len;
+	int ret;
+	int conv_value;
+
+	ret = sensor_hub_get_feature(st->hdev,
+			st->poll.report_id,
+			st->poll.index, &value);
+	if (ret < 0 || value <= 0)
+		len = sprintf(buf, "0\n");
+	else {
+		if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
+			conv_value = 1000/value;
+		else if (st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
+			conv_value = 1/value;
+		else
+			conv_value = value; /*Assume HZ*/
+		len = sprintf(buf, "%d\n", conv_value);
+	}
+	return len;
+}
+
+ssize_t hid_sensor_write_samp_freq(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	int value;
+	int conv_value;
+	int ret;
+
+	if (kstrtoint(buf, 10, &value) < 0)
+		return -EINVAL;
+
+	if (value > MAXIMUM_SAMP_FREQUENCY)
+		value = MAXIMUM_SAMP_FREQUENCY;
+
+	if (value && st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
+		conv_value = 1000/value;
+	else if (value && st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
+		conv_value = 1/value;
+	else
+		conv_value = value; /*Assume HZ*/
+
+	ret = sensor_hub_set_feature(st->hdev,
+		st->poll.report_id,
+		st->poll.index,
+		conv_value);
+
+	if (ret < 0)
+		return ret;
+	return strlen(buf);
+}
+
+ssize_t hid_sensor_read_hyst_raw(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	__s32 value;
+	int len;
+	int ret;
+
+	ret = sensor_hub_get_feature(st->hdev,
+		st->sensitivity.report_id,
+		st->sensitivity.index, &value);
+	if (ret < 0 || value < 0)
+		len = sprintf(buf, "0\n");
+	else
+		len = sprintf(buf, "units:%d,exp:%d,value:%d\n",
+				st->sensitivity.units,
+				st->sensitivity.unit_expo, value);
+	return len;
+}
+
+ssize_t hid_sensor_write_hyst_raw(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	int value;
+	int ret;
+
+	if (kstrtoint(buf, 10, &value) < 0)
+		return -EINVAL;
+
+	if (value <= 0)
+		value = 0;
+	ret = sensor_hub_set_feature(st->hdev,
+		st->sensitivity.report_id,
+		st->sensitivity.index,
+		value);
+
+	if (ret < 0)
+		return ret;
+
+	return strlen(buf);
+}
+
+int hid_sensor_parse_common_attributes(struct hid_device *hdev, u32 usage_id,
+					struct hid_sensor_attributes *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hdev,
+					HID_FEATURE_REPORT, usage_id,
+					HID_SENSOR_POLLING, &st->poll);
+
+	ret = sensor_hub_input_get_attribute_info(hdev,
+					HID_FEATURE_REPORT, usage_id,
+					HID_SENSOR_REPORT_STATE,
+					&st->activate);
+
+	ret = sensor_hub_input_get_attribute_info(hdev,
+			HID_FEATURE_REPORT, usage_id,
+			HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS,
+			 &st->sensitivity);
+
+	hid_dbg(hdev, "common attributes: %x:%x, %x:%x, %x:%x\n",
+			st->poll.index, st->poll.report_id,
+			st->activate.index, st->activate.report_id,
+			st->sensitivity.index, st->sensitivity.report_id);
+
+	return 0;
+}
diff --git a/drivers/staging/hid-sensors/hid-sensor-attributes.h b/drivers/staging/hid-sensors/hid-sensor-attributes.h
new file mode 100644
index 0000000..41f2db1
--- /dev/null
+++ b/drivers/staging/hid-sensors/hid-sensor-attributes.h
@@ -0,0 +1,51 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#ifndef _HID_SENSORS_ATTRIBUTES_H
+#define _HID_SENSORS_ATTRIBUTES_H
+
+/* Common sysfs attributes for HID sensors */
+
+int hid_sensor_parse_common_attributes(struct hid_device *hdev, u32 usage_id,
+					struct hid_sensor_attributes *st);
+ssize_t hid_sensor_read_hyst_raw(struct device *dev,
+				struct device_attribute *attr,
+				char *buf);
+ssize_t hid_sensor_write_hyst_raw(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len);
+ssize_t hid_sensor_read_samp_freq(struct device *dev,
+				struct device_attribute *attr,
+				char *buf);
+ssize_t hid_sensor_write_samp_freq(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len);
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			      hid_sensor_read_samp_freq,
+			      hid_sensor_write_samp_freq);
+
+#define IIO_DEV_ATTR_HYSTERESIS(_mode, _show, _store, _addr)        \
+	IIO_DEVICE_ATTR(hyst_raw, _mode, _show, _store, _addr)
+
+static IIO_DEV_ATTR_HYSTERESIS(S_IWUSR | S_IRUSR,
+			hid_sensor_read_hyst_raw,
+			hid_sensor_write_hyst_raw,
+			HID_USAGE_SENSOR_PROPERTY_CHANGE_SENSITIVITY_ABS);
+
+#endif
diff --git a/drivers/staging/hid-sensors/hid-sensor-buffer.c b/drivers/staging/hid-sensors/hid-sensor-buffer.c
new file mode 100644
index 0000000..8d5da0e
--- /dev/null
+++ b/drivers/staging/hid-sensors/hid-sensor-buffer.c
@@ -0,0 +1,98 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+#include "iio/iio.h"
+#include "iio/sysfs.h"
+#include "iio/trigger_consumer.h"
+#include "iio/trigger.h"
+#include "iio/kfifo_buf.h"
+
+static const struct iio_buffer_setup_ops hid_sensors_buffer_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
+};
+
+static irqreturn_t hid_sensor_trigger_handler(int irq, void *p)
+{
+	return IRQ_HANDLED;
+}
+
+void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+	s64 timestamp = iio_get_time_ns();
+	int datum_sz;
+
+	if (!buffer)
+		return;
+	datum_sz = buffer->access->get_bytes_per_datum(buffer);
+	if (len > datum_sz) {
+		dev_err(&indio_dev->dev, "Datum size mismatch %d:%d\n", len,
+				datum_sz);
+		return;
+	}
+	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+}
+
+int hid_sensor_configure_buffer(struct iio_dev *indio_dev)
+{
+	struct iio_buffer *buffer;
+	int ret = 0;
+
+	buffer = iio_kfifo_allocate(indio_dev);
+	if (!buffer)
+		return -ENOMEM;
+
+	buffer->scan_timestamp = true;
+	indio_dev->buffer = buffer;
+	indio_dev->setup_ops = &hid_sensors_buffer_setup_ops;
+
+	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+						 &hid_sensor_trigger_handler,
+						 IRQF_ONESHOT,
+						 indio_dev,
+						 "hid_sensor%d",
+						 indio_dev->id);
+	if (indio_dev->pollfunc == NULL) {
+		ret = -ENOMEM;
+		goto error_iio_free;
+	}
+
+	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
+	return ret;
+
+error_iio_free:
+	iio_kfifo_free(indio_dev->buffer);
+	return ret;
+}
+
+void hid_sensor_cleanup_buffer(struct iio_dev *indio_dev)
+{
+	iio_dealloc_pollfunc(indio_dev->pollfunc);
+	iio_kfifo_free(indio_dev->buffer);
+}
diff --git a/drivers/staging/hid-sensors/hid-sensor-interface.h b/drivers/staging/hid-sensors/hid-sensor-interface.h
index c388b6b..ec1bd43 100644
--- a/drivers/staging/hid-sensors/hid-sensor-interface.h
+++ b/drivers/staging/hid-sensors/hid-sensor-interface.h
@@ -75,4 +75,15 @@ int sensor_hub_input_attr_get_raw_value(struct hid_device *hdev, u32 usage_id,
 					u32 attr_usage_id, u32 report_id);
 int sensor_hub_input_get_unit_expo(struct hid_device *hdev, u32 field_usage_id,
 					s32 *unit, s32 *unit_expo);
+
+/* Common IIO Ring Processing Functions */
+int hid_sensor_configure_buffer(struct iio_dev *indio_dev);
+void hid_sensor_cleanup_buffer(struct iio_dev *indio_dev);
+void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data,
+								int len);
+
+/* Trigger functions */
+int hid_sensor_setup_trigger(struct iio_dev *indio_dev, char *name);
+void hid_sensor_remove_trigger(struct iio_dev *indio_dev);
+
 #endif
diff --git a/drivers/staging/hid-sensors/hid-sensor-trigger.c b/drivers/staging/hid-sensors/hid-sensor-trigger.c
new file mode 100644
index 0000000..1a4f6cd
--- /dev/null
+++ b/drivers/staging/hid-sensors/hid-sensor-trigger.c
@@ -0,0 +1,83 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+#include <linux/device.h>
+#include <linux/hid.h>
+#include <linux/usb.h>
+#include "usbhid/usbhid.h"
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "iio/iio.h"
+#include "iio/trigger.h"
+#include "hid-sensor-interface.h"
+
+static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
+						bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	int ret;
+	int state_val;
+
+	st->data_ready = state;
+	state_val = state ? 1 : 0;
+	ret = sensor_hub_set_feature(st->hdev, st->activate.report_id,
+					st->activate.index,
+					(s32)state_val);
+	return ret;
+}
+
+void hid_sensor_remove_trigger(struct iio_dev *indio_dev)
+{
+	iio_trigger_unregister(indio_dev->trig);
+	iio_free_trigger(indio_dev->trig);
+}
+
+static const struct iio_trigger_ops hid_sensor_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
+};
+
+int hid_sensor_setup_trigger(struct iio_dev *indio_dev, char *name)
+{
+	int ret;
+	struct iio_trigger *trig;
+
+	trig = iio_allocate_trigger("%s-dev%d", name, indio_dev->id);
+	if (trig == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	trig->dev.parent = indio_dev->dev.parent;
+	trig->private_data = (void *)indio_dev;
+	trig->ops = &hid_sensor_trigger_ops;
+	ret = iio_trigger_register(trig);
+
+	/* select default trigger */
+	indio_dev->trig = trig;
+	if (ret)
+		goto error_free_trig;
+
+	return ret;
+
+error_free_trig:
+	iio_free_trigger(trig);
+error_ret:
+	return ret;
+}
-- 
1.7.7.6
