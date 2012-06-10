Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jiri Kosina <jkosina@suse.cz>,
	Srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 5/8] HID-Sensors: Added accelerometer 3D
Date: Sat,  9 Jun 2012 18:53:15 -0700
Message-Id: <1339293198-10404-6-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

From: Srinivas pandruvada <srinivas.pandruvada@intel.com>

Added usage id processing for Accelrometer 3D. This uses IIO
interfaces "buffer and trigger interface" to present
data to user mode.

Signed-off-by: Srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/staging/hid-sensors/Makefile               |    1 +
 drivers/staging/hid-sensors/hid-sensor-accel-3d.c  |  375 ++++++++++++++++++++
 drivers/staging/hid-sensors/hid-sensor-hub.c       |    1 +
 drivers/staging/hid-sensors/hid-sensor-interface.h |    3 +
 4 files changed, 380 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-accel-3d.c

diff --git a/drivers/staging/hid-sensors/Makefile b/drivers/staging/hid-sensors/Makefile
index 123e7fa..1b86473 100644
--- a/drivers/staging/hid-sensors/Makefile
+++ b/drivers/staging/hid-sensors/Makefile
@@ -9,4 +9,5 @@ hid-sensors-y := hid-sensor-hub.o
 hid-sensors-y += hid-sensor-attributes.o
 hid-sensors-y += hid-sensor-buffer.o
 hid-sensors-y += hid-sensor-trigger.o
+hid-sensors-y += hid-sensor-accel-3d.o
 obj-$(CONFIG_HID_SENSORS) += hid-sensors.o
