Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:57679 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967094Ab3DRKso (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Apr 2013 06:48:44 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so1179981eek.18
        for <linux-iio@vger.kernel.org>; Thu, 18 Apr 2013 03:48:43 -0700 (PDT)
Message-ID: <516FCEBC.7080000@gmail.com>
Date: Thu, 18 Apr 2013 14:45:16 +0400
From: Denis Darwish <darwish.d.d@gmail.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: basic ADC support for Freescale i.MX25
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Denis Darwish <darwish.d.d@gmail.com>

This patch adds basic support for Freescale i.MX25 ADC in the IIO Subsystem.

Signed-off-by: Denis Darwish <darwish.d.d@gmail.com>
---
 I want to thank Lars-Peter Clausen for a detailed review.

 Functionality tested with linux 3.8.0 and linux-next.
 IIO_BUFFER and IIO_TRIGGER unsupported
 Changes since v1:
 + end of conversion IRQ support
 * cleanup debug info messages, vars etc.
 * all definitions put into c file
 * iio_chan_spec statically initialized
 * get resources in modern way (clk, iomem etc)

 arch/arm/mach-imx/clk-imx25.c                  |    2 +-
 arch/arm/mach-imx/devices/Kconfig              |    4 +
 arch/arm/mach-imx/devices/Makefile             |    1 +
 arch/arm/mach-imx/devices/devices-common.h     |    2 +
 arch/arm/mach-imx/devices/platform-imx25-adc.c |   27 +
 arch/arm/mach-imx/mx25.h                       |    2 +
 drivers/iio/adc/Kconfig                        |    7 +
 drivers/iio/adc/Makefile                       |    1 +
 drivers/iio/adc/imx25_adc.c                    |  639 ++++++++++++++++++++++++
 9 files changed, 684 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-imx/devices/platform-imx25-adc.c
 create mode 100644 drivers/iio/adc/imx25_adc.c

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 69858c7..febc054 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -274,7 +274,7 @@ int __init mx25_clocks_init(void)
 	clk_register_clkdev(clk[pwm1_ipg], "ipg", "mxc_pwm.3");
 	clk_register_clkdev(clk[per10], "per", "mxc_pwm.3");
 	clk_register_clkdev(clk[kpp_ipg], NULL, "imx-keypad");
-	clk_register_clkdev(clk[tsc_ipg], NULL, "mx25-adc");
+	clk_register_clkdev(clk[tsc_ipg], NULL, "imx25-adc");
 	clk_register_clkdev(clk[i2c_ipg_per], NULL, "imx21-i2c.0");
 	clk_register_clkdev(clk[i2c_ipg_per], NULL, "imx21-i2c.1");
 	clk_register_clkdev(clk[i2c_ipg_per], NULL, "imx21-i2c.2");
diff --git a/arch/arm/mach-imx/devices/Kconfig b/arch/arm/mach-imx/devices/Kconfig
index 3dd2b1b..5096d56 100644
--- a/arch/arm/mach-imx/devices/Kconfig
+++ b/arch/arm/mach-imx/devices/Kconfig
@@ -16,6 +16,10 @@ config IMX_HAVE_PLATFORM_GPIO_KEYS
 config IMX_HAVE_PLATFORM_IMX21_HCD
 	bool
 
+config IMX_HAVE_PLATFORM_IMX25_ADC
+	bool
+	default y if SOC_IMX25
+
 config IMX_HAVE_PLATFORM_IMX27_CODA
 	bool
 	default y if SOC_IMX27
diff --git a/arch/arm/mach-imx/devices/Makefile b/arch/arm/mach-imx/devices/Makefile
index 67416fb..4450d19 100644
--- a/arch/arm/mach-imx/devices/Makefile
+++ b/arch/arm/mach-imx/devices/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_FSL_USB2_UDC) += platform-fsl-usb2-udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_GPIO_KEYS) += platform-gpio_keys.o
 obj-y += platform-gpio-mxc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX21_HCD) += platform-imx21-hcd.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX25_ADC) += platform-imx25-adc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX27_CODA) += platform-imx27-coda.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX2_WDT) += platform-imx2-wdt.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_IMXDI_RTC) += platform-imxdi_rtc.o
diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 453e20b..0781dcf 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -344,3 +344,5 @@ struct platform_device *imx_add_imx_dma(char *name, resource_size_t iobase,
 					int irq, int irq_err);
 struct platform_device *imx_add_imx_sdma(char *name,
 	resource_size_t iobase, int irq, struct sdma_platform_data *pdata);
