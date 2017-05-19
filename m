Return-Path: <SRS0=POww=4Z=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 5/5] iio: adc: stm32: add support for STM32H7
Date: Fri, 19 May 2017 14:45:28 +0200
Message-ID: <1495197928-1439-6-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1495197928-1439-1-git-send-email-fabrice.gasnier@st.com>
References: <1495197928-1439-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add support for STM32H7 Analog to Digital Converter. It has up
to 20 external channels, resolution ranges from 8 to 16bits.
Either bus or asynchronous adc clock may be used.

Add registers & bitfields definition. Also add new configuration
options to enter/exit powerdown and perform self-calibration.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc-core.c | 171 +++++++++++-
 drivers/iio/adc/stm32-adc-core.h |   2 +
 drivers/iio/adc/stm32-adc.c      | 552 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 721 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index c5d292c..e09233b 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -49,6 +49,23 @@
 /* STM32 F4 maximum analog clock rate (from datasheet) */
 #define STM32F4_ADC_MAX_CLK_RATE	36000000
 
+/* STM32H7 - common registers for all ADC instances */
+#define STM32H7_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
+#define STM32H7_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x08)
+
+/* STM32H7_ADC_CSR - bit fields */
+#define STM32H7_EOC_SLV			BIT(18)
+#define STM32H7_EOC_MST			BIT(2)
+
+/* STM32H7_ADC_CCR - bit fields */
+#define STM32H7_PRESC_SHIFT		18
+#define STM32H7_PRESC_MASK		GENMASK(21, 18)
+#define STM32H7_CKMODE_SHIFT		16
+#define STM32H7_CKMODE_MASK		GENMASK(17, 16)
+
+/* STM32 H7 maximum analog clock rate (from datasheet) */
+#define STM32H7_ADC_MAX_CLK_RATE	72000000
+
 /**
  * stm32_adc_common_regs - stm32 common registers, compatible dependent data
  * @csr:	common status register offset
@@ -80,6 +97,7 @@ struct stm32_adc_priv_cfg {
  * @irq:		irq for ADC block
  * @domain:		irq domain reference
  * @aclk:		clock reference for the analog circuitry
+ * @bclk:		bus clock common for all ADCs, depends on part used
  * @vref:		regulator reference
  * @cfg:		compatible configuration data
  * @common:		common data for all ADC instances
@@ -88,6 +106,7 @@ struct stm32_adc_priv {
 	int				irq;
 	struct irq_domain		*domain;
 	struct clk			*aclk;
+	struct clk			*bclk;
 	struct regulator		*vref;
 	const struct stm32_adc_priv_cfg	*cfg;
 	struct stm32_adc_common		common;
@@ -129,6 +148,7 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	priv->common.rate = rate;
 	val = readl_relaxed(priv->common.base + STM32F4_ADC_CCR);
 	val &= ~STM32F4_ADC_ADCPRE_MASK;
 	val |= i << STM32F4_ADC_ADCPRE_SHIFT;
@@ -140,6 +160,111 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
 	return 0;
 }
 
+/**
+ * struct stm32h7_adc_ck_spec - specification for stm32h7 adc clock
+ * @ckmode: ADC clock mode, Async or sync with prescaler.
+ * @presc: prescaler bitfield for async clock mode
+ * @div: prescaler division ratio
+ */
+struct stm32h7_adc_ck_spec {
+	u32 ckmode;
+	u32 presc;
+	int div;
+};
+
+const struct stm32h7_adc_ck_spec stm32h7_adc_ckmodes_spec[] = {
+	/* 00: CK_ADC[1..3]: Asynchronous clock modes */
+	{ 0, 0, 1 },
+	{ 0, 1, 2 },
+	{ 0, 2, 4 },
+	{ 0, 3, 6 },
+	{ 0, 4, 8 },
+	{ 0, 5, 10 },
+	{ 0, 6, 12 },
+	{ 0, 7, 16 },
+	{ 0, 8, 32 },
+	{ 0, 9, 64 },
+	{ 0, 10, 128 },
+	{ 0, 11, 256 },
+	/* HCLK used: Synchronous clock modes (1, 2 or 4 prescaler) */
+	{ 1, 0, 1 },
+	{ 2, 0, 2 },
+	{ 3, 0, 4 },
+};
+
+static int stm32h7_adc_clk_sel(struct platform_device *pdev,
+			       struct stm32_adc_priv *priv)
+{
+	u32 ckmode, presc, val;
+	unsigned long rate;
+	int i, div;
+
+	/* stm32h7 bus clock is common for all ADC instances (mandatory) */
+	if (!priv->bclk) {
+		dev_err(&pdev->dev, "No 'bus' clock found\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * stm32h7 can use either 'bus' or 'adc' clock for analog circuitry.
+	 * So, choice is to have bus clock mandatory and adc clock optional.
+	 * If optional 'adc' clock has been found, then try to use it first.
+	 */
+	if (priv->aclk) {
+		/*
+		 * Asynchronous clock modes (e.g. ckmode == 0)
+		 * From spec: PLL output musn't exceed max rate
+		 */
+		rate = clk_get_rate(priv->aclk);
+
+		for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
+			ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
+			presc = stm32h7_adc_ckmodes_spec[i].presc;
+			div = stm32h7_adc_ckmodes_spec[i].div;
+
+			if (ckmode)
+				continue;
+
+			if ((rate / div) <= STM32H7_ADC_MAX_CLK_RATE)
+				goto out;
+		}
+	}
+
+	/* Synchronous clock modes (e.g. ckmode is 1, 2 or 3) */
+	rate = clk_get_rate(priv->bclk);
+
+	for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
+		ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
+		presc = stm32h7_adc_ckmodes_spec[i].presc;
+		div = stm32h7_adc_ckmodes_spec[i].div;
+
+		if (!ckmode)
+			continue;
+
+		if ((rate / div) <= STM32H7_ADC_MAX_CLK_RATE)
+			goto out;
+	}
+
+	dev_err(&pdev->dev, "adc clk selection failed\n");
+	return -EINVAL;
+
+out:
+	/* rate used later by each ADC instance to control BOOST mode */
+	priv->common.rate = rate;
+
+	/* Set common clock mode and prescaler */
+	val = readl_relaxed(priv->common.base + STM32H7_ADC_CCR);
+	val &= ~(STM32H7_CKMODE_MASK | STM32H7_PRESC_MASK);
+	val |= ckmode << STM32H7_CKMODE_SHIFT;
+	val |= presc << STM32H7_PRESC_SHIFT;
+	writel_relaxed(val, priv->common.base + STM32H7_ADC_CCR);
+
+	dev_dbg(&pdev->dev, "Using %s clock/%d source at %ld kHz\n",
+		ckmode ? "bus" : "adc", div, rate / (div * 1000));
+
+	return 0;
+}
+
 /* STM32F4 common registers definitions */
 static const struct stm32_adc_common_regs stm32f4_adc_common_regs = {
 	.csr = STM32F4_ADC_CSR,
@@ -148,6 +273,13 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
 	.eoc3_msk = STM32F4_EOC3,
 };
 
