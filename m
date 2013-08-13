Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jic23@cam.ac.uk,
	sachin.kamat@linaro.org
Subject: [PATCH 9/9] iio: gyro: adis16060_core: Use devm_iio_device_alloc
Date: Tue, 13 Aug 2013 12:04:35 +0530
Message-Id: <1376375675-11595-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org>
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/gyro/adis16060_core.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index c67d3a8..6d3d771 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -151,11 +151,9 @@ static int adis16060_r_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
@@ -171,23 +169,16 @@ static int adis16060_r_probe(struct spi_device *spi)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	adis16060_iio_dev = indio_dev;
 	return 0;
-
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
-	return ret;
 }
 
 /* fixme, confirm ordering in this function */
 static int adis16060_r_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_device_free(spi_get_drvdata(spi));
-
 	return 0;
 }
 
-- 
1.7.9.5
