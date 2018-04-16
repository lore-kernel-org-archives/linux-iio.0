Return-Path: <SRS0=GZmW=HF=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] iio: adc: select buffer for at91-sama5d2_adc
Date: Mon, 16 Apr 2018 09:54:03 +0300
Message-ID: <1523861643-3419-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

We need to select the buffer code, otherwise we get build errors
with undefined functions on the trigger and buffer,
if we select just IIO and then AT91_SAMA5D2_ADC from menuconfig

This adds a Kconfig 'select' statement like other ADC
drivers have it already.

Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Hello Jonathan,

While you are at it, I also found this small kconfig issue during my tests.
Would be good to have as a fix as well.

Thanks,
Eugen

 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 15606f2..9da7907 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -158,6 +158,7 @@ config AT91_SAMA5D2_ADC
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on HAS_DMA
+	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Atmel SAMA5D2 ADC which is
-- 
2.7.4
