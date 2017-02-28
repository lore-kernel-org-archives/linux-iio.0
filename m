Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24287 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751356AbdB1RM1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2017 12:12:27 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linus.walleij@linaro.org>
Subject: [PATCH v3 6/6] iio: adc: stm32: add support for EXTI trigger
Date: Tue, 28 Feb 2017 17:51:19 +0100
Message-ID: <1488300679-3259-7-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

EXTi (external interrupt) signal can be routed internally as trigger
source for ADC conversions: STM32F4 ADC can use EXTI11.

Retrieve interrupt trigger from DT, so it can be muxed into ADC IP,
via extsel.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-adc.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 9b49a6ad..4d9040d 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -108,6 +108,9 @@ enum stm32_adc_extsel {
 	STM32_EXT15,
 };
 
+/* EXTI 11 trigger selection on STM32F4 */
+#define STM32F4_EXTI11_EXTSEL		STM32_EXT15
+
 /**
  * struct stm32_adc_trig_info - ADC trigger info
  * @name:		name of the trigger, corresponding to its source
@@ -146,6 +149,7 @@ struct stm32_adc_regs {
  * @rx_buf:		dma rx buffer cpu address
  * @rx_dma_buf:		dma rx buffer bus address
  * @rx_buf_sz:		dma rx buffer size
+ * @exti_trig		EXTI trigger
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -162,6 +166,7 @@ struct stm32_adc {
 	u8			*rx_buf;
 	dma_addr_t		rx_dma_buf;
 	unsigned int		rx_buf_sz;
+	struct iio_trigger	*exti_trig;
 };
 
 /**
@@ -395,10 +400,15 @@ static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
  *
  * Returns trigger extsel value, if trig matches, -EINVAL otherwise.
  */
-static int stm32_adc_get_trig_extsel(struct iio_trigger *trig)
+static int stm32_adc_get_trig_extsel(struct iio_dev *indio_dev,
+				     struct iio_trigger *trig)
 {
+	struct stm32_adc *adc = iio_priv(indio_dev);
 	int i;
 
+	if (trig == adc->exti_trig)
+		return STM32F4_EXTI11_EXTSEL;
+
 	/* lookup triggers registered by stm32 timer trigger driver */
 	for (i = 0; stm32f4_adc_trigs[i].name; i++) {
 		/**
@@ -432,7 +442,7 @@ static int stm32_adc_set_trig(struct iio_dev *indio_dev,
 	int ret;
 
 	if (trig) {
-		ret = stm32_adc_get_trig_extsel(trig);
+		ret = stm32_adc_get_trig_extsel(indio_dev, trig);
 		if (ret < 0)
 			return ret;
 
@@ -604,7 +614,7 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
 static int stm32_adc_validate_trigger(struct iio_dev *indio_dev,
 				      struct iio_trigger *trig)
 {
-	return stm32_adc_get_trig_extsel(trig) < 0 ? -EINVAL : 0;
+	return stm32_adc_get_trig_extsel(indio_dev, trig) < 0 ? -EINVAL : 0;
 }
 
 static int stm32_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
@@ -1030,6 +1040,17 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_clk_disable;
 
+	adc->exti_trig = devm_iio_trigger_get_by_name(&pdev->dev, "exti");
+	if (IS_ERR(adc->exti_trig)) {
+		ret = PTR_ERR(adc->exti_trig);
+		if (ret == -EPROBE_DEFER)
+			goto err_dma_disable;
+		dev_dbg(&pdev->dev, "No exti trigger found (%d)\n", ret);
+		adc->exti_trig = NULL;
+	} else {
+		dev_info(&pdev->dev, "Can use %s\n", adc->exti_trig->name);
+	}
+
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 &iio_pollfunc_store_time,
 					 &stm32_adc_trigger_handler,
-- 
1.9.1

