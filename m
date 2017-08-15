Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:51523 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbdHOOrX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2017 10:47:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: select triggered buffer for sama5d2 adc
Date: Tue, 15 Aug 2017 16:46:31 +0200
Message-Id: <20170815144700.2030858-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Without the triggered buffer code, we get a link error:

drivers/iio/adc/at91-sama5d2_adc.o: In function `at91_adc_probe':
at91-sama5d2_adc.c:(.text+0x938): undefined reference to `devm_iio_triggered_buffer_setup'

This adds a Kconfig 'select' statement like other ADC
drivers have it already.

Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e4eeebac5297..57625653fcb6 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -158,6 +158,7 @@ config AT91_SAMA5D2_ADC
 	tristate "Atmel AT91 SAMA5D2 ADC"
 	depends on ARCH_AT91 || COMPILE_TEST
 	depends on HAS_IOMEM
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Atmel SAMA5D2 ADC which is
 	  available on SAMA5D2 SoC family.
-- 
2.9.0

