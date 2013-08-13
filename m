Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jic23@cam.ac.uk,
	sachin.kamat@linaro.org
Subject: [PATCH 4/9] iio: gyro: adis16260: Use devm_iio_device_alloc
Date: Tue, 13 Aug 2013 12:04:30 +0530
Message-Id: <1376375675-11595-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org>
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/gyro/adis16260.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index b4cf800..0654116 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -343,11 +343,9 @@ static int adis16260_probe(struct spi_device *spi)
 	int ret;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_device_alloc(sizeof(*adis));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adis));
+	if (!indio_dev)
+		return -ENOMEM;
 	adis = iio_priv(indio_dev);
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
@@ -361,11 +359,11 @@ static int adis16260_probe(struct spi_device *spi)
 
 	ret = adis_init(adis, indio_dev, spi, &adis16260_data);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	ret = adis_setup_buffer_and_trigger(adis, indio_dev, NULL);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	/* Get the device into a sane initial state */
 	ret = adis_initial_startup(adis);
@@ -379,9 +377,6 @@ static int adis16260_probe(struct spi_device *spi)
 
 error_cleanup_buffer_trigger:
 	adis_cleanup_buffer_and_trigger(adis, indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
 	return ret;
 }
 
@@ -393,7 +388,6 @@ static int adis16260_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	adis16260_stop_device(indio_dev);
 	adis_cleanup_buffer_and_trigger(adis, indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
