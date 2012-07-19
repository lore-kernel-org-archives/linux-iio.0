Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jkosina@suse.cz,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 9/9] HID-Sensors: Added ALS
Date: Thu, 19 Jul 2012 11:17:31 -0700
Message-Id: <1342721851-2655-10-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1342721851-2655-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1342721851-2655-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added usage id processing for ALS. This uses IIO
interfaces for triggerred buffer to present data to user
mode.This uses HID sensor framework for registering callback
events from the sensor hub.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/iio/Kconfig                |    1 +
 drivers/iio/Makefile               |    1 +
 drivers/iio/light/Kconfig          |   16 ++
 drivers/iio/light/Makefile         |    6 +
 drivers/iio/light/hid-sensor-als.c |  397 ++++++++++++++++++++++++++++++++++++
 5 files changed, 421 insertions(+), 0 deletions(-)
 create mode 100644 drivers/iio/light/Kconfig
 create mode 100644 drivers/iio/light/Makefile
 create mode 100644 drivers/iio/light/hid-sensor-als.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index cdb3cfb..80b6b30 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -59,6 +59,7 @@ source "drivers/iio/adc/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/common/Kconfig"
 source "drivers/iio/gyro/Kconfig"
+source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 71b643a..e1aa434 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -15,4 +15,5 @@ obj-y += adc/
 obj-y += amplifiers/
 obj-y += common/
 obj-y += gyro/
