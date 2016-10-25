Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49341 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S941850AbcJYQ1I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 12:27:08 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>
Subject: [PATCH 06/10] iio: adc: stm32: add ext attrs to configure sampling time
Date: Tue, 25 Oct 2016 18:25:18 +0200
Message-ID: <1477412722-24061-7-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add per channel "smpr" IIO extended attribute, to allow sampling
time configuration.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32/stm32-adc.c   | 75 +++++++++++++++++++++++++++++++++++++
 drivers/iio/adc/stm32/stm32-adc.h   | 25 +++++++++++++
 drivers/iio/adc/stm32/stm32f4-adc.c | 48 ++++++++++++++++++++++++
 3 files changed, 148 insertions(+)

diff --git a/drivers/iio/adc/stm32/stm32-adc.c b/drivers/iio/adc/stm32/stm32-adc.c
index 9b4b459..1681f75 100644
--- a/drivers/iio/adc/stm32/stm32-adc.c
+++ b/drivers/iio/adc/stm32/stm32-adc.c
@@ -38,6 +38,61 @@
 #include "stm32-adc.h"
 
 /**
+ * stm32_adc_conf_smp() - Configure sampling time for each channel
+ * @indio_dev: IIO device
+ * @scan_mask: channels to be converted
+ */
+static int stm32_adc_conf_smp(struct iio_dev *indio_dev,
+			      const unsigned long *scan_mask)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	const struct stm32_adc_regs *smp =
+		adc->common->data->adc_reginfo->smpr_regs;
+	struct stm32_adc_chan *stm32_chan;
+	const struct iio_chan_spec *chan;
+	u32 bit, val;
+	int i;
+
+	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
+		chan = indio_dev->channels + bit;
+		stm32_chan = to_stm32_chan(adc, chan);
+		i = chan->channel;
+
+		if (i >= adc->max_channels)
+			return -EINVAL;
+
+		val = stm32_adc_readl(adc, smp[i].reg);
+		val &= ~smp[i].mask;
+		val |= (stm32_chan->smpr << smp[i].shift) & smp[i].mask;
+		stm32_adc_writel(adc, smp[i].reg, val);
+	}
+
+	return 0;
+}
+
+int stm32_adc_set_smpr(struct iio_dev *indio_dev,
+		       const struct iio_chan_spec *chan, unsigned int smpr)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	struct stm32_adc_chan *stm32_chan = to_stm32_chan(adc, chan);
+
+	stm32_chan->smpr = smpr;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_adc_set_smpr);
+
+int stm32_adc_get_smpr(struct iio_dev *indio_dev,
+		       const struct iio_chan_spec *chan)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	struct stm32_adc_chan *stm32_chan = to_stm32_chan(adc, chan);
+
+	return stm32_chan->smpr;
+}
+EXPORT_SYMBOL_GPL(stm32_adc_get_smpr);
+
+/**
  * stm32_adc_conf_scan_seq() - Build regular or injected channels scan sequence
  * @indio_dev: IIO device
  * @scan_mask: channels to be converted
@@ -126,6 +181,12 @@ static int stm32_adc_conf_scan(struct iio_dev *indio_dev,
 		return ret;
 	}
 
+	ret = stm32_adc_conf_smp(indio_dev, scan_mask);
+	if (ret) {
+		dev_err(&indio_dev->dev, "Failed to configure samp time\n");
+		goto err_dis;
+	}
+
 	ret = stm32_adc_conf_scan_seq(indio_dev, scan_mask);
 	if (ret) {
 		dev_err(&indio_dev->dev, "Failed to configure sequence\n");
@@ -938,6 +999,7 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev,
 				  const struct stm32_adc_info *adc_info)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
+	struct stm32_adc_common *common = adc->common;
 	struct device_node *node = indio_dev->dev.of_node;
 	struct property *prop;
 	const __be32 *cur;
@@ -945,6 +1007,19 @@ static int stm32_adc_chan_of_init(struct iio_dev *indio_dev,
 	int scan_index = 0, num_channels = 0;
 	u32 val;
 
+	if (!common->stm32_chans[adc->id]) {
+		/* Allocate extended attributes structure for an instance */
+		struct stm32_adc_chan *stm32_chans;
+
+		stm32_chans = devm_kcalloc(&indio_dev->dev,
+					   adc_info->max_channels,
+					   sizeof(*stm32_chans), GFP_KERNEL);
+		if (!stm32_chans)
+			return -ENOMEM;
+
+		common->stm32_chans[adc->id] = stm32_chans;
+	}
+
 	of_property_for_each_u32(node, "st,adc-channels", prop, cur, val)
 		num_channels++;
 
