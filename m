Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54759 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752696AbdASNfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 08:35:37 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 1/7] iio: adc: stm32: add support for triggered buffer mode
Date: Thu, 19 Jan 2017 14:34:08 +0100
Message-ID: <1484832854-6314-2-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
References: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 ADC conversions can be launched using hardware triggers.
It can be used to start conversion sequences (group of channels).
Selected channels are select via sequence registers.
Trigger source is selected via 'extsel' (external trigger mux).
Trigger polarity is set to rising edge by default.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/Kconfig     |   2 +
 drivers/iio/adc/stm32-adc.c | 349 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 348 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9c8b558..33341f4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -446,6 +446,8 @@ config STM32_ADC_CORE
 	depends on ARCH_STM32 || COMPILE_TEST
 	depends on OF
 	depends on REGULATOR
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Select this option to enable the core driver for STMicroelectronics
 	  STM32 analog-to-digital converter (ADC).
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5715e79..8d0b74b 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -22,11 +22,16 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #include "stm32-adc-core.h"
 
@@ -58,21 +63,66 @@
 
 /* STM32F4_ADC_CR2 - bit fields */
 #define STM32F4_SWSTART			BIT(30)
+#define STM32F4_EXTEN_SHIFT		28
 #define STM32F4_EXTEN_MASK		GENMASK(29, 28)
+#define STM32F4_EXTSEL_SHIFT		24
+#define STM32F4_EXTSEL_MASK		GENMASK(27, 24)
 #define STM32F4_EOCS			BIT(10)
 #define STM32F4_ADON			BIT(0)
 
 /* STM32F4_ADC_SQR1 - bit fields */
 #define STM32F4_L_SHIFT			20
 #define STM32F4_L_MASK			GENMASK(23, 20)
+#define STM32F4_SQ16_SHIFT		15
+#define STM32F4_SQ16_MASK		GENMASK(19, 15)
+#define STM32F4_SQ15_SHIFT		10
+#define STM32F4_SQ15_MASK		GENMASK(14, 10)
+#define STM32F4_SQ14_SHIFT		5
+#define STM32F4_SQ14_MASK		GENMASK(9, 5)
+#define STM32F4_SQ13_SHIFT		0
+#define STM32F4_SQ13_MASK		GENMASK(4, 0)
+
+/* STM32F4_ADC_SQR2 - bit fields */
+#define STM32F4_SQ12_SHIFT		25
+#define STM32F4_SQ12_MASK		GENMASK(29, 25)
+#define STM32F4_SQ11_SHIFT		20
+#define STM32F4_SQ11_MASK		GENMASK(24, 20)
+#define STM32F4_SQ10_SHIFT		15
+#define STM32F4_SQ10_MASK		GENMASK(19, 15)
+#define STM32F4_SQ9_SHIFT		10
+#define STM32F4_SQ9_MASK		GENMASK(14, 10)
+#define STM32F4_SQ8_SHIFT		5
+#define STM32F4_SQ8_MASK		GENMASK(9, 5)
+#define STM32F4_SQ7_SHIFT		0
+#define STM32F4_SQ7_MASK		GENMASK(4, 0)
 
 /* STM32F4_ADC_SQR3 - bit fields */
+#define STM32F4_SQ6_SHIFT		25
+#define STM32F4_SQ6_MASK		GENMASK(29, 25)
+#define STM32F4_SQ5_SHIFT		20
+#define STM32F4_SQ5_MASK		GENMASK(24, 20)
+#define STM32F4_SQ4_SHIFT		15
+#define STM32F4_SQ4_MASK		GENMASK(19, 15)
+#define STM32F4_SQ3_SHIFT		10
+#define STM32F4_SQ3_MASK		GENMASK(14, 10)
+#define STM32F4_SQ2_SHIFT		5
+#define STM32F4_SQ2_MASK		GENMASK(9, 5)
 #define STM32F4_SQ1_SHIFT		0
 #define STM32F4_SQ1_MASK		GENMASK(4, 0)
 
+#define STM32_ADC_MAX_SQ		16	/* SQ1..SQ16 */
 #define STM32_ADC_TIMEOUT_US		100000
 #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
 
