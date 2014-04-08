Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33347 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756369AbaDHNY4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 8 Apr 2014 09:24:56 -0400
Date: Tue, 8 Apr 2014 15:24:51 +0200
From: Jean Delvare <jdelvare@suse.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2] iio: adc: Fix exynos_adc dependencies
Message-ID: <20140408152451.6dc2b230@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

EXYNOS_ADC shouldn't only depend on OF. It is useless on architectures
other than Exynos so it should depend on ARCH_EXYNOS (which implies
OF.)

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
 * Alternatively depend on COMPILE_TEST as requested by Lars-Peter
   Clausen. Thanks for the review!

 drivers/iio/adc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc0.orig/drivers/iio/adc/Kconfig	2014-04-08 14:54:37.418421834 +0200
+++ linux-3.15-rc0/drivers/iio/adc/Kconfig	2014-04-08 15:20:42.735670677 +0200
@@ -107,7 +107,7 @@ config AT91_ADC
 
 config EXYNOS_ADC
 	bool "Exynos ADC driver support"
-	depends on OF
+	depends on ARCH_EXYNOS || (OF && COMPILE_TEST)
 	help
 	  Core support for the ADC block found in the Samsung EXYNOS series
 	  of SoCs for drivers such as the touchscreen and hwmon to use to share


-- 
Jean Delvare
SUSE L3 Support
