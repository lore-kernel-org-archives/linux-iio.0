Return-Path: <SRS0=djI4=DE=st.com=arnaud.pouliquen@kernel.org>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, <arnaud.pouliquen@st.com>
Subject: [PATCH v7 08/13] IIO: ADC: add stm32 DFSDM core support
Date: Fri, 8 Dec 2017 15:49:21 +0100
Message-ID: <1512744566-13233-9-git-send-email-arnaud.pouliquen@st.com>
In-Reply-To: <1512744566-13233-1-git-send-email-arnaud.pouliquen@st.com>
References: <1512744566-13233-1-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add driver for stm32 DFSDM pheripheral. Its converts a sigma delta
stream in n bit samples through a low pass filter and an integrator.
stm32-dfsdm-core driver is the core part supporting the filter
instances dedicated to sigma-delta ADC or audio PDM microphone purpose.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
V6 to V7 updates:
- SPDX-Licensing.
- Fix return value when optional property "spi-max-frequency" not defined.
- Use devm_regmap_init_mmio_clk instead of devm_regmap_init_mmio.

 drivers/iio/adc/Kconfig            |  12 ++
 drivers/iio/adc/Makefile           |   1 +
 drivers/iio/adc/stm32-dfsdm-core.c | 309 ++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/stm32-dfsdm.h      | 310 +++++++++++++++++++++++++++++++++++++
 4 files changed, 632 insertions(+)
 create mode 100644 drivers/iio/adc/stm32-dfsdm-core.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm.h

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index c5db62f..b729ae0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -665,6 +665,18 @@ config STM32_ADC
 	  This driver can also be built as a module.  If so, the module
 	  will be called stm32-adc.
 
+config STM32_DFSDM_CORE
+	tristate "STMicroelectronics STM32 DFSDM core"
+	depends on (ARCH_STM32 && OF) || COMPILE_TEST
+	select REGMAP
+	select REGMAP_MMIO
+	help
+	  Select this option to enable the  driver for STMicroelectronics
+	  STM32 digital filter for sigma delta converter.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called stm32-dfsdm-core.
+
 config STX104
 	tristate "Apex Embedded Systems STX104 driver"
 	depends on PC104 && X86 && ISA_BUS_API
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d800325..b52d0a0 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
 obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
+obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
 obj-$(CONFIG_TI_ADC084S021) += ti-adc084s021.o
diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
new file mode 100644
index 0000000..7242741
--- /dev/null
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file is part the core part STM32 DFSDM driver
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com> for STMicroelectronics.
+ */
+
+#include <linux/clk.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "stm32-dfsdm.h"
+
+struct stm32_dfsdm_dev_data {
+	unsigned int num_filters;
+	unsigned int num_channels;
+	const struct regmap_config *regmap_cfg;
+};
+
+#define STM32H7_DFSDM_NUM_FILTERS	4
+#define STM32H7_DFSDM_NUM_CHANNELS	8
+
+static bool stm32_dfsdm_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if (reg < DFSDM_FILTER_BASE_ADR)
+		return false;
+
+	/*
+	 * Mask is done on register to avoid to list registers of all
+	 * filter instances.
+	 */
+	switch (reg & DFSDM_FILTER_REG_MASK) {
+	case DFSDM_CR1(0) & DFSDM_FILTER_REG_MASK:
+	case DFSDM_ISR(0) & DFSDM_FILTER_REG_MASK:
+	case DFSDM_JDATAR(0) & DFSDM_FILTER_REG_MASK:
+	case DFSDM_RDATAR(0) & DFSDM_FILTER_REG_MASK:
+		return true;
+	}
+
+	return false;
+}
+
+static const struct regmap_config stm32h7_dfsdm_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = sizeof(u32),
+	.max_register = 0x2B8,
+	.volatile_reg = stm32_dfsdm_volatile_reg,
+	.fast_io = true,
+};
+
+static const struct stm32_dfsdm_dev_data stm32h7_dfsdm_data = {
+	.num_filters = STM32H7_DFSDM_NUM_FILTERS,
+	.num_channels = STM32H7_DFSDM_NUM_CHANNELS,
+	.regmap_cfg = &stm32h7_dfsdm_regmap_cfg,
+};
+
+struct dfsdm_priv {
+	struct platform_device *pdev; /* platform device */
+
+	struct stm32_dfsdm dfsdm; /* common data exported for all instances */
+
+	unsigned int spi_clk_out_div; /* SPI clkout divider value */
+	atomic_t n_active_ch;	/* number of current active channels */
+
+	struct clk *clk; /* DFSDM clock */
+	struct clk *aclk; /* audio clock */
+};
+
+/**
+ * stm32_dfsdm_start_dfsdm - start global dfsdm interface.
+ *
+ * Enable interface if n_active_ch is not null.
+ * @dfsdm: Handle used to retrieve dfsdm context.
+ */
+int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
+{
+	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
+	struct device *dev = &priv->pdev->dev;
+	unsigned int clk_div = priv->spi_clk_out_div;
+	int ret;
+
+	if (atomic_inc_return(&priv->n_active_ch) == 1) {
+		ret = clk_prepare_enable(priv->clk);
+		if (ret < 0) {
+			dev_err(dev, "Failed to start clock\n");
+			goto error_ret;
+		}
+		if (priv->aclk) {
+			ret = clk_prepare_enable(priv->aclk);
+			if (ret < 0) {
+				dev_err(dev, "Failed to start audio clock\n");
+				goto disable_clk;
+			}
+		}
+
+		/* Output the SPI CLKOUT (if clk_div == 0 clock if OFF) */
+		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
+					 DFSDM_CHCFGR1_CKOUTDIV_MASK,
+					 DFSDM_CHCFGR1_CKOUTDIV(clk_div));
+		if (ret < 0)
+			goto disable_aclk;
+
+		/* Global enable of DFSDM interface */
+		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
+					 DFSDM_CHCFGR1_DFSDMEN_MASK,
+					 DFSDM_CHCFGR1_DFSDMEN(1));
+		if (ret < 0)
+			goto disable_aclk;
+	}
+
+	dev_dbg(dev, "%s: n_active_ch %d\n", __func__,
+		atomic_read(&priv->n_active_ch));
+
+	return 0;
+
+disable_aclk:
+	clk_disable_unprepare(priv->aclk);
+disable_clk:
+	clk_disable_unprepare(priv->clk);
+
+error_ret:
+	atomic_dec(&priv->n_active_ch);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stm32_dfsdm_start_dfsdm);
+
+/**
+ * stm32_dfsdm_stop_dfsdm - stop global DFSDM interface.
+ *
+ * Disable interface if n_active_ch is null
+ * @dfsdm: Handle used to retrieve dfsdm context.
+ */
+int stm32_dfsdm_stop_dfsdm(struct stm32_dfsdm *dfsdm)
+{
+	struct dfsdm_priv *priv = container_of(dfsdm, struct dfsdm_priv, dfsdm);
+	int ret;
+
+	if (atomic_dec_and_test(&priv->n_active_ch)) {
+		/* Global disable of DFSDM interface */
+		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
+					 DFSDM_CHCFGR1_DFSDMEN_MASK,
+					 DFSDM_CHCFGR1_DFSDMEN(0));
+		if (ret < 0)
+			return ret;
+
+		/* Stop SPI CLKOUT */
+		ret = regmap_update_bits(dfsdm->regmap, DFSDM_CHCFGR1(0),
+					 DFSDM_CHCFGR1_CKOUTDIV_MASK,
+					 DFSDM_CHCFGR1_CKOUTDIV(0));
+		if (ret < 0)
+			return ret;
+
+		clk_disable_unprepare(priv->clk);
+		if (priv->aclk)
+			clk_disable_unprepare(priv->aclk);
+	}
+	dev_dbg(&priv->pdev->dev, "%s: n_active_ch %d\n", __func__,
+		atomic_read(&priv->n_active_ch));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_dfsdm_stop_dfsdm);
+
+static int stm32_dfsdm_parse_of(struct platform_device *pdev,
+				struct dfsdm_priv *priv)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct resource *res;
+	unsigned long clk_freq;
+	unsigned int spi_freq, rem;
+	int ret;
+
+	if (!node)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get memory resource\n");
+		return -ENODEV;
+	}
+	priv->dfsdm.phys_base = res->start;
+	priv->dfsdm.base = devm_ioremap_resource(&pdev->dev, res);
+
+	/*
+	 * "dfsdm" clock is mandatory for DFSDM peripheral clocking.
+	 * "dfsdm" or "audio" clocks can be used as source clock for
+	 * the SPI clock out signal and internal processing, depending
+	 * on use case.
+	 */
+	priv->clk = devm_clk_get(&pdev->dev, "dfsdm");
+	if (IS_ERR(priv->clk)) {
+		dev_err(&pdev->dev, "No stm32_dfsdm_clk clock found\n");
+		return -EINVAL;
+	}
+
+	priv->aclk = devm_clk_get(&pdev->dev, "audio");
+	if (IS_ERR(priv->aclk))
+		priv->aclk = NULL;
+
+	if (priv->aclk)
+		clk_freq = clk_get_rate(priv->aclk);
+	else
+		clk_freq = clk_get_rate(priv->clk);
+
+	/* SPI clock out frequency */
+	ret = of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
+				   &spi_freq);
+	if (ret < 0) {
+		/* No SPI master mode */
+		return 0;
+	}
+
+	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem) - 1;
+	priv->dfsdm.spi_master_freq = spi_freq;
+
+	if (rem) {
+		dev_warn(&pdev->dev, "SPI clock not accurate\n");
+		dev_warn(&pdev->dev, "%ld = %d * %d + %d\n",
+			 clk_freq, spi_freq, priv->spi_clk_out_div + 1, rem);
+	}
+
+	return 0;
+};
+
+static const struct of_device_id stm32_dfsdm_of_match[] = {
+	{
+		.compatible = "st,stm32h7-dfsdm",
+		.data = &stm32h7_dfsdm_data,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
+
+static int stm32_dfsdm_probe(struct platform_device *pdev)
+{
+	struct dfsdm_priv *priv;
+	struct device_node *pnode = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+	const struct stm32_dfsdm_dev_data *dev_data;
+	struct stm32_dfsdm *dfsdm;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = pdev;
+
+	of_id = of_match_node(stm32_dfsdm_of_match, pnode);
+	if (!of_id->data) {
+		dev_err(&pdev->dev, "Data associated to device is missing\n");
+		return -EINVAL;
+	}
+
+	dev_data = (const struct stm32_dfsdm_dev_data *)of_id->data;
+	dfsdm = &priv->dfsdm;
+	dfsdm->fl_list = devm_kcalloc(&pdev->dev, dev_data->num_filters,
+				      sizeof(*dfsdm->fl_list), GFP_KERNEL);
+	if (!dfsdm->fl_list)
+		return -ENOMEM;
+
+	dfsdm->num_fls = dev_data->num_filters;
+	dfsdm->ch_list = devm_kcalloc(&pdev->dev, dev_data->num_channels,
+				      sizeof(*dfsdm->ch_list),
+				      GFP_KERNEL);
+	if (!dfsdm->ch_list)
+		return -ENOMEM;
+	dfsdm->num_chs = dev_data->num_channels;
+
+	ret = stm32_dfsdm_parse_of(pdev, priv);
+	if (ret < 0)
+		return ret;
+
+	dfsdm->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "dfsdm",
+						  dfsdm->base,
+						  &stm32h7_dfsdm_regmap_cfg);
+	if (IS_ERR(dfsdm->regmap)) {
+		ret = PTR_ERR(dfsdm->regmap);
+		dev_err(&pdev->dev, "%s: Failed to allocate regmap: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, dfsdm);
+
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static struct platform_driver stm32_dfsdm_driver = {
+	.probe = stm32_dfsdm_probe,
+	.driver = {
+		.name = "stm32-dfsdm",
+		.of_match_table = stm32_dfsdm_of_match,
+	},
+};
+
+module_platform_driver(stm32_dfsdm_driver);
+
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics STM32 dfsdm driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/stm32-dfsdm.h b/drivers/iio/adc/stm32-dfsdm.h
new file mode 100644
index 0000000..8708394
--- /dev/null
+++ b/drivers/iio/adc/stm32-dfsdm.h
@@ -0,0 +1,310 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file is part of STM32 DFSDM driver
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author(s): Arnaud Pouliquen <arnaud.pouliquen@st.com>.
+ */
+
+#ifndef MDF_STM32_DFSDM__H
+#define MDF_STM32_DFSDM__H
+
+#include <linux/bitfield.h>
+
+/*
+ * STM32 DFSDM - global register map
+ * ________________________________________________________
+ * | Offset |                 Registers block             |
+ * --------------------------------------------------------
+ * | 0x000  |      CHANNEL 0 + COMMON CHANNEL FIELDS      |
+ * --------------------------------------------------------
+ * | 0x020  |                CHANNEL 1                    |
+ * --------------------------------------------------------
+ * | ...    |                .....                        |
+ * --------------------------------------------------------
+ * | 0x0E0  |                CHANNEL 7                    |
+ * --------------------------------------------------------
+ * | 0x100  |      FILTER  0 + COMMON  FILTER FIELDs      |
+ * --------------------------------------------------------
+ * | 0x200  |                FILTER  1                    |
+ * --------------------------------------------------------
+ * | 0x300  |                FILTER  2                    |
+ * --------------------------------------------------------
+ * | 0x400  |                FILTER  3                    |
+ * --------------------------------------------------------
+ */
+
+/*
+ * Channels register definitions
+ */
+#define DFSDM_CHCFGR1(y)  ((y) * 0x20 + 0x00)
+#define DFSDM_CHCFGR2(y)  ((y) * 0x20 + 0x04)
+#define DFSDM_AWSCDR(y)   ((y) * 0x20 + 0x08)
+#define DFSDM_CHWDATR(y)  ((y) * 0x20 + 0x0C)
+#define DFSDM_CHDATINR(y) ((y) * 0x20 + 0x10)
+
+/* CHCFGR1: Channel configuration register 1 */
+#define DFSDM_CHCFGR1_SITP_MASK     GENMASK(1, 0)
+#define DFSDM_CHCFGR1_SITP(v)       FIELD_PREP(DFSDM_CHCFGR1_SITP_MASK, v)
+#define DFSDM_CHCFGR1_SPICKSEL_MASK GENMASK(3, 2)
+#define DFSDM_CHCFGR1_SPICKSEL(v)   FIELD_PREP(DFSDM_CHCFGR1_SPICKSEL_MASK, v)
+#define DFSDM_CHCFGR1_SCDEN_MASK    BIT(5)
+#define DFSDM_CHCFGR1_SCDEN(v)      FIELD_PREP(DFSDM_CHCFGR1_SCDEN_MASK, v)
+#define DFSDM_CHCFGR1_CKABEN_MASK   BIT(6)
+#define DFSDM_CHCFGR1_CKABEN(v)     FIELD_PREP(DFSDM_CHCFGR1_CKABEN_MASK, v)
+#define DFSDM_CHCFGR1_CHEN_MASK     BIT(7)
+#define DFSDM_CHCFGR1_CHEN(v)       FIELD_PREP(DFSDM_CHCFGR1_CHEN_MASK, v)
+#define DFSDM_CHCFGR1_CHINSEL_MASK  BIT(8)
+#define DFSDM_CHCFGR1_CHINSEL(v)    FIELD_PREP(DFSDM_CHCFGR1_CHINSEL_MASK, v)
+#define DFSDM_CHCFGR1_DATMPX_MASK   GENMASK(13, 12)
+#define DFSDM_CHCFGR1_DATMPX(v)     FIELD_PREP(DFSDM_CHCFGR1_DATMPX_MASK, v)
+#define DFSDM_CHCFGR1_DATPACK_MASK  GENMASK(15, 14)
+#define DFSDM_CHCFGR1_DATPACK(v)    FIELD_PREP(DFSDM_CHCFGR1_DATPACK_MASK, v)
+#define DFSDM_CHCFGR1_CKOUTDIV_MASK GENMASK(23, 16)
+#define DFSDM_CHCFGR1_CKOUTDIV(v)   FIELD_PREP(DFSDM_CHCFGR1_CKOUTDIV_MASK, v)
+#define DFSDM_CHCFGR1_CKOUTSRC_MASK BIT(30)
+#define DFSDM_CHCFGR1_CKOUTSRC(v)   FIELD_PREP(DFSDM_CHCFGR1_CKOUTSRC_MASK, v)
+#define DFSDM_CHCFGR1_DFSDMEN_MASK  BIT(31)
+#define DFSDM_CHCFGR1_DFSDMEN(v)    FIELD_PREP(DFSDM_CHCFGR1_DFSDMEN_MASK, v)
+
+/* CHCFGR2: Channel configuration register 2 */
+#define DFSDM_CHCFGR2_DTRBS_MASK    GENMASK(7, 3)
+#define DFSDM_CHCFGR2_DTRBS(v)      FIELD_PREP(DFSDM_CHCFGR2_DTRBS_MASK, v)
+#define DFSDM_CHCFGR2_OFFSET_MASK   GENMASK(31, 8)
+#define DFSDM_CHCFGR2_OFFSET(v)     FIELD_PREP(DFSDM_CHCFGR2_OFFSET_MASK, v)
+
+/* AWSCDR: Channel analog watchdog and short circuit detector */
+#define DFSDM_AWSCDR_SCDT_MASK    GENMASK(7, 0)
+#define DFSDM_AWSCDR_SCDT(v)      FIELD_PREP(DFSDM_AWSCDR_SCDT_MASK, v)
+#define DFSDM_AWSCDR_BKSCD_MASK   GENMASK(15, 12)
+#define DFSDM_AWSCDR_BKSCD(v)	  FIELD_PREP(DFSDM_AWSCDR_BKSCD_MASK, v)
+#define DFSDM_AWSCDR_AWFOSR_MASK  GENMASK(20, 16)
+#define DFSDM_AWSCDR_AWFOSR(v)    FIELD_PREP(DFSDM_AWSCDR_AWFOSR_MASK, v)
+#define DFSDM_AWSCDR_AWFORD_MASK  GENMASK(23, 22)
+#define DFSDM_AWSCDR_AWFORD(v)    FIELD_PREP(DFSDM_AWSCDR_AWFORD_MASK, v)
+
+/*
+ * Filters register definitions
+ */
+#define DFSDM_FILTER_BASE_ADR		0x100
+#define DFSDM_FILTER_REG_MASK		0x7F
+#define DFSDM_FILTER_X_BASE_ADR(x)	((x) * 0x80 + DFSDM_FILTER_BASE_ADR)
+
+#define DFSDM_CR1(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x00)
+#define DFSDM_CR2(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x04)
+#define DFSDM_ISR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x08)
+#define DFSDM_ICR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x0C)
+#define DFSDM_JCHGR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x10)
+#define DFSDM_FCR(x)     (DFSDM_FILTER_X_BASE_ADR(x)  + 0x14)
+#define DFSDM_JDATAR(x)  (DFSDM_FILTER_X_BASE_ADR(x)  + 0x18)
+#define DFSDM_RDATAR(x)  (DFSDM_FILTER_X_BASE_ADR(x)  + 0x1C)
+#define DFSDM_AWHTR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x20)
+#define DFSDM_AWLTR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x24)
+#define DFSDM_AWSR(x)    (DFSDM_FILTER_X_BASE_ADR(x)  + 0x28)
+#define DFSDM_AWCFR(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x2C)
+#define DFSDM_EXMAX(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x30)
+#define DFSDM_EXMIN(x)   (DFSDM_FILTER_X_BASE_ADR(x)  + 0x34)
+#define DFSDM_CNVTIMR(x) (DFSDM_FILTER_X_BASE_ADR(x)  + 0x38)
+
+/* CR1 Control register 1 */
+#define DFSDM_CR1_DFEN_MASK	BIT(0)
+#define DFSDM_CR1_DFEN(v)	FIELD_PREP(DFSDM_CR1_DFEN_MASK, v)
+#define DFSDM_CR1_JSWSTART_MASK	BIT(1)
+#define DFSDM_CR1_JSWSTART(v)	FIELD_PREP(DFSDM_CR1_JSWSTART_MASK, v)
+#define DFSDM_CR1_JSYNC_MASK	BIT(3)
+#define DFSDM_CR1_JSYNC(v)	FIELD_PREP(DFSDM_CR1_JSYNC_MASK, v)
+#define DFSDM_CR1_JSCAN_MASK	BIT(4)
+#define DFSDM_CR1_JSCAN(v)	FIELD_PREP(DFSDM_CR1_JSCAN_MASK, v)
+#define DFSDM_CR1_JDMAEN_MASK	BIT(5)
+#define DFSDM_CR1_JDMAEN(v)	FIELD_PREP(DFSDM_CR1_JDMAEN_MASK, v)
+#define DFSDM_CR1_JEXTSEL_MASK	GENMASK(12, 8)
+#define DFSDM_CR1_JEXTSEL(v)	FIELD_PREP(DFSDM_CR1_JEXTSEL_MASK, v)
+#define DFSDM_CR1_JEXTEN_MASK	GENMASK(14, 13)
+#define DFSDM_CR1_JEXTEN(v)	FIELD_PREP(DFSDM_CR1_JEXTEN_MASK, v)
+#define DFSDM_CR1_RSWSTART_MASK	BIT(17)
+#define DFSDM_CR1_RSWSTART(v)	FIELD_PREP(DFSDM_CR1_RSWSTART_MASK, v)
+#define DFSDM_CR1_RCONT_MASK	BIT(18)
+#define DFSDM_CR1_RCONT(v)	FIELD_PREP(DFSDM_CR1_RCONT_MASK, v)
+#define DFSDM_CR1_RSYNC_MASK	BIT(19)
+#define DFSDM_CR1_RSYNC(v)	FIELD_PREP(DFSDM_CR1_RSYNC_MASK, v)
+#define DFSDM_CR1_RDMAEN_MASK	BIT(21)
+#define DFSDM_CR1_RDMAEN(v)	FIELD_PREP(DFSDM_CR1_RDMAEN_MASK, v)
+#define DFSDM_CR1_RCH_MASK	GENMASK(26, 24)
+#define DFSDM_CR1_RCH(v)	FIELD_PREP(DFSDM_CR1_RCH_MASK, v)
+#define DFSDM_CR1_FAST_MASK	BIT(29)
+#define DFSDM_CR1_FAST(v)	FIELD_PREP(DFSDM_CR1_FAST_MASK, v)
+#define DFSDM_CR1_AWFSEL_MASK	BIT(30)
+#define DFSDM_CR1_AWFSEL(v)	FIELD_PREP(DFSDM_CR1_AWFSEL_MASK, v)
+
+/* CR2: Control register 2 */
+#define DFSDM_CR2_IE_MASK	GENMASK(6, 0)
+#define DFSDM_CR2_IE(v)		FIELD_PREP(DFSDM_CR2_IE_MASK, v)
+#define DFSDM_CR2_JEOCIE_MASK	BIT(0)
+#define DFSDM_CR2_JEOCIE(v)	FIELD_PREP(DFSDM_CR2_JEOCIE_MASK, v)
+#define DFSDM_CR2_REOCIE_MASK	BIT(1)
+#define DFSDM_CR2_REOCIE(v)	FIELD_PREP(DFSDM_CR2_REOCIE_MASK, v)
+#define DFSDM_CR2_JOVRIE_MASK	BIT(2)
+#define DFSDM_CR2_JOVRIE(v)	FIELD_PREP(DFSDM_CR2_JOVRIE_MASK, v)
+#define DFSDM_CR2_ROVRIE_MASK	BIT(3)
+#define DFSDM_CR2_ROVRIE(v)	FIELD_PREP(DFSDM_CR2_ROVRIE_MASK, v)
+#define DFSDM_CR2_AWDIE_MASK	BIT(4)
+#define DFSDM_CR2_AWDIE(v)	FIELD_PREP(DFSDM_CR2_AWDIE_MASK, v)
+#define DFSDM_CR2_SCDIE_MASK	BIT(5)
+#define DFSDM_CR2_SCDIE(v)	FIELD_PREP(DFSDM_CR2_SCDIE_MASK, v)
+#define DFSDM_CR2_CKABIE_MASK	BIT(6)
+#define DFSDM_CR2_CKABIE(v)	FIELD_PREP(DFSDM_CR2_CKABIE_MASK, v)
+#define DFSDM_CR2_EXCH_MASK	GENMASK(15, 8)
+#define DFSDM_CR2_EXCH(v)	FIELD_PREP(DFSDM_CR2_EXCH_MASK, v)
+#define DFSDM_CR2_AWDCH_MASK	GENMASK(23, 16)
+#define DFSDM_CR2_AWDCH(v)	FIELD_PREP(DFSDM_CR2_AWDCH_MASK, v)
+
+/* ISR: Interrupt status register */
+#define DFSDM_ISR_JEOCF_MASK	BIT(0)
+#define DFSDM_ISR_JEOCF(v)	FIELD_PREP(DFSDM_ISR_JEOCF_MASK, v)
+#define DFSDM_ISR_REOCF_MASK	BIT(1)
+#define DFSDM_ISR_REOCF(v)	FIELD_PREP(DFSDM_ISR_REOCF_MASK, v)
+#define DFSDM_ISR_JOVRF_MASK	BIT(2)
+#define DFSDM_ISR_JOVRF(v)	FIELD_PREP(DFSDM_ISR_JOVRF_MASK, v)
+#define DFSDM_ISR_ROVRF_MASK	BIT(3)
+#define DFSDM_ISR_ROVRF(v)	FIELD_PREP(DFSDM_ISR_ROVRF_MASK, v)
+#define DFSDM_ISR_AWDF_MASK	BIT(4)
+#define DFSDM_ISR_AWDF(v)	FIELD_PREP(DFSDM_ISR_AWDF_MASK, v)
+#define DFSDM_ISR_JCIP_MASK	BIT(13)
+#define DFSDM_ISR_JCIP(v)	FIELD_PREP(DFSDM_ISR_JCIP_MASK, v)
+#define DFSDM_ISR_RCIP_MASK	BIT(14)
+#define DFSDM_ISR_RCIP(v)	FIELD_PREP(DFSDM_ISR_RCIP, v)
+#define DFSDM_ISR_CKABF_MASK	GENMASK(23, 16)
+#define DFSDM_ISR_CKABF(v)	FIELD_PREP(DFSDM_ISR_CKABF_MASK, v)
+#define DFSDM_ISR_SCDF_MASK	GENMASK(31, 24)
+#define DFSDM_ISR_SCDF(v)	FIELD_PREP(DFSDM_ISR_SCDF_MASK, v)
+
+/* ICR: Interrupt flag clear register */
+#define DFSDM_ICR_CLRJOVRF_MASK	      BIT(2)
+#define DFSDM_ICR_CLRJOVRF(v)	      FIELD_PREP(DFSDM_ICR_CLRJOVRF_MASK, v)
+#define DFSDM_ICR_CLRROVRF_MASK	      BIT(3)
+#define DFSDM_ICR_CLRROVRF(v)	      FIELD_PREP(DFSDM_ICR_CLRROVRF_MASK, v)
+#define DFSDM_ICR_CLRCKABF_MASK	      GENMASK(23, 16)
+#define DFSDM_ICR_CLRCKABF(v)	      FIELD_PREP(DFSDM_ICR_CLRCKABF_MASK, v)
+#define DFSDM_ICR_CLRCKABF_CH_MASK(y) BIT(16 + (y))
+#define DFSDM_ICR_CLRCKABF_CH(v, y)   \
+			   (((v) << (16 + (y))) & DFSDM_ICR_CLRCKABF_CH_MASK(y))
+#define DFSDM_ICR_CLRSCDF_MASK	      GENMASK(31, 24)
+#define DFSDM_ICR_CLRSCDF(v)	      FIELD_PREP(DFSDM_ICR_CLRSCDF_MASK, v)
+#define DFSDM_ICR_CLRSCDF_CH_MASK(y)  BIT(24 + (y))
+#define DFSDM_ICR_CLRSCDF_CH(v, y)    \
+			       (((v) << (24 + (y))) & DFSDM_ICR_CLRSCDF_MASK(y))
+
+/* FCR: Filter control register */
+#define DFSDM_FCR_IOSR_MASK	GENMASK(7, 0)
+#define DFSDM_FCR_IOSR(v)	FIELD_PREP(DFSDM_FCR_IOSR_MASK, v)
+#define DFSDM_FCR_FOSR_MASK	GENMASK(25, 16)
+#define DFSDM_FCR_FOSR(v)	FIELD_PREP(DFSDM_FCR_FOSR_MASK, v)
+#define DFSDM_FCR_FORD_MASK	GENMASK(31, 29)
+#define DFSDM_FCR_FORD(v)	FIELD_PREP(DFSDM_FCR_FORD_MASK, v)
+
+/* RDATAR: Filter data register for regular channel */
+#define DFSDM_DATAR_CH_MASK	GENMASK(2, 0)
+#define DFSDM_DATAR_DATA_OFFSET 8
+#define DFSDM_DATAR_DATA_MASK	GENMASK(31, DFSDM_DATAR_DATA_OFFSET)
+
+/* AWLTR: Filter analog watchdog low threshold register */
+#define DFSDM_AWLTR_BKAWL_MASK	GENMASK(3, 0)
+#define DFSDM_AWLTR_BKAWL(v)	FIELD_PREP(DFSDM_AWLTR_BKAWL_MASK, v)
+#define DFSDM_AWLTR_AWLT_MASK	GENMASK(31, 8)
+#define DFSDM_AWLTR_AWLT(v)	FIELD_PREP(DFSDM_AWLTR_AWLT_MASK, v)
+
+/* AWHTR: Filter analog watchdog low threshold register */
+#define DFSDM_AWHTR_BKAWH_MASK	GENMASK(3, 0)
+#define DFSDM_AWHTR_BKAWH(v)	FIELD_PREP(DFSDM_AWHTR_BKAWH_MASK, v)
+#define DFSDM_AWHTR_AWHT_MASK	GENMASK(31, 8)
+#define DFSDM_AWHTR_AWHT(v)	FIELD_PREP(DFSDM_AWHTR_AWHT_MASK, v)
+
+/* AWSR: Filter watchdog status register */
+#define DFSDM_AWSR_AWLTF_MASK	GENMASK(7, 0)
+#define DFSDM_AWSR_AWLTF(v)	FIELD_PREP(DFSDM_AWSR_AWLTF_MASK, v)
+#define DFSDM_AWSR_AWHTF_MASK	GENMASK(15, 8)
+#define DFSDM_AWSR_AWHTF(v)	FIELD_PREP(DFSDM_AWSR_AWHTF_MASK, v)
+
+/* AWCFR: Filter watchdog status register */
+#define DFSDM_AWCFR_AWLTF_MASK	GENMASK(7, 0)
+#define DFSDM_AWCFR_AWLTF(v)	FIELD_PREP(DFSDM_AWCFR_AWLTF_MASK, v)
+#define DFSDM_AWCFR_AWHTF_MASK	GENMASK(15, 8)
+#define DFSDM_AWCFR_AWHTF(v)	FIELD_PREP(DFSDM_AWCFR_AWHTF_MASK, v)
+
+/* DFSDM filter order  */
+enum stm32_dfsdm_sinc_order {
+	DFSDM_FASTSINC_ORDER, /* FastSinc filter type */
+	DFSDM_SINC1_ORDER,    /* Sinc 1 filter type */
+	DFSDM_SINC2_ORDER,    /* Sinc 2 filter type */
+	DFSDM_SINC3_ORDER,    /* Sinc 3 filter type */
+	DFSDM_SINC4_ORDER,    /* Sinc 4 filter type (N.A. for watchdog) */
+	DFSDM_SINC5_ORDER,    /* Sinc 5 filter type (N.A. for watchdog) */
+	DFSDM_NB_SINC_ORDER,
+};
+
+/**
+ * struct stm32_dfsdm_filter - structure relative to stm32 FDSDM filter
+ * @iosr: integrator oversampling
+ * @fosr: filter oversampling
+ * @ford: filter order
+ * @res: output sample resolution
+ * @sync_mode: filter synchronized with filter 0
+ * @fast: filter fast mode
+ */
+struct stm32_dfsdm_filter {
+	unsigned int iosr;
+	unsigned int fosr;
+	enum stm32_dfsdm_sinc_order ford;
+	u64 res;
+	unsigned int sync_mode;
+	unsigned int fast;
+};
+
+/**
+ * struct stm32_dfsdm_channel - structure relative to stm32 FDSDM channel
+ * @id: id of the channel
+ * @type: interface type linked to stm32_dfsdm_chan_type
+ * @src: interface type linked to stm32_dfsdm_chan_src
+ * @alt_si: alternative serial input interface
+ */
+struct stm32_dfsdm_channel {
+	unsigned int id;
+	unsigned int type;
+	unsigned int src;
+	unsigned int alt_si;
+};
+
+/**
+ * struct stm32_dfsdm - stm32 FDSDM driver common data (for all instances)
+ * @base:	control registers base cpu addr
+ * @phys_base:	DFSDM IP register physical address
+ * @regmap:	regmap for register read/write
+ * @fl_list:	filter resources list
+ * @num_fls:	number of filter resources available
+ * @ch_list:	channel resources list
+ * @num_chs:	number of channel resources available
+ * @spi_master_freq: SPI clock out frequency
+ */
+struct stm32_dfsdm {
+	void __iomem	*base;
+	phys_addr_t	phys_base;
+	struct regmap *regmap;
+	struct stm32_dfsdm_filter *fl_list;
+	unsigned int num_fls;
+	struct stm32_dfsdm_channel *ch_list;
+	unsigned int num_chs;
+	unsigned int spi_master_freq;
+};
+
+/* DFSDM channel serial spi clock source */
+enum stm32_dfsdm_spi_clk_src {
+	DFSDM_CHANNEL_SPI_CLOCK_EXTERNAL,
+	DFSDM_CHANNEL_SPI_CLOCK_INTERNAL,
+	DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_FALLING,
+	DFSDM_CHANNEL_SPI_CLOCK_INTERNAL_DIV2_RISING
+};
+
+int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm);
+int stm32_dfsdm_stop_dfsdm(struct stm32_dfsdm *dfsdm);
+
+#endif
-- 
2.7.4
