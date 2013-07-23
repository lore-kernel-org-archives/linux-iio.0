Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/11] iio: adc: ad7791: Use devm_* APIs
Date: Tue, 23 Jul 2013 14:28:09 +0530
Message-Id: <1374569897-3858-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7791.c |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 5e8d1da..c202035 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -361,21 +361,19 @@ static int ad7791_probe(struct spi_device *spi)
 		return -ENXIO;
 	}
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
-	st->reg = regulator_get(&spi->dev, "refin");
-	if (IS_ERR(st->reg)) {
-		ret = PTR_ERR(st->reg);
-		goto err_iio_free;
-	}
+	st->reg = devm_regulator_get(&spi->dev, "refin");
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
 
 	ret = regulator_enable(st->reg);
 	if (ret)
-		goto error_put_reg;
+		return ret;
 
 	st->info = &ad7791_chip_infos[spi_get_device_id(spi)->driver_data];
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7791_sigma_delta_info);
@@ -410,10 +408,6 @@ error_remove_trigger:
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_disable_reg:
 	regulator_disable(st->reg);
-error_put_reg:
-	regulator_put(st->reg);
-err_iio_free:
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -427,9 +421,6 @@ static int ad7791_remove(struct spi_device *spi)
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
 	regulator_disable(st->reg);
-	regulator_put(st->reg);
-
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
