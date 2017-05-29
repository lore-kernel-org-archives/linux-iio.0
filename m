Return-Path: <SRS0=EDDA=5D=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH v2 3/5] iio: adc: stm32: introduce compatible data cfg
Date: Mon, 29 May 2017 11:28:18 +0200
Message-ID: <1496050100-25854-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1496050100-25854-1-git-send-email-fabrice.gasnier@st.com>
References: <1496050100-25854-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Prepare support for stm32h7 adc variant by introducing compatible
configuration data.
Move STM32F4 specific stuff to compatible data structure:
- registers & bit fields
- input channels data
- start/stop procedures
- trigger definitions

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- rename stm32f4_adc123_channels to stm32_adc_channels
---
 drivers/iio/adc/stm32-adc-core.c |  62 ++++++++++--
 drivers/iio/adc/stm32-adc.c      | 202 +++++++++++++++++++++++++++++----------
 2 files changed, 205 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 597ab7a..c5d292c 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -50,11 +50,38 @@
 #define STM32F4_ADC_MAX_CLK_RATE	36000000
 
 /**
+ * stm32_adc_common_regs - stm32 common registers, compatible dependent data
+ * @csr:	common status register offset
+ * @eoc1:	adc1 end of conversion flag in @csr
+ * @eoc2:	adc2 end of conversion flag in @csr
+ * @eoc3:	adc3 end of conversion flag in @csr
+ */
+struct stm32_adc_common_regs {
+	u32 csr;
+	u32 eoc1_msk;
+	u32 eoc2_msk;
+	u32 eoc3_msk;
+};
+
+struct stm32_adc_priv;
+
+/**
+ * stm32_adc_priv_cfg - stm32 core compatible configuration data
+ * @regs:	common registers for all instances
+ * @clk_sel:	clock selection routine
+ */
+struct stm32_adc_priv_cfg {
+	const struct stm32_adc_common_regs *regs;
+	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
+};
+
+/**
  * struct stm32_adc_priv - stm32 ADC core private data
  * @irq:		irq for ADC block
  * @domain:		irq domain reference
  * @aclk:		clock reference for the analog circuitry
  * @vref:		regulator reference
+ * @cfg:		compatible configuration data
  * @common:		common data for all ADC instances
  */
 struct stm32_adc_priv {
@@ -62,6 +89,7 @@ struct stm32_adc_priv {
 	struct irq_domain		*domain;
 	struct clk			*aclk;
 	struct regulator		*vref;
+	const struct stm32_adc_priv_cfg	*cfg;
 	struct stm32_adc_common		common;
 };
 
@@ -112,6 +140,14 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
 	return 0;
 }
 
+/* STM32F4 common registers definitions */
+static const struct stm32_adc_common_regs stm32f4_adc_common_regs = {
+	.csr = STM32F4_ADC_CSR,
+	.eoc1_msk = STM32F4_EOC1,
+	.eoc2_msk = STM32F4_EOC2,
+	.eoc3_msk = STM32F4_EOC3,
+};
+
 /* ADC common interrupt for all instances */
 static void stm32_adc_irq_handler(struct irq_desc *desc)
 {
@@ -120,15 +156,15 @@ static void stm32_adc_irq_handler(struct irq_desc *desc)
 	u32 status;
 
 	chained_irq_enter(chip, desc);
-	status = readl_relaxed(priv->common.base + STM32F4_ADC_CSR);
+	status = readl_relaxed(priv->common.base + priv->cfg->regs->csr);
 
-	if (status & STM32F4_EOC1)
+	if (status & priv->cfg->regs->eoc1_msk)
 		generic_handle_irq(irq_find_mapping(priv->domain, 0));
 
-	if (status & STM32F4_EOC2)
+	if (status & priv->cfg->regs->eoc2_msk)
 		generic_handle_irq(irq_find_mapping(priv->domain, 1));
 
-	if (status & STM32F4_EOC3)
+	if (status & priv->cfg->regs->eoc3_msk)
 		generic_handle_irq(irq_find_mapping(priv->domain, 2));
 
 	chained_irq_exit(chip, desc);
@@ -194,6 +230,7 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
 static int stm32_adc_probe(struct platform_device *pdev)
 {
 	struct stm32_adc_priv *priv;
+	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
 	int ret;
@@ -205,6 +242,9 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->cfg = (const struct stm32_adc_priv_cfg *)
+		of_match_device(dev->driver->of_match_table, dev)->data;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->common.base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->common.base))
@@ -251,7 +291,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = stm32f4_adc_clk_sel(pdev, priv);
+	ret = priv->cfg->clk_sel(pdev, priv);
 	if (ret < 0)
 		goto err_clk_disable;
 
