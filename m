Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:59190 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbdKGOZc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Nov 2017 09:25:32 -0500
From: Yixun Lan <yixun.lan@amlogic.com>
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/4] iio: adc: meson-saradc: remove irrelevant clock "sana"
Date: Tue, 7 Nov 2017 22:10:06 +0800
Message-ID: <20171107141006.30091-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

The "sana" clock is not used at SAR ADC module in Amlogic Meson SoC,
it is irrelevant for the SAR ADC.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/iio/adc/meson_saradc.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 2e8dbb89c8c9..f7dcf187fb43 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -231,7 +231,6 @@ struct meson_sar_adc_priv {
 	const struct meson_sar_adc_data		*data;
 	struct clk				*clkin;
 	struct clk				*core_clk;
-	struct clk				*sana_clk;
 	struct clk				*adc_sel_clk;
 	struct clk				*adc_clk;
 	struct clk_gate				clk_gate;
@@ -708,12 +707,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 		goto err_core_clk;
 	}
 
-	ret = clk_prepare_enable(priv->sana_clk);
-	if (ret) {
-		dev_err(indio_dev->dev.parent, "failed to enable sana clk\n");
-		goto err_sana_clk;
-	}
-
 	regval = FIELD_PREP(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, 1);
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
 			   MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
@@ -741,8 +734,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
 			   MESON_SAR_ADC_REG3_ADC_EN, 0);
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 			   MESON_SAR_ADC_REG11_BANDGAP_EN, 0);
-	clk_disable_unprepare(priv->sana_clk);
-err_sana_clk:
 	clk_disable_unprepare(priv->core_clk);
 err_core_clk:
 	regulator_disable(priv->vref);
@@ -768,7 +759,6 @@ static int meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
 	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
 			   MESON_SAR_ADC_REG11_BANDGAP_EN, 0);
 
-	clk_disable_unprepare(priv->sana_clk);
 	clk_disable_unprepare(priv->core_clk);
 
 	regulator_disable(priv->vref);
@@ -962,16 +952,6 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->core_clk);
 	}
 
-	priv->sana_clk = devm_clk_get(&pdev->dev, "sana");
-	if (IS_ERR(priv->sana_clk)) {
-		if (PTR_ERR(priv->sana_clk) == -ENOENT) {
-			priv->sana_clk = NULL;
-		} else {
-			dev_err(&pdev->dev, "failed to get sana clk\n");
-			return PTR_ERR(priv->sana_clk);
-		}
-	}
-
 	priv->adc_clk = devm_clk_get(&pdev->dev, "adc_clk");
 	if (IS_ERR(priv->adc_clk)) {
 		if (PTR_ERR(priv->adc_clk) == -ENOENT) {
-- 
2.14.1

