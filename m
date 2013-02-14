Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:43337 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758656Ab3BNVC0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Feb 2013 16:02:26 -0500
Received: by mail-la0-f53.google.com with SMTP id fr10so2799839lab.12
        for <linux-iio@vger.kernel.org>; Thu, 14 Feb 2013 13:02:24 -0800 (PST)
Message-ID: <511D50E6.4060801@gmail.com>
Date: Fri, 15 Feb 2013 01:02:30 +0400
From: Denis Darwish <darwish.d.d@gmail.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [RFC][PATCH] iio: basic ADC support for Freescale i.MX25
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds basic support for Freescale i.MX25 ADC in the IIO Subsystem.
It is provides direct access via sysfs, IRQ not used now.
Compile tested with linux-next.
Functionality tested with linux 3.3.0.


>From c57696f02b235837a67e2607da517bdcabaa72a5 Mon Sep 17 00:00:00 2001
From: ddarwish <darwish.d.d@gmail.com>
Date: Thu, 14 Feb 2013 11:59:07 +0400
Subject: [PATCH] simple Freescale i.MX25 ADC driver

---
 arch/arm/mach-imx/clk-imx25.c         |    2 +-
 arch/arm/mach-imx/mx25.h              |    1 +
 drivers/staging/iio/adc/Kconfig       |   12 +
 drivers/staging/iio/adc/Makefile      |    1 +
 drivers/staging/iio/adc/imx25_adc.c   |  456 +++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/imx_adc.h     |   13 +
 drivers/staging/iio/adc/imx_adc_reg.h |  243 ++++++++++++++++++
 7 files changed, 727 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/iio/adc/imx25_adc.c
 create mode 100644 drivers/staging/iio/adc/imx_adc.h
 create mode 100644 drivers/staging/iio/adc/imx_adc_reg.h

diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 2c570cd..e30a253 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -271,7 +271,7 @@ int __init mx25_clocks_init(void)
 	clk_register_clkdev(clk[pwm1_ipg], "ipg", "mxc_pwm.3");
 	clk_register_clkdev(clk[per10], "per", "mxc_pwm.3");
 	clk_register_clkdev(clk[kpp_ipg], NULL, "imx-keypad");
-	clk_register_clkdev(clk[tsc_ipg], NULL, "mx25-adc");
+	clk_register_clkdev(clk[tsc_ipg], NULL, "imx25-adc");
 	clk_register_clkdev(clk[i2c_ipg_per], NULL, "imx21-i2c.0");
 	clk_register_clkdev(clk[i2c_ipg_per], NULL, "imx21-i2c.1");
 	clk_register_clkdev(clk[i2c_ipg_per], NULL, "imx21-i2c.2");
diff --git a/arch/arm/mach-imx/mx25.h b/arch/arm/mach-imx/mx25.h
index ec46640..b2e34fd 100644
--- a/arch/arm/mach-imx/mx25.h
+++ b/arch/arm/mach-imx/mx25.h
@@ -37,6 +37,7 @@
 
 #define MX25_CSPI3_BASE_ADDR		0x50004000
 #define MX25_CSPI2_BASE_ADDR		0x50010000
+#define MX25_TSC_BASE_ADDR		0x50030000
 #define MX25_FEC_BASE_ADDR		0x50038000
 #define MX25_SSI2_BASE_ADDR		0x50014000
 #define MX25_SSI1_BASE_ADDR		0x50034000
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 7b2a01d..293f73b 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -130,6 +130,18 @@ config MXS_LRADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called mxs-lradc.
 
+config IMX25_ADC
+	tristate "Freescale IMX25 ADC"
+	depends on ARCH_MXC
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	select SYSFS
+	help
+	  Say yes here to build support for Freescale i.MX25 ADC built into these chips.
+	  Provides direct access via sysfs.
+
+
 config SPEAR_ADC
 	tristate "ST SPEAr ADC"
 	depends on PLAT_SPEAR
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index d285596..b64ec6d 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_AD7280) += ad7280a.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
 obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