diff --git a/drivers/staging/hid-sensors/hid-sensor-accel-3d.c b/drivers/staging/hid-sensors/hid-sensor-accel-3d.c
new file mode 100644
index 0000000..eb917ff
--- /dev/null
+++ b/drivers/staging/hid-sensors/hid-sensor-accel-3d.c
@@ -0,0 +1,375 @@
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
+#include "iio/sysfs.h"
+#include "iio/ring_sw.h"
+#include "iio/trigger.h"
+#include "hid-sensor-ids.h"
+#include "hid-sensor-interface.h"
+#include "hid-sensor-attributes.h"
+
+#define CHANNEL_SCAN_INDEX_X 0
+#define CHANNEL_SCAN_INDEX_Y 1
+#define CHANNEL_SCAN_INDEX_Z 2
+
+struct accel_3d_sample {
+	u32 accel_x;
+	u32 accel_y;
+	u32 accel_z;
+} __packed;
+
+struct accel_3d_state {
+	struct hid_sensor_hub_attribute_info accel_x;
+	struct hid_sensor_hub_attribute_info accel_y;
+	struct hid_sensor_hub_attribute_info accel_z;
+	struct accel_3d_sample accel_sample_data;
+};
+
+static struct iio_chan_spec accel_3d_channels[] = {
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_X,
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_Y,
+	}, {
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_Z,
+	}
+};
+
+static void accel_3d_adjust_channel_bit_mask(int channel, int size)
+{
+	accel_3d_channels[channel].scan_type.sign = 's';
+	accel_3d_channels[channel].scan_type.realbits = size * 8;
+	accel_3d_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+static int accel_3d_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct accel_3d_state *accel_state =
+			(struct accel_3d_state *)st->private;
+	int report_id = -1;
+	u32 address;
+
+	*val = 0;
+	*val2 = 0;
+
+	switch (mask) {
+	case 0:
+		switch (chan->scan_index) {
+		case  CHANNEL_SCAN_INDEX_X:
+			report_id = accel_state->accel_x.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS;
+			break;
+		case  CHANNEL_SCAN_INDEX_Y:
+			report_id = accel_state->accel_y.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS;
+			break;
+		case  CHANNEL_SCAN_INDEX_Z:
+			report_id = accel_state->accel_z.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS;
+			break;
+		default:
+			report_id = -1;
+			break;
+		}
+		if (report_id >= 0)
+			*val = sensor_hub_input_attr_get_raw_value(st->hdev,
+				 HID_USAGE_SENSOR_ACCEL_3D, address,
+				 report_id);
+		else
+			*val = 0;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = accel_state->accel_x.units;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = accel_state->accel_x.unit_expo;
+		break;
+	default:
+		break;
+
+	}
+	return IIO_VAL_INT;
+}
+
+static int accel_3d_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	printk(KERN_ERR "%s\n", __func__);
+
+	return 0;
+}
+
+static struct attribute *accel_3d_attributes[] = {
+	/* common attributes */
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_hyst_raw.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group accel_3d_attribute_group = {
+	.attrs = accel_3d_attributes,
+};
+
+static const struct iio_info accel_3d_info = {
+	.attrs = &accel_3d_attribute_group,
+	.driver_module = THIS_MODULE,
+	.read_raw = &accel_3d_read_raw,
+	.write_raw = &accel_3d_write_raw,
+};
+
+/* Function to push data to IIO ring */
+int accel_3d_proc_event(struct hid_device *hdev, unsigned usage_id, void *priv)
+{
+	struct iio_dev *indio_dev = (struct iio_dev *)priv;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct accel_3d_state *accel_state =
+			(struct accel_3d_state *)st->private;
+
+	hid_dbg(hdev, "accel_3d_proc_event\n");
+	if (st->data_ready)
+		hid_sensor_push_data(indio_dev,
+				(u8 *)&accel_state->accel_sample_data,
+				sizeof(struct accel_3d_sample));
+	else
+		hid_dbg(hdev, "accel_3d_proc_event data not ready\n");
+	return 0;
+}
+
+/* Capture samples in local storage */
+int accel_3d_capture_sample(struct hid_device *hdev, unsigned usage_id,
+				 size_t raw_len, char *raw_data, void *priv)
+{
+	struct iio_dev *indio_dev = (struct iio_dev *)priv;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct accel_3d_state *accel_state =
+			(struct accel_3d_state *)st->private;
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS:
+		accel_state->accel_sample_data.accel_x =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS:
+		accel_state->accel_sample_data.accel_y =
+		*(u32 *)raw_data;
+		break;
+	case HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS:
+		accel_state->accel_sample_data.accel_z =
+		*(u32 *)raw_data;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+/* Parse report which is specific to an usage id*/
+static int accel_3d_parse_report(struct hid_device *hdev, unsigned usage_id,
+				struct accel_3d_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_X_AXIS,
+			&st->accel_x);
+	if (!ret)
+		hid_dbg(hdev, "No Accel X attribute\n");
+	accel_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_X,
+					st->accel_x.size);
+
+	ret = sensor_hub_input_get_attribute_info(hdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Y_AXIS,
+			&st->accel_y);
+	if (!ret)
+		hid_dbg(hdev, "No Accel Y attribute\n");
+	accel_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Y,
+					st->accel_y.size);
+
+	ret = sensor_hub_input_get_attribute_info(hdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_MOTION_ACCELERATION_Z_AXIS,
+			&st->accel_z);
+	if (!ret)
+		hid_dbg(hdev, "No Accel Z attribute\n");
+	accel_3d_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_Z,
+					st->accel_z.size);
+
+	hid_dbg(hdev, "accel_3d %x:%x, %x:%x, %x:%x\n", st->accel_x.index,
+			st->accel_x.report_id,
+			st->accel_y.index, st->accel_y.report_id,
+			st->accel_z.index, st->accel_z.report_id);
+
+	return 0;
+}
+
+/* Entry function to initialize the processing for usage id */
+static int accel_3d_enter(struct hid_device *hdev, unsigned usage_id,
+				void **priv)
+{
+	int ret = 0;
+	static char *name = "accel_3d";
+	struct iio_dev *indio_dev;
+	struct accel_3d_state *accel_state;
+	struct hid_sensor_attributes *st;
+
+	accel_state = kzalloc(sizeof(struct accel_3d_state), GFP_KERNEL);
+	if (accel_state == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	indio_dev = iio_allocate_device(sizeof(struct hid_sensor_attributes));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_free_state;
+	}
+	st = iio_priv(indio_dev);
+	st->usage_id = usage_id;
+	st->hdev = hdev;
+	st->private = (void *)accel_state;
+
+	ret = hid_sensor_parse_common_attributes(hdev, usage_id, st);
+	if (ret) {
+		hid_err(hdev, "failed to setup common attributes\n");
+		goto error_free_dev;
+	}
+	ret = accel_3d_parse_report(hdev, usage_id, accel_state);
+	if (ret) {
+		hid_err(hdev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = accel_3d_channels;
+	indio_dev->num_channels =
+				ARRAY_SIZE(accel_3d_channels);
+	indio_dev->dev.parent = &hdev->dev;
+	indio_dev->info = &accel_3d_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = hid_sensor_configure_buffer(indio_dev);
+	if (ret) {
+		hid_err(hdev, "failed to initialize the ring\n");
+		goto error_free_dev;
+	}
+
+	ret = iio_buffer_register(indio_dev,
+					accel_3d_channels,
+					ARRAY_SIZE(accel_3d_channels));
+	if (ret) {
+		hid_err(hdev, "failed to initialize the ring\n");
+		goto error_unreg_ring_funcs;
+	}
+	iio_scan_mask_set(indio_dev, indio_dev->buffer,
+			   CHANNEL_SCAN_INDEX_X);
+	iio_scan_mask_set(indio_dev, indio_dev->buffer,
+			   CHANNEL_SCAN_INDEX_Y);
+	iio_scan_mask_set(indio_dev, indio_dev->buffer,
+			   CHANNEL_SCAN_INDEX_Z);
+	st->data_ready = true;
+	ret = hid_sensor_setup_trigger(indio_dev, name);
+	if (ret < 0) {
+		hid_err(hdev, "trigger setup failed\n");
+		goto error_uninit_ring;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		hid_err(hdev, "device register failed\n");
+		goto error_remove_trigger;
+	}
+	*priv = (void *)indio_dev;
+	return ret;
+
+error_remove_trigger:
+		hid_sensor_remove_trigger(indio_dev);
+error_uninit_ring:
+		iio_buffer_unregister(indio_dev);
+error_unreg_ring_funcs:
+		hid_sensor_cleanup_buffer(indio_dev);
+error_free_dev:
+		iio_free_device(indio_dev);
+error_free_state:
+		kfree(accel_state);
+error_ret:
+		return ret;
+}
+
+static int accel_3d_exit(struct hid_device *hdev, void *priv)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = (struct iio_dev *)priv;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct accel_3d_state *accel_state =
+			(struct accel_3d_state *)st->private;
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_buffer_unregister(indio_dev);
+	hid_sensor_cleanup_buffer(indio_dev);
+	iio_free_device(indio_dev);
+
+	kfree(accel_state);
+	return ret;
+}
+
+static struct sensor_hub_callbacks accel_3d_callbacks = {
+	.enter = accel_3d_enter,
+	.exit = accel_3d_exit,
+	.send_event = accel_3d_proc_event,
+	.capture_sample = accel_3d_capture_sample,
+};
+
+struct sensor_hub_callbacks  *accel_3d_register_callbacks(void)
+{
+	return &accel_3d_callbacks;
+}
diff --git a/drivers/staging/hid-sensors/hid-sensor-hub.c b/drivers/staging/hid-sensors/hid-sensor-hub.c
index 95de914..a5b90bb 100644
--- a/drivers/staging/hid-sensors/hid-sensor-hub.c
+++ b/drivers/staging/hid-sensors/hid-sensor-hub.c
@@ -60,6 +60,7 @@ struct sensor_hub_callbacks_list {
 };
 
 static struct sensor_hub_callbacks_list usage_callbacks[] = {
+	{HID_USAGE_SENSOR_ACCEL_3D, accel_3d_register_callbacks},
 	{0}
 };
 
diff --git a/drivers/staging/hid-sensors/hid-sensor-interface.h b/drivers/staging/hid-sensors/hid-sensor-interface.h
index ec1bd43..2c7ef9f 100644
--- a/drivers/staging/hid-sensors/hid-sensor-interface.h
+++ b/drivers/staging/hid-sensors/hid-sensor-interface.h
@@ -86,4 +86,7 @@ void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data,
 int hid_sensor_setup_trigger(struct iio_dev *indio_dev, char *name);
 void hid_sensor_remove_trigger(struct iio_dev *indio_dev);
 
+/* Sensor usage id processing callbacks */
+struct sensor_hub_callbacks  *accel_3d_register_callbacks(void);
+
 #endif
-- 
1.7.7.6
