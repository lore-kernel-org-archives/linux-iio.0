Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33849 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdAJVdr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 16:33:47 -0500
Received: by mail-oi0-f66.google.com with SMTP id 3so71695097oih.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Jan 2017 13:33:46 -0800 (PST)
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH V4] iio: adc: Add Renesas GyroADC driver
Date: Tue, 10 Jan 2017 22:33:38 +0100
Message-Id: <20170110213338.15855-1-marek.vasut@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add IIO driver for the Renesas RCar GyroADC block. This block is a
simple 4/8-channel ADC which samples 12/15/24 bits of data every
cycle from all channels.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms+renesas@verge.net.au>
---
V2: - Spelling fixes
    - Rename the driver source file to rcar-gyroadc
    - Rework the channel sample width handling
    - Use iio_device_claim_mode_direct()
    - Rename "renesas,rcar-gyroadc" to "renesas,r8a7791-gyroadc" and
      rename "renesas,rcar-gyroadc-r8a7792" to "renesas,r8a7792-gyroadc"
      to match the new naming scheme (WARNING: scif uses the old one!)
    - Switch to using regulators for channel voltage reference, add new
      properties renesas,gyroadc-vref-chN-supply for N in 0..7
    - Handle vref regulators as optional to, make channels without
      vref regulator return EINVAL on read.
    - Fix module license to GPL
    - Drop interrupt.h include
    - Rename clk to iclk
    - Rename RCar to R-Car
    - Rework the invalid mode handling
    - Don't print error message on EPROBE_DEFER
    - Drop fclk handling, use runtime PM for that instead
V3: - More R-Car spelling fixes
    - Flip checks for V2H, since that's the only one that has
      interrupt registers
    - Replace if-else statement with switch statement in init_mode
    - Use unsigned types where applicable
    - Rework timing calculation slightly to drop if-else block
    - Use DIV_ROUND_CLOSEST
V4: - Add renesas,rcar-gyroadc fallback compatible string into the bindings
    - Rework the ADC bindings to use per-channel subdevs
    - Support more compatible ADC chips
