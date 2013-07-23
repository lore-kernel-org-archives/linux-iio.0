Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: [PATCH 04/11] iio: adc: ad7793: Use devm_* APIs
Date: Tue, 23 Jul 2013 14:28:10 +0530
Message-Id: <1374569897-3858-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
 drivers/iio/adc/ad7793.c |   23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 334e31f..4dddeab 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -757,7 +757,7 @@ static int ad7793_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -766,15 +766,13 @@ static int ad7793_probe(struct spi_device *spi)
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
 
 	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
-		st->reg = regulator_get(&spi->dev, "refin");
-		if (IS_ERR(st->reg)) {
-			ret = PTR_ERR(st->reg);
-			goto error_device_free;
-		}
+		st->reg = devm_regulator_get(&spi->dev, "refin");
+		if (IS_ERR(st->reg))
+			return PTR_ERR(st->reg);
 
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 
 		vref_mv = regulator_get_voltage(st->reg);
 		if (vref_mv < 0) {
@@ -818,11 +816,6 @@ error_remove_trigger:
 error_disable_reg:
 	if (pdata->refsel != AD7793_REFSEL_INTERNAL)
 		regulator_disable(st->reg);
-error_put_reg:
-	if (pdata->refsel != AD7793_REFSEL_INTERNAL)
-		regulator_put(st->reg);
-error_device_free:
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -836,12 +829,8 @@ static int ad7793_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
-	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
+	if (pdata->refsel != AD7793_REFSEL_INTERNAL)
 		regulator_disable(st->reg);
-		regulator_put(st->reg);
-	}
-
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
