Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 10/14] iio: dac: ad5755: Use devm_iio_device_alloc
Date: Mon, 19 Aug 2013 17:08:21 +0530
Message-Id: <1376912305-6423-10-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5755.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 12bb315..124d53b 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -565,7 +565,7 @@ static int ad5755_probe(struct spi_device *spi)
 	struct ad5755_state *st;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL) {
 		dev_err(&spi->dev, "Failed to allocate iio device\n");
 		return  -ENOMEM;
@@ -589,24 +589,19 @@ static int ad5755_probe(struct spi_device *spi)
 
 	ret = ad5755_init_channels(indio_dev, pdata);
 	if (ret)
-		goto error_free;
+		return ret;
 
 	ret = ad5755_setup_pdata(indio_dev, pdata);
 	if (ret)
-		goto error_free;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to register iio device: %d\n", ret);
-		goto error_free;
+		return ret;
 	}
 
 	return 0;
-
-error_free:
-	iio_device_free(indio_dev);
-
-	return ret;
 }
 
 static int ad5755_remove(struct spi_device *spi)
@@ -614,8 +609,6 @@ static int ad5755_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	iio_device_unregister(indio_dev);
-	iio_device_free(indio_dev);
-
 	return 0;
 }
 
-- 
1.7.9.5
