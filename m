Return-Path: <SRS0=JgeZ=EA=google.com=gwendal@kernel.org>
Sender: Gwendal Grignou <gwendal@google.com>
From: Gwendal Grignou <gwendal@chromium.org>
To: enric.balletbo@collabora.com,
	jic23@kernel.org,
	groeck@chromium.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 3/3] iio: cros_ec: add barometer driver
Date: Thu,  4 Jan 2018 16:32:42 -0800
Message-Id: <20180105003242.11290-3-gwendal@chromium.org>
In-Reply-To: <20180105003242.11290-1-gwendal@chromium.org>
References: <20180105003242.11290-1-gwendal@chromium.org>
List-ID: <linux-iio@vger.kernel.org>

Add a driver when EC presents a barometer.

BUG=chrome-os-partner:57111
TEST=Check the values returned by the EC
cat scale
0.040000000
cat in_pressure_raw
24097
scale * in_pressure_raw --> 963.88 hPa

Reviewed-on: https://chromium-review.googlesource.com/382832
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
(cherry picked from commit 686988372cdc ("CHROMIUM: iio: cros_ec:
add cros_ec barometer driver"))
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/common/cros_ec_sensors/Kconfig        |   7 +
 drivers/iio/common/cros_ec_sensors/Makefile       |   1 +
 drivers/iio/common/cros_ec_sensors/cros_ec_baro.c | 213 ++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_baro.c

diff --git a/drivers/iio/common/cros_ec_sensors/Kconfig b/drivers/iio/common/cros_ec_sensors/Kconfig
index b70138566870..f5c95198580f 100644
--- a/drivers/iio/common/cros_ec_sensors/Kconfig
+++ b/drivers/iio/common/cros_ec_sensors/Kconfig
@@ -21,6 +21,13 @@ config IIO_CROS_EC_SENSORS
 	  presented by the ChromeOS EC Sensor hub.
 	  Creates an IIO device for each functions.
 
+config IIO_CROS_EC_BARO
+	tristate "ChromeOS EC Barometer Sensor"
+	depends on IIO_CROS_EC_SENSORS_CORE
+	help
+	  Module to handle Barometer sensor when
+	  presented by the ChromeOS EC Sensor hub.
+
 config IIO_CROS_EC_LIGHT_PROX
 	tristate "ChromeOS EC Light and Proximity Sensors"
 	depends on IIO_CROS_EC_SENSORS_CORE
diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
index 7aaf2a2dcdbd..71103495aada 100644
--- a/drivers/iio/common/cros_ec_sensors/Makefile
+++ b/drivers/iio/common/cros_ec_sensors/Makefile
@@ -4,4 +4,5 @@
 
 obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
 obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
+obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
 obj-$(CONFIG_IIO_CROS_EC_LIGHT_PROX) += cros_ec_light_prox.o
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_baro.c b/drivers/iio/common/cros_ec_sensors/cros_ec_baro.c
new file mode 100644
index 000000000000..794c4e86f301
--- /dev/null
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_baro.c
@@ -0,0 +1,213 @@
+/*
+ * cros_ec_baro - Driver for barometer sensor behind CrOS EC.
+ *
+ * Copyright (C) 2015 Google, Inc
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This driver uses the cros-ec interface to communicate with the Chrome OS
+ * EC about accelerometer data. Accelerometer access is presented through
+ * iio sysfs.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/kernel.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#include "cros_ec_sensors_core.h"
+
+/*
+ * One channel for pressure, the other for timestamp.
+ */
+#define MAX_CHANNELS (1 + 1)
+
+/* State data for ec_sensors iio driver. */
+struct cros_ec_baro_state {
+	/* Shared by all sensors */
+	struct cros_ec_sensors_core_state core;
+
+	struct iio_chan_spec channels[MAX_CHANNELS];
+};
+
+static int cros_ec_baro_read(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	struct cros_ec_baro_state *st = iio_priv(indio_dev);
+	u16 data = 0;
+	int ret = IIO_VAL_INT;
+	int idx = chan->scan_index;
+
+	mutex_lock(&st->core.cmd_lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
+					(s16 *)&data) < 0)
+			ret = -EIO;
+		*val = data;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
+		st->core.param.sensor_range.data =
+			EC_MOTION_SENSE_NO_VALUE;
+
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		if (ret != 0)
+			break;
+
+		*val = st->core.resp->sensor_range.ret;
+		/* EC return value in Pa, convert to hPa */
+		*val2 = 100 << CROS_EC_SENSOR_BITS;
+		ret = IIO_VAL_FRACTIONAL;
+		break;
+	default:
+		ret = cros_ec_sensors_core_read(
+				&st->core, chan, val, val2, mask);
+		break;
+	}
+	mutex_unlock(&st->core.cmd_lock);
+	return ret;
+}
+
+static int cros_ec_baro_write(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val, int val2, long mask)
+{
+	struct cros_ec_baro_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	mutex_lock(&st->core.cmd_lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		st->core.param.cmd = MOTIONSENSE_CMD_SENSOR_RANGE;
+		st->core.param.sensor_range.data = val;
+
+		/* Always roundup, so caller gets at least what it asks for. */
+		st->core.param.sensor_range.roundup = 1;
+
+		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
+		break;
+	default:
+		ret = cros_ec_sensors_core_write(
+				&st->core, chan, val, val2, mask);
+		break;
+	}
+
+	mutex_unlock(&st->core.cmd_lock);
+	return ret;
+}
+
+static const struct iio_info cros_ec_baro_info = {
+	.read_raw = &cros_ec_baro_read,
+	.write_raw = &cros_ec_baro_write,
+	.driver_module = THIS_MODULE,
+};
+
+static int cros_ec_baro_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct iio_dev *indio_dev;
+	struct cros_ec_baro_state *state;
+	struct iio_chan_spec *channel;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ret = cros_ec_sensors_core_init(pdev, indio_dev, true);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &cros_ec_baro_info;
+	state = iio_priv(indio_dev);
+	state->core.type = state->core.resp->info.type;
+	state->core.loc = state->core.resp->info.location;
+	channel = state->channels;
+	/* common part */
+	channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	channel->info_mask_shared_by_all =
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+		BIT(IIO_CHAN_INFO_FREQUENCY);
+	channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
+	channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
+	channel->scan_type.shift = 0;
+	channel->scan_index = 0;
+	channel->ext_info = cros_ec_sensors_ext_info;
+	channel->scan_type.sign = 'u';
+
+	state->core.calib[0] = 0;
+
+	/* sensor specific */
+	switch (state->core.type) {
+	case MOTIONSENSE_TYPE_BARO:
+		channel->type = IIO_PRESSURE;
+		break;
+	default:
+		dev_warn(dev, "unknown\n");
+		return -EINVAL;
+	}
+
+	/* Timestamp */
+	channel++;
+	channel->type = IIO_TIMESTAMP;
+	channel->channel = -1;
+	channel->scan_index = 1;
+	channel->scan_type.sign = 's';
+	channel->scan_type.realbits = 64;
+	channel->scan_type.storagebits = 64;
+
+	indio_dev->channels = state->channels;
+	indio_dev->num_channels = MAX_CHANNELS;
+
+	state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+			cros_ec_sensors_capture, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct platform_device_id cros_ec_baro_ids[] = {
+	{
+		.name = "cros-ec-baro",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, cros_ec_baro_ids);
+
+static struct platform_driver cros_ec_baro_platform_driver = {
+	.driver = {
+		.name	= "cros-ec-baro",
+		.pm	= &cros_ec_sensors_pm_ops,
+	},
+	.probe		= cros_ec_baro_probe,
+	.id_table	= cros_ec_baro_ids,
+};
+module_platform_driver(cros_ec_baro_platform_driver);
+
+MODULE_DESCRIPTION("ChromeOS EC barometer sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.16.0.rc0.223.g4a4ac83678-goog
