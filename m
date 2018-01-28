Return-Path: <SRS0=zW5g=EX=gmail.com=embed3d@kernel.org>
From: Philipp Rossak <embed3d@gmail.com>
To: lee.jones@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	maxime.ripard@free-electrons.com,
	wens@csie.org,
	linux@armlinux.org.uk,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	davem@davemloft.net,
	hans.verkuil@cisco.com,
	mchehab@kernel.org,
	rask@formelder.dk,
	clabbe.montjoie@gmail.com,
	sean@mess.org,
	krzk@kernel.org,
	quentin.schulz@free-electrons.com,
	icenowy@aosc.io,
	edu.molinas@gmail.com,
	singhalsimran0@gmail.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: [PATCH v2 04/16] iio: adc: sun4i-gpadc-iio: rework: sampling start/end code readout reg
Date: Mon, 29 Jan 2018 00:29:07 +0100
Message-Id: <20180128232919.12639-5-embed3d@gmail.com>
In-Reply-To: <20180128232919.12639-1-embed3d@gmail.com>
References: <20180128232919.12639-1-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

For adding newer sensor some basic rework of the code is necessary.

This commit reworks the code and allows the sampling start/end code and
the position of value readout register to be altered. Later the start/end
functions will be used to configure the ths and start/stop the
sampling.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 44 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 03804ff9c006..db57d9fffe48 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -49,6 +49,15 @@ static unsigned int sun6i_gpadc_chan_select(unsigned int chan)
 	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
 }
 
+struct sun4i_gpadc_iio;
+
+/*
+ * Prototypes for these functions, which enable these functions to be
+ * referenced in gpadc_data structures.
+ */
+static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info);
+static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info);
+
 struct gpadc_data {
 	int		temp_offset;
 	int		temp_scale;
@@ -56,6 +65,9 @@ struct gpadc_data {
 	unsigned int	tp_adc_select;
 	unsigned int	(*adc_chan_select)(unsigned int chan);
 	unsigned int	adc_chan_mask;
+	unsigned int	temp_data;
+	int		(*sample_start)(struct sun4i_gpadc_iio *info);
+	int		(*sample_end)(struct sun4i_gpadc_iio *info);
 };
 
 static const struct gpadc_data sun4i_gpadc_data = {
@@ -65,6 +77,9 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.sample_start = sun4i_gpadc_sample_start,
+	.sample_end = sun4i_gpadc_sample_end,
 };
 
 static const struct gpadc_data sun5i_gpadc_data = {
@@ -74,6 +89,9 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.sample_start = sun4i_gpadc_sample_start,
+	.sample_end = sun4i_gpadc_sample_end,
 };
 
 static const struct gpadc_data sun6i_gpadc_data = {
@@ -83,12 +101,18 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.tp_adc_select = SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun6i_gpadc_chan_select,
 	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.sample_start = sun4i_gpadc_sample_start,
+	.sample_end = sun4i_gpadc_sample_end,
 };
 
 static const struct gpadc_data sun8i_a33_gpadc_data = {
 	.temp_offset = -1662,
 	.temp_scale = 162,
 	.tp_mode_en = SUN8I_A33_GPADC_CTRL1_CHOP_TEMP_EN,
+	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.sample_start = sun4i_gpadc_sample_start,
+	.sample_end = sun4i_gpadc_sample_end,
 };
 
 struct sun4i_gpadc_iio {
@@ -277,7 +301,7 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 	if (info->no_irq) {
 		pm_runtime_get_sync(indio_dev->dev.parent);
 
-		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
+		regmap_read(info->regmap, info->data->temp_data, val);
 
 		pm_runtime_mark_last_busy(indio_dev->dev.parent);
 		pm_runtime_put_autosuspend(indio_dev->dev.parent);
@@ -382,10 +406,8 @@ static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int sun4i_gpadc_runtime_suspend(struct device *dev)
+static int sun4i_gpadc_sample_end(struct sun4i_gpadc_iio *info)
 {
-	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
-
 	/* Disable the ADC on IP */
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
 	/* Disable temperature sensor on IP */
@@ -394,10 +416,15 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int sun4i_gpadc_runtime_resume(struct device *dev)
+static int sun4i_gpadc_runtime_suspend(struct device *dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
 
+	return info->data->sample_end(info);
+}
+
+static int sun4i_gpadc_sample_start(struct sun4i_gpadc_iio *info)
+{
 	/* clkin = 6MHz */
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL0,
 		     SUN4I_GPADC_CTRL0_ADC_CLK_DIVIDER(2) |
@@ -415,6 +442,13 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int sun4i_gpadc_runtime_resume(struct device *dev)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(dev));
+
+	return info->data->sample_start(info);
+}
+
 static int sun4i_gpadc_get_temp(void *data, int *temp)
 {
 	struct sun4i_gpadc_iio *info = data;
-- 
2.11.0
