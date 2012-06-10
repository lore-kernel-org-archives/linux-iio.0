Return-Path: <srinivas.pandruvada@intel.com>
From: srinivas pandruvada <srinivas.pandruvada@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jiri Kosina <jkosina@suse.cz>,
	Srinivas pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH 8/8] HID-Sensors: Added ALS
Date: Sat,  9 Jun 2012 18:53:18 -0700
Message-Id: <1339293198-10404-9-git-send-email-srinivas.pandruvada@intel.com>
In-Reply-To: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
References: <1339293198-10404-1-git-send-email-srinivas.pandruvada@intel.com>
List-ID: <linux-iio@vger.kernel.org>

From: Srinivas pandruvada <srinivas.pandruvada@intel.com>

Added usage id processing for ALS. This uses IIO
interfaces "ring/buffer and trigger interface" to present
data to user mode.

Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/staging/hid-sensors/Makefile               |    1 +
 drivers/staging/hid-sensors/hid-sensor-als.c       |  313 ++++++++++++++++++++
 drivers/staging/hid-sensors/hid-sensor-hub.c       |    1 +
 drivers/staging/hid-sensors/hid-sensor-interface.h |    1 +
 4 files changed, 316 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/hid-sensors/hid-sensor-als.c

diff --git a/drivers/staging/hid-sensors/Makefile b/drivers/staging/hid-sensors/Makefile
index f78fcf6..2d7d296 100644
--- a/drivers/staging/hid-sensors/Makefile
+++ b/drivers/staging/hid-sensors/Makefile
@@ -12,4 +12,5 @@ hid-sensors-y += hid-sensor-trigger.o
 hid-sensors-y += hid-sensor-accel-3d.o
 hid-sensors-y += hid-sensor-gyro-3d.o
 hid-sensors-y += hid-sensor-compass-3d.o
+hid-sensors-y += hid-sensor-als.o
 obj-$(CONFIG_HID_SENSORS) += hid-sensors.o