diff --git a/drivers/iio/adc/stm32/stm32-adc.h b/drivers/iio/adc/stm32/stm32-adc.h
index 6c9b70d..8cf1d5c 100644
--- a/drivers/iio/adc/stm32/stm32-adc.h
+++ b/drivers/iio/adc/stm32/stm32-adc.h
@@ -143,6 +143,14 @@ struct stm32_adc_chan_spec {
 };
 
 /**
+ * struct stm32_adc_chan - Extended specifications of stm32 adc channels
+ * @smpr: per channel sampling time selection
+ */
+struct stm32_adc_chan {
+	unsigned smpr:3;
+};
+
+/**
  * struct stm32_adc_trig_info - ADC trigger info
  * @extsel:		trigger selection for regular or injected
  * @name:		name of the trigger, corresponding to its source
@@ -206,6 +214,7 @@ struct stm32_adc_trig_reginfo {
  * @jdr:		injected data registers offsets
  * @sqr_regs:		Regular sequence registers description
  * @jsqr_reg:		Injected sequence register description
+ * @smpr_regs:		Sampling time registers description
  * @trig_reginfo:	regular trigger control registers description
  * @jtrig_reginfo:	injected trigger control registers description
  */
@@ -220,6 +229,7 @@ struct stm32_adc_reginfo {
 	u32 jdr[4];
 	const struct stm32_adc_regs *sqr_regs;
 	const struct stm32_adc_regs *jsqr_reg;
+	const struct stm32_adc_regs *smpr_regs;
 	const struct stm32_adc_trig_reginfo *trig_reginfo;
 	const struct stm32_adc_trig_reginfo *jtrig_reginfo;
 };
