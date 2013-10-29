Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36490 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab3J2Ll5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:57 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so6621594pde.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:57 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 16/33] staging: iio: lpc32xx_adc: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:39 +0530
Message-Id: <1383046796-329-17-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/adc/lpc32xx_adc.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
index ef0a21d..a876ce7 100644
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

