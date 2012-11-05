Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-191.synserver.de ([212.40.185.191]:1044 "EHLO
	smtp-out-191.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585Ab2KEJ5H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Nov 2012 04:57:07 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] staging:iio: Move the ad7887 driver out of staging
Date: Mon,  5 Nov 2012 10:56:46 +0100
Message-Id: <1352109406-7206-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1352109406-7206-1-git-send-email-lars@metafoo.de>
References: <1352109406-7206-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver does not expose any custom API to userspace and none of the standard
static code checker tools report any issues, so move it out of staging.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/Kconfig                                     | 13 +++++++++++++
 drivers/iio/adc/Makefile                                    |  1 +
 drivers/{staging => }/iio/adc/ad7887.c                      |  2 +-
 drivers/staging/iio/adc/Kconfig                             | 13 -------------
 drivers/staging/iio/adc/Makefile                            |  2 --
 .../iio/adc => include/linux/platform_data}/ad7887.h        |  5 -----
 6 files changed, 15 insertions(+), 21 deletions(-)
 rename drivers/{staging => }/iio/adc/ad7887.c (99%)
 rename {drivers/staging/iio/adc => include/linux/platform_data}/ad7887.h (90%)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 4927581..706386b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -45,6 +45,19 @@ config AD7476
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7476.
 
+config AD7887
+	tristate "Analog Devices AD7887 ADC driver"
+	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices
+	  AD7887 SPI analog to digital converter (ADC).
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7887.
+
 config AT91_ADC
 	tristate "Atmel AT91 ADC"
 	depends on ARCH_AT91
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 900995d..034eacb 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -6,5 +6,6 @@ obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD7266) += ad7266.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7791) += ad7791.o
+obj-$(CONFIG_AD7887) += ad7887.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
diff --git a/drivers/staging/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
similarity index 99%
rename from drivers/staging/iio/adc/ad7887.c
rename to drivers/iio/adc/ad7887.c
index 72cfe19..fd62309 100644
--- a/drivers/staging/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -23,7 +23,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include "ad7887.h"
+#include <linux/platform_data/ad7887.h>
 
 #define AD7887_REF_DIS		(1 << 5) /* on-chip reference disable */
 #define AD7887_DUAL		(1 << 4) /* dual-channel mode */
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 71a515d..eba64fb 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -68,19 +68,6 @@ config AD799X_RING_BUFFER
 	  Say yes here to include ring buffer support in the AD799X
 	  ADC driver.
 
-config AD7887
-	tristate "Analog Devices AD7887 ADC driver"
-	depends on SPI
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for Analog Devices
-	  AD7887 SPI analog to digital converter (ADC).
-	  If unsure, say N (but it's safe to say "Y").
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7887.
-
 config AD7780
 	tristate "Analog Devices AD7780 and similar ADCs driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 8036fd1..c56b41e 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -17,8 +17,6 @@ ad799x-y := ad799x_core.o
 ad799x-$(CONFIG_AD799X_RING_BUFFER) += ad799x_ring.o
 obj-$(CONFIG_AD799X) += ad799x.o
 
-obj-$(CONFIG_AD7887) += ad7887.o
-
 ad7298-y := ad7298_core.o
 ad7298-$(CONFIG_IIO_BUFFER) += ad7298_ring.o
 obj-$(CONFIG_AD7298) += ad7298.o
diff --git a/drivers/staging/iio/adc/ad7887.h b/include/linux/platform_data/ad7887.h
similarity index 90%
rename from drivers/staging/iio/adc/ad7887.h
rename to include/linux/platform_data/ad7887.h
index 78b06a3..dedb9735 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/include/linux/platform_data/ad7887.h
@@ -8,11 +8,6 @@
 #ifndef IIO_ADC_AD7887_H_
 #define IIO_ADC_AD7887_H_
 
-/*
- * TODO: struct ad7887_platform_data needs to go into include/linux/iio
- */
-
-
 /**
  * struct ad7887_platform_data - AD7887 ADC driver platform data
  * @en_dual: Whether to use dual channel mode. If set to true AIN1 becomes the
-- 
1.8.0

