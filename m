Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	sachin.kamat@linaro.org
Subject: [PATCH 1/9] staging: iio: ad7192: Use devm_* APIs
Date: Sat, 31 Aug 2013 22:42:31 +0530
Message-Id: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
This series is compile tested and based on togreg branch
of iio tree.
---
 drivers/staging/iio/adc/ad7192.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 3283e28..83bb44b 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -623,17 +623,17 @@ static int ad7192_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
-	st->reg = regulator_get(&spi->dev, "vcc");
+	st->reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 
 		voltage_uv = regulator_get_voltage(st->reg);
 	}
@@ -677,11 +677,6 @@ error_remove_trigger:
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
-
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -694,10 +689,8 @@ static int ad7192_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
-	if (!IS_ERR(st->reg)) {
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-		regulator_put(st->reg);
-	}
 
 	return 0;
 }
-- 
1.7.4.1