+obj-$(CONFIG_IMX25_ADC) += imx25_adc.o
diff --git a/drivers/staging/iio/adc/imx25_adc.c b/drivers/staging/iio/adc/imx25_adc.c
new file mode 100644
index 0000000..6d3b438
--- /dev/null
+++ b/drivers/staging/iio/adc/imx25_adc.c
@@ -0,0 +1,456 @@
+/**
+ * Copyright (c) 2013 Denis darwish
+ * Based on code by Freescale Semiconductor
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/buffer.h>
+
+ #include "imx_adc_reg.h"
+ #include "imx_adc.h"
+
+#define IMX_ADC_DATA_BITS (12)
+
+struct imx_adc_state {
+	struct clk				*adc_clk;
+	unsigned long			channels_mask;
+	u16						value;
+	struct mutex			lock;
+	u8						num_channels;
+	void __iomem			*reg_base;
+	u32						vref_mv;
+};
+
+static int adc_clk_enable(struct imx_adc_state *st)
+{
+	unsigned long reg;
+	int ret;
+	
+	dev_info(NULL, "st point b2 %p \n", st);
+
+	ret = clk_enable(st->adc_clk);
+	reg = __raw_readl(st->reg_base + TGCR);
+	reg |= TGCR_IPG_CLK_EN;
+	__raw_writel(reg, st->reg_base + TGCR);
+	return (ret);
+}
+
+void adc_clk_disable(struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	clk_disable(st->adc_clk);
+	reg = __raw_readl(st->reg_base + TGCR);
+	reg &= ~TGCR_IPG_CLK_EN;
+	__raw_writel(reg, st->reg_base + TGCR);
+}
+
+void tsc_self_reset(struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg = __raw_readl(st->reg_base + TGCR);
+	reg |= TGCR_TSC_RST;
+	__raw_writel(reg, st->reg_base + TGCR);
+
+	while (__raw_readl(st->reg_base + TGCR) & TGCR_TSC_RST)
+		continue;
+}
+
+/* Internal reference */
+void tsc_intref_enable(struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg = __raw_readl(st->reg_base + TGCR);
+	reg |= TGCR_INTREFEN;
+	__raw_writel(reg, st->reg_base + TGCR);
+}
+
+/* Set power mode */
+void adc_set_power_mode(struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg = __raw_readl(st->reg_base + TGCR) & ~TGCR_POWER_MASK;
+	reg |= TGCR_POWER_ON;
+	__raw_writel(reg, st->reg_base + TGCR);
+}
+
+/* Set ADC clock configuration */
+void adc_set_clk(struct imx_adc_state *st) {
+
+	unsigned long reg;
+
+	reg = __raw_readl(st->reg_base + TGCR) & ~TGCR_ADCCLKCFG_MASK;
+	reg |= 31 << TGCR_ADCCLKCFG_SHIFT;	//ADC clock = ipg_clk / (2*div+2)
+	__raw_writel(reg, st->reg_base + TGCR);
+}
+
+void adc_set_queue(struct imx_adc_state *st) {
+
+	unsigned long reg;
+
+	reg = __raw_readl(st->reg_base + GCQ_ITEM_7_0);
+	reg =  (GCQ_ITEM_GCC0 << GCQ_ITEM0_SHIFT) 
+		| (GCQ_ITEM_GCC1 << GCQ_ITEM1_SHIFT)
+		| (GCQ_ITEM_GCC2 << GCQ_ITEM2_SHIFT);
+	__raw_writel(reg, st->reg_base + GCQ_ITEM_7_0);
+	
+	reg = TSC_GENERAL_ADC_GCC0;
+	reg |= (0 << CC_NOS_SHIFT) | (16 << CC_SETTLING_TIME_SHIFT);
+	__raw_writel(reg, st->reg_base + GCC0);
+	reg = TSC_GENERAL_ADC_GCC1;
+	reg |= (0 << CC_NOS_SHIFT) | (16 << CC_SETTLING_TIME_SHIFT);
+	__raw_writel(reg, st->reg_base + GCC1);
+	reg = TSC_GENERAL_ADC_GCC2;
+	reg |= (0 << CC_NOS_SHIFT) | (16 << CC_SETTLING_TIME_SHIFT);
+	__raw_writel(reg, st->reg_base + GCC2);
+
+
+	reg = __raw_readl(st->reg_base + GCQCR) & ~CQCR_LAST_ITEM_ID_MASK;
+	reg |= 0 << CQCR_LAST_ITEM_ID_SHIFT;
+	__raw_writel(reg, st->reg_base + GCQCR);
+
+	reg = __raw_readl(st->reg_base + GCQCR) & ~CQCR_QSM_MASK;
+	reg |= CQCR_QSM_FQS;
+	__raw_writel(reg, st->reg_base + GCQCR);
+
+	reg = __raw_readl(st->reg_base + GCQCR) & ~CQCR_FIFOWATERMARK_MASK;
+	reg |= (0x0 << CQCR_FIFOWATERMARK_SHIFT);
+	__raw_writel(reg, st->reg_base + GCQCR);
+}
+
+void imx_adc_set_chanel(struct imx_adc_state *st, u8 channel) {
+	unsigned long reg;
+
+	reg = __raw_readl(st->reg_base + GCQ_ITEM_7_0);
+	switch (channel) {
+		case 0:
+			reg =  (GCQ_ITEM_GCC0 << GCQ_ITEM0_SHIFT);
+			break;
+		case 1:
+			reg =  (GCQ_ITEM_GCC1 << GCQ_ITEM0_SHIFT);
+			break;
+		case 2:
+			reg =  (GCQ_ITEM_GCC2 << GCQ_ITEM0_SHIFT);
+			break;			
+		default:
+			break;
+	}
+	__raw_writel(reg, st->reg_base + GCQ_ITEM_7_0);
+
+}
+
+void imx_adc_read_general(unsigned short *result, struct imx_adc_state *st)
+{
+	unsigned long reg;
+
+	reg = __raw_readl(st->reg_base + GCQCR);
+	reg |= CQCR_FQS;
+	__raw_writel(reg, st->reg_base + GCQCR);
+
+	while (!(__raw_readl(st->reg_base + GCQSR) & CQSR_EOQ))
+		continue;
+	reg = __raw_readl(st->reg_base + GCQCR);
+	reg &= ~CQCR_FQS;
+	__raw_writel(reg, st->reg_base + GCQCR);
+	reg = __raw_readl(st->reg_base + GCQSR);
+	reg |= CQSR_EOQ;
+	__raw_writel(reg, st->reg_base + GCQSR);
+
+	while (!(__raw_readl(st->reg_base + GCQSR) & CQSR_EMPT)) {
+		*result = __raw_readl(st->reg_base + GCQFIFO) >>
+				 GCQFIFO_ADCOUT_SHIFT;
+		
+	}
+
+}
+
+#define IMX25_ADC_MAX_CH_NUM (3)
+static struct iio_chan_spec imx_adc_iio_channels[IMX25_ADC_MAX_CH_NUM];
+
+static int imx_adc_read_raw(struct iio_dev *idev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct imx_adc_state *st= iio_priv(idev);
+	unsigned short rawresult;
+
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+
+		imx_adc_set_chanel(st, chan->channel);
+		imx_adc_read_general (&rawresult, st);
+		
+		st->value = rawresult;
+		*val = st->value;
+
+		mutex_unlock(&st->lock);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = (st->vref_mv * 1000) >> IMX_ADC_DATA_BITS; 
+		*val2 = 0;
+		return IIO_VAL_INT_PLUS_MICRO;
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
+static int imx_adc_probe_dt(struct imx_adc_state *st,
+			     struct platform_device *pdev)
+{
+	//ToDo implement adc_probe_dt function
+	return 1;
+}
+
+/* platform data file should contain next
+*
+* static struct resource adc_resources[] = {
+*         [0] = {
+*                 .start  = MX25_TSC_BASE_ADDR,
+*                 .end    = MX25_TSC_BASE_ADDR + SZ_16K - 1,
+*                 .flags  = IORESOURCE_MEM,
+*         },
+* };
+*
+* static struct imx_adc_data mpu5_imx_adc_data = {
+* 	.channels_used = 0x01,
+* 	.num_channels = 3,
+* 	.vref = 2500,
+* };
+* 
+* 
+* static struct platform_device imx_adc = {
+* 	.name	= "imx25-adc",
+* 	.id	= -1,
+* 	.resource       = adc_resources,
+* 	.num_resources  = ARRAY_SIZE(adc_resources),
+* 	.dev = {
+* 		.platform_data = &mpu5_imx_adc_data,
+* 	}
+* };
+*/
+
+static int imx_adc_probe_pdata(struct imx_adc_state *st,
+			     struct platform_device *pdev)
+{
+	struct imx_adc_data *pdata = pdev->dev.platform_data;
+
+	if (!pdata)
+		return -EINVAL;
+
+
+	st->vref_mv = pdata->vref;
+	st->channels_mask = pdata->channels_used;
+	st->num_channels = pdata->num_channels;
+	// st->trigger_number = pdata->trigger_number;
+	// st->trigger_list = pdata->trigger_list;
+	// st->registers = pdata->registers;
+
+	return 0;
+}
+
+static int imx_adc_probe(struct platform_device *pdev)
+{
+	struct imx_adc_state *st;
+	struct iio_dev *iodev = NULL;
+	int ret = -ENODEV;
+	struct resource *res;
+	int i;
+
+	dev_info(&pdev->dev, "version 0.0.5 \n");
+
+	iodev = iio_device_alloc(sizeof(struct imx_adc_state));
+	// iodev = iio_allocate_device(sizeof(struct imx_adc_state)); //legasy name
+	if (iodev == NULL) {
+		dev_err(&pdev->dev, "failed allocating iio device\n");
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	st = iio_priv(iodev);
+
+	if (pdev->dev.of_node)
+		ret = imx_adc_probe_dt(st, pdev);
+	else
+		ret = imx_adc_probe_pdata(st, pdev);
+
+	if (ret) {
+		dev_err(&pdev->dev, "No platform data available.\n");
+		ret = -EINVAL;
+		goto error_free_device;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "No resource defined\n");
+		ret = -ENXIO;
+		goto error_ret;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res),
+				"IMX adc registers")) {
+		dev_err(&pdev->dev, "Resources are unavailable.\n");
+		ret = -EBUSY;
+		goto error_free_device;
+	}
+
+	dev_info(&pdev->dev, "res->start %p \n", res->start);
+
+	st->reg_base = ioremap(res->start, resource_size(res));
+	if (!st->reg_base) {
+		dev_err(&pdev->dev, "Failed to map registers.\n");
+		ret = -ENOMEM;
+		goto error_release_mem;
+	}
+
+	dev_info(&pdev->dev, "reg_base %p \n", st->reg_base);
+
+	st->adc_clk = clk_get(&pdev->dev, NULL);
+		if (IS_ERR(st->adc_clk)) {
+		dev_err(&pdev->dev, "Failed to get the clock.\n");
+		ret = PTR_ERR(st->adc_clk);
+		goto error_free_clk;
+	}
+
+	dev_info(&pdev->dev, "st point b1 %p \n", st);
+	
+	ret = adc_clk_enable(st);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not enable the clock.\n");
+		goto error_unprepare_clk;
+	}
+
+	dev_info(&pdev->dev, "adc clk enabled\n");
+
+	/* Reset */
+	tsc_self_reset(st);
+	dev_info(&pdev->dev, "adc reseted\n");
+
+	// /* Internal reference */
+	tsc_intref_enable(st);
+	dev_info(&pdev->dev, "Internal reference enabled\n");
+
+	adc_set_clk(st);
+
+	/* Set power mode */
+	adc_set_power_mode(st);
+
+	/* Set queue*/
+	adc_set_queue(st);
+
+	platform_set_drvdata(pdev, iodev);
+
+	iodev->name = dev_name(&pdev->dev);
+	iodev->dev.parent = &pdev->dev;
+	iodev->info = &imx_adc_info;
+	iodev->modes = INDIO_DIRECT_MODE;
+
+	if (st->num_channels > IMX25_ADC_MAX_CH_NUM) {
+		dev_err(&pdev->dev, "Platform data error. To many adc chanels \n");
+		ret = -EINVAL;
+		goto error_dev_cfg;
+	}
+	iodev->num_channels = st->num_channels;
+
+	for (i = 0; i < st->num_channels; i++) {
+
+		imx_adc_iio_channels[i].type = IIO_VOLTAGE;
+		imx_adc_iio_channels[i].indexed = 1;
+		imx_adc_iio_channels[i].channel = i;
+		imx_adc_iio_channels[i].scan_index = 0;
+		imx_adc_iio_channels[i].scan_type.sign = 'u';
+		imx_adc_iio_channels[i].scan_type.realbits = 12;
+		imx_adc_iio_channels[i].scan_type.storagebits = 16;
+		// imx_adc_iio_channels[0].info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT |
+		// 		IIO_CHAN_INFO_RAW_SEPARATE_BIT;
+		imx_adc_iio_channels[i].info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT;
+	}
+
+	iodev->channels = imx_adc_iio_channels;
+
+	ret = iio_device_register(iodev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Couldn't register the device.\n");
+		goto error_dev;
+	}
+
+	//ToDo Setup interrupt
+
+	mutex_init(&st->lock);
+
+	//ToDo Setup buffers
+	//ToDo Setup triggers
+	//ToDo Setup registers
+
+	return 0;
+
+error_dev:
+
+error_dev_cfg:
+
+error_unprepare_clk:
+	adc_clk_disable(st);
+error_free_clk:
+	clk_put(st->adc_clk);
+error_release_mem:
+	release_mem_region(res->start, resource_size(res));
+error_free_device:
+	iio_device_free(iodev);
+error_ret:
+	return ret;
+}
+
+static int imx_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *iodev = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct imx_adc_state *st = iio_priv(iodev);
+
+	iio_device_unregister(iodev);
+
+	adc_clk_disable(st);
+	clk_put(st->adc_clk);
+	release_mem_region(res->start, resource_size(res));
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
+//		   .of_match_table = of_match_ptr(imx25_adc_dt_ids),
+	},
+};
+
+module_platform_driver(imx_adc_driver);
+
+MODULE_AUTHOR("Denis Darwish <darwish.d.d@gmail.com>");
+MODULE_DESCRIPTION("Freescale i.MX25 ADC Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/adc/imx_adc.h b/drivers/staging/iio/adc/imx_adc.h
new file mode 100644
index 0000000..9ce3370
--- /dev/null
+++ b/drivers/staging/iio/adc/imx_adc.h
@@ -0,0 +1,13 @@
+
+/**
+ * struct imx_adc_data - platform data for ADC driver
+ * @channels_used:              channels in use on the board as a bitmask
+ * @num_channels:               global number of channels available on the board
+ * @vref:                       Reference voltage for the ADC in millivolts
+ */
+ 
+struct imx_adc_data {
+		unsigned long	channels_used;
+		u8				num_channels;
+		u16				vref;
+};
\ No newline at end of file
diff --git a/drivers/staging/iio/adc/imx_adc_reg.h b/drivers/staging/iio/adc/imx_adc_reg.h
new file mode 100644
index 0000000..9d9fc89
--- /dev/null
+++ b/drivers/staging/iio/adc/imx_adc_reg.h
@@ -0,0 +1,243 @@
+/*
+ * Copyright 2009-2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * The code contained herein is licensed under the GNU Lesser General
+ * Public License.  You may obtain a copy of the GNU Lesser General
+ * Public License Version 2.1 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/lgpl-license.html
+ * http://www.gnu.org/copyleft/lgpl.html
+ */
+
+#ifndef __IMX_ADC_H__
+#define __IMX_ADC_H__
+
+/* TSC General Config Register */
+#define TGCR                  0x000
+#define TGCR_IPG_CLK_EN       (1 << 0)
+#define TGCR_TSC_RST          (1 << 1)
+#define TGCR_FUNC_RST         (1 << 2)
+#define TGCR_SLPC             (1 << 4)
+#define TGCR_STLC             (1 << 5)
+#define TGCR_HSYNC_EN         (1 << 6)
+#define TGCR_HSYNC_POL        (1 << 7)
+#define TGCR_POWERMODE_SHIFT  8
+#define TGCR_POWER_OFF        (0x0 << TGCR_POWERMODE_SHIFT)
+#define TGCR_POWER_SAVE       (0x1 << TGCR_POWERMODE_SHIFT)
+#define TGCR_POWER_ON         (0x3 << TGCR_POWERMODE_SHIFT)
+#define TGCR_POWER_MASK       (0x3 << TGCR_POWERMODE_SHIFT)
+#define TGCR_INTREFEN         (1 << 10)
+#define TGCR_ADCCLKCFG_SHIFT  16
+#define TGCR_ADCCLKCFG_MASK	  (0x1F << TGCR_ADCCLKCFG_SHIFT)
+#define TGCR_PD_EN            (1 << 23)
+#define TGCR_PDB_EN           (1 << 24)
+#define TGCR_PDBTIME_SHIFT    25
+#define TGCR_PDBTIME128       (0x3f << TGCR_PDBTIME_SHIFT)
+#define TGCR_PDBTIME_MASK     (0x7f << TGCR_PDBTIME_SHIFT)
+
+/* TSC General Status Register */
+#define TGSR                  0x004
+#define TCQ_INT               (1 << 0)
+#define GCQ_INT               (1 << 1)
+#define SLP_INT               (1 << 2)
+#define TCQ_DMA               (1 << 16)
+#define GCQ_DMA               (1 << 17)
+
+/* TSC IDLE Config Register */
+#define TICR                  0x008
+
+/* TouchScreen Convert Queue FIFO Register */
+#define TCQFIFO               0x400
+/* TouchScreen Convert Queue Control Register */
+#define TCQCR                 0x404
+#define CQCR_QSM_SHIFT        0
+#define CQCR_QSM_STOP         (0x0 << CQCR_QSM_SHIFT)
+#define CQCR_QSM_PEN          (0x1 << CQCR_QSM_SHIFT)
+#define CQCR_QSM_FQS          (0x2 << CQCR_QSM_SHIFT)
+#define CQCR_QSM_FQS_PEN      (0x3 << CQCR_QSM_SHIFT)
+#define CQCR_QSM_MASK         (0x3 << CQCR_QSM_SHIFT)
+#define CQCR_FQS              (1 << 2)
+#define CQCR_RPT              (1 << 3)
+#define CQCR_LAST_ITEM_ID_SHIFT   4
+#define CQCR_LAST_ITEM_ID_MASK    (0xf << CQCR_LAST_ITEM_ID_SHIFT)
+#define CQCR_FIFOWATERMARK_SHIFT  8
+#define CQCR_FIFOWATERMARK_MASK   (0xf << CQCR_FIFOWATERMARK_SHIFT)
+#define CQCR_REPEATWAIT_SHIFT     12
+#define CQCR_REPEATWAIT_MASK      (0xf << CQCR_REPEATWAIT_SHIFT)
+#define CQCR_QRST             (1 << 16)
+#define CQCR_FRST             (1 << 17)
+#define CQCR_PD_MSK           (1 << 18)
+#define CQCR_PD_CFG           (1 << 19)
+
+/* TouchScreen Convert Queue Status Register */
+#define TCQSR                 0x408
+#define CQSR_PD               (1 << 0)
+#define CQSR_EOQ              (1 << 1)
+#define CQSR_FOR              (1 << 4)
+#define CQSR_FUR              (1 << 5)
+#define CQSR_FER              (1 << 6)
+#define CQSR_EMPT             (1 << 13)
+#define CQSR_FULL             (1 << 14)
+#define CQSR_FDRY             (1 << 15)
+
+/* TouchScreen Convert Queue Mask Register */
+#define TCQMR                 0x40c
+#define TCQMR_PD_IRQ_MSK      (1 << 0)
+#define TCQMR_EOQ_IRQ_MSK     (1 << 1)
+#define TCQMR_FOR_IRQ_MSK     (1 << 4)
+#define TCQMR_FUR_IRQ_MSK     (1 << 5)
+#define TCQMR_FER_IRQ_MSK     (1 << 6)
+#define TCQMR_PD_DMA_MSK      (1 << 16)
+#define TCQMR_EOQ_DMA_MSK     (1 << 17)
+#define TCQMR_FOR_DMA_MSK     (1 << 20)
+#define TCQMR_FUR_DMA_MSK     (1 << 21)
+#define TCQMR_FER_DMA_MSK     (1 << 22)
+#define TCQMR_FDRY_DMA_MSK    (1 << 31)
+
+/* TouchScreen Convert Queue ITEM 7~0 */
+#define TCQ_ITEM_7_0          0x420
+
+/* TouchScreen Convert Queue ITEM 15~8 */
+#define TCQ_ITEM_15_8         0x424
+
+#define TCQ_ITEM7_SHIFT       28
+#define TCQ_ITEM6_SHIFT       24
+#define TCQ_ITEM5_SHIFT       20
+#define TCQ_ITEM4_SHIFT       16
+#define TCQ_ITEM3_SHIFT       12
+#define TCQ_ITEM2_SHIFT       8
+#define TCQ_ITEM1_SHIFT       4
+#define TCQ_ITEM0_SHIFT       0
+
+#define TCQ_ITEM_TCC0         0x0
+#define TCQ_ITEM_TCC1         0x1
+#define TCQ_ITEM_TCC2         0x2
+#define TCQ_ITEM_TCC3         0x3
+#define TCQ_ITEM_TCC4         0x4
+#define TCQ_ITEM_TCC5         0x5
+#define TCQ_ITEM_TCC6         0x6
+#define TCQ_ITEM_TCC7         0x7
+#define TCQ_ITEM_GCC7         0x8
+#define TCQ_ITEM_GCC6         0x9
+#define TCQ_ITEM_GCC5         0xa
+#define TCQ_ITEM_GCC4         0xb
+#define TCQ_ITEM_GCC3         0xc
+#define TCQ_ITEM_GCC2         0xd
+#define TCQ_ITEM_GCC1         0xe
+#define TCQ_ITEM_GCC0         0xf
+
+/* TouchScreen Convert Config 0-7 */
+#define TCC0                  0x440
+#define TCC1                  0x444
+#define TCC2                  0x448
+#define TCC3                  0x44c
+#define TCC4                  0x450
+#define TCC5                  0x454
+#define TCC6                  0x458
+#define TCC7                  0x45c
+#define CC_PEN_IACK           (1 << 1)
+#define CC_SEL_REFN_SHIFT     2
+#define CC_SEL_REFN_YNLR      (0x1 << CC_SEL_REFN_SHIFT)
+#define CC_SEL_REFN_AGND      (0x2 << CC_SEL_REFN_SHIFT)
+#define CC_SEL_REFN_MASK      (0x3 << CC_SEL_REFN_SHIFT)
+#define CC_SELIN_SHIFT        4
+#define CC_SELIN_XPUL         (0x0 << CC_SELIN_SHIFT)
+#define CC_SELIN_YPLL         (0x1 << CC_SELIN_SHIFT)
+#define CC_SELIN_XNUR         (0x2 << CC_SELIN_SHIFT)
+#define CC_SELIN_YNLR         (0x3 << CC_SELIN_SHIFT)
+#define CC_SELIN_WIPER        (0x4 << CC_SELIN_SHIFT)
+#define CC_SELIN_INAUX0       (0x5 << CC_SELIN_SHIFT)
+#define CC_SELIN_INAUX1       (0x6 << CC_SELIN_SHIFT)
+#define CC_SELIN_INAUX2       (0x7 << CC_SELIN_SHIFT)
+#define CC_SELIN_MASK         (0x7 << CC_SELIN_SHIFT)
+#define CC_SELREFP_SHIFT      7
+#define CC_SELREFP_YPLL       (0x0 << CC_SELREFP_SHIFT)
+#define CC_SELREFP_XPUL       (0x1 << CC_SELREFP_SHIFT)
+#define CC_SELREFP_EXT        (0x2 << CC_SELREFP_SHIFT)
+#define CC_SELREFP_INT        (0x3 << CC_SELREFP_SHIFT)
+#define CC_SELREFP_MASK       (0x3 << CC_SELREFP_SHIFT)
+#define CC_XPULSW             (1 << 9)
+#define CC_XNURSW_SHIFT       10
+#define CC_XNURSW_HIGH        (0x0 << CC_XNURSW_SHIFT)
+#define CC_XNURSW_OFF         (0x1 << CC_XNURSW_SHIFT)
+#define CC_XNURSW_LOW         (0x3 << CC_XNURSW_SHIFT)
+#define CC_XNURSW_MASK        (0x3 << CC_XNURSW_SHIFT)
+#define CC_YPLLSW_SHIFT       12
+#define CC_YPLLSW_MASK        (0x3 << CC_YPLLSW_SHIFT)
+#define CC_YNLRSW             (1 << 14)
+#define CC_WIPERSW            (1 << 15)
+#define CC_NOS_SHIFT          16
+#define CC_YPLLSW_HIGH        (0x0 << CC_NOS_SHIFT)
+#define CC_YPLLSW_OFF         (0x1 << CC_NOS_SHIFT)
+#define CC_YPLLSW_LOW         (0x3 << CC_NOS_SHIFT)
+#define CC_NOS_MASK           (0xf << CC_NOS_SHIFT)
+#define CC_IGS                (1 << 20)
+#define CC_SETTLING_TIME_SHIFT 24
+#define CC_SETTLING_TIME_MASK (0xff << CC_SETTLING_TIME_SHIFT)
+
+#define TSC_4WIRE_PRECHARGE    0x158c
+#define TSC_4WIRE_TOUCH_DETECT 0x578e
+
+#define TSC_4WIRE_X_MEASUMENT  0x1c90
+#define TSC_4WIRE_Y_MEASUMENT  0x4604
+
+#define TSC_GENERAL_ADC_GCC0   0x17dc
+#define TSC_GENERAL_ADC_GCC1   0x17ec
+#define TSC_GENERAL_ADC_GCC2   0x17fc
+
+/* GeneralADC Convert Queue FIFO Register */
+#define GCQFIFO                0x800
+#define GCQFIFO_ADCOUT_SHIFT   4
+#define GCQFIFO_ADCOUT_MASK    (0xfff << GCQFIFO_ADCOUT_SHIFT)
+/* GeneralADC Convert Queue Control Register */
+#define GCQCR                  0x804
+/* GeneralADC Convert Queue Status Register */
+#define GCQSR                  0x808
+/* GeneralADC Convert Queue Mask Register */
+#define GCQMR                  0x80c
+
+/* GeneralADC Convert Queue ITEM 7~0 */
+#define GCQ_ITEM_7_0           0x820
+/* GeneralADC Convert Queue ITEM 15~8 */
+#define GCQ_ITEM_15_8          0x824
+
+#define GCQ_ITEM7_SHIFT        28
+#define GCQ_ITEM6_SHIFT        24
+#define GCQ_ITEM5_SHIFT        20
+#define GCQ_ITEM4_SHIFT        16
+#define GCQ_ITEM3_SHIFT        12
+#define GCQ_ITEM2_SHIFT        8
+#define GCQ_ITEM1_SHIFT        4
+#define GCQ_ITEM0_SHIFT        0
+
+#define GCQ_ITEM_GCC0          0x0
+#define GCQ_ITEM_GCC1          0x1
+#define GCQ_ITEM_GCC2          0x2
+#define GCQ_ITEM_GCC3          0x3
+
+/* GeneralADC Convert Config 0-7 */
+#define GCC0                   0x840
+#define GCC1                   0x844
+#define GCC2                   0x848
+#define GCC3                   0x84c
+#define GCC4                   0x850
+#define GCC5                   0x854
+#define GCC6                   0x858
+#define GCC7                   0x85c
+
+/* TSC Test Register R/W */
+#define TTR                    0xc00
+/* TSC Monitor Register 1, 2 */
+#define MNT1                   0xc04
+#define MNT2                   0xc04
+
+#define DETECT_ITEM_ID_1       1
+#define DETECT_ITEM_ID_2       5
+#define TS_X_ITEM_ID           2
+#define TS_Y_ITEM_ID           3
+#define TSI_DATA               1
+#define FQS_DATA               0
+
+#endif				/* __IMX_ADC_H__ */
-- 
1.7.10.4



