Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47741 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbbHLKNq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:13:46 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 20/20] iio: bmc150: Add SPI driver
Date: Wed, 12 Aug 2015 12:12:45 +0200
Message-Id: <1439374365-20623-21-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a simple SPI driver which initializes the spi regmap for the bmc150
core driver.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/iio/accel/Kconfig            | 10 +++++
 drivers/iio/accel/Makefile           |  1 +
 drivers/iio/accel/bmc150-accel-spi.c | 86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 drivers/iio/accel/bmc150-accel-spi.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index c63e981c38ff..bdb42069a767 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -40,6 +40,16 @@ config BMC150_ACCEL_I2C
 	  Say yes here to build support for I2C communication with the
 	  mentioned accelerometer.
 
+config BMC150_ACCEL_SPI
+	tristate "SPI support"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for SPI communication with the
+	  mentioned accelerometer.
+
 endif
 
 config HID_SENSOR_ACCEL_3D
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 5ef8bdbad092..e579e93bf022 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
 obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
+obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
 obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
diff --git a/drivers/iio/accel/bmc150-accel-spi.c b/drivers/iio/accel/bmc150-accel-spi.c
new file mode 100644
index 000000000000..c13fd2aa5f34
--- /dev/null
+++ b/drivers/iio/accel/bmc150-accel-spi.c
@@ -0,0 +1,86 @@
+/*
+ * 3-axis accelerometer driver supporting following I2C Bosch-Sensortec chips:
+ *  - BMC150
+ *  - BMI055
+ *  - BMA255
+ *  - BMA250E
+ *  - BMA222E
+ *  - BMA280
+ *
+ * Copyright (c) 2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "bmc150-accel.h"
+
+static const struct regmap_config bmc150_spi_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x3f,
+
+	.use_single_rw = false,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int bmc150_accel_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+	const struct spi_device_id *id = spi_get_device_id(spi);
+
+	regmap = devm_regmap_init_spi(spi, &bmc150_spi_regmap_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Failed to initialize spi regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	return bmc150_accel_core_probe(&spi->dev, regmap, spi->irq,
+				       id->name, id->driver_data, true);
+}
+
+static int bmc150_accel_remove(struct spi_device *spi)
+{
+	return bmc150_accel_core_remove(&spi->dev);
+}
+
+static const struct spi_device_id bmc150_accel_id[] = {
+	{"bmc150_accel",	bmc150},
+	{"bmi055_accel",	bmi055},
+	{"bma255",		bma255},
+	{"bma250e",		bma250e},
+	{"bma222e",		bma222e},
+	{"bma280",		bma280},
+	{}
+};
+
+MODULE_DEVICE_TABLE(spi, bmc150_accel_id);
+
+static struct spi_driver bmc150_accel_driver = {
+	.driver = {
+		.name	= "bmc150_accel_spi",
+		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
+		.pm	= &bmc150_accel_pm_ops,
+	},
+	.probe		= bmc150_accel_probe,
+	.remove		= bmc150_accel_remove,
+	.id_table	= bmc150_accel_id,
+};
+module_spi_driver(bmc150_accel_driver);
+
+MODULE_AUTHOR("Markus Pargmann <mpa@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("BMC150 SPI accelerometer driver");
-- 
2.4.6

