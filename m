Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org,
	Graff Yang <graff.yang@gmail.com>
Subject: [PATCH 05/10] staging: iio: ad2s90: Use devm_iio_device_alloc
Date: Wed, 11 Sep 2013 15:25:20 +0530
Message-Id: <1378893325-31764-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org>
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Graff Yang <graff.yang@gmail.com>
---
 drivers/staging/iio/resolver/ad2s90.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 40b8252..e24c589 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -64,11 +64,9 @@ static int ad2s90_probe(struct spi_device *spi)
 	struct ad2s90_state *st;
 	int ret = 0;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 
@@ -83,7 +81,7 @@ static int ad2s90_probe(struct spi_device *spi)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	/* need 600ns between CS and the first falling edge of SCLK */
 	spi->max_speed_hz = 830000;
@@ -91,17 +89,11 @@ static int ad2s90_probe(struct spi_device *spi)
 	spi_setup(spi);
 
 	return 0;
-
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
-	return ret;
 }
 
 static int ad2s90_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.9.5
