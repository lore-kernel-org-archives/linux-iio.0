Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:64636 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab3J2Ll2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:28 -0400
Received: by mail-pa0-f45.google.com with SMTP id kp14so8437571pab.32
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:27 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 05/33] iio: adc: twl6030-gpadc: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:28 +0530
Message-Id: <1383046796-329-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/twl6030-gpadc.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 53e1c64..d1ef33c 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -948,15 +948,12 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	indio_dev->channels = pdata->iio_channels;
 	indio_dev->num_channels = pdata->nchannels;
 
-	return iio_device_register(indio_dev);
+	return devm_iio_device_register(&pdev->dev, indio_dev);
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

