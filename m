Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35607 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdCDIc6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2017 03:32:58 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmitry.torokhov@gmail.com, michael.hennerich@analog.com,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        florian.vaussard@heig-vd.ch, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v6 4/4] iio: accel: adxl345: Add SPI support
Date: Sat,  4 Mar 2017 16:31:26 +0800
Message-Id: <211e687f6848450067db4c1a294303a40aa66d57.1488615230.git.eraretuya@gmail.com>
In-Reply-To: <cover.1488615230.git.eraretuya@gmail.com>
References: <cover.1488615230.git.eraretuya@gmail.com>
In-Reply-To: <cover.1488615230.git.eraretuya@gmail.com>
References: <cover.1488615230.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add SPI driver that initializes SPI regmap for the adxl345 core driver.
The driver supports the same functionality as I2C namely the x, y, z and
scale readings.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes from v5:
* Simplify configuration dependency to "depends on INPUT_ADXL34X=n"
* Modify header comment: place indication at the beginning
* Re-order local variable declarations from longest to shortest line
* Remove explicit casting to int in handling devm_regmap_init_spi() error,
  use %ld instead
* Rename functions calls from *_common_* to *_core_*

 drivers/iio/accel/Kconfig       | 14 +++++++
 drivers/iio/accel/Makefile      |  1 +
 drivers/iio/accel/adxl345_spi.c | 81 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/iio/accel/adxl345_spi.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index a725227..15de262 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -22,6 +22,20 @@ config ADXL345_I2C
 	  will be called adxl345_i2c and you will also get adxl345_core
 	  for the core module.
 
+config ADXL345_SPI
+	tristate "Analog Devices ADXL345 3-Axis Digital Accelerometer SPI Driver"
+	depends on INPUT_ADXL34X=n
+	depends on SPI
+	select ADXL345
+	select REGMAP_SPI
+	help
+	  Say Y here if you want to build support for the Analog Devices
+	  ADXL345 3-axis digital accelerometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called adxl345_spi and you will also get adxl345_core
+	  for the core module.
+
 config BMA180
 	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
 	depends on I2C
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 3f4a6d6..31fba19 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -5,6 +5,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
+obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
new file mode 100644
index 0000000..6d65819
--- /dev/null
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -0,0 +1,81 @@
+/*
+ * ADXL345 3-Axis Digital Accelerometer SPI driver
+ *
+ * Copyright (c) 2017 Eva Rachel Retuya <eraretuya@gmail.com>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License. See the file COPYING in the main
+ * directory of this archive for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "adxl345.h"
+
+#define ADXL345_MAX_SPI_FREQ_HZ		5000000
+
+static const struct regmap_config adxl345_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	 /* Setting bits 7 and 6 enables multiple-byte read */
+	.read_flag_mask = BIT(7) | BIT(6),
+};
+
+static int adxl345_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *regmap;
+
+	/* Bail out if max_speed_hz exceeds 5 MHz */
+	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ) {
+		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds 5 MHz\n",
+			spi->max_speed_hz);
+		return -EINVAL;
+	}
+
+	regmap = devm_regmap_init_spi(spi, &adxl345_spi_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return adxl345_core_probe(&spi->dev, regmap, id->name);
+}
+
+static int adxl345_spi_remove(struct spi_device *spi)
+{
+	return adxl345_core_remove(&spi->dev);
+}
+
+static const struct spi_device_id adxl345_spi_id[] = {
+	{ "adxl345", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
+
+static const struct of_device_id adxl345_of_match[] = {
+	{ .compatible = "adi,adxl345" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, adxl345_of_match);
+
+static struct spi_driver adxl345_spi_driver = {
+	.driver = {
+		.name	= "adxl345_spi",
+		.of_match_table = adxl345_of_match,
+	},
+	.probe		= adxl345_spi_probe,
+	.remove		= adxl345_spi_remove,
+	.id_table	= adxl345_spi_id,
+};
+
+module_spi_driver(adxl345_spi_driver);
+
+MODULE_AUTHOR("Eva Rachel Retuya <eraretuya@gmail.com>");
+MODULE_DESCRIPTION("ADXL345 3-Axis Digital Accelerometer SPI driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