+/* STM32H7 common registers definitions */
+static const struct stm32_adc_common_regs stm32h7_adc_common_regs = {
+	.csr = STM32H7_ADC_CSR,
+	.eoc1_msk = STM32H7_EOC_MST,
+	.eoc2_msk = STM32H7_EOC_SLV,
+};
+
 /* ADC common interrupt for all instances */
 static void stm32_adc_irq_handler(struct irq_desc *desc)
 {
@@ -291,13 +423,32 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		}
 	}
 
+	priv->bclk = devm_clk_get(&pdev->dev, "bus");
+	if (IS_ERR(priv->bclk)) {
+		ret = PTR_ERR(priv->bclk);
+		if (ret == -ENOENT) {
+			priv->bclk = NULL;
+		} else {
+			dev_err(&pdev->dev, "Can't get 'bus' clock\n");
+			goto err_aclk_disable;
+		}
+	}
+
+	if (priv->bclk) {
+		ret = clk_prepare_enable(priv->bclk);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "adc clk enable failed\n");
+			goto err_aclk_disable;
+		}
+	}
+
 	ret = priv->cfg->clk_sel(pdev, priv);
 	if (ret < 0)
-		goto err_clk_disable;
+		goto err_bclk_disable;
 
 	ret = stm32_adc_irq_probe(pdev, priv);
 	if (ret < 0)
-		goto err_clk_disable;
+		goto err_bclk_disable;
 
 	platform_set_drvdata(pdev, &priv->common);
 
@@ -312,7 +463,11 @@ static int stm32_adc_probe(struct platform_device *pdev)
 err_irq_remove:
 	stm32_adc_irq_remove(pdev, priv);
 
-err_clk_disable:
+err_bclk_disable:
+	if (priv->bclk)
+		clk_disable_unprepare(priv->bclk);
+
+err_aclk_disable:
 	if (priv->aclk)
 		clk_disable_unprepare(priv->aclk);
 
@@ -329,6 +484,8 @@ static int stm32_adc_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(&pdev->dev);
 	stm32_adc_irq_remove(pdev, priv);
+	if (priv->bclk)
+		clk_disable_unprepare(priv->bclk);
 	if (priv->aclk)
 		clk_disable_unprepare(priv->aclk);
 	regulator_disable(priv->vref);
@@ -341,11 +498,19 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	.clk_sel = stm32f4_adc_clk_sel,
 };
 
