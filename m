Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:45996 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbcCYWqT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2016 18:46:19 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 6/8] iio: adc: Fix at91-sama5d2_adc dependencies
Date: Fri, 25 Mar 2016 23:40:53 +0100
Message-Id: <1458945655-5027-6-git-send-email-richard@nod.at>
In-Reply-To: <1458945655-5027-1-git-send-email-richard@nod.at>
References: <1458945655-5027-1-git-send-email-richard@nod.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not all archs have io memory.

Fixes the following build error:
ERROR: "devm_ioremap_resource" [drivers/iio/adc/at91-sama5d2_adc.ko] undefined!

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: b9cd7a25 ("MAINTAINERS: add entry for Atmel SAMA5D2 ADC driver")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index af4aea7..31fa2e7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -133,6 +133,7 @@ config AT91_ADC
 
 config AT91_SAMA5D2_ADC
 	tristate "Atmel AT91 SAMA5D2 ADC"
+	depends on HAS_IOMEM
 	depends on ARCH_AT91 || COMPILE_TEST
 	help
 	  Say yes here to build support for Atmel SAMA5D2 ADC which is
-- 
1.8.4.5

