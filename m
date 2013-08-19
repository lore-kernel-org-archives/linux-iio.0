Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 11/14] iio: dac: ad5764: Use devm_* APIs
Date: Mon, 19 Aug 2013 17:08:22 +0530
Message-Id: <1376912305-6423-11-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5764.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
index 7a53f7d..df7e028 100644
--- a/drivers/iio/dac/ad5764.c
+++ b/drivers/iio/dac/ad5764.c
@@ -275,7 +275,7 @@ static int ad5764_probe(struct spi_device *spi)
 	struct ad5764_state *st;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL) {
 		dev_err(&spi->dev, "Failed to allocate iio device\n");
 		return -ENOMEM;
@@ -298,12 +298,12 @@ static int ad5764_probe(struct spi_device *spi)
 		st->vref_reg[0].supply = "vrefAB";
 		st->vref_reg[1].supply = "vrefCD";
 
-		ret = regulator_bulk_get(&st->spi->dev,
+		ret = devm_regulator_bulk_get(&st->spi->dev,
 			ARRAY_SIZE(st->vref_reg), st->vref_reg);
 		if (ret) {
 			dev_err(&spi->dev, "Failed to request vref regulators: %d\n",
 				ret);
-			goto error_free;
+			return ret;
 		}
 
 		ret = regulator_bulk_enable(ARRAY_SIZE(st->vref_reg),
@@ -311,7 +311,7 @@ static int ad5764_probe(struct spi_device *spi)
 		if (ret) {
 			dev_err(&spi->dev, "Failed to enable vref regulators: %d\n",
 				ret);
-			goto error_free_reg;
+			return ret;
 		}
 	}
 
@@ -326,12 +326,6 @@ static int ad5764_probe(struct spi_device *spi)
 error_disable_reg:
 	if (st->chip_info->int_vref == 0)
 		regulator_bulk_disable(ARRAY_SIZE(st->vref_reg), st->vref_reg);
-error_free_reg:
-	if (st->chip_info->int_vref == 0)
-		regulator_bulk_free(ARRAY_SIZE(st->vref_reg), st->vref_reg);
-error_free:
-	iio_device_free(indio_dev);
-
 	return ret;
 }
 
@@ -342,12 +336,8 @@ static int ad5764_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 
-	if (st->chip_info->int_vref == 0) {
+	if (st->chip_info->int_vref == 0)
 		regulator_bulk_disable(ARRAY_SIZE(st->vref_reg), st->vref_reg);
-		regulator_bulk_free(ARRAY_SIZE(st->vref_reg), st->vref_reg);
-	}
-
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
