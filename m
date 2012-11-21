Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-222.synserver.de ([212.40.185.222]:1066 "EHLO
	smtp-out-222.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab2KUQ10 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Nov 2012 11:27:26 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 09/11] staging:iio: Move ad7793 driver out of staging
Date: Wed, 21 Nov 2012 17:27:14 +0100
Message-Id: <1353515236-21843-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1353515236-21843-1-git-send-email-lars@metafoo.de>
References: <1353515236-21843-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver does not expose any custom API to userspace and none of the standard
static code checker tools report any issues, so move it out of staging.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/Kconfig                                      | 12 ++++++++++++
 drivers/iio/adc/Makefile                                     |  1 +
 drivers/{staging => }/iio/adc/ad7793.c                       |  3 +--
 drivers/staging/iio/adc/Kconfig                              | 12 ------------
 drivers/staging/iio/adc/Makefile                             |  1 -
 .../staging/iio/adc => include/linux/platform_data}/ad7793.h |  8 ++------
 6 files changed, 16 insertions(+), 21 deletions(-)
 rename drivers/{staging => }/iio/adc/ad7793.c (99%)
 rename {drivers/staging/iio/adc => include/linux/platform_data}/ad7793.h (96%)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index cd5eed6..408557b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -42,6 +42,18 @@ config AD7791
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7791.
 
+config AD7793
+	tristate "Analog Devices AD7793 and similar ADCs driver"
+	depends on SPI
+	select AD_SIGMA_DELTA
+	help
+	  Say yes here to build support for Analog Devices AD7785, AD7792, AD7793,
+	  AD7794 and AD7795 SPI analog to digital converters (ADC).
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called AD7793.
+
 config AD7476
 	tristate "Analog Devices AD7476 and similar 1-channel ADCs driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 3256dc6..78202d9 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_AD7266) += ad7266.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7791) += ad7791.o
+obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
similarity index 99%
rename from drivers/staging/iio/adc/ad7793.c
rename to drivers/iio/adc/ad7793.c
index 0bbfdf3..8bcda5d 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -25,8 +25,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
-
-#include "ad7793.h"
+#include <linux/platform_data/ad7793.h>
 
 /* Registers */
 #define AD7793_REG_COMM		0 /* Communications Register (WO, 8-bit) */
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index dc8582b..fb8c239 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -70,18 +70,6 @@ config AD7780
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7780.
 
-config AD7793
-	tristate "Analog Devices AD7793 and similar ADCs driver"
-	depends on SPI
-	select AD_SIGMA_DELTA
-	help
-	  Say yes here to build support for Analog Devices AD7785, AD7792, AD7793,
-	  AD7794 and AD7795 SPI analog to digital converters (ADC).
-	  If unsure, say N (but it's safe to say "Y").
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called AD7793.
-
 config AD7816
 	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 7281451..d285596 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_AD799X) += ad799x.o
 
 obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7780) += ad7780.o
-obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_ADT7410) += adt7410.o
diff --git a/drivers/staging/iio/adc/ad7793.h b/include/linux/platform_data/ad7793.h
similarity index 96%
rename from drivers/staging/iio/adc/ad7793.h
rename to include/linux/platform_data/ad7793.h
index 0e455de..7ea6751 100644
--- a/drivers/staging/iio/adc/ad7793.h
+++ b/include/linux/platform_data/ad7793.h
@@ -5,12 +5,8 @@
  *
  * Licensed under the GPL-2.
  */
-#ifndef IIO_ADC_AD7793_H_
-#define IIO_ADC_AD7793_H_
-
-/*
- * TODO: struct ad7793_platform_data needs to go into include/linux/iio
- */
+#ifndef __LINUX_PLATFORM_DATA_AD7793_H__
+#define __LINUX_PLATFORM_DATA_AD7793_H__
 
 /**
  * enum ad7793_clock_source - AD7793 clock source selection
-- 
1.8.0

