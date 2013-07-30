Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] iio: imu: adis16480: Use devm_iio_device_alloc
Date: Tue, 30 Jul 2013 14:14:24 +0530
Message-Id: <1375173868-13235-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
References: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16480.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index b7db383..dd4206c 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -839,7 +839,7 @@ static int adis16480_probe(struct spi_device *spi)
 	struct adis16480 *st;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -857,11 +857,11 @@ static int adis16480_probe(struct spi_device *spi)
 
 	ret = adis_init(&st->adis, indio_dev, spi, &adis16480_data);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	ret = adis16480_initial_setup(indio_dev);
 	if (ret)
@@ -879,8 +879,6 @@ error_stop_device:
 	adis16480_stop_device(indio_dev);
 error_cleanup_buffer:
 	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
 	return ret;
 }
 
@@ -894,8 +892,6 @@ static int adis16480_remove(struct spi_device *spi)
 
 	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
 
-	iio_device_free(indio_dev);
-
 	return 0;
 }
 
-- 
1.7.9.5
