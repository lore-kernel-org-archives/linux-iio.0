Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15007 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932156AbdGXQMp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2017 12:12:45 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] iio: adc: stm32: add optional st,min-sample-time-nsecs
Date: Mon, 24 Jul 2017 18:10:40 +0200
Message-ID: <1500912640-23927-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1500912640-23927-1-git-send-email-fabrice.gasnier@st.com>
References: <1500912640-23927-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

STM32 ADC allows each channel to be sampled with a different sampling time,
by setting SMPR registers. Basically, value depends on local electrical
properties. Selecting correct value for sampling time highly depends on
analog source impedance. There is a manual that may help in this process:
'How to get the best ADC accuracy in STM32...'

This patch allows to configure minimum sampling time via device tree,
either for:
- all channels at once:
  st,min-sample-time-nsecs = <10000>;

- independently for each channel (must match "st,adc-channels" list):
  st,adc-channels = <0 1>;
  st,min-sample-time-nsecs = <5000 10000>;

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Use 'st,min-sample-time-nsecs' instead of 'min-sample-time'.
- Add a comment on of_property_read_u32_index() use.
---
 drivers/iio/adc/stm32-adc.c | 140 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 136 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5bfcc1f..6bc6028 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -83,6 +83,8 @@
 #define STM32H7_ADC_IER			0x04
 #define STM32H7_ADC_CR			0x08
 #define STM32H7_ADC_CFGR		0x0C
+#define STM32H7_ADC_SMPR1		0x14
+#define STM32H7_ADC_SMPR2		0x18
 #define STM32H7_ADC_PCSEL		0x1C
 #define STM32H7_ADC_SQR1		0x30
 #define STM32H7_ADC_SQR2		0x34
