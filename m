Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47060 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbeH3TsN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:48:13 -0400
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
Subject: [PATCH v3 07/30] iio: adc: remove mfd_probe & sunwi_irq_init function
Date: Thu, 30 Aug 2018 17:44:55 +0200
Message-Id: <20180830154518.29507-8-embed3d@gmail.com>
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In the previous commit we removed the function call, now we remove the
unused functions.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 126 --------------------------------------
 1 file changed, 126 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index d6f00d3b802d..f787442a9e5f 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -431,55 +431,6 @@ static const struct dev_pm_ops sun4i_gpadc_pm_ops = {
 	.runtime_resume = &sun4i_gpadc_runtime_resume,
 };
 
-static int sun4i_irq_init(struct platform_device *pdev, const char *name,
-			  irq_handler_t handler, const char *devname,
-			  unsigned int *irq, atomic_t *atomic)
-{
-	int ret;
-	struct sun4i_gpadc_dev *mfd_dev = dev_get_drvdata(pdev->dev.parent);
-	struct sun4i_gpadc_iio *info = iio_priv(dev_get_drvdata(&pdev->dev));
-
-	/*
-	 * Once the interrupt is activated, the IP continuously performs
-	 * conversions thus throws interrupts. The interrupt is activated right
-	 * after being requested but we want to control when these interrupts
-	 * occur thus we disable it right after being requested. However, an
-	 * interrupt might occur between these two instructions and we have to
-	 * make sure that does not happen, by using atomic flags. We set the
-	 * flag before requesting the interrupt and unset it right after
-	 * disabling the interrupt. When an interrupt occurs between these two
-	 * instructions, reading the atomic flag will tell us to ignore the
-	 * interrupt.
-	 */
-	atomic_set(atomic, 1);
-
-	ret = platform_get_irq_byname(pdev, name);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "no %s interrupt registered\n", name);
-		return ret;
-	}
-
-	ret = regmap_irq_get_virq(mfd_dev->regmap_irqc, ret);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get virq for irq %s\n", name);
-		return ret;
-	}
-
-	*irq = ret;
-	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler, 0,
-					   devname, info);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not request %s interrupt: %d\n",
-			name, ret);
-		return ret;
-	}
-
-	disable_irq(*irq);
-	atomic_set(atomic, 0);
-
-	return 0;
-}
-
 static const struct of_device_id sun4i_gpadc_of_id[] = {
 	{
 		.compatible = "allwinner,sun8i-a33-ths",
@@ -523,83 +474,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	return 0;
 }
 
-static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
-				 struct iio_dev *indio_dev)
-{
-	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
-	struct sun4i_gpadc_dev *sun4i_gpadc_dev =
-		dev_get_drvdata(pdev->dev.parent);
-	int ret;
-
-	info->no_irq = false;
-	info->regmap = sun4i_gpadc_dev->regmap;
-
-	indio_dev->num_channels = ARRAY_SIZE(sun4i_gpadc_channels);
-	indio_dev->channels = sun4i_gpadc_channels;
-
-	info->data = (struct gpadc_data *)platform_get_device_id(pdev)->driver_data;
-
-	/*
-	 * Since the controller needs to be in touchscreen mode for its thermal
-	 * sensor to operate properly, and that switching between the two modes
-	 * needs a delay, always registering in the thermal framework will
-	 * significantly slow down the conversion rate of the ADCs.
-	 *
-	 * Therefore, instead of depending on THERMAL_OF in Kconfig, we only
-	 * register the sensor if that option is enabled, eventually leaving
-	 * that choice to the user.
-	 */
-
-	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		/*
-		 * This driver is a child of an MFD which has a node in the DT
-		 * but not its children, because of DT backward compatibility
-		 * for A10, A13 and A31 SoCs. Therefore, the resulting devices
-		 * of this driver do not have an of_node variable.
-		 * However, its parent (the MFD driver) has an of_node variable
-		 * and since devm_thermal_zone_of_sensor_register uses its first
-		 * argument to match the phandle defined in the node of the
-		 * thermal driver with the of_node of the device passed as first
-		 * argument and the third argument to call ops from
-		 * thermal_zone_of_device_ops, the solution is to use the parent
-		 * device as first argument to match the phandle with its
-		 * of_node, and the device from this driver as third argument to
-		 * return the temperature.
-		 */
-		info->sensor_device = pdev->dev.parent;
-	} else {
-		indio_dev->num_channels =
-			ARRAY_SIZE(sun4i_gpadc_channels_no_temp);
-		indio_dev->channels = sun4i_gpadc_channels_no_temp;
-	}
-
-	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		ret = sun4i_irq_init(pdev, "TEMP_DATA_PENDING",
-				     sun4i_gpadc_temp_data_irq_handler,
-				     "temp_data", &info->temp_data_irq,
-				     &info->ignore_temp_data_irq);
-		if (ret < 0)
-			return ret;
-	}
-
-	ret = sun4i_irq_init(pdev, "FIFO_DATA_PENDING",
-			     sun4i_gpadc_fifo_data_irq_handler, "fifo_data",
-			     &info->fifo_data_irq, &info->ignore_fifo_data_irq);
-	if (ret < 0)
-		return ret;
-
-	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
-		ret = iio_map_array_register(indio_dev, sun4i_gpadc_hwmon_maps);
-		if (ret < 0) {
-			dev_err(&pdev->dev,
-				"failed to register iio map array\n");
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static int sun4i_gpadc_probe(struct platform_device *pdev)
 {
 	struct sun4i_gpadc_iio *info;
-- 
2.11.0
