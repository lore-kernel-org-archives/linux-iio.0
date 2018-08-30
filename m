Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53882 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbeH3TsX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:23 -0400
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        geert+renesas@glider.be, lukas@wunner.de, icenowy@aosc.io,
        arnd@arndb.de, broonie@kernel.org, arnaud.pouliquen@st.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 16/30] iio: adc: sun4i-gpadc-iio: rework: readout temp_data
Date: Thu, 30 Aug 2018 17:45:04 +0200
Message-Id: <20180830154518.29507-17-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

For adding newer sensor some basic rework of the code is necessary.

This commit reworks the code and uses regmap field to read out
temp_data.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index d48f338af563..c278e165e161 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -63,6 +63,7 @@ struct gpadc_data {
 	int		(*ths_suspend)(struct sun4i_gpadc_iio *info);
 	int		(*ths_resume)(struct sun4i_gpadc_iio *info);
 	bool		support_irq;
+	u32		temp_data_base;
 };
 
 static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
@@ -77,6 +78,7 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.adc_channel = true,
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 static const struct gpadc_data sun5i_gpadc_data = {
@@ -89,6 +91,7 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.adc_channel = true,
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 static const struct gpadc_data sun6i_gpadc_data = {
@@ -101,12 +104,14 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.adc_channel = true,
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_offset = -1662,
 	.temp_scale = 162,
 	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
+	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
 };
 
 struct sun4i_gpadc_iio {
@@ -271,18 +276,18 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 
-	if (!info->data->support_irq) {
-		pm_runtime_get_sync(indio_dev->dev.parent);
+	if (info->data->adc_channel)
+		return sun4i_gpadc_read(indio_dev, 0, val,
+				SUN4I_GPADC_IRQ_TEMP_DATA);
 
-		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
+	pm_runtime_get_sync(indio_dev->dev.parent);
 
-		pm_runtime_mark_last_busy(indio_dev->dev.parent);
-		pm_runtime_put_autosuspend(indio_dev->dev.parent);
+	regmap_read(info->regmap, info->data->temp_data_base, val);
 
-		return 0;
-	}
+	pm_runtime_mark_last_busy(indio_dev->dev.parent);
+	pm_runtime_put_autosuspend(indio_dev->dev.parent);
 
-	return sun4i_gpadc_read(indio_dev, 0, val, SUN4I_GPADC_IRQ_TEMP_DATA);
+	return 0;
 }
 
 static int sun4i_gpadc_temp_offset(struct iio_dev *indio_dev, int *val)
-- 
2.11.0
