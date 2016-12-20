Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34598 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbcLTK2U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 05:28:20 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org, linux@armlinux.org.uk,
        stefan.mavrodiev@gmail.com
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@free-electrons.com
Subject: [PATCH 3/7] iio: adc: sun4i-gpadc-iio: add support for A33 thermal sensor
Date: Tue, 20 Dec 2016 11:27:05 +0100
Message-Id: <20161220102709.9504-4-quentin.schulz@free-electrons.com>
In-Reply-To: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds support for the Allwinner A33 thermal sensor.

Unlike the A10, A13 and A31, the Allwinner A33 only has one channel
which is dedicated to the thermal sensor. Moreover, its thermal sensor
does not generate interruptions, thus we only need to directly read the
register storing the temperature value.

The MFD used by the A10, A13 and A31, was created to avoid breaking the
DT binding, but since the nodes for the ADC weren't there for the A33,
it is not needed.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/iio/adc/Kconfig           |  21 ++--
 drivers/iio/adc/sun4i-gpadc-iio.c | 204 ++++++++++++++++++++++++++++----------
 include/linux/mfd/sun4i-gpadc.h   |   4 +
 3 files changed, 172 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6a6d369..06041ff 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -437,17 +437,24 @@ config STX104
 config SUN4I_GPADC
 	tristate "Support for the Allwinner SoCs GPADC"
 	depends on IIO
-	depends on MFD_SUN4I_GPADC
-	help
-	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
-	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
-	  a touchscreen input and one channel for thermal sensor.
-
-	  The thermal sensor slows down ADC readings and can be disabled by
+# MFD_SUN4I_GPADC is needed for sun4i, sun5i and sun6i but not for sun8i
+	select MFD_SUN4I_GPADC if MACH_SUN4I || MACH_SUN5I || MACH_SUN6I
+# THERMAL_OF can be disabled on sun4i, sun5i and sun6i to quicken ADC readings
+	depends on THERMAL_OF || MACH_SUN4I || MACH_SUN5I || MACH_SUN6I
+	depends on !TOUCHSCREEN_SUN4I
+	help
+	  Say yes here to build support for Allwinner (A10, A13, A31 and A33)
+	  SoCs GPADC.
+
+	  The ADC on A10, A13 and A31 provides 4 channels which can be used as
+	  an ADC or as a touchscreen input and one channel for thermal sensor.
+	  Their thermal sensor slows down ADC readings and can be disabled by
 	  disabling CONFIG_THERMAL_OF. However, the thermal sensor should be
 	  enabled by default since the SoC temperature is usually more critical
 	  than ADC readings.
 
+	  The ADC on A33 provides one channel for thermal sensor.
+
 	  To compile this driver as a module, choose M here: the module will be
 	  called sun4i-gpadc-iio.
 
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index a8e134f..8be694e 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -1,4 +1,4 @@
-/* ADC driver for sunxi platforms' (A10, A13 and A31) GPADC
+/* ADC driver for sunxi platforms' (A10, A13, A31 and A33) GPADC
  *
  * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons.com>
  *
@@ -85,6 +85,12 @@ static const struct gpadc_data sun6i_gpadc_data = {
 	.adc_chan_mask = SUN6I_GPADC_CTRL1_ADC_CHAN_MASK,
 };
 
+static const struct gpadc_data sun8i_gpadc_data = {
+	.temp_offset = -1662,
+	.temp_scale = 162,
+	.tp_mode_en = SUN8I_GPADC_CTRL1_CHOP_TEMP_EN,
+};
+
 struct sun4i_gpadc_iio {
 	struct iio_dev			*indio_dev;
 	struct completion		completion;
@@ -96,6 +102,7 @@ struct sun4i_gpadc_iio {
 	unsigned int			temp_data_irq;
 	atomic_t			ignore_temp_data_irq;
 	const struct gpadc_data		*data;
+	bool				use_dt;
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
 };
@@ -138,6 +145,23 @@ static const struct iio_chan_spec sun4i_gpadc_channels_no_temp[] = {
 	SUN4I_GPADC_ADC_CHANNEL(3, "adc_chan3"),
 };
 
+static const struct iio_chan_spec sun8i_gpadc_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.datasheet_name = "temp_adc",
+	},
+};
+
+static const struct regmap_config sun4i_gpadc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+};
+
 static int sun4i_prepare_for_irq(struct iio_dev *indio_dev, int channel,
 				 unsigned int irq)
 {
@@ -231,7 +255,6 @@ static int sun4i_gpadc_read(struct iio_dev *indio_dev, int channel, int *val,
 err:
 	pm_runtime_put_autosuspend(indio_dev->dev.parent);
 	mutex_unlock(&info->mutex);
-
 	return ret;
 }
 
@@ -246,6 +269,19 @@ static int sun4i_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
 static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+	int ret;
+
+	if (info->use_dt) {
+		pm_runtime_get_sync(indio_dev->dev.parent);
+
+		ret = regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
+		if (!ret)
+			pm_runtime_mark_last_busy(indio_dev->dev.parent);
+
+		pm_runtime_put_autosuspend(indio_dev->dev.parent);
+
+		return 0;
+	}
 
 	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
 }
@@ -410,7 +446,7 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
 			  unsigned int *irq, atomic_t *atomic)
 {
 	int ret;
-	struct sun4i_gpadc_dev *mfd_dev = dev_get_drvdata(pdev->dev.parent);
+	struct sun4i_gpadc_dev *mfd_dev;
 	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(&pdev->dev));
 
 	/*
@@ -427,6 +463,8 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
 	 */
 	atomic_set(atomic, 1);
 
