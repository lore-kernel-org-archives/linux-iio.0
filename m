Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Milo Kim <milo.kim@ti.com>
Subject: [PATCH 07/11] iio: adc: lp8788_adc: Use devm_* APIs
Date: Tue, 23 Jul 2013 14:28:13 +0530
Message-Id: <1374569897-3858-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Milo Kim <milo.kim@ti.com>
---
 drivers/iio/adc/lp8788_adc.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index 62bc39e..5c8c915 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -194,7 +194,7 @@ static int lp8788_adc_probe(struct platform_device *pdev)
 	struct lp8788_adc *adc;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*adc));
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -205,7 +205,7 @@ static int lp8788_adc_probe(struct platform_device *pdev)
 	indio_dev->dev.of_node = pdev->dev.of_node;
 	ret = lp8788_iio_map_register(indio_dev, lp->pdata, adc);
 	if (ret)
-		goto err_iio_map;
+		return ret;
 
 	mutex_init(&adc->lock);
 
@@ -226,8 +226,6 @@ static int lp8788_adc_probe(struct platform_device *pdev)
 
 err_iio_device:
 	iio_map_array_unregister(indio_dev);
-err_iio_map:
-	iio_device_free(indio_dev);
 	return ret;
 }
 
@@ -237,7 +235,6 @@ static int lp8788_adc_remove(struct platform_device *pdev)
 
 	iio_device_unregister(indio_dev);
 	iio_map_array_unregister(indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
