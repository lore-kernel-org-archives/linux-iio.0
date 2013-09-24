Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 7/8] iio: adc: viperboard: Use devm_iio_device_register
Date: Tue, 24 Sep 2013 17:35:37 +0530
Message-Id: <1380024338-30204-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
References: <1380024338-30204-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/viperboard_adc.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 09727a7..674b333 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -139,7 +139,7 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = vprbrd_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(vprbrd_adc_iio_channels);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register iio (adc)");
 		return ret;
@@ -150,22 +150,12 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int vprbrd_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static struct platform_driver vprbrd_adc_driver = {
 	.driver = {
 		.name	= "viperboard-adc",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= vprbrd_adc_probe,
-	.remove		= vprbrd_adc_remove,
 };
 
 module_platform_driver(vprbrd_adc_driver);
-- 
1.7.9.5
