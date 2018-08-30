Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43348 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeH3TsR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:17 -0400
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
Subject: [PATCH v3 10/30] iio: adc: rework irq and adc_channel handling
Date: Thu, 30 Aug 2018 17:44:58 +0200
Message-Id: <20180830154518.29507-11-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We rework the irq handling and the adc_channel handling.
This is requiered since we merge the mfd driver into the adc driver.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 157 ++++++++++++++++++++++++--------------
 include/linux/mfd/sun4i-gpadc.h   |   7 --
 2 files changed, 98 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 658a7e3e3370..a2027614ee0c 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -49,6 +49,8 @@ static unsigned int sun6i_gpadc_chan_select(unsigned int chan)
 	return SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(chan);
 }
 
+struct sun4i_gpadc_iio;
+
 struct gpadc_data {
 	int		temp_offset;
 	int		temp_scale;
@@ -56,8 +58,15 @@ struct gpadc_data {
 	unsigned int	tp_adc_select;
 	unsigned int	(*adc_chan_select)(unsigned int chan);
 	unsigned int	adc_chan_mask;
+	bool		adc_channel;
+	irqreturn_t	(*ths_irq_thread)(int irq, void *dev_id);
+	int		(*ths_suspend)(struct sun4i_gpadc_iio *info);
+	int		(*ths_resume)(struct sun4i_gpadc_iio *info);
+	bool		support_irq;
 };
 
+static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id);
+
 static const struct gpadc_data sun4i_gpadc_data = {
 	.temp_offset = -1932,
 	.temp_scale = 133,
@@ -65,6 +74,9 @@ static const struct gpadc_data sun4i_gpadc_data = {
 	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.adc_channel = true,
+	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
+	.support_irq = true,
 };
 
 static const struct gpadc_data sun5i_gpadc_data = {
@@ -74,6 +86,9 @@ static const struct gpadc_data sun5i_gpadc_data = {
 	.tp_adc_select = SUN4I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun4i_gpadc_chan_select,
 	.adc_chan_mask = SUN4I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.adc_channel = true,
+	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
+	.support_irq = true,
 };
 
 static const struct gpadc_data sun6i_gpadc_data = {
@@ -83,6 +98,9 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.tp_adc_select = SUN6I_GPADC_CTRL1_TP_ADC_SELECT,
 	.adc_chan_select = &sun6i_gpadc_chan_select,
 	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
+	.adc_channel = true,
+	.ths_irq_thread = sun4i_gpadc_data_irq_handler,
+	.support_irq = true,
 };
 
 static const struct gpadc_data sun8i_a33_gpadc_data = {
@@ -96,13 +114,10 @@ struct sun4i_gpadc_iio {
 	struct completion		completion;
 	int				temp_data;
 	u32				adc_data;
+	unsigned int			irq_data_type;
 	struct regmap			*regmap;
-	unsigned int			fifo_data_irq;
-	atomic_t			ignore_fifo_data_irq;
-	unsigned int			temp_data_irq;
-	atomic_t			ignore_temp_data_irq;
+	unsigned int			irq;
 	const struct gpadc_data		*data;
-	bool				no_irq;
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
 	struct thermal_zone_device	*tzd;
@@ -130,6 +145,20 @@ static const struct regmap_config sun4i_gpadc_regmap_config = {
 	.fast_io = true,
 };
 
+static int sun4i_gpadc_irq_init(struct sun4i_gpadc_iio *info)
+{
+	u32 reg;
+
+	if (info->irq_data_type == SUN4I_GPADC_IRQ_FIFO_DATA)
+		reg = SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN;
+	else
+		reg = SUN4I_GPADC_INT_FIFOC_TEMP_IRQ_EN;
+
+	regmap_write(info->regmap, SUN4I_GPADC_INT_FIFOC, reg);
+
+	return 0;
+}
+
 static int sun4i_prepare_for_irq(struct iio_dev *indio_dev, int channel,
 				 unsigned int irq)
 {
@@ -151,7 +180,7 @@ static int sun4i_prepare_for_irq(struct iio_dev *indio_dev, int channel,
 	if (ret)
 		return ret;
 
-	if (irq == info->fifo_data_irq) {
+	if (irq == SUN4I_GPADC_IRQ_FIFO_DATA) {
 		ret = regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
 				   info->data->tp_mode_en |
 				   info->data->tp_adc_select |
@@ -172,6 +201,8 @@ static int sun4i_prepare_for_irq(struct iio_dev *indio_dev, int channel,
 		ret = regmap_write(info->regmap, SUN4I_GPADC_CTRL1,
 				   info->data->tp_mode_en);
 	}
+	if (info->data->support_irq)
+		sun4i_gpadc_irq_init(info);
 
 	if (ret)
 		return ret;
@@ -194,11 +225,12 @@ static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
 
 	mutex_lock(&info->mutex);
 
+	info->irq_data_type = irq;
 	ret = sun4i_prepare_for_irq(indio_dev, channel, irq);
 	if (ret)
 		goto err;
 
-	enable_irq(irq);
+	enable_irq(info->irq);
 
 	/*
 	 * The temperature sensor throws an interruption periodically (currently
@@ -212,7 +244,7 @@ static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
 		goto err;
 	}
 
-	if (irq == info->fifo_data_irq)
+	if (irq == SUN4I_GPADC_IRQ_FIFO_DATA)
 		*val = info->adc_data;
 	else
 		*val = info->temp_data;
@@ -222,7 +254,7 @@ static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
 
 err:
 	pm_runtime_put_autosuspend(indio_dev->dev.parent);
-	disable_irq(irq);
+	disable_irq(info->irq);
 	mutex_unlock(&info->mutex);
 
 	return ret;
@@ -231,16 +263,15 @@ static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
 static int sun4i_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
 				int *val)
 {
-	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
-
-	return sun4i_gpadc_read(indio_dev, channel, val, info->fifo_data_irq);
+	return sun4i_gpadc_read(indio_dev, channel, val,
+			SUN4I_GPADC_IRQ_FIFO_DATA);
 }
 
 static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 
-	if (info->no_irq) {
+	if (!info->data->support_irq) {
 		pm_runtime_get_sync(indio_dev->dev.parent);
 
 		regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
@@ -251,7 +282,7 @@ static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 		return 0;
 	}
 
-	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
+	return sun4i_gpadc_read(indio_dev, 0, val, SUN4I_GPADC_IRQ_TEMP_DATA);
 }
 
 static int sun4i_gpadc_temp_offset(struct iio_dev *indio_dev, int *val)
@@ -320,31 +351,21 @@ static const struct iio_info sun4i_gpadc_iio_info = {
 	.read_raw = sun4i_gpadc_read_raw,
 };
 
-static irqreturn_t sun4i_gpadc_temp_data_irq_handler(int irq, void *dev_id)
+static irqreturn_t sun4i_gpadc_data_irq_handler(int irq, void *dev_id)
 {
 	struct sun4i_gpadc_iio *info = dev_id;
 
-	if (atomic_read(&info->ignore_temp_data_irq))
-		goto out;
-
-	if (!regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, &info->temp_data))
-		complete(&info->completion);
-
-out:
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t sun4i_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
-{
-	struct sun4i_gpadc_iio *info = dev_id;
-
-	if (atomic_read(&info->ignore_fifo_data_irq))
-		goto out;
-
-	if (!regmap_read(info->regmap, SUN4I_GPADC_DATA, &info->adc_data))
-		complete(&info->completion);
-
-out:
+	if (info->irq_data_type == SUN4I_GPADC_IRQ_FIFO_DATA) {
+		/* read fifo data */
+		if (!regmap_read(info->regmap, SUN4I_GPADC_DATA,
+					&info->adc_data))
+			complete(&info->completion);
+	} else {
+		/* read temp data */
+		if (!regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA,
+					&info->temp_data))
+			complete(&info->completion);
+	}
 	return IRQ_HANDLED;
 }
 
@@ -356,6 +377,8 @@ static int sun4i_gpadc_runtime_suspend(struct device *dev)
 	regmap_write(info->regmap, SUN4I_GPADC_CTRL1, 0);
 	/* Disable temperature sensor on IP */
 	regmap_write(info->regmap, SUN4I_GPADC_TPR, 0);
+	/* Disable irq*/
+	regmap_write(info->regmap, SUN4I_GPADC_INT_FIFOC, 0);
 
 	return 0;
 }
@@ -378,6 +401,7 @@ static int sun4i_gpadc_runtime_resume(struct device *dev)
 		     SUN4I_GPADC_TPR_TEMP_ENABLE |
 		     SUN4I_GPADC_TPR_TEMP_PERIOD(800));
 
+
 	return 0;
 }
 
@@ -426,8 +450,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	if (!info->data)
 		return -ENODEV;
 
-	info->no_irq = true;
-
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(base))
@@ -441,8 +463,25 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 		return ret;
 	}
 