+obj-y += light/
 obj-y += magnetometer/
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
new file mode 100644
index 0000000..6944c8b
--- /dev/null
+++ b/drivers/iio/light/Kconfig
@@ -0,0 +1,16 @@
+#
+# Light sensors
+#
+menu "Light sensors"
+
+config HID_SENSOR_ALS
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select HID_SENSOR_IIO_COMMON
+	tristate "HID ALS"
+	help
+	  Say yes here to build support for the HID SENSOR
+	  Ambient light sensor.
+
+endmenu
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
new file mode 100644
index 0000000..f14d94c
--- /dev/null
+++ b/drivers/iio/light/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for industrial I/O Light sensor drivers
+#
+
+hid-sensor-als-drv-y := hid-sensor-als.o
+obj-$(CONFIG_HID_SENSOR_ALS) += hid-sensor-als-drv.o
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
new file mode 100644
index 0000000..541ade3
--- /dev/null
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -0,0 +1,397 @@
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
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/hid-sensor-hub.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include "../common/hid-sensors/hid-sensor-attributes.h"
+#include "../common/hid-sensors/hid-sensor-trigger.h"
+
+/*Format: HID-SENSOR-usage_id_in_hex*/
+#define DRIVER_NAME "HID-SENSOR-200041"
+
+#define CHANNEL_SCAN_INDEX_ILLUM 0
+
+struct als_state {
+	struct hid_sensor_hub_attribute_info als_illum;
+	u32 illum;
+};
+
+/* Channel definitions */
+static struct iio_chan_spec als_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
+		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
+	}
+};
+
+/* Adjust channel real bits based on report descriptor */
+static void als_adjust_channel_bit_mask(int channel, int size)
+{
+	als_channels[channel].scan_type.sign = 's';
+	/* Real storage bits will change based on the report desc. */
+	als_channels[channel].scan_type.realbits = size * 8;
+	/* Maximum size of a sample to capture is u32 */
+	als_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+/* Channel read_raw handler */
+static int als_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state = st->private;
+	int report_id = -1;
+	u32 address;
+	int ret;
+
+	*val = 0;
+	*val2 = 0;
+	switch (mask) {
+	case 0:
+		switch (chan->scan_index) {
+		case  CHANNEL_SCAN_INDEX_ILLUM:
+			report_id = als_state->als_illum.report_id;
+			address =
+			HID_USAGE_SENSOR_LIGHT_ILLUM;
+			break;
+		default:
+			report_id = -1;
+			break;
+		}
+		if (report_id >= 0)
+			*val = sensor_hub_input_attr_get_raw_value(
+				st->hsdev,
+				HID_USAGE_SENSOR_ALS, address,
+				report_id);
+		else
+			*val = 0;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = als_state->als_illum.units;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = als_state->als_illum.unit_expo;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = hid_sensor_read_samp_freq_value(st, val, val2);
+		break;
+	case IIO_CHAN_INFO_HYSTERESIS:
+		ret = hid_sensor_read_raw_hyst_value(st, val, val2);
+		break;
+	default:
+		break;
+	}
+
+	if (*val2)
+		return IIO_VAL_INT_PLUS_MICRO;
+	else
+		return IIO_VAL_INT;
+}
+
+/* Channel write_raw handler */
+static int als_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = hid_sensor_write_samp_freq_value(st, val, val2);
+		break;
+	case IIO_CHAN_INFO_HYSTERESIS:
+		ret = hid_sensor_write_raw_hyst_value(st, val, val2);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int als_write_raw_get_fmt(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       long mask)
+{
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static const struct iio_info als_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &als_read_raw,
+	.write_raw = &als_write_raw,	
+	.write_raw_get_fmt = &als_write_raw_get_fmt,
+};
+
+/* Function to push data to buffer */
+void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
+{
+	struct iio_buffer *buffer = indio_dev->buffer;
+	s64 timestamp = iio_get_time_ns();
+	int datum_sz;
+
+	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
+	if (!buffer) {
+		dev_err(&indio_dev->dev, "Buffer == NULL\n");
+		return;
+	}
+	datum_sz = buffer->access->get_bytes_per_datum(buffer);
+	if (len > datum_sz) {
+		dev_err(&indio_dev->dev, "Datum size mismatch %d:%d\n", len,
+				datum_sz);
+		return;
+	}
+	buffer->access->store_to(buffer, (u8 *)data, timestamp);
+}
+
+/* Callback handler to send event after all samples are received and captured */
+int als_proc_event(struct hid_sensor_hub_device *hsdev, unsigned usage_id,
+			void *priv)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(priv);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state = st->private;
+
+	dev_dbg(&indio_dev->dev, "als_proc_event [%d]\n", st->data_ready);
+	if (st->data_ready)
+		hid_sensor_push_data(indio_dev,
+				(u8 *)&als_state->illum,
+				sizeof(als_state->illum));
+
+	return 0;
+}
+
+/* Capture samples in local storage */
+int als_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				size_t raw_len, char *raw_data,
+				void *priv)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(priv);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state = st->private;
+	int ret = -EINVAL;
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_LIGHT_ILLUM:
+		als_state->illum = *(u32 *)raw_data;
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/* Parse report which is specific to an usage id*/
+static int als_parse_report(struct platform_device *pdev,
+				struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				struct als_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_LIGHT_ILLUM,
+			&st->als_illum);
+	als_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_ILLUM,
+					st->als_illum.size);
+
+	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum.index,
+			st->als_illum.report_id);
+
+	return ret;
+}
+
+/* Function to initialize the processing for usage id */
+static int als_init(struct platform_device *pdev,
+			struct hid_sensor_hub_device *hsdev,
+			unsigned usage_id)
+{
+	int ret = 0;
+	static char *name = "als";
+	struct iio_dev *indio_dev;
+	struct als_state *als_state;
+	struct hid_sensor_attributes *st;
+
+	als_state = kzalloc(sizeof(struct als_state), GFP_KERNEL);
+	if (als_state == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	indio_dev = iio_device_alloc(sizeof(struct hid_sensor_attributes));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_free_state;
+	}
+	platform_set_drvdata(pdev, indio_dev);
+	/* Using the common structure among all HID sensors as private so that
+	common modules don't have to have knowledge about per sensor data
+	structure. For example the trigger handler can activate device from
+	common module without having any sensor specific data instance.*/
+	st = iio_priv(indio_dev);
+	st->hsdev = hsdev;
+	st->pdev = pdev;
+	st->private = (void *)als_state;
+
+	ret = hid_sensor_parse_common_attributes(hsdev, usage_id, st);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		goto error_free_dev;
+	}
+
+	ret = als_parse_report(pdev, hsdev, usage_id, als_state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = kmemdup(als_channels,
+					sizeof(als_channels),
+					GFP_KERNEL);
+	if (!indio_dev->channels) {
+		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->num_channels =
+				ARRAY_SIZE(als_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &als_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		NULL, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
+		goto error_free_dev_mem;
+	}
+	st->data_ready = false;
+	ret = hid_sensor_setup_trigger(indio_dev, name);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "trigger setup failed\n");
+		goto error_unreg_buffer_funcs;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "device register failed\n");
+		goto error_remove_trigger;
+	}
+	return ret;
+
+error_remove_trigger:
+	hid_sensor_remove_trigger(indio_dev);
+error_unreg_buffer_funcs:
+	iio_triggered_buffer_cleanup(indio_dev);
+error_free_dev_mem:
+	kfree(indio_dev->channels);
+error_free_dev:
+	iio_device_free(indio_dev);
+error_free_state:
+	kfree(als_state);
+error_ret:
+	return ret;
+}
+
+/* Function to deinitialize the processing for usage id */
+static int als_exit(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state = st->private;
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	kfree(indio_dev->channels);
+	iio_device_free(indio_dev);
+	kfree(als_state);
+
+	return ret;
+}
+
+static struct hid_sensor_hub_callbacks als_callbacks = {
+	.send_event = als_proc_event,
+	.capture_sample = als_capture_sample,
+};
+
+static int __devinit hid_als_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+
+	ret = als_init(pdev, hsdev, HID_USAGE_SENSOR_ALS);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "als_init failed\n");
+		return ret;
+	}
+	als_callbacks.pdev = pdev;
+	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ALS,
+					&als_callbacks);
+
+	return 0;
+}
+
+static int __devinit hid_als_remove(struct platform_device *pdev)
+{
+	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+
+	als_exit(pdev);
+
+	return sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
+}
+
+static struct platform_driver hid_als_platform_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hid_als_probe,
+	.remove		= hid_als_remove,
+};
+module_platform_driver(hid_als_platform_driver);
+
+MODULE_DESCRIPTION("HID Sensor ALS");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.7.6
