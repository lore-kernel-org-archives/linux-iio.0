Return-Path: <SRS0=fkoa=4Y=free-electrons.com=quentin.schulz@kernel.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com,
	wens@csie.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
	clabbe.montjoie@gmail.com,
	linux-iio@vger.kernel.org,
	thomas.petazzoni@free-electrons.com,
	linux-sunxi@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: sun4i-gpadc-iio: fix parent device being used in devm function
Date: Thu, 18 May 2017 08:36:07 +0200
Message-Id: <20170518063607.11069-1-quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

For the sake of DT binding stability, this IIO driver is a child of an
MFD driver for Allwinner A10, A13 and A31 because there already exists a
DT binding for this IP. The MFD driver has a DT node but the IIO driver
does not.

The IIO device registers the temperature sensor in the thermal framework
using the DT node of the parent, the MFD device, so the thermal
framework could match the phandle to the MFD device in the DT and the
struct device used to register in the thermal framework.

devm_thermal_zone_of_sensor_register was previously used to register the
thermal sensor with the parent struct device of the IIO device,
representing the MFD device. By doing so, we registered actually the
parent in the devm routine and not the actual IIO device.

This lead to the devm unregister function not being called when the IIO
module driver is removed. It resulted in the thermal framework still
polling the get_temp function of the IIO module while the device doesn't
exist anymore, thus generated a kernel panic.

Use the non-devm function instead and do the unregister manually in the
remove function.

Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---

v2:
  - save struct device used to register in thermal framework in
  sun4i_gpadc_iio,
  - use this struct device to unregister from thermal framework instead
  of doing a condition on pdev->dev.of_node,
  - check if CONFIG_THERMAL_OF is enabled before unregistering from
  thermal,

 drivers/iio/adc/sun4i-gpadc-iio.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index b23527309088..11f7d7745614 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -105,6 +105,8 @@ struct sun4i_gpadc_iio {
 	bool				no_irq;
 	/* prevents concurrent reads of temperature and ADC */
 	struct mutex			mutex;
+	struct thermal_zone_device	*tzd;
+	struct device			*sensor_device;
 };
 
 #define SUN4I_GPADC_ADC_CHANNEL(_channel, _name) {		\
@@ -502,7 +504,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
 	const struct of_device_id *of_dev;
-	struct thermal_zone_device *tzd;
 	struct resource *mem;
 	void __iomem *base;
 	int ret;
@@ -532,13 +533,14 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	if (!IS_ENABLED(CONFIG_THERMAL_OF))
 		return 0;
 
-	tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, info,
-						   &sun4i_ts_tz_ops);
-	if (IS_ERR(tzd))
+	info->sensor_device = &pdev->dev;
+	info->tzd = thermal_zone_of_sensor_register(info->sensor_device, 0,
+						    info, &sun4i_ts_tz_ops);
+	if (IS_ERR(info->tzd))
 		dev_err(&pdev->dev, "could not register thermal sensor: %ld\n",
-			PTR_ERR(tzd));
+			PTR_ERR(info->tzd));
 
-	return PTR_ERR_OR_ZERO(tzd);
+	return PTR_ERR_OR_ZERO(info->tzd);
 }
 
 static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
@@ -584,15 +586,15 @@ static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
 		 * of_node, and the device from this driver as third argument to
 		 * return the temperature.
 		 */
-		struct thermal_zone_device *tzd;
-		tzd = devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0,
-							   info,
-							   &sun4i_ts_tz_ops);
-		if (IS_ERR(tzd)) {
+		info->sensor_device = pdev->dev.parent;
+		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
+							    0, info,
+							    &sun4i_ts_tz_ops);
+		if (IS_ERR(info->tzd)) {
 			dev_err(&pdev->dev,
 				"could not register thermal sensor: %ld\n",
-				PTR_ERR(tzd));
-			return PTR_ERR(tzd);
+				PTR_ERR(info->tzd));
+			return PTR_ERR(info->tzd);
 		}
 	} else {
 		indio_dev->num_channels =
@@ -688,7 +690,13 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!info->no_irq && IS_ENABLED(CONFIG_THERMAL_OF))
+
+	if (!IS_ENABLED(CONFIG_THERMAL_OF))
+		return 0;
+
+	thermal_zone_of_sensor_unregister(info->sensor_device, info->tzd);
+
+	if (!info->no_irq)
 		iio_map_array_unregister(indio_dev);
 
 	return 0;
-- 
2.11.0
