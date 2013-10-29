Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:42966 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3J2Lla (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:30 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so8157411pdj.23
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:30 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 06/33] iio: adc: viperboard: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:29 +0530
Message-Id: <1383046796-329-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

