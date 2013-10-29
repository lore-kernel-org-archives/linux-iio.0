Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:40801 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab3J2LmM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:42:12 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so3981345pab.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:42:12 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 22/33] staging: iio: ad9852: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:45 +0530
Message-Id: <1383046796-329-23-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/frequency/ad9852.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9852.c b/drivers/staging/iio/frequency/ad9852.c
index 11e4367..af2f2cc 100644
--- a/drivers/staging/iio/frequency/ad9852.c
+++ b/drivers/staging/iio/frequency/ad9852.c
@@ -218,7 +218,7 @@ static int ad9852_probe(struct spi_device *spi)
 	idev->info = &ad9852_info;
 	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(idev);
+	ret = devm_iio_device_register(&spi->dev, idev);
 	if (ret)
 		return ret;
 	spi->max_speed_hz = 2000000;
@@ -230,20 +230,12 @@ static int ad9852_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int ad9852_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-
-	return 0;
-}
-
 static struct spi_driver ad9852_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
 	},
 	.probe = ad9852_probe,
-	.remove = ad9852_remove,
 };
 module_spi_driver(ad9852_driver);
 
-- 
1.7.9.5