+	mfd_dev = dev_get_drvdata(pdev->dev.parent);
+
 	ret = platform_get_irq_byname(pdev, name);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "no %s interrupt registered\n", name);
@@ -454,31 +492,68 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
 	return 0;
 }
 
-static int sun4i_gpadc_probe(struct platform_device *pdev)
+static const struct of_device_id sun4i_gpadc_of_id[] = {
+	{
+		.compatible = "allwinner,sun8i-a33-gpadc-iio",
+		.data = &sun8i_gpadc_data,
+	},
+	{ /* sentinel */ }
+};
+
+static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
+				struct iio_dev *indio_dev)
 {
-	struct sun4i_gpadc_iio *info;
-	struct iio_dev *indio_dev;
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+	const struct of_device_id *of_dev;
+	struct thermal_zone_device *tzd;
+	struct resource *mem;
+	void __iomem *base;
 	int ret;
-	struct sun4i_gpadc_dev *sun4i_gpadc_dev;
 
-	sun4i_gpadc_dev = dev_get_drvdata(pdev->dev.parent);
+	of_dev = of_match_device(sun4i_gpadc_of_id, &pdev->dev);
+	if (!of_dev)
+		return -ENODEV;
+
+	info->use_dt = true;
+	info->data = (struct gpadc_data *)of_dev->data;
+	indio_dev->num_channels = ARRAY_SIZE(sun8i_gpadc_channels);
+	indio_dev->channels = sun8i_gpadc_channels;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	info->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					     &sun4i_gpadc_regmap_config);
+	if (IS_ERR(info->regmap)) {
+		ret = PTR_ERR(info->regmap);
+		dev_err(&pdev->dev, "failed to init regmap: %d\n", ret);
+		return ret;
+	}
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
-	if (!indio_dev)
-		return -ENOMEM;
+	tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, info,
+						   &sun4i_ts_tz_ops);
+	if (IS_ERR(tzd)) {
+		dev_err(&pdev->dev, "could not register thermal sensor: %ld\n",
+			PTR_ERR(tzd));
+		return PTR_ERR(tzd);
+	}
 
-	info = iio_priv(indio_dev);
-	platform_set_drvdata(pdev, indio_dev);
+	return 0;
+}
 
