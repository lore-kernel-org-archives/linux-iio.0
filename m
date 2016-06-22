Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36013 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbcFVUy2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2016 16:54:28 -0400
Received: by mail-lf0-f48.google.com with SMTP id q132so82370565lfe.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2016 13:54:27 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Matt Ranostay <mranostay@gmail.com>
Cc: Christoph Mair <christoph.mair@gmail.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Marek Belisko <marek@goldelico.com>,
	Eric Andersson <eric.andersson@unixphere.com>,
	Neil Brown <neilb@suse.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 7/9 v2] iio: pressure: bmp280: add SPI interface driver
Date: Wed, 22 Jun 2016 22:53:37 +0200
Message-Id: <1466628819-29784-8-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
References: <1466628819-29784-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch mimics the SPI functionality found in the misc driver in
drivers/misc/bh085-spi.c to make it possible to reuse the existing
BMP280/BMP180/BMP085 driver with all clients of the other driver.
The adoption is straight-forward since like the other driver, it is
a simple matter of using regmap.

This driver is also so obviously inspired/copied from the old misc
driver in drivers/misc/bmp085.c that I just took the liberty to
add in the authors of the other drivers + self in the core driver
file.

The bus mapping code for SPI was written by Akinobu Mita.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix misnamed device table
- Added Akinobu's bus mapping code for SPI
- Add IDs and match strings for the new BME280 sensor too
---
 drivers/iio/pressure/Kconfig       |  15 ++++-
 drivers/iio/pressure/Makefile      |   1 +
 drivers/iio/pressure/bmp280-core.c |   4 ++
 drivers/iio/pressure/bmp280-spi.c  | 117 +++++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/pressure/bmp280-spi.c

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 94ad8e7ad0ec..8b209d14bac9 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -7,15 +7,17 @@ menu "Pressure sensors"
 
 config BMP280
 	tristate "Bosch Sensortec BMP180/BMP280 pressure sensor I2C driver"
-	depends on I2C
+	depends on (I2C || SPI_MASTER)
 	select BMP280_I2C if (I2C)
+	select BMP280_SPI if (SPI_MASTER)
 	help
 	  Say yes here to build support for Bosch Sensortec BMP180 and BMP280
 	  pressure and temperature sensors. Also supports the BE280 with
 	  an additional humidity sensor channel.
 
-	  To compile this driver as a module, choose M here: the modules
-	  will be called bmp280-i2c and bmp280.
+	  To compile this driver as a module, choose M here: the core module
+	  will be called bmp280 and you will also get bmp280-i2c for I2C
+	  and/or bmp280-spi for SPI support.
 
 config BMP280_I2C
 	tristate
@@ -24,6 +26,13 @@ config BMP280_I2C
 	depends on !(BMP085_I2C=y || BMP085_I2C=m)
 	select REGMAP_I2C
 
+config BMP280_SPI
+	tristate
+	depends on BMP280
+	depends on SPI_MASTER
+	depends on !(BMP085_SPI=y || BMP085_SPI=m)
+	select REGMAP_SPI
+
 config HID_SENSOR_PRESS
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 736f4305fe46..7f395bed5e88 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_BMP280) += bmp280.o
 bmp280-objs := bmp280-core.o bmp280-regmap.o
 obj-$(CONFIG_BMP280_I2C) += bmp280-i2c.o
+obj-$(CONFIG_BMP280_SPI) += bmp280-spi.o
 obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
 obj-$(CONFIG_HP03) += hp03.o
 obj-$(CONFIG_MPL115) += mpl115.o
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 77f0fc935c09..733ef3c08102 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1,5 +1,9 @@
 /*
+ * Copyright (c) 2010 Christoph Mair <christoph.mair@gmail.com>
+ * Copyright (c) 2012 Bosch Sensortec GmbH
+ * Copyright (c) 2012 Unixphere AB
  * Copyright (c) 2014 Intel Corporation
+ * Copyright (c) 2016 Linus Walleij <linus.walleij@linaro.org>
  *
  * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure sensor.
  *
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
new file mode 100644
index 000000000000..2b9955f48d58
--- /dev/null
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -0,0 +1,117 @@
+/*
+ * SPI interface for the BMP280 driver
+ *
+ * Inspired by the older BMP085 driver drivers/misc/bmp085-spi.c
+ */
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/err.h>
+#include <linux/regmap.h>
+
+#include "bmp280.h"
+
+static int bmp280_regmap_spi_write(void *context, const void *data,
+                                   size_t count)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+	u8 buf[2];
+
+	memcpy(buf, data, 2);
+	/*
+	 * The SPI register address (= full register address without bit 7) and
+	 * the write command (bit7 = RW = '0')
+	 */
+	buf[0] &= ~0x80;
+
+	return spi_write_then_read(spi, buf, 2, NULL, 0);
+}
+
+static int bmp280_regmap_spi_read(void *context, const void *reg,
+                                  size_t reg_size, void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+
+	return spi_write_then_read(spi, reg, reg_size, val, val_size);
+}
+
+static struct regmap_bus bmp280_regmap_bus = {
+	.write = bmp280_regmap_spi_write,
+	.read = bmp280_regmap_spi_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static int bmp280_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *regmap;
+	const struct regmap_config *regmap_config;
+	int ret;
+
+	spi->bits_per_word = 8;
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		dev_err(&spi->dev, "spi_setup failed!\n");
+		return ret;
+	}
+
+	switch (id->driver_data) {
+	case BMP180_CHIP_ID:
+		regmap_config = &bmp180_regmap_config;
+		break;
+	case BMP280_CHIP_ID:
+	case BME280_CHIP_ID:
+		regmap_config = &bmp280_regmap_config;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap = devm_regmap_init(&spi->dev,
+				  &bmp280_regmap_bus,
+				  &spi->dev,
+				  regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "failed to allocate register map\n");
+		return PTR_ERR(regmap);
+	}
+
+	return bmp280_common_probe(&spi->dev,
+				   regmap,
+				   id->driver_data,
+				   id->name);
+}
+
+static const struct of_device_id bmp280_of_spi_match[] = {
+	{ .compatible = "bosch,bmp085", },
+	{ .compatible = "bosch,bmp180", },
+	{ .compatible = "bosch,bmp181", },
+	{ .compatible = "bosch,bmp280", },
+	{ .compatible = "bosch,bme280", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
+
+static const struct spi_device_id bmp280_spi_id[] = {
+	{ "bmp180", BMP180_CHIP_ID },
+	{ "bmp181", BMP180_CHIP_ID },
+	{ "bmp280", BMP280_CHIP_ID },
+	{ "bme280", BME280_CHIP_ID },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, bmp280_spi_id);
+
+static struct spi_driver bmp280_spi_driver = {
+	.driver = {
+		.name   = "bmp280",
+		.of_match_table = bmp280_of_spi_match
+	},
+	.id_table       = bmp280_spi_id,
+	.probe          = bmp280_spi_probe,
+};
+module_spi_driver(bmp280_spi_driver);
+
+MODULE_DESCRIPTION("BMP085 SPI bus driver");
+MODULE_LICENSE("GPL");
-- 
2.4.11

