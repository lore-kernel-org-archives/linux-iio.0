Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55429 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbeH3TsJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:09 -0400
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
Subject: [PATCH v3 02/30] mfd: Kconfig: Remove MFD_SUN4I_GPADC config option
Date: Thu, 30 Aug 2018 17:44:50 +0200
Message-Id: <20180830154518.29507-3-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We are merging the mfd:sun4i-gpadc driver into the
iio/adc/sun4i-gpadc driver. So we need to remove the MFD_SUN4I_GPADC
config option.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/mfd/Kconfig | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..c7ab57d65610 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -40,23 +40,6 @@ config MFD_ACT8945A
 	  linear regulators, along with a complete ActivePath battery
 	  charger.
 
-config MFD_SUN4I_GPADC
-	tristate "Allwinner sunxi platforms' GPADC MFD driver"
-	select MFD_CORE
-	select REGMAP_MMIO
-	select REGMAP_IRQ
-	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on !TOUCHSCREEN_SUN4I
-	help
-	  Select this to get support for Allwinner SoCs (A10, A13 and A31) ADC.
-	  This driver will only map the hardware interrupt and registers, you
-	  have to select individual drivers based on this MFD to be able to use
-	  the ADC or the thermal sensor. This will try to probe the ADC driver
-	  sun4i-gpadc-iio and the hwmon driver iio_hwmon.
-
-	  To compile this driver as a module, choose M here: the module will be
-	  called sun4i-gpadc.
-
 config MFD_AS3711
 	bool "AMS AS3711"
 	select MFD_CORE
-- 
2.11.0
