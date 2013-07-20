Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:48908 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597Ab3GTX7B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 20 Jul 2013 19:59:01 -0400
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Martin Liska <marxin.liska@gmail.com>, Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V5] iio: acpi: Add ACPI0008 ALS driver
Date: Sun, 21 Jul 2013 01:58:37 +0200
Message-Id: <1374364717-10040-1-git-send-email-marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Martin Liska <marxin.liska@gmail.com>

Add basic implementation of the ACPI0008 Ambient Light Sensor driver.
This driver currently supports only the ALI property, yet is ready to
be easily extended to handle ALC, ALT, ALP ones as well.

Signed-off-by: Martin Liska <marxin.liska@gmail.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/staging/iio/light/Kconfig    |   10 ++
 drivers/staging/iio/light/Makefile   |    1 +
 drivers/staging/iio/light/acpi-als.c |  326 ++++++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 drivers/staging/iio/light/acpi-als.c

V2: Fix the channel mask, so it's really reading RAW data.
V3: Put scan timestamp into the buffer only when enabled,
    Set the light sensor ID to 0 instead of 1
V4: Select IIO_TRIGGERED_BUFFER as we need it here
V5: Use irq_work to trigger the buffer
    Use module_acpi_driver()

diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index ca8d6e6..0238a7f 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -3,6 +3,16 @@
 #
 menu "Light sensors"
 
+config ACPI_ALS
+	tristate "ACPI Ambient Light Sensor"
+	depends on ACPI
+	select IIO_TRIGGERED_BUFFER
+	help
+	 Support for the ACPI0008 Ambient Light Sensor.
+
+	 This driver can also be built as a module.  If so, the module
+	 will be called acpi-als.
+
 config SENSORS_ISL29018
 	tristate "ISL 29018 light and proximity sensor"
 	depends on I2C
diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
index 9960fdf..a3f68bc 100644
--- a/drivers/staging/iio/light/Makefile
+++ b/drivers/staging/iio/light/Makefile
@@ -2,6 +2,7 @@
 # Makefile for industrial I/O Light sensors
 #
 
+obj-$(CONFIG_ACPI_ALS)	+= acpi-als.o
 obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_TSL2583)	+= tsl2583.o
