Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33884 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdBNV7C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2017 16:59:02 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so5582388wmi.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Feb 2017 13:59:01 -0800 (PST)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/2] iio: adc: meson-saradc: switch from polling to interrupt
 mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Message-ID: <1675b5cb-9348-de5d-b4f9-dc6d9b5c4798@gmail.com>
Date: Tue, 14 Feb 2017 22:58:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch from polling to interrupt mode.

Successfully tested on a S905GXBB-based Odroid C2.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/iio/adc/meson_saradc.c | 46 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 89def603..dbd56bcc 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -18,7 +18,9 @@
 #include <linux/io.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -163,6 +165,7 @@
 	#define MESON_SAR_ADC_REG13_12BIT_CALIBRATION_MASK	GENMASK(13, 8)
 
 #define MESON_SAR_ADC_MAX_FIFO_SIZE				32
+#define MESON_SAR_ADC_TIMEOUT					100 /* ms */
 
 #define MESON_SAR_ADC_CHAN(_chan) {					\
 	.type = IIO_VOLTAGE,						\
@@ -229,6 +232,7 @@ struct meson_sar_adc_priv {
 	struct clk_gate				clk_gate;
 	struct clk				*adc_div_clk;
 	struct clk_divider			clk_div;
+	struct completion			done;
 };
 
 static const struct regmap_config meson_sar_adc_regmap_config = {
@@ -274,11 +278,11 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
 					 int *val)
 {
 	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
-	int ret, regval, fifo_chan, fifo_val, sum = 0, count = 0;
+	int regval, fifo_chan, fifo_val, sum = 0, count = 0;
 
-	ret = meson_sar_adc_wait_busy_clear(indio_dev);
-	if (ret)
-		return ret;
+	if(!wait_for_completion_timeout(&priv->done,
+				msecs_to_jiffies(MESON_SAR_ADC_TIMEOUT)))
+		return -ETIMEDOUT;
 
 	while (meson_sar_adc_get_fifo_count(indio_dev) > 0 &&
 	       count < MESON_SAR_ADC_MAX_FIFO_SIZE) {
@@ -456,6 +460,7 @@ static int meson_sar_adc_get_sample(struct iio_dev *indio_dev,
 				    enum meson_sar_adc_num_samples avg_samples,
 				    int *val)
 {
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
 	int ret;
 
 	ret = meson_sar_adc_lock(indio_dev);
@@ -465,6 +470,11 @@ static int meson_sar_adc_get_sample(struct iio_dev *indio_dev,
 	/* clear the FIFO to make sure we're not reading old values */
 	meson_sar_adc_clear_fifo(indio_dev);
 
+	reinit_completion(&priv->done);
+	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN,
+			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN);
+
 	meson_sar_adc_set_averaging(indio_dev, chan, avg_mode, avg_samples);
 
 	meson_sar_adc_enable_channel(indio_dev, chan);
@@ -473,6 +483,9 @@ static int meson_sar_adc_get_sample(struct iio_dev *indio_dev,
 	ret = meson_sar_adc_read_raw_sample(indio_dev, chan, val);
 	meson_sar_adc_stop_sample_engine(indio_dev);
 
+	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			   MESON_SAR_ADC_REG0_FIFO_IRQ_EN, 0);
+
 	meson_sar_adc_unlock(indio_dev);
 
 	if (ret) {
@@ -577,6 +590,9 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 	 */
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_CH7_INPUT);
 
+	regval = FIELD_PREP(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, 1);
+	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
+			   MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
 	/*
 	 * leave sampling delay and the input clocks as configured by BL30 to
 	 * make sure BL30 gets the values it expects when reading the
@@ -728,6 +744,16 @@ static int meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static irqreturn_t meson_sar_adc_irq(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
+
+	complete(&priv->done);
+
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info meson_sar_adc_iio_info = {
 	.read_raw = meson_sar_adc_iio_info_read_raw,
 	.driver_module = THIS_MODULE,
@@ -770,7 +796,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 	const struct of_device_id *match;
-	int ret;
+	int irq, ret;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
 	if (!indio_dev) {
@@ -779,6 +805,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	}
 
 	priv = iio_priv(indio_dev);
+	init_completion(&priv->done);
 
 	match = of_match_device(meson_sar_adc_of_match, &pdev->dev);
 	priv->data = match->data;
@@ -797,6 +824,15 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (!irq)
+		return -EINVAL;
+
+	ret = devm_request_irq(&pdev->dev, irq, meson_sar_adc_irq, 0,
+			       dev_name(&pdev->dev), indio_dev);
+	if (ret)
+		return ret;
+
 	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					     &meson_sar_adc_regmap_config);
 	if (IS_ERR(priv->regmap))
-- 
2.11.1

