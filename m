Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 21/32] staging: iio: ad9852: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:57 +0530
Message-Id: <1380106208-6948-22-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/frequency/ad9852.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9852.c b/drivers/staging/iio/frequency/ad9852.c
index 4be2cf8..1e18af9 100644
--- a/drivers/staging/iio/frequency/ad9852.c
+++ b/drivers/staging/iio/frequency/ad9852.c
@@ -241,7 +241,7 @@ static int ad9852_probe(struct spi_device *spi)
 	idev->info = &ad9852_info;
 	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(idev);
+	ret = devm_iio_device_register(&spi->dev, idev);
 	if (ret)
 		return ret;
 	spi->max_speed_hz = 2000000;
@@ -253,20 +253,12 @@ static int ad9852_probe(struct spi_device *spi)
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