+static const struct stm32_adc_priv_cfg stm32h7_adc_priv_cfg = {
+	.regs = &stm32h7_adc_common_regs,
+	.clk_sel = stm32h7_adc_clk_sel,
+};
+
 static const struct of_device_id stm32_adc_of_match[] = {
 	{
 		.compatible = "st,stm32f4-adc-core",
 		.data = (void *)&stm32f4_adc_priv_cfg
 	}, {
+		.compatible = "st,stm32h7-adc-core",
+		.data = (void *)&stm32h7_adc_priv_cfg
+	}, {
 	},
 };
 MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index 2ec7abb..250ee95 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -43,11 +43,13 @@
  * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
  * @base:		control registers base cpu addr
  * @phys_base:		control registers base physical addr
+ * @rate:		clock rate used for analog circuitry
  * @vref_mv:		vref voltage (mv)
  */
 struct stm32_adc_common {
 	void __iomem			*base;
 	phys_addr_t			phys_base;
+	unsigned long			rate;
 	int				vref_mv;
 };
 
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index ad8fdb9..dba89c7 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -31,6 +31,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
@@ -77,6 +78,78 @@
 #define STM32F4_DMA			BIT(8)
 #define STM32F4_ADON			BIT(0)
 
+/* STM32H7 - Registers for each ADC instance */
+#define STM32H7_ADC_ISR			0x00
+#define STM32H7_ADC_IER			0x04
+#define STM32H7_ADC_CR			0x08
+#define STM32H7_ADC_CFGR		0x0C
+#define STM32H7_ADC_PCSEL		0x1C
+#define STM32H7_ADC_SQR1		0x30
+#define STM32H7_ADC_SQR2		0x34
+#define STM32H7_ADC_SQR3		0x38
+#define STM32H7_ADC_SQR4		0x3C
+#define STM32H7_ADC_DR			0x40
+#define STM32H7_ADC_CALFACT		0xC4
+#define STM32H7_ADC_CALFACT2		0xC8
+
+/* STM32H7_ADC_ISR - bit fields */
+#define STM32H7_EOC			BIT(2)
+#define STM32H7_ADRDY			BIT(0)
+
+/* STM32H7_ADC_IER - bit fields */
+#define STM32H7_EOCIE			STM32H7_EOC
+
+/* STM32H7_ADC_CR - bit fields */
+#define STM32H7_ADCAL			BIT(31)
+#define STM32H7_ADCALDIF		BIT(30)
+#define STM32H7_DEEPPWD			BIT(29)
+#define STM32H7_ADVREGEN		BIT(28)
+#define STM32H7_LINCALRDYW6		BIT(27)
+#define STM32H7_LINCALRDYW5		BIT(26)
+#define STM32H7_LINCALRDYW4		BIT(25)
+#define STM32H7_LINCALRDYW3		BIT(24)
+#define STM32H7_LINCALRDYW2		BIT(23)
+#define STM32H7_LINCALRDYW1		BIT(22)
+#define STM32H7_ADCALLIN		BIT(16)
+#define STM32H7_BOOST			BIT(8)
+#define STM32H7_ADSTP			BIT(4)
+#define STM32H7_ADSTART			BIT(2)
+#define STM32H7_ADDIS			BIT(1)
+#define STM32H7_ADEN			BIT(0)
+
+/* STM32H7_ADC_CFGR bit fields */
+#define STM32H7_EXTEN_SHIFT		10
+#define STM32H7_EXTEN_MASK		GENMASK(11, 10)
+#define STM32H7_EXTSEL_SHIFT		5
+#define STM32H7_EXTSEL_MASK		GENMASK(9, 5)
+#define STM32H7_RES_SHIFT		2
+#define STM32H7_RES_MASK		GENMASK(4, 2)
+#define STM32H7_DMNGT_SHIFT		0
+#define STM32H7_DMNGT_MASK		GENMASK(1, 0)
+
+enum stm32h7_adc_dmngt {
+	STM32H7_DMNGT_DR_ONLY,		/* Regular data in DR only */
+	STM32H7_DMNGT_DMA_ONESHOT,	/* DMA one shot mode */
+	STM32H7_DMNGT_DFSDM,		/* DFSDM mode */
+	STM32H7_DMNGT_DMA_CIRC,		/* DMA circular mode */
+};
+
+/* STM32H7_ADC_CALFACT - bit fields */
+#define STM32H7_CALFACT_D_SHIFT		16
+#define STM32H7_CALFACT_D_MASK		GENMASK(26, 16)
+#define STM32H7_CALFACT_S_SHIFT		0
+#define STM32H7_CALFACT_S_MASK		GENMASK(10, 0)
+
+/* STM32H7_ADC_CALFACT2 - bit fields */
+#define STM32H7_LINCALFACT_SHIFT	0
+#define STM32H7_LINCALFACT_MASK		GENMASK(29, 0)
+
+/* Number of linear calibration shadow registers / LINCALRDYW control bits */
+#define STM32H7_LINCALFACT_NUM		6
+
+/* BOOST bit must be set on STM32H7 when ADC clock is above 20MHz */
+#define STM32H7_BOOST_CLKRATE		20000000UL
+
 #define STM32_ADC_MAX_SQ		16	/* SQ1..SQ16 */
 #define STM32_ADC_TIMEOUT_US		100000
 #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
