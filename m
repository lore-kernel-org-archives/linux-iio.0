Return-Path: <SRS0=q78n=B6=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/5] iio: adc: meson-saradc: fix the clock frequency on Meson8 and Meson8b
Date: Tue, 31 Oct 2017 21:01:46 +0100
Message-Id: <20171031200147.14660-5-martin.blumenstingl@googlemail.com>
In-Reply-To: <20171031200147.14660-1-martin.blumenstingl@googlemail.com>
References: <20171031200147.14660-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

GX SoCs use a 1.2 MHz ADC clock, while the older SoCs use a 1.14 MHz
clock.

A comment in the driver from Amlogic's GPL kernel says that it's
running at 1.28 MHz. However, it's actually programming a divider of
20 + 1. With a XTAL clock of 24 MHz this results in a frequency of
1.14 MHz. (their calculation might be based on a 27 MHz XTAL clock,
but this is not what we have on the Meson8 and Meson8b SoCs).

The ADC was still working with the 1.2MHz clock. In my own tests I did
not see a difference between 1.2 and 1.14 MHz (regardless of the clock
frequency used, the ADC results were identical).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 7dc7d297a0fc..fa3c1378c2c9 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -221,6 +221,7 @@ enum meson_sar_adc_chan7_mux_sel {
 
 struct meson_sar_adc_data {
 	bool					has_bl30_integration;
+	unsigned long				clock_rate;
 	u32					bandgap_reg;
 	unsigned int				resolution;
 	const char				*name;
@@ -684,7 +685,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	ret = clk_set_rate(priv->adc_clk, 1200000);
+	ret = clk_set_rate(priv->adc_clk, priv->data->clock_rate);
 	if (ret) {
 		dev_err(indio_dev->dev.parent,
 			"failed to set adc clock rate\n");
@@ -867,6 +868,7 @@ static const struct iio_info meson_sar_adc_iio_info = {
 
 static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
 	.has_bl30_integration = false,
+	.clock_rate = 1150000,
 	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
 	.regmap_config = &meson_sar_adc_regmap_config_meson8,
 	.resolution = 10,
@@ -875,6 +877,7 @@ static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
 
 static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
 	.has_bl30_integration = false,
+	.clock_rate = 1150000,
 	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
 	.regmap_config = &meson_sar_adc_regmap_config_meson8,
 	.resolution = 10,
@@ -883,6 +886,7 @@ static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
 
 static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
 	.has_bl30_integration = true,
+	.clock_rate = 1200000,
 	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 10,
@@ -891,6 +895,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
 
 static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
 	.has_bl30_integration = true,
+	.clock_rate = 1200000,
 	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 12,
@@ -899,6 +904,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
 
 static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
 	.has_bl30_integration = true,
+	.clock_rate = 1200000,
 	.bandgap_reg = MESON_SAR_ADC_REG11,
 	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
 	.resolution = 12,
-- 
2.15.0
