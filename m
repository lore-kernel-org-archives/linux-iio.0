Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34672 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbcL3TST (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 14:18:19 -0500
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] iio: adc: Add Renesas GyroADC driver
Date: Fri, 30 Dec 2016 20:18:00 +0100
Message-Id: <20161230191800.2532-1-marek.vasut@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add IIO driver for the Renesas RCar GyroADC block. This block is a
simple 4/8-channel ADC which samples 12/15/24 bits of data every
cycle from all channels.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/iio/adc/renesas,gyroadc.txt           |  38 +++
 MAINTAINERS                                        |   6 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rcar_gyro_adc.c                    | 379 +++++++++++++++++++++
 5 files changed, 434 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
 create mode 100644 drivers/iio/adc/rcar_gyro_adc.c

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
new file mode 100644
index 0000000..3fd5f57
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
@@ -0,0 +1,38 @@
+* Renesas RCar GyroADC device driver
+
+Required properties:
+- compatible:	Should be "renesas,rcar-gyroadc" for regular GyroADC or
+		"renesas,rcar-gyroadc-r8a7792" for GyroADC without interrupt
+		block found in R8A7792.
+- reg:		Address and length of the register set for the device
+- clocks:	References to all the clocks specified in the clock-names
+		property as specified in
+		Documentation/devicetree/bindings/clock/clock-bindings.txt.
+- clock-names:	Shall contain "fck" and "if". The "fck" are the GyroADC block
+		clock, the "if" are the interface clock.
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+- power-domains: Must contain a reference to the PM domain, if available.
+- renesas,gyroadc-mode:	GyroADC mode of operation, must be either of:
+			1 - MB88101A mode, 12bit sampling, 4 channels
+			2 - ADCS7476 mode, 15bit sampling, 8 channels
+			3 - MAX1162 mode,  16bit sampling, 8 channels
+- renesas,gyroadc-vref:	Array of reference voltage values for each input to
+			the GyroADC, in uV. Array must have 4 elemenets for
+			mode 1 and 8 elements for mode 2 and 3.
+
+Example:
+	&adc {
+		compatible = "renesas,rcar-gyroadc";
+		reg = <0 0xe6e54000 0 64>;
+		clocks = <&mstp9_clks R8A7791_CLK_GYROADC>, <&clk_65m>;
+		clock-names = "fck", "if";
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+
+		pinctrl-0 = <&adc_pins>;
+		pinctrl-names = "default";
+
+		renesas,gyroadc-vref = <4096000 4096000 4096000 4096000
+					4096000 4096000 4096000 4096000>;
+		renesas,gyroadc-mode = <3>;
+		status = "okay";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 162d904..751e760 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10271,6 +10271,12 @@ L:	linux-renesas-soc@vger.kernel.org
 F:	drivers/net/ethernet/renesas/
 F:	include/linux/sh_eth.h
 
+RENESAS RCAR GYROADC DRIVER
+M:	Marek Vasut <marek.vasut@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/rcar_gyro_adc.c
+
 RENESAS USB2 PHY DRIVER
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 L:	linux-renesas-soc@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 99c0514..4a4cac7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -408,6 +408,16 @@ config QCOM_SPMI_VADC
 	  To compile this driver as a module, choose M here: the module will
 	  be called qcom-spmi-vadc.
 
+config RCAR_GYRO_ADC
+	tristate "Renesas RCAR GyroADC driver"
+	depends on ARCH_RCAR_GEN2 || (ARM && COMPILE_TEST)
+	help
+	  Say yes here to build support for the GyroADC found in Renesas
+	  RCar Gen2 SoCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rcar-gyroadc.
+
 config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7a40c04..253aeb2 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
 obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
 obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
+obj-$(CONFIG_RCAR_GYRO_ADC) += rcar_gyro_adc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
diff --git a/drivers/iio/adc/rcar_gyro_adc.c b/drivers/iio/adc/rcar_gyro_adc.c
new file mode 100644
index 0000000..a74b148
--- /dev/null
+++ b/drivers/iio/adc/rcar_gyro_adc.c
@@ -0,0 +1,379 @@
+/*
+ * Renesas RCar GyroADC driver
+ *
+ * Copyright 2016 Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/regulator/consumer.h>
+#include <linux/of_platform.h>
+#include <linux/err.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+
+/* GyroADC registers. */
+#define RCAR_GYROADC_MODE_SELECT		0x00
+#define RCAR_GYROADC_MODE_SELECT_1_MB88101A	0x0
+#define RCAR_GYROADC_MODE_SELECT_2_ADCS7476	0x1
+#define RCAR_GYROADC_MODE_SELECT_3_MAX1162	0x3
+
+#define RCAR_GYROADC_START_STOP			0x04
+#define RCAR_GYROADC_START_STOP_START		BIT(0)
+
+#define RCAR_GYROADC_CLOCK_LENGTH		0x08
+#define RCAR_GYROADC_1_25MS_LENGTH		0x0c
+
+#define RCAR_GYROADC_REALTIME_DATA(ch)		(0x10 + ((ch) * 4))
+#define RCAR_GYROADC_100MS_ADDED_DATA(ch)	(0x30 + ((ch) * 4))
+#define RCAR_GYROADC_10MS_AVG_DATA(ch)		(0x50 + ((ch) * 4))
+
+#define RCAR_GYROADC_FIFO_STATUS		0x70
+#define RCAR_GYROADC_FIFO_STATUS_EMPTY(ch)	BIT(0 + (4 * (ch)))
+#define RCAR_GYROADC_FIFO_STATUS_FULL(ch)	BIT(1 + (4 * (ch)))
+#define RCAR_GYROADC_FIFO_STATUS_ERROR(ch)	BIT(2 + (4 * (ch)))
+
+#define RCAR_GYROADC_INTR			0x74
+#define RCAR_GYROADC_INTR_INT			BIT(0)
+
+#define RCAR_GYROADC_INTENR			0x78
+#define RCAR_GYROADC_INTENR_INTEN		BIT(0)
+
+#define RCAR_GYROADC_SAMPLE_RATE		800	/* Hz */
+
+enum rcar_gyroadc_model {
+	RCAR_GYROADC_MODEL_DEFAULT,
+	RCAR_GYROADC_MODEL_R8A7792,
+};
+
+struct rcar_gyroadc {
+	struct device		*dev;
+	void __iomem		*regs;
+	struct clk		*fclk;
+	struct clk		*clk;
+	enum rcar_gyroadc_model	model;
+	unsigned int		mode;
+	u32			vref_uv[8];
+	u32			buffer[8];
+};
+
+static void rcar_gyroadc_hw_init(struct rcar_gyroadc *priv)
+{
+	unsigned long clk_mhz = clk_get_rate(priv->clk) / 1000000;
+
+	/* Stop the GyroADC. */
+	writel(0, priv->regs + RCAR_GYROADC_START_STOP);
+
+	/* Disable IRQ, except on V2H. */
+	if (priv->model != RCAR_GYROADC_MODEL_R8A7792)
+		writel(0, priv->regs + RCAR_GYROADC_INTENR);
+
+	/* Set mode and timing. */
+	writel(priv->mode, priv->regs + RCAR_GYROADC_MODE_SELECT);
+
+	if (priv->mode == RCAR_GYROADC_MODE_SELECT_1_MB88101A)
+		writel(clk_mhz * 10, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
+	else if (priv->mode == RCAR_GYROADC_MODE_SELECT_2_ADCS7476)
+		writel(clk_mhz * 5, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
+	else if (priv->mode == RCAR_GYROADC_MODE_SELECT_3_MAX1162)
+		writel(clk_mhz * 5, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
+	writel(clk_mhz * 1250, priv->regs + RCAR_GYROADC_1_25MS_LENGTH);
+
+	/*
+	 * We can possibly turn the sampling on/off on-demand to reduce power
+	 * consumption, but for the sake of quick availability of samples, we
+	 * don't do it now.
+	 */
+	writel(RCAR_GYROADC_START_STOP_START,
+	       priv->regs + RCAR_GYROADC_START_STOP);
+
+	/* Wait for the first conversion to complete. */
+	udelay(1250);
+}
+
+#define RCAR_GYROADC_CHAN(_idx, _chan_type, _realbits) {	\
+	.type			= (_chan_type),			\
+	.indexed		= 1,				\
+	.channel		= (_idx),			\
+	.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+	.scan_index		= (_idx),			\
+	.scan_type	= {					\
+		.sign		= 'u',				\
+		.realbits	= (_realbits),			\
+		.storagebits	= 16,				\
+	},							\
+}
+
+static const struct iio_chan_spec rcar_gyroadc_iio_channels_1[] = {
+	RCAR_GYROADC_CHAN(0, IIO_VOLTAGE, 12),
+	RCAR_GYROADC_CHAN(1, IIO_VOLTAGE, 12),
+	RCAR_GYROADC_CHAN(2, IIO_VOLTAGE, 12),
+	RCAR_GYROADC_CHAN(3, IIO_VOLTAGE, 12),
+};
+
+static const struct iio_chan_spec rcar_gyroadc_iio_channels_2[] = {
+	RCAR_GYROADC_CHAN(0, IIO_VOLTAGE, 15),
+	RCAR_GYROADC_CHAN(1, IIO_VOLTAGE, 15),
+	RCAR_GYROADC_CHAN(2, IIO_VOLTAGE, 15),
+	RCAR_GYROADC_CHAN(3, IIO_VOLTAGE, 15),
+	RCAR_GYROADC_CHAN(4, IIO_VOLTAGE, 15),
+	RCAR_GYROADC_CHAN(5, IIO_VOLTAGE, 15),
+	RCAR_GYROADC_CHAN(6, IIO_VOLTAGE, 15),
+	RCAR_GYROADC_CHAN(7, IIO_VOLTAGE, 15),
+};
+
+/*
+ * NOTE: The data we receive in mode 3 from MAX1162 have MSByte = 0,
+ *       therefore we only use 16bit realbits here instead of 24.
+ */
+static const struct iio_chan_spec rcar_gyroadc_iio_channels_3[] = {
+	RCAR_GYROADC_CHAN(0, IIO_VOLTAGE, 16),
+	RCAR_GYROADC_CHAN(1, IIO_VOLTAGE, 16),
+	RCAR_GYROADC_CHAN(2, IIO_VOLTAGE, 16),
+	RCAR_GYROADC_CHAN(3, IIO_VOLTAGE, 16),
+	RCAR_GYROADC_CHAN(4, IIO_VOLTAGE, 16),
+	RCAR_GYROADC_CHAN(5, IIO_VOLTAGE, 16),
+	RCAR_GYROADC_CHAN(6, IIO_VOLTAGE, 16),
+	RCAR_GYROADC_CHAN(7, IIO_VOLTAGE, 16),
+};
+
+static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2, long mask)
+{
+	struct rcar_gyroadc *priv = iio_priv(indio_dev);
+	unsigned int datareg = RCAR_GYROADC_REALTIME_DATA(chan->channel);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_VOLTAGE)
+			return -EINVAL;
+
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
+		*val = readl(priv->regs + datareg);
+		*val &= BIT(chan->scan_type.realbits) - 1;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = (priv->vref_uv[chan->channel] * 1000) / 0x10000;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = RCAR_GYROADC_SAMPLE_RATE;
+		*val2 = 0;
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int rcar_gyroadc_reg_access(struct iio_dev *indio_dev,
+				   unsigned int reg, unsigned int writeval,
+				   unsigned int *readval)
+{
+	struct rcar_gyroadc *priv = iio_priv(indio_dev);
+	unsigned int maxreg = RCAR_GYROADC_INTENR;
+
+	if (readval == NULL)
+		return -EINVAL;
+
+	if (reg % 4)
+		return -EINVAL;
+
+	/* Handle the V2H case with missing interrupt block. */
+	if (priv->model == RCAR_GYROADC_MODEL_R8A7792)
+		maxreg = RCAR_GYROADC_FIFO_STATUS;
+
+	if (reg > maxreg)
+		return -EINVAL;
+
+	*readval = readl(priv->regs + reg);
+
+	return 0;
+}
+
+static const struct iio_info rcar_gyroadc_iio_info = {
+	.driver_module		= THIS_MODULE,
+	.read_raw		= rcar_gyroadc_read_raw,
+	.debugfs_reg_access	= rcar_gyroadc_reg_access,
+};
+
+static const struct of_device_id rcar_gyroadc_match[] = {
+	{
+		/* RCar Gen2 compatible GyroADC */
+		.compatible	= "renesas,rcar-gyroadc",
+		.data		= (void *)RCAR_GYROADC_MODEL_DEFAULT,
+	}, {
+		/* RCar V2H specialty without interrupt registers. */
+		.compatible	= "renesas,rcar-gyroadc-r8a7792",
+		.data		= (void *)RCAR_GYROADC_MODEL_R8A7792,
+	}, {
+		/* sentinel */
+	}
+};
+
+MODULE_DEVICE_TABLE(of, rcar_gyroadc_match);
+
+static int rcar_gyroadc_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+		of_match_device(rcar_gyroadc_match, &pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct rcar_gyroadc *priv;
+	struct iio_dev *indio_dev;
+	struct resource *mem;
+	int ret, mode;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev) {
+		dev_err(dev, "Failed to allocate IIO device.\n");
+		return -ENOMEM;
+	}
+
+	priv = iio_priv(indio_dev);
+	priv->dev = dev;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->regs = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(priv->regs))
+		return PTR_ERR(priv->regs);
+
+	priv->fclk = devm_clk_get(dev, "fck");
+	if (IS_ERR(priv->fclk)) {
+		ret = PTR_ERR(priv->fclk);
+		dev_err(dev, "Failed to get FCK clock (ret=%i)\n", ret);
+		return ret;
+	}
+
+	priv->clk = devm_clk_get(dev, "if");
+	if (IS_ERR(priv->clk)) {
+		ret = PTR_ERR(priv->clk);
+		dev_err(dev, "Failed to get IF clock (ret=%i)\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32(pdev->dev.of_node, "renesas,gyroadc-mode",
+				   &mode);
+	if (ret || (mode < 1) || (mode > 3)) {
+		dev_err(dev, "Failed to get GyroADC mode (ret=%i)\n", ret);
+		return ret;
+	}
+
+	if (mode == 1)
+		priv->mode = RCAR_GYROADC_MODE_SELECT_1_MB88101A;
+	else if (mode == 2)
+		priv->mode = RCAR_GYROADC_MODE_SELECT_2_ADCS7476;
+	else if (mode == 3)
+		priv->mode = RCAR_GYROADC_MODE_SELECT_3_MAX1162;
+
+	of_property_read_u32_array(pdev->dev.of_node, "renesas,gyroadc-vref",
+				   priv->vref_uv, (mode == 1) ? 4 : 8);
+
+	priv->model = (enum rcar_gyroadc_model)of_id->data;
+
+	platform_set_drvdata(pdev, indio_dev);
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->info = &rcar_gyroadc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	if (mode == 1) {
+		indio_dev->channels = rcar_gyroadc_iio_channels_1;
+		indio_dev->num_channels =
+			ARRAY_SIZE(rcar_gyroadc_iio_channels_1);
+	} else if (mode == 2) {
+		indio_dev->channels = rcar_gyroadc_iio_channels_2;
+		indio_dev->num_channels =
+			ARRAY_SIZE(rcar_gyroadc_iio_channels_2);
+	} else if (mode == 3) {
+		indio_dev->channels = rcar_gyroadc_iio_channels_3;
+		indio_dev->num_channels =
+			ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
+	}
+
+	ret = clk_prepare_enable(priv->fclk);
+	if (ret) {
+		dev_err(dev, "Could not prepare or enable the FCK clock.\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret) {
+		dev_err(dev, "Could not prepare or enable the IF clock.\n");
+		goto error_clk_if_enable;
+	}
+
+	rcar_gyroadc_hw_init(priv);
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(dev, "Couldn't register IIO device.\n");
+		goto error_iio_device_register;
+	}
+
+	return 0;
+
+error_iio_device_register:
+	clk_disable_unprepare(priv->clk);
+error_clk_if_enable:
+	clk_disable_unprepare(priv->fclk);
+	return ret;
+}
+
+static int rcar_gyroadc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct rcar_gyroadc *priv = iio_priv(indio_dev);
+
+	/* Stop sampling */
+	writel(0, priv->regs + RCAR_GYROADC_START_STOP);
+
+	iio_device_unregister(indio_dev);
+	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->fclk);
+
+	return 0;
+}
+
+static struct platform_driver rcar_gyroadc_driver = {
+	.probe          = rcar_gyroadc_probe,
+	.remove         = rcar_gyroadc_remove,
+	.driver         = {
+		.name		= "rcar-gyroadc",
+		.of_match_table	= rcar_gyroadc_match,
+	},
+};
+
+module_platform_driver(rcar_gyroadc_driver);
+
+MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION("Renesas RCAR GyroADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.10.2