@@ -122,6 +195,18 @@ struct stm32_adc_trig_info {
 };
 
 /**
+ * struct stm32_adc_calib - optional adc calibration data
+ * @calfact_s: Calibration offset for single ended channels
+ * @calfact_d: Calibration offset in differential
+ * @lincalfact: Linearity calibration factor
+ */
+struct stm32_adc_calib {
+	u32			calfact_s;
+	u32			calfact_d;
+	u32			lincalfact[STM32H7_LINCALFACT_NUM];
+};
+
+/**
  * stm32_adc_regs - stm32 ADC misc registers & bitfield desc
  * @reg:		register offset
  * @mask:		bitfield mask
@@ -161,16 +246,22 @@ struct stm32_adc_regspec {
  * @adc_info:		per instance input channels definitions
  * @trigs:		external trigger sources
  * @clk_required:	clock is required
+ * @selfcalib:		optional routine for self-calibration
+ * @prepare:		optional prepare routine (power-up, enable)
  * @start_conv:		routine to start conversions
  * @stop_conv:		routine to stop conversions
+ * @unprepare:		optional unprepare routine (disable, power-down)
  */
 struct stm32_adc_cfg {
 	const struct stm32_adc_regspec	*regs;
 	const struct stm32_adc_info	*adc_info;
 	struct stm32_adc_trig_info	*trigs;
 	bool clk_required;
+	int (*selfcalib)(struct stm32_adc *);
+	int (*prepare)(struct stm32_adc *);
 	void (*start_conv)(struct stm32_adc *, bool dma);
 	void (*stop_conv)(struct stm32_adc *);
+	void (*unprepare)(struct stm32_adc *);
 };
 
 /**
@@ -191,6 +282,8 @@ struct stm32_adc_cfg {
  * @rx_buf:		dma rx buffer cpu address
  * @rx_dma_buf:		dma rx buffer bus address
  * @rx_buf_sz:		dma rx buffer size
+ * @pcsel		bitmask to preselect channels on some devices
+ * @cal:		optional calibration data on some devices
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -209,6 +302,8 @@ struct stm32_adc {
 	u8			*rx_buf;
 	dma_addr_t		rx_dma_buf;
 	unsigned int		rx_buf_sz;
+	u32			pcsel;
+	struct stm32_adc_calib	cal;
 };
 
 /**
@@ -269,6 +364,42 @@ struct stm32_adc_info {
 	.num_res = ARRAY_SIZE(stm32f4_adc_resolutions),
 };
 
+/* Input definitions for stm32h7 */
+static const struct stm32_adc_chan_spec stm32h7_adc_channels[] = {
+	{ IIO_VOLTAGE, 0, "in0" },
+	{ IIO_VOLTAGE, 1, "in1" },
+	{ IIO_VOLTAGE, 2, "in2" },
+	{ IIO_VOLTAGE, 3, "in3" },
+	{ IIO_VOLTAGE, 4, "in4" },
+	{ IIO_VOLTAGE, 5, "in5" },
+	{ IIO_VOLTAGE, 6, "in6" },
+	{ IIO_VOLTAGE, 7, "in7" },
+	{ IIO_VOLTAGE, 8, "in8" },
+	{ IIO_VOLTAGE, 9, "in9" },
+	{ IIO_VOLTAGE, 10, "in10" },
+	{ IIO_VOLTAGE, 11, "in11" },
+	{ IIO_VOLTAGE, 12, "in12" },
+	{ IIO_VOLTAGE, 13, "in13" },
+	{ IIO_VOLTAGE, 14, "in14" },
+	{ IIO_VOLTAGE, 15, "in15" },
+	{ IIO_VOLTAGE, 16, "in16" },
+	{ IIO_VOLTAGE, 17, "in17" },
+	{ IIO_VOLTAGE, 18, "in18" },
+	{ IIO_VOLTAGE, 19, "in19" },
+};
+
+static const unsigned int stm32h7_adc_resolutions[] = {
+	/* sorted values so the index matches RES[2:0] in STM32H7_ADC_CFGR */
+	16, 14, 12, 10, 8,
+};
+
+static const struct stm32_adc_info stm32h7_adc_info = {
+	.channels = stm32h7_adc_channels,
+	.max_channels = ARRAY_SIZE(stm32h7_adc_channels),
+	.resolutions = stm32h7_adc_resolutions,
+	.num_res = ARRAY_SIZE(stm32h7_adc_resolutions),
+};
+
 /**
  * stm32f4_sq - describe regular sequence registers
  * - L: sequence len (register & bit field)
@@ -327,6 +458,58 @@ struct stm32_adc_info {
 	.res = { STM32F4_ADC_CR1, STM32F4_RES_MASK, STM32F4_RES_SHIFT },
 };
 
+static const struct stm32_adc_regs stm32h7_sq[STM32_ADC_MAX_SQ + 1] = {
+	/* L: len bit field description to be kept as first element */
+	{ STM32H7_ADC_SQR1, GENMASK(3, 0), 0 },
+	/* SQ1..SQ16 registers & bit fields (reg, mask, shift) */
+	{ STM32H7_ADC_SQR1, GENMASK(10, 6), 6 },
+	{ STM32H7_ADC_SQR1, GENMASK(16, 12), 12 },
+	{ STM32H7_ADC_SQR1, GENMASK(22, 18), 18 },
+	{ STM32H7_ADC_SQR1, GENMASK(28, 24), 24 },
+	{ STM32H7_ADC_SQR2, GENMASK(4, 0), 0 },
+	{ STM32H7_ADC_SQR2, GENMASK(10, 6), 6 },
+	{ STM32H7_ADC_SQR2, GENMASK(16, 12), 12 },
+	{ STM32H7_ADC_SQR2, GENMASK(22, 18), 18 },
+	{ STM32H7_ADC_SQR2, GENMASK(28, 24), 24 },
+	{ STM32H7_ADC_SQR3, GENMASK(4, 0), 0 },
+	{ STM32H7_ADC_SQR3, GENMASK(10, 6), 6 },
+	{ STM32H7_ADC_SQR3, GENMASK(16, 12), 12 },
+	{ STM32H7_ADC_SQR3, GENMASK(22, 18), 18 },
+	{ STM32H7_ADC_SQR3, GENMASK(28, 24), 24 },
+	{ STM32H7_ADC_SQR4, GENMASK(4, 0), 0 },
+	{ STM32H7_ADC_SQR4, GENMASK(10, 6), 6 },
+};
+
+/* STM32H7 external trigger sources for all instances */
+static struct stm32_adc_trig_info stm32h7_adc_trigs[] = {
+	{ TIM1_CH1, STM32_EXT0 },
+	{ TIM1_CH2, STM32_EXT1 },
+	{ TIM1_CH3, STM32_EXT2 },
+	{ TIM2_CH2, STM32_EXT3 },
+	{ TIM3_TRGO, STM32_EXT4 },
+	{ TIM4_CH4, STM32_EXT5 },
+	{ TIM8_TRGO, STM32_EXT7 },
+	{ TIM8_TRGO2, STM32_EXT8 },
+	{ TIM1_TRGO, STM32_EXT9 },
+	{ TIM1_TRGO2, STM32_EXT10 },
+	{ TIM2_TRGO, STM32_EXT11 },
+	{ TIM4_TRGO, STM32_EXT12 },
+	{ TIM6_TRGO, STM32_EXT13 },
+	{ TIM3_CH4, STM32_EXT15 },
+	{},
+};
+
+static const struct stm32_adc_regspec stm32h7_adc_regspec = {
+	.dr = STM32H7_ADC_DR,
+	.ier_eoc = { STM32H7_ADC_IER, STM32H7_EOCIE },
+	.isr_eoc = { STM32H7_ADC_ISR, STM32H7_EOC },
+	.sqr = stm32h7_sq,
+	.exten = { STM32H7_ADC_CFGR, STM32H7_EXTEN_MASK, STM32H7_EXTEN_SHIFT },
+	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
+		    STM32H7_EXTSEL_SHIFT },
+	.res = { STM32H7_ADC_CFGR, STM32H7_RES_MASK, STM32H7_RES_SHIFT },
+};
+
 /**
  * STM32 ADC registers access routines
  * @adc: stm32 adc instance
@@ -340,6 +523,12 @@ static u32 stm32_adc_readl(struct stm32_adc *adc, u32 reg)
 	return readl_relaxed(adc->common->base + adc->offset + reg);
 }
 
+#define stm32_adc_readl_addr(addr)	stm32_adc_readl(adc, addr)
+
+#define stm32_adc_readl_poll_timeout(reg, val, cond, sleep_us, timeout_us) \
+	readx_poll_timeout(stm32_adc_readl_addr, reg, val, \
+			   cond, sleep_us, timeout_us)
+
 static u16 stm32_adc_readw(struct stm32_adc *adc, u32 reg)
 {
 	return readw_relaxed(adc->common->base + adc->offset + reg);
@@ -436,6 +625,324 @@ static void stm32f4_adc_stop_conv(struct stm32_adc *adc)
 			   STM32F4_ADON | STM32F4_DMA | STM32F4_DDS);
 }
 
+static void stm32h7_adc_start_conv(struct stm32_adc *adc, bool dma)
+{
+	enum stm32h7_adc_dmngt dmngt;
+	unsigned long flags;
+	u32 val;
+
+	if (dma)
+		dmngt = STM32H7_DMNGT_DMA_CIRC;
+	else
+		dmngt = STM32H7_DMNGT_DR_ONLY;
+
+	spin_lock_irqsave(&adc->lock, flags);
+	val = stm32_adc_readl(adc, STM32H7_ADC_CFGR);
+	val = (val & ~STM32H7_DMNGT_MASK) | (dmngt << STM32H7_DMNGT_SHIFT);
+	stm32_adc_writel(adc, STM32H7_ADC_CFGR, val);
+	spin_unlock_irqrestore(&adc->lock, flags);
+
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTART);
+}
+
+static void stm32h7_adc_stop_conv(struct stm32_adc *adc)
+{
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	int ret;
+	u32 val;
+
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTP);
+
+	ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
+					   !(val & (STM32H7_ADSTART)),
+					   100, STM32_ADC_TIMEOUT_US);
+	if (ret)
+		dev_warn(&indio_dev->dev, "stop failed\n");
+
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR, STM32H7_DMNGT_MASK);
+}
+
+static void stm32h7_adc_exit_pwr_down(struct stm32_adc *adc)
+{
+	/* Exit deep power down, then enable ADC voltage regulator */
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_DEEPPWD);
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADVREGEN);
+
+	if (adc->common->rate > STM32H7_BOOST_CLKRATE)
+		stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_BOOST);
+
+	/* Wait for startup time */
+	usleep_range(10, 20);
+}
+
+static void stm32h7_adc_enter_pwr_down(struct stm32_adc *adc)
+{
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_BOOST);
+
+	/* Setting DEEPPWD disables ADC vreg and clears ADVREGEN */
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_DEEPPWD);
+}
+
+static int stm32h7_adc_enable(struct stm32_adc *adc)
+{
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	int ret;
+	u32 val;
+
+	/* Clear ADRDY by writing one, then enable ADC */
+	stm32_adc_set_bits(adc, STM32H7_ADC_ISR, STM32H7_ADRDY);
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADEN);
+
+	/* Poll for ADRDY to be set (after adc startup time) */
+	ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_ISR, val,
+					   val & STM32H7_ADRDY,
+					   100, STM32_ADC_TIMEOUT_US);
+	if (ret) {
+		stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADEN);
+		dev_err(&indio_dev->dev, "Failed to enable ADC\n");
+	}
+
+	return ret;
+}
+
+static void stm32h7_adc_disable(struct stm32_adc *adc)
+{
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	int ret;
+	u32 val;
+
+	/* Disable ADC and wait until it's effectively disabled */
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADDIS);
+	ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
+					   !(val & STM32H7_ADEN), 100,
+					   STM32_ADC_TIMEOUT_US);
+	if (ret)
+		dev_warn(&indio_dev->dev, "Failed to disable\n");
+}
+
+/**
+ * stm32h7_adc_read_selfcalib() - read calibration shadow regs, save result
+ * @adc: stm32 adc instance
+ */
+static int stm32h7_adc_read_selfcalib(struct stm32_adc *adc)
+{
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	int i, ret;
+	u32 lincalrdyw_mask, val;
+
+	/* Enable adc so LINCALRDYW1..6 bits are writable */
+	ret = stm32h7_adc_enable(adc);
+	if (ret)
+		return ret;
+
+	/* Read linearity calibration */
+	lincalrdyw_mask = STM32H7_LINCALRDYW6;
+	for (i = STM32H7_LINCALFACT_NUM - 1; i >= 0; i--) {
+		/* Clear STM32H7_LINCALRDYW[6..1]: transfer calib to CALFACT2 */
+		stm32_adc_clr_bits(adc, STM32H7_ADC_CR, lincalrdyw_mask);
+
+		/* Poll: wait calib data to be ready in CALFACT2 register */
+		ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
+						   !(val & lincalrdyw_mask),
+						   100, STM32_ADC_TIMEOUT_US);
+		if (ret) {
+			dev_err(&indio_dev->dev, "Failed to read calfact\n");
+			goto disable;
+		}
+
+		val = stm32_adc_readl(adc, STM32H7_ADC_CALFACT2);
+		adc->cal.lincalfact[i] = (val & STM32H7_LINCALFACT_MASK);
+		adc->cal.lincalfact[i] >>= STM32H7_LINCALFACT_SHIFT;
+
+		lincalrdyw_mask >>= 1;
+	}
+
+	/* Read offset calibration */
+	val = stm32_adc_readl(adc, STM32H7_ADC_CALFACT);
+	adc->cal.calfact_s = (val & STM32H7_CALFACT_S_MASK);
+	adc->cal.calfact_s >>= STM32H7_CALFACT_S_SHIFT;
+	adc->cal.calfact_d = (val & STM32H7_CALFACT_D_MASK);
+	adc->cal.calfact_d >>= STM32H7_CALFACT_D_SHIFT;
+
+disable:
+	stm32h7_adc_disable(adc);
+
+	return ret;
+}
+
+/**
+ * stm32h7_adc_restore_selfcalib() - Restore saved self-calibration result
+ * @adc: stm32 adc instance
+ * Note: ADC must be enabled, with no on-going conversions.
+ */
+static int stm32h7_adc_restore_selfcalib(struct stm32_adc *adc)
+{
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	int i, ret;
+	u32 lincalrdyw_mask, val;
+
+	val = (adc->cal.calfact_s << STM32H7_CALFACT_S_SHIFT) |
+		(adc->cal.calfact_d << STM32H7_CALFACT_D_SHIFT);
+	stm32_adc_writel(adc, STM32H7_ADC_CALFACT, val);
+
+	lincalrdyw_mask = STM32H7_LINCALRDYW6;
+	for (i = STM32H7_LINCALFACT_NUM - 1; i >= 0; i--) {
+		/*
+		 * Write saved calibration data to shadow registers:
+		 * Write CALFACT2, and set LINCALRDYW[6..1] bit to trigger
+		 * data write. Then poll to wait for complete transfer.
+		 */
+		val = adc->cal.lincalfact[i] << STM32H7_LINCALFACT_SHIFT;
+		stm32_adc_writel(adc, STM32H7_ADC_CALFACT2, val);
+		stm32_adc_set_bits(adc, STM32H7_ADC_CR, lincalrdyw_mask);
+		ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
+						   val & lincalrdyw_mask,
+						   100, STM32_ADC_TIMEOUT_US);
+		if (ret) {
+			dev_err(&indio_dev->dev, "Failed to write calfact\n");
+			return ret;
+		}
+
+		/*
+		 * Read back calibration data, has two effects:
+		 * - It ensures bits LINCALRDYW[6..1] are kept cleared
+		 *   for next time calibration needs to be restored.
+		 * - BTW, bit clear triggers a read, then check data has been
+		 *   correctly written.
+		 */
+		stm32_adc_clr_bits(adc, STM32H7_ADC_CR, lincalrdyw_mask);
+		ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
+						   !(val & lincalrdyw_mask),
+						   100, STM32_ADC_TIMEOUT_US);
+		if (ret) {
+			dev_err(&indio_dev->dev, "Failed to read calfact\n");
+			return ret;
+		}
+		val = stm32_adc_readl(adc, STM32H7_ADC_CALFACT2);
+		if (val != adc->cal.lincalfact[i] << STM32H7_LINCALFACT_SHIFT) {
+			dev_err(&indio_dev->dev, "calfact not consistent\n");
+			return -EIO;
+		}
+
+		lincalrdyw_mask >>= 1;
+	}
+
+	return 0;
+}
+
+/**
+ * Fixed timeout value for ADC calibration.
+ * worst cases:
+ * - low clock frequency
+ * - maximum prescalers
+ * Calibration requires:
+ * - 131,072 ADC clock cycle for the linear calibration
+ * - 20 ADC clock cycle for the offset calibration
+ *
+ * Set to 100ms for now
+ */
+#define STM32H7_ADC_CALIB_TIMEOUT_US		100000
+
+/**
+ * stm32h7_adc_selfcalib() - Procedure to calibrate ADC (from power down)
+ * @adc: stm32 adc instance
+ * Exit from power down, calibrate ADC, then return to power down.
+ */
+static int stm32h7_adc_selfcalib(struct stm32_adc *adc)
+{
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
+	int ret;
+	u32 val;
+
+	stm32h7_adc_exit_pwr_down(adc);
+
+	/*
+	 * Select calibration mode:
+	 * - Offset calibration for single ended inputs
+	 * - No linearity calibration (do it later, before reading it)
+	 */
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALLIN);
+
+	/* Start calibration, then wait for completion */
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
+	ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
+					   !(val & STM32H7_ADCAL), 100,
+					   STM32H7_ADC_CALIB_TIMEOUT_US);
+	if (ret) {
+		dev_err(&indio_dev->dev, "calibration failed\n");
+		goto pwr_dwn;
+	}
+
+	/*
+	 * Select calibration mode, then start calibration:
+	 * - Offset calibration for differential input
+	 * - Linearity calibration (needs to be done only once for single/diff)
+	 *   will run simultaneously with offset calibration.
+	 */
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR,
+			   STM32H7_ADCALDIF | STM32H7_ADCALLIN);
+	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
+	ret = stm32_adc_readl_poll_timeout(STM32H7_ADC_CR, val,
+					   !(val & STM32H7_ADCAL), 100,
+					   STM32H7_ADC_CALIB_TIMEOUT_US);
+	if (ret) {
+		dev_err(&indio_dev->dev, "calibration failed\n");
+		goto pwr_dwn;
+	}
+
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CR,
+			   STM32H7_ADCALDIF | STM32H7_ADCALLIN);
+
+	/* Read calibration result for future reference */
+	ret = stm32h7_adc_read_selfcalib(adc);
+
+pwr_dwn:
+	stm32h7_adc_enter_pwr_down(adc);
+
+	return ret;
+}
+
+/**
+ * stm32h7_adc_prepare() - Leave power down mode to enable ADC.
+ * @adc: stm32 adc instance
+ * Leave power down mode.
+ * Enable ADC.
+ * Restore calibration data.
+ * Pre-select channels that may be used in PCSEL (required by input MUX / IO).
+ */
+static int stm32h7_adc_prepare(struct stm32_adc *adc)
+{
+	int ret;
+
+	stm32h7_adc_exit_pwr_down(adc);
+
+	ret = stm32h7_adc_enable(adc);
+	if (ret)
+		goto pwr_dwn;
+
+	ret = stm32h7_adc_restore_selfcalib(adc);
+	if (ret)
+		goto disable;
+
+	stm32_adc_writel(adc, STM32H7_ADC_PCSEL, adc->pcsel);
+
+	return 0;
+
+disable:
+	stm32h7_adc_disable(adc);
+pwr_dwn:
+	stm32h7_adc_enter_pwr_down(adc);
+
+	return ret;
+}
+
+static void stm32h7_adc_unprepare(struct stm32_adc *adc)
+{
+	stm32h7_adc_disable(adc);
+	stm32h7_adc_enter_pwr_down(adc);
+}
+
 /**
  * stm32_adc_conf_scan_seq() - Build regular channels scan sequence
  * @indio_dev: IIO device
@@ -606,6 +1113,12 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 
 	adc->bufi = 0;
 
+	if (adc->cfg->prepare) {
+		ret = adc->cfg->prepare(adc);
+		if (ret)
+			return ret;
+	}
+
 	/* Program chan number in regular sequence (SQ1) */
 	val = stm32_adc_readl(adc, regs->sqr[1].reg);
 	val &= ~regs->sqr[1].mask;
