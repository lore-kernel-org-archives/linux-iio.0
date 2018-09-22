Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39606 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeIWEQV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Sep 2018 00:16:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so6567183wmq.4
        for <linux-iio@vger.kernel.org>; Sat, 22 Sep 2018 15:21:12 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] iio: adc: meson-saradc: remove #define MESON_SAR_ADC_DELTA_10_TS_C_SHIFT
Date: Sun, 23 Sep 2018 00:21:00 +0200
Message-Id: <20180922222102.12023-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20180922222102.12023-1-martin.blumenstingl@googlemail.com>
References: <20180922222102.12023-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This define is of no use because the driver is avoiding shifting bits
by itself but using FIELD_GET/FIELD_PREP (which are using bit masks)
instead. There is already a MESON_SAR_ADC_DELTA_10_TS_C_MASK bit mask so
MESON_SAR_ADC_DELTA_10_TS_C_SHIFT was redundant.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index da2d16dfa63e..b97b06bf7713 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -148,7 +148,6 @@
 	#define MESON_SAR_ADC_DELTA_10_TS_REVE1			BIT(26)
 	#define MESON_SAR_ADC_DELTA_10_CHAN1_DELTA_VALUE_MASK	GENMASK(25, 16)
 	#define MESON_SAR_ADC_DELTA_10_TS_REVE0			BIT(15)
-	#define MESON_SAR_ADC_DELTA_10_TS_C_SHIFT		11
 	#define MESON_SAR_ADC_DELTA_10_TS_C_MASK		GENMASK(14, 11)
 	#define MESON_SAR_ADC_DELTA_10_TS_VBG_EN		BIT(10)
 	#define MESON_SAR_ADC_DELTA_10_CHAN0_DELTA_VALUE_MASK	GENMASK(9, 0)
-- 
2.19.0
