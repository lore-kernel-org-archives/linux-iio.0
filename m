Return-Path: <SRS0=vIQ5=EK=infradead.org=rdunlap@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] iio/adc: depend on SYSFS instead of selecting it
To: linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ab9e8e58-4f97-f48d-ade4-962856e5dd11@infradead.org>
Date: Sun, 14 Jan 2018 21:11:05 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Drivers should not 'select' a subsystem. Instead they should depend
on it. If the subsystem is disabled, the user probably did that for
a purpose and one driver shouldn't be changing that.

This also makes all IIO drivers consistent w.r.t depending on SYSFS
instead of selecting it.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/adc/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- lnx-415-rc8.orig/drivers/iio/adc/Kconfig
+++ lnx-415-rc8/drivers/iio/adc/Kconfig
@@ -144,10 +144,9 @@ config ASPEED_ADC
 config AT91_ADC
 	tristate "Atmel AT91 ADC"
 	depends on ARCH_AT91
-	depends on INPUT
+	depends on INPUT && SYSFS
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-	select SYSFS
 	help
 	  Say yes here to build support for Atmel AT91 ADC.
 