@@ -637,6 +1150,9 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 
 	stm32_adc_conv_irq_disable(adc);
 
+	if (adc->cfg->unprepare)
+		adc->cfg->unprepare(adc);
+
 	return ret;
 }
 
@@ -861,10 +1377,16 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	int ret;
 
+	if (adc->cfg->prepare) {
+		ret = adc->cfg->prepare(adc);
+		if (ret)
+			return ret;
+	}
+
 	ret = stm32_adc_set_trig(indio_dev, indio_dev->trig);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Can't set trigger\n");
-		return ret;
+		goto err_unprepare;
 	}
 
 	ret = stm32_adc_dma_start(indio_dev);
@@ -892,6 +1414,9 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 		dmaengine_terminate_all(adc->dma_chan);
 err_clr_trig:
 	stm32_adc_set_trig(indio_dev, NULL);
+err_unprepare:
+	if (adc->cfg->unprepare)
+		adc->cfg->unprepare(adc);
 
 	return ret;
 }
@@ -915,6 +1440,9 @@ static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 	if (stm32_adc_set_trig(indio_dev, NULL))
 		dev_err(&indio_dev->dev, "Can't clear trigger\n");
 
+	if (adc->cfg->unprepare)
+		adc->cfg->unprepare(adc);
+
 	return ret;
 }
 