+/* External trigger enable */
+enum stm32_adc_exten {
+	STM32_EXTEN_SWTRIG,
+	STM32_EXTEN_HWTRIG_RISING_EDGE,
+	STM32_EXTEN_HWTRIG_FALLING_EDGE,
+	STM32_EXTEN_HWTRIG_BOTH_EDGES,
+};
+
+
 /**
  * struct stm32_adc - private data of each ADC IIO instance
  * @common:		reference to ADC block common data
@@ -82,6 +132,8 @@
  * @clk:		clock for this adc instance
  * @irq:		interrupt for this adc instance
  * @lock:		spinlock
+ * @bufi:		data buffer index
+ * @num_conv:		expected number of scan conversions
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -91,6 +143,8 @@ struct stm32_adc {
 	struct clk		*clk;
 	int			irq;
 	spinlock_t		lock;		/* interrupt lock */
+	int			bufi;
+	int			num_conv;
 };
 
 /**
@@ -105,6 +159,18 @@ struct stm32_adc_chan_spec {
 	const char		*name;
 };
 
+/**
+ * stm32_adc_regs - stm32 ADC misc registers & bitfield desc
+ * @reg:		register offset
+ * @mask:		bitfield mask
+ * @shift:		left shift
+ */
+struct stm32_adc_regs {
+	int reg;
+	int mask;
+	int shift;
+};
+
 /* Input definitions common for all STM32F4 instances */
 static const struct stm32_adc_chan_spec stm32f4_adc123_channels[] = {
 	{ IIO_VOLTAGE, 0, "in0" },
@@ -126,6 +192,33 @@ struct stm32_adc_chan_spec {
 };
 
 /**
+ * stm32f4_sqr_regs - describe regular sequence registers
+ * - L: sequence len (register & bit field)
+ * - SQ1..SQ16: sequence entries (register & bit field)
+ */
+static const struct stm32_adc_regs stm32f4_sqr_regs[STM32_ADC_MAX_SQ + 1] = {
+	/* L: len bit field description to be kept as first element */
+	{ STM32F4_ADC_SQR1, STM32F4_L_MASK, STM32F4_L_SHIFT },
+	/* SQ1..SQ16 registers & bit fields */
+	{ STM32F4_ADC_SQR3, STM32F4_SQ1_MASK, STM32F4_SQ1_SHIFT },
+	{ STM32F4_ADC_SQR3, STM32F4_SQ2_MASK, STM32F4_SQ2_SHIFT },
+	{ STM32F4_ADC_SQR3, STM32F4_SQ3_MASK, STM32F4_SQ3_SHIFT },
+	{ STM32F4_ADC_SQR3, STM32F4_SQ4_MASK, STM32F4_SQ4_SHIFT },
+	{ STM32F4_ADC_SQR3, STM32F4_SQ5_MASK, STM32F4_SQ5_SHIFT },
+	{ STM32F4_ADC_SQR3, STM32F4_SQ6_MASK, STM32F4_SQ6_SHIFT },
+	{ STM32F4_ADC_SQR2, STM32F4_SQ7_MASK, STM32F4_SQ7_SHIFT },
+	{ STM32F4_ADC_SQR2, STM32F4_SQ8_MASK, STM32F4_SQ8_SHIFT },
+	{ STM32F4_ADC_SQR2, STM32F4_SQ9_MASK, STM32F4_SQ9_SHIFT },
+	{ STM32F4_ADC_SQR2, STM32F4_SQ10_MASK, STM32F4_SQ10_SHIFT },
+	{ STM32F4_ADC_SQR2, STM32F4_SQ11_MASK, STM32F4_SQ11_SHIFT },
+	{ STM32F4_ADC_SQR2, STM32F4_SQ12_MASK, STM32F4_SQ12_SHIFT },
+	{ STM32F4_ADC_SQR1, STM32F4_SQ13_MASK, STM32F4_SQ13_SHIFT },
+	{ STM32F4_ADC_SQR1, STM32F4_SQ14_MASK, STM32F4_SQ14_SHIFT },
+	{ STM32F4_ADC_SQR1, STM32F4_SQ15_MASK, STM32F4_SQ15_SHIFT },
+	{ STM32F4_ADC_SQR1, STM32F4_SQ16_MASK, STM32F4_SQ16_SHIFT },
+};
+
+/**
  * STM32 ADC registers access routines
  * @adc: stm32 adc instance
  * @reg: reg offset in adc instance
@@ -211,6 +304,106 @@ static void stm32_adc_stop_conv(struct stm32_adc *adc)
 }
 
 /**
+ * stm32_adc_conf_scan_seq() - Build regular channels scan sequence
+ * @indio_dev: IIO device
+ * @scan_mask: channels to be converted
+ *
+ * Conversion sequence :
+ * Configure ADC scan sequence based on selected channels in scan_mask.
+ * Add channels to SQR registers, from scan_mask LSB to MSB, then
+ * program sequence len.
+ */
+static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan;
+	u32 val, bit;
+	int i = 0;
+
+	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
+		chan = indio_dev->channels + bit;
+		/*
+		 * Assign one channel per SQ entry in regular
+		 * sequence, starting with SQ1.
+		 */
+		i++;
+		if (i > STM32_ADC_MAX_SQ)
+			return -EINVAL;
+
+		dev_dbg(&indio_dev->dev, "%s chan %d to SQ%d\n",
+			__func__, chan->channel, i);
+
+		val = stm32_adc_readl(adc, stm32f4_sqr_regs[i].reg);
+		val &= ~stm32f4_sqr_regs[i].mask;
+		val |= chan->channel << stm32f4_sqr_regs[i].shift;
+		stm32_adc_writel(adc, stm32f4_sqr_regs[i].reg, val);
+	}
+
+	if (!i)
+		return -EINVAL;
+
+	/* Sequence len */
+	val = stm32_adc_readl(adc, stm32f4_sqr_regs[0].reg);
+	val &= ~stm32f4_sqr_regs[0].mask;
+	val |= ((i - 1) << stm32f4_sqr_regs[0].shift);
+	stm32_adc_writel(adc, stm32f4_sqr_regs[0].reg, val);
+
+	return 0;
+}
+
+/**
+ * stm32_adc_get_trig_extsel() - Get external trigger selection
+ * @indio_dev: IIO device
+ * @trig: trigger
+ *
+ * Returns trigger extsel value, if trig matches, -EINVAL otherwise.
+ */
+static int stm32_adc_get_trig_extsel(struct iio_dev *indio_dev,
+				     struct iio_trigger *trig)
+{
+	return -EINVAL;
+}
+
+/**
+ * stm32_adc_set_trig() - Set a regular trigger
+ * @indio_dev: IIO device
+ * @trig: IIO trigger
+ *
+ * Set trigger source/polarity (e.g. SW, or HW with polarity) :
+ * - if HW trigger disabled (e.g. trig == NULL, conversion launched by sw)
+ * - if HW trigger enabled, set source & polarity
+ */
+static int stm32_adc_set_trig(struct iio_dev *indio_dev,
+			      struct iio_trigger *trig)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 val, extsel = 0, exten = STM32_EXTEN_SWTRIG;
+	unsigned long flags;
+	int ret;
+
+	if (trig) {
+		ret = stm32_adc_get_trig_extsel(indio_dev, trig);
+		if (ret < 0)
+			return ret;
+
+		/* set trigger source, default to rising edge */
+		extsel = ret;
+		exten = STM32_EXTEN_HWTRIG_RISING_EDGE;
+	}
+
+	spin_lock_irqsave(&adc->lock, flags);
+	val = stm32_adc_readl(adc, STM32F4_ADC_CR2);
+	val &= ~(STM32F4_EXTEN_MASK | STM32F4_EXTSEL_MASK);
+	val |= exten << STM32F4_EXTEN_SHIFT;
+	val |= extsel << STM32F4_EXTSEL_SHIFT;
+	stm32_adc_writel(adc, STM32F4_ADC_CR2, val);
+	spin_unlock_irqrestore(&adc->lock, flags);
+
+	return 0;
+}
+
+/**
  * stm32_adc_single_conv() - Performs a single conversion
  * @indio_dev: IIO device
  * @chan: IIO channel
@@ -234,6 +427,7 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 	reinit_completion(&adc->completion);
 
 	adc->buffer = &result;
+	adc->bufi = 0;
 
 	/* Program chan number in regular sequence */
 	val = stm32_adc_readl(adc, STM32F4_ADC_SQR3);
