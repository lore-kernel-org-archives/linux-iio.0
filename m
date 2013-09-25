Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 14/32] staging: iio: ad7816: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:50 +0530
Message-Id: <1380106208-6948-15-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/adc/ad7816.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 9f48e5c..2369cf2 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -412,7 +412,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi_dev->dev, indio_dev);
 	if (ret)
 		return ret;
 
@@ -422,15 +422,6 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	return 0;
 }
 
-static int ad7816_remove(struct spi_device *spi_dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static const struct spi_device_id ad7816_id[] = {
 	{ "ad7816", 0 },
 	{ "ad7817", 0 },
@@ -446,7 +437,6 @@ static struct spi_driver ad7816_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad7816_probe,
-	.remove = ad7816_remove,
 	.id_table = ad7816_id,
 };
 module_spi_driver(ad7816_driver);
-- 
1.7.9.5
