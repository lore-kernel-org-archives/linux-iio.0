Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:38989 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdIEJo0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Sep 2017 05:44:26 -0400
Message-Id: <d5a12cb12480235e05315e9c8fa6e8b5f5a3dfb6.1504604178.git.lukas@wunner.de>
In-Reply-To: <be82f31ef2f0f39c7893b42dfe46c7235ea6144a.1504604178.git.lukas@wunner.de>
References: <be82f31ef2f0f39c7893b42dfe46c7235ea6144a.1504604178.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 5 Sep 2017 11:44:00 +0200
Subject: [PATCH 2/2] drivers: misc: ti_dac7512: Remove duplicate driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Andrew F. Davis" <afd@ti.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Daniel Mack <daniel@zonque.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Texas Instruments DAC7512 has the exact same pinout, programming
interface and power-down modes as the Texas Instruments DAC121S101 and
Analog Devices AD5320, which are already supported by the IIO driver
ad5446.c.  Remove the duplicate misc driver.

This requires user space to migrate to the standardized IIO sysfs ABI.
(In other words, it needs to change a filename.)

The IIO driver supports the chip's features more fully, e.g. the ability
to power down the output or choose one of the available powerdown modes.

There is an oddity with the misc driver in that it initializes the SPI
slave to SPI_MODE_0, in contradiction to the datasheet which specifies
that data is latched in on the falling edge, implying that SPI_MODE_1
or SPI_MODE_2 must be used.  Another oddity is that Kconfig and the
MODULE_DESCRIPTION() claim the chip has 16-bit resolution although it
actually has 12-bit.

Datasheets:
http://www.ti.com/lit/ds/symlink/dac7512.pdf
http://www.ti.com/lit/ds/symlink/dac121s101.pdf
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5320.pdf

Cc: Daniel Mack <daniel@zonque.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 arch/arm/configs/pxa_defconfig      |   3 +-
 arch/arm/configs/raumfeld_defconfig |   3 +-
 drivers/iio/dac/ad5446.c            |  10 ++++
 drivers/misc/Kconfig                |  10 ----
 drivers/misc/Makefile               |   1 -
 drivers/misc/ti_dac7512.c           | 103 ------------------------------------
 6 files changed, 14 insertions(+), 116 deletions(-)
 delete mode 100644 drivers/misc/ti_dac7512.c

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 64e3a2a8cede..1a608ec04e17 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -219,7 +219,8 @@ CONFIG_AD525X_DPOT_I2C=m
 CONFIG_ICS932S401=m
 CONFIG_APDS9802ALS=m
 CONFIG_ISL29003=m
-CONFIG_TI_DAC7512=m
+CONFIG_IIO=m
+CONFIG_AD5446=m
 CONFIG_EEPROM_AT24=m
 CONFIG_SENSORS_LIS3_SPI=m
 CONFIG_IDE=m
diff --git a/arch/arm/configs/raumfeld_defconfig b/arch/arm/configs/raumfeld_defconfig
index e3dc80ead465..77a56c23c6ef 100644
--- a/arch/arm/configs/raumfeld_defconfig
+++ b/arch/arm/configs/raumfeld_defconfig
@@ -37,7 +37,8 @@ CONFIG_MTD_NAND_PXA3xx=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_ISL29003=y
-CONFIG_TI_DAC7512=y
+CONFIG_IIO=y
+CONFIG_AD5446=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 3f6465de39de..fd26a4272fc5 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -463,10 +463,19 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 	{"dac081s101", ID_AD5300}, /* compatible Texas Instruments chips */
 	{"dac101s101", ID_AD5310},
 	{"dac121s101", ID_AD5320},
