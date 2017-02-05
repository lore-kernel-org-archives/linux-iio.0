Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36311 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdBENHG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2017 08:07:06 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Roland Stigge <stigge@antcom.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/3] staging:iio:adc:lpc32xx Apply consistent prefix to local defines
Date: Sun,  5 Feb 2017 13:06:58 +0000
Message-Id: <20170205130700.5063-2-jic23@kernel.org>
In-Reply-To: <20170205130700.5063-1-jic23@kernel.org>
References: <20170205130700.5063-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There was a bit of a random mixture going on here so change all prefixes
to LPC32XXAD_

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/lpc32xx_adc.c | 54 +++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index b51f237cd817..5d13ff008a39 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -38,25 +38,28 @@
 /*
  * LPC32XX registers definitions
  */
-#define LPC32XX_ADC_SELECT(x)	((x) + 0x04)
-#define LPC32XX_ADC_CTRL(x)	((x) + 0x08)
-#define LPC32XX_ADC_VALUE(x)	((x) + 0x48)
+#define LPC32XXAD_SELECT(x)	((x) + 0x04)
+#define LPC32XXAD_CTRL(x)	((x) + 0x08)
+#define LPC32XXAD_VALUE(x)	((x) + 0x48)
 
-/* Bit definitions for LPC32XX_ADC_SELECT: */
-#define AD_REFm         0x00000200 /* constant, always write this value! */
-#define AD_REFp		0x00000080 /* constant, always write this value! */
-#define AD_IN		0x00000010 /* multiple of this is the */
-				   /* channel number: 0, 1, 2 */
-#define AD_INTERNAL	0x00000004 /* constant, always write this value! */
+/* Bit definitions for LPC32XXAD_SELECT: */
+/* constant, always write this value! */
+#define LPC32XXAD_REFm         0x00000200
+/* constant, always write this value! */
+#define LPC32XXAD_REFp		0x00000080
+ /* multiple of this is the channel number: 0, 1, 2 */
+#define LPC32XXAD_IN		0x00000010
+/* constant, always write this value! */
+#define LPC32XXAD_INTERNAL	0x00000004
 
-/* Bit definitions for LPC32XX_ADC_CTRL: */
-#define AD_STROBE	0x00000002
-#define AD_PDN_CTRL	0x00000004
+/* Bit definitions for LPC32XXAD_CTRL: */
+#define LPC32XXAD_STROBE	0x00000002
+#define LPC32XXAD_PDN_CTRL	0x00000004
 
-/* Bit definitions for LPC32XX_ADC_VALUE: */
-#define ADC_VALUE_MASK	0x000003FF
+/* Bit definitions for LPC32XXAD_VALUE: */
+#define LPC32XXAD_VALUE_MASK	0x000003FF
 
-#define MOD_NAME "lpc32xx-adc"
+#define LPC32XXAD_NAME "lpc32xx-adc"
 
 struct lpc32xx_adc_info {
 	void __iomem *adc_base;
@@ -78,11 +81,12 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
 		mutex_lock(&indio_dev->mlock);
 		clk_prepare_enable(info->clk);
 		/* Measurement setup */
-		__raw_writel(AD_INTERNAL | (chan->address) | AD_REFp | AD_REFm,
-			     LPC32XX_ADC_SELECT(info->adc_base));
+		__raw_writel(LPC32XXAD_INTERNAL | (chan->address) |
+			     LPC32XXAD_REFp | LPC32XXAD_REFm,
+			     LPC32XXAD_SELECT(info->adc_base));
 		/* Trigger conversion */
-		__raw_writel(AD_PDN_CTRL | AD_STROBE,
-			     LPC32XX_ADC_CTRL(info->adc_base));
+		__raw_writel(LPC32XXAD_PDN_CTRL | LPC32XXAD_STROBE,
+			     LPC32XXAD_CTRL(info->adc_base));
 		wait_for_completion(&info->completion); /* set by ISR */
 		clk_disable_unprepare(info->clk);
 		*val = info->value;
@@ -104,7 +108,7 @@ static const struct iio_info lpc32xx_adc_iio_info = {
 	.indexed = 1,					\
 	.channel = _index,				\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-	.address = AD_IN * _index,			\
+	.address = LPC32XXAD_IN * _index,		\
 	.scan_index = _index,				\
 }
 
@@ -119,8 +123,8 @@ static irqreturn_t lpc32xx_adc_isr(int irq, void *dev_id)
 	struct lpc32xx_adc_info *info = dev_id;
 
 	/* Read value and clear irq */
-	info->value = __raw_readl(LPC32XX_ADC_VALUE(info->adc_base)) &
-				ADC_VALUE_MASK;
+	info->value = __raw_readl(LPC32XXAD_VALUE(info->adc_base)) &
+				LPC32XXAD_VALUE_MASK;
 	complete(&info->completion);
 
 	return IRQ_HANDLED;
@@ -166,7 +170,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	}
 
 	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
-				  MOD_NAME, info);
+				  LPC32XXAD_NAME, info);
 	if (retval < 0) {
 		dev_err(&pdev->dev, "failed requesting interrupt\n");
 		return retval;
@@ -176,7 +180,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 
 	init_completion(&info->completion);
 
-	iodev->name = MOD_NAME;
+	iodev->name = LPC32XXAD_NAME;
 	iodev->dev.parent = &pdev->dev;
 	iodev->info = &lpc32xx_adc_iio_info;
 	iodev->modes = INDIO_DIRECT_MODE;
@@ -203,7 +207,7 @@ MODULE_DEVICE_TABLE(of, lpc32xx_adc_match);
 static struct platform_driver lpc32xx_adc_driver = {
 	.probe		= lpc32xx_adc_probe,
 	.driver		= {
-		.name	= MOD_NAME,
+		.name	= LPC32XXAD_NAME,
 		.of_match_table = of_match_ptr(lpc32xx_adc_match),
 	},
 };
-- 
2.11.1

