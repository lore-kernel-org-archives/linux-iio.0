Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	sachin.kamat@linaro.org,
	jic23@kernel.org
Subject: [PATCH 08/12] staging: iio: ad9910: Use devm_iio_device_alloc
Date: Thu,  5 Sep 2013 14:59:53 +0530
Message-Id: <1378373397-22919-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/frequency/ad9910.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9910.c b/drivers/staging/iio/frequency/ad9910.c
index e48f874..a7d528e 100644
--- a/drivers/staging/iio/frequency/ad9910.c
+++ b/drivers/staging/iio/frequency/ad9910.c
@@ -367,11 +367,9 @@ static int ad9910_probe(struct spi_device *spi)
 	struct iio_dev *idev;
 	int ret = 0;
 
-	idev = iio_device_alloc(sizeof(*st));
-	if (idev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	idev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!idev)
+		return -ENOMEM;
 	spi_set_drvdata(spi, idev);
 	st = iio_priv(idev);
 	mutex_init(&st->lock);
@@ -383,24 +381,18 @@ static int ad9910_probe(struct spi_device *spi)
 
 	ret = iio_device_register(idev);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 	spi->max_speed_hz = 2000000;
 	spi->mode = SPI_MODE_3;
 	spi->bits_per_word = 8;
 	spi_setup(spi);
 	ad9910_init(st);
 	return 0;
-
-error_free_dev:
-	iio_device_free(idev);
-error_ret:
-	return ret;
 }
 
 static int ad9910_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.9.5
