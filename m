Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:53327 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754331AbcGZHod (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 03:44:33 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
Subject: [PATCH v3 2/4] mfd: add support for Allwinner SoCs ADC
Date: Tue, 26 Jul 2016 09:43:45 +0200
Message-Id: <1469519027-11387-3-git-send-email-quentin.schulz@free-electrons.com>
In-Reply-To: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. For now, only the ADC and the thermal
sensor drivers are probed by the MFD, the touchscreen controller support
will be added later.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

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

 drivers/mfd/Kconfig                 |  15 +++
 drivers/mfd/Makefile                |   2 +
 drivers/mfd/sunxi-gpadc-mfd.c       | 189 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sunxi-gpadc-mfd.h |  94 ++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
 create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 1bcf601..6180c2d 100644
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
+	  sunxi-gpadc-iio and the hwmon driver iio_hwmon.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called sunxi-gpadc-mfd.
+
 config MFD_AS3711
 	bool "AMS AS3711"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 42a66e1..9dfd033 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -205,3 +205,5 @@ intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+= intel_soc_pmic_bxtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397-core.o
+
+obj-$(CONFIG_MFD_SUN4I_GPADC)	+= sunxi-gpadc-mfd.o
diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpadc-mfd.c
new file mode 100644
index 0000000..3d70af0
--- /dev/null
+++ b/drivers/mfd/sunxi-gpadc-mfd.c
@@ -0,0 +1,189 @@
+/* ADC MFD core driver for sunxi platforms
+ *
+ * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
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
+#include <linux/mfd/sunxi-gpadc-mfd.h>
+
+static struct resource adc_resources[] = {
+	{
+		.name	= "FIFO_DATA_PENDING",
+		.start	= SUNXI_IRQ_FIFO_DATA,
+		.end	= SUNXI_IRQ_FIFO_DATA,
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.name	= "TEMP_DATA_PENDING",
+		.start	= SUNXI_IRQ_TEMP_DATA,
+		.end	= SUNXI_IRQ_TEMP_DATA,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static const struct regmap_irq sunxi_gpadc_mfd_regmap_irq[] = {
+	REGMAP_IRQ_REG(SUNXI_IRQ_FIFO_DATA, 0,
+		       SUNXI_GPADC_TP_INT_FIFOC_TP_DATA_IRQ_EN),
+	REGMAP_IRQ_REG(SUNXI_IRQ_TEMP_DATA, 0,
+		       SUNXI_GPADC_TP_INT_FIFOC_TEMP_IRQ_EN),
+};
+
+static const struct regmap_irq_chip sunxi_gpadc_mfd_regmap_irq_chip = {
+	.name = "sunxi_gpadc_mfd_irq_chip",
+	.status_base = SUNXI_GPADC_TP_INT_FIFOS,
+	.ack_base = SUNXI_GPADC_TP_INT_FIFOS,
+	.mask_base = SUNXI_GPADC_TP_INT_FIFOC,
+	.init_ack_masked = true,
+	.mask_invert = true,
+	.irqs = sunxi_gpadc_mfd_regmap_irq,
+	.num_irqs = ARRAY_SIZE(sunxi_gpadc_mfd_regmap_irq),
+	.num_regs = 1,
+};
+
+static struct mfd_cell sun4i_gpadc_mfd_cells[] = {
+	{
+		.name	= "sun4i-a10-gpadc-iio",
+		.resources = adc_resources,
+		.num_resources = ARRAY_SIZE(adc_resources),
+	}, {
+		.name = "iio_hwmon",
+	}
+};
+
+static struct mfd_cell sun5i_gpadc_mfd_cells[] = {
+	{
+		.name	= "sun5i-a13-gpadc-iio",
+		.resources = adc_resources,
+		.num_resources = ARRAY_SIZE(adc_resources),
+	}, {
+		.name = "iio_hwmon",
+	},
+};
+
+static struct mfd_cell sun6i_gpadc_mfd_cells[] = {
+	{
+		.name	= "sun6i-a31-gpadc-iio",
+		.resources = adc_resources,
+		.num_resources = ARRAY_SIZE(adc_resources),
+	}, {
+		.name = "iio_hwmon",
+	},
+};
+
+static const struct regmap_config sunxi_gpadc_mfd_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+};
+
+static const struct of_device_id sunxi_gpadc_mfd_of_match[] = {
+	{
+		.compatible = "allwinner,sun4i-a10-ts",
+		.data = &sun4i_gpadc_mfd_cells,
+	}, {
+		.compatible = "allwinner,sun5i-a13-ts",
+		.data = &sun5i_gpadc_mfd_cells,
+	}, {
+		.compatible = "allwinner,sun6i-a31-ts",
+		.data = &sun6i_gpadc_mfd_cells,
+	}, { /* sentinel */ }
+};
+
+static int sunxi_gpadc_mfd_probe(struct platform_device *pdev)
+{
+	struct sunxi_gpadc_mfd_dev *mfd_dev;
+	struct resource *mem;
+	const struct of_device_id *of_id;
+	const struct mfd_cell *mfd_cells;
+	unsigned int irq;
+	int ret;
+
+	of_id = of_match_node(sunxi_gpadc_mfd_of_match, pdev->dev.of_node);
+	if (!of_id)
+		return -EINVAL;
+
+	mfd_dev = devm_kzalloc(&pdev->dev, sizeof(*mfd_dev), GFP_KERNEL);
+	if (!mfd_dev)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mfd_dev->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(mfd_dev->regs))
+		return PTR_ERR(mfd_dev->regs);
+
+	mfd_dev->dev = &pdev->dev;
+	dev_set_drvdata(mfd_dev->dev, mfd_dev);
+
+	mfd_dev->regmap = devm_regmap_init_mmio(mfd_dev->dev, mfd_dev->regs,
+						&sunxi_gpadc_mfd_regmap_config);
+	if (IS_ERR(mfd_dev->regmap)) {
+		ret = PTR_ERR(mfd_dev->regmap);
+		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
+	/* Disable all interrupts */
+	regmap_write(mfd_dev->regmap, SUNXI_GPADC_TP_INT_FIFOC, 0);
+
+	irq = platform_get_irq(pdev, 0);
+	ret = regmap_add_irq_chip(mfd_dev->regmap, irq, IRQF_ONESHOT, 0,
+				  &sunxi_gpadc_mfd_regmap_irq_chip,
+				  &mfd_dev->regmap_irqc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add irq chip: %d\n", ret);
+		return ret;
+	}
+
+	mfd_cells = of_id->data;
+	ret = mfd_add_devices(mfd_dev->dev, 0, mfd_cells, 2, NULL, 0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add MFD devices: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+err:
+	regmap_del_irq_chip(irq, mfd_dev->regmap_irqc);
+	return ret;
+}
+
+static int sunxi_gpadc_mfd_remove(struct platform_device *pdev)
+{
+	struct sunxi_gpadc_mfd_dev *mfd_dev;
+	unsigned int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	mfd_remove_devices(&pdev->dev);
+	mfd_dev = dev_get_drvdata(&pdev->dev);
+	regmap_del_irq_chip(irq, mfd_dev->regmap_irqc);
+
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(of, sunxi_gpadc_mfd_of_match);
+
+static struct platform_driver sunxi_gpadc_mfd_driver = {
+	.driver = {
+		.name = "sunxi-adc-mfd",
+		.of_match_table = of_match_ptr(sunxi_gpadc_mfd_of_match),
+	},
+	.probe = sunxi_gpadc_mfd_probe,
+	.remove = sunxi_gpadc_mfd_remove,
+};
+
+module_platform_driver(sunxi_gpadc_mfd_driver);
+
+MODULE_DESCRIPTION("Allwinner sunxi platforms' GPADC MFD core driver");
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sunxi-gpadc-mfd.h b/include/linux/mfd/sunxi-gpadc-mfd.h
new file mode 100644
index 0000000..c21abae
--- /dev/null
+++ b/include/linux/mfd/sunxi-gpadc-mfd.h
@@ -0,0 +1,94 @@
+/* Header of ADC MFD core driver for sunxi platforms
+ *
+ * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#ifndef __SUNXI_GPADC_MFD__H__
+#define __SUNXI_GPADC_MFD__H__
+
+#define SUNXI_GPADC_TP_CTRL0				0x00
+
+#define SUNXI_GPADC_TP_CTRL0_ADC_FIRST_DLY(x)		((GENMASK(7, 0) & (x)) << 24)
+#define SUNXI_GPADC_TP_CTRL0_ADC_FIRST_DLY_MODE		BIT(23)
+#define SUNXI_GPADC_TP_CTRL0_ADC_CLK_SELECT		BIT(22)
+#define SUNXI_GPADC_TP_CTRL0_ADC_CLK_DIVIDER(x)		((GENMASK(1, 0) & (x)) << 20)
+#define SUNXI_GPADC_TP_CTRL0_FS_DIV(x)			((GENMASK(3, 0) & (x)) << 16)
+#define SUNXI_GPADC_TP_CTRL0_T_ACQ(x)			(GENMASK(15, 0) & (x))
+
+#define SUNXI_GPADC_TP_CTRL1				0x04
+
+#define SUNXI_GPADC_TP_CTRL1_STYLUS_UP_DEBOUNCE(x)	((GENMASK(7, 0) & (x)) << 12)
+#define SUNXI_GPADC_TP_CTRL1_STYLUS_UP_DEBOUNCE_EN	BIT(9)
+#define SUNXI_GPADC_TP_CTRL1_TOUCH_PAN_CALI_EN		BIT(6)
+#define SUNXI_GPADC_TP_CTRL1_TP_DUAL_EN			BIT(5)
+#define SUNXI_GPADC_TP_CTRL1_TP_MODE_EN			BIT(4)
+#define SUNXI_GPADC_TP_CTRL1_TP_ADC_SELECT		BIT(3)
+#define SUNXI_GPADC_TP_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(2, 0) & (x))
+
+/* TP_CTRL1 bits for sun6i SOCs */
+#define SUNXI_GPADC_TP_CTRL1_SUN6I_TOUCH_PAN_CALI_EN	BIT(7)
+#define SUNXI_GPADC_TP_CTRL1_SUN6I_TP_DUAL_EN		BIT(6)
+#define SUNXI_GPADC_TP_CTRL1_SUN6I_TP_MODE_EN		BIT(5)
+#define SUNXI_GPADC_TP_CTRL1_SUN6I_TP_ADC_SELECT	BIT(4)
+#define SUNXI_GPADC_TP_CTRL1_SUN6I_ADC_CHAN_SELECT(x)	(GENMASK(3, 0) & BIT(x))
+
+#define SUNXI_GPADC_TP_CTRL2				0x08
+
+#define SUNXI_GPADC_TP_CTRL2_TP_SENSITIVE_ADJUST(x)	((GENMASK(3, 0) & (x)) << 28)
+#define SUNXI_GPADC_TP_CTRL2_TP_MODE_SELECT(x)		((GENMASK(1, 0) & (x)) << 26)
+#define SUNXI_GPADC_TP_CTRL2_PRE_MEA_EN			BIT(24)
+#define SUNXI_GPADC_TP_CTRL2_PRE_MEA_THRE_CNT(x)	(GENMASK(23, 0) & (x))
+
+#define SUNXI_GPADC_TP_CTRL3				0x0c
+
+#define SUNXI_GPADC_TP_CTRL3_FILTER_EN			BIT(2)
+#define SUNXI_GPADC_TP_CTRL3_FILTER_TYPE(x)		(GENMASK(1, 0) & (x))
+
+#define SUNXI_GPADC_TP_TPR				0x18
+
+#define SUNXI_GPADC_TP_TPR_TEMP_ENABLE			BIT(16)
+#define SUNXI_GPADC_TP_TPR_TEMP_PERIOD(x)		(GENMASK(15, 0) & (x))
+
+#define SUNXI_GPADC_TP_INT_FIFOC			0x10
+
+#define SUNXI_GPADC_TP_INT_FIFOC_TEMP_IRQ_EN		BIT(18)
+#define SUNXI_GPADC_TP_INT_FIFOC_TP_OVERRUN_IRQ_EN	BIT(17)
+#define SUNXI_GPADC_TP_INT_FIFOC_TP_DATA_IRQ_EN		BIT(16)
+#define SUNXI_GPADC_TP_INT_FIFOC_TP_DATA_XY_CHANGE	BIT(13)
+#define SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_TRIG_LEVEL(x)	((GENMASK(4, 0) & (x)) << 8)
+#define SUNXI_GPADC_TP_INT_FIFOC_TP_DATA_DRQ_EN		BIT(7)
+#define SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_FLUSH		BIT(4)
+#define SUNXI_GPADC_TP_INT_FIFOC_TP_UP_IRQ_EN		BIT(1)
+#define SUNXI_GPADC_TP_INT_FIFOC_TP_DOWN_IRQ_EN		BIT(0)
+
+#define SUNXI_GPADC_TP_INT_FIFOS			0x14
+
+#define SUNXI_GPADC_TP_INT_FIFOS_TEMP_DATA_PENDING	BIT(18)
+#define SUNXI_GPADC_TP_INT_FIFOS_FIFO_OVERRUN_PENDING	BIT(17)
+#define SUNXI_GPADC_TP_INT_FIFOS_FIFO_DATA_PENDING	BIT(16)
+#define SUNXI_GPADC_TP_INT_FIFOS_TP_IDLE_FLG		BIT(2)
+#define SUNXI_GPADC_TP_INT_FIFOS_TP_UP_PENDING		BIT(1)
+#define SUNXI_GPADC_TP_INT_FIFOS_TP_DOWN_PENDING	BIT(0)
+
+#define SUNXI_GPADC_TP_CDAT				0x1c
+#define SUNXI_GPADC_TEMP_DATA				0x20
+#define SUNXI_GPADC_TP_DATA				0x24
+
+#define SUNXI_IRQ_FIFO_DATA				0
+#define SUNXI_IRQ_TEMP_DATA				1
+
+/* 10s delay before suspending the IP */
+#define SUNXI_GPADC_AUTOSUSPEND_DELAY			10000
+
+struct sunxi_gpadc_mfd_dev {
+	struct device			*dev;
+	struct regmap			*regmap;
+	struct regmap_irq_chip_data	*regmap_irqc;
+	void __iomem			*regs;
+};
+
+#endif
-- 
2.5.0

