Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:46005 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933269AbcAYWaY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2016 17:30:24 -0500
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net,
	Richard Weinberger <richard@nod.at>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Pradeep Goudagunta <pgoudagunta@nvidia.com>,
	Haibo Chen <haibo.chen@freescale.com>,
	Phani Movva <Phani.Movva@imgtec.com>,
	Andrea Galbusera <gizero@gmail.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	=?UTF-8?q?Oliver=20St=C3=A4bler?= <oliver.staebler@bytesatwork.ch>,
	=?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bytesatwork.ch>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@rosetechnology.dk>,
	linux-iio@vger.kernel.org
Subject: [PATCH 06/22] iio: adc: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:05 +0100
Message-Id: <1453760661-1444-7-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/iio/adc/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 605ff42..283ded7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -175,6 +175,7 @@ config DA9150_GPADC
 config EXYNOS_ADC
 	tristate "Exynos ADC driver support"
 	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || (OF && COMPILE_TEST)
+	depends on HAS_IOMEM
 	help
 	  Core support for the ADC block found in the Samsung EXYNOS series
 	  of SoCs for drivers such as the touchscreen and hwmon to use to share
@@ -207,6 +208,7 @@ config INA2XX_ADC
 config IMX7D_ADC
 	tristate "IMX7D ADC driver"
 	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Say yes here to build support for IMX7D ADC.
 
@@ -409,6 +411,7 @@ config TWL6030_GPADC
 config VF610_ADC
 	tristate "Freescale vf610 ADC driver"
 	depends on OF
+	depends on HAS_IOMEM
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-- 
1.8.4.5