@@ -151,6 +153,7 @@ enum stm32h7_adc_dmngt {
 #define STM32H7_BOOST_CLKRATE		20000000UL
 
 #define STM32_ADC_MAX_SQ		16	/* SQ1..SQ16 */
+#define STM32_ADC_MAX_SMP		7	/* SMPx range is [0..7] */
 #define STM32_ADC_TIMEOUT_US		100000
 #define STM32_ADC_TIMEOUT	(msecs_to_jiffies(STM32_ADC_TIMEOUT_US / 1000))
 
@@ -227,6 +230,8 @@ struct stm32_adc_regs {
  * @exten:		trigger control register & bitfield
  * @extsel:		trigger selection register & bitfield
  * @res:		resolution selection register & bitfield
+ * @smpr:		smpr1 & smpr2 registers offset array
+ * @smp_bits:		smpr1 & smpr2 index and bitfields
  */
 struct stm32_adc_regspec {
 	const u32 dr;
@@ -236,6 +241,8 @@ struct stm32_adc_regspec {
 	const struct stm32_adc_regs exten;
 	const struct stm32_adc_regs extsel;
 	const struct stm32_adc_regs res;
+	const u32 smpr[2];
+	const struct stm32_adc_regs *smp_bits;
 };
 
 struct stm32_adc;
@@ -251,6 +258,7 @@ struct stm32_adc_regspec {
  * @start_conv:		routine to start conversions
  * @stop_conv:		routine to stop conversions
  * @unprepare:		optional unprepare routine (disable, power-down)
+ * @smp_cycles:		programmable sampling time (ADC clock cycles)
  */
 struct stm32_adc_cfg {
 	const struct stm32_adc_regspec	*regs;
@@ -262,6 +270,7 @@ struct stm32_adc_cfg {
 	void (*start_conv)(struct stm32_adc *, bool dma);
 	void (*stop_conv)(struct stm32_adc *);
 	void (*unprepare)(struct stm32_adc *);
+	const unsigned int *smp_cycles;
 };
 
 /**
@@ -283,6 +292,7 @@ struct stm32_adc_cfg {
  * @rx_dma_buf:		dma rx buffer bus address
  * @rx_buf_sz:		dma rx buffer size
  * @pcsel		bitmask to preselect channels on some devices
+ * @smpr_val:		sampling time settings (e.g. smpr1 / smpr2)
  * @cal:		optional calibration data on some devices
  */
 struct stm32_adc {
@@ -303,6 +313,7 @@ struct stm32_adc {
 	dma_addr_t		rx_dma_buf;
 	unsigned int		rx_buf_sz;
 	u32			pcsel;
+	u32			smpr_val[2];
 	struct stm32_adc_calib	cal;
 };
 
@@ -431,6 +442,39 @@ struct stm32_adc_info {
 	{}, /* sentinel */
 };
 
+/**
+ * stm32f4_smp_bits[] - describe sampling time register index & bit fields
+ * Sorted so it can be indexed by channel number.
+ */
+static const struct stm32_adc_regs stm32f4_smp_bits[] = {
+	/* STM32F4_ADC_SMPR2: smpr[] index, mask, shift for SMP0 to SMP9 */
+	{ 1, GENMASK(2, 0), 0 },
+	{ 1, GENMASK(5, 3), 3 },
+	{ 1, GENMASK(8, 6), 6 },
+	{ 1, GENMASK(11, 9), 9 },
+	{ 1, GENMASK(14, 12), 12 },
+	{ 1, GENMASK(17, 15), 15 },
+	{ 1, GENMASK(20, 18), 18 },
+	{ 1, GENMASK(23, 21), 21 },
+	{ 1, GENMASK(26, 24), 24 },
+	{ 1, GENMASK(29, 27), 27 },
+	/* STM32F4_ADC_SMPR1, smpr[] index, mask, shift for SMP10 to SMP18 */
+	{ 0, GENMASK(2, 0), 0 },
+	{ 0, GENMASK(5, 3), 3 },
+	{ 0, GENMASK(8, 6), 6 },
+	{ 0, GENMASK(11, 9), 9 },
+	{ 0, GENMASK(14, 12), 12 },
+	{ 0, GENMASK(17, 15), 15 },
+	{ 0, GENMASK(20, 18), 18 },
+	{ 0, GENMASK(23, 21), 21 },
+	{ 0, GENMASK(26, 24), 24 },
+};
+
+/* STM32F4 programmable sampling time (ADC clock cycles) */
+static const unsigned int stm32f4_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
+	3, 15, 28, 56, 84, 112, 144, 480,
+};
+
 static const struct stm32_adc_regspec stm32f4_adc_regspec = {
 	.dr = STM32F4_ADC_DR,
 	.ier_eoc = { STM32F4_ADC_CR1, STM32F4_EOCIE },
@@ -440,6 +484,8 @@ struct stm32_adc_info {
 	.extsel = { STM32F4_ADC_CR2, STM32F4_EXTSEL_MASK,
 		    STM32F4_EXTSEL_SHIFT },
 	.res = { STM32F4_ADC_CR1, STM32F4_RES_MASK, STM32F4_RES_SHIFT },
+	.smpr = { STM32F4_ADC_SMPR1, STM32F4_ADC_SMPR2 },
+	.smp_bits = stm32f4_smp_bits,
 };
 
 static const struct stm32_adc_regs stm32h7_sq[STM32_ADC_MAX_SQ + 1] = {
@@ -483,6 +529,40 @@ struct stm32_adc_info {
 	{},
 };
 
+/**
+ * stm32h7_smp_bits - describe sampling time register index & bit fields
+ * Sorted so it can be indexed by channel number.
+ */
+static const struct stm32_adc_regs stm32h7_smp_bits[] = {
+	/* STM32H7_ADC_SMPR1, smpr[] index, mask, shift for SMP0 to SMP9 */
+	{ 0, GENMASK(2, 0), 0 },
+	{ 0, GENMASK(5, 3), 3 },
+	{ 0, GENMASK(8, 6), 6 },
+	{ 0, GENMASK(11, 9), 9 },
+	{ 0, GENMASK(14, 12), 12 },
+	{ 0, GENMASK(17, 15), 15 },
+	{ 0, GENMASK(20, 18), 18 },
+	{ 0, GENMASK(23, 21), 21 },
+	{ 0, GENMASK(26, 24), 24 },
+	{ 0, GENMASK(29, 27), 27 },
+	/* STM32H7_ADC_SMPR2, smpr[] index, mask, shift for SMP10 to SMP19 */
+	{ 1, GENMASK(2, 0), 0 },
+	{ 1, GENMASK(5, 3), 3 },
+	{ 1, GENMASK(8, 6), 6 },
+	{ 1, GENMASK(11, 9), 9 },
+	{ 1, GENMASK(14, 12), 12 },
+	{ 1, GENMASK(17, 15), 15 },
+	{ 1, GENMASK(20, 18), 18 },
+	{ 1, GENMASK(23, 21), 21 },
+	{ 1, GENMASK(26, 24), 24 },
+	{ 1, GENMASK(29, 27), 27 },
+};
+
+/* STM32H7 programmable sampling time (ADC clock cycles, rounded down) */
+static const unsigned int stm32h7_adc_smp_cycles[STM32_ADC_MAX_SMP + 1] = {
+	1, 2, 8, 16, 32, 64, 387, 810,
+};
+
 static const struct stm32_adc_regspec stm32h7_adc_regspec = {
 	.dr = STM32H7_ADC_DR,
 	.ier_eoc = { STM32H7_ADC_IER, STM32H7_EOCIE },
@@ -492,6 +572,8 @@ struct stm32_adc_info {
 	.extsel = { STM32H7_ADC_CFGR, STM32H7_EXTSEL_MASK,
 		    STM32H7_EXTSEL_SHIFT },
 	.res = { STM32H7_ADC_CFGR, STM32H7_RES_MASK, STM32H7_RES_SHIFT },
+	.smpr = { STM32H7_ADC_SMPR1, STM32H7_ADC_SMPR2 },
+	.smp_bits = stm32h7_smp_bits,
 };
 
 /**
@@ -933,6 +1015,7 @@ static void stm32h7_adc_unprepare(struct stm32_adc *adc)
  * @scan_mask: channels to be converted
  *
  * Conversion sequence :
+ * Apply sampling time settings for all channels.
  * Configure ADC scan sequence based on selected channels in scan_mask.
  * Add channels to SQR registers, from scan_mask LSB to MSB, then
  * program sequence len.
@@ -946,6 +1029,10 @@ static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
 	u32 val, bit;
 	int i = 0;
 
+	/* Apply sampling time settings */
+	stm32_adc_writel(adc, adc->cfg->regs->smpr[0], adc->smpr_val[0]);
+	stm32_adc_writel(adc, adc->cfg->regs->smpr[1], adc->smpr_val[1]);
+
 	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
 		chan = indio_dev->channels + bit;
 		/*
@@ -1079,6 +1166,7 @@ static int stm32_adc_get_trig_pol(struct iio_dev *indio_dev,
  * @res: conversion result
  *
  * The function performs a single conversion on a given channel:
+ * - Apply sampling time settings
  * - Program sequencer with one channel (e.g. in SQ1 with len = 1)
  * - Use SW trigger
  * - Start conversion, then wait for interrupt completion.
@@ -1103,6 +1191,10 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 			return ret;
 	}
 
+	/* Apply sampling time settings */
+	stm32_adc_writel(adc, regs->smpr[0], adc->smpr_val[0]);
+	stm32_adc_writel(adc, regs->smpr[1], adc->smpr_val[1]);
+
 	/* Program chan number in regular sequence (SQ1) */
 	val = stm32_adc_readl(adc, regs->sqr[1].reg);
 	val &= ~regs->sqr[1].mask;
@@ -1507,10 +1599,28 @@ static int stm32_adc_of_get_resolution(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static void stm32_adc_smpr_init(struct stm32_adc *adc, int channel, u32 smp_ns)
+{
+	const struct stm32_adc_regs *smpr = &adc->cfg->regs->smp_bits[channel];
+	u32 period_ns, shift = smpr->shift, mask = smpr->mask;
+	unsigned int smp, r = smpr->reg;
+
+	/* Determine sampling time (ADC clock cycles) */
+	period_ns = NSEC_PER_SEC / adc->common->rate;
+	for (smp = 0; smp <= STM32_ADC_MAX_SMP; smp++)
+		if ((period_ns * adc->cfg->smp_cycles[smp]) >= smp_ns)
+			break;
+	if (smp > STM32_ADC_MAX_SMP)
+		smp = STM32_ADC_MAX_SMP;
+
+	/* pre-build sampling time registers (e.g. smpr1, smpr2) */
+	adc->smpr_val[r] = (adc->smpr_val[r] & ~mask) | (smp << shift);
+}
+
 static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 				    struct iio_chan_spec *chan,
 				    const struct stm32_adc_chan_spec *channel,
-				    int scan_index)
+				    int scan_index, u32 smp)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 
@@ -1526,6 +1636,9 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 	chan->scan_type.storagebits = 16;
 	chan->ext_info = stm32_adc_ext_info;
 
+	/* Prepare sampling time settings */
+	stm32_adc_smpr_init(adc, chan->channel, smp);
+
 	/* pre-build selected channels mask */
 	adc->pcsel |= BIT(chan->channel);
 }
@@ -1538,8 +1651,8 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
 	struct property *prop;
 	const __be32 *cur;
 	struct iio_chan_spec *channels;
-	int scan_index = 0, num_channels;
-	u32 val;
+	int scan_index = 0, num_channels, ret;
+	u32 val, smp = 0;
 
 	num_channels = of_property_count_u32_elems(node, "st,adc-channels");
 	if (num_channels < 0 ||
@@ -1548,6 +1661,13 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
 		return num_channels < 0 ? num_channels : -EINVAL;
 	}
 
+	/* Optional sample time is provided either for each, or all channels */
+	ret = of_property_count_u32_elems(node, "st,min-sample-time-nsecs");
+	if (ret > 1 && ret != num_channels) {
+		dev_err(&indio_dev->dev, "Invalid st,min-sample-time-nsecs\n");
+		return -EINVAL;
+	}
+
 	channels = devm_kcalloc(&indio_dev->dev, num_channels,
 				sizeof(struct iio_chan_spec), GFP_KERNEL);
 	if (!channels)
@@ -1558,9 +1678,19 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev)
 			dev_err(&indio_dev->dev, "Invalid channel %d\n", val);
 			return -EINVAL;
 		}
+
+		/*
+		 * Using of_property_read_u32_index(), smp value will only be
+		 * modified if valid u32 value can be decoded. This allows to
+		 * get either no value, 1 shared value for all indexes, or one
+		 * value per channel.
+		 */
+		of_property_read_u32_index(node, "st,min-sample-time-nsecs",
+					   scan_index, &smp);
+
 		stm32_adc_chan_init_one(indio_dev, &channels[scan_index],
 					&adc_info->channels[val],
-					scan_index);
+					scan_index, smp);
 		scan_index++;
 	}
 
@@ -1755,6 +1885,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	.clk_required = true,
 	.start_conv = stm32f4_adc_start_conv,
 	.stop_conv = stm32f4_adc_stop_conv,
+	.smp_cycles = stm32f4_adc_smp_cycles,
 };
 
 static const struct stm32_adc_cfg stm32h7_adc_cfg = {
@@ -1766,6 +1897,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
 	.unprepare = stm32h7_adc_unprepare,
+	.smp_cycles = stm32h7_adc_smp_cycles,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {
-- 
1.9.1

