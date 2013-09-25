Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 10/32] iio: gyro: adis16130: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:46 +0530
Message-Id: <1380106208-6948-11-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/gyro/adis16130.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
index 9155cf6..3f79eff 100644
--- a/drivers/iio/gyro/adis16130.c
+++ b/drivers/iio/gyro/adis16130.c
@@ -165,13 +165,7 @@ static int adis16130_probe(struct spi_device *spi)
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
@@ -180,7 +174,6 @@ static struct spi_driver adis16130_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adis16130_probe,
-	.remove = adis16130_remove,
 };
 module_spi_driver(adis16130_driver);
 
-- 
1.7.9.5
