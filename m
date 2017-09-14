Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hermes.aosc.io ([199.195.250.187]:60891 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbdINOxr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Sep 2017 10:53:47 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH v4 3/6] iio: adc: sun4i-gpadc-iio: rework code for supporting newer THS variants
Date: Thu, 14 Sep 2017 22:52:48 +0800
Message-Id: <20170914145251.21784-4-icenowy@aosc.io>
In-Reply-To: <20170914145251.21784-1-icenowy@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The SoCs after H3 has newer thermal sensor ADCs, which have two clock
inputs (bus clock and sampling clock) and a reset. The registers are
also re-arranged.

This commit reworks the code, adds the process of the clocks and
resets, and allows the sampling start/end code and the position of value
readout register to be altered.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 123 +++++++++++++++++++++++++++++++++++---
 1 file changed, 116 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 68926b986cd0..97845982d050 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -22,6 +22,7 @@
  * shutdown for not being used.
  */
 
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -31,6 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/thermal.h>
 #include <linux/delay.h>
 
@@ -49,6 +51,15 @@ static unsigned int sun6i_gpadc_chan_select(unsigned int chan)
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
@@ -56,6 +67,12 @@ struct gpadc_data {
 	unsigned int	tp_adc_select;
 	unsigned int	(*adc_chan_select)(unsigned int chan);
 	unsigned int	adc_chan_mask;
+	unsigned int	temp_data;
+	int		(*sample_start)(struct sun4i_gpadc_iio *info);
+	int		(*sample_end)(struct sun4i_gpadc_iio *info);
+	bool		has_bus_clk;
+	bool		has_bus_rst;
+	bool		has_mod_clk;
 };
 
 static const struct gpadc_data sun4i_gpadc_data = {
@@ -65,6 +82,9 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.sample_start = sun4i_gpadc_sample_start,
+	.sample_end = sun4i_gpadc_sample_end,
 };
 
 static const struct gpadc_data sun5i_gpadc_data = {
@@ -74,6 +94,9 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.temp_data = SUN4I_GPADC_TEMP_DATA,
+	.sample_start = sun4i_gpadc_sample_start,
+	.sample_end = sun4i_gpadc_sample_end,
 };
 
 static const struct gpadc_data sun6i_gpadc_data = {
@@ -83,12 +106,18 @@ static const struct gpadc_data sun6i_gpadc_data = {
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
@@ -103,6 +132,9 @@ struct sun4i_gpadc_iio {
 	atomic_t			ignore_temp_data_irq;
 	const struct gpadc_data		*data;
 	bool				no_irq;
+	struct clk			*bus_clk;
+	struct clk			*mod_clk;
+	struct reset_control		*reset;
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
 	struct thermal_zone_device	*tzd;
@@ -277,7 +309,7 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 	if (info->no_irq) {
 		pm_runtime_get_sync(indio_dev->dev.parent);
 
-		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
+		regmap_read(info->regmap, info->data->temp_data, val);
 
 		pm_runtime_mark_last_busy(indio_dev->dev.parent);
 		pm_runtime_put_autosuspend(indio_dev->dev.parent);
@@ -383,10 +415,8 @@ static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
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
@@ -395,10 +425,15 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
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
@@ -416,6 +451,13 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
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
@@ -529,17 +571,75 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 		return ret;
 	}
 
+	if (info->data->has_bus_rst) {
+		info->reset = devm_reset_control_get(&pdev->dev, NULL);
+		if (IS_ERR(info->reset)) {
+			ret = PTR_ERR(info->reset);
+			return ret;
+		}
+
+		ret = reset_control_deassert(info->reset);
+		if (ret)
+			return ret;
+	}
+
+	if (info->data->has_bus_clk) {
+		info->bus_clk = devm_clk_get(&pdev->dev, "bus");
+		if (IS_ERR(info->bus_clk)) {
+			ret = PTR_ERR(info->bus_clk);
+			goto assert_reset;
+		}
+
+		ret = clk_prepare_enable(info->bus_clk);
+		if (ret)
+			goto assert_reset;
+	}
+
+	if (info->data->has_mod_clk) {
+		info->mod_clk = devm_clk_get(&pdev->dev, "mod");
+		if (IS_ERR(info->mod_clk)) {
+			ret = PTR_ERR(info->mod_clk);
+			goto disable_bus_clk;
+		}
+
+		/* Running at 6MHz */
+		ret = clk_set_rate(info->mod_clk, 6000000);
+		if (ret)
+			goto disable_bus_clk;
+
+		ret = clk_prepare_enable(info->mod_clk);
+		if (ret)
+			goto disable_bus_clk;
+	}
+
 	if (!IS_ENABLED(CONFIG_THERMAL_OF))
 		return 0;
 
 	info->sensor_device = &pdev->dev;
 	info->tzd = thermal_zone_of_sensor_register(info->sensor_device, 0,
 						    info, &sun4i_ts_tz_ops);
-	if (IS_ERR(info->tzd))
+	if (IS_ERR(info->tzd)) {
 		dev_err(&pdev->dev, "could not register thermal sensor: %ld\n",
 			PTR_ERR(info->tzd));
+		ret = PTR_ERR(info->tzd);
+		goto disable_mod_clk;
+	}
+
+	return 0;
+
+disable_mod_clk:
+	if (info->data->has_mod_clk)
+		clk_disable_unprepare(info->mod_clk);
+
+disable_bus_clk:
+	if (info->data->has_bus_clk)
+		clk_disable_unprepare(info->bus_clk);
 
-	return PTR_ERR_OR_ZERO(info->tzd);
+assert_reset:
+	if (info->data->has_bus_rst)
+		reset_control_assert(info->reset);
+
+	return ret;
 }
 
 static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
@@ -698,6 +798,15 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	if (!info->no_irq)
 		iio_map_array_unregister(indio_dev);
 
+	if (info->data->has_mod_clk)
+		clk_disable_unprepare(info->mod_clk);
+
+	if (info->data->has_bus_clk)
+		clk_disable_unprepare(info->bus_clk);
+
+	if (info->data->has_bus_rst)
+		reset_control_assert(info->reset);
+
 	return 0;
 }
 
-- 
2.13.5