+
+struct platform_device *__init imx25_add_adc(void);
diff --git a/arch/arm/mach-imx/devices/platform-imx25-adc.c b/arch/arm/mach-imx/devices/platform-imx25-adc.c
new file mode 100644
index 0000000..628c890
--- /dev/null
+++ b/arch/arm/mach-imx/devices/platform-imx25-adc.c
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2013 Denis Darwish <darwish.d.d@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include "../hardware.h"
+#include "devices-common.h"
+
+struct platform_device *__init imx25_add_adc(void)
+{
+	struct resource res[] = {
+		[0] = {
+			.start  = MX25_TSC_BASE_ADDR,
+			.end    = MX25_TSC_BASE_ADDR + SZ_16K - 1,
+			.flags  = IORESOURCE_MEM,
+		},
+		[1] = {
+			.start  = MX25_INT_TSC,
+			.end    = MX25_INT_TSC,
+			.flags  = IORESOURCE_IRQ,
+		},
+	};
+	return imx_add_platform_device("imx25-adc", -1,
+				       res, ARRAY_SIZE(res), NULL, 0);
+}
diff --git a/arch/arm/mach-imx/mx25.h b/arch/arm/mach-imx/mx25.h
index ec46640..e3a3f33 100644
--- a/arch/arm/mach-imx/mx25.h
+++ b/arch/arm/mach-imx/mx25.h
@@ -37,6 +37,7 @@
 
 #define MX25_CSPI3_BASE_ADDR		0x50004000
 #define MX25_CSPI2_BASE_ADDR		0x50010000
+#define MX25_TSC_BASE_ADDR		0x50030000
 #define MX25_FEC_BASE_ADDR		0x50038000
 #define MX25_SSI2_BASE_ADDR		0x50014000
 #define MX25_SSI1_BASE_ADDR		0x50034000
@@ -96,6 +97,7 @@
 #define MX25_INT_CAN1		(NR_IRQS_LEGACY + 43)
 #define MX25_INT_CAN2		(NR_IRQS_LEGACY + 44)
 #define MX25_INT_UART1		(NR_IRQS_LEGACY + 45)
+#define MX25_INT_TSC		(NR_IRQS_LEGACY + 46)
 #define MX25_INT_GPIO2		(NR_IRQS_LEGACY + 51)
 #define MX25_INT_GPIO1		(NR_IRQS_LEGACY + 52)
 #define MX25_INT_GPT1		(NR_IRQS_LEGACY + 54)
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ab0767e6..d56c7e6 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -150,6 +150,13 @@ config TI_AM335X_ADC
 	  Say yes here to build support for Texas Instruments ADC
 	  driver which is also a MFD client.
 
+config IMX25_ADC
+	tristate "Freescale IMX25 ADC"
+	depends on ARCH_MXC
+	select SYSFS
+	help
+	  Say yes here to build support for Freescale i.MX25 ADC built into these chips.
+
 config VIPERBOARD_ADC
 	tristate "Viperboard ADC support"
 	depends on MFD_VIPERBOARD && USB
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 0a825be..b2b9d63 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
 obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
