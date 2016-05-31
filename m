Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60086 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755414AbcEaRAf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 31 May 2016 13:00:35 -0400
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee.jones@linaro.org>,
	Dave Gerlach <d-gerlach@ti.com>
CC: <linux-iio@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 2/8] iio: adc: ti_am335x_adc: use SIMPLE_DEV_PM_OPS helper macro
Date: Tue, 31 May 2016 12:00:07 -0500
Message-ID: <20160531170013.2649-3-afd@ti.com>
In-Reply-To: <20160531170013.2649-1-afd@ti.com>
References: <20160531170013.2649-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace ifdefs with SIMPLE_DEV_PM_OPS helper macro.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/adc/ti_am335x_adc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index c1e0553..18af71d 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -531,8 +531,7 @@ static int tiadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int tiadc_suspend(struct device *dev)
+static int __maybe_unused tiadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
@@ -550,7 +549,7 @@ static int tiadc_suspend(struct device *dev)
 	return 0;
 }
 
-static int tiadc_resume(struct device *dev)
+static int __maybe_unused tiadc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
@@ -567,14 +566,7 @@ static int tiadc_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops tiadc_pm_ops = {
-	.suspend = tiadc_suspend,
-	.resume = tiadc_resume,
-};
-#define TIADC_PM_OPS (&tiadc_pm_ops)
-#else
-#define TIADC_PM_OPS NULL
-#endif
+static SIMPLE_DEV_PM_OPS(tiadc_pm_ops, tiadc_suspend, tiadc_resume);
 
 static const struct of_device_id ti_adc_dt_ids[] = {
 	{ .compatible = "ti,am3359-adc", },
@@ -585,7 +577,7 @@ MODULE_DEVICE_TABLE(of, ti_adc_dt_ids);
 static struct platform_driver tiadc_driver = {
 	.driver = {
 		.name   = "TI-am335x-adc",
-		.pm	= TIADC_PM_OPS,
+		.pm	= &tiadc_pm_ops,
 		.of_match_table = ti_adc_dt_ids,
 	},
 	.probe	= tiadc_probe,
-- 
2.8.3

