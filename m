Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:39972 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3J2Llf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:35 -0400
Received: by mail-pd0-f176.google.com with SMTP id g10so8435855pdj.35
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:33 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 07/33] iio: dac: ad5421: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:30 +0530
Message-Id: <1383046796-329-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5421.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 3eeaa82..7d1e908 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -514,16 +514,7 @@ static int ad5421_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	return iio_device_register(indio_dev);
-}
-
-static int ad5421_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static struct spi_driver ad5421_driver = {
@@ -532,7 +523,6 @@ static struct spi_driver ad5421_driver = {
 		   .owner = THIS_MODULE,
 	},
 	.probe = ad5421_probe,
-	.remove = ad5421_remove,
 };
 module_spi_driver(ad5421_driver);
 
-- 
1.7.9.5

