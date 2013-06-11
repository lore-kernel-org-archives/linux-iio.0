Return-Path: <alexandre@relange.org>
From: Alexandre Relange <alexandre@relange.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Alexandre Relange <alexandre@relange.org>
Subject: [PATCH 4/5] iio: mechanical: new HID sensor boolean switch
Date: Tue, 11 Jun 2013 16:52:15 +0200
Message-Id: <1370962336-20739-4-git-send-email-alexandre@relange.org>
In-Reply-To: <1370962336-20739-1-git-send-email-alexandre@relange.org>
References: <1370962336-20739-1-git-send-email-alexandre@relange.org>
List-ID: <linux-iio@vger.kernel.org>

Implements the Boolean Switch sensor from the USB sensor usage tables
http://www.usb.org/developers/hidpage/HUTRR39b.pdf

This code is based on drivers/iio/light/hid-sensor-als.c

Signed-off-by: Alexandre Relange <alexandre@relange.org>
---
 drivers/iio/mechanical/Kconfig             |  14 ++
 drivers/iio/mechanical/Makefile            |   1 +
 drivers/iio/mechanical/hid-sensor-switch.c | 359 +++++++++++++++++++++++++++++
 include/linux/hid-sensor-ids.h             |   4 +
 4 files changed, 378 insertions(+)
 create mode 100644 drivers/iio/mechanical/hid-sensor-switch.c

diff --git a/drivers/iio/mechanical/Kconfig b/drivers/iio/mechanical/Kconfig
index b536fa2..e449588 100644
--- a/drivers/iio/mechanical/Kconfig
+++ b/drivers/iio/mechanical/Kconfig
@@ -3,4 +3,18 @@
 #
 menu "Mechanical sensors"
 
+config HID_SENSOR_SWITCH
+	depends on HID_SENSOR_HUB
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select HID_SENSOR_IIO_COMMON
+	select HID_SENSOR_IIO_TRIGGER
+	tristate "HID Boolean Switch"
+	help
+	  Say yes here to build support for the HID SENSOR
+	  Boolean Switch sensor.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called hid-sensor-switch.
+
 endmenu
diff --git a/drivers/iio/mechanical/Makefile b/drivers/iio/mechanical/Makefile
index 716098f..30931c5 100644
--- a/drivers/iio/mechanical/Makefile
+++ b/drivers/iio/mechanical/Makefile
@@ -1,3 +1,4 @@
 #
 # Makefile for IIO Mechanical sensors
 #
