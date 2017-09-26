Return-Path: <SRS0=6t7A=A3=free-electrons.com=quentin.schulz@kernel.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com,
	wens@csie.org
Cc: linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com,
	thomas.petazzoni@free-electrons.com,
	icenowy@aosc.io,
	Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 1/2] iio: adc: sun4i-gpadc-iio: register in the thermal after registering in pm
Date: Tue, 26 Sep 2017 14:52:18 +0200
Message-Id: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

This driver has a get_temp function used by the thermal framework that
uses pm functions.

However, the driver isn't registered in pm before it is registered in
thermal framework, resulting in the pm_resume not being called and thus
the IP not enabled.

When the IP is disabled, the raw temp value is always 0. With the
devices currently supported, it isn't a problem since with their
respective formula, they return a really cold SoC temperature which
isn't a problem for the thermal framework. But for future SoC that have
a different formula, it could return a critically hot temperature,
forcing the thermal framework to shutdown the board.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 34 ++++++++++++++------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 137f577..392d47f 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -529,17 +529,10 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 		return ret;
 	}
 
-	if (!IS_ENABLED(CONFIG_THERMAL_OF))
-		return 0;
+	if (IS_ENABLED(CONFIG_THERMAL_OF))
+		info->sensor_device = &pdev->dev;
 
-	info->sensor_device = &pdev->dev;
-	info->tzd = thermal_zone_of_sensor_register(info->sensor_device, 0,
-						    info, &sun4i_ts_tz_ops);
-	if (IS_ERR(info->tzd))
-		dev_err(&pdev->dev, "could not register thermal sensor: %ld\n",
-			PTR_ERR(info->tzd));
-
-	return PTR_ERR_OR_ZERO(info->tzd);
+	return 0;
 }
 
 static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
@@ -586,15 +579,6 @@ static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
 		 * return the temperature.
 		 */
 		info->sensor_device = pdev->dev.parent;
-		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
-							    0, info,
-							    &sun4i_ts_tz_ops);
-		if (IS_ERR(info->tzd)) {
-			dev_err(&pdev->dev,
-				"could not register thermal sensor: %ld\n",
-				PTR_ERR(info->tzd));
-			return PTR_ERR(info->tzd);
-		}
 	} else {
 		indio_dev->num_channels =
 			ARRAY_SIZE(sun4i_gpadc_channels_no_temp);
@@ -664,6 +648,18 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
+		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
+							    0, info,
+							    &sun4i_ts_tz_ops);
+		if (IS_ERR(info->tzd)) {
+			dev_err(&pdev->dev,
+				"could not register thermal sensor: %ld\n",
+				PTR_ERR(info->tzd));
+			return PTR_ERR(info->tzd);
+		}
+	}
+
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not register the device\n");

base-commit: 1f183459b5144384e2669a3f757d36bacab108cf
-- 
git-series 0.9.1
