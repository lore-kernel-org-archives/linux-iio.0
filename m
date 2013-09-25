Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 07/32] iio: dac: ad5755: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:43 +0530
Message-Id: <1380106208-6948-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5755.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index f305a0c..35796f5 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -596,7 +596,7 @@ static int ad5755_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to register iio device: %d\n", ret);
 		return ret;
@@ -605,15 +605,6 @@ static int ad5755_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int ad5755_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static const struct spi_device_id ad5755_id[] = {
 	{ "ad5755", ID_AD5755 },
 	{ "ad5755-1", ID_AD5755 },
@@ -630,7 +621,6 @@ static struct spi_driver ad5755_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = ad5755_probe,
-	.remove = ad5755_remove,
 	.id_table = ad5755_id,
 };
 module_spi_driver(ad5755_driver);
-- 
1.7.9.5
