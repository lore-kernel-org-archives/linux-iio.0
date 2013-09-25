Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 04/32] iio: adc: twl6030-gpadc: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:40 +0530
Message-Id: <1380106208-6948-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/twl6030-gpadc.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 0ea96c0..cd16077 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -948,17 +948,14 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	indio_dev->channels = pdata->iio_channels;
 	indio_dev->num_channels = pdata->nchannels;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
 
 	return ret;
 }
 
 static int twl6030_gpadc_remove(struct platform_device *pdev)
 {
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-
 	twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
-	iio_device_unregister(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
