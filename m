Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:58377 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790AbbFUKSZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 21 Jun 2015 06:18:25 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/1] iio:adc:Kconfig: rework help descriptions
Date: Sun, 21 Jun 2015 12:18:09 +0200
Message-Id: <1434881889-2908-1-git-send-email-knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rework the help text of several ADCs to make sure that:
  - the module name is mentioned, if the driver can be built as a module
  - "If unsure, say N" messages are dropped
  - right indentation is maintained

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
This patch is based on the cc10001_adc dependency and sort order fixes I
just submitted.

 drivers/iio/adc/Kconfig | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 4790071..aee1e87 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -20,6 +20,9 @@ config AD7266
 	  Say yes here to build support for Analog Devices AD7265 and AD7266
 	  ADCs.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7266.
+
 config AD7291
 	tristate "Analog Devices AD7291 ADC driver"
 	depends on I2C
@@ -52,8 +55,6 @@ config AD7476
 	  AD7277, AD7278, AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468,
 	  AD7495, AD7910, AD7920, AD7920 SPI analog to digital converters (ADC).
 
-	  If unsure, say N (but it's safe to say "Y").
-
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7476.
 
@@ -63,8 +64,7 @@ config AD7791
 	select AD_SIGMA_DELTA
 	help
 	  Say yes here to build support for Analog Devices AD7787, AD7788, AD7789,
-	  AD7790 and AD7791 SPI analog to digital converters (ADC). If unsure, say
-	  N (but it is safe to say "Y").
+	  AD7790 and AD7791 SPI analog to digital converters (ADC).
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7791.
@@ -76,7 +76,6 @@ config AD7793
 	help
 	  Say yes here to build support for Analog Devices AD7785, AD7792, AD7793,
 	  AD7794 and AD7795 SPI analog to digital converters (ADC).
-	  If unsure, say N (but it's safe to say "Y").
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called AD7793.
@@ -89,7 +88,6 @@ config AD7887
 	help
 	  Say yes here to build support for Analog Devices
 	  AD7887 SPI analog to digital converter (ADC).
-	  If unsure, say N (but it's safe to say "Y").
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7887.
@@ -117,6 +115,9 @@ config AD799X
 	  i2c analog to digital converters (ADC). Provides direct access
 	  via sysfs.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad799x.
+
 config AT91_ADC
 	tristate "Atmel AT91 ADC"
 	depends on ARCH_AT91
@@ -127,6 +128,9 @@ config AT91_ADC
 	help
 	  Say yes here to build support for Atmel AT91 ADC.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called at91_adc.
+
 config AXP288_ADC
 	tristate "X-Powers AXP288 ADC driver"
 	depends on MFD_AXP20X
@@ -135,6 +139,9 @@ config AXP288_ADC
 	  device. Depending on platform configuration, this general purpose ADC can
 	  be used for sampling sensors such as thermal resistors.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called axp288_adc.
+
 config BERLIN2_ADC
 	tristate "Marvell Berlin2 ADC driver"
 	depends on ARCH_BERLIN
@@ -142,6 +149,9 @@ config BERLIN2_ADC
 	  Marvell Berlin2 ADC driver. This ADC has 8 channels, with one used for
 	  temperature measurement.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called berlin2-adc.
+
 config CC10001_ADC
 	tristate "Cosmic Circuits 10001 ADC driver"
 	depends on HAS_IOMEM && HAVE_CLK && REGULATOR
@@ -170,12 +180,18 @@ config EXYNOS_ADC
 	  of SoCs for drivers such as the touchscreen and hwmon to use to share
 	  this resource.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called exynos_adc.
+
 config LP8788_ADC
 	tristate "LP8788 ADC driver"
 	depends on MFD_LP8788
 	help
 	  Say yes here to build support for TI LP8788 ADC.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called lp8788_adc.
+
 config MAX1027
 	tristate "Maxim max1027 ADC driver"
 	depends on SPI
@@ -185,6 +201,9 @@ config MAX1027
 	  Say yes here to build support for Maxim SPI ADC models
 	  max1027, max1029 and max1031.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called max1027.
+
 config MAX1363
 	tristate "Maxim max1363 ADC driver"
 	depends on I2C
@@ -201,6 +220,9 @@ config MAX1363
 	  max11646, max11647) Provides direct access via sysfs and buffered
 	  data via the iio dev interface.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called max1363.
+
 config MCP320X
 	tristate "Microchip Technology MCP3x01/02/04/08"
 	depends on SPI
@@ -309,15 +331,18 @@ config TI_AM335X_ADC
 	  Say yes here to build support for Texas Instruments ADC
 	  driver which is also a MFD client.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called ti_am335x_adc.
+
 config TWL4030_MADC
 	tristate "TWL4030 MADC (Monitoring A/D Converter)"
 	depends on TWL4030_CORE
 	help
-	This driver provides support for Triton TWL4030-MADC. The
-	driver supports both RT and SW conversion methods.
+	  This driver provides support for Triton TWL4030-MADC. The
+	  driver supports both RT and SW conversion methods.
 
-	This driver can also be built as a module. If so, the module will be
-	called twl4030-madc.
+	  This driver can also be built as a module. If so, the module will be
+	  called twl4030-madc.
 
 config TWL6030_GPADC
 	tristate "TWL6030 GPADC (General Purpose A/D Converter) Support"
@@ -350,6 +375,9 @@ config VIPERBOARD_ADC
 	  Say yes here to access the ADC part of the Nano River
 	  Technologies Viperboard.
 
+	  To compile this driver as a module, choose M here: the module will be
+	  called viperboard_adc.
+
 config XILINX_XADC
 	tristate "Xilinx XADC driver"
 	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
-- 
2.3.6

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
