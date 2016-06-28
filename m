Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:44768 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752096AbcF1ISk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 04:18:40 -0400
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
Subject: [PATCH 1/3] mfd: add support for Allwinner SoCs ADC
Date: Tue, 28 Jun 2016 10:18:15 +0200
Message-Id: <1467101897-15946-2-git-send-email-quentin.schulz@free-electrons.com>
In-Reply-To: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Allwinner SoCs all have an ADC that can also act as a touchscreen
controller and a thermal sensor. For now, only the ADC and the thermal
sensor drivers are probed by the MFD, the touchscreen controller support
will be added later.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/Kconfig                 |  14 +++
 drivers/mfd/Makefile                |   2 +
 drivers/mfd/sunxi-gpadc-mfd.c       | 188 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/sunxi-gpadc-mfd.h |  14 +++
 4 files changed, 218 insertions(+)
 create mode 100644 drivers/mfd/sunxi-gpadc-mfd.c
 create mode 100644 include/linux/mfd/sunxi-gpadc-mfd.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index eea61e3..1663db9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -82,6 +82,20 @@ config MFD_ATMEL_FLEXCOM
 	  by the probe function of this MFD driver according to a device tree
 	  property.
 
+config MFD_SUNXI_ADC
+	tristate "ADC MFD core driver for sunxi platforms"
+	select MFD_CORE
+	select REGMAP_MMIO
+	help
+	  Select this to get support for Allwinner SoCs (A10, A13 and A31) ADC.
+	  This driver will only map the hardware interrupt and registers, you
+	  have to select individual drivers based on this MFD to be able to use
+	  the ADC or the thermal sensor. This will try to probe the ADC driver
+	  sunxi-gpadc-iio and the hwmon driver iio_hwmon.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sunxi-gpadc-mfd.
+
 config MFD_ATMEL_HLCDC
 	tristate "Atmel HLCDC (High-end LCD Controller)"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5eaa6465d..b280d0a 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -199,6 +199,8 @@ obj-$(CONFIG_MFD_DLN2)		+= dln2.o
 obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
 obj-$(CONFIG_MFD_SKY81452)	+= sky81452.o
 
+obj-$(CONFIG_MFD_SUNXI_ADC)	+= sunxi-gpadc-mfd.o
+
 intel-soc-pmic-objs		:= intel_soc_pmic_core.o intel_soc_pmic_crc.o
 intel-soc-pmic-$(CONFIG_INTEL_PMC_IPC)	+= intel_soc_pmic_bxtwc.o
 obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpadc-mfd.c
