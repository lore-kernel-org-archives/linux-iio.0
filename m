Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jkosina@suse.cz,
	srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 8/9] HID-Sensors: Added Compass/Magnetometer 3D
Date: Thu, 19 Jul 2012 11:17:30 -0700
Message-Id: <1342721851-2655-9-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1342721851-2655-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1342721851-2655-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added usage id processing for Compass 3D. This uses IIO
interfaces for triggerred buffer to present data to user
mode.This uses HID sensor framework for registering callback
events from the sensor hub.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/iio/Kconfig                           |    1 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/magnetometer/Kconfig              |   16 +
 drivers/iio/magnetometer/Makefile             |    6 +
 drivers/iio/magnetometer/hid-sensor-magn-3d.c |  431 +++++++++++++++++++++++++
 5 files changed, 455 insertions(+), 0 deletions(-)
 create mode 100644 drivers/iio/magnetometer/Kconfig
 create mode 100644 drivers/iio/magnetometer/Makefile
 create mode 100644 drivers/iio/magnetometer/hid-sensor-magn-3d.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 20212af..cdb3cfb 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -59,5 +59,6 @@ source "drivers/iio/adc/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/common/Kconfig"
 source "drivers/iio/gyro/Kconfig"
+source "drivers/iio/magnetometer/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 7660bc4..71b643a 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -15,3 +15,4 @@ obj-y += adc/
 obj-y += amplifiers/
 obj-y += common/
 obj-y += gyro/