+obj-$(CONFIG_HID_SENSOR_SWITCH)	+= hid-sensor-switch.o
diff --git a/drivers/iio/mechanical/hid-sensor-switch.c b/drivers/iio/mechanical/hid-sensor-switch.c
new file mode 100644
index 0000000..7027305
--- /dev/null
+++ b/drivers/iio/mechanical/hid-sensor-switch.c
@@ -0,0 +1,359 @@
+/*
+ * HID Sensors Driver
+ * Copyright (c) 2012, Intel Corporation.
+ * Copyright (c) 2013, Alexandre Relange
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
+#include "../common/hid-sensors/hid-sensor-trigger.h"
+
+/*Format: HID-SENSOR-usage_id_in_hex*/
+/*Usage ID from spec for Boolean-Switch: 0x200061*/
+#define DRIVER_NAME "HID-SENSOR-200061"
+
+#define CHANNEL_SCAN_INDEX_SWITCH 0
+
+struct switch_state {
+	struct hid_sensor_hub_callbacks callbacks;
+	struct hid_sensor_common common_attributes;
+	struct hid_sensor_hub_attribute_info switch_attr;
+	u32 value;
+};
+
+/* Channel definitions */
+static const struct iio_chan_spec switch_channels[] = {
+	{
+		.type = IIO_STATE,
+		.info_mask_shared_by_type =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+			BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.scan_index = CHANNEL_SCAN_INDEX_SWITCH,
+	}
+};
+
+/* Adjust channel real bits based on report descriptor */
+static void switch_adjust_channel_bit_mask(struct iio_chan_spec *channels,
+					int channel, int size)
+{
+	channels[channel].scan_type.sign = 'u';
+	/* Real storage bits will change based on the report desc. */
+	channels[channel].scan_type.realbits = size * 8;
+	/* Maximum size of a sample to capture is u32 */
+	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+/* Channel read_raw handler */
+static int switch_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct switch_state *switch_state = iio_priv(indio_dev);
+	int report_id = -1;
+	u32 address;
+	int ret;
+	int ret_type;
+
+	*val = 0;
+	*val2 = 0;
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->scan_index) {
+		case  CHANNEL_SCAN_INDEX_SWITCH:
+			report_id = switch_state->switch_attr.report_id;
+			address =
+			HID_USAGE_SENSOR_MECHA_BOOL_SWITCH_STATE;
+			break;
+		default:
+			report_id = -1;
+			break;
+		}
+		if (report_id >= 0)
+			*val = sensor_hub_input_attr_get_raw_value(
+				switch_state->common_attributes.hsdev,
+				HID_USAGE_SENSOR_MECHA_BOOL_SWITCH, address,
+				report_id);
+		else {
+			*val = 0;
+			return -EINVAL;
+		}
+		ret_type = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = hid_sensor_read_samp_freq_value(
+				&switch_state->common_attributes, val, val2);
+		ret_type = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case IIO_CHAN_INFO_HYSTERESIS:
+		ret = hid_sensor_read_raw_hyst_value(
+				&switch_state->common_attributes, val, val2);
+		ret_type = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	default:
+		ret_type = -EINVAL;
+		break;
+	}
+
+	return ret_type;
+}
+
+/* Channel write_raw handler */
+static int switch_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	struct switch_state *switch_state = iio_priv(indio_dev);
+	int ret = 0;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = hid_sensor_write_samp_freq_value(
+				&switch_state->common_attributes, val, val2);
+		break;
+	case IIO_CHAN_INFO_HYSTERESIS:
+		ret = hid_sensor_write_raw_hyst_value(
+				&switch_state->common_attributes, val, val2);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int switch_write_raw_get_fmt(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       long mask)
+{
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static const struct iio_info switch_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &switch_read_raw,
+	.write_raw = &switch_write_raw,
+	.write_raw_get_fmt = &switch_write_raw_get_fmt,
+};
+
+/* Function to push data to buffer */
+static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
+{
+	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
+	iio_push_to_buffers(indio_dev, (u8 *)data);
+}
+
+/* Callback handler to send event after all samples are received and captured */
+static int switch_proc_event(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				void *priv)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(priv);
+	struct switch_state *switch_state = iio_priv(indio_dev);
+
+	dev_dbg(&indio_dev->dev, "switch_proc_event [%d]\n",
+				switch_state->common_attributes.data_ready);
+	if (switch_state->common_attributes.data_ready)
+		hid_sensor_push_data(indio_dev,
+				(u8 *)&switch_state->value,
+				sizeof(switch_state->value));
+
+	return 0;
+}
+
+/* Capture samples in local storage */
+static int switch_capture_sample(struct hid_sensor_hub_device *hsdev,
+				unsigned usage_id,
+				size_t raw_len, char *raw_data,
+				void *priv)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(priv);
+	struct switch_state *switch_state = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_MECHA_BOOL_SWITCH_STATE:
+		switch_state->value = *(u32 *)raw_data;
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
+static int switch_parse_report(struct platform_device *pdev,
+				struct hid_sensor_hub_device *hsdev,
+				struct iio_chan_spec *channels,
+				unsigned usage_id,
+				struct switch_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hsdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_MECHA_BOOL_SWITCH_STATE,
+			&st->switch_attr);
+	if (ret < 0)
+		return ret;
+	switch_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_SWITCH,
+					st->switch_attr.size);
+
+	dev_dbg(&pdev->dev, "switch %x:%x\n", st->switch_attr.index,
+			st->switch_attr.report_id);
+
+	return ret;
+}
+
+/* Function to initialize the processing for usage id */
+static int hid_switch_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	static const char *name = "switch";
+	struct iio_dev *indio_dev;
+	struct switch_state *switch_state;
+	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	struct iio_chan_spec *channels;
+
+	indio_dev = iio_device_alloc(sizeof(struct switch_state));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	platform_set_drvdata(pdev, indio_dev);
+
+	switch_state = iio_priv(indio_dev);
+	switch_state->common_attributes.hsdev = hsdev;
+	switch_state->common_attributes.pdev = pdev;
+
+	ret = hid_sensor_parse_common_attributes(hsdev, HID_USAGE_SENSOR_MECHA_BOOL_SWITCH,
+					&switch_state->common_attributes);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup common attributes\n");
+		goto error_free_dev;
+	}
+
+	channels = kmemdup(switch_channels, sizeof(switch_channels), GFP_KERNEL);
+	if (!channels) {
+		ret = -ENOMEM;
+		dev_err(&pdev->dev, "failed to duplicate channels\n");
+		goto error_free_dev;
+	}
+
+	ret = switch_parse_report(pdev, hsdev, channels,
+				HID_USAGE_SENSOR_MECHA_BOOL_SWITCH, switch_state);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to setup attributes\n");
+		goto error_free_dev_mem;
+	}
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels =
+				ARRAY_SIZE(switch_channels);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &switch_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		NULL, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
+		goto error_free_dev_mem;
+	}
+	switch_state->common_attributes.data_ready = false;
+	ret = hid_sensor_setup_trigger(indio_dev, name,
+				&switch_state->common_attributes);
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
+
+	switch_state->callbacks.send_event = switch_proc_event;
+	switch_state->callbacks.capture_sample = switch_capture_sample;
+	switch_state->callbacks.pdev = pdev;
+	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_MECHA_BOOL_SWITCH,
+					&switch_state->callbacks);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "callback reg failed\n");
+		goto error_iio_unreg;
+	}
+
+	return ret;
+
+error_iio_unreg:
+	iio_device_unregister(indio_dev);
+error_remove_trigger:
+	hid_sensor_remove_trigger(indio_dev);
+error_unreg_buffer_funcs:
+	iio_triggered_buffer_cleanup(indio_dev);
+error_free_dev_mem:
+	kfree(indio_dev->channels);
+error_free_dev:
+	iio_device_free(indio_dev);
+error_ret:
+	return ret;
+}
+
+/* Function to deinitialize the processing for usage id */
+static int hid_switch_remove(struct platform_device *pdev)
+{
+	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+
+	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_MECHA_BOOL_SWITCH);
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	kfree(indio_dev->channels);
+	iio_device_free(indio_dev);
+
+	return 0;
+}
+
+static struct platform_driver hid_switch_platform_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hid_switch_probe,
+	.remove		= hid_switch_remove,
+};
+module_platform_driver(hid_switch_platform_driver);
+
+MODULE_DESCRIPTION("HID Sensor Boolean Switch");
+MODULE_AUTHOR("Alexandre Relange <alexandre@relange.org>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 6f24446..e469078 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -31,6 +31,10 @@
 #define HID_USAGE_SENSOR_ALS					0x200041
 #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
 
+/* MECHANICAL: Boolean Switch: (200061) */
+#define HID_USAGE_SENSOR_MECHA_BOOL_SWITCH			0x200061
+#define HID_USAGE_SENSOR_MECHA_BOOL_SWITCH_STATE		0x200491
+
 /* Gyro 3D: (200076) */
 #define HID_USAGE_SENSOR_GYRO_3D				0x200076
 #define HID_USAGE_SENSOR_ANGL_VELOCITY_X_AXIS			0x200457
-- 
1.8.3
