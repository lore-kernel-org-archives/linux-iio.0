Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Martin Liska <marxin.liska@gmail.com>,
	Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2] iio: acpi: Add ACPI0008 ALS driver
Date: Sun, 27 Jan 2013 00:33:12 +0100
Message-Id: <1359243192-3576-1-git-send-email-marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

From: Martin Liska <marxin.liska@gmail.com>

Add basic implementation of the ACPI0008 Ambient Light Sensor driver.
This driver currently supports only the ALI property, yet is ready to
be easily extended to handle ALC, ALT, ALP ones as well.

Signed-off-by: Martin Liska <marxin.liska@gmail.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/staging/iio/light/Kconfig    |    9 +
 drivers/staging/iio/light/Makefile   |    1 +
 drivers/staging/iio/light/acpi-als.c |  318 ++++++++++++++++++++++++++++++++++
 3 files changed, 328 insertions(+)
 create mode 100644 drivers/staging/iio/light/acpi-als.c

V2: Fix the channel mask, so it's really reading RAW data.

diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index 4bed30e..c857c26 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -50,4 +50,13 @@ config TSL2x7x
 	 tmd2672, tsl2772, tmd2772 devices.
 	 Provides iio_events and direct access via sysfs.
 
+config ACPI_ALS
+	tristate "ACPI Ambient Light Sensor"
+	depends on ACPI
+	help
+	 Support for the ACPI0008 Ambient Light Sensor.
+
+	 This driver can also be built as a module.  If so, the module
+	 will be called acpi-als.
+
 endmenu
diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
index 141af1e..13090e6 100644
--- a/drivers/staging/iio/light/Makefile
+++ b/drivers/staging/iio/light/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_TSL2583)	+= tsl2583.o
 obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
+obj-$(CONFIG_ACPI_ALS)	+= acpi-als.o
diff --git a/drivers/staging/iio/light/acpi-als.c b/drivers/staging/iio/light/acpi-als.c
new file mode 100644
index 0000000..6aff77a
--- /dev/null
+++ b/drivers/staging/iio/light/acpi-als.c
@@ -0,0 +1,318 @@
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
+	struct iio_trigger	*trig;
+	struct mutex		lock;
+
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
+static void acpi_als_notify(struct acpi_device *device, u32 event)
+{
+	struct iio_dev *iio = acpi_driver_data(device);
+	struct acpi_als *als = iio_priv(iio);
+	uint16_t *buffer = als->evt_buffer;
+	s64 time_ns = iio_get_time_ns();
+
+	mutex_lock(&als->lock);
+
+	memset(buffer, 0, als->evt_buffer_len);
+
+	switch (event) {
+	case ACPI_ALS_NOTIFY_ILLUMINANCE:
+		*buffer++ = als_read_value(als, ACPI_ALS_ILLUMINANCE);
+		break;
+	default:
+		/* Unhandled event */
+		dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
+			event);
+		return;
+	}
+
+	*(s64 *)ALIGN((uintptr_t)buffer, sizeof(s64)) = time_ns;
+
+	if (iio_buffer_enabled(iio))
+		iio_push_to_buffer(iio->buffer, (uint8_t *)als->evt_buffer);
+
+	mutex_unlock(&als->lock);
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
+		.indexed	= 1,
+		.channel	= 1,
+		.scan_type	= {
+			.sign 		= 'u',
+			.realbits	= 10,
+			.storagebits	= 16,
+		},
+		.info_mask	= IIO_CHAN_INFO_RAW_SEPARATE_BIT,
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
+
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct acpi_als *als = iio_priv(iio);
+
+	iio_trigger_notify_done(als->trig);
+
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
+	trig->private_data = iio;
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
+	als->evt_buffer = evt_buffer;
+	mutex_init(&als->lock);
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
+static int acpi_als_remove(struct acpi_device *device, int type)
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
+static int acpi_als_init(void)
+{
+	return acpi_bus_register_driver(&acpi_als_driver);
+}
+
+static void acpi_als_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_als_driver);
+}
+
+module_init(acpi_als_init);
+module_exit(acpi_als_exit);
+
+MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
+MODULE_AUTHOR("Martin Liska <marxin.liska@gmail.com>");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
+MODULE_LICENSE("GPL");
-- 
1.7.10.4