+obj-y += magnetometer/
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
new file mode 100644
index 0000000..c1f0cdd
--- /dev/null
+++ b/drivers/iio/magnetometer/Kconfig
@@ -0,0 +1,16 @@
+#
+# Magnetometer sensors
+#
+menu "Magnetometer sensors"
+
+config HID_SENSOR_MAGNETOMETER_3D
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select HID_SENSOR_IIO_COMMON
+	tristate "HID Magenetometer 3D"
+	help
+	  Say yes here to build support for the HID SENSOR
+	  Magnetometer 3D.
+
+endmenu
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
new file mode 100644
index 0000000..cb26b44
--- /dev/null
+++ b/drivers/iio/magnetometer/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for industrial I/O Magnetometer sensor drivers
+#
+
+hid-sensor-magn-3d-drv-y := hid-sensor-magn-3d.o
+obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d-drv.o
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
new file mode 100644
index 0000000..bebd6e2
--- /dev/null
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -0,0 +1,431 @@
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
+#define DRIVER_NAME "HID-SENSOR-200083"
+
+enum magn_3d_channel{
+	CHANNEL_SCAN_INDEX_X,
+	CHANNEL_SCAN_INDEX_Y,
+	CHANNEL_SCAN_INDEX_Z,
+	MAGN_3D_CHANNEL_MAX,
+};
+
+struct magn_3d_state {
+	struct hid_sensor_hub_attribute_info magn[MAGN_3D_CHANNEL_MAX];
+	u32 magn_val[MAGN_3D_CHANNEL_MAX];
+};
+
+const u32 magn_3d_addresses[MAGN_3D_CHANNEL_MAX] = {
+	HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_X_AXIS,
+	HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_Y_AXIS,
+	HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_Z_AXIS
+};
+
+/* Channel definitions */
+static struct iio_chan_spec magn_3d_channels[] = {
+	{
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
+		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_X,
+	}, {
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
+		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_Y,
+	}, {
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		IIO_CHAN_INFO_SAMP_FREQ_SHARED_BIT |
+		IIO_CHAN_INFO_HYSTERESIS_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_Z,
+	}
+};
+
+/* Adjust channel real bits based on report descriptor */
+static void magn_3d_adjust_channel_bit_mask(int channel, int size)
+{
+	magn_3d_channels[channel].scan_type.sign = 's';
+	/* Real storage bits will change based on the report desc. */
+	magn_3d_channels[channel].scan_type.realbits = size * 8;
+	/* Maximum size of a sample to capture is u32 */
+	magn_3d_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+/* Channel read_raw handler */
+static int magn_3d_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct magn_3d_state *magn_state = st->private;
+	int report_id = -1;
+	u32 address;
+	int ret;
+
+	*val = 0;
+	*val2 = 0;
+	switch (mask) {
+	case 0:
+		report_id =
+			magn_state->magn[chan->scan_index].report_id;
+		address = magn_3d_addresses[chan->scan_index];
+		if (report_id >= 0)
+			*val = sensor_hub_input_attr_get_raw_value(
+				st->hsdev,
+				HID_USAGE_SENSOR_COMPASS_3D, address,
+				report_id);
+		else
+			*val = 0;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = magn_state->magn[CHANNEL_SCAN_INDEX_X].units;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = magn_state->magn[CHANNEL_SCAN_INDEX_X].unit_expo;
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
+static int magn_3d_write_raw(struct iio_dev *indio_dev,
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
+static int magn_3d_write_raw_get_fmt(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       long mask)
+{
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static const struct iio_info magn_3d_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &magn_3d_read_raw,
+	.write_raw = &magn_3d_write_raw,	
+	.write_raw_get_fmt = &magn_3d_write_raw_get_fmt,
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
+int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev, unsigned usage_id,
+			void *priv)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(priv);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct magn_3d_state *magn_state = st->private;
+
+	dev_dbg(&indio_dev->dev, "magn_3d_proc_event [%d]\n", st->data_ready);
+	if (st->data_ready)
+		hid_sensor_push_data(indio_dev,
+				(u8 *)magn_state->magn_val,
+				sizeof(magn_state->magn_val));
+
+	return 0;
+}
+
+/* Capture samples in local storage */
+int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				size_t raw_len, char *raw_data,
+				void *priv)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(priv);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct magn_3d_state *magn_state = st->private;
+	int offset;
+	int ret = -EINVAL;
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_X_AXIS:
+	case HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_Y_AXIS:
+	case HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_Z_AXIS:
+		offset = usage_id - HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_X_AXIS;
+		magn_state->magn_val[CHANNEL_SCAN_INDEX_X + offset] =
+						*(u32 *)raw_data;
+		ret = 0;
+	break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/* Parse report which is specific to an usage id*/
+static int magn_3d_parse_report(struct platform_device *pdev,
+				struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				struct magn_3d_state *st)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i <= CHANNEL_SCAN_INDEX_Z; ++i) {
+		ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+				usage_id,
+				HID_USAGE_SENSOR_ORIENT_MAGN_FLUX_X_AXIS + i,
+				&st->magn[CHANNEL_SCAN_INDEX_X + i]);
+		magn_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_X + i,
+				st->magn[CHANNEL_SCAN_INDEX_X + i].size);
+		if (ret < 0)
+			break;
+	}
+	dev_dbg(&pdev->dev, "magn_3d %x:%x, %x:%x, %x:%x\n",
+			st->magn[0].index,
+			st->magn[0].report_id,
+			st->magn[1].index, st->magn[1].report_id,
+			st->magn[2].index, st->magn[2].report_id);
+
+	return ret;
+}
+
+/* Function to initialize the processing for usage id */
+static int magn_3d_init(struct platform_device *pdev,
+			struct hid_sensor_hub_device *hsdev,
+			unsigned usage_id)
+{
+	int ret = 0;
+	static char *name = "magn_3d";
+	struct iio_dev *indio_dev;
+	struct magn_3d_state *magn_state;
+	struct hid_sensor_attributes *st;
+
+	magn_state = kzalloc(sizeof(struct magn_3d_state), GFP_KERNEL);
+	if (magn_state == NULL) {
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
+	st->private = (void *)magn_state;
+
+	ret = hid_sensor_parse_common_attributes(hsdev, usage_id, st);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		goto error_free_dev;
+	}
+
+	ret = magn_3d_parse_report(pdev, hsdev, usage_id, magn_state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = kmemdup(magn_3d_channels,
+					sizeof(magn_3d_channels),
+					GFP_KERNEL);
+	if (!indio_dev->channels) {
+		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->num_channels =
+				ARRAY_SIZE(magn_3d_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &magn_3d_info;
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
+	kfree(magn_state);
+error_ret:
+	return ret;
+}
+
+/* Function to deinitialize the processing for usage id */
+static int magn_3d_exit(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct magn_3d_state *magn_state = st->private;
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	kfree(indio_dev->channels);
+	iio_device_free(indio_dev);
+	kfree(magn_state);
+
+	return ret;
+}
+
+static struct hid_sensor_hub_callbacks magn_3d_callbacks = {
+	.send_event = magn_3d_proc_event,
+	.capture_sample = magn_3d_capture_sample,
+};
+
+static int __devinit hid_magn_3d_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+
+	ret = magn_3d_init(pdev, hsdev, HID_USAGE_SENSOR_COMPASS_3D);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "magn_3d_init failed\n");
+		return ret;
+	}
+	magn_3d_callbacks.pdev = pdev;
+	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D,
+					&magn_3d_callbacks);
+
+	return 0;
+}
+
+static int __devinit hid_magn_3d_remove(struct platform_device *pdev)
+{
+	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+
+	magn_3d_exit(pdev);
+
+	return sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
+}
+
+static struct platform_driver hid_magn_3d_platform_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hid_magn_3d_probe,
+	.remove		= hid_magn_3d_remove,
+};
+module_platform_driver(hid_magn_3d_platform_driver);
+
+MODULE_DESCRIPTION("HID Sensor Magnetometer 3D");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@intel.com>");
+MODULE_LICENSE("GPL");
-- 
1.7.7.6
