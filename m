Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-233.synserver.de ([212.40.185.233]:1034 "EHLO
	smtp-out-233.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760614Ab2IGMoK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Sep 2012 08:44:10 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/10] iio: Move ad7476 driver out of staging
Date: Fri,  7 Sep 2012 14:44:29 +0200
Message-Id: <1347021872-7885-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1347021872-7885-1-git-send-email-lars@metafoo.de>
References: <1347021872-7885-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad7476 driver is a driver for simple single channel ADCs. The driver does
not export any experimental or custom ABI files nor do the static code check
tools report any issues, so move the driver out of staging.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/Kconfig                |   14 ++++++++++++++
 drivers/iio/adc/Makefile               |    1 +
 drivers/{staging => }/iio/adc/ad7476.c |    0
 drivers/staging/iio/adc/Kconfig        |   14 --------------
 drivers/staging/iio/adc/Makefile       |    2 --
 5 files changed, 15 insertions(+), 16 deletions(-)
 rename drivers/{staging => }/iio/adc/ad7476.c (100%)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a2c5071..260e20b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -18,6 +18,20 @@ config AD7266
 	  Say yes here to build support for Analog Devices AD7265 and AD7266
 	  ADCs.
 
+config AD7476
+	tristate "Analog Devices AD7475/6/7/8 AD7466/7/8 and AD7495 ADC driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices
+	  AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495
+	  SPI analog to digital converters (ADC).
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7476.
+
 config AT91_ADC
 	tristate "Atmel AT91 ADC"
 	depends on ARCH_AT91
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 5989356..17a60a8 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -4,4 +4,5 @@
 
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD7266) += ad7266.o
+obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
diff --git a/drivers/staging/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
similarity index 100%
rename from drivers/staging/iio/adc/ad7476.c
rename to drivers/iio/adc/ad7476.c
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index a1fa172..1b4a356 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -68,20 +68,6 @@ config AD799X_RING_BUFFER
 	  Say yes here to include ring buffer support in the AD799X
 	  ADC driver.
 
-config AD7476
-	tristate "Analog Devices AD7475/6/7/8 AD7466/7/8 and AD7495 ADC driver"
-	depends on SPI
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for Analog Devices
-	  AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495
-	  SPI analog to digital converters (ADC).
-	  If unsure, say N (but it's safe to say "Y").
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7476.
-
 config AD7887
 	tristate "Analog Devices AD7887 ADC driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 6b60af0..62ee02e 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -17,8 +17,6 @@ ad799x-y := ad799x_core.o
 ad799x-$(CONFIG_AD799X_RING_BUFFER) += ad799x_ring.o
 obj-$(CONFIG_AD799X) += ad799x.o
 
-obj-$(CONFIG_AD7476) += ad7476.o
-
 ad7887-y := ad7887_core.o
 ad7887-$(CONFIG_IIO_BUFFER) += ad7887_ring.o
 obj-$(CONFIG_AD7887) += ad7887.o
-- 
1.7.10.4