-	mutex_init(&info->mutex);
+static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
+				 struct iio_dev *indio_dev)
+{
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
+	struct sun4i_gpadc_dev *sun4i_gpadc_dev;
+	int ret;
+
+	info->use_dt = false;
+	sun4i_gpadc_dev = dev_get_drvdata(pdev->dev.parent);
 	info->regmap = sun4i_gpadc_dev->regmap;
-	info->indio_dev = indio_dev;
-	init_completion(&info->completion);
-	indio_dev->name = dev_name(&pdev->dev);
-	indio_dev->dev.parent = &pdev->dev;
-	indio_dev->dev.of_node = pdev->dev.of_node;
-	indio_dev->info = &sun4i_gpadc_iio_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+
 	indio_dev->num_channels = ARRAY_SIZE(sun4i_gpadc_channels);
 	indio_dev->channels = sun4i_gpadc_channels;
 
@@ -494,7 +569,6 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	 * register the sensor if that option is enabled, eventually leaving
 	 * that choice to the user.
 	 */
-
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
 		/*
 		 * This driver is a child of an MFD which has a node in the DT
@@ -519,8 +593,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"could not register thermal sensor: %ld\n",
 				PTR_ERR(tzd));
-			ret = PTR_ERR(tzd);
-			goto err;
+			return PTR_ERR(tzd);
 		}
 	} else {
 		indio_dev->num_channels =
@@ -528,49 +601,78 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 		indio_dev->channels = sun4i_gpadc_channels_no_temp;
 	}
 
-	pm_runtime_set_autosuspend_delay(&pdev->dev,
-					 SUN4I_GPADC_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_set_suspended(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
-
 	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
 		ret = sun4i_irq_init(pdev, "TEMP_DATA_PENDING",
 				     sun4i_gpadc_temp_data_irq_handler,
 				     "temp_data", &info->temp_data_irq,
 				     &info->ignore_temp_data_irq);
 		if (ret < 0)
-			goto err;
-	}
+			return ret;
 
-	ret = sun4i_irq_init(pdev, "FIFO_DATA_PENDING",
-			     sun4i_gpadc_fifo_data_irq_handler, "fifo_data",
-			     &info->fifo_data_irq, &info->ignore_fifo_data_irq);
-	if (ret < 0)
-		goto err;
+		ret = sun4i_irq_init(pdev, "FIFO_DATA_PENDING",
+				     sun4i_gpadc_fifo_data_irq_handler,
+				     "fifo_data", &info->fifo_data_irq,
+				     &info->ignore_fifo_data_irq);
+		if (ret < 0)
+			return ret;
+	}
 
-	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		ret = iio_map_array_register(indio_dev, sun4i_gpadc_hwmon_maps);
-		if (ret < 0) {
-			dev_err(&pdev->dev,
-				"failed to register iio map array\n");
-			goto err;
-		}
+	ret = iio_map_array_register(indio_dev, sun4i_gpadc_hwmon_maps);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register iio map array\n");
+		return ret;
 	}
 
+	return 0;
+}
+
+static int sun4i_gpadc_probe(struct platform_device *pdev)
+{
+	struct sun4i_gpadc_iio *info;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	info = iio_priv(indio_dev);
+	platform_set_drvdata(pdev, indio_dev);
+
+	mutex_init(&info->mutex);
+	info->indio_dev = indio_dev;
+	init_completion(&info->completion);
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->dev.of_node = pdev->dev.of_node;
+	indio_dev->info = &sun4i_gpadc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	if (pdev->dev.of_node)
+		ret = sun4i_gpadc_probe_dt(pdev, indio_dev);
+	else
+		ret = sun4i_gpadc_probe_mfd(pdev, indio_dev);
+
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+					 SUN4I_GPADC_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register the device\n");
-		goto err_map;
+		goto err;
 	}
 
 	return 0;
 
-err_map:
-	if (IS_ENABLED(CONFIG_THERMAL_OF))
-		iio_map_array_unregister(indio_dev);
-
 err:
+	if (!info->use_dt && IS_ENABLED(CONFIG_THERMAL_OF))
+		iio_map_array_unregister(indio_dev);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
@@ -580,10 +682,11 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 static int sun4i_gpadc_remove(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (IS_ENABLED(CONFIG_THERMAL_OF))
+	if (!info->use_dt && IS_ENABLED(CONFIG_THERMAL_OF))
 		iio_map_array_unregister(indio_dev);
 
 	return 0;
@@ -599,6 +702,7 @@ static const struct platform_device_id sun4i_gpadc_id[] = {
 static struct platform_driver sun4i_gpadc_driver = {
 	.driver = {
 		.name = "sun4i-gpadc-iio",
+		.of_match_table = sun4i_gpadc_of_id,
 		.pm = &sun4i_gpadc_pm_ops,
 	},
 	.id_table = sun4i_gpadc_id,
diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
index 509e736..139872c 100644
--- a/include/linux/mfd/sun4i-gpadc.h
+++ b/include/linux/mfd/sun4i-gpadc.h
@@ -38,6 +38,10 @@
 #define SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GENMASK(3, 0) & BIT(x))
 #define SUN6I_GPADC_CTRL1_ADC_CHAN_MASK			GENMASK(3, 0)
 
+/* TP_CTRL1 bits for sun8i SoCs */
+#define SUN8I_GPADC_CTRL1_CHOP_TEMP_EN			BIT(8)
+#define SUN8I_GPADC_CTRL1_GPADC_CALI_EN			BIT(7)
+
 #define SUN4I_GPADC_CTRL2				0x08
 
 #define SUN4I_GPADC_CTRL2_TP_SENSITIVE_ADJUST(x)	((GENMASK(3, 0) & (x)) << 28)
-- 
2.9.3