@@ -328,6 +338,7 @@ struct stm32_adc {
  * @aclk:		common clock for the analog circuitry
  * @vref:		regulator reference
  * @vref_mv:		vref voltage (mv)
+ * @stm32_chans:	stm32 channels extended specification data
  * @gpio_descs:		gpio descriptor used to configure EXTi triggers
  * @lock:		mutex
  */
@@ -341,11 +352,21 @@ struct stm32_adc_common {
 	struct clk			*aclk;
 	struct regulator		*vref;
 	int				vref_mv;
+	struct stm32_adc_chan		*stm32_chans[STM32_ADC_ID_MAX];
 	struct gpio_descs		*gpios;
 	struct mutex			lock;	/* read_raw lock */
 };
 
 /* Helper routines */
+static inline struct stm32_adc_chan *to_stm32_chan(struct stm32_adc *adc,
+						   const struct iio_chan_spec
+						   *chan)
+{
+	struct stm32_adc_chan *stm32_chans = adc->common->stm32_chans[adc->id];
+
+	return &stm32_chans[chan->channel];
+}
+
 static inline int stm32_adc_start_conv(struct stm32_adc *adc)
 {
 	return adc->common->data->start_conv(adc);
@@ -458,6 +479,10 @@ static inline void stm32_adc_clr_bits(struct stm32_adc *adc, u32 reg, u32 bits)
 
 /* STM32 common extended attributes */
 extern const struct iio_enum stm32_adc_trig_pol;
+int stm32_adc_set_smpr(struct iio_dev *indio_dev,
+		       const struct iio_chan_spec *chan, unsigned int smpr);
+int stm32_adc_get_smpr(struct iio_dev *indio_dev,
+		       const struct iio_chan_spec *chan);
 int stm32_adc_probe(struct platform_device *pdev);
 int stm32_adc_remove(struct platform_device *pdev);
 
diff --git a/drivers/iio/adc/stm32/stm32f4-adc.c b/drivers/iio/adc/stm32/stm32f4-adc.c
index e033a68..e0e6211 100644
--- a/drivers/iio/adc/stm32/stm32f4-adc.c
+++ b/drivers/iio/adc/stm32/stm32f4-adc.c
@@ -330,6 +330,32 @@ enum stm32f4_adc_smpr {
 };
 
 /**
+ * stm32f4_smpr_regs[] - describe sampling time registers & bit fields
+ * Sorted so it can be indexed by channel number.
+ */
+static const struct stm32_adc_regs stm32f4_smpr_regs[] = {
+	{ STM32F4_ADCX_SMPR2, STM32F4_SMP0_MASK, STM32F4_SMP0_SHIFT },
+	{ STM32F4_ADCX_SMPR2, STM32F4_SMP1_MASK, STM32F4_SMP1_SHIFT },
+	{ STM32F4_ADCX_SMPR2, STM32F4_SMP2_MASK, STM32F4_SMP2_SHIFT },
+	{ STM32F4_ADCX_SMPR2, STM32F4_SMP3_MASK, STM32F4_SMP3_SHIFT },
+	{ STM32F4_ADCX_SMPR2, STM32F4_SMP4_MASK, STM32F4_SMP4_SHIFT },
+	{ STM32F4_ADCX_SMPR2, STM32F4_SMP5_MASK, STM32F4_SMP5_SHIFT },
+	{ STM32F4_ADCX_SMPR2, STM32F4_SMP6_MASK, STM32F4_SMP6_SHIFT },
+	{ STM32F4_ADCX_SMPR2, STM32F4_SMP7_MASK, STM32F4_SMP7_SHIFT },
+	{ STM32F4_ADCX_SMPR2, STM32F4_SMP8_MASK, STM32F4_SMP8_SHIFT },
+	{ STM32F4_ADCX_SMPR2, STM32F4_SMP9_MASK, STM32F4_SMP9_SHIFT },
+	{ STM32F4_ADCX_SMPR1, STM32F4_SMP10_MASK, STM32F4_SMP10_SHIFT },
+	{ STM32F4_ADCX_SMPR1, STM32F4_SMP11_MASK, STM32F4_SMP11_SHIFT },
+	{ STM32F4_ADCX_SMPR1, STM32F4_SMP12_MASK, STM32F4_SMP12_SHIFT },
+	{ STM32F4_ADCX_SMPR1, STM32F4_SMP13_MASK, STM32F4_SMP13_SHIFT },
+	{ STM32F4_ADCX_SMPR1, STM32F4_SMP14_MASK, STM32F4_SMP14_SHIFT },
+	{ STM32F4_ADCX_SMPR1, STM32F4_SMP15_MASK, STM32F4_SMP15_SHIFT },
+	{ STM32F4_ADCX_SMPR1, STM32F4_SMP16_MASK, STM32F4_SMP16_SHIFT },
+	{ STM32F4_ADCX_SMPR1, STM32F4_SMP17_MASK, STM32F4_SMP17_SHIFT },
+	{ STM32F4_ADCX_SMPR1, STM32F4_SMP18_MASK, STM32F4_SMP18_SHIFT },
+};
+
+/**
  * stm32f4_sqr_regs - describe regular sequence registers
  * - L: sequence len (register & bit field)
  * - SQ1..SQ16: sequence entries (register & bit field)
@@ -407,6 +433,7 @@ enum stm32f4_adc_smpr {
 	},
 	.sqr_regs = stm32f4_sqr_regs,
 	.jsqr_reg = stm32f4_jsqr_reg,
+	.smpr_regs = stm32f4_smpr_regs,
 	.trig_reginfo = &stm32f4_adc_trig_reginfo,
 	.jtrig_reginfo = &stm32f4_adc_jtrig_reginfo,
 };
@@ -555,7 +582,28 @@ static int stm32f4_adc_clk_sel(struct stm32_adc *adc)
 	return 0;
 }
 
+/* stm32f4_smpr_items : Channel-wise programmable sampling time */
+static const char * const stm32f4_smpr_items[] = {
+	[STM32F4_SMPR_3_CK_CYCLES] = "3_cycles",
+	[STM32F4_SMPR_15_CK_CYCLES] = "15_cycles",
+	[STM32F4_SMPR_28_CK_CYCLES] = "28_cycles",
+	[STM32F4_SMPR_56_CK_CYCLES] = "56_cycles",
+	[STM32F4_SMPR_84_CK_CYCLES] = "84_cycles",
+	[STM32F4_SMPR_112_CK_CYCLES] = "112_cycles",
+	[STM32F4_SMPR_144_CK_CYCLES] = "144_cycles",
+	[STM32F4_SMPR_480_CK_CYCLES] = "480_cycles",
+};
+
+static const struct iio_enum stm32f4_smpr = {
+	.items = stm32f4_smpr_items,
+	.num_items = ARRAY_SIZE(stm32f4_smpr_items),
+	.get = stm32_adc_get_smpr,
+	.set = stm32_adc_set_smpr,
+};
+
 static const struct iio_chan_spec_ext_info stm32f4_adc_ext_info[] = {
+	IIO_ENUM("smpr", IIO_SEPARATE, &stm32f4_smpr),
+	IIO_ENUM_AVAILABLE("smpr", &stm32f4_smpr),
 	IIO_ENUM("trigger_pol", IIO_SHARED_BY_ALL, &stm32_adc_trig_pol),
 	{
 		.name = "trigger_pol_available",
-- 
1.9.1

