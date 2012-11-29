Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63639 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310Ab2K2Cqy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Nov 2012 21:46:54 -0500
From: marxin.liska@gmail.com
To: corentin.chary@gmail.com
Cc: marex@denx.de, jic23@cam.ac.uk,
	platform-driver-x86@vger.kernel.org, linux-iio@vger.kernel.org,
	rui.zhang@intel.com, jlee@suse.com, len.brown@intel.com,
	pavel@denx.de, jbrenner@taosinc.com, pmeerw@pmeerw.net,
	marxin <marxin.liska@gmail.com>
Subject: [PATCH] ACPI ALS driver for iio introduced.
Date: Thu, 29 Nov 2012 02:46:45 +0000
Message-Id: <1354157205-2956-2-git-send-email-marxin.liska@gmail.com>
In-Reply-To: <1354157205-2956-1-git-send-email-marxin.liska@gmail.com>
References: <CAHR064j_7Y3wYXVXmC4TqZHxkqa0Z2HK84-OaDTiC7oesB_TrQ@mail.gmail.com>
 <1354157205-2956-1-git-send-email-marxin.liska@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: marxin <marxin.liska@gmail.com>

---
 drivers/iio/industrialio-buffer.c    |    4 +-
 drivers/staging/iio/light/Kconfig    |    6 +
 drivers/staging/iio/light/Makefile   |    1 +
 drivers/staging/iio/light/acpi-als.c |  486 ++++++++++++++++++++++++++++++++++
 4 files changed, 495 insertions(+), 2 deletions(-)
 create mode 100644 drivers/staging/iio/light/acpi-als.c

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index aaadd32..b8b377c 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -119,8 +119,8 @@ static ssize_t iio_scan_el_show(struct device *dev,
 	int ret;
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 
-	ret = test_bit(to_iio_dev_attr(attr)->address,
-		       indio_dev->buffer->scan_mask);
+	ret = !!(test_bit(to_iio_dev_attr(attr)->address,
+		       indio_dev->buffer->scan_mask));
 
 	return sprintf(buf, "%d\n", ret);
 }
diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index 4bed30e..a164ecc 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -50,4 +50,10 @@ config TSL2x7x
 	 tmd2672, tsl2772, tmd2772 devices.
 	 Provides iio_events and direct access via sysfs.
 
