Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: TRIGGER: New sysfs based trigger
Date: Mon, 7 Feb 2011 11:05:46 +0100
Message-ID: <1297073146-10411-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds a new trigger that can be invoked by writing
the sysfs file: trigger_now. This approach can be valuable during
automated testing or in situations, where other trigger methods
are not applicable. For example no RTC or spare GPIOs.
Last but not least we can allow user space applications to produce triggers.

IIO: TRIGGER: Apply review feedback by Greg Kroah-Hartman

Changes since v1:

Add sysfs documentation.
Change license notice.
Add module alias.
Add more Kconfig help text

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 .../iio/Documentation/sysfs-bus-iio-trigger-sysfs  |   11 ++
 drivers/staging/iio/trigger/Kconfig                |   10 ++
 drivers/staging/iio/trigger/Makefile               |    1 +
 drivers/staging/iio/trigger/iio-trig-sysfs.c       |  108 ++++++++++++++++++++
 4 files changed, 130 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs
 create mode 100644 drivers/staging/iio/trigger/iio-trig-sysfs.c

diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs b/drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs
new file mode 100644
index 0000000..5235e6c
--- /dev/null
+++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-trigger-sysfs
@@ -0,0 +1,11 @@
+What:		/sys/bus/iio/devices/triggerX/trigger_now
+KernelVersion:	2.6.38
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This file is provided by the iio-trig-sysfs stand-alone trigger
+		driver. Writing this file with any value triggers an event
+		driven driver, associated with this trigger, to capture data
+		into an in kernel buffer. This approach can be valuable during
+		automated testing or in situations, where other trigger methods
+		are not applicable. For example no RTC or spare GPIOs.
+		X is the IIO index of the trigger.
diff --git a/drivers/staging/iio/trigger/Kconfig b/drivers/staging/iio/trigger/Kconfig
index d842a58..3a82013 100644
--- a/drivers/staging/iio/trigger/Kconfig
+++ b/drivers/staging/iio/trigger/Kconfig
@@ -18,4 +18,14 @@ config IIO_GPIO_TRIGGER
 	help
 	  Provides support for using GPIO pins as IIO triggers.

+config IIO_SYSFS_TRIGGER
+	tristate "SYSFS trigger"
+	depends on SYSFS
+	help
+	  Provides support for using SYSFS entry as IIO triggers.
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called iio-trig-sysfs.
+
 endif # IIO_TRIGGER
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
index 10aeca5..504b9c0 100644
--- a/drivers/staging/iio/trigger/Makefile
+++ b/drivers/staging/iio/trigger/Makefile
@@ -4,3 +4,4 @@

 obj-$(CONFIG_IIO_PERIODIC_RTC_TRIGGER) += iio-trig-periodic-rtc.o
 obj-$(CONFIG_IIO_GPIO_TRIGGER) += iio-trig-gpio.o
+obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
diff --git a/drivers/staging/iio/trigger/iio-trig-sysfs.c b/drivers/staging/iio/trigger/iio-trig-sysfs.c
new file mode 100644
index 0000000..127a2a3
--- /dev/null
+++ b/drivers/staging/iio/trigger/iio-trig-sysfs.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "../iio.h"
+#include "../trigger.h"
+
+static ssize_t iio_sysfs_trigger_poll(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct iio_trigger *trig = dev_get_drvdata(dev);
+	iio_trigger_poll(trig, 0);
+
+	return count;
+}
+
+static DEVICE_ATTR(trigger_now, S_IWUSR, NULL, iio_sysfs_trigger_poll);
+static IIO_TRIGGER_NAME_ATTR;
+
+static struct attribute *iio_sysfs_trigger_attrs[] = {
+	&dev_attr_trigger_now.attr,
+	&dev_attr_name.attr,
+	NULL,
+};
+
+static const struct attribute_group iio_sysfs_trigger_attr_group = {
+	.attrs = iio_sysfs_trigger_attrs,
+};
+
+static int __devinit iio_sysfs_trigger_probe(struct platform_device *pdev)
+{
+	struct iio_trigger *trig;
+	int ret;
+
+	trig = iio_allocate_trigger();
+	if (!trig) {
+		ret = -ENOMEM;
+		goto out1;
+	}
+
+	trig->control_attrs = &iio_sysfs_trigger_attr_group;
+	trig->owner = THIS_MODULE;
+	trig->name = kasprintf(GFP_KERNEL, "sysfstrig%d", pdev->id);
+	if (trig->name == NULL) {
+		ret = -ENOMEM;
+		goto out2;
+	}
+
+	ret = iio_trigger_register(trig);
+	if (ret)
+		goto out3;
+
+	platform_set_drvdata(pdev, trig);
+
+	return 0;
+out3:
+	kfree(trig->name);
+out2:
+	iio_put_trigger(trig);
+out1:
+
+	return ret;
+}
+
+static int __devexit iio_sysfs_trigger_remove(struct platform_device *pdev)
+{
+	struct iio_trigger *trig = platform_get_drvdata(pdev);
+
+	iio_trigger_unregister(trig);
+	kfree(trig->name);
+	iio_put_trigger(trig);
+
+	return 0;
+}
+
+static struct platform_driver iio_sysfs_trigger_driver = {
+	.driver = {
+		.name = "iio_sysfs_trigger",
+		.owner = THIS_MODULE,
+	},
+	.probe = iio_sysfs_trigger_probe,
+	.remove = __devexit_p(iio_sysfs_trigger_remove),
+};
+
+static int __init iio_sysfs_trig_init(void)
+{
+	return platform_driver_register(&iio_sysfs_trigger_driver);
+}
+module_init(iio_sysfs_trig_init);
+
+static void __exit iio_sysfs_trig_exit(void)
+{
+	platform_driver_unregister(&iio_sysfs_trigger_driver);
+}
+module_exit(iio_sysfs_trig_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Sysfs based trigger for the iio subsystem");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:iio-trig-sysfs");
--
1.6.0.2
