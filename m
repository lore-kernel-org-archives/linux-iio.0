Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH] iio: Spell fix - consistent use of Converter - no functional changes
Date: Wed, 19 Oct 2011 11:17:53 +0200
Message-ID: <1319015873-23897-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/Kconfig   |   18 +++++++++---------
 drivers/staging/iio/addac/Kconfig |    2 +-
 drivers/staging/iio/dac/Kconfig   |    4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index bfe91d7..13e93fb 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -1,7 +1,7 @@
 #
 # ADC drivers
 #
-menu "Analog to digital convertors"
+menu "Analog to digital converters"

 config AD7150
 	tristate "Analog Devices ad7150/1/6 capacitive sensor driver"
@@ -42,7 +42,7 @@ config AD7606
 	select IIO_SW_RING
 	help
 	  Say yes here to build support for Analog Devices:
-	  ad7606, ad7606-6, ad7606-4 analog to digital convertors (ADC).
+	  ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).

 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7606.
@@ -70,7 +70,7 @@ config AD799X
 	help
 	  Say yes here to build support for Analog Devices:
 	  ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997, ad7998
-	  i2c analog to digital convertors (ADC). Provides direct access
+	  i2c analog to digital converters (ADC). Provides direct access
 	  via sysfs.

 config AD799X_RING_BUFFER
@@ -91,7 +91,7 @@ config AD7476
 	help
 	  Say yes here to build support for Analog Devices
 	  AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495
-	  SPI analog to digital convertors (ADC).
+	  SPI analog to digital converters (ADC).
 	  If unsure, say N (but it's safe to say "Y").

 	  To compile this driver as a module, choose M here: the
@@ -105,7 +105,7 @@ config AD7887
 	select IIO_TRIGGER
 	help
 	  Say yes here to build support for Analog Devices
-	  AD7887 SPI analog to digital convertor (ADC).
+	  AD7887 SPI analog to digital converter (ADC).
 	  If unsure, say N (but it's safe to say "Y").

 	  To compile this driver as a module, choose M here: the
@@ -117,7 +117,7 @@ config AD7780
 	depends on GPIOLIB
 	help
 	  Say yes here to build support for Analog Devices
-	  AD7780 and AD7781 SPI analog to digital convertors (ADC).
+	  AD7780 and AD7781 SPI analog to digital converters (ADC).
 	  If unsure, say N (but it's safe to say "Y").

 	  To compile this driver as a module, choose M here: the
@@ -131,7 +131,7 @@ config AD7793
 	select IIO_TRIGGER
 	help
 	  Say yes here to build support for Analog Devices
-	  AD7792 and AD7793 SPI analog to digital convertors (ADC).
+	  AD7792 and AD7793 SPI analog to digital converters (ADC).
 	  If unsure, say N (but it's safe to say "Y").

 	  To compile this driver as a module, choose M here: the
@@ -163,7 +163,7 @@ config AD7192
 	select IIO_TRIGGER
 	help
 	  Say yes here to build support for Analog Devices AD7190,
-	  AD7192 or AD7195 SPI analog to digital convertors (ADC).
+	  AD7192 or AD7195 SPI analog to digital converters (ADC).
 	  If unsure, say N (but it's safe to say "Y").

 	  To compile this driver as a module, choose M here: the
@@ -200,7 +200,7 @@ config MAX1363
 	select MAX1363_RING_BUFFER
 	help
 	  Say yes here to build support for many Maxim i2c analog to digital
-	  convertors (ADC). (max1361, max1362, max1363, max1364, max1036,
+	  converters (ADC). (max1361, max1362, max1363, max1364, max1036,
 	  max1037, max1038, max1039, max1136, max1136, max1137, max1138,
 	  max1139, max1236, max1237, max11238, max1239, max11600, max11601,
 	  max11602, max11603, max11604, max11605, max11606, max11607,
diff --git a/drivers/staging/iio/addac/Kconfig b/drivers/staging/iio/addac/Kconfig
index 4b76375..698a897 100644
--- a/drivers/staging/iio/addac/Kconfig
+++ b/drivers/staging/iio/addac/Kconfig
@@ -1,7 +1,7 @@
 #
 # ADDAC drivers
 #
-menu "Analog digital bi-direction convertors"
+menu "Analog digital bi-direction converters"

 config ADT7316
 	tristate "Analog Devices ADT7316/7/8 ADT7516/7/9 temperature sensor, ADC and DAC driver"
diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index 3000156..5bddf9b 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -1,14 +1,14 @@
 #
 # DAC drivers
 #
-menu "Digital to analog convertors"
+menu "Digital to analog converters"

 config AD5624R_SPI
 	tristate "Analog Devices AD5624/44/64R DAC spi driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
-	  AD5664R convertors (DAC). This driver uses the common SPI interface.
+	  AD5664R converters (DAC). This driver uses the common SPI interface.

 config AD5446
 	tristate "Analog Devices AD5444/6, AD5620/40/60 and AD5542A/12A DAC SPI driver"
--
1.7.0.4
