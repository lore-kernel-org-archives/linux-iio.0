Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39513 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934131AbcIOMox (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2016 08:44:53 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 1/2] mfd: add support for Allwinner SoCs ADC
Date: Thu, 15 Sep 2016 14:44:03 +0200
Message-Id: <1473943444-23979-2-git-send-email-quentin.schulz@free-electrons.com>
In-Reply-To: <1473943444-23979-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1473943444-23979-1-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. For now, only the ADC and the thermal
sensor drivers are probed by the MFD, the touchscreen controller support
will be added later.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---

v6:
 - remove "-mfd" from filenames and variables inside MFD driver,
 - use DEFINE_RES_IRQ_NAMED instead of setting resources manually,
 - cosmetic changes,
 - use IDs and switch over ID to get cells specific to an architecture, instead
 of using cells direclty, in of_device_id.data,
 - compute size of mfd_cells array instead of hardcoded one,

v5:
 - correct mail address,

v4:
 - rename files and variables from sunxi* to sun4i*,
 - rename defines from SUNXI_* to SUN4I_* or SUN6I_*,
 - remove TP in defines name,
 - rename SUNXI_IRQ_* to SUN4I_GPADC_IRQ_* for consistency,
 - use devm functions for regmap_add_irq_chip and mfd_add_devices,
 - remove remove functions (now empty thanks to devm functions),

v3:
 - use defines in regmap_irq instead of hard coded BITs,
 - use of_device_id data field to chose which MFD cells to add considering
   the compatible responsible of the MFD probe,
 - remove useless initializations,
 - disable all interrupts before adding them to regmap_irqchip,
 - add goto error label in probe,
 - correct wrapping in header license,
 - move defines from IIO driver to header,
 - use GENMASK to limit the size of the variable passed to a macro,
 - prefix register BIT defines with the name of the register,
 - reorder defines,

v2:
 - add license headers,
 - reorder alphabetically includes,
 - add SUNXI_GPADC_ prefixes for defines,

 drivers/mfd/Kconfig             |  15 ++++
 drivers/mfd/Makefile            |   2 +
 drivers/mfd/sun4i-gpadc.c       | 181 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sun4i-gpadc.h |  94 +++++++++++++++++++++
 4 files changed, 292 insertions(+)
 create mode 100644 drivers/mfd/sun4i-gpadc.c
 create mode 100644 include/linux/mfd/sun4i-gpadc.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1bcf601..45db3f4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -29,6 +29,21 @@ config MFD_ACT8945A
 	  linear regulators, along with a complete ActivePath battery
 	  charger.
 
+config MFD_SUN4I_GPADC
+	tristate "Allwinner sunxi platforms' GPADC MFD driver"
+	select MFD_CORE
+	select REGMAP_MMIO
+	depends on ARCH_SUNXI || COMPILE_TEST
+	help
+	  Select this to get support for Allwinner SoCs (A10, A13 and A31) ADC.
+	  This driver will only map the hardware interrupt and registers, you
+	  have to select individual drivers based on this MFD to be able to use
+	  the ADC or the thermal sensor. This will try to probe the ADC driver
+	  sun4i-gpadc-iio and the hwmon driver iio_hwmon.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called sun4i-gpadc.
+
 config MFD_AS3711
 	bool "AMS AS3711"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 42a66e1..12c49af 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -205,3 +205,5 @@ intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+= intel_soc_pmic_bxtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