@@ -296,9 +336,17 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
+	.regs = &stm32f4_adc_common_regs,
+	.clk_sel = stm32f4_adc_clk_sel,
+};
+
 static const struct of_device_id stm32_adc_of_match[] = {
-	{ .compatible = "st,stm32f4-adc-core" },
-	{},
+	{
+		.compatible = "st,stm32f4-adc-core",
+		.data = (void *)&stm32f4_adc_priv_cfg
+	}, {
+	},
 };
 MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
 
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index c28e7ff..50b2538 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "stm32-adc-core.h"
 
@@ -133,9 +134,48 @@ struct stm32_adc_regs {
 };
 
 /**
+ * stm32_adc_regspec - stm32 registers definition, compatible dependent data
+ * @dr:			data register offset
+ * @ier_eoc:		interrupt enable register & eocie bitfield
+ * @isr_eoc:		interrupt status register & eoc bitfield
+ * @sqr:		reference to sequence registers array
+ * @exten:		trigger control register & bitfield
+ * @extsel:		trigger selection register & bitfield
+ * @res:		resolution selection register & bitfield
+ */
+struct stm32_adc_regspec {
+	const u32 dr;
+	const struct stm32_adc_regs ier_eoc;
+	const struct stm32_adc_regs isr_eoc;
+	const struct stm32_adc_regs *sqr;
+	const struct stm32_adc_regs exten;
+	const struct stm32_adc_regs extsel;
+	const struct stm32_adc_regs res;
+};
+
+struct stm32_adc;
+
+/**
+ * stm32_adc_cfg - stm32 compatible configuration data
+ * @regs:		registers descriptions
+ * @adc_info:		per instance input channels definitions
+ * @trigs:		external trigger sources
+ * @start_conv:		routine to start conversions
+ * @stop_conv:		routine to stop conversions
+ */
+struct stm32_adc_cfg {
+	const struct stm32_adc_regspec	*regs;
+	const struct stm32_adc_info	*adc_info;
+	struct stm32_adc_trig_info	*trigs;
+	void (*start_conv)(struct stm32_adc *, bool dma);
+	void (*stop_conv)(struct stm32_adc *);
+};
+
+/**
  * struct stm32_adc - private data of each ADC IIO instance
  * @common:		reference to ADC block common data
  * @offset:		ADC instance register offset in ADC block
+ * @cfg:		compatible configuration data
  * @completion:		end of single conversion completion
  * @buffer:		data buffer
  * @clk:		clock for this adc instance
@@ -153,6 +193,7 @@ struct stm32_adc_regs {
 struct stm32_adc {
 	struct stm32_adc_common	*common;
 	u32			offset;
+	const struct stm32_adc_cfg	*cfg;
 	struct completion	completion;
 	u16			buffer[STM32_ADC_MAX_SQ];
 	struct clk		*clk;
@@ -180,8 +221,25 @@ struct stm32_adc_chan_spec {
 	const char		*name;
 };
 
-/* Input definitions common for all STM32F4 instances */
-static const struct stm32_adc_chan_spec stm32f4_adc123_channels[] = {
+/**
+ * struct stm32_adc_info - stm32 ADC, per instance config data
+ * @channels:		Reference to stm32 channels spec
+ * @max_channels:	Number of channels
+ * @resolutions:	available resolutions
+ * @num_res:		number of available resolutions
+ */
+struct stm32_adc_info {
+	const struct stm32_adc_chan_spec *channels;
+	int max_channels;
+	const unsigned int *resolutions;
+	const unsigned int num_res;
+};
+
+/*
+ * Input definitions common for all instances:
+ * stm32f4 can have up to 16 channels
+ */
+static const struct stm32_adc_chan_spec stm32_adc_channels[] = {
 	{ IIO_VOLTAGE, 0, "in0" },
 	{ IIO_VOLTAGE, 1, "in1" },
 	{ IIO_VOLTAGE, 2, "in2" },
@@ -205,6 +263,13 @@ struct stm32_adc_chan_spec {
 	12, 10, 8, 6,
 };
 
+static const struct stm32_adc_info stm32f4_adc_info = {
+	.channels = stm32_adc_channels,
+	.max_channels = 16,
+	.resolutions = stm32f4_adc_resolutions,
+	.num_res = ARRAY_SIZE(stm32f4_adc_resolutions),
+};
+
 /**
  * stm32f4_sq - describe regular sequence registers
  * - L: sequence len (register & bit field)
@@ -252,6 +317,17 @@ struct stm32_adc_chan_spec {
 	{}, /* sentinel */
 };
 
+static const struct stm32_adc_regspec stm32f4_adc_regspec = {
+	.dr = STM32F4_ADC_DR,
+	.ier_eoc = { STM32F4_ADC_CR1, STM32F4_EOCIE },
+	.isr_eoc = { STM32F4_ADC_SR, STM32F4_EOC },
+	.sqr = stm32f4_sq,
+	.exten = { STM32F4_ADC_CR2, STM32F4_EXTEN_MASK, STM32F4_EXTEN_SHIFT },
+	.extsel = { STM32F4_ADC_CR2, STM32F4_EXTSEL_MASK,
+		    STM32F4_EXTSEL_SHIFT },
+	.res = { STM32F4_ADC_CR1, STM32F4_RES_MASK, STM32F4_RES_SHIFT },
+};
+
 /**
  * STM32 ADC registers access routines
  * @adc: stm32 adc instance
@@ -299,7 +375,8 @@ static void stm32_adc_clr_bits(struct stm32_adc *adc, u32 reg, u32 bits)
  */
 static void stm32_adc_conv_irq_enable(struct stm32_adc *adc)
 {
-	stm32_adc_set_bits(adc, STM32F4_ADC_CR1, STM32F4_EOCIE);
+	stm32_adc_set_bits(adc, adc->cfg->regs->ier_eoc.reg,
+			   adc->cfg->regs->ier_eoc.mask);
 };
 
 /**
@@ -308,19 +385,22 @@ static void stm32_adc_conv_irq_enable(struct stm32_adc *adc)
  */
 static void stm32_adc_conv_irq_disable(struct stm32_adc *adc)
 {
-	stm32_adc_clr_bits(adc, STM32F4_ADC_CR1, STM32F4_EOCIE);
+	stm32_adc_clr_bits(adc, adc->cfg->regs->ier_eoc.reg,
+			   adc->cfg->regs->ier_eoc.mask);
 }
 
 static void stm32_adc_set_res(struct stm32_adc *adc)
 {
-	u32 val = stm32_adc_readl(adc, STM32F4_ADC_CR1);
+	const struct stm32_adc_regs *res = &adc->cfg->regs->res;
+	u32 val;
 
-	val = (val & ~STM32F4_RES_MASK) | (adc->res << STM32F4_RES_SHIFT);
-	stm32_adc_writel(adc, STM32F4_ADC_CR1, val);
+	val = stm32_adc_readl(adc, res->reg);
+	val = (val & ~res->mask) | (adc->res << res->shift);
+	stm32_adc_writel(adc, res->reg, val);
 }
 
 /**
- * stm32_adc_start_conv() - Start conversions for regular channels.
+ * stm32f4_adc_start_conv() - Start conversions for regular channels.
  * @adc: stm32 adc instance
  * @dma: use dma to transfer conversion result
  *
@@ -329,7 +409,7 @@ static void stm32_adc_set_res(struct stm32_adc *adc)
  * conversions, in IIO buffer modes. Otherwise, use ADC interrupt with direct
  * DR read instead (e.g. read_raw, or triggered buffer mode without DMA).
  */
-static void stm32_adc_start_conv(struct stm32_adc *adc, bool dma)
+static void stm32f4_adc_start_conv(struct stm32_adc *adc, bool dma)
 {
 	stm32_adc_set_bits(adc, STM32F4_ADC_CR1, STM32F4_SCAN);
 
@@ -347,7 +427,7 @@ static void stm32_adc_start_conv(struct stm32_adc *adc, bool dma)
 		stm32_adc_set_bits(adc, STM32F4_ADC_CR2, STM32F4_SWSTART);
 }
 
-static void stm32_adc_stop_conv(struct stm32_adc *adc)
+static void stm32f4_adc_stop_conv(struct stm32_adc *adc)
 {
 	stm32_adc_clr_bits(adc, STM32F4_ADC_CR2, STM32F4_EXTEN_MASK);
 	stm32_adc_clr_bits(adc, STM32F4_ADC_SR, STM32F4_STRT);
@@ -371,6 +451,7 @@ static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
+	const struct stm32_adc_regs *sqr = adc->cfg->regs->sqr;
 	const struct iio_chan_spec *chan;
 	u32 val, bit;
 	int i = 0;
@@ -388,20 +469,20 @@ static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
 		dev_dbg(&indio_dev->dev, "%s chan %d to SQ%d\n",
 			__func__, chan->channel, i);
 
-		val = stm32_adc_readl(adc, stm32f4_sq[i].reg);
-		val &= ~stm32f4_sq[i].mask;
-		val |= chan->channel << stm32f4_sq[i].shift;
-		stm32_adc_writel(adc, stm32f4_sq[i].reg, val);
+		val = stm32_adc_readl(adc, sqr[i].reg);
+		val &= ~sqr[i].mask;
+		val |= chan->channel << sqr[i].shift;
+		stm32_adc_writel(adc, sqr[i].reg, val);
 	}
 
 	if (!i)
 		return -EINVAL;
 
 	/* Sequence len */
-	val = stm32_adc_readl(adc, stm32f4_sq[0].reg);
-	val &= ~stm32f4_sq[0].mask;
-	val |= ((i - 1) << stm32f4_sq[0].shift);
-	stm32_adc_writel(adc, stm32f4_sq[0].reg, val);
+	val = stm32_adc_readl(adc, sqr[0].reg);
+	val &= ~sqr[0].mask;
+	val |= ((i - 1) << sqr[0].shift);
+	stm32_adc_writel(adc, sqr[0].reg, val);
 
 	return 0;
 }
