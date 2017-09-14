Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:60868 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751318AbdINOxe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Sep 2017 10:53:34 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 2/6] iio: adc: sun4i-gpadc-iio: rename A33-specified registers to contain A33
Date: Thu, 14 Sep 2017 22:52:47 +0800
Message-Id: <20170914145251.21784-3-icenowy@aosc.io>
In-Reply-To: <20170914145251.21784-1-icenowy@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As the H3 SoC, which is also in sun8i line, has totally different
register map for the thermal sensor (a cut down version of GPADC), we
should rename A23/A33-specified registers to contain A33, in order to
prevent obfuscation with H3 registers. Currently these registers are
only prefixed "SUN8I", not "SUN8I_A33".

Add "_A33" after "SUN8I" on the register names.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v4:
- Change A23 to A33, as the driver never supports A23.

 drivers/iio/adc/sun4i-gpadc-iio.c | 2 +-
 include/linux/mfd/sun4i-gpadc.h   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 137f577d9432..68926b986cd0 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -88,7 +88,7 @@ static const struct gpadc_data sun6i_gpadc_data = {
 static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_offset = -1662,
 	.temp_scale = 162,
-	.tp_mode_en = SUN8I_GPADC_CTRL1_CHOP_TEMP_EN,
+	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
 };
 
 struct sun4i_gpadc_iio {
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 139872c2e0fe..78d31984a222 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -38,9 +38,9 @@
 #define SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(3, 0) & BIT(x))
 #define SUN6I_GPADC_CTRL1_ADC_CHAN_MASK			GENMASK(3, 0)
 
-/* TP_CTRL1 bits for sun8i SoCs */
-#define SUN8I_GPADC_CTRL1_CHOP_TEMP_EN			BIT(8)
-#define SUN8I_GPADC_CTRL1_GPADC_CALI_EN			BIT(7)
+/* TP_CTRL1 bits for A33 */
+#define SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN		BIT(8)
+#define SUN8I_A33_GPADC_CTRL1_GPADC_CALI_EN		BIT(7)
 
 #define SUN4I_GPADC_CTRL2				0x08
 
-- 
2.13.5

