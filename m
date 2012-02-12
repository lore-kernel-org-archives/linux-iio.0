Return-Path: <rst@work-microwave.de>
From: Roland Stigge <stigge@antcom.de>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, kevin.wells@nxp.com,
        w.sang@pengutronix.de, jic23@cam.ac.uk
Cc: Roland Stigge <stigge@antcom.de>
Subject: [PATCH v2] ARM: LPC32xx: ADC support
Date: Sun, 12 Feb 2012 21:09:05 +0100
Message-Id: <1329077345-15305-1-git-send-email-stigge@antcom.de>
List-ID: <linux-iio@vger.kernel.org>

This patch adds a 3-channel ADC driver for the LPC32xx ARM SoC

Signed-off-by: Roland Stigge <stigge@antcom.de>

Index: linux-arm-soc/arch/arm/mach-lpc32xx/clock.c
===================================================================
--- linux-arm-soc.orig/arch/arm/mach-lpc32xx/clock.c	2012-02-12 20:04:49.000000000 +0100
+++ linux-arm-soc/arch/arm/mach-lpc32xx/clock.c	2012-02-12 20:17:13.000000000 +0100
@@ -721,6 +721,41 @@
 	.get_rate	= local_return_parent_rate,
 };
 
+static int adc_onoff_enable(struct clk *clk, int enable)
+{
+	u32 tmp;
+	u32 divider;
+
+	/* Use PERIPH_CLOCK */
+	tmp = __raw_readl(LPC32XX_CLKPWR_ADC_CLK_CTRL_1);
+	tmp |= LPC32XX_CLKPWR_ADCCTRL1_PCLK_SEL;
+	/*
+	 * Set clock divider so that we have equal to or less than
+	 * 4.5MHz clock at ADC
+	 */
+	divider = clk->get_rate(clk) / 4500000 + 1;
+	tmp |= divider;
+	__raw_writel(tmp, LPC32XX_CLKPWR_ADC_CLK_CTRL_1);
+
+	/* synchronize rate of this clock w/ actual HW setting */
+	clk->rate = clk->get_rate(clk->parent) / divider;
+
+	if (enable == 0)
+		__raw_writel(0, clk->enable_reg);
+	else
+		__raw_writel(clk->enable_mask, clk->enable_reg);
+
+	return 0;
+}
+
+static struct clk clk_adc = {
+	.parent		= &clk_pclk,
+	.enable		= adc_onoff_enable,
+	.enable_reg	= LPC32XX_CLKPWR_ADC_CLK_CTRL,
+	.enable_mask	= LPC32XX_CLKPWR_ADC32CLKCTRL_CLK_EN,
+	.get_rate	= local_return_parent_rate,
+};
+
 static int mmc_onoff_enable(struct clk *clk, int enable)
 {
 	u32 tmp;
@@ -1055,6 +1090,7 @@
 	_REGISTER_CLOCK("dev:ssp1", NULL, clk_ssp1)
 	_REGISTER_CLOCK("lpc32xx_keys.0", NULL, clk_kscan)
 	_REGISTER_CLOCK("lpc32xx-nand.0", "nand_ck", clk_nand)
+	_REGISTER_CLOCK("lpc32xx-adc", NULL, clk_adc)
 	_REGISTER_CLOCK(NULL, "i2s0_ck", clk_i2s0)
 	_REGISTER_CLOCK(NULL, "i2s1_ck", clk_i2s1)
 	_REGISTER_CLOCK("ts-lpc32xx", NULL, clk_tsc)
Index: linux-arm-soc/arch/arm/mach-lpc32xx/common.c
===================================================================
--- linux-arm-soc.orig/arch/arm/mach-lpc32xx/common.c	2012-02-12 20:04:49.000000000 +0100
+++ linux-arm-soc/arch/arm/mach-lpc32xx/common.c	2012-02-12 20:17:13.000000000 +0100
@@ -138,6 +138,28 @@
 };
 
 /*
+ * ADC support
+ */
+static struct resource adc_resources[] = {
+	{
+		.start = LPC32XX_ADC_BASE,
+		.end = LPC32XX_ADC_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	}, {
+		.start = IRQ_LPC32XX_TS_IRQ,
+		.end = IRQ_LPC32XX_TS_IRQ,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device lpc32xx_adc_device = {
+	.name =  "lpc32xx-adc",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(adc_resources),
+	.resource = adc_resources,
+};
+
+/*
  * Returns the unique ID for the device
  */
 void lpc32xx_get_uid(u32 devid[4])
Index: linux-arm-soc/arch/arm/mach-lpc32xx/common.h
===================================================================
--- linux-arm-soc.orig/arch/arm/mach-lpc32xx/common.h	2012-02-12 20:04:49.000000000 +0100
+++ linux-arm-soc/arch/arm/mach-lpc32xx/common.h	2012-02-12 20:17:13.000000000 +0100
@@ -29,6 +29,7 @@
 extern struct platform_device lpc32xx_i2c1_device;
 extern struct platform_device lpc32xx_i2c2_device;
 extern struct platform_device lpc32xx_tsc_device;
+extern struct platform_device lpc32xx_adc_device;
 extern struct platform_device lpc32xx_rtc_device;
 
 /*
Index: linux-arm-soc/arch/arm/mach-lpc32xx/phy3250.c
===================================================================
--- linux-arm-soc.orig/arch/arm/mach-lpc32xx/phy3250.c	2012-02-12 20:04:49.000000000 +0100
+++ linux-arm-soc/arch/arm/mach-lpc32xx/phy3250.c	2012-02-12 20:17:13.000000000 +0100
@@ -252,6 +252,9 @@
 	&lpc32xx_i2c2_device,
 	&lpc32xx_watchdog_device,
 	&lpc32xx_gpio_led_device,
+#if defined(CONFIG_LPC32XX_ADC)
+	&lpc32xx_adc_device,
+#endif
 };
 
 static struct amba_device *amba_devs[] __initdata = {
Index: linux-arm-soc/drivers/staging/iio/adc/Kconfig
===================================================================
--- linux-arm-soc.orig/drivers/staging/iio/adc/Kconfig	2012-02-12 20:04:00.000000000 +0100
+++ linux-arm-soc/drivers/staging/iio/adc/Kconfig	2012-02-12 20:17:13.000000000 +0100
@@ -193,4 +193,13 @@
 	  Say yes here to include ring buffer support in the MAX1363
 	  ADC driver.
 
+config LPC32XX_ADC
+	tristate "NXP LPC32XX ADC"
+	depends on ARCH_LPC32XX && !TOUCHSCREEN_LPC32XX
+	help
+	  Say yes here to build support for the integrated ADC inside the
+	  LPC32XX SoC. Note that this feature uses the same hardware as the
+	  touchscreen driver, so you can only select one of the two drivers
+	  (lpc32xx_adc or lpc32xx_ts). Provides direct access via sysfs.
+
 endmenu
Index: linux-arm-soc/drivers/staging/iio/adc/Makefile
===================================================================
--- linux-arm-soc.orig/drivers/staging/iio/adc/Makefile	2012-02-12 20:04:00.000000000 +0100
+++ linux-arm-soc/drivers/staging/iio/adc/Makefile	2012-02-12 20:17:13.000000000 +0100
@@ -37,3 +37,4 @@
 obj-$(CONFIG_ADT7310) += adt7310.o
 obj-$(CONFIG_ADT7410) += adt7410.o
 obj-$(CONFIG_AD7280) += ad7280a.o
+obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
Index: linux-arm-soc/drivers/staging/iio/adc/lpc32xx_adc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-arm-soc/drivers/staging/iio/adc/lpc32xx_adc.c	2012-02-12 20:17:13.000000000 +0100
@@ -0,0 +1,259 @@
+/*
+ *  lpc32xx_adc.c - Support for ADC in LPC32XX
+ *
+ *  3-channel, 10-bit ADC
+ *
+ *  Copyright (C) 2011, 2012 Roland Stigge <stigge@antcom.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/completion.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+
+/*
+ * LPC32XX registers definitions
+ */
+
+#define LPC32XX_ADC_SELECT(x)	((x) + 0x04)
+#define LPC32XX_ADC_CTRL(x)	((x) + 0x08)
+#define LPC32XX_ADC_VALUE(x)	((x) + 0x48)
+
+/* Bit definitions for LPC32XX_ADC_SELECT: */
+#define AD_REFm         0x00000200 /* constant, always write this value! */
+#define AD_REFp		0x00000080 /* constant, always write this value! */
+#define AD_IN		0x00000010 /* multiple of this is the */
+				   /* channel number: 0, 1, 2 */
+#define AD_INTERNAL	0x00000004 /* constant, always write this value! */
+
+/* Bit definitions for LPC32XX_ADC_CTRL: */
+#define AD_STROBE	0x00000002
+#define AD_PDN_CTRL	0x00000004
+
+/* Bit definitions for LPC32XX_ADC_VALUE: */
+#define ADC_VALUE_MASK	0x000003FF
+
+#define MOD_NAME "lpc32xx-adc"
+
+/*
+ * chip specifc information
+ */
+
+struct lpc32xx_adc_info {
+	void __iomem *adc_base;
+	struct clk *clk;
+	struct completion completion;
+
+	u32 value;
+};
+
+/*
+ * read callback
+ */
+static int lpc32xx_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val,
+				int *val2,
+				long mask)
+{
+	struct lpc32xx_adc_info *info = iio_priv(indio_dev);
+
+	if (mask == 0) {
+		mutex_lock(&indio_dev->mlock);
+		clk_enable(info->clk);
+		/* Measurement setup */
+		__raw_writel(AD_INTERNAL | (chan->address) | AD_REFp | AD_REFm,
+			LPC32XX_ADC_SELECT(info->adc_base));
+		/* Trigger conversion */
+		__raw_writel(AD_PDN_CTRL | AD_STROBE,
+			LPC32XX_ADC_CTRL(info->adc_base));
+		wait_for_completion(&info->completion); /* set by ISR */
+		clk_disable(info->clk);
+		*val = info->value;
+		mutex_unlock(&indio_dev->mlock);
+
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info lpc32xx_adc_iio_info = {
+	.read_raw = &lpc32xx_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+#define LPC32XX_ADC_CHANNEL(_index) {		\
+	.type = IIO_VOLTAGE,			\
+	.indexed = 1,				\
+	.channel = _index,			\
+	.address = AD_IN * _index,		\
+	.scan_type = IIO_ST('u', 10, 10, 0),	\
+	.scan_index = _index,			\
+}
+
+static struct iio_chan_spec lpc32xx_adc_iio_channels[] = {
+	LPC32XX_ADC_CHANNEL(0),
+	LPC32XX_ADC_CHANNEL(1),
+	LPC32XX_ADC_CHANNEL(2),
+};
+
+static irqreturn_t lpc32xx_adc_isr(int irq, void *dev_id)
+{
+	struct lpc32xx_adc_info *info = (struct lpc32xx_adc_info *) dev_id;
+
+	/* Read value and clear irq */
+	info->value = __raw_readl(LPC32XX_ADC_VALUE(info->adc_base)) &
+				ADC_VALUE_MASK;
+	complete(&info->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit lpc32xx_adc_probe(struct platform_device *pdev)
+{
+	struct lpc32xx_adc_info *info = NULL;
+	struct resource *res;
+	int retval = -ENODEV;
+	struct iio_dev *iodev = NULL;
+	int irq;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get platform I/O memory\n");
+		retval = -EBUSY;
+		goto errout1;
+	}
+
+	iodev = iio_allocate_device(sizeof(struct lpc32xx_adc_info));
+	if (!iodev) {
+		dev_err(&pdev->dev, "failed allocating iio device\n");
+		retval = -ENOMEM;
+		goto errout1;
+	}
+
+	info = iio_priv(iodev);
+
+	info->adc_base = ioremap(res->start, res->end - res->start + 1);
+	if (!info->adc_base) {
+		dev_err(&pdev->dev, "failed mapping memory\n");
+		retval = -EBUSY;
+		goto errout2;
+	}
+
+	info->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(info->clk)) {
+		dev_err(&pdev->dev, "failed getting clock\n");
+		goto errout3;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if ((irq < 0) || (irq >= NR_IRQS)) {
+		dev_err(&pdev->dev, "failed getting interrupt resource\n");
+		retval = -EINVAL;
+		goto errout4;
+	}
+
+	retval = request_irq(irq, lpc32xx_adc_isr, 0, MOD_NAME, info);
+	if (retval < 0) {
+		dev_err(&pdev->dev, "failed requesting interrupt\n");
+		goto errout4;
+	}
+
+	platform_set_drvdata(pdev, iodev);
+
+	init_completion(&info->completion);
+
+	iodev->name = MOD_NAME;
+	iodev->dev.parent = &pdev->dev;
+	iodev->info = &lpc32xx_adc_iio_info;
+	iodev->modes = INDIO_DIRECT_MODE;
+	iodev->channels = lpc32xx_adc_iio_channels;
+	iodev->num_channels = ARRAY_SIZE(lpc32xx_adc_iio_channels);
+
+	retval = iio_device_register(iodev);
+	if (retval)
+		goto errout5;
+
+	dev_info(&pdev->dev, "LPC32XX ADC driver loaded, IRQ %d\n", irq);
+
+	return 0;
+
+errout5:
+	free_irq(irq, iodev);
+errout4:
+	clk_put(info->clk);
+errout3:
+	iounmap(info->adc_base);
+errout2:
+	iio_free_device(iodev);
+errout1:
+	return retval;
+}
+
+static int __devexit lpc32xx_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *iodev = platform_get_drvdata(pdev);
+	struct lpc32xx_adc_info *info = iio_priv(iodev);
+	int irq = platform_get_irq(pdev, 0);
+
+	iio_device_unregister(iodev);
+	free_irq(irq, iodev);
+	platform_set_drvdata(pdev, NULL);
+	clk_put(info->clk);
+	iounmap(info->adc_base);
+	iio_free_device(iodev);
+
+	dev_info(&pdev->dev, "LPC32XX ADC driver unloaded\n");
+
+	return 0;
+}
+
+static struct platform_driver lpc32xx_adc_driver = {
+	.probe		= lpc32xx_adc_probe,
+	.remove		= __devexit_p(lpc32xx_adc_remove),
+	.driver		= {
+		.name	= MOD_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init lpc32xx_adc_init(void)
+{
+	return platform_driver_register(&lpc32xx_adc_driver);
+}
+
+static void __exit lpc32xx_adc_exit(void)
+{
+	platform_driver_unregister(&lpc32xx_adc_driver);
+}
+
+module_init(lpc32xx_adc_init);
+module_exit(lpc32xx_adc_exit);
+
+MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
+MODULE_DESCRIPTION("LPC32XX ADC driver");
+MODULE_LICENSE("GPL");