new file mode 100644
index 0000000..710e297
--- /dev/null
+++ b/drivers/mfd/sunxi-gpadc-mfd.c
@@ -0,0 +1,188 @@
+#include <linux/interrupt.h>
+#include <linux/regmap.h>
+#include <linux/mfd/sunxi-gpadc-mfd.h>
+#include <linux/mfd/core.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#define SUNXI_IRQ_FIFO_DATA	0
+#define SUNXI_IRQ_TEMP_DATA	1
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
+	REGMAP_IRQ_REG(SUNXI_IRQ_FIFO_DATA, 0, BIT(16)),
+	REGMAP_IRQ_REG(SUNXI_IRQ_TEMP_DATA, 0, BIT(18)),
+};
+
+static const struct regmap_irq_chip sunxi_gpadc_mfd_regmap_irq_chip = {
+	.name = "sunxi_gpadc_mfd_irq_chip",
+	.status_base = TP_INT_FIFOS,
+	.ack_base = TP_INT_FIFOS,
+	.mask_base = TP_INT_FIFOC,
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
+static int sunxi_gpadc_mfd_probe(struct platform_device *pdev)
+{
+	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev = NULL;
+	struct resource *mem = NULL;
+	unsigned int irq;
+	int ret;
+
+	sunxi_gpadc_mfd_dev = devm_kzalloc(&pdev->dev,
+					   sizeof(*sunxi_gpadc_mfd_dev),
+					   GFP_KERNEL);
+	if (!sunxi_gpadc_mfd_dev)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sunxi_gpadc_mfd_dev->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(sunxi_gpadc_mfd_dev->regs))
+		return PTR_ERR(sunxi_gpadc_mfd_dev->regs);
+
+	sunxi_gpadc_mfd_dev->dev = &pdev->dev;
+	dev_set_drvdata(sunxi_gpadc_mfd_dev->dev, sunxi_gpadc_mfd_dev);
+
+	sunxi_gpadc_mfd_dev->regmap =
+		devm_regmap_init_mmio(sunxi_gpadc_mfd_dev->dev,
+				      sunxi_gpadc_mfd_dev->regs,
+				      &sunxi_gpadc_mfd_regmap_config);
+	if (IS_ERR(sunxi_gpadc_mfd_dev->regmap)) {
+		ret = PTR_ERR(sunxi_gpadc_mfd_dev->regmap);
+		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
+		return ret;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	ret = regmap_add_irq_chip(sunxi_gpadc_mfd_dev->regmap, irq,
+				  IRQF_ONESHOT, 0,
+				  &sunxi_gpadc_mfd_regmap_irq_chip,
+				  &sunxi_gpadc_mfd_dev->regmap_irqc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add irq chip: %d\n", ret);
+		return ret;
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun4i-a10-ts"))
+		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
+				      sun4i_gpadc_mfd_cells,
+				      ARRAY_SIZE(sun4i_gpadc_mfd_cells), NULL,
+				      0, NULL);
+	else if (of_device_is_compatible(pdev->dev.of_node,
+					 "allwinner,sun5i-a13-ts"))
+		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
+				      sun5i_gpadc_mfd_cells,
+				      ARRAY_SIZE(sun5i_gpadc_mfd_cells), NULL,
+				      0, NULL);
+	else if (of_device_is_compatible(pdev->dev.of_node,
+					 "allwinner,sun6i-a31-ts"))
+		ret = mfd_add_devices(sunxi_gpadc_mfd_dev->dev, 0,
+				      sun6i_gpadc_mfd_cells,
+				      ARRAY_SIZE(sun6i_gpadc_mfd_cells), NULL,
+				      0, NULL);
+
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add MFD devices: %d\n", ret);
+		regmap_del_irq_chip(irq, sunxi_gpadc_mfd_dev->regmap_irqc);
+		mfd_remove_devices(&pdev->dev);
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "successfully loaded\n");
+
+	return 0;
+}
+
+static int sunxi_gpadc_mfd_remove(struct platform_device *pdev)
+{
+	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev;
+	unsigned int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	mfd_remove_devices(&pdev->dev);
+	sunxi_gpadc_mfd_dev = dev_get_drvdata(&pdev->dev);
+	regmap_del_irq_chip(irq, sunxi_gpadc_mfd_dev->regmap_irqc);
+
+	return 0;
+}
+
+static const struct of_device_id sunxi_gpadc_mfd_of_match[] = {
+	{ .compatible = "allwinner,sun4i-a10-ts" },
+	{ .compatible = "allwinner,sun5i-a13-ts" },
+	{ .compatible = "allwinner,sun6i-a31-ts" },
+	{ /* sentinel */ }
+};
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
+MODULE_DESCRIPTION("ADC MFD core driver for sunxi platforms");
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/sunxi-gpadc-mfd.h b/include/linux/mfd/sunxi-gpadc-mfd.h
new file mode 100644
index 0000000..341f8c3
--- /dev/null
+++ b/include/linux/mfd/sunxi-gpadc-mfd.h
@@ -0,0 +1,14 @@
+#ifndef __SUNXI_GPADC_MFD__H__
+#define __SUNXI_GPADC_MFD__H__
+
+#define TP_INT_FIFOC            0x10
+#define TP_INT_FIFOS            0x14
+
+struct sunxi_gpadc_mfd_dev {
+	void __iomem			*regs;
+	struct device			*dev;
+	struct regmap			*regmap;
+	struct regmap_irq_chip_data	*regmap_irqc;
+};
+
+#endif
-- 
2.5.0

