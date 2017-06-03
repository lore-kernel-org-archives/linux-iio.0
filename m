Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35872 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFCX1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jun 2017 19:27:36 -0400
Received: by mail-lf0-f68.google.com with SMTP id x81so1661500lfb.3
        for <linux-iio@vger.kernel.org>; Sat, 03 Jun 2017 16:27:35 -0700 (PDT)
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Ryan Mallon <rmallon@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v5 3/5] ep93xx: Add ADC platform device support to core
Date: Sun,  4 Jun 2017 01:26:50 +0200
Message-Id: <20170603232652.21401-4-alexander.sverdlin@gmail.com>
In-Reply-To: <20170603232652.21401-1-alexander.sverdlin@gmail.com>
References: <20170603232652.21401-1-alexander.sverdlin@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Newly provided ep93xx_register_adc() could be used by machine-specific code
to create ADC platform device on Cirrus Logic EP93xx SoC-based machines.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Acked-by: Ryan Mallon <rmallon@gmail.com>
---
 arch/arm/mach-ep93xx/core.c                  | 24 ++++++++++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/platform.h |  1 +
 arch/arm/mach-ep93xx/soc.h                   |  1 +
 3 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index c393b1b0310d..f53c61813998 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -821,6 +821,30 @@ void ep93xx_ide_release_gpio(struct platform_device *pdev)
 EXPORT_SYMBOL(ep93xx_ide_release_gpio);
 
 /*************************************************************************
+ * EP93xx ADC
+ *************************************************************************/
+static struct resource ep93xx_adc_resources[] = {
+	DEFINE_RES_MEM(EP93XX_ADC_PHYS_BASE, 0x28),
+	DEFINE_RES_IRQ(IRQ_EP93XX_TOUCH),
+};
+
+static struct platform_device ep93xx_adc_device = {
+	.name		= "ep93xx-adc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ep93xx_adc_resources),
+	.resource	= ep93xx_adc_resources,
+};
+
+void __init ep93xx_register_adc(void)
+{
+	/* Power up ADC, deactivate Touch Screen Controller */
+	ep93xx_devcfg_set_clear(EP93XX_SYSCON_DEVCFG_TIN,
+				EP93XX_SYSCON_DEVCFG_ADCPD);
+
+	platform_device_register(&ep93xx_adc_device);
+}
+
+/*************************************************************************
  * EP93xx Security peripheral
  *************************************************************************/
 
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 4c0bbd97f741..db0839691ef5 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -52,6 +52,7 @@ int ep93xx_i2s_acquire(void);
 void ep93xx_i2s_release(void);
 void ep93xx_register_ac97(void);
 void ep93xx_register_ide(void);
+void ep93xx_register_adc(void);
 int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
 void ep93xx_ide_release_gpio(struct platform_device *pdev);
 
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
index 7bf7ff8beae7..d20e631164cf 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -95,6 +95,7 @@
 #define EP93XX_KEY_MATRIX_PHYS_BASE	EP93XX_APB_PHYS(0x000f0000)
 #define EP93XX_KEY_MATRIX_BASE		EP93XX_APB_IOMEM(0x000f0000)
 
+#define EP93XX_ADC_PHYS_BASE		EP93XX_APB_PHYS(0x00100000)
 #define EP93XX_ADC_BASE			EP93XX_APB_IOMEM(0x00100000)
 #define EP93XX_TOUCHSCREEN_BASE		EP93XX_APB_IOMEM(0x00100000)
 
-- 
2.12.2