diff --git a/drivers/staging/iio/light/acpi-als.c b/drivers/staging/iio/light/acpi-als.c
new file mode 100644
index 0000000..f63427c
--- /dev/null
+++ b/drivers/staging/iio/light/acpi-als.c
@@ -0,0 +1,326 @@
+/*
+ * ACPI Ambient Light Sensor Driver
+ *
+ * Based on ALS driver:
+ * Copyright (C) 2009 Zhang Rui <rui.zhang@intel.com>
+ *
+ * Rework for IIO subsystem:
+ * Copyright (C) 2012-2013 Martin Liska <marxin.liska@gmail.com>
+ *
+ * Final cleanup and debugging:
+ * Copyright (C) 2013 Marek Vasut <marex@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/irq_work.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define ACPI_ALS_CLASS			"als"
+#define ACPI_ALS_DEVICE_NAME		"acpi-als"
+#define ACPI_ALS_NOTIFY_ILLUMINANCE	0x80
+
+ACPI_MODULE_NAME("acpi-als");
+
+struct acpi_als {
+	struct acpi_device	*device;
+	struct iio_dev		*iio;
+	struct mutex		lock;
+	struct irq_work		work;
+
+	s64			evt_time;
+	uint32_t		evt_event;
+	uint16_t		*evt_buffer;
+	unsigned int		evt_buffer_len;
+};
+
+/*
+ * All types of properties the ACPI0008 block can report. The ALI, ALC, ALT
+ * and ALP can all be handled by als_read_value() below, while the ALR is
+ * special.
+ *
+ * The _ALR property returns tables that can be used to fine-tune the values
+ * reported by the other props based on the particular hardware type and it's
+ * location (it contains tables for "rainy", "bright inhouse lighting" etc.).
+ *
+ * So far, we support only ALI (illuminance).
+ */
+#define ACPI_ALS_ILLUMINANCE	"_ALI"
+#define ACPI_ALS_CHROMATICITY	"_ALC"
+#define ACPI_ALS_COLOR_TEMP	"_ALT"
+#define ACPI_ALS_POLLING	"_ALP"
+#define ACPI_ALS_TABLES		"_ALR"
+
+static int32_t als_read_value(struct acpi_als *als, char *prop)
+{
+	unsigned long long illuminance;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(als->device->handle,
+				prop, NULL, &illuminance);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"Error reading ALS illuminance"));
+		/* Something went wrong, it's pitch black outside! */
+		illuminance = 0;
+	}
+
+	return illuminance;
+}
+
+static void acpi_als_irq_work(struct irq_work *work)
+{
+	struct acpi_als *als = container_of(work, struct acpi_als, work);
+
+	iio_trigger_poll(als->iio->trig, 0);
+}
+
+static void acpi_als_notify(struct acpi_device *device, u32 event)
+{
+	struct iio_dev *iio = acpi_driver_data(device);
+	struct acpi_als *als = iio_priv(iio);
+	s64 time_ns = iio_get_time_ns();
+
+	mutex_lock(&als->lock);
+
+	if (iio_buffer_enabled(iio)) {
+		als->evt_time = time_ns;
+		als->evt_event = event;
+		irq_work_queue(&als->work);
+	}
+}
+
+static int acpi_als_read_raw(struct iio_dev *iio,
+			struct iio_chan_spec const *chan, int *val,
+			int *val2, long mask)
+{
+	struct acpi_als *als = iio_priv(iio);
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	/* we support only illumination (_ALI) so far. */
+	if (chan->type != IIO_LIGHT)
+		return -EINVAL;
+
+	*val = als_read_value(als, ACPI_ALS_ILLUMINANCE);
+	return IIO_VAL_INT;
+}
+
+/*
+ * So far, there's only one channel in here, but the specification for
+ * ACPI0008 says there can be more to what the block can report. Like
+ * chromaticity and such. We are ready for incoming additions!
+ */
+static const struct iio_chan_spec acpi_als_channels[] = {
+	{
+		.type		= IIO_LIGHT,
+		.indexed	= 0,
+		.channel	= 0,
+		.scan_index	= 0,
+		.scan_type	= {
+			.sign 		= 'u',
+			.realbits	= 10,
+			.storagebits	= 16,
+		},
+		.info_mask	= BIT(IIO_CHAN_INFO_RAW),
+	},
+};
+
+static const struct iio_info acpi_als_info = {
+	.driver_module	= THIS_MODULE,
+	.read_raw	= &acpi_als_read_raw,
+};
+
+static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct acpi_als *als = iio_priv(iio);
+	struct device *dev = &als->device->dev;
+	uint16_t *buffer = als->evt_buffer;
+
+	memset(buffer, 0, als->evt_buffer_len);
+
+	switch (als->evt_event) {
+	case ACPI_ALS_NOTIFY_ILLUMINANCE:
+		*buffer++ = als_read_value(als, ACPI_ALS_ILLUMINANCE);
+		break;
+	default:
+		/* Unhandled event */
+		dev_dbg(dev, "Unhandled ACPI ALS event (%08x)!\n",
+			als->evt_event);
+		goto skip;
+	}
+
+	if (iio->scan_timestamp)
+		*(s64 *)ALIGN((uintptr_t)buffer, sizeof(s64)) = als->evt_time;
+
+	iio_push_to_buffers(iio, (uint8_t *)als->evt_buffer);
+
+skip:
+	iio_trigger_notify_done(iio->trig);
+	mutex_unlock(&als->lock);
+	return IRQ_HANDLED;
+}
+
+static const struct iio_trigger_ops acpi_als_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
+static int acpi_als_trigger_init(struct iio_dev *iio)
+{
+	struct iio_trigger *trig;
+	int ret;
+
+	trig = iio_trigger_alloc("%s-dev%i", iio->name, iio->id);
+	if (!trig)
+		return -ENOMEM;
+
+	trig->dev.parent = iio->dev.parent;
+	iio_trigger_set_drvdata(trig, iio);
+	trig->ops = &acpi_als_trigger_ops;
+
+	ret = iio_trigger_register(trig);
+	if (ret) {
+		iio_trigger_free(trig);
+		return ret;
+	}
+
+	iio->trig = trig;
+
+	return 0;
+}
+
+static void acpi_als_trigger_remove(struct iio_dev *iio)
+{
+	iio_trigger_unregister(iio->trig);
+	iio_trigger_free(iio->trig);
+}
+
+static int acpi_als_add(struct acpi_device *device)
+{
+	struct acpi_als *als;
+	struct iio_dev *iio;
+	struct device *dev = &device->dev;
+	int ret;
+
+	/*
+	 * The event buffer contains timestamp and all the data from
+	 * the ACPI0008 block. There are multiple, but so far we only
+	 * support _ALI (illuminance). Yes, we're ready for more!
+	 */
+	uint16_t *evt_buffer;
+	const unsigned int evt_sources = 1;
+	const unsigned int evt_buffer_size = sizeof(int64_t) +
+				(sizeof(uint16_t) * evt_sources);
+
+	evt_buffer = devm_kzalloc(dev, evt_buffer_size, GFP_KERNEL);
+	if (!evt_buffer)
+		return -ENOMEM;
+
+	iio = iio_device_alloc(sizeof(*als));
+	if (!iio) {
+		dev_err(dev, "Failed to allocate IIO device\n");
+		return -ENOMEM;
+	}
+
+	als = iio_priv(iio);
+
+	device->driver_data = iio;
+	als->device = device;
+	als->iio = iio;
+	als->evt_buffer = evt_buffer;
+	mutex_init(&als->lock);
+	init_irq_work(&als->work, acpi_als_irq_work);
+
+	iio->name = ACPI_ALS_DEVICE_NAME;
+	iio->dev.parent = dev;
+	iio->info = &acpi_als_info;
+	iio->modes = INDIO_DIRECT_MODE;
+	iio->channels = acpi_als_channels;
+	iio->num_channels = ARRAY_SIZE(acpi_als_channels);
+
+	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
+					&acpi_als_trigger_handler, NULL);
+	if (ret)
+		goto err_iio;
+
+	ret = acpi_als_trigger_init(iio);
+	if (ret)
+		goto err_trig;
+
+	ret = iio_device_register(iio);
+	if (ret < 0)
+		goto err_dev;
+
+	return 0;
+
+err_dev:
+	acpi_als_trigger_remove(iio);
+err_trig:
+	iio_triggered_buffer_cleanup(iio);
+err_iio:
+	iio_device_free(iio);
+	return ret;
+}
+
+static int acpi_als_remove(struct acpi_device *device)
+{
+	struct iio_dev *iio = acpi_driver_data(device);
+
+	iio_device_unregister(iio);
+	iio_triggered_buffer_cleanup(iio);
+	acpi_als_trigger_remove(iio);
+	iio_device_free(iio);
+
+	return 0;
+}
+
+static const struct acpi_device_id acpi_als_device_ids[] = {
+	{"ACPI0008", 0},
+	{"", 0},
+};
+
+MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);
+
+static struct acpi_driver acpi_als_driver = {
+	.name	= "acpi_als",
+	.class	= ACPI_ALS_CLASS,
+	.ids	= acpi_als_device_ids,
+	.ops = {
+		.add	= acpi_als_add,
+		.remove	= acpi_als_remove,
+		.notify	= acpi_als_notify,
+	},
+};
+
+module_acpi_driver(acpi_als_driver);
+
+MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
+MODULE_AUTHOR("Martin Liska <marxin.liska@gmail.com>");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.10.4

