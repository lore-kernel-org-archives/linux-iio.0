Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:53160 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759486Ab1EMQG2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 May 2011 12:06:28 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/5] staging:iio: Trivial kconfig reorganization and uniformity improvements.
Date: Fri, 13 May 2011 17:09:03 +0100
Message-Id: <1305302943-16475-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305302943-16475-1-git-send-email-jic23@cam.ac.uk>
References: <1305302943-16475-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Kconfig       |    8 +++---
 drivers/staging/iio/adc/Kconfig   |   48 ++++++++++++++++++------------------
 drivers/staging/iio/light/Kconfig |   26 ++++++++++----------
 3 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index e6235d1..f96d5b5 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -5,17 +5,17 @@
 menuconfig IIO
 	tristate "Industrial I/O support"
 	depends on !S390
-	---help---
+	help
 	  The industrial I/O subsystem provides a unified framework for
 	  drivers for many different types of embedded sensors using a
 	  number of different physical interfaces (i2c, spi, etc). See
-	  Documentation/industrialio for more information.
+	  drivers/staging/iio/Documentation for more information.
 if IIO
 
 config IIO_RING_BUFFER
-	bool "Enable ring buffer support within IIO"
+	bool "Enable buffer support within IIO"
 	help
-	  Provide core support for various ring buffer based data
+	  Provide core support for various buffer based data
 	  acquisition methods.
 
 if IIO_RING_BUFFER
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 228274b..00bfb9d 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -3,30 +3,6 @@
 #
 comment "Analog to digital convertors"
 
-config MAX1363
-	tristate "MAXIM max1363 ADC driver"
-	depends on I2C
-	select IIO_TRIGGER if IIO_RING_BUFFER
-	select MAX1363_RING_BUFFER
-	help
-	  Say yes here to build support for many MAXIM i2c analog to digital
-	  convertors (ADC). (max1361, max1362, max1363, max1364, max1036,
-	  max1037, max1038, max1039, max1136, max1136, max1137, max1138,
-	  max1139, max1236, max1237, max11238, max1239, max11600, max11601,
-	  max11602, max11603, max11604, max11605, max11606, max11607,
-	  max11608, max11609, max11610, max11611, max11612, max11613,
-	  max11614, max11615, max11616, max11617, max11644, max11645,
-	  max11646, max11647) Provides direct access via sysfs.
-
-config MAX1363_RING_BUFFER
-	bool "MAXIM max1363: use ring buffer"
-	depends on MAX1363
-	select IIO_RING_BUFFER
-	select IIO_SW_RING
-	help
-	  Say yes here to include ring buffer support in the MAX1363
-	  ADC driver.
-
 config AD7150
 	tristate "Analog Devices ad7150/1/6 capacitive sensor driver"
 	depends on I2C
@@ -190,3 +166,27 @@ config ADT7410
 	help
 	  Say yes here to build support for Analog Devices ADT7410
 	  temperature sensors.
+
+config MAX1363
+	tristate "Maxim max1363 ADC driver"
+	depends on I2C
+	select IIO_TRIGGER if IIO_RING_BUFFER
+	select MAX1363_RING_BUFFER
+	help
+	  Say yes here to build support for many Maxim i2c analog to digital
+	  convertors (ADC). (max1361, max1362, max1363, max1364, max1036,
+	  max1037, max1038, max1039, max1136, max1136, max1137, max1138,
+	  max1139, max1236, max1237, max11238, max1239, max11600, max11601,
+	  max11602, max11603, max11604, max11605, max11606, max11607,
+	  max11608, max11609, max11610, max11611, max11612, max11613,
+	  max11614, max11615, max11616, max11617, max11644, max11645,
+	  max11646, max11647) Provides direct access via sysfs.
+
+config MAX1363_RING_BUFFER
+	bool "Maxim max1363: use ring buffer"
+	depends on MAX1363
+	select IIO_RING_BUFFER
+	select IIO_SW_RING
+	help
+	  Say yes here to include ring buffer support in the MAX1363
+	  ADC driver.
diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index e9f3794..46d62d1 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -1,18 +1,8 @@
-#
+\#
 # Light sensors
 #
 comment "Light sensors"
 
-config SENSORS_TSL2563
-	tristate "TAOS TSL256[0-3] ambient light sensor"
-	depends on I2C
-	help
-	 If you say yes here you get support for the Taos TSL2560,
-	 TSL2561, TSL2562 and TSL2563 ambient light sensors.
-
-	 This driver can also be built as a module.  If so, the module
-	 will be called tsl2563.
-
 config SENSORS_ISL29018
         tristate "ISL 29018 light and proximity sensor"
         depends on I2C
@@ -24,9 +14,19 @@ config SENSORS_ISL29018
          in lux, proximity infrared sensing and normal infrared sensing.
          Data from sensor is accessible via sysfs.
 
+config SENSORS_TSL2563
+	tristate "TAOS TSL2560, TSL2561, TSL2562 and TSL2563 ambient light sensors"
+	depends on I2C
+	help
+	 If you say yes here you get support for the Taos TSL2560,
+	 TSL2561, TSL2562 and TSL2563 ambient light sensors.
+
+	 This driver can also be built as a module.  If so, the module
+	 will be called tsl2563.
+
 config TSL2583
-	tristate "TAOS TSL2580, TSL2581, and TSL2583 light-to-digital converters"
+	tristate "TAOS TSL2580, TSL2581 and TSL2583 light-to-digital converters"
 	depends on I2C
 	help
-	 Provides support for the TAOS tsl2580, tsl2581, and tsl2583 devices.
+	 Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
 	 Access ALS data via iio, sysfs.
-- 
1.7.3.4

