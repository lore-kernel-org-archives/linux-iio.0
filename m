Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37061 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbeH3TsS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:18 -0400
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
Subject: [PATCH v3 12/30] mfd: Remove old mfd driver & Move sun4i-gpadc.h to iio/adc/
Date: Thu, 30 Aug 2018 17:45:00 +0200
Message-Id: <20180830154518.29507-13-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since we reworked the sun4i-gpadc iio driver we can now remove the mfd
driver and move it's header to include/linux/iio/adc.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c            |   2 +-
 drivers/mfd/sun4i-gpadc.c                    | 181 ---------------------------
 include/linux/{mfd => iio/adc}/sun4i-gpadc.h |   0
 3 files changed, 1 insertion(+), 182 deletions(-)
 delete mode 100644 drivers/mfd/sun4i-gpadc.c
 rename include/linux/{mfd => iio/adc}/sun4i-gpadc.h (100%)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 79b8efdab803..e1fe5e8e9dc0 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -37,7 +37,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
 #include <linux/iio/machine.h>
-#include <linux/mfd/sun4i-gpadc.h>
+#include <linux/iio/adc/sun4i-gpadc.h>
 
 static unsigned int sun4i_gpadc_chan_select(unsigned int chan)
 {
diff --git a/drivers/mfd/sun4i-gpadc.c b/drivers/mfd/sun4i-gpadc.c
deleted file mode 100644
index 9cfc88134d03..000000000000
--- a/drivers/mfd/sun4i-gpadc.c
+++ /dev/null
@@ -1,181 +0,0 @@
-/* ADC MFD core driver for sunxi platforms
- *
- * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/mfd/core.h>
-#include <linux/module.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
-#include <linux/regmap.h>
-
-#include <linux/mfd/sun4i-gpadc.h>
-
-#define ARCH_SUN4I_A10 0
-#define ARCH_SUN5I_A13 1
-#define ARCH_SUN6I_A31 2
-
-static struct resource adc_resources[] = {
-	DEFINE_RES_IRQ_NAMED(SUN4I_GPADC_IRQ_FIFO_DATA, "FIFO_DATA_PENDING"),
-	DEFINE_RES_IRQ_NAMED(SUN4I_GPADC_IRQ_TEMP_DATA, "TEMP_DATA_PENDING"),
-};
-
-static const struct regmap_irq sun4i_gpadc_regmap_irq[] = {
-	REGMAP_IRQ_REG(SUN4I_GPADC_IRQ_FIFO_DATA, 0,
-		       SUN4I_GPADC_INT_FIFOC_TP_DATA_IRQ_EN),
-	REGMAP_IRQ_REG(SUN4I_GPADC_IRQ_TEMP_DATA, 0,
-		       SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN),
-};
-
-static const struct regmap_irq_chip sun4i_gpadc_regmap_irq_chip = {
-	.name = "sun4i_gpadc_irq_chip",
-	.status_base = SUN4I_GPADC_INT_FIFOS,
-	.ack_base = SUN4I_GPADC_INT_FIFOS,
-	.mask_base = SUN4I_GPADC_INT_FIFOC,
-	.init_ack_masked = true,
-	.mask_invert = true,
-	.irqs = sun4i_gpadc_regmap_irq,
-	.num_irqs = ARRAY_SIZE(sun4i_gpadc_regmap_irq),
-	.num_regs = 1,
-};
-
-static struct mfd_cell sun4i_gpadc_cells[] = {
-	{
-		.name	= "sun4i-a10-gpadc-iio",
-		.resources = adc_resources,
-		.num_resources = ARRAY_SIZE(adc_resources),
-	},
-	{ .name = "iio_hwmon" }
-};
-
-static struct mfd_cell sun5i_gpadc_cells[] = {
-	{
-		.name	= "sun5i-a13-gpadc-iio",
-		.resources = adc_resources,
-		.num_resources = ARRAY_SIZE(adc_resources),
-	},
-	{ .name = "iio_hwmon" },
-};
-
-static struct mfd_cell sun6i_gpadc_cells[] = {
-	{
-		.name	= "sun6i-a31-gpadc-iio",
-		.resources = adc_resources,
-		.num_resources = ARRAY_SIZE(adc_resources),
-	},
-	{ .name = "iio_hwmon" },
-};
-
-static const struct regmap_config sun4i_gpadc_regmap_config = {
-	.reg_bits = 32,
-	.val_bits = 32,
-	.reg_stride = 4,
-	.fast_io = true,
-};
-
-static const struct of_device_id sun4i_gpadc_of_match[] = {
-	{
-		.compatible = "allwinner,sun4i-a10-ts",
-		.data = (void *)ARCH_SUN4I_A10,
-	}, {
-		.compatible = "allwinner,sun5i-a13-ts",
-		.data = (void *)ARCH_SUN5I_A13,
-	}, {
-		.compatible = "allwinner,sun6i-a31-ts",
-		.data = (void *)ARCH_SUN6I_A31,
-	}, { /* sentinel */ }
-};
-
-MODULE_DEVICE_TABLE(of, sun4i_gpadc_of_match);
-
-static int sun4i_gpadc_probe(struct platform_device *pdev)
-{
-	struct sun4i_gpadc_dev *dev;
-	struct resource *mem;
-	const struct of_device_id *of_id;
-	const struct mfd_cell *cells;
-	unsigned int irq, size;
-	int ret;
-
-	of_id = of_match_node(sun4i_gpadc_of_match, pdev->dev.of_node);
-	if (!of_id)
-		return -EINVAL;
-
-	switch ((long)of_id->data) {
-	case ARCH_SUN4I_A10:
-		cells = sun4i_gpadc_cells;
-		size = ARRAY_SIZE(sun4i_gpadc_cells);
-		break;
-	case ARCH_SUN5I_A13:
-		cells = sun5i_gpadc_cells;
-		size = ARRAY_SIZE(sun5i_gpadc_cells);
-		break;
-	case ARCH_SUN6I_A31:
-		cells = sun6i_gpadc_cells;
-		size = ARRAY_SIZE(sun6i_gpadc_cells);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dev->base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(dev->base))
-		return PTR_ERR(dev->base);
-
-	dev->dev = &pdev->dev;
-	dev_set_drvdata(dev->dev, dev);
-
-	dev->regmap = devm_regmap_init_mmio(dev->dev, dev->base,
-					    &sun4i_gpadc_regmap_config);
-	if (IS_ERR(dev->regmap)) {
-		ret = PTR_ERR(dev->regmap);
-		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
-		return ret;
-	}
-
-	/* Disable all interrupts */
-	regmap_write(dev->regmap, SUN4I_GPADC_INT_FIFOC, 0);
-
-	irq = platform_get_irq(pdev, 0);
-	ret = devm_regmap_add_irq_chip(&pdev->dev, dev->regmap, irq,
-				       IRQF_ONESHOT, 0,
-				       &sun4i_gpadc_regmap_irq_chip,
-				       &dev->regmap_irqc);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add irq chip: %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_mfd_add_devices(dev->dev, 0, cells, size, NULL, 0, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add MFD devices: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct platform_driver sun4i_gpadc_driver = {
-	.driver = {
-		.name = "sun4i-gpadc",
-		.of_match_table = of_match_ptr(sun4i_gpadc_of_match),
-	},
-	.probe = sun4i_gpadc_probe,
-};
-
-module_platform_driver(sun4i_gpadc_driver);
-
-MODULE_DESCRIPTION("Allwinner sunxi platforms' GPADC MFD core driver");
-MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/iio/adc/sun4i-gpadc.h
similarity index 100%
rename from include/linux/mfd/sun4i-gpadc.h
rename to include/linux/iio/adc/sun4i-gpadc.h
-- 
2.11.0