+	{"dac7512", ID_AD5320},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id ad5446_of_ids[] = {
+	{ .compatible = "ti,dac7512" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5446_of_ids);
+#endif
+
 static int ad5446_spi_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -483,6 +492,7 @@ static int ad5446_spi_remove(struct spi_device *spi)
 static struct spi_driver ad5446_spi_driver = {
 	.driver = {
 		.name	= "ad5446",
+		.of_match_table = of_match_ptr(ad5446_of_ids),
 	},
 	.probe		= ad5446_spi_probe,
 	.remove		= ad5446_spi_remove,
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 8136dc7e863d..f1a5c2357b14 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -393,16 +393,6 @@ config SPEAR13XX_PCIE_GADGET
 	 entry will be created for that controller. User can use these
 	 sysfs node to configure PCIe EP as per his requirements.
 
-config TI_DAC7512
-	tristate "Texas Instruments DAC7512"
-	depends on SPI && SYSFS
-	help
-	  If you say yes here you get support for the Texas Instruments
-	  DAC7512 16-bit digital-to-analog converter.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called ti_dac7512.
-
 config VMWARE_BALLOON
 	tristate "VMware Balloon Driver"
 	depends on VMWARE_VMCI && X86 && HYPERVISOR_GUEST
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b0b766416306..7c8eb47177f7 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -30,7 +30,6 @@ obj-$(CONFIG_ISL29003)		+= isl29003.o
 obj-$(CONFIG_ISL29020)		+= isl29020.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_DS1682)		+= ds1682.o
-obj-$(CONFIG_TI_DAC7512)	+= ti_dac7512.o
 obj-$(CONFIG_C2PORT)		+= c2port/
 obj-$(CONFIG_HMC6352)		+= hmc6352.o
 obj-y				+= eeprom/
diff --git a/drivers/misc/ti_dac7512.c b/drivers/misc/ti_dac7512.c
deleted file mode 100644
index f5456fb7d773..000000000000
--- a/drivers/misc/ti_dac7512.c
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- *  dac7512.c - Linux kernel module for
- * 	Texas Instruments DAC7512
- *
- *  Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/module.h>
-#include <linux/spi/spi.h>
-#include <linux/of.h>
-
-static ssize_t dac7512_store_val(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t count)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	unsigned char tmp[2];
-	unsigned long val;
-	int ret;
-
-	ret = kstrtoul(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	tmp[0] = val >> 8;
-	tmp[1] = val & 0xff;
-	spi_write(spi, tmp, sizeof(tmp));
-	return count;
-}
-
-static DEVICE_ATTR(value, S_IWUSR, NULL, dac7512_store_val);
-
-static struct attribute *dac7512_attributes[] = {
-	&dev_attr_value.attr,
-	NULL
-};
-
-static const struct attribute_group dac7512_attr_group = {
-	.attrs = dac7512_attributes,
-};
-
-static int dac7512_probe(struct spi_device *spi)
-{
-	int ret;
-
-	spi->bits_per_word = 8;
-	spi->mode = SPI_MODE_0;
-	ret = spi_setup(spi);
-	if (ret < 0)
-		return ret;
-
-	return sysfs_create_group(&spi->dev.kobj, &dac7512_attr_group);
-}
-
-static int dac7512_remove(struct spi_device *spi)
-{
-	sysfs_remove_group(&spi->dev.kobj, &dac7512_attr_group);
-	return 0;
-}
-
-static const struct spi_device_id dac7512_id_table[] = {
-	{ "dac7512", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(spi, dac7512_id_table);
-
-#ifdef CONFIG_OF
-static const struct of_device_id dac7512_of_match[] = {
-	{ .compatible = "ti,dac7512", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, dac7512_of_match);
-#endif
-
-static struct spi_driver dac7512_driver = {
-	.driver = {
-		.name	= "dac7512",
-		.of_match_table = of_match_ptr(dac7512_of_match),
-	},
-	.probe	= dac7512_probe,
-	.remove	= dac7512_remove,
-	.id_table = dac7512_id_table,
-};
-
-module_spi_driver(dac7512_driver);
-
-MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("DAC7512 16-bit DAC");
-MODULE_LICENSE("GPL v2");
-- 
2.11.0

