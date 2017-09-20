Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:41635 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751818AbdITPSs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Sep 2017 11:18:48 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 2/7] iio: adc: axp20x-adc: allow to skip ADC rate setup now
Date: Wed, 20 Sep 2017 23:18:09 +0800
Message-Id: <20170920151814.22461-3-icenowy@aosc.io>
In-Reply-To: <20170920151814.22461-1-icenowy@aosc.io>
References: <20170920151814.22461-1-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADC rate setup on AXP803 is more complex than AXP20x/22x.

As it's not a necessary setup, allow it to be skipped, to allow simpler
AXP803 support now.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/iio/adc/axp20x_adc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 11e177180ea0..93dd6b80059e 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -556,8 +556,10 @@ static int axp20x_probe(struct platform_device *pdev)
 				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
 
 	/* Configure ADCs rate */
-	regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MASK,
-			   info->data->adc_rate(100));
+	if (info->data->adc_rate)
+		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
+				   AXP20X_ADC_RATE_MASK,
+				   info->data->adc_rate(100));
 
 	ret = iio_map_array_register(indio_dev, info->data->maps);
 	if (ret < 0) {
-- 
2.13.5

