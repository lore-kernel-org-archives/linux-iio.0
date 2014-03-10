Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-220.synserver.de ([212.40.185.220]:1085 "EHLO
	smtp-out-129.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751735AbaCJKay (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Mar 2014 06:30:54 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] staging:iio: Move ad799x driver out of staging
Date: Mon, 10 Mar 2014 11:31:24 +0100
Message-Id: <1394447484-29334-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1394447484-29334-1-git-send-email-lars@metafoo.de>
References: <1394447484-29334-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver is now at a reasonable quality level. Move it out of staging.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/Kconfig                                     | 11 +++++++++++
 drivers/iio/adc/Makefile                                    |  1 +
 drivers/{staging/iio/adc/ad799x_core.c => iio/adc/ad799x.c} |  0
 drivers/staging/iio/adc/Kconfig                             | 11 -----------
 drivers/staging/iio/adc/Makefile                            |  3 ---
 5 files changed, 12 insertions(+), 14 deletions(-)
 rename drivers/{staging/iio/adc/ad799x_core.c => iio/adc/ad799x.c} (100%)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5553206..a036811 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -96,6 +96,17 @@ config AD7923
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7923.
 
+config AD799X
+	tristate "Analog Devices AD799x ADC driver"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices:
+	  ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997, ad7998
+	  i2c analog to digital converters (ADC). Provides direct access
+	  via sysfs.
+
 config AT91_ADC
 	tristate "Atmel AT91 ADC"
 	depends on ARCH_AT91
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 89f1216..1e2fc891 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
+obj-$(CONFIG_AD799X) += ad799x.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
 obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/iio/adc/ad799x.c
similarity index 100%
rename from drivers/staging/iio/adc/ad799x_core.c
rename to drivers/iio/adc/ad799x.c
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index ed23cceb..b87e382 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -37,17 +37,6 @@ config AD7606_IFACE_SPI
 	  Say yes here to include parallel interface support on the AD7606
 	  ADC driver.
 
-config AD799X
-	tristate "Analog Devices AD799x ADC driver"
-	depends on I2C
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for Analog Devices:
-	  ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997, ad7998
-	  i2c analog to digital converters (ADC). Provides direct access
-	  via sysfs.
-
 config AD7780
 	tristate "Analog Devices AD7780 and similar ADCs driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index b2d35f8..afdcd1f 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -8,9 +8,6 @@ ad7606-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 ad7606-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
 obj-$(CONFIG_AD7606) += ad7606.o
 
-ad799x-y := ad799x_core.o
-obj-$(CONFIG_AD799X) += ad799x.o
-
 obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7816) += ad7816.o
-- 
1.8.0

