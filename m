Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	sachin.kamat@linaro.org,
	jic23@kernel.org
Subject: [PATCH 04/12] staging: iio: ad9832: Use devm_* APIs
Date: Thu,  5 Sep 2013 14:59:49 +0530
Message-Id: <1378373397-22919-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/frequency/ad9832.c |   32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 4e18380..adc91b7 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -214,14 +214,14 @@ static int ad9832_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	reg = regulator_get(&spi->dev, "vcc");
+	reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(reg)) {
 		ret = regulator_enable(reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 	}
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
@@ -279,47 +279,42 @@ static int ad9832_probe(struct spi_device *spi)
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret) {
 		dev_err(&spi->dev, "device init failed\n");
-		goto error_free_device;
+		goto error_disable_reg;
 	}
 
 	ret = ad9832_write_frequency(st, AD9832_FREQ0HM, pdata->freq0);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
 	ret = ad9832_write_frequency(st, AD9832_FREQ1HM, pdata->freq1);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE0H, pdata->phase0);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE1H, pdata->phase1);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE2H, pdata->phase2);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
 	ret = ad9832_write_phase(st, AD9832_PHASE3H, pdata->phase3);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
 	return 0;
 
-error_free_device:
-	iio_device_free(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
-error_put_reg:
-	if (!IS_ERR(reg))
-		regulator_put(reg);
 
 	return ret;
 }
@@ -330,11 +325,8 @@ static int ad9832_remove(struct spi_device *spi)
 	struct ad9832_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg)) {
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-		regulator_put(st->reg);
-	}
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
