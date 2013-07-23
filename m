Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] iio: adc: ad7266: Use devm_* APIs
Date: Tue, 23 Jul 2013 12:20:10 +0530
Message-Id: <1374562210-29171-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7266.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index c2744a7..371731d 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -399,17 +399,17 @@ static int ad7266_probe(struct spi_device *spi)
 	unsigned int i;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
-	st->reg = regulator_get(&spi->dev, "vref");
+	st->reg = devm_regulator_get(&spi->dev, "vref");
 	if (!IS_ERR_OR_NULL(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 
 		ret = regulator_get_voltage(st->reg);
 		if (ret < 0)
@@ -489,11 +489,6 @@ error_free_gpios:
 error_disable_reg:
 	if (!IS_ERR_OR_NULL(st->reg))
 		regulator_disable(st->reg);
-error_put_reg:
-	if (!IS_ERR_OR_NULL(st->reg))
-		regulator_put(st->reg);
-
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -507,11 +502,8 @@ static int ad7266_remove(struct spi_device *spi)
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (!st->fixed_addr)
 		gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
-	if (!IS_ERR_OR_NULL(st->reg)) {
+	if (!IS_ERR_OR_NULL(st->reg))
 		regulator_disable(st->reg);
-		regulator_put(st->reg);
-	}
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
