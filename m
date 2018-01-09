Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45683 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbeAIJfB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jan 2018 04:35:01 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 01/16] iio: adc: axp20x_adc: put ADC rate setting in a per-variant function
Date: Tue,  9 Jan 2018 10:33:32 +0100
Message-Id: <e50850aeb3a121a546c39704edceda0c052a0cb1.1515486346.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

To prepare for a new comer that set a different register with different
values, move rate setting in a function that is specific to each AXP
variant.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/iio/adc/axp20x_adc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index a30a972..3fc1b06 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -470,14 +470,18 @@ static const struct iio_info axp22x_adc_iio_info = {
 	.read_raw = axp22x_read_raw,
 };
 
-static int axp20x_adc_rate(int rate)
+static int axp20x_adc_rate(struct axp20x_adc_iio *info, int rate)
 {
-	return AXP20X_ADC_RATE_HZ(rate);
+	return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
+				  AXP20X_ADC_RATE_MASK,
+				  AXP20X_ADC_RATE_HZ(rate));
 }
 
-static int axp22x_adc_rate(int rate)
+static int axp22x_adc_rate(struct axp20x_adc_iio *info, int rate)
 {
-	return AXP22X_ADC_RATE_HZ(rate);
+	return regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
+				  AXP20X_ADC_RATE_MASK,
+				  AXP22X_ADC_RATE_HZ(rate));
 }
 
 struct axp_data {
@@ -485,7 +489,8 @@ struct axp_data {
 	int				num_channels;
 	struct iio_chan_spec const	*channels;
 	unsigned long			adc_en1_mask;
-	int				(*adc_rate)(int rate);
+	int				(*adc_rate)(struct axp20x_adc_iio *info,
+						    int rate);
 	bool				adc_en2;
 	struct iio_map			*maps;
 };
@@ -554,8 +559,7 @@ static int axp20x_probe(struct platform_device *pdev)
 				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
 
 	/* Configure ADCs rate */
-	regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MASK,
-			   info->data->adc_rate(100));
+	info->data->adc_rate(info, 100);
 
 	ret = iio_map_array_register(indio_dev, info->data->maps);
 	if (ret < 0) {
-- 
git-series 0.9.1