-	if (IS_ENABLED(CONFIG_THERMAL_OF))
-		info->sensor_device = &pdev->dev;
+	if (info->data->support_irq) {
+
+		/* ths interrupt */
+		info->irq = platform_get_irq(pdev, 0);
+
+		ret = devm_request_threaded_irq(&pdev->dev, info->irq,
+				NULL, info->data->ths_irq_thread,
+				IRQF_ONESHOT, dev_name(&pdev->dev), info);
+
+		if (info->data->adc_channel)
+			disable_irq(info->irq);
+
+		if (ret) {
+			dev_err(&pdev->dev, "failed to add ths irq: %d\n", ret);
+			return ret;
+		}
+	}
+
+	info->sensor_device = &pdev->dev;
 
 	return 0;
 }
@@ -469,6 +508,11 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	indio_dev->info = &sun4i_gpadc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	if (&info->data->adc_channel) {
+		indio_dev->num_channels = ARRAY_SIZE(sun4i_gpadc_channels);
+		indio_dev->channels = sun4i_gpadc_channels;
+	}
+
 	ret = sun4i_gpadc_probe_dt(pdev, indio_dev);
 
 	if (ret)
@@ -480,20 +524,18 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
-							    0, info,
-							    &sun4i_ts_tz_ops);
-		/*
-		 * Do not fail driver probing when failing to register in
-		 * thermal because no thermal DT node is found.
-		 */
-		if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) != -ENODEV) {
-			dev_err(&pdev->dev,
-				"could not register thermal sensor: %ld\n",
-				PTR_ERR(info->tzd));
-			return PTR_ERR(info->tzd);
-		}
+	info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
+						    0, info,
+						    &sun4i_ts_tz_ops);
+	/*
+	 * Do not fail driver probing when failing to register in
+	 * thermal because no thermal DT node is found.
+	 */
+	if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) != -ENODEV) {
+		dev_err(&pdev->dev,
+			"could not register thermal sensor: %ld\n",
+			PTR_ERR(info->tzd));
+		return PTR_ERR(info->tzd);
 	}
 
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
@@ -505,7 +547,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	return 0;
 
 err_map:
-	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
+	if (!info->data->support_irq)
 		iio_map_array_unregister(indio_dev);
 
 	pm_runtime_put(&pdev->dev);
@@ -522,12 +564,9 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	if (!IS_ENABLED(CONFIG_THERMAL_OF))
-		return 0;
-
 	thermal_zone_of_sensor_unregister(info->sensor_device, info->tzd);
 
-	if (!info->no_irq)
+	if (!info->data->support_irq)
 		iio_map_array_unregister(indio_dev);
 
 	return 0;
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 54c7c9375c1b..ca59336f246b 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -99,11 +99,4 @@
 	.datasheet_name = _name,				\
 }
 
-struct sun4i_gpadc_dev {
-	struct device			*dev;
-	struct regmap			*regmap;
-	struct regmap_irq_chip_data	*regmap_irqc;
-	void __iomem			*base;
-};
-
 #endif
-- 
2.11.0