+obj-$(CONFIG_IMX25_ADC) += imx25_adc.o
diff --git a/drivers/iio/adc/imx25_adc.c b/drivers/iio/adc/imx25_adc.c
new file mode 100644
index 0000000..a0e3570
--- /dev/null
+++ b/drivers/iio/adc/imx25_adc.c
@@ -0,0 +1,639 @@
+/**
+ * Copyright (c) 2013 Denis Darwish
+ * Copyright 2009-2011 Freescale Semiconductor, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/buffer.h>
+
+#define IMX_ADC_DATA_BITS (12)
+
+ /* TSC General Config Register */
+#define IMX_ADC_TGCR                  0x000
+#define IMX_ADC_TGCR_IPG_CLK_EN       (1 << 0)
+#define IMX_ADC_TGCR_TSC_RST          (1 << 1)
+#define IMX_ADC_TGCR_FUNC_RST         (1 << 2)
+#define IMX_ADC_TGCR_SLPC             (1 << 4)
+#define IMX_ADC_TGCR_STLC             (1 << 5)
+#define IMX_ADC_TGCR_HSYNC_EN         (1 << 6)
+#define IMX_ADC_TGCR_HSYNC_POL        (1 << 7)
+#define IMX_ADC_TGCR_POWERMODE_SHIFT  8
+#define IMX_ADC_TGCR_POWER_OFF        (0x0 << IMX_ADC_TGCR_POWERMODE_SHIFT)
+#define IMX_ADC_TGCR_POWER_SAVE       (0x1 << IMX_ADC_TGCR_POWERMODE_SHIFT)
+#define IMX_ADC_TGCR_POWER_ON         (0x3 << IMX_ADC_TGCR_POWERMODE_SHIFT)
+#define IMX_ADC_TGCR_POWER_MASK       (0x3 << IMX_ADC_TGCR_POWERMODE_SHIFT)
+#define IMX_ADC_TGCR_INTREFEN         (1 << 10)
+#define IMX_ADC_TGCR_ADCCLKCFG_SHIFT  16
+#define IMX_ADC_TGCR_ADCCLKCFG_MASK	  (0x1F << IMX_ADC_TGCR_ADCCLKCFG_SHIFT)
+#define IMX_ADC_TGCR_PD_EN            (1 << 23)
+#define IMX_ADC_TGCR_PDB_EN           (1 << 24)
+#define IMX_ADC_TGCR_PDBTIME_SHIFT    25
+#define IMX_ADC_TGCR_PDBTIME128       (0x3f << IMX_ADC_TGCR_PDBTIME_SHIFT)
+#define IMX_ADC_TGCR_PDBTIME_MASK     (0x7f << IMX_ADC_TGCR_PDBTIME_SHIFT)
+
+/* TSC General Status Register */
+#define IMX_ADC_TGSR                  0x004
+#define IMX_ADC_TCQ_INT               (1 << 0)
+#define IMX_ADC_GCQ_INT               (1 << 1)
+#define IMX_ADC_SLP_INT               (1 << 2)
+#define IMX_ADC_TCQ_DMA               (1 << 16)
+#define IMX_ADC_GCQ_DMA               (1 << 17)
+
+/* TSC IDLE Config Register */
+#define IMX_ADC_TICR                  0x008
+
+/* TouchScreen Convert Queue FIFO Register */
+/* #define TCQFIFO               0x400 */
+/* TouchScreen Convert Queue Control Register */
+#define IMX_ADC_TCQCR					0x404
+#define IMX_ADC_CQCR_QSM_SHIFT			0
+#define IMX_ADC_CQCR_QSM_STOP			(0x0 << IMX_ADC_CQCR_QSM_SHIFT)
+#define IMX_ADC_CQCR_QSM_PEN			(0x1 << IMX_ADC_CQCR_QSM_SHIFT)
+#define IMX_ADC_CQCR_QSM_FQS			(0x2 << IMX_ADC_CQCR_QSM_SHIFT)
+#define IMX_ADC_CQCR_QSM_FQS_PEN		(0x3 << IMX_ADC_CQCR_QSM_SHIFT)
+#define IMX_ADC_CQCR_QSM_MASK			(0x3 << IMX_ADC_CQCR_QSM_SHIFT)
+#define IMX_ADC_CQCR_FQS				(1 << 2)
+#define IMX_ADC_CQCR_RPT				(1 << 3)
+#define IMX_ADC_CQCR_LAST_ITEM_ID_SHIFT		4
+#define IMX_ADC_CQCR_LAST_ITEM_ID_MASK		\
+				(0xf << IMX_ADC_CQCR_LAST_ITEM_ID_SHIFT)
+#define IMX_ADC_CQCR_FIFOWATERMARK_SHIFT	8
+#define IMX_ADC_CQCR_FIFOWATERMARK_MASK		\
+				(0xf << IMX_ADC_CQCR_FIFOWATERMARK_SHIFT)
+#define IMX_ADC_CQCR_REPEATWAIT_SHIFT		12
+#define IMX_ADC_CQCR_REPEATWAIT_MASK		\
+				(0xf << IMX_ADC_CQCR_REPEATWAIT_SHIFT)
+#define IMX_ADC_CQCR_QRST			(1 << 16)
+#define IMX_ADC_CQCR_FRST			(1 << 17)
+#define IMX_ADC_CQCR_PD_MSK			(1 << 18)
+#define IMX_ADC_CQCR_PD_CFG			(1 << 19)
+
+/* TouchScreen Convert Queue Status Register */
+#define IMX_ADC_TCQSR                 0x408
+#define IMX_ADC_CQSR_PD               (1 << 0)
+#define IMX_ADC_CQSR_EOQ              (1 << 1)
+#define IMX_ADC_CQSR_FOR              (1 << 4)
+#define IMX_ADC_CQSR_FUR              (1 << 5)
+#define IMX_ADC_CQSR_FER              (1 << 6)
+#define IMX_ADC_CQSR_EMPT             (1 << 13)
+#define IMX_ADC_CQSR_FULL             (1 << 14)
+#define IMX_ADC_CQSR_FDRY             (1 << 15)
+
+/* TouchScreen Convert Config 0-7 */
+#define IMX_ADC_TCC0                  0x440
+#define IMX_ADC_TCC1                  0x444
+#define IMX_ADC_TCC2                  0x448
+#define IMX_ADC_TCC3                  0x44c
+#define IMX_ADC_TCC4                  0x450
+#define IMX_ADC_TCC5                  0x454
+#define IMX_ADC_TCC6                  0x458
+#define IMX_ADC_TCC7                  0x45c
+#define IMX_ADC_CC_PEN_IACK           (1 << 1)
+#define IMX_ADC_CC_SEL_REFN_SHIFT     2
+#define IMX_ADC_CC_SEL_REFN_YNLR      (0x1 << IMX_ADC_CC_SEL_REFN_SHIFT)
+#define IMX_ADC_CC_SEL_REFN_AGND      (0x2 << IMX_ADC_CC_SEL_REFN_SHIFT)
+#define IMX_ADC_CC_SEL_REFN_MASK      (0x3 << IMX_ADC_CC_SEL_REFN_SHIFT)
+#define IMX_ADC_CC_SELIN_SHIFT        4
+#define IMX_ADC_CC_SELIN_XPUL         (0x0 << IMX_ADC_CC_SELIN_SHIFT)
+#define IMX_ADC_CC_SELIN_YPLL         (0x1 << IMX_ADC_CC_SELIN_SHIFT)
+#define IMX_ADC_CC_SELIN_XNUR         (0x2 << IMX_ADC_CC_SELIN_SHIFT)
+#define IMX_ADC_CC_SELIN_YNLR         (0x3 << IMX_ADC_CC_SELIN_SHIFT)
+#define IMX_ADC_CC_SELIN_WIPER        (0x4 << IMX_ADC_CC_SELIN_SHIFT)
+#define IMX_ADC_CC_SELIN_INAUX0       (0x5 << IMX_ADC_CC_SELIN_SHIFT)
+#define IMX_ADC_CC_SELIN_INAUX1       (0x6 << IMX_ADC_CC_SELIN_SHIFT)
+#define IMX_ADC_CC_SELIN_INAUX2       (0x7 << IMX_ADC_CC_SELIN_SHIFT)
+#define IMX_ADC_CC_SELIN_MASK         (0x7 << IMX_ADC_CC_SELIN_SHIFT)
+#define IMX_ADC_CC_SELREFP_SHIFT      7
+#define IMX_ADC_CC_SELREFP_YPLL       (0x0 << IMX_ADC_CC_SELREFP_SHIFT)
+#define IMX_ADC_CC_SELREFP_XPUL       (0x1 << IMX_ADC_CC_SELREFP_SHIFT)
+#define IMX_ADC_CC_SELREFP_EXT        (0x2 << IMX_ADC_CC_SELREFP_SHIFT)
+#define IMX_ADC_CC_SELREFP_INT        (0x3 << IMX_ADC_CC_SELREFP_SHIFT)
+#define IMX_ADC_CC_SELREFP_MASK       (0x3 << IMX_ADC_CC_SELREFP_SHIFT)
+#define IMX_ADC_CC_XPULSW             (1 << 9)
+#define IMX_ADC_CC_XNURSW_SHIFT       10
+#define IMX_ADC_CC_XNURSW_HIGH        (0x0 << IMX_ADC_CC_XNURSW_SHIFT)
+#define IMX_ADC_CC_XNURSW_OFF         (0x1 << IMX_ADC_CC_XNURSW_SHIFT)
+#define IMX_ADC_CC_XNURSW_LOW         (0x3 << IMX_ADC_CC_XNURSW_SHIFT)
+#define IMX_ADC_CC_XNURSW_MASK        (0x3 << IMX_ADC_CC_XNURSW_SHIFT)
+#define IMX_ADC_CC_YPLLSW_SHIFT       12
+#define IMX_ADC_CC_YPLLSW_MASK        (0x3 << IMX_ADC_CC_YPLLSW_SHIFT)
+#define IMX_ADC_CC_YNLRSW             (1 << 14)
+#define IMX_ADC_CC_WIPERSW            (1 << 15)
+#define IMX_ADC_CC_NOS_SHIFT          16
+#define IMX_ADC_CC_YPLLSW_HIGH        (0x0 << IMX_ADC_CC_NOS_SHIFT)
+#define IMX_ADC_CC_YPLLSW_OFF         (0x1 << IMX_ADC_CC_NOS_SHIFT)
+#define IMX_ADC_CC_YPLLSW_LOW         (0x3 << IMX_ADC_CC_NOS_SHIFT)
+#define IMX_ADC_CC_NOS_MASK           (0xf << IMX_ADC_CC_NOS_SHIFT)
+#define IMX_ADC_CC_IGS                (1 << 20)
+#define IMX_ADC_CC_SETTLING_TIME_SHIFT 24
+#define IMX_ADC_CC_SETTLING_TIME_MASK (0xff << IMX_ADC_CC_SETTLING_TIME_SHIFT)
+
+#define IMX_ADC_TSC_GENERAL_ADC_GCC0   0x17dc
+#define IMX_ADC_TSC_GENERAL_ADC_GCC1   0x17ec
+#define IMX_ADC_TSC_GENERAL_ADC_GCC2   0x17fc
+
+/* GeneralADC Convert Queue FIFO Register */
+#define IMX_ADC_GCQFIFO                0x800
+#define IMX_ADC_GCQFIFO_ADCOUT_SHIFT   4
+#define IMX_ADC_GCQFIFO_ADCOUT_MASK    (0xfff << IMX_ADC_GCQFIFO_ADCOUT_SHIFT)
+/* GeneralADC Convert Queue Control Register */
+#define IMX_ADC_GCQCR                  0x804
+/* GeneralADC Convert Queue Status Register */
+#define IMX_ADC_GCQSR                  0x808
+/* GeneralADC Convert Queue Mask Register */
+#define IMX_ADC_GCQMR                  0x80c
+#define IMX_ADC_GCQMR_PD_IRQ_MSK      (1 << 0)
+#define IMX_ADC_GCQMR_EOQ_IRQ_MSK     (1 << 1)
+#define IMX_ADC_GCQMR_FOR_IRQ_MSK     (1 << 4)
+#define IMX_ADC_GCQMR_FUR_IRQ_MSK     (1 << 5)
+#define IMX_ADC_GCQMR_FER_IRQ_MSK     (1 << 6)
+#define IMX_ADC_GCQMR_PD_DMA_MSK      (1 << 16)
+#define IMX_ADC_GCQMR_EOQ_DMA_MSK     (1 << 17)
+#define IMX_ADC_GCQMR_FOR_DMA_MSK     (1 << 20)
+#define IMX_ADC_GCQMR_FUR_DMA_MSK     (1 << 21)
+#define IMX_ADC_GCQMR_FER_DMA_MSK     (1 << 22)
+#define IMX_ADC_GCQMR_FDRY_DMA_MSK    (1 << 31)
+
+/* GeneralADC Convert Queue ITEM 7~0 */
+#define IMX_ADC_GCQ_ITEM_7_0           0x820
+/* GeneralADC Convert Queue ITEM 15~8 */
+#define IMX_ADC_GCQ_ITEM_15_8          0x824
+
+#define IMX_ADC_GCQ_ITEM7_SHIFT        28
+#define IMX_ADC_GCQ_ITEM6_SHIFT        24
+#define IMX_ADC_GCQ_ITEM5_SHIFT        20
+#define IMX_ADC_GCQ_ITEM4_SHIFT        16
+#define IMX_ADC_GCQ_ITEM3_SHIFT        12
+#define IMX_ADC_GCQ_ITEM2_SHIFT        8
+#define IMX_ADC_GCQ_ITEM1_SHIFT        4
+#define IMX_ADC_GCQ_ITEM0_SHIFT        0
+
+#define IMX_ADC_GCQ_ITEM_GCC0          0x0
+#define IMX_ADC_GCQ_ITEM_GCC1          0x1
+#define IMX_ADC_GCQ_ITEM_GCC2          0x2
+#define IMX_ADC_GCQ_ITEM_GCC3          0x3
+
+/* GeneralADC Convert Config 0-7 */
+#define IMX_ADC_GCC0                   0x840
+#define IMX_ADC_GCC1                   0x844
+#define IMX_ADC_GCC2                   0x848
+#define IMX_ADC_GCC3                   0x84c
+#define IMX_ADC_GCC4                   0x850
+#define IMX_ADC_GCC5                   0x854
+#define IMX_ADC_GCC6                   0x858
+#define IMX_ADC_GCC7                   0x85c
+
+struct imx_adc_state {
+	struct regulator		*reg;
+	struct clk				*adc_clk;
+	u16						value;
+	struct mutex			lock;
+	struct completion		completion;
+	int						irq;
+	void __iomem			*reg_base;
+	u32						vref_mv;
+};
+
+static int adc_clk_enable(struct imx_adc_state *st)
+{
+	unsigned long reg;
+	int ret;
+
+	ret = clk_prepare_enable(st->adc_clk);
+	reg = readl_relaxed(st->reg_base + IMX_ADC_TGCR);
+	reg |= IMX_ADC_TGCR_IPG_CLK_EN;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_TGCR);
+	return ret;
+}
+
+void adc_clk_disable(struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_TGCR);
+	reg &= ~IMX_ADC_TGCR_IPG_CLK_EN;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_TGCR);
+	clk_disable_unprepare(st->adc_clk);
+}
+
+void tsc_self_reset(struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_TGCR);
+	reg |= IMX_ADC_TGCR_TSC_RST;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_TGCR);
+
+	while (readl_relaxed(st->reg_base + IMX_ADC_TGCR) &
+		IMX_ADC_TGCR_TSC_RST)
+		continue;
+}
+
+/* Internal reference */
+void tsc_intref_enable(struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_TGCR);
+	reg |= IMX_ADC_TGCR_INTREFEN;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_TGCR);
+}
+
+/* Set power mode */
+void adc_set_power_mode(struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_TGCR) &
+		~IMX_ADC_TGCR_POWER_MASK;
+	reg |= IMX_ADC_TGCR_POWER_ON;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_TGCR);
+}
+
+/* Set ADC clock configuration */
+void adc_set_clk(struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_TGCR) &
+		~IMX_ADC_TGCR_ADCCLKCFG_MASK;
+	/* ADC clock = ipg_clk / (2*div+2) */
+	reg |= 31 << IMX_ADC_TGCR_ADCCLKCFG_SHIFT;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_TGCR);
+}
+
+void adc_set_queue(struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg =  (IMX_ADC_GCQ_ITEM_GCC0 << IMX_ADC_GCQ_ITEM0_SHIFT)
+		| (IMX_ADC_GCQ_ITEM_GCC1 << IMX_ADC_GCQ_ITEM1_SHIFT)
+		| (IMX_ADC_GCQ_ITEM_GCC2 << IMX_ADC_GCQ_ITEM2_SHIFT);
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQ_ITEM_7_0);
+
+	reg = IMX_ADC_TSC_GENERAL_ADC_GCC0;
+	reg |= (0 << IMX_ADC_CC_NOS_SHIFT) |
+		(16 << IMX_ADC_CC_SETTLING_TIME_SHIFT);
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCC0);
+	reg = IMX_ADC_TSC_GENERAL_ADC_GCC1;
+	reg |= (0 << IMX_ADC_CC_NOS_SHIFT) |
+		(16 << IMX_ADC_CC_SETTLING_TIME_SHIFT);
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCC1);
+	reg = IMX_ADC_TSC_GENERAL_ADC_GCC2;
+	reg |= (0 << IMX_ADC_CC_NOS_SHIFT) |
+		(16 << IMX_ADC_CC_SETTLING_TIME_SHIFT);
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCC2);
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR) &
+		~IMX_ADC_CQCR_LAST_ITEM_ID_MASK;
+	reg |= 0 << IMX_ADC_CQCR_LAST_ITEM_ID_SHIFT;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR) &
+		~IMX_ADC_CQCR_QSM_MASK;
+	reg |= IMX_ADC_CQCR_QSM_FQS;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR) &
+		~IMX_ADC_CQCR_FIFOWATERMARK_MASK;
+	reg |= (0x0 << IMX_ADC_CQCR_FIFOWATERMARK_SHIFT);
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
+}
+
+void imx_adc_set_chanel(struct imx_adc_state *st, u8 channel)
+{
+	unsigned long reg;
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQ_ITEM_7_0);
+	switch (channel) {
+	case 0:
+		reg = IMX_ADC_GCQ_ITEM_GCC0 <<
+			IMX_ADC_GCQ_ITEM0_SHIFT;
+		break;
+	case 1:
+		reg = IMX_ADC_GCQ_ITEM_GCC1 <<
+			IMX_ADC_GCQ_ITEM0_SHIFT;
+		break;
+	case 2:
+		reg = IMX_ADC_GCQ_ITEM_GCC2 <<
+			IMX_ADC_GCQ_ITEM0_SHIFT;
+		break;
+	default:
+		break;
+	}
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQ_ITEM_7_0);
+
+}
+
+void imx_adc_read_general(unsigned short *result, struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR);
+	reg |= IMX_ADC_CQCR_FQS;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
+
+	while (!(readl_relaxed(st->reg_base + IMX_ADC_GCQSR) &
+		IMX_ADC_CQSR_EOQ))
+		continue;
+	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR);
+	reg &= ~IMX_ADC_CQCR_FQS;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
+	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQSR);
+	reg |= IMX_ADC_CQSR_EOQ;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQSR);
+
+	while (!(readl_relaxed(st->reg_base + IMX_ADC_GCQSR) &
+		IMX_ADC_CQSR_EMPT)) {
+		*result = readl_relaxed(st->reg_base + IMX_ADC_GCQFIFO) >>
+				 IMX_ADC_GCQFIFO_ADCOUT_SHIFT;
+	}
+
+}
+
+static irqreturn_t imx_adc_handle_irq(int irq, void *private)
+{
+	struct iio_dev *iodev = private;
+	struct imx_adc_state *st = iio_priv(iodev);
+	unsigned long reg;
+
+	reg = readl_relaxed(st->reg_base + IMX_ADC_TGSR);
+	if (!(reg & IMX_ADC_GCQ_INT))
+		return IRQ_HANDLED;
+
+	/* GCQ interrupt negated */
+	reg |= IMX_ADC_GCQ_INT;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_TGSR);
+
+	/* mask end-of-queue IRQ */
+	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQMR);
+	reg |= IMX_ADC_GCQMR_EOQ_IRQ_MSK;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQMR);
+
+	/* FQS does not start the conversion queue */
+	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR);
+	reg &= ~IMX_ADC_CQCR_FQS;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
+
+	/* Convert queue is completed */
+	reg = readl_relaxed(st->reg_base + IMX_ADC_GCQSR);
+	reg |= IMX_ADC_CQSR_EOQ;
+	writel_relaxed(reg, st->reg_base + IMX_ADC_GCQSR);
+
+	complete(&st->completion);
+
+	return IRQ_HANDLED;
+}
+
+#define IMX_ADC_CHAN(idx, chan_type) {				\
+	.type = (chan_type),					\
+	.indexed = 1,						\
+	.scan_index = (idx),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+	.channel = (idx),					\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = 12,					\
+		.storagebits = 16,				\
+	},							\
+}
+
+static const struct iio_chan_spec imx_adc_iio_channels[] = {
+	IMX_ADC_CHAN(0, IIO_VOLTAGE),
+	IMX_ADC_CHAN(1, IIO_VOLTAGE),
+	IMX_ADC_CHAN(2, IIO_VOLTAGE),
+};
+
+static int imx_adc_read_raw(struct iio_dev *idev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct imx_adc_state *st = iio_priv(idev);
+	int ret;
+	unsigned long reg;
+
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = mutex_trylock(&st->lock);
+			if (!ret)
+				return -EBUSY;
+
+		INIT_COMPLETION(st->completion);
+
+		imx_adc_set_chanel(st, chan->channel);
+
+		/* Enable the IRQ, unmask end-of-queue IRQ */
+		reg = readl_relaxed(st->reg_base + IMX_ADC_GCQMR);
+		reg &= ~IMX_ADC_GCQMR_EOQ_IRQ_MSK;
+		writel_relaxed(reg, st->reg_base + IMX_ADC_GCQMR);
+
+		/* Start sampling the channel. */
+		reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR);
+		reg |= IMX_ADC_CQCR_FQS;
+		writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
+
+		ret = wait_for_completion_killable_timeout(&st->completion, HZ);
+		if (!ret)
+			ret = -ETIMEDOUT;
+		if (ret > 0) {
+			while (!(readl_relaxed(st->reg_base + IMX_ADC_GCQSR) &
+				IMX_ADC_CQSR_EMPT)) {
+				st->value = readl_relaxed(st->reg_base +
+					IMX_ADC_GCQFIFO) >>
+					IMX_ADC_GCQFIFO_ADCOUT_SHIFT;
+				}
+			*val = st->value;
+			ret = IIO_VAL_INT;
+		}
+		/* GCQ interrupt negated */
+		reg |= IMX_ADC_GCQ_INT;
+		writel_relaxed(reg, st->reg_base + IMX_ADC_TGSR);
+
+		/* mask end-of-queue IRQ */
+		reg = readl_relaxed(st->reg_base + IMX_ADC_GCQMR);
+		reg |= IMX_ADC_GCQMR_EOQ_IRQ_MSK;
+		writel_relaxed(reg, st->reg_base + IMX_ADC_GCQMR);
+
+		/* FQS does not start the conversion queue */
+		reg = readl_relaxed(st->reg_base + IMX_ADC_GCQCR);
+		reg &= ~IMX_ADC_CQCR_FQS;
+		writel_relaxed(reg, st->reg_base + IMX_ADC_GCQCR);
+
+		/* Convert queue is completed */
+		reg = readl_relaxed(st->reg_base + IMX_ADC_GCQSR);
+		reg |= IMX_ADC_CQSR_EOQ;
+		writel_relaxed(reg, st->reg_base + IMX_ADC_GCQSR);
+
+		mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mv;
+		*val2 = IMX_ADC_DATA_BITS;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info imx_adc_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &imx_adc_read_raw,
+};
+
+static int imx_adc_probe(struct platform_device *pdev)
+{
+	struct imx_adc_state *st;
+	struct iio_dev *iodev;
+	int ret = -ENODEV;
+	struct resource *res;
+
+	iodev = iio_device_alloc(sizeof(struct imx_adc_state));
+	if (iodev == NULL) {
+		dev_err(&pdev->dev, "failed allocating iio device\n");
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	st = iio_priv(iodev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	st->reg_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (IS_ERR(st->reg_base)) {
+		ret = PTR_ERR(st->reg_base);
+		goto error_free_device;
+	}
+
+	/* Reset */
+	tsc_self_reset(st);
+
+	st->reg = regulator_get(&pdev->dev, "ext-vref");
+	if (!IS_ERR_OR_NULL(st->reg)) {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			goto error_put_reg;
+		st->vref_mv = regulator_get_voltage(st->reg);
+	} else {
+		/* Use internal reference */
+		st->vref_mv = 2500; /* internal reference = 2.5V */
+		tsc_intref_enable(st);
+	}
+
+	st->irq = platform_get_irq(pdev, 0);
+		if (st->irq < 0) {
+			dev_err(&pdev->dev, "No IRQ ID is designated\n");
+			ret = -EINVAL;
+			goto error_disable_reg;
+		}
+
+	ret = devm_request_irq(&pdev->dev, st->irq,
+		imx_adc_handle_irq, 0,
+		pdev->dev.driver->name, iodev);
+	if (ret)
+		goto error_disable_reg;
+
+	st->adc_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(st->adc_clk)) {
+		dev_err(&pdev->dev, "Failed to get the clock.\n");
+		ret = PTR_ERR(st->adc_clk);
+		goto error_free_clk;
+	}
+
+	ret = adc_clk_enable(st);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Could not prepare or enable the clock.\n");
+		goto error_free_clk;
+	}
+
+	adc_set_clk(st);
+
+	/* Set power mode */
+	adc_set_power_mode(st);
+
+	/* Set queue */
+	adc_set_queue(st);
+
+	platform_set_drvdata(pdev, iodev);
+
+	iodev->name = dev_name(&pdev->dev);
+	iodev->dev.parent = &pdev->dev;
+	iodev->info = &imx_adc_info;
+	iodev->modes = INDIO_DIRECT_MODE;
+
+
+	iodev->channels = imx_adc_iio_channels;
+	iodev->num_channels = ARRAY_SIZE(imx_adc_iio_channels);
+
+	init_completion(&st->completion);
+	mutex_init(&st->lock);
+
+	ret = iio_device_register(iodev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Couldn't register the device.\n");
+		goto error_dev;
+	}
+
+	return 0;
+
+error_dev:
+
+error_free_clk:
+	adc_clk_disable(st);
+error_disable_reg:
+	if (!IS_ERR_OR_NULL(st->reg))
+		regulator_disable(st->reg);
+error_put_reg:
+	if (!IS_ERR_OR_NULL(st->reg))
+		regulator_put(st->reg);
+error_free_device:
+	iio_device_free(iodev);
+error_ret:
+	return ret;
+}
+
+static int imx_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *iodev = platform_get_drvdata(pdev);
+	struct imx_adc_state *st = iio_priv(iodev);
+
+	iio_device_unregister(iodev);
+
+	adc_clk_disable(st);
+	clk_put(st->adc_clk);
+
+	iio_device_free(iodev);
+
+	return 0;
+}
+
+
+static struct platform_driver imx_adc_driver = {
+	.probe = imx_adc_probe,
+	.remove = imx_adc_remove,
+	.driver = {
+		   .name = "imx25-adc",
+	},
+};
+
+module_platform_driver(imx_adc_driver);
+
+MODULE_AUTHOR("Denis Darwish <darwish.d.d@gmail.com>");
+MODULE_DESCRIPTION("Freescale i.MX25 ADC Driver");
+MODULE_LICENSE("GPL");
-- 1.7.3.4

