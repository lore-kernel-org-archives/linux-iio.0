Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:35688 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576Ab3J2Llq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2013 07:41:46 -0400
Received: by mail-pb0-f42.google.com with SMTP id jt11so7864102pbb.29
        for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2013 04:41:46 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 12/33] iio: gyro: adxrs450: Use devm_iio_device_register
Date: Tue, 29 Oct 2013 17:09:35 +0530
Message-Id: <1383046796-329-13-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/gyro/adxrs450.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index 1e546ba..eb0e08e 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -434,23 +434,14 @@ static int adxrs450_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(adxrs450_channels);
 	indio_dev->name = spi->dev.driver->name;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret)
 		return ret;
 
 	/* Get the device into a sane initial state */
 	ret = adxrs450_initial_setup(indio_dev);
 	if (ret)
-		goto error_initial;
-	return 0;
-error_initial:
-	iio_device_unregister(indio_dev);
-	return ret;
-}
-
-static int adxrs450_remove(struct spi_device *spi)
-{
-	iio_device_unregister(spi_get_drvdata(spi));
+		return ret;
 
 	return 0;
 }
@@ -468,7 +459,6 @@ static struct spi_driver adxrs450_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adxrs450_probe,
-	.remove = adxrs450_remove,
 	.id_table	= adxrs450_id,
 };
 module_spi_driver(adxrs450_driver);
-- 
1.7.9.5

