Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 08/14] iio: dac: ad5624r_spi: Use devm_* APIs
Date: Mon, 19 Aug 2013 17:08:19 +0530
Message-Id: <1376912305-6423-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5624r_spi.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
index bb298aa..714af75 100644
--- a/drivers/iio/dac/ad5624r_spi.c
+++ b/drivers/iio/dac/ad5624r_spi.c
@@ -226,17 +226,15 @@ static int ad5624r_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	st->reg = regulator_get(&spi->dev, "vcc");
+	st->reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 
 		ret = regulator_get_voltage(st->reg);
 		if (ret < 0)
@@ -277,11 +275,6 @@ static int ad5624r_probe(struct spi_device *spi)
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
-	iio_device_free(indio_dev);
-error_ret:
 
 	return ret;
 }
@@ -292,11 +285,8 @@ static int ad5624r_remove(struct spi_device *spi)
 	struct ad5624r_state *st = iio_priv(indio_dev);
 
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