@@ -1002,6 +1530,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 
+	/* Initialize IIO channel */
 	chan->type = channel->type;
 	chan->channel = channel->channel;
 	chan->datasheet_name = channel->name;
@@ -1013,6 +1542,9 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 	chan->scan_type.realbits = adc->cfg->adc_info->resolutions[adc->res];
 	chan->scan_type.storagebits = 16;
 	chan->ext_info = stm32_adc_ext_info;
+
+	/* pre-build selected channels mask */
+	adc->pcsel |= BIT(chan->channel);
 }
 
 static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
@@ -1166,6 +1698,12 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	stm32_adc_set_res(adc);
 
+	if (adc->cfg->selfcalib) {
+		ret = adc->cfg->selfcalib(adc);
+		if (ret)
+			goto err_clk_disable;
+	}
+
 	ret = stm32_adc_chan_of_init(indio_dev);
 	if (ret < 0)
 		goto err_clk_disable;
@@ -1236,8 +1774,20 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	.stop_conv = stm32f4_adc_stop_conv,
 };
 
+static const struct stm32_adc_cfg stm32h7_adc_cfg = {
+	.regs = &stm32h7_adc_regspec,
+	.adc_info = &stm32h7_adc_info,
+	.trigs = stm32h7_adc_trigs,
+	.selfcalib = stm32h7_adc_selfcalib,
+	.start_conv = stm32h7_adc_start_conv,
+	.stop_conv = stm32h7_adc_stop_conv,
+	.prepare = stm32h7_adc_prepare,
+	.unprepare = stm32h7_adc_unprepare,
+};
+
 static const struct of_device_id stm32_adc_of_match[] = {
 	{ .compatible = "st,stm32f4-adc", .data = (void *)&stm32f4_adc_cfg },
+	{ .compatible = "st,stm32h7-adc", .data = (void *)&stm32h7_adc_cfg },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
-- 
1.9.1
