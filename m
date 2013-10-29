Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:45395 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab3J2LmK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:42:10 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so3144638pbb.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:42:10 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 21/33] staging: iio: ad9850: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:44 +0530
Message-Id: <1383046796-329-22-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/frequency/ad9850.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9850.c b/drivers/staging/iio/frequency/ad9850.c
index af877ff..ec1a2f0 100644
--- a/drivers/staging/iio/frequency/ad9850.c
+++ b/drivers/staging/iio/frequency/ad9850.c
@@ -92,7 +92,7 @@ static int ad9850_probe(struct spi_device *spi)
 	idev->info = &ad9850_info;
 	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(idev);
+	ret = devm_iio_device_register(&spi->dev, idev);
 	if (ret)
 		return ret;
 	spi->max_speed_hz = 2000000;
@@ -103,20 +103,12 @@ static int ad9850_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int ad9850_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-
-	return 0;
-}
-
 static struct spi_driver ad9850_driver = {
 	.driver = {
 		.name = DRV_NAME,
 		.owner = THIS_MODULE,
 	},
 	.probe = ad9850_probe,
-	.remove = ad9850_remove,
 };
 module_spi_driver(ad9850_driver);
 
-- 
1.7.9.5

