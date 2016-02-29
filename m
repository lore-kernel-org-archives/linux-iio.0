Return-Path: <manabian@gmail.com>
From: Joachim Eastwood <manabian@gmail.com>
To: jic23@kernel.org
Cc: Joachim Eastwood <manabian@gmail.com>,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	robh+dt@kernel.org
Subject: [PATCH 3/4] iio: dac: add NXP LPC18xx DAC driver
Date: Mon, 29 Feb 2016 20:05:40 +0100
Message-Id: <1456772741-9402-4-git-send-email-manabian@gmail.com>
In-Reply-To: <1456772741-9402-1-git-send-email-manabian@gmail.com>
References: <1456772741-9402-1-git-send-email-manabian@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add base support for the 10-bit DAC peripheral found
on NXP LPC18xx/43xx SoCs.

This is a minimal driver that does not support DMA or
interrupts.

User manual with register description can be found on:
LPC18xx: www.nxp.com/documents/user_manual/UM10430.pdf
LPC43xx: www.nxp.com/documents/user_manual/UM10503.pdf

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/iio/dac/Kconfig       |  10 +++
 drivers/iio/dac/Makefile      |   1 +
 drivers/iio/dac/lpc18xx_dac.c | 204 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 drivers/iio/dac/lpc18xx_dac.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index a995139f907c..210db81ca144 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -154,6 +154,16 @@ config AD7303
 	  To compile this driver as module choose M here: the module will be called
 	  ad7303.
 
+config LPC18XX_DAC
+	tristate "NXP LPC18xx DAC driver"
+	depends on ARCH_LPC18XX || COMPILE_TEST
+	depends on OF && HAS_IOMEM
+	help
+	  Say yes here to build support for NXP LPC18XX DAC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called lpc18xx_dac.
+
 config M62332
 	tristate "Mitsubishi M62332 DAC driver"
 	depends on I2C
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 67b48429686d..420a15cdaa53 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
 obj-$(CONFIG_AD7303) += ad7303.o
+obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
 obj-$(CONFIG_M62332) += m62332.o
 obj-$(CONFIG_MAX517) += max517.o
 obj-$(CONFIG_MAX5821) += max5821.o
diff --git a/drivers/iio/dac/lpc18xx_dac.c b/drivers/iio/dac/lpc18xx_dac.c
new file mode 100644
index 000000000000..5f4668be603f
--- /dev/null
+++ b/drivers/iio/dac/lpc18xx_dac.c
@@ -0,0 +1,204 @@
+/*
+ * IIO DAC driver for NXP LPC18xx DAC
+ *
+ * Copyright (C) 2016 Joachim Eastwood <manabian@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * UNSUPPORTED hardware features:
+ *  - Interrupts
+ *  - DMA
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+
+/* LPC18XX DAC registers and bits */
+#define LPC18XX_DAC_CR			0x000
+#define  LPC18XX_DAC_CR_VALUE_SHIFT	6
+#define  LPC18XX_DAC_CR_VALUE_MASK	0x3ff
+#define  LPC18XX_DAC_CR_BIAS		BIT(16)
+#define LPC18XX_DAC_CTRL		0x004
+#define  LPC18XX_DAC_CTRL_DMA_ENA	BIT(3)
+
+struct lpc18xx_dac {
+	struct clk *clk;
+	void __iomem *base;
+	struct regulator *vref;
+};
+
+static const struct iio_chan_spec lpc18xx_dac_iio_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.output = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static int lpc18xx_dac_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct lpc18xx_dac *dac = iio_priv(indio_dev);
+	u32 reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		reg = readl(dac->base + LPC18XX_DAC_CR);
+		*val = reg >> LPC18XX_DAC_CR_VALUE_SHIFT;
+		*val &= LPC18XX_DAC_CR_VALUE_MASK;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = regulator_get_voltage(dac->vref) / 1000;
+		*val2 = 10;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
+}
+
+static int lpc18xx_dac_write_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
+{
+	struct lpc18xx_dac *dac = iio_priv(indio_dev);
+	u32 reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val > LPC18XX_DAC_CR_VALUE_MASK)
+			return -EINVAL;
+
+		reg = LPC18XX_DAC_CR_BIAS;
+		reg |= val << LPC18XX_DAC_CR_VALUE_SHIFT;
+		writel(reg, dac->base + LPC18XX_DAC_CR);
+		writel(LPC18XX_DAC_CTRL_DMA_ENA, dac->base + LPC18XX_DAC_CTRL);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info lpc18xx_dac_info = {
+	.read_raw = lpc18xx_dac_read_raw,
+	.write_raw = lpc18xx_dac_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int lpc18xx_dac_probe(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev;
+	struct lpc18xx_dac *dac;
+	struct resource *res;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*dac));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, indio_dev);
+	dac = iio_priv(indio_dev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dac->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dac->base))
+		return PTR_ERR(dac->base);
+
+	dac->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dac->clk)) {
+		dev_err(&pdev->dev, "error getting clock\n");
+		return PTR_ERR(dac->clk);
+	}
+
+	dac->vref = devm_regulator_get(&pdev->dev, "vref");
+	if (IS_ERR(dac->vref)) {
+		dev_err(&pdev->dev, "error get regulator\n");
+		return PTR_ERR(dac->vref);
+	}
+
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->info = &lpc18xx_dac_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = lpc18xx_dac_iio_channels;
+	indio_dev->num_channels = ARRAY_SIZE(lpc18xx_dac_iio_channels);
+
+	ret = regulator_enable(dac->vref);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to enable regulator\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(dac->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to enable clock.\n");
+		goto dis_reg;
+	}
+
+	writel(0, dac->base + LPC18XX_DAC_CTRL);
+	writel(0, dac->base + LPC18XX_DAC_CR);
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register device\n");
+		goto dis_clk;
+	}
+
+	return 0;
+
+dis_clk:
+	clk_disable_unprepare(dac->clk);
+dis_reg:
+	regulator_disable(dac->vref);
+	return ret;
+}
+
+static int lpc18xx_dac_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct lpc18xx_dac *dac = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	writel(0, dac->base + LPC18XX_DAC_CTRL);
+	clk_disable_unprepare(dac->clk);
+	regulator_disable(dac->vref);
+
+	return 0;
+}
+
+static const struct of_device_id lpc18xx_dac_match[] = {
+	{ .compatible = "nxp,lpc1850-dac" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, lpc18xx_dac_match);
+
+static struct platform_driver lpc18xx_dac_driver = {
+	.probe	= lpc18xx_dac_probe,
+	.remove	= lpc18xx_dac_remove,
+	.driver	= {
+		.name = "lpc18xx-dac",
+		.of_match_table = lpc18xx_dac_match,
+	},
+};
+module_platform_driver(lpc18xx_dac_driver);
+
+MODULE_DESCRIPTION("LPC18xx DAC driver");
+MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.8.0