@@ -301,17 +495,58 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 static irqreturn_t stm32_adc_isr(int irq, void *data)
 {
 	struct stm32_adc *adc = data;
+	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
 	u32 status = stm32_adc_readl(adc, STM32F4_ADC_SR);
 
 	if (status & STM32F4_EOC) {
-		*adc->buffer = stm32_adc_readw(adc, STM32F4_ADC_DR);
-		complete(&adc->completion);
+		adc->buffer[adc->bufi] = stm32_adc_readw(adc, STM32F4_ADC_DR);
+		if (iio_buffer_enabled(indio_dev)) {
+			adc->bufi++;
+			if (adc->bufi >= adc->num_conv) {
+				stm32_adc_conv_irq_disable(adc);
+				iio_trigger_poll(indio_dev->trig);
+			}
+		} else {
+			complete(&adc->completion);
+		}
 		return IRQ_HANDLED;
 	}
 
 	return IRQ_NONE;
 }
 
+/**
+ * stm32_adc_validate_trigger() - validate trigger for stm32 adc
+ * @indio_dev: IIO device
+ * @trig: new trigger
+ *
+ * Returns: 0 if trig matches one of the triggers registered by stm32 adc
+ * driver, -EINVAL otherwise.
+ */
+static int stm32_adc_validate_trigger(struct iio_dev *indio_dev,
+				      struct iio_trigger *trig)
+{
+	return stm32_adc_get_trig_extsel(indio_dev, trig) < 0 ? -EINVAL : 0;
+}
+
+static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	int ret;
+	u32 bit;
+
+	adc->num_conv = 0;
+	for_each_set_bit(bit, scan_mask, indio_dev->masklength)
+		adc->num_conv++;
+
+	ret = stm32_adc_conf_scan_seq(indio_dev, scan_mask);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int stm32_adc_of_xlate(struct iio_dev *indio_dev,
 			      const struct of_phandle_args *iiospec)
 {
@@ -350,11 +585,106 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info stm32_adc_iio_info = {
 	.read_raw = stm32_adc_read_raw,
+	.validate_trigger = stm32_adc_validate_trigger,
+	.update_scan_mode = stm32_adc_update_scan_mode,
 	.debugfs_reg_access = stm32_adc_debugfs_reg_access,
 	.of_xlate = stm32_adc_of_xlate,
 	.driver_module = THIS_MODULE,
 };
 
+static int stm32_adc_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	/* Reset adc buffer index */
+	adc->bufi = 0;
+
+	/* Allocate adc buffer */
+	adc->buffer = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (!adc->buffer)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	ret = stm32_adc_set_trig(indio_dev, indio_dev->trig);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Can't set trigger\n");
+		return ret;
+	}
+
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	stm32_adc_conv_irq_enable(adc);
+	stm32_adc_start_conv(adc);
+
+	return 0;
+}
+
+static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	int ret;
+
+	stm32_adc_stop_conv(adc);
+	stm32_adc_conv_irq_disable(adc);
+
+	ret = iio_triggered_buffer_predisable(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = stm32_adc_set_trig(indio_dev, NULL);
+	if (ret)
+		dev_err(&indio_dev->dev, "Can't clear trigger\n");
+
+	return ret;
+}
+
+static int stm32_adc_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	kfree(adc->buffer);
+	adc->buffer = NULL;
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops stm32_adc_buffer_setup_ops = {
+	.preenable = &stm32_adc_buffer_preenable,
+	.postenable = &stm32_adc_buffer_postenable,
+	.predisable = &stm32_adc_buffer_predisable,
+	.postdisable = &stm32_adc_buffer_postdisable,
+};
+
+static irqreturn_t stm32_adc_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	dev_dbg(&indio_dev->dev, "%s bufi=%d\n", __func__, adc->bufi);
+
+	/* reset buffer index */
+	adc->bufi = 0;
+	iio_push_to_buffers_with_timestamp(indio_dev, adc->buffer,
+					   pf->timestamp);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	/* re-enable eoc irq */
+	stm32_adc_conv_irq_enable(adc);
+
+	return IRQ_HANDLED;
+}
+
 static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 				    struct iio_chan_spec *chan,
 				    const struct stm32_adc_chan_spec *channel,
@@ -471,14 +801,26 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_clk_disable;
 
+	ret = iio_triggered_buffer_setup(indio_dev,
+					 &iio_pollfunc_store_time,
+					 &stm32_adc_trigger_handler,
+					 &stm32_adc_buffer_setup_ops);
+	if (ret) {
+		dev_err(&pdev->dev, "buffer setup failed\n");
+		goto err_clk_disable;
+	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "iio dev register failed\n");
-		goto err_clk_disable;
+		goto err_buffer_cleanup;
 	}
 
 	return 0;
 
+err_buffer_cleanup:
+	iio_triggered_buffer_cleanup(indio_dev);
+
 err_clk_disable:
 	clk_disable_unprepare(adc->clk);
 
@@ -491,6 +833,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = iio_priv_to_dev(adc);
 
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	clk_disable_unprepare(adc->clk);
 
 	return 0;
-- 
1.9.1

