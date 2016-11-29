Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38307 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757594AbcK2PW6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Nov 2016 10:22:58 -0500
Received: by mail-wm0-f51.google.com with SMTP id f82so191620154wmf.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Nov 2016 07:22:58 -0800 (PST)
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] iio: misc: add a generic regulator driver
Date: Tue, 29 Nov 2016 16:22:49 +0100
Message-Id: <1480432969-20913-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some iio devices are powered externally by a regulator which, for
example, can be used to power-cycle an adc.

This patch proposes to add a simple driver representing a regulator
to the iio framework which exports attributes allowing to manipulate
the underlying hardware.

The reason for connecting the regulator and the iio frameworks is that
once libiio learns to toggle iio attributes we'll be able to
power-cycle devices remotely.

Initially the driver only supports enable/disable operations, but it
should be straightforward to extend it with other regulator operations
in the future.

Tested with a baylibre-acme board for beaglebone black.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/iio/misc/iio-regulator.txt |  18 +++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/misc/Kconfig                           |  17 +++
 drivers/iio/misc/Makefile                          |   6 +
 drivers/iio/misc/iio-regulator.c                   | 121 +++++++++++++++++++++
 6 files changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
 create mode 100644 drivers/iio/misc/Kconfig
 create mode 100644 drivers/iio/misc/Makefile
 create mode 100644 drivers/iio/misc/iio-regulator.c

diff --git a/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
new file mode 100644
index 0000000..147458f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/misc/iio-regulator.txt
@@ -0,0 +1,18 @@
+Industrial IO regulator device driver
+-------------------------------------
+
+This document describes the bindings for the iio-regulator - a dummy device
+driver representing a physical regulator within the iio framework.
+
+Required properties:
+
+- compatible: must be "iio-regulator"
+- vcc-supply: phandle of the regulator this device represents
+
+Example
+-------
+
+iio_regulator {
+	compatible = "iio-regulator";
+	vcc-supply = <&vcc0>;
+};
diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 6743b18..2e896e0 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -80,6 +80,7 @@ source "drivers/iio/gyro/Kconfig"
 source "drivers/iio/health/Kconfig"
 source "drivers/iio/humidity/Kconfig"
 source "drivers/iio/imu/Kconfig"
+source "drivers/iio/misc/Kconfig"
 source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 source "drivers/iio/orientation/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 87e4c43..4008d5a 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -25,6 +25,7 @@ obj-y += frequency/
 obj-y += health/
 obj-y += humidity/
 obj-y += imu/
+obj-y += misc/
 obj-y += light/
 obj-y += magnetometer/
 obj-y += orientation/
diff --git a/drivers/iio/misc/Kconfig b/drivers/iio/misc/Kconfig
new file mode 100644
index 0000000..b43a1ed
--- /dev/null
+++ b/drivers/iio/misc/Kconfig
@@ -0,0 +1,17 @@
+#
+# Miscellaneous iio drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Miscellaneous iio drivers"
+
+config IIO_REGULATOR
+	tristate "IIO regulator driver"
+	depends on REGULATOR
+	help
+	  Say yes here to build support for regulators powering iio devices.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called iio-regulator.
+
+endmenu
diff --git a/drivers/iio/misc/Makefile b/drivers/iio/misc/Makefile
new file mode 100644
index 0000000..da8f56a
--- /dev/null
+++ b/drivers/iio/misc/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for IIO misc drivers
+#
+
+# When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_IIO_REGULATOR) += iio-regulator.o
diff --git a/drivers/iio/misc/iio-regulator.c b/drivers/iio/misc/iio-regulator.c
new file mode 100644
index 0000000..0d61553
--- /dev/null
+++ b/drivers/iio/misc/iio-regulator.c
@@ -0,0 +1,121 @@
+/*
+ * Generic regulator driver for industrial IO.
+ *
+ * Copyright (C) 2016 BayLibre SAS
+ *
+ * Author:
+ *   Bartosz Golaszewski <bgolaszewski@baylibre.com.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+struct iio_regulator_context {
+	struct regulator *regulator;
+};
+
+static ssize_t iio_regulator_enable_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_regulator_context *ctx = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%d\n", regulator_is_enabled(ctx->regulator));
+}
+
+static ssize_t iio_regulator_enable_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t len)
+{
+	struct iio_regulator_context *ctx = iio_priv(dev_to_iio_dev(dev));
+	int ret, enabled;
+	bool val;
+
+	ret = strtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	enabled = regulator_is_enabled(ctx->regulator);
+	if ((val && enabled) || (!val && !enabled))
+		return -EPERM;
+
+	ret = val ? regulator_enable(ctx->regulator) :
+		    regulator_disable(ctx->regulator);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(in_enable, 0644,
+		       iio_regulator_enable_show,
+		       iio_regulator_enable_store, 0);
+
+static struct attribute *iio_regulator_attributes[] = {
+	&iio_dev_attr_in_enable.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group iio_regulator_attribute_group = {
+	.attrs = iio_regulator_attributes,
+};
+
+static const struct iio_info iio_regulator_info = {
+	.driver_module = THIS_MODULE,
+	.attrs = &iio_regulator_attribute_group,
+};
+
+static int iio_regulator_probe(struct platform_device *pdev)
+{
+	struct iio_regulator_context *ctx;
+	struct iio_dev *iio_dev;
+	struct device *dev;
+
+	dev = &pdev->dev;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*ctx));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	ctx = iio_priv(iio_dev);
+
+	ctx->regulator = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(ctx->regulator)) {
+		dev_err(dev, "unable to get vcc regulator: %ld\n",
+			PTR_ERR(ctx->regulator));
+		return PTR_ERR(ctx->regulator);
+	}
+
+	iio_dev->dev.parent = dev;
+	iio_dev->dev.of_node = dev->of_node;
+	iio_dev->name = dev->driver->name;
+	iio_dev->info = &iio_regulator_info;
+
+	return devm_iio_device_register(dev, iio_dev);
+}
+
+static const struct of_device_id iio_regulator_of_match[] = {
+	{ .compatible = "iio-regulator", },
+	{ },
+};
+
+static struct platform_driver iio_regulator_platform_driver = {
+	.probe = iio_regulator_probe,
+	.driver = {
+		.name = "iio-regulator",
+		.of_match_table = iio_regulator_of_match,
+	},
+};
+module_platform_driver(iio_regulator_platform_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_DESCRIPTION("Regulator driver for iio");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3

