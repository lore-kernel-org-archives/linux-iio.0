Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36333 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbcLKCsi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2016 21:48:38 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH v3 2/2] staging: iio: ad7606: move out of staging
Date: Sun, 11 Dec 2016 10:47:49 +0800
Message-Id: <406fd6f60db88f051b36bf6f28cfe8fc8b1acb32.1481424136.git.eraretuya@gmail.com>
In-Reply-To: <cover.1481424136.git.eraretuya@gmail.com>
References: <cover.1481424136.git.eraretuya@gmail.com>
In-Reply-To: <cover.1481424136.git.eraretuya@gmail.com>
References: <cover.1481424136.git.eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the ad7606 driver from staging/iio/adc to iio/adc. Also, update the
corresponding Makefile and Kconfig associated with the change.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/iio/adc/Kconfig                    | 34 ++++++++++++++++++++++++++++++
 drivers/iio/adc/Makefile                   |  3 +++
 drivers/{staging => }/iio/adc/ad7606.c     |  0
 drivers/{staging => }/iio/adc/ad7606.h     |  0
 drivers/{staging => }/iio/adc/ad7606_par.c |  0
 drivers/{staging => }/iio/adc/ad7606_spi.c |  0
 drivers/staging/iio/adc/Kconfig            | 34 ------------------------------
 drivers/staging/iio/adc/Makefile           |  4 ----
 8 files changed, 37 insertions(+), 38 deletions(-)
 rename drivers/{staging => }/iio/adc/ad7606.c (100%)
 rename drivers/{staging => }/iio/adc/ad7606.h (100%)
 rename drivers/{staging => }/iio/adc/ad7606_par.c (100%)
 rename drivers/{staging => }/iio/adc/ad7606_spi.c (100%)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index be81ba3..3fa2c60 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -58,6 +58,40 @@ config AD7476
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7476.
 
+config AD7606
+	tristate "Analog Devices AD7606 ADC driver"
+	depends on GPIOLIB || COMPILE_TEST
+	depends on HAS_IOMEM
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices:
+	  ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7606.
+
+config AD7606_IFACE_PARALLEL
+	tristate "parallel interface support"
+	depends on AD7606
+	help
+	  Say yes here to include parallel interface support on the AD7606
+	  ADC driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7606_parallel.
+
+config AD7606_IFACE_SPI
+	tristate "spi interface support"
+	depends on AD7606
+	depends on SPI
+	help
+	  Say yes here to include parallel interface support on the AD7606
+	  ADC driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7606_spi.
+
 config AD7766
 	tristate "Analog Devices AD7766/AD7767 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index f8e1218..dfe7dea 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -9,6 +9,9 @@ obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7923) += ad7923.o
 obj-$(CONFIG_AD7476) += ad7476.o
+obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
+obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
+obj-$(CONFIG_AD7606) += ad7606.o
 obj-$(CONFIG_AD7766) += ad7766.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
similarity index 100%
rename from drivers/staging/iio/adc/ad7606.c
rename to drivers/iio/adc/ad7606.c
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
similarity index 100%
rename from drivers/staging/iio/adc/ad7606.h
rename to drivers/iio/adc/ad7606.h
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
similarity index 100%
rename from drivers/staging/iio/adc/ad7606_par.c
rename to drivers/iio/adc/ad7606_par.c
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
similarity index 100%
rename from drivers/staging/iio/adc/ad7606_spi.c
rename to drivers/iio/adc/ad7606_spi.c
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index deff899..995867b 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -3,40 +3,6 @@
 #
 menu "Analog to digital converters"
 
-config AD7606
-	tristate "Analog Devices AD7606 ADC driver"
-	depends on GPIOLIB || COMPILE_TEST
-	depends on HAS_IOMEM
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for Analog Devices:
-	  ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606.
-
-config AD7606_IFACE_PARALLEL
-	tristate "parallel interface support"
-	depends on AD7606
-	help
-	  Say yes here to include parallel interface support on the AD7606
-	  ADC driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606_parallel.
-
-config AD7606_IFACE_SPI
-	tristate "spi interface support"
-	depends on AD7606
-	depends on SPI
-	help
-	  Say yes here to include parallel interface support on the AD7606
-	  ADC driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606_spi.
-
 config AD7780
 	tristate "Analog Devices AD7780 and similar ADCs driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index ac09485..549032b 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -2,10 +2,6 @@
 # Makefile for industrial I/O ADC drivers
 #
 
-obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
-obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
-obj-$(CONFIG_AD7606) += ad7606.o
-
 obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_AD7192) += ad7192.o
-- 
2.7.4