diff --git a/drivers/staging/hid-sensors/hid-sensor-als.c b/drivers/staging/hid-sensors/hid-sensor-als.c
new file mode 100644
index 0000000..6b89b20
--- /dev/null
+++ b/drivers/staging/hid-sensors/hid-sensor-als.c
@@ -0,0 +1,313 @@
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
+#define CHANNEL_SCAN_INDEX_ILLUM 0
+
+struct als_sample {
+	u16 illum;
+};
+
+struct als_state {
+	struct hid_sensor_hub_attribute_info als_illum;
+	struct als_sample als_sample_data;
+};
+
+static struct iio_chan_spec als_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.info_mask = IIO_CHAN_INFO_OFFSET_SHARED_BIT |
+		IIO_CHAN_INFO_SCALE_SHARED_BIT,
+		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
+	}
+};
+
+static void als_adjust_channel_bit_mask(int channel, int size)
+{
+	als_channels[channel].scan_type.sign = 's';
+	als_channels[channel].scan_type.realbits = size * 8;
+	als_channels[channel].scan_type.storagebits = sizeof(u32) * 8;
+}
+
+static int als_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
+{
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state =
+			(struct als_state *)st->private;
+	int report_id = -1;
+	u32 address;
+
+	*val = 0;
+	*val2 = 0;
+
+	switch (mask) {
+	case 0:
+		switch (chan->scan_index) {
+		case  CHANNEL_SCAN_INDEX_ILLUM:
+			report_id = als_state->als_illum.report_id;
+			address =
+			HID_USAGE_SENSOR_DATA_LIGHT_ILLUMINANCE;
+			break;
+		default:
+			report_id = -1;
+			break;
+		}
+		if (report_id >= 0)
+			*val = sensor_hub_input_attr_get_raw_value(st->hdev,
+				 HID_USAGE_SENSOR_ALS, address,
+				 report_id);
+		else
+			*val = 0;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = als_state->als_illum.units;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = als_state->als_illum.unit_expo;
+		break;
+	default:
+		break;
+
+	}
+	return IIO_VAL_INT;
+}
+
+static int als_write_raw(struct iio_dev *indio_dev,
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
+static struct attribute *als_attributes[] = {
+	/* common attributes */
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_hyst_raw.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group als_attribute_group = {
+	.attrs = als_attributes,
+};
+
+static const struct iio_info als_info = {
+	.attrs = &als_attribute_group,
+	.driver_module = THIS_MODULE,
+	.read_raw = &als_read_raw,
+	.write_raw = &als_write_raw,
+};
+
+/* Function to push data to IIO ring */
+int als_proc_event(struct hid_device *hdev, unsigned usage_id, void *priv)
+{
+	struct iio_dev *indio_dev = (struct iio_dev *)priv;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state =
+			(struct als_state *)st->private;
+
+	hid_dbg(hdev, "als_proc_event\n");
+	if (st->data_ready)
+		hid_sensor_push_data(indio_dev,
+				(u8 *)&als_state->als_sample_data,
+				sizeof(struct als_sample));
+	else
+		hid_dbg(hdev, "als_proc_event data not ready\n");
+	return 0;
+}
+
+/* Capture samples in local storage */
+int als_capture_sample(struct hid_device *hdev, unsigned usage_id,
+				 size_t raw_len, char *raw_data, void *priv)
+{
+	struct iio_dev *indio_dev = (struct iio_dev *)priv;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state =
+			(struct als_state *)st->private;
+
+	switch (usage_id) {
+	case HID_USAGE_SENSOR_DATA_LIGHT_ILLUMINANCE:
+		als_state->als_sample_data.illum =
+		*(u32 *)raw_data;
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+/* Parse report which is specific to an usage id*/
+static int als_parse_report(struct hid_device *hdev, unsigned usage_id,
+				struct als_state *st)
+{
+	int ret;
+
+	ret = sensor_hub_input_get_attribute_info(hdev, HID_INPUT_REPORT,
+			usage_id,
+			HID_USAGE_SENSOR_DATA_LIGHT_ILLUMINANCE,
+			&st->als_illum);
+	if (!ret)
+		hid_dbg(hdev, "No Accel X attribute\n");
+	als_adjust_channel_bit_mask(CHANNEL_SCAN_INDEX_ILLUM,
+					st->als_illum.size);
+
+	hid_dbg(hdev, "als %x:%x\n", st->als_illum.index,
+			st->als_illum.report_id);
+
+	return 0;
+}
+
+/* Entry function to initialize the processing for usage id */
+static int als_enter(struct hid_device *hdev, unsigned usage_id,
+				void **priv)
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
+	indio_dev = iio_allocate_device(sizeof(struct hid_sensor_attributes));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_free_state;
+	}
+	st = iio_priv(indio_dev);
+	st->usage_id = usage_id;
+	st->hdev = hdev;
+	st->private = (void *)als_state;
+
+	ret = hid_sensor_parse_common_attributes(hdev, usage_id, st);
+	if (ret) {
+		hid_err(hdev, "failed to setup common attributes\n");
+		goto error_free_dev;
+	}
+	ret = als_parse_report(hdev, usage_id, als_state);
+	if (ret) {
+		hid_err(hdev, "failed to setup attributes\n");
+		goto error_free_dev;
+	}
+
+	indio_dev->channels = als_channels;
+	indio_dev->num_channels =
+				ARRAY_SIZE(als_channels);
+	indio_dev->dev.parent = &hdev->dev;
+	indio_dev->info = &als_info;
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
+					als_channels,
+					ARRAY_SIZE(als_channels));
+	if (ret) {
+		hid_err(hdev, "failed to initialize the ring\n");
+		goto error_unreg_ring_funcs;
+	}
+	iio_scan_mask_set(indio_dev, indio_dev->buffer,
+			   CHANNEL_SCAN_INDEX_ILLUM);
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
+		kfree(als_state);
+error_ret:
+		return ret;
+}
+
+static int als_exit(struct hid_device *hdev, void *priv)
+{
+	int ret = 0;
+	struct iio_dev *indio_dev = (struct iio_dev *)priv;
+	struct hid_sensor_attributes *st = iio_priv(indio_dev);
+	struct als_state *als_state =
+			(struct als_state *)st->private;
+
+	iio_device_unregister(indio_dev);
+	hid_sensor_remove_trigger(indio_dev);
+	iio_buffer_unregister(indio_dev);
+	hid_sensor_cleanup_buffer(indio_dev);
+	iio_free_device(indio_dev);
+
+	kfree(als_state);
+	return ret;
+}
+
+static struct sensor_hub_callbacks als_callbacks = {
+	.enter = als_enter,
+	.exit = als_exit,
+	.send_event = als_proc_event,
+	.capture_sample = als_capture_sample,
+};
+
+struct sensor_hub_callbacks  *als_register_callbacks(void)
+{
+	return &als_callbacks;
+}
diff --git a/drivers/staging/hid-sensors/hid-sensor-hub.c b/drivers/staging/hid-sensors/hid-sensor-hub.c
index 3fad890..d838e25 100644
--- a/drivers/staging/hid-sensors/hid-sensor-hub.c
+++ b/drivers/staging/hid-sensors/hid-sensor-hub.c
@@ -63,6 +63,7 @@ static struct sensor_hub_callbacks_list usage_callbacks[] = {
 	{HID_USAGE_SENSOR_ACCEL_3D, accel_3d_register_callbacks},
 	{HID_USAGE_SENSOR_GYRO_3D, gyro_3d_register_callbacks},
 	{HID_USAGE_SENSOR_COMPASS_3D, compass_3d_register_callbacks},
+	{HID_USAGE_SENSOR_ALS, als_register_callbacks},
 	{0}
 };
 
diff --git a/drivers/staging/hid-sensors/hid-sensor-interface.h b/drivers/staging/hid-sensors/hid-sensor-interface.h
index d7da165..56d860b 100644
--- a/drivers/staging/hid-sensors/hid-sensor-interface.h
+++ b/drivers/staging/hid-sensors/hid-sensor-interface.h
@@ -90,5 +90,6 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev);
 struct sensor_hub_callbacks  *accel_3d_register_callbacks(void);
 struct sensor_hub_callbacks  *gyro_3d_register_callbacks(void);
 struct sensor_hub_callbacks  *compass_3d_register_callbacks(void);
+struct sensor_hub_callbacks  *als_register_callbacks(void);
 
 #endif
-- 
1.7.7.6
