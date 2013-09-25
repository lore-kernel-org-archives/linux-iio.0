Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 06/32] iio: dac: ad5421: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:42 +0530
Message-Id: <1380106208-6948-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5421.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
index 1f78b14..5d68af6 100644
--- a/drivers/iio/dac/ad5421.c
+++ b/drivers/iio/dac/ad5421.c
@@ -494,7 +494,7 @@ static int ad5421_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to register iio device: %d\n", ret);
 		return ret;
@@ -503,22 +503,12 @@ static int ad5421_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int ad5421_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static struct spi_driver ad5421_driver = {
 	.driver = {
 		   .name = "ad5421",
 		   .owner = THIS_MODULE,
 	},
 	.probe = ad5421_probe,
-	.remove = ad5421_remove,
 };
 module_spi_driver(ad5421_driver);
 
-- 
1.7.9.5
