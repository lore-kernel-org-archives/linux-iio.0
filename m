Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19620 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932563AbcDYNMc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Apr 2016 09:12:32 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH v2 2/3] iio: dummy: Convert IIO dummy to configfs
Date: Mon, 25 Apr 2016 16:15:52 +0300
Message-Id: <1461590153-22308-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1461590153-22308-1-git-send-email-daniel.baluta@intel.com>
References: <1461590153-22308-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We register a new device type named "dummy", this will create a
configfs entry under:
	* /config/iio/devices/dummy.

Creating dummy devices is now as simple as:

$ mkdir /config/iio/devices/dummy/my_dummy_device

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/dummy/Kconfig            |   1 +
 drivers/iio/dummy/iio_simple_dummy.c | 102 +++++++++++++----------------------
 2 files changed, 38 insertions(+), 65 deletions(-)

diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
index 71805ce..aa5824d 100644
--- a/drivers/iio/dummy/Kconfig
+++ b/drivers/iio/dummy/Kconfig
@@ -10,6 +10,7 @@ config IIO_DUMMY_EVGEN
 
 config IIO_SIMPLE_DUMMY
        tristate "An example driver with no hardware requirements"
+       depends on IIO_SW_DEVICE
        help
 	 Driver intended mainly as documentation for how to write
 	 a driver. May also be useful for testing userspace code
diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index 43fe4ba..ad3410e 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -17,26 +17,18 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/string.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/sw_device.h>
 #include "iio_simple_dummy.h"
 
-/*
- * A few elements needed to fake a bus for this driver
- * Note instances parameter controls how many of these
- * dummy devices are registered.
- */
-static unsigned instances = 1;
-module_param(instances, uint, 0);
-
-/* Pointer array used to fake bus elements */
-static struct iio_dev **iio_dummy_devs;
-
-/* Fake a name for the part number, usually obtained from the id table */
-static const char *iio_dummy_part_number = "iio_dummy_part_no";
+static struct config_item_type iio_dummy_type = {
+	.ct_owner = THIS_MODULE,
+};
 
 /**
  * struct iio_dummy_accel_calibscale - realworld to register mapping
@@ -572,12 +564,18 @@ static int iio_dummy_init_device(struct iio_dev *indio_dev)
  *                      const struct i2c_device_id *id)
  * SPI: iio_dummy_probe(struct spi_device *spi)
  */
-static int iio_dummy_probe(int index)
+static struct iio_sw_device *iio_dummy_probe(const char *name)
 {
 	int ret;
 	struct iio_dev *indio_dev;
 	struct iio_dummy_state *st;
+	struct iio_sw_device *swd;
 
+	swd = kzalloc(sizeof(*swd), GFP_KERNEL);
+	if (!swd) {
+		ret = -ENOMEM;
+		goto error_kzalloc;
+	}
 	/*
 	 * Allocate an IIO device.
 	 *
@@ -608,7 +606,7 @@ static int iio_dummy_probe(int index)
 	 * i2c_set_clientdata(client, indio_dev);
 	 * spi_set_drvdata(spi, indio_dev);
 	 */
-	iio_dummy_devs[index] = indio_dev;
+	swd->device = indio_dev;
 
 	/*
 	 * Set the device name.
@@ -619,7 +617,7 @@ static int iio_dummy_probe(int index)
 	 *    indio_dev->name = id->name;
 	 *    indio_dev->name = spi_get_device_id(spi)->name;
 	 */
-	indio_dev->name = iio_dummy_part_number;
+	indio_dev->name = kstrdup(name, GFP_KERNEL);
 
 	/* Provide description of available channels */
 	indio_dev->channels = iio_dummy_channels;
@@ -646,7 +644,9 @@ static int iio_dummy_probe(int index)
 	if (ret < 0)
 		goto error_unconfigure_buffer;
 
-	return 0;
+	iio_swd_group_init_type_name(swd, name, &iio_dummy_type);
+
+	return swd;
 error_unconfigure_buffer:
 	iio_simple_dummy_unconfigure_buffer(indio_dev);
 error_unregister_events:
@@ -654,16 +654,18 @@ error_unregister_events:
 error_free_device:
 	iio_device_free(indio_dev);
 error_ret:
-	return ret;
+	kfree(swd);
+error_kzalloc:
+	return ERR_PTR(ret);
 }
 
 /**
  * iio_dummy_remove() - device instance removal function
- * @index: device index.
+ * @swd: pointer to software IIO device abstraction
  *
  * Parameters follow those of iio_dummy_probe for buses.
  */
-static void iio_dummy_remove(int index)
+static int iio_dummy_remove(struct iio_sw_device *swd)
 {
 	/*
 	 * Get a pointer to the device instance iio_dev structure
@@ -671,7 +673,7 @@ static void iio_dummy_remove(int index)
 	 * struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	 * struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	 */
-	struct iio_dev *indio_dev = iio_dummy_devs[index];
+	struct iio_dev *indio_dev = swd->device;
 
 	/* Unregister the device */
 	iio_device_unregister(indio_dev);
@@ -684,11 +686,13 @@ static void iio_dummy_remove(int index)
 	iio_simple_dummy_events_unregister(indio_dev);
 
 	/* Free all structures */
+	kfree(indio_dev->name);
 	iio_device_free(indio_dev);
-}
 
+	return 0;
+}
 /**
- * iio_dummy_init() -  device driver registration
+ * module_iio_sw_device_driver() -  device driver registration
  *
  * Varies depending on bus type of the device. As there is no device
  * here, call probe directly. For information on device registration
@@ -697,50 +701,18 @@ static void iio_dummy_remove(int index)
  * spi:
  * Documentation/spi/spi-summary
  */
-static __init int iio_dummy_init(void)
-{
-	int i, ret;
-
-	if (instances > 10) {
-		instances = 1;
-		return -EINVAL;
-	}
-
-	/* Fake a bus */
-	iio_dummy_devs = kcalloc(instances, sizeof(*iio_dummy_devs),
-				 GFP_KERNEL);
-	/* Here we have no actual device so call probe */
-	for (i = 0; i < instances; i++) {
-		ret = iio_dummy_probe(i);
-		if (ret < 0)
-			goto error_remove_devs;
-	}
-	return 0;
-
-error_remove_devs:
-	while (i--)
-		iio_dummy_remove(i);
-
-	kfree(iio_dummy_devs);
-	return ret;
-}
-module_init(iio_dummy_init);
+static const struct iio_sw_device_ops iio_dummy_device_ops = {
+	.probe = iio_dummy_probe,
+	.remove = iio_dummy_remove,
+};
 
-/**
- * iio_dummy_exit() - device driver removal
- *
- * Varies depending on bus type of the device.
- * As there is no device here, call remove directly.
- */
-static __exit void iio_dummy_exit(void)
-{
-	int i;
+static struct iio_sw_device_type iio_dummy_device = {
+	.name = "dummy",
+	.owner = THIS_MODULE,
+	.ops = &iio_dummy_device_ops,
+};
 
-	for (i = 0; i < instances; i++)
-		iio_dummy_remove(i);
-	kfree(iio_dummy_devs);
-}
-module_exit(iio_dummy_exit);
+module_iio_sw_device_driver(iio_dummy_device);
 
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
 MODULE_DESCRIPTION("IIO dummy driver");
-- 
2.5.0