+config ACPI_ALS
+	tristate "ACPI Ambient Light Sensor"
+	help
+	 Support for ACPI0008 Light Sensor.
+	 Provides direct access via sysfs.
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
index 0000000..9ba0fc4
--- /dev/null
+++ b/drivers/staging/iio/light/acpi-als.c
@@ -0,0 +1,486 @@
+/*
+ * ACPI Ambient Light Sensor Driver
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <trace/events/printk.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define PREFIX "ACPI: "
+
+#define ACPI_ALS_CLASS			"als"
+#define ACPI_ALS_DEVICE_NAME		"acpi-als"
+#define ACPI_ALS_NOTIFY_ILLUMINANCE	0x80
+
+#define ACPI_ALS_OUTPUTS		1
+
+#define _COMPONENT			ACPI_ALS_COMPONENT
+ACPI_MODULE_NAME("acpi-als");
+
+MODULE_AUTHOR("Martin Liska <marxin.liska@gmail.com>");
+MODULE_DESCRIPTION("ACPI Ambient Light Sensor Driver");
+MODULE_LICENSE("GPL");
+
+struct acpi_als_chip {
+    struct acpi_device		*device;
+    struct acpi_als_device	*acpi_als_sys;
+    struct mutex		lock;
+    struct iio_trigger		*trig;
+
+    int				illuminance;
+    int				polling;
+
+    int				count;
+    struct acpi_als_mapping	*mappings;
+};
+
+static int acpi_als_add(struct acpi_device *device);
+static int acpi_als_remove(struct acpi_device *device, int type);
+static void acpi_als_notify(struct acpi_device *device, u32 event);
+
+static const struct acpi_device_id acpi_als_device_ids[] = {
+    {"ACPI0008", 0},
+    {"", 0},
+};
+
+MODULE_DEVICE_TABLE(acpi, acpi_als_device_ids);
+
+static struct acpi_driver acpi_als_driver = {
+    .name = "acpi_als",
+    .class = ACPI_ALS_CLASS,
+    .ids = acpi_als_device_ids,
+    .ops = {
+        .add = acpi_als_add,
+        .remove = acpi_als_remove,
+        .notify = acpi_als_notify,
+    },
+};
+
+struct acpi_als_mapping {
+    int adjustment;
+    int illuminance;
+};
+
+#define ALS_INVALID_VALUE_LOW		0
+#define ALS_INVALID_VALUE_HIGH		-1
+
+/* --------------------------------------------------------------------------
+		Ambient Light Sensor device Management
+   -------------------------------------------------------------------------- */
+
+/*
+ * acpi_als_get_illuminance - get the current ambient light illuminance
+ */
+static int acpi_als_get_illuminance(struct acpi_als_chip *als)
+{
+    acpi_status status;
+    unsigned long long illuminance;
+
+    status = acpi_evaluate_integer(als->device->handle,
+                                   "_ALI", NULL, &illuminance);
+
+    if (ACPI_FAILURE(status)) {
+        ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS illuminance"));
+        als->illuminance = ALS_INVALID_VALUE_LOW;
+        return -ENODEV;
+    }
+    als->illuminance = illuminance;
+
+    return 0;
+}
+
+/*
+ * acpi_als_get_mappings - get the ALS illuminance mappings
+ *
+ * Return a package of ALS illuminance to display adjustment mappings
+ * that can be used by OS to calibrate its ambient light policy
+ * for a given sensor configuration.
+ */
+static int acpi_als_get_mappings(struct acpi_als_chip *chip)
+{
+    int result = 0;
+    acpi_status status;
+    struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+    union acpi_object *alr;
+    int i, j;
+
+    /* Free the old mappings */
+    kfree(chip->mappings);
+    chip->mappings = NULL;
+
+    status =
+        acpi_evaluate_object(chip->device->handle, "_ALR", NULL, &buffer);
+    if (ACPI_FAILURE(status)) {
+        ACPI_EXCEPTION((AE_INFO, status, "Error reading ALS mappings"));
+        return -ENODEV;
+    }
+
+    alr = buffer.pointer;
+    if (!alr || (alr->type != ACPI_TYPE_PACKAGE)) {
+        printk(KERN_ERR PREFIX "Invalid _ALR data\n");
+        result = -EFAULT;
+        goto end;
+    }
+
+    ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d illuminance mappings\n",
+                      alr->package.count));
+
+    chip->count = alr->package.count;
+
+    if (!chip->count)
+        return 0;
+
+    chip->mappings =
+        kmalloc(sizeof(struct acpi_als_mapping) * chip->count, GFP_KERNEL);
+    if (!chip->mappings) {
+        result = -ENOMEM;
+        goto end;
+    }
+
+    for (i = 0, j = 0; i < chip->count; i++) {
+        struct acpi_als_mapping *mapping = &(chip->mappings[j]);
+        union acpi_object *element = &(alr->package.elements[i]);
+
+        if (element->type != ACPI_TYPE_PACKAGE)
+            continue;
+
+        if (element->package.count != 2)
+            continue;
+
+        if (element->package.elements[0].type != ACPI_TYPE_INTEGER ||
+            element->package.elements[1].type != ACPI_TYPE_INTEGER)
+            continue;
+
+        mapping->adjustment =
+            element->package.elements[0].integer.value;
+        mapping->illuminance =
+            element->package.elements[1].integer.value;
+        j++;
+
+        ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Mapping [%d]: "
+                          "adjustment [%d] illuminance[%d]\n",
+                          i, mapping->adjustment,
+                          mapping->illuminance));
+    }
+
+end:
+    kfree(buffer.pointer);
+    return result;
+}
+
+/*
+ * acpi_als_get_polling - get a recommended polling frequency
+ * 			  for the Ambient Light Sensor device
+ */
+static int acpi_als_get_polling(struct acpi_als_chip *chip)
+{
+    acpi_status status;
+    unsigned long long polling;
+
+    status =
+        acpi_evaluate_integer(chip->device->handle, "_ALP", NULL, &polling);
+    if (ACPI_FAILURE(status)) {
+        ACPI_DEBUG_PRINT((ACPI_DB_INFO, "_ALP not available\n"));
+        return -ENODEV;
+    }
+
+    chip->polling = polling;
+    return 0;
+}
+
+/*
+ * get_illuminance - wrapper for getting the currect ambient light illuminance
+ */
+static int get_illuminance(struct acpi_als_chip *als, int *illuminance)
+{
+    int result;
+
+    result = acpi_als_get_illuminance(als);
+    if (!result)
+        *illuminance = als->illuminance;
+
+    return result;
+}
+
+static void acpi_als_notify(struct acpi_device *device, u32 event)
+{
+	int illuminance;
+	struct iio_dev *indio_dev = acpi_driver_data(device);
+	struct acpi_als_chip *chip = iio_priv(indio_dev);
+
+	s64 time_ns = iio_get_time_ns();
+	int len = sizeof(int);
+	u8 data[sizeof(s64) + ACPI_ALS_OUTPUTS * len];
+
+	switch(event) {
+	case ACPI_ALS_NOTIFY_ILLUMINANCE:
+		get_illuminance(chip, &illuminance);
+		*(int *)((u8 *)data) = illuminance;
+		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64))) = time_ns;
+		break;
+	default:
+		return;
+	}
+
+	if (iio_buffer_enabled(indio_dev))
+		iio_push_to_buffers(indio_dev, data);
+
+	return;
+}
+
+static int acpi_als_read_raw(struct iio_dev *indio_dev,
+                             struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+    struct acpi_als_chip *chip = iio_priv(indio_dev);
+    int ret = -EINVAL;
+
+    mutex_lock(&chip->lock);
+
+    switch (mask) {
+    case IIO_CHAN_INFO_RAW:
+    case IIO_CHAN_INFO_PROCESSED:
+        switch(chan->type) {
+        case IIO_LIGHT:
+            ret = get_illuminance(chip, val);
+            break;
+        default:
+            break;
+        }
+
+        if(!ret)
+            ret = IIO_VAL_INT;
+
+        break;
+    default:
+        dev_err(&chip->device->dev, "mask value 0x%08lx not supported\n", mask);
+        break;
+    }
+
+    mutex_unlock(&chip->lock);
+
+    return ret;
+}
+
+static const struct iio_chan_spec acpi_als_channels[] = {
+    {
+        .type = IIO_LIGHT,
+        .indexed = 1,
+        .channel = 1,
+        .scan_type.sign = 'u',
+        .scan_type.realbits = 10,
+        .scan_type.storagebits = 16,
+        .info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
+        IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
+    },
+};
+
+static const struct iio_info acpi_als_info = {
+    .driver_module = THIS_MODULE,
+    .read_raw = &acpi_als_read_raw,
+    .write_raw = NULL,
+};
+
+static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
+{
+
+    struct iio_poll_func *pf = p;
+    struct iio_dev *idev = pf->indio_dev;
+
+
+    struct acpi_als_chip *chip = iio_priv(idev);
+
+    printk("XXX: TRIGGER handler called :)");
+    iio_trigger_notify_done(chip->trig);
+    return IRQ_HANDLED;
+}
+
+/**
+ * acpi_als_data_rdy_trigger_set_state() set datardy interrupt state
+ **/
+static int acpi_als_data_rdy_trigger_set_state(struct iio_trigger *trig,
+        bool state)
+{
+
+    struct iio_dev *indio_dev = trig->private_data;
+    printk("XXX: set_state called\n");
+
+    dev_dbg(&indio_dev->dev, "%s (%d)\n", __func__, state);
+
+    return 0;
+}
+
+static const struct iio_trigger_ops acpi_als_trigger_ops = {
+    .owner = THIS_MODULE,
+    .set_trigger_state = &acpi_als_data_rdy_trigger_set_state
+};
+
+// TODO
+static const struct iio_buffer_setup_ops acpi_als_buffer_ops = {
+    .preenable = &iio_sw_buffer_preenable, // TODO ?
+    .postenable = &iio_triggered_buffer_postenable,
+    .predisable = &iio_triggered_buffer_predisable,
+};
+
+static struct iio_trigger *acpi_als_allocate_trigger(struct iio_dev *idev) {
+    int ret;
+    struct iio_trigger *trig;
+
+    trig = iio_trigger_alloc("acpi-als");
+    if (trig == NULL)
+        return NULL;
+
+    trig->dev.parent = idev->dev.parent;
+    trig->private_data = idev;
+    trig->ops = &acpi_als_trigger_ops;
+
+
+    ret = iio_trigger_register(trig);
+    if (ret)
+        return NULL;
+
+    printk("XXX: acpi_als_allocate_trigger: %d\n", ret);
+    return trig;
+}
+
+static int acpi_als_trigger_init(struct iio_dev *idev)
+{
+    struct acpi_als_chip *chip = iio_priv(idev);
+    int ret;
+
+    chip->trig = devm_kzalloc(&idev->dev, sizeof(chip->trig), GFP_KERNEL);
+
+    if (chip->trig == NULL) {
+        ret = -ENOMEM;
+        goto error_ret;
+    }
+
+    chip->trig = acpi_als_allocate_trigger(idev);
+    if (chip->trig == NULL) {
+        dev_err(&idev->dev, "Could not allocate trigger!\n");
+        ret = -ENOMEM;
+        goto error_trigger;
+    }
+
+    return 0;
+
+error_trigger:
+    iio_trigger_free(chip->trig);
+error_ret:
+    return ret;
+}
+
+
+static int acpi_als_add(struct acpi_device *device)
+{
+    int result;
+    struct acpi_als_chip *chip;
+    struct iio_dev *indio_dev;
+
+    /*
+    if (unlikely(als_id >= 10)) {
+    	printk(KERN_WARNING PREFIX "Too many ALS device found\n");
+    	return -ENODEV;
+    }
+    */
+
+    indio_dev = iio_device_alloc(sizeof(*chip));
+    if (!indio_dev) {
+        dev_err(&device->dev, "iio allocation fails\n");
+        return -ENOMEM;
+    }
+
+    chip = iio_priv(indio_dev);
+
+    device->driver_data = indio_dev;
+    chip->device = device;
+    mutex_init(&chip->lock);
+
+    indio_dev->info = &acpi_als_info;
+    indio_dev->channels = acpi_als_channels;
+    indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
+    indio_dev->name = ACPI_ALS_DEVICE_NAME;
+    indio_dev->dev.parent = &device->dev;
+    indio_dev->modes = INDIO_DIRECT_MODE;
+
+    result = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+                                        &acpi_als_trigger_handler, NULL);
+
+    if(result) {
+        printk("Could not setup buffer for iio device\n");
+        goto exit_iio_free;
+    }
+
+    result = acpi_als_trigger_init(indio_dev);
+    if (result) {
+        printk("Couldn't setup the triggers.\n");
+        // TODO
+        //goto error_unregister_buffer;
+    }
+
+    result = iio_device_register(indio_dev);
+    if (result < 0) {
+        dev_err(&chip->device->dev, "iio registration fails with error %d\n",
+                result);
+        goto exit_iio_free;
+    }
+
+    printk("ACPI ALS initialized");
+
+    return 0;
+
+exit_iio_free:
+    iio_device_free(indio_dev);
+    return result;
+}
+
+static int acpi_als_remove(struct acpi_device *device, int type)
+{
+    struct iio_dev *indio_dev;
+
+    indio_dev = acpi_driver_data(device);
+    if(!indio_dev) {
+        dev_err(&device->dev, "could not get indio_dev for ACPI device\n");
+        return -1;
+    }
+
+    iio_device_unregister(indio_dev);
+    iio_device_free(indio_dev);
+
+    return 0;
+}
+
+static int __init acpi_als_init(void)
+{
+    return acpi_bus_register_driver(&acpi_als_driver);
+}
+
+static void __exit acpi_als_exit(void)
+{
+    acpi_bus_unregister_driver(&acpi_als_driver);
+}
+
+module_init(acpi_als_init);
+module_exit(acpi_als_exit);
-- 
1.7.8.6

