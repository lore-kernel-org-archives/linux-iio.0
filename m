Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34375 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab3J2Llo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:44 -0400
Received: by mail-pd0-f174.google.com with SMTP id z10so3803282pdj.33
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:43 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 11/33] iio: gyro: adis16130: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:34 +0530
Message-Id: <1383046796-329-12-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/gyro/adis16130.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
index 445c2ae..8d08c7e 100644
--- a/drivers/iio/gyro/adis16130.c
+++ b/drivers/iio/gyro/adis16130.c
@@ -161,13 +161,7 @@ static int adis16130_probe(struct spi_device *spi)
 	indio_dev->info = &adis16130_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	return iio_device_register(indio_dev);
-}
-
-static int adis16130_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static struct spi_driver adis16130_driver = {
@@ -176,7 +170,6 @@ static struct spi_driver adis16130_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16130_probe,
-	.remove = adis16130_remove,
 };
 module_spi_driver(adis16130_driver);
 
-- 
1.7.9.5

