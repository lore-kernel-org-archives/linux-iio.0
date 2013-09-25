Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 11/32] iio: gyro: adxrs450: Use devm_iio_device_register
Date: Wed, 25 Sep 2013 16:19:47 +0530
Message-Id: <1380106208-6948-12-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_register simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/gyro/adxrs450.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index c1f40ef..ab78b57 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -442,23 +442,14 @@ static int adxrs450_probe(struct spi_device *spi)
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
@@ -476,7 +467,6 @@ static struct spi_driver adxrs450_driver = {
 		.owner = THIS_MODULE,
 	},
 	.probe = adxrs450_probe,
-	.remove = adxrs450_remove,
 	.id_table	= adxrs450_id,
 };
 module_spi_driver(adxrs450_driver);
-- 
1.7.9.5
