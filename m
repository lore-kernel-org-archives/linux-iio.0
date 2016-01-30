Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:55823 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164AbcA3Jo7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 30 Jan 2016 04:44:59 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, Adriana Reus <adriana.reus@intel.com>
Subject: [RFC PATCH 5/5] iio: imu: inv_mpu6050: Add SPI support for MPU6000
Date: Sat, 30 Jan 2016 11:43:48 +0200
Message-Id: <1454147028-22449-6-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1454147028-22449-1-git-send-email-adriana.reus@intel.com>
References: <1454147028-22449-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The only difference between the MPU6000 and the
MPU6050 is that the first also supports SPI.
Add SPI driver for this chip.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig       |  7 ++-
 drivers/iio/imu/inv_mpu6050/Makefile      |  5 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 80 +++++++++++++++++++++++++++++++
 4 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 2225d3c..4ebe8d6 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -8,6 +8,7 @@ config INV_MPU6050_IIO
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select INV_MPU6050_I2C if I2C
+	select INV_MPU6050_SPI if SPI
 	help
 	  This driver supports the Invensense MPU6050 devices.
 	  This driver can also support MPU6500 in MPU6050 compatibility mode
@@ -20,4 +21,8 @@ config INV_MPU6050_I2C
 	tristate "Invensense MPU6050 devices"
 	depends on I2C
 	select I2C_MUX
-	select REGMAP_I2C
\ No newline at end of file
+	select REGMAP_I2C
+
+config INV_MPU6050_SPI
+	tristate "Invensense MPU6050 devices"
+	select REGMAP_SPI
diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
index cb5df02..734af5e 100644
--- a/drivers/iio/imu/inv_mpu6050/Makefile
+++ b/drivers/iio/imu/inv_mpu6050/Makefile
@@ -6,4 +6,7 @@ obj-$(CONFIG_INV_MPU6050_IIO) += inv-mpu6050.o
 inv-mpu6050-objs := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
 
 obj-$(CONFIG_INV_MPU6050_I2C) += inv-mpu6050-i2c.o
-inv-mpu6050-i2c-objs := inv_mpu_i2c.o inv_mpu_acpi.o
\ No newline at end of file
+inv-mpu6050-i2c-objs := inv_mpu_i2c.o inv_mpu_acpi.o
+
+obj-$(CONFIG_INV_MPU6050_SPI) += inv-mpu6050-spi.o
+inv-mpu6050-spi-objs := inv_mpu_spi.o
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 0ef6046..74181d8 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -62,6 +62,7 @@ struct inv_mpu6050_reg_map {
 enum inv_devices {
 	INV_MPU6050,
 	INV_MPU6500,
+	INV_MPU6000,
 	INV_NUM_PARTS
 };
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
new file mode 100644
index 0000000..f94f121
--- /dev/null
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -0,0 +1,80 @@
+/*
+* Copyright (C) 2015 Intel Corporation Inc.
+*
+* This software is licensed under the terms of the GNU General Public
+* License version 2, as published by the Free Software Foundation, and
+* may be copied, distributed, and modified under those terms.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*/
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
+#include "inv_mpu_iio.h"
+
+static const struct regmap_config inv_mpu_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int inv_mpu_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	const char *name = id ? id->name : NULL;
+
+	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return inv_mpu_core_probe(&spi->dev, regmap, spi->irq, name);
+}
+
+static int inv_mpu_remove(struct spi_device *spi)
+{
+	return inv_mpu_core_remove(&spi->dev);
+}
+
+/*
+ * device id table is used to identify what device can be
+ * supported by this driver
+ */
+static const struct spi_device_id inv_mpu_id[] = {
+	{"mpu6050", INV_MPU6050},
+	{"mpu6000", INV_MPU6000},
+	{}
+};
+
+MODULE_DEVICE_TABLE(spi, inv_mpu_id);
+
+static const struct acpi_device_id inv_acpi_match[] = {
+	{"INVN6000", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
+
+static struct spi_driver inv_mpu_driver = {
+	.probe		=	inv_mpu_probe,
+	.remove		=	inv_mpu_remove,
+	.id_table	=	inv_mpu_id,
+	.driver = {
+		.owner	=	THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(inv_acpi_match),
+		.name	=	"inv-mpu6050 spi driver",
+		.pm     =       &inv_mpu_pmops,
+	},
+};
+
+module_spi_driver(inv_mpu_driver);
+
+MODULE_AUTHOR("Adriana Reus <adriana.reus@intel.com>");
+MODULE_DESCRIPTION("Invensense device MPU6050 driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1

