Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38141 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbbKYLup (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2015 06:50:45 -0500
Received: by wmec201 with SMTP id c201so66630226wme.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2015 03:50:44 -0800 (PST)
Subject: [PATCH 3/5] ep93xx: Add ADC platform device support to core
To: Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <56558B23.4080506@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <5655A092.4030804@gmail.com>
Date: Wed, 25 Nov 2015 12:50:42 +0100
MIME-Version: 1.0
In-Reply-To: <56558B23.4080506@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Newly provided ep93xx_register_adc() could be used by machine-specific code
to create ADC platform device on Cirrus Logic EP93xx SoC-based machines.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/arm/mach-ep93xx/core.c                  | 24 ++++++++++++++++++++++++
 arch/arm/mach-ep93xx/include/mach/platform.h |  1 +
 arch/arm/mach-ep93xx/soc.h                   |  1 +
 3 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index c393b1b..f53c618 100644
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
index 4c0bbd9..db08396 100644
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
index 7bf7ff8..d20e631 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -95,6 +95,7 @@
 #define EP93XX_KEY_MATRIX_PHYS_BASE	EP93XX_APB_PHYS(0x000f0000)
 #define EP93XX_KEY_MATRIX_BASE		EP93XX_APB_IOMEM(0x000f0000)

+#define EP93XX_ADC_PHYS_BASE		EP93XX_APB_PHYS(0x00100000)
 #define EP93XX_ADC_BASE			EP93XX_APB_IOMEM(0x00100000)
 #define EP93XX_TOUCHSCREEN_BASE		EP93XX_APB_IOMEM(0x00100000)