+
+obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sun4i-gpadc.o
diff --git a/drivers/mfd/sun4i-gpadc.c b/drivers/mfd/sun4i-gpadc.c
new file mode 100644
index 0000000..276a1f4
--- /dev/null
+++ b/drivers/mfd/sun4i-gpadc.c
@@ -0,0 +1,181 @@
+/* ADC MFD core driver for sunxi platforms
+ *
+ * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/sun4i-gpadc.h>
+
+#define ARCH_SUN4I_A10 0
+#define ARCH_SUN5I_A13 1
+#define ARCH_SUN6I_A31 2
+
+static struct resource adc_resources[] = {
+	DEFINE_RES_IRQ_NAMED(SUN4I_GPADC_IRQ_FIFO_DATA, "FIFO_DATA_PENDING"),
+	DEFINE_RES_IRQ_NAMED(SUN4I_GPADC_IRQ_TEMP_DATA, "TEMP_DATA_PENDING"),
+};
+
+static const struct regmap_irq sun4i_gpadc_regmap_irq[] = {
+	REGMAP_IRQ_REG(SUN4I_GPADC_IRQ_FIFO_DATA, 0,
+		       SUN4I_GPADC_INT_FIFOC_TP_DATA_IRQ_EN),
+	REGMAP_IRQ_REG(SUN4I_GPADC_IRQ_TEMP_DATA, 0,
+		       SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN),
+};
+
+static const struct regmap_irq_chip sun4i_gpadc_regmap_irq_chip = {
+	.name = "sun4i_gpadc_irq_chip",
+	.status_base = SUN4I_GPADC_INT_FIFOS,
+	.ack_base = SUN4I_GPADC_INT_FIFOS,
+	.mask_base = SUN4I_GPADC_INT_FIFOC,
+	.init_ack_masked = true,
+	.mask_invert = true,
+	.irqs = sun4i_gpadc_regmap_irq,
+	.num_irqs = ARRAY_SIZE(sun4i_gpadc_regmap_irq),
+	.num_regs = 1,
+};
+
+static struct mfd_cell sun4i_gpadc_cells[] = {
+	{
+		.name	= "sun4i-a10-gpadc-iio",
+		.resources = adc_resources,
+		.num_resources = ARRAY_SIZE(adc_resources),
+	},
+	{ .name = "iio_hwmon" }
+};
+
+static struct mfd_cell sun5i_gpadc_cells[] = {
+	{
+		.name	= "sun5i-a13-gpadc-iio",
+		.resources = adc_resources,
+		.num_resources = ARRAY_SIZE(adc_resources),
+	},
+	{ .name = "iio_hwmon" },
+};
+
+static struct mfd_cell sun6i_gpadc_cells[] = {
+	{
+		.name	= "sun6i-a31-gpadc-iio",
+		.resources = adc_resources,
+		.num_resources = ARRAY_SIZE(adc_resources),
+	},
+	{ .name = "iio_hwmon" },
+};
+
+static const struct regmap_config sun4i_gpadc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+};
+
+static const struct of_device_id sun4i_gpadc_of_match[] = {
+	{
+		.compatible = "allwinner,sun4i-a10-ts",
+		.data = (void *)ARCH_SUN4I_A10,
+	}, {
+		.compatible = "allwinner,sun5i-a13-ts",
+		.data = (void *)ARCH_SUN5I_A13,
+	}, {
+		.compatible = "allwinner,sun6i-a31-ts",
+		.data = (void *)ARCH_SUN6I_A31,
+	}, { /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, sun4i_gpadc_of_match);
+
+static int sun4i_gpadc_probe(struct platform_device *pdev)
+{
+	struct sun4i_gpadc_dev *dev;
+	struct resource *mem;
+	const struct of_device_id *of_id;
+	const struct mfd_cell *cells;
+	unsigned int irq, size;
+	int ret;
+
+	of_id = of_match_node(sun4i_gpadc_of_match, pdev->dev.of_node);
+	if (!of_id)
+		return -EINVAL;
+
+	switch ((int)of_id->data) {
+	case ARCH_SUN4I_A10:
+		cells = sun4i_gpadc_cells;
+		size = ARRAY_SIZE(sun4i_gpadc_cells);
+		break;
+	case ARCH_SUN5I_A13:
+		cells = sun5i_gpadc_cells;
+		size = ARRAY_SIZE(sun5i_gpadc_cells);
+		break;
+	case ARCH_SUN6I_A31:
+		cells = sun6i_gpadc_cells;
+		size = ARRAY_SIZE(sun6i_gpadc_cells);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dev->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(dev->base))
+		return PTR_ERR(dev->base);
+
+	dev->dev = &pdev->dev;
+	dev_set_drvdata(dev->dev, dev);
+
+	dev->regmap = devm_regmap_init_mmio(dev->dev, dev->base,
+					    &sun4i_gpadc_regmap_config);
+	if (IS_ERR(dev->regmap)) {
+		ret = PTR_ERR(dev->regmap);
+		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
+	/* Disable all interrupts */
+	regmap_write(dev->regmap, SUN4I_GPADC_INT_FIFOC, 0);
+
+	irq = platform_get_irq(pdev, 0);
+	ret = devm_regmap_add_irq_chip(&pdev->dev, dev->regmap, irq,
+				       IRQF_ONESHOT, 0,
+				       &sun4i_gpadc_regmap_irq_chip,
+				       &dev->regmap_irqc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add irq chip: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_mfd_add_devices(dev->dev, 0, cells, size, NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add MFD devices: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver sun4i_gpadc_driver = {
+	.driver = {
+		.name = "sun4i-gpadc",
+		.of_match_table = of_match_ptr(sun4i_gpadc_of_match),
+	},
+	.probe = sun4i_gpadc_probe,
+};
+
+module_platform_driver(sun4i_gpadc_driver);
+
+MODULE_DESCRIPTION("Allwinner sunxi platforms' GPADC MFD core driver");
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
new file mode 100644
index 0000000..d7a29f2
--- /dev/null
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -0,0 +1,94 @@
+/* Header of ADC MFD core driver for sunxi platforms
+ *
+ * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#ifndef __SUN4I_GPADC__H__
+#define __SUN4I_GPADC__H__
+
+#define SUN4I_GPADC_CTRL0				0x00
+
+#define SUN4I_GPADC_CTRL0_ADC_FIRST_DLY(x)		((GENMASK(7, 0) & (x)) << 24)
+#define SUN4I_GPADC_CTRL0_ADC_FIRST_DLY_MODE		BIT(23)
+#define SUN4I_GPADC_CTRL0_ADC_CLK_SELECT		BIT(22)
+#define SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(x)		((GENMASK(1, 0) & (x)) << 20)
+#define SUN4I_GPADC_CTRL0_FS_DIV(x)			((GENMASK(3, 0) & (x)) << 16)
+#define SUN4I_GPADC_CTRL0_T_ACQ(x)			(GENMASK(15, 0) & (x))
+
+#define SUN4I_GPADC_CTRL1				0x04
+
+#define SUN4I_GPADC_CTRL1_STYLUS_UP_DEBOUNCE(x)		((GENMASK(7, 0) & (x)) << 12)
+#define SUN4I_GPADC_CTRL1_STYLUS_UP_DEBOUNCE_EN		BIT(9)
+#define SUN4I_GPADC_CTRL1_TOUCH_PAN_CALI_EN		BIT(6)
+#define SUN4I_GPADC_CTRL1_TP_DUAL_EN			BIT(5)
+#define SUN4I_GPADC_CTRL1_TP_MODE_EN			BIT(4)
+#define SUN4I_GPADC_CTRL1_TP_ADC_SELECT			BIT(3)
+#define SUN4I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(2, 0) & (x))
+
+/* TP_CTRL1 bits for sun6i SOCs */
+#define SUN6I_GPADC_CTRL1_TOUCH_PAN_CALI_EN		BIT(7)
+#define SUN6I_GPADC_CTRL1_TP_DUAL_EN			BIT(6)
+#define SUN6I_GPADC_CTRL1_TP_MODE_EN			BIT(5)
+#define SUN6I_GPADC_CTRL1_TP_ADC_SELECT			BIT(4)
+#define SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(3, 0) & BIT(x))
+
+#define SUN4I_GPADC_CTRL2				0x08
+
+#define SUN4I_GPADC_CTRL2_TP_SENSITIVE_ADJUST(x)	((GENMASK(3, 0) & (x)) << 28)
+#define SUN4I_GPADC_CTRL2_TP_MODE_SELECT(x)		((GENMASK(1, 0) & (x)) << 26)
+#define SUN4I_GPADC_CTRL2_PRE_MEA_EN			BIT(24)
+#define SUN4I_GPADC_CTRL2_PRE_MEA_THRE_CNT(x)		(GENMASK(23, 0) & (x))
+
+#define SUN4I_GPADC_CTRL3				0x0c
+
+#define SUN4I_GPADC_CTRL3_FILTER_EN			BIT(2)
+#define SUN4I_GPADC_CTRL3_FILTER_TYPE(x)		(GENMASK(1, 0) & (x))
+
+#define SUN4I_GPADC_TPR					0x18
+
+#define SUN4I_GPADC_TPR_TEMP_ENABLE			BIT(16)
+#define SUN4I_GPADC_TPR_TEMP_PERIOD(x)			(GENMASK(15, 0) & (x))
+
+#define SUN4I_GPADC_INT_FIFOC				0x10
+
+#define SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN		BIT(18)
+#define SUN4I_GPADC_INT_FIFOC_TP_OVERRUN_IRQ_EN		BIT(17)
+#define SUN4I_GPADC_INT_FIFOC_TP_DATA_IRQ_EN		BIT(16)
+#define SUN4I_GPADC_INT_FIFOC_TP_DATA_XY_CHANGE		BIT(13)
+#define SUN4I_GPADC_INT_FIFOC_TP_FIFO_TRIG_LEVEL(x)	((GENMASK(4, 0) & (x)) << 8)
+#define SUN4I_GPADC_INT_FIFOC_TP_DATA_DRQ_EN		BIT(7)
+#define SUN4I_GPADC_INT_FIFOC_TP_FIFO_FLUSH		BIT(4)
+#define SUN4I_GPADC_INT_FIFOC_TP_UP_IRQ_EN		BIT(1)
+#define SUN4I_GPADC_INT_FIFOC_TP_DOWN_IRQ_EN		BIT(0)
+
+#define SUN4I_GPADC_INT_FIFOS				0x14
+
+#define SUN4I_GPADC_INT_FIFOS_TEMP_DATA_PENDING		BIT(18)
+#define SUN4I_GPADC_INT_FIFOS_FIFO_OVERRUN_PENDING	BIT(17)
+#define SUN4I_GPADC_INT_FIFOS_FIFO_DATA_PENDING		BIT(16)
+#define SUN4I_GPADC_INT_FIFOS_TP_IDLE_FLG		BIT(2)
+#define SUN4I_GPADC_INT_FIFOS_TP_UP_PENDING		BIT(1)
+#define SUN4I_GPADC_INT_FIFOS_TP_DOWN_PENDING		BIT(0)
+
+#define SUN4I_GPADC_CDAT				0x1c
+#define SUN4I_GPADC_TEMP_DATA				0x20
+#define SUN4I_GPADC_DATA				0x24
+
+#define SUN4I_GPADC_IRQ_FIFO_DATA			0
+#define SUN4I_GPADC_IRQ_TEMP_DATA			1
+
+/* 10s delay before suspending the IP */
+#define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000
+
+struct sun4i_gpadc_dev {
+	struct device			*dev;
+	struct regmap			*regmap;
+	struct regmap_irq_chip_data	*regmap_irqc;
+	void __iomem			*base;
+};
+
+#endif
-- 
2.5.0

