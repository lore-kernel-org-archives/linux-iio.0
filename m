Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 15/32] staging: iio: lpc32xx_adc: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:51 +0530
Message-Id: <1380106208-6948-16-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/adc/lpc32xx_adc.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index ce7ff3e..840af87 100644
--- a/drivers/staging/iio/adc/lpc32xx_adc.c
+++ b/drivers/staging/iio/adc/lpc32xx_adc.c
@@ -183,7 +183,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	iodev->channels = lpc32xx_adc_iio_channels;
 	iodev->num_channels = ARRAY_SIZE(lpc32xx_adc_iio_channels);
 
-	retval = iio_device_register(iodev);
+	retval = devm_iio_device_register(&pdev->dev, iodev);
 	if (retval)
 		return retval;
 
@@ -192,15 +192,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int lpc32xx_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *iodev = platform_get_drvdata(pdev);
-
-	iio_device_unregister(iodev);
-
-	return 0;
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id lpc32xx_adc_match[] = {
 	{ .compatible = "nxp,lpc3220-adc" },
@@ -211,7 +202,6 @@ MODULE_DEVICE_TABLE(of, lpc32xx_adc_match);
 
 static struct platform_driver lpc32xx_adc_driver = {
 	.probe		= lpc32xx_adc_probe,
-	.remove		= lpc32xx_adc_remove,
 	.driver		= {
 		.name	= MOD_NAME,
 		.owner	= THIS_MODULE,
-- 
1.7.9.5
