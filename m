Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34113 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeH3TsK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:10 -0400
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 04/30] iio: adc: Kconfig: Update Kconfig to new build options
Date: Thu, 30 Aug 2018 17:44:52 +0200
Message-Id: <20180830154518.29507-5-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since we are merging the mfd driver into the iio adc driver we need to
update the Kconfig build options.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/Kconfig | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9da79070357c..5d0cffd6d2e4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -713,13 +713,16 @@ config STX104
 	  array module parameter.
 
 config SUN4I_GPADC
-	tristate "Support for the Allwinner SoCs GPADC"
+	tristate "Allwinner sunxi platforms' GPADC/Thermal driver"
+	select REGMAP_MMIO
+	select REGMAP_IRQ
 	depends on IIO
-	depends on MFD_SUN4I_GPADC || MACH_SUN8I
-	depends on THERMAL || !THERMAL_OF
+	depends on ARCH_SUNXI || MACH_SUN8I
+	depends on THERMAL && THERMAL_OF
 	help
 	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
-	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
+	  GPADC or newer SOCs (A33, H3, A83T, ...) Thermal sensor driver.
+	  This ADC provides 4 channels which can be used as an ADC or as
 	  a touchscreen input and one channel for thermal sensor.
 
 	  The thermal sensor slows down ADC readings and can be disabled by
-- 
2.11.0
