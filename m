Return-Path: <SRS0=HpEw=LN=gmail.com=embed3d@kernel.org>
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	maxime.ripard@bootlin.com,
	wens@csie.org,
	linux@armlinux.org.uk,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	eugen.hristev@microchip.com,
	rdunlap@infradead.org,
	vilhelm.gray@gmail.com,
	clabbe.montjoie@gmail.com,
	quentin.schulz@bootlin.com,
	geert+renesas@glider.be,
	lukas@wunner.de,
	icenowy@aosc.io,
	arnd@arndb.de,
	broonie@kernel.org,
	arnaud.pouliquen@st.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: [PATCH v3 20/30] iio: adc: sun4i-gpadc-iio: rework: device specific suspend & resume
Date: Thu, 30 Aug 2018 17:45:08 +0200
Message-Id: <20180830154518.29507-21-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Different sensors will have different suspend and resume functions. So
we are modularize the suspend and resume functions.

The resume function configures and initializes the thermal sensor and
the suspend function disables the sensors.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 2fd73d143815..c7b46c82e3e5 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -76,6 +76,9 @@ struct gpadc_data {
 
 static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
 
+static int sun4i_ths_resume(struct sun4i_gpadc_iio *info);
+static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info);
+
 static const struct gpadc_data sun4i_gpadc_data = {
 	.temp_offset = -1932,
 	.temp_scale = 133,
@@ -87,6 +90,8 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.ths_resume = sun4i_ths_resume,
+	.ths_suspend = sun4i_ths_suspend,
 	.sensor_count = 1,
 };
 
@@ -101,6 +106,8 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.ths_resume = sun4i_ths_resume,
+	.ths_suspend = sun4i_ths_suspend,
 	.sensor_count = 1,
 };
 
@@ -115,6 +122,8 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
 	.support_irq = true,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.ths_resume = sun4i_ths_resume,
+	.ths_suspend = sun4i_ths_suspend,
 	.sensor_count = 1,
 };
 
@@ -123,6 +132,8 @@ static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_scale = 162,
 	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
 	.temp_data_base = SUN4I_GPADC_TEMP_DATA,
+	.ths_resume = sun4i_ths_resume,
+	.ths_suspend = sun4i_ths_suspend,
 	.sensor_count = 1,
 };
 
@@ -401,6 +412,11 @@ static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id)
 static int sun4i_gpadc_runtime_suspend(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
+	return info->data->ths_suspend(info);
+}
+
+static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)
+{
 
 	/* Disable the ADC on IP */
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
@@ -415,7 +431,11 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
 static int sun4i_gpadc_runtime_resume(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
+	return info->data->ths_resume(info);
+}
 
+static int sun4i_ths_resume(struct sun4i_gpadc_iio *info)
+{
 	/* clkin = 6MHz */
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
 		     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
-- 
2.11.0
