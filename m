Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36314 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbdBENHG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2017 08:07:06 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Roland Stigge <stigge@antcom.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/3] staging:iio:adc:lpc32xx Move out of staging.
Date: Sun,  5 Feb 2017 13:07:00 +0000
Message-Id: <20170205130700.5063-4-jic23@kernel.org>
In-Reply-To: <20170205130700.5063-1-jic23@kernel.org>
References: <20170205130700.5063-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are a few more little cleanups that could be done on this driver, but
I don't think any are sufficient to justify not moving it out of staging.

It's a very simple driver (presumably for a simple part) so not much that can
go wrong.  I think it was only ever in staging because that's where IIO was
as a whole at the time and then we forgot about it!

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Cc: Roland Stigge <stigge@antcom.de>
---
 drivers/iio/adc/Kconfig               |  12 ++
 drivers/iio/adc/Makefile              |   1 +
 drivers/iio/adc/lpc32xx_adc.c         | 219 ++++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig       |  12 --
 drivers/staging/iio/adc/Makefile      |   1 -
 drivers/staging/iio/adc/lpc32xx_adc.c | 219 ----------------------------------
 6 files changed, 232 insertions(+), 232 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 789a5fb7c0be..d777a972586d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -305,6 +305,18 @@ config LPC18XX_ADC
 	  To compile this driver as a module, choose M here: the module will be
 	  called lpc18xx_adc.
 
+config LPC32XX_ADC
+	tristate "NXP LPC32XX ADC"
+	depends on ARCH_LPC32XX || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say yes here to build support for the integrated ADC inside the
+	  LPC32XX SoC. Note that this feature uses the same hardware as the
+	  touchscreen driver, so you should either select only one of the two
+	  drivers (lpc32xx_adc or lpc32xx_ts) or, in the OpenFirmware case,
+	  activate only one via device tree selection.  Provides direct access
+	  via sysfs.
+
 config LTC2485
 	tristate "Linear Technology LTC2485 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 19e48af43b97..b11bb5767543 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
 obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
+obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX11100) += max11100.o
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
new file mode 100644
index 000000000000..0de709b4288b
--- /dev/null
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -0,0 +1,219 @@
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
+#include <linux/of.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/*
+ * LPC32XX registers definitions
+ */
+#define LPC32XXAD_SELECT(x)	((x) + 0x04)
+#define LPC32XXAD_CTRL(x)	((x) + 0x08)
+#define LPC32XXAD_VALUE(x)	((x) + 0x48)
+
+/* Bit definitions for LPC32XXAD_SELECT: */
+/* constant, always write this value! */
+#define LPC32XXAD_REFm         0x00000200
+/* constant, always write this value! */
+#define LPC32XXAD_REFp		0x00000080
+ /* multiple of this is the channel number: 0, 1, 2 */
+#define LPC32XXAD_IN		0x00000010
+/* constant, always write this value! */
+#define LPC32XXAD_INTERNAL	0x00000004
+
+/* Bit definitions for LPC32XXAD_CTRL: */
+#define LPC32XXAD_STROBE	0x00000002
+#define LPC32XXAD_PDN_CTRL	0x00000004
+
+/* Bit definitions for LPC32XXAD_VALUE: */
+#define LPC32XXAD_VALUE_MASK	0x000003FF
+
+#define LPC32XXAD_NAME "lpc32xx-adc"
+
+struct lpc32xx_adc_state {
+	void __iomem *adc_base;
+	struct clk *clk;
+	struct completion completion;
+
+	u32 value;
+};
+
+static int lpc32xx_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val,
+			    int *val2,
+			    long mask)
+{
+	struct lpc32xx_adc_state *st = iio_priv(indio_dev);
+
+	if (mask == IIO_CHAN_INFO_RAW) {
+		mutex_lock(&indio_dev->mlock);
+		clk_prepare_enable(st->clk);
+		/* Measurement setup */
+		__raw_writel(LPC32XXAD_INTERNAL | (chan->address) |
+			     LPC32XXAD_REFp | LPC32XXAD_REFm,
+			     LPC32XXAD_SELECT(st->adc_base));
+		/* Trigger conversion */
+		__raw_writel(LPC32XXAD_PDN_CTRL | LPC32XXAD_STROBE,
+			     LPC32XXAD_CTRL(st->adc_base));
+		wait_for_completion(&st->completion); /* set by ISR */
+		clk_disable_unprepare(st->clk);
+		*val = st->value;
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
+#define LPC32XX_ADC_CHANNEL(_index) {			\
+	.type = IIO_VOLTAGE,				\
+	.indexed = 1,					\
+	.channel = _index,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.address = LPC32XXAD_IN * _index,		\
+	.scan_index = _index,				\
+}
+
+static const struct iio_chan_spec lpc32xx_adc_iio_channels[] = {
+	LPC32XX_ADC_CHANNEL(0),
+	LPC32XX_ADC_CHANNEL(1),
+	LPC32XX_ADC_CHANNEL(2),
+};
+
+static irqreturn_t lpc32xx_adc_isr(int irq, void *dev_id)
+{
+	struct lpc32xx_adc_state *st = dev_id;
+
+	/* Read value and clear irq */
+	st->value = __raw_readl(LPC32XXAD_VALUE(st->adc_base)) &
+		LPC32XXAD_VALUE_MASK;
+	complete(&st->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int lpc32xx_adc_probe(struct platform_device *pdev)
+{
+	struct lpc32xx_adc_state *st = NULL;
+	struct resource *res;
+	int retval = -ENODEV;
+	struct iio_dev *iodev = NULL;
+	int irq;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get platform I/O memory\n");
+		return -ENXIO;
+	}
+
+	iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
+	if (!iodev)
+		return -ENOMEM;
+
+	st = iio_priv(iodev);
+
+	st->adc_base = devm_ioremap(&pdev->dev, res->start,
+				    resource_size(res));
+	if (!st->adc_base) {
+		dev_err(&pdev->dev, "failed mapping memory\n");
+		return -EBUSY;
+	}
+
+	st->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(st->clk)) {
+		dev_err(&pdev->dev, "failed getting clock\n");
+		return PTR_ERR(st->clk);
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_err(&pdev->dev, "failed getting interrupt resource\n");
+		return -ENXIO;
+	}
+
+	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
+				  LPC32XXAD_NAME, st);
+	if (retval < 0) {
+		dev_err(&pdev->dev, "failed requesting interrupt\n");
+		return retval;
+	}
+
+	platform_set_drvdata(pdev, iodev);
+
+	init_completion(&st->completion);
+
+	iodev->name = LPC32XXAD_NAME;
+	iodev->dev.parent = &pdev->dev;
+	iodev->info = &lpc32xx_adc_iio_info;
+	iodev->modes = INDIO_DIRECT_MODE;
+	iodev->channels = lpc32xx_adc_iio_channels;
+	iodev->num_channels = ARRAY_SIZE(lpc32xx_adc_iio_channels);
+
+	retval = devm_iio_device_register(&pdev->dev, iodev);
+	if (retval)
+		return retval;
+
+	dev_info(&pdev->dev, "LPC32XX ADC driver loaded, IRQ %d\n", irq);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id lpc32xx_adc_match[] = {
+	{ .compatible = "nxp,lpc3220-adc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, lpc32xx_adc_match);
+#endif
+
+static struct platform_driver lpc32xx_adc_driver = {
+	.probe		= lpc32xx_adc_probe,
+	.driver		= {
+		.name	= LPC32XXAD_NAME,
+		.of_match_table = of_match_ptr(lpc32xx_adc_match),
+	},
+};
+
+module_platform_driver(lpc32xx_adc_driver);
+
+MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
+MODULE_DESCRIPTION("LPC32XX ADC driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 0ad5c44042b2..e17efb03bac0 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -80,16 +80,4 @@ config AD7280
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7280a
 
-config LPC32XX_ADC
-	tristate "NXP LPC32XX ADC"
-	depends on ARCH_LPC32XX || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Say yes here to build support for the integrated ADC inside the
-	  LPC32XX SoC. Note that this feature uses the same hardware as the
-	  touchscreen driver, so you should either select only one of the two
-	  drivers (lpc32xx_adc or lpc32xx_ts) or, in the OpenFirmware case,
-	  activate only one via device tree selection.  Provides direct access
-	  via sysfs.
-
 endmenu
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index e7098dedeb75..bf18bdd7c99d 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -10,4 +10,3 @@ obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_AD7280) += ad7280a.o
-obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
deleted file mode 100644
index 0de709b4288b..000000000000
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ /dev/null
@@ -1,219 +0,0 @@
-/*
- *  lpc32xx_adc.c - Support for ADC in LPC32XX
- *
- *  3-channel, 10-bit ADC
- *
- *  Copyright (C) 2011, 2012 Roland Stigge <stigge@antcom.de>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/completion.h>
-#include <linux/of.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-
-/*
- * LPC32XX registers definitions
- */
-#define LPC32XXAD_SELECT(x)	((x) + 0x04)
-#define LPC32XXAD_CTRL(x)	((x) + 0x08)
-#define LPC32XXAD_VALUE(x)	((x) + 0x48)
-
-/* Bit definitions for LPC32XXAD_SELECT: */
-/* constant, always write this value! */
-#define LPC32XXAD_REFm         0x00000200
-/* constant, always write this value! */
-#define LPC32XXAD_REFp		0x00000080
- /* multiple of this is the channel number: 0, 1, 2 */
-#define LPC32XXAD_IN		0x00000010
-/* constant, always write this value! */
-#define LPC32XXAD_INTERNAL	0x00000004
-
-/* Bit definitions for LPC32XXAD_CTRL: */
-#define LPC32XXAD_STROBE	0x00000002
-#define LPC32XXAD_PDN_CTRL	0x00000004
-
-/* Bit definitions for LPC32XXAD_VALUE: */
-#define LPC32XXAD_VALUE_MASK	0x000003FF
-
-#define LPC32XXAD_NAME "lpc32xx-adc"
-
-struct lpc32xx_adc_state {
-	void __iomem *adc_base;
-	struct clk *clk;
-	struct completion completion;
-
-	u32 value;
-};
-
-static int lpc32xx_read_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int *val,
-			    int *val2,
-			    long mask)
-{
-	struct lpc32xx_adc_state *st = iio_priv(indio_dev);
-
-	if (mask == IIO_CHAN_INFO_RAW) {
-		mutex_lock(&indio_dev->mlock);
-		clk_prepare_enable(st->clk);
-		/* Measurement setup */
-		__raw_writel(LPC32XXAD_INTERNAL | (chan->address) |
-			     LPC32XXAD_REFp | LPC32XXAD_REFm,
-			     LPC32XXAD_SELECT(st->adc_base));
-		/* Trigger conversion */
-		__raw_writel(LPC32XXAD_PDN_CTRL | LPC32XXAD_STROBE,
-			     LPC32XXAD_CTRL(st->adc_base));
-		wait_for_completion(&st->completion); /* set by ISR */
-		clk_disable_unprepare(st->clk);
-		*val = st->value;
-		mutex_unlock(&indio_dev->mlock);
-
-		return IIO_VAL_INT;
-	}
-
-	return -EINVAL;
-}
-
-static const struct iio_info lpc32xx_adc_iio_info = {
-	.read_raw = &lpc32xx_read_raw,
-	.driver_module = THIS_MODULE,
-};
-
-#define LPC32XX_ADC_CHANNEL(_index) {			\
-	.type = IIO_VOLTAGE,				\
-	.indexed = 1,					\
-	.channel = _index,				\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-	.address = LPC32XXAD_IN * _index,		\
-	.scan_index = _index,				\
-}
-
-static const struct iio_chan_spec lpc32xx_adc_iio_channels[] = {
-	LPC32XX_ADC_CHANNEL(0),
-	LPC32XX_ADC_CHANNEL(1),
-	LPC32XX_ADC_CHANNEL(2),
-};
-
-static irqreturn_t lpc32xx_adc_isr(int irq, void *dev_id)
-{
-	struct lpc32xx_adc_state *st = dev_id;
-
-	/* Read value and clear irq */
-	st->value = __raw_readl(LPC32XXAD_VALUE(st->adc_base)) &
-		LPC32XXAD_VALUE_MASK;
-	complete(&st->completion);
-
-	return IRQ_HANDLED;
-}
-
-static int lpc32xx_adc_probe(struct platform_device *pdev)
-{
-	struct lpc32xx_adc_state *st = NULL;
-	struct resource *res;
-	int retval = -ENODEV;
-	struct iio_dev *iodev = NULL;
-	int irq;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get platform I/O memory\n");
-		return -ENXIO;
-	}
-
-	iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
-	if (!iodev)
-		return -ENOMEM;
-
-	st = iio_priv(iodev);
-
-	st->adc_base = devm_ioremap(&pdev->dev, res->start,
-				    resource_size(res));
-	if (!st->adc_base) {
-		dev_err(&pdev->dev, "failed mapping memory\n");
-		return -EBUSY;
-	}
-
-	st->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(st->clk)) {
-		dev_err(&pdev->dev, "failed getting clock\n");
-		return PTR_ERR(st->clk);
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "failed getting interrupt resource\n");
-		return -ENXIO;
-	}
-
-	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
-				  LPC32XXAD_NAME, st);
-	if (retval < 0) {
-		dev_err(&pdev->dev, "failed requesting interrupt\n");
-		return retval;
-	}
-
-	platform_set_drvdata(pdev, iodev);
-
-	init_completion(&st->completion);
-
-	iodev->name = LPC32XXAD_NAME;
-	iodev->dev.parent = &pdev->dev;
-	iodev->info = &lpc32xx_adc_iio_info;
-	iodev->modes = INDIO_DIRECT_MODE;
-	iodev->channels = lpc32xx_adc_iio_channels;
-	iodev->num_channels = ARRAY_SIZE(lpc32xx_adc_iio_channels);
-
-	retval = devm_iio_device_register(&pdev->dev, iodev);
-	if (retval)
-		return retval;
-
-	dev_info(&pdev->dev, "LPC32XX ADC driver loaded, IRQ %d\n", irq);
-
-	return 0;
-}
-
-#ifdef CONFIG_OF
-static const struct of_device_id lpc32xx_adc_match[] = {
-	{ .compatible = "nxp,lpc3220-adc" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, lpc32xx_adc_match);
-#endif
-
-static struct platform_driver lpc32xx_adc_driver = {
-	.probe		= lpc32xx_adc_probe,
-	.driver		= {
-		.name	= LPC32XXAD_NAME,
-		.of_match_table = of_match_ptr(lpc32xx_adc_match),
-	},
-};
-
-module_platform_driver(lpc32xx_adc_driver);
-
-MODULE_AUTHOR("Roland Stigge <stigge@antcom.de>");
-MODULE_DESCRIPTION("LPC32XX ADC driver");
-MODULE_LICENSE("GPL");
-- 
2.11.1