---
 .../bindings/iio/adc/renesas,gyroadc.txt           |  70 +++
 MAINTAINERS                                        |   6 +
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/rcar-gyroadc.c                     | 531 +++++++++++++++++++++
 5 files changed, 618 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
 create mode 100644 drivers/iio/adc/rcar-gyroadc.c

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
new file mode 100644
index 000000000000..2dcea9c8895b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
@@ -0,0 +1,70 @@
+* Renesas RCar GyroADC device driver
+
+Required properties:
+- compatible:	Should be "renesas,<chip>-gyroadc", "renesas,rcar-gyroadc".
+		Use "renesas,r8a7792-gyroadc" for a GyroADC with interrupt
+		block found in R8A7792.
+- reg:		Address and length of the register set for the device
+- clocks:	References to all the clocks specified in the clock-names
+		property as specified in
+		Documentation/devicetree/bindings/clock/clock-bindings.txt.
+- clock-names:	Shall contain "fck" and "if". The "fck" is the GyroADC block
+		clock, the "if" is the interface clock.
+- power-domains: Must contain a reference to the PM domain, if available.
+- #address-cells: Should be <1> (setting for the subnodes)
+- #size-cells:	Should be <0> (setting for the subnodes)
+
+Sub-nodes:
+Optionally you can define subnodes which define the reference voltage
+for the analog inputs.
+
+Required properties for subnodes:
+- compatible:	Should be either of:
+		"fujitsu,mb88101a"
+			- Fujitsu MB88101A compatible mode,
+			  12bit sampling, 4 channels
+		"ti,adcs7476" or "ti,adc121" or "adi,ad7476"
+			- TI ADCS7476 / TI ADC121 / ADI AD7476 compatible mode,
+			  15bit sampling, 8 channels
+		"maxim,max1162" or "maxim,max11100"
+			- Maxim MAX1162 / Maxim MAX11100 compatible mode,
+			  16bit sampling, 8 channels
+- reg:		Should be the number of the analog input.
+- vref-supply:	Reference to the channel reference voltage regulator.
+
+Example:
+	vref_max1162: regulator-vref-max1162 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "MAX1162 Vref";
+		regulator-min-microvolt = <4096000>;
+		regulator-max-microvolt = <4096000>;
+	};
+
+	&adc {
+		compatible = "renesas,r8a7791-gyroadc", "renesas,rcar-gyroadc";
+		reg = <0 0xe6e54000 0 64>;
+		clocks = <&mstp9_clks R8A7791_CLK_GYROADC>, <&clk_65m>;
+		clock-names = "fck", "if";
+		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+
+		pinctrl-0 = <&adc_pins>;
+		pinctrl-names = "default";
+
+		status = "okay";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		adc@0 {
+			reg = <0>;
+			compatible = "maxim,max1162";
+			vref-supply = <&vref_max1162>;
+		};
+
+		adc@1 {
+			reg = <1>;
+			compatible = "maxim,max1162";
+			vref-supply = <&vref_max1162>;
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 890fc9e3c191..498e8a755eb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10276,6 +10276,12 @@ L:	linux-renesas-soc@vger.kernel.org
 F:	drivers/net/ethernet/renesas/
 F:	include/linux/sh_eth.h
 
+RENESAS R-CAR GYROADC DRIVER
+M:	Marek Vasut <marek.vasut@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/adc/rcar_gyro_adc.c
+
 RENESAS USB2 PHY DRIVER
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 L:	linux-renesas-soc@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 99c051490eff..f9954c71048d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -408,6 +408,16 @@ config QCOM_SPMI_VADC
 	  To compile this driver as a module, choose M here: the module will
 	  be called qcom-spmi-vadc.
 
+config RCAR_GYRO_ADC
+	tristate "Renesas R-Car GyroADC driver"
+	depends on ARCH_RCAR_GEN2 || (ARM && COMPILE_TEST)
+	help
+	  Say yes here to build support for the GyroADC found in Renesas
+	  R-Car Gen2 SoCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rcar-gyroadc.
+
 config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7a40c04c311f..13db7c2bffc8 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
 obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
 obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
+obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
 obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
new file mode 100644
index 000000000000..14f139613e1c
--- /dev/null
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -0,0 +1,531 @@
+/*
+ * Renesas R-Car GyroADC driver
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
+#include <linux/pm_runtime.h>
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
+	struct device			*dev;
+	void __iomem			*regs;
+	struct clk			*iclk;
+	struct regulator		*vref[8];
+	unsigned int			num_channels;
+	enum rcar_gyroadc_model		model;
+	unsigned int			mode;
+	unsigned int			sample_width;
+	u32				buffer[8];
+};
+
+static void rcar_gyroadc_hw_init(struct rcar_gyroadc *priv)
+{
+	const unsigned long clk_mhz = clk_get_rate(priv->iclk) / 1000000;
+	const unsigned long clk_mul =
+		(priv->mode == RCAR_GYROADC_MODE_SELECT_1_MB88101A) ? 10 : 5;
+
+	/* Stop the GyroADC. */
+	writel(0, priv->regs + RCAR_GYROADC_START_STOP);
+
+	/* Disable IRQ on V2H. */
+	if (priv->model == RCAR_GYROADC_MODEL_R8A7792)
+		writel(0, priv->regs + RCAR_GYROADC_INTENR);
+
+	/* Set mode and timing. */
+	writel(priv->mode, priv->regs + RCAR_GYROADC_MODE_SELECT);
+	writel(clk_mhz * clk_mul, priv->regs + RCAR_GYROADC_CLOCK_LENGTH);
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
+#define RCAR_GYROADC_CHAN(_idx) {				\
+	.type			= IIO_VOLTAGE,			\
+	.indexed		= 1,				\
+	.channel		= (_idx),			\
+	.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |	\
+				  BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+}
+
+static const struct iio_chan_spec rcar_gyroadc_iio_channels_1[] = {
+	RCAR_GYROADC_CHAN(0),
+	RCAR_GYROADC_CHAN(1),
+	RCAR_GYROADC_CHAN(2),
+	RCAR_GYROADC_CHAN(3),
+};
+
+static const struct iio_chan_spec rcar_gyroadc_iio_channels_2[] = {
+	RCAR_GYROADC_CHAN(0),
+	RCAR_GYROADC_CHAN(1),
+	RCAR_GYROADC_CHAN(2),
+	RCAR_GYROADC_CHAN(3),
+	RCAR_GYROADC_CHAN(4),
+	RCAR_GYROADC_CHAN(5),
+	RCAR_GYROADC_CHAN(6),
+	RCAR_GYROADC_CHAN(7),
+};
+
+/*
+ * NOTE: The data we receive in mode 3 from MAX1162 have MSByte = 0,
+ *       therefore we only use 16bit realbits here instead of 24.
+ */
+static const struct iio_chan_spec rcar_gyroadc_iio_channels_3[] = {
+	RCAR_GYROADC_CHAN(0),
+	RCAR_GYROADC_CHAN(1),
+	RCAR_GYROADC_CHAN(2),
+	RCAR_GYROADC_CHAN(3),
+	RCAR_GYROADC_CHAN(4),
+	RCAR_GYROADC_CHAN(5),
+	RCAR_GYROADC_CHAN(6),
+	RCAR_GYROADC_CHAN(7),
+};
+
+static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val, int *val2, long mask)
+{
+	struct rcar_gyroadc *priv = iio_priv(indio_dev);
+	struct regulator *consumer = priv->vref[chan->channel];
+	unsigned int datareg = RCAR_GYROADC_REALTIME_DATA(chan->channel);
+	unsigned int vref;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_VOLTAGE)
+			return -EINVAL;
+
+		/* Channel not connected. */
+		if (!consumer)
+			return -EINVAL;
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		*val = readl(priv->regs + datareg);
+		*val &= BIT(priv->sample_width) - 1;
+
+		iio_device_release_direct_mode(indio_dev);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* Channel not connected. */
+		if (!consumer)
+			return -EINVAL;
+
+		vref = regulator_get_voltage(consumer);
+		*val = 0;
+		*val2 = DIV_ROUND_CLOSEST(vref * 1000, 0x10000);
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = RCAR_GYROADC_SAMPLE_RATE;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rcar_gyroadc_reg_access(struct iio_dev *indio_dev,
+				   unsigned int reg, unsigned int writeval,
+				   unsigned int *readval)
+{
+	struct rcar_gyroadc *priv = iio_priv(indio_dev);
+	unsigned int maxreg = RCAR_GYROADC_FIFO_STATUS;
+
+	if (readval == NULL)
+		return -EINVAL;
+
+	if (reg % 4)
+		return -EINVAL;
+
+	/* Handle the V2H case with extra interrupt block. */
+	if (priv->model == RCAR_GYROADC_MODEL_R8A7792)
+		maxreg = RCAR_GYROADC_INTENR;
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
+		/* R-Car compatible GyroADC */
+		.compatible	= "renesas,rcar-gyroadc",
+		.data		= (void *)RCAR_GYROADC_MODEL_DEFAULT,
+	}, {
+		/* R-Car V2H specialty with interrupt registers. */
+		.compatible	= "renesas,r8a7792-gyroadc",
+		.data		= (void *)RCAR_GYROADC_MODEL_R8A7792,
+	}, {
+		/* sentinel */
+	}
+};
+
+MODULE_DEVICE_TABLE(of, rcar_gyroadc_match);
+
+static const struct of_device_id rcar_gyroadc_child_match[] = {
+	/* Mode 1 ADCs */
+	{
+		.compatible	= "fujitsu,mb88101a",
+		.data		= (void *)RCAR_GYROADC_MODE_SELECT_1_MB88101A,
+	},
+	/* Mode 2 ADCs */
+	{
+		.compatible	= "ti,adcs7476",
+		.data		= (void *)RCAR_GYROADC_MODE_SELECT_2_ADCS7476,
+	}, {
+		.compatible	= "ti,adc121",
+		.data		= (void *)RCAR_GYROADC_MODE_SELECT_2_ADCS7476,
+	}, {
+		.compatible	= "adi,ad7476",
+		.data		= (void *)RCAR_GYROADC_MODE_SELECT_2_ADCS7476,
+	},
+	/* Mode 3 ADCs */
+	{
+		.compatible	= "maxim,max1162",
+		.data		= (void *)RCAR_GYROADC_MODE_SELECT_3_MAX1162,
+	}, {
+		.compatible	= "maxim,max11100",
+		.data		= (void *)RCAR_GYROADC_MODE_SELECT_3_MAX1162,
+	},
+	{ /* sentinel */ }
+};
+
+static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
+{
+	const struct of_device_id *of_id;
+	const struct iio_chan_spec *channels;
+	struct rcar_gyroadc *priv = iio_priv(indio_dev);
+	struct device *dev = priv->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *child;
+	struct regulator *vref;
+	unsigned int reg, maxreg;
+	unsigned int adcmode, childmode;
+	unsigned int sample_width;
+	unsigned int num_channels;
+	int ret, first = 1;
+
+	for_each_child_of_node(np, child) {
+		of_id = of_match_node(rcar_gyroadc_child_match, child);
+		if (!of_id) {
+			dev_err(dev, "Ignoring unsupported ADC \"%s\".",
+				child->name);
+			continue;
+		}
+
+		ret = of_property_read_u32(child, "reg", &reg);
+		if (ret) {
+			dev_err(dev,
+				"Failed to get child reg property of ADC \"%s\".\n",
+				child->name);
+			continue;
+		}
+
+		childmode = (unsigned int)of_id->data;
+		switch (childmode) {
+		case RCAR_GYROADC_MODE_SELECT_1_MB88101A:
+			maxreg = 4;
+			sample_width = 12;
+			channels = rcar_gyroadc_iio_channels_1;
+			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_1);
+			break;
+		case RCAR_GYROADC_MODE_SELECT_2_ADCS7476:
+			maxreg = 8;
+			sample_width = 15;
+			channels = rcar_gyroadc_iio_channels_2;
+			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_2);
+			break;
+		case RCAR_GYROADC_MODE_SELECT_3_MAX1162:
+			maxreg = 8;
+			sample_width = 16;
+			channels = rcar_gyroadc_iio_channels_3;
+			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
+			break;
+		}
+
+		/* Channel number is too high. */
+		if (reg >= maxreg) {
+			dev_err(dev,
+				"Only %i channels supported with %s, but reg = <%i>, ignoring.\n",
+				maxreg, child->name, reg);
+			continue;
+		}
+
+		/* Child node selected different mode than the rest. */
+		if (!first && (adcmode != childmode)) {
+			dev_err(dev,
+				"Channel %i uses different ADC mode than the rest, ignoring.\n",
+				reg);
+			continue;
+		}
+
+		/* Channel is valid, grab the regulator. */
+		dev->of_node = child;
+		vref = devm_regulator_get_optional(dev, "vref");
+		dev->of_node = np;
+		if (IS_ERR(vref)) {
+			/*
+			 * Regulator is not present, which means the channel
+			 * supply is not connected.
+			 */
+			dev_dbg(dev, "Channel %i 'vref' supply not connected\n",
+				reg);
+			continue;
+		}
+
+		priv->vref[reg] = vref;
+
+		if (!first)
+			continue;
+
+		/* First child node which passed sanity tests. */
+		adcmode = childmode;
+		first = 0;
+
+		priv->num_channels = maxreg;
+		priv->mode = childmode;
+		priv->sample_width = sample_width;
+
+		indio_dev->channels = channels;
+		indio_dev->num_channels = num_channels;
+	}
+
+	if (first) {
+		dev_err(dev, "No valid ADC channels found, aborting.\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void rcar_gyroadc_deinit_supplies(struct iio_dev *indio_dev)
+{
+	struct rcar_gyroadc *priv = iio_priv(indio_dev);
+	unsigned int i;
+
+	for (i = 0; i < priv->num_channels; i++) {
+		if (!priv->vref[i])
+			continue;
+
+		regulator_disable(priv->vref[i]);
+	}
+}
+
+static int rcar_gyroadc_init_supplies(struct iio_dev *indio_dev)
+{
+	struct rcar_gyroadc *priv = iio_priv(indio_dev);
+	struct device *dev = priv->dev;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < priv->num_channels; i++) {
+		if (!priv->vref[i])
+			continue;
+
+		ret = regulator_enable(priv->vref[i]);
+		if (ret) {
+			dev_err(dev, "Failed to enable regulator %i (ret=%i)\n",
+				i, ret);
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	rcar_gyroadc_deinit_supplies(indio_dev);
+	return ret;
+}
+
+static int rcar_gyroadc_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+		of_match_device(rcar_gyroadc_match, &pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct rcar_gyroadc *priv;
+	struct iio_dev *indio_dev;
+	struct resource *mem;
+	int ret;
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
+	priv->iclk = devm_clk_get(dev, "if");
+	if (IS_ERR(priv->iclk)) {
+		ret = PTR_ERR(priv->iclk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get IF clock (ret=%i)\n", ret);
+		return ret;
+	}
+
+	ret = rcar_gyroadc_parse_subdevs(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = rcar_gyroadc_init_supplies(indio_dev);
+	if (ret)
+		return ret;
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
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	ret = clk_prepare_enable(priv->iclk);
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
+	clk_disable_unprepare(priv->iclk);
+error_clk_if_enable:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+	rcar_gyroadc_deinit_supplies(indio_dev);
+	return ret;
+}
+
+static int rcar_gyroadc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct rcar_gyroadc *priv = iio_priv(indio_dev);
+	struct device *dev = priv->dev;
+
+	/* Stop sampling */
+	writel(0, priv->regs + RCAR_GYROADC_START_STOP);
+
+	iio_device_unregister(indio_dev);
+	clk_disable_unprepare(priv->iclk);
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+	rcar_gyroadc_deinit_supplies(indio_dev);
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
+MODULE_DESCRIPTION("Renesas R-Car GyroADC driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0

