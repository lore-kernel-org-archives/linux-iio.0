Return-Path: <k.kozlowski@samsung.com>
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] iio: adc: Fix build error of missing devm_ioremap_resource on
 UM
Date: Fri, 04 Mar 2016 10:05:26 +0900
Message-id: <1457053526-28841-1-git-send-email-k.kozlowski@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

The devres.o gets linked if HAS_IOMEM is present so on ARCH=um
allyesconfig (COMPILE_TEST) failed with:

drivers/built-in.o: In function `at91_adc_probe':
at91-sama5d2_adc.c:(.text+0x48f548): undefined reference to `devm_ioremap_resource'

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index af4aea7b20f9..82c718c515a0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -134,6 +134,7 @@ config AT91_ADC
 config AT91_SAMA5D2_ADC
 	tristate "Atmel AT91 SAMA5D2 ADC"
 	depends on ARCH_AT91 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Say yes here to build support for Atmel SAMA5D2 ADC which is
 	  available on SAMA5D2 SoC family.
-- 
2.5.0
