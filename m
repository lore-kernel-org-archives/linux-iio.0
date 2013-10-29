Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:60889 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab3J2LmU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:42:20 -0400
Received: by mail-pd0-f179.google.com with SMTP id y10so8438895pdj.38
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:42:20 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 25/33] staging: iio: adis16060: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:48 +0530
Message-Id: <1383046796-329-26-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/gyro/adis16060_core.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 6d3d771..d5d395c 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -167,7 +167,7 @@ static int adis16060_r_probe(struct spi_device *spi)
 	indio_dev->channels = adis16060_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adis16060_channels);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -175,13 +175,6 @@ static int adis16060_r_probe(struct spi_device *spi)
 	return 0;
 }
 
-/* fixme, confirm ordering in this function */
-static int adis16060_r_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
-	return 0;
-}
-
 static int adis16060_w_probe(struct spi_device *spi)
 {
 	int ret;
@@ -211,7 +204,6 @@ static struct spi_driver adis16060_r_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16060_r_probe,
-	.remove = adis16060_r_remove,
 };
 
 static struct spi_driver adis16060_w_driver = {
-- 
1.7.9.5