@@ -412,19 +493,21 @@ static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
  *
  * Returns trigger extsel value, if trig matches, -EINVAL otherwise.
  */
-static int stm32_adc_get_trig_extsel(struct iio_trigger *trig)
+static int stm32_adc_get_trig_extsel(struct iio_dev *indio_dev,
+				     struct iio_trigger *trig)
 {
+	struct stm32_adc *adc = iio_priv(indio_dev);
 	int i;
 
 	/* lookup triggers registered by stm32 timer trigger driver */
-	for (i = 0; stm32f4_adc_trigs[i].name; i++) {
+	for (i = 0; adc->cfg->trigs[i].name; i++) {
 		/**
 		 * Checking both stm32 timer trigger type and trig name
 		 * should be safe against arbitrary trigger names.
 		 */
 		if (is_stm32_timer_trigger(trig) &&
-		    !strcmp(stm32f4_adc_trigs[i].name, trig->name)) {
-			return stm32f4_adc_trigs[i].extsel;
+		    !strcmp(adc->cfg->trigs[i].name, trig->name)) {
+			return adc->cfg->trigs[i].extsel;
 		}
 	}
 
@@ -449,7 +532,7 @@ static int stm32_adc_set_trig(struct iio_dev *indio_dev,
 	int ret;
 
 	if (trig) {
-		ret = stm32_adc_get_trig_extsel(trig);
+		ret = stm32_adc_get_trig_extsel(indio_dev, trig);
 		if (ret < 0)
 			return ret;
 
@@ -459,11 +542,11 @@ static int stm32_adc_set_trig(struct iio_dev *indio_dev,
 	}
 
 	spin_lock_irqsave(&adc->lock, flags);
-	val = stm32_adc_readl(adc, STM32F4_ADC_CR2);
-	val &= ~(STM32F4_EXTEN_MASK | STM32F4_EXTSEL_MASK);
-	val |= exten << STM32F4_EXTEN_SHIFT;
-	val |= extsel << STM32F4_EXTSEL_SHIFT;
-	stm32_adc_writel(adc, STM32F4_ADC_CR2, val);
+	val = stm32_adc_readl(adc, adc->cfg->regs->exten.reg);
+	val &= ~(adc->cfg->regs->exten.mask | adc->cfg->regs->extsel.mask);
+	val |= exten << adc->cfg->regs->exten.shift;
+	val |= extsel << adc->cfg->regs->extsel.shift;
+	stm32_adc_writel(adc,  adc->cfg->regs->exten.reg, val);
 	spin_unlock_irqrestore(&adc->lock, flags);
 
 	return 0;
@@ -515,6 +598,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 				 int *res)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
+	const struct stm32_adc_regspec *regs = adc->cfg->regs;
 	long timeout;
 	u32 val;
 	int ret;
@@ -524,20 +608,20 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 	adc->bufi = 0;
 
 	/* Program chan number in regular sequence (SQ1) */
-	val = stm32_adc_readl(adc, stm32f4_sq[1].reg);
-	val &= ~stm32f4_sq[1].mask;
-	val |= chan->channel << stm32f4_sq[1].shift;
-	stm32_adc_writel(adc, stm32f4_sq[1].reg, val);
+	val = stm32_adc_readl(adc, regs->sqr[1].reg);
+	val &= ~regs->sqr[1].mask;
+	val |= chan->channel << regs->sqr[1].shift;
+	stm32_adc_writel(adc, regs->sqr[1].reg, val);
 
 	/* Set regular sequence len (0 for 1 conversion) */
-	stm32_adc_clr_bits(adc, stm32f4_sq[0].reg, stm32f4_sq[0].mask);
+	stm32_adc_clr_bits(adc, regs->sqr[0].reg, regs->sqr[0].mask);
 
 	/* Trigger detection disabled (conversion can be launched in SW) */
-	stm32_adc_clr_bits(adc, STM32F4_ADC_CR2, STM32F4_EXTEN_MASK);
+	stm32_adc_clr_bits(adc, regs->exten.reg, regs->exten.mask);
 
 	stm32_adc_conv_irq_enable(adc);
 
-	stm32_adc_start_conv(adc, false);
+	adc->cfg->start_conv(adc, false);
 
 	timeout = wait_for_completion_interruptible_timeout(
 					&adc->completion, STM32_ADC_TIMEOUT);
@@ -550,7 +634,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 	}
 
-	stm32_adc_stop_conv(adc);
+	adc->cfg->stop_conv(adc);
 
 	stm32_adc_conv_irq_disable(adc);
 
@@ -590,11 +674,12 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
 {
 	struct stm32_adc *adc = data;
 	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
-	u32 status = stm32_adc_readl(adc, STM32F4_ADC_SR);
+	const struct stm32_adc_regspec *regs = adc->cfg->regs;
+	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
 
-	if (status & STM32F4_EOC) {
+	if (status & regs->isr_eoc.mask) {
 		/* Reading DR also clears EOC status flag */
-		adc->buffer[adc->bufi] = stm32_adc_readw(adc, STM32F4_ADC_DR);
+		adc->buffer[adc->bufi] = stm32_adc_readw(adc, regs->dr);
 		if (iio_buffer_enabled(indio_dev)) {
 			adc->bufi++;
 			if (adc->bufi >= adc->num_conv) {
@@ -621,7 +706,7 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
 static int stm32_adc_validate_trigger(struct iio_dev *indio_dev,
 				      struct iio_trigger *trig)
 {
-	return stm32_adc_get_trig_extsel(trig) < 0 ? -EINVAL : 0;
+	return stm32_adc_get_trig_extsel(indio_dev, trig) < 0 ? -EINVAL : 0;
 }
 
 static int stm32_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
@@ -799,7 +884,7 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
 	if (!adc->dma_chan)
 		stm32_adc_conv_irq_enable(adc);
 
-	stm32_adc_start_conv(adc, !!adc->dma_chan);
+	adc->cfg->start_conv(adc, !!adc->dma_chan);
 
 	return 0;
 
@@ -817,7 +902,7 @@ static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	int ret;
 
-	stm32_adc_stop_conv(adc);
+	adc->cfg->stop_conv(adc);
 	if (!adc->dma_chan)
 		stm32_adc_conv_irq_disable(adc);
 
@@ -895,12 +980,12 @@ static int stm32_adc_of_get_resolution(struct iio_dev *indio_dev)
 	u32 res;
 
 	if (of_property_read_u32(node, "assigned-resolution-bits", &res))
-		res = stm32f4_adc_resolutions[0];
+		res = adc->cfg->adc_info->resolutions[0];
 
-	for (i = 0; i < ARRAY_SIZE(stm32f4_adc_resolutions); i++)
-		if (res == stm32f4_adc_resolutions[i])
+	for (i = 0; i < adc->cfg->adc_info->num_res; i++)
+		if (res == adc->cfg->adc_info->resolutions[i])
 			break;
-	if (i >= ARRAY_SIZE(stm32f4_adc_resolutions)) {
+	if (i >= adc->cfg->adc_info->num_res) {
 		dev_err(&indio_dev->dev, "Bad resolution: %u bits\n", res);
 		return -EINVAL;
 	}
@@ -926,7 +1011,7 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
 	chan->scan_type.sign = 'u';
-	chan->scan_type.realbits = stm32f4_adc_resolutions[adc->res];
+	chan->scan_type.realbits = adc->cfg->adc_info->resolutions[adc->res];
 	chan->scan_type.storagebits = 16;
 	chan->ext_info = stm32_adc_ext_info;
 }
@@ -934,6 +1019,8 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
 {
 	struct device_node *node = indio_dev->dev.of_node;
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
 	struct property *prop;
 	const __be32 *cur;
 	struct iio_chan_spec *channels;
@@ -942,7 +1029,7 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
 
 	num_channels = of_property_count_u32_elems(node, "st,adc-channels");
 	if (num_channels < 0 ||
-	    num_channels >= ARRAY_SIZE(stm32f4_adc123_channels)) {
+	    num_channels >= adc_info->max_channels) {
 		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
 		return num_channels < 0 ? num_channels : -EINVAL;
 	}
@@ -953,12 +1040,12 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	of_property_for_each_u32(node, "st,adc-channels", prop, cur, val) {
-		if (val >= ARRAY_SIZE(stm32f4_adc123_channels)) {
+		if (val >= adc_info->max_channels) {
 			dev_err(&indio_dev->dev, "Invalid channel %d\n", val);
 			return -EINVAL;
 		}
 		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
-					&stm32f4_adc123_channels[val],
+					&adc_info->channels[val],
 					scan_index);
 		scan_index++;
 	}
@@ -990,7 +1077,7 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
 	/* Configure DMA channel to read data register */
 	memset(&config, 0, sizeof(config));
 	config.src_addr = (dma_addr_t)adc->common->phys_base;
-	config.src_addr += adc->offset + STM32F4_ADC_DR;
+	config.src_addr += adc->offset + adc->cfg->regs->dr;
 	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	ret = dmaengine_slave_config(adc->dma_chan, &config);
@@ -1011,6 +1098,7 @@ static int stm32_adc_dma_request(struct iio_dev *indio_dev)
 static int stm32_adc_probe(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev;
+	struct device *dev = &pdev->dev;
 	struct stm32_adc *adc;
 	int ret;
 
@@ -1025,6 +1113,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	adc->common = dev_get_drvdata(pdev->dev.parent);
 	spin_lock_init(&adc->lock);
 	init_completion(&adc->completion);
+	adc->cfg = (const struct stm32_adc_cfg *)
+		of_match_device(dev->driver->of_match_table, dev)->data;
 
 	indio_dev->name = dev_name(&pdev->dev);
 	indio_dev->dev.parent = &pdev->dev;
@@ -1129,8 +1219,16 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct stm32_adc_cfg stm32f4_adc_cfg = {
+	.regs = &stm32f4_adc_regspec,
+	.adc_info = &stm32f4_adc_info,
+	.trigs = stm32f4_adc_trigs,
+	.start_conv = stm32f4_adc_start_conv,
+	.stop_conv = stm32f4_adc_stop_conv,
+};
+
 static const struct of_device_id stm32_adc_of_match[] = {
-	{ .compatible = "st,stm32f4-adc" },
+	{ .compatible = "st,stm32f4-adc", .data = (void *)&stm32f4_adc_cfg },
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_adc_of_match);
-- 
1.9.1
