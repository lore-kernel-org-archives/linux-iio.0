Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34165 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3J2Llg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:36 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so8605565pab.8
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:36 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 08/33] iio: dac: ad5755: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:31 +0530
Message-Id: <1383046796-329-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5755.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 9a78d5a..ee1e95a 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -589,16 +589,7 @@ static int ad5755_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return iio_device_register(indio_dev);
-}
-
-static int ad5755_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad5755_id[] = {
@@ -617,7 +608,6 @@ static struct spi_driver ad5755_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad5755_probe,
-	.remove = ad5755_remove,
 	.id_table = ad5755_id,
 };
 module_spi_driver(ad5755_driver);
-- 
1.7.9.5

