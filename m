Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 06/14] iio: dac: ad5449: Use devm_* APIs
Date: Mon, 19 Aug 2013 17:08:17 +0530
Message-Id: <1376912305-6423-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5449.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
index ba1c914..fff7d07 100644
--- a/drivers/iio/dac/ad5449.c
+++ b/drivers/iio/dac/ad5449.c
@@ -275,7 +275,7 @@ static int ad5449_spi_probe(struct spi_device *spi)
 	unsigned int i;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -288,14 +288,14 @@ static int ad5449_spi_probe(struct spi_device *spi)
 	for (i = 0; i < st->chip_info->num_channels; ++i)
 		st->vref_reg[i].supply = ad5449_vref_name(st, i);
 
-	ret = regulator_bulk_get(&spi->dev, st->chip_info->num_channels,
+	ret = devm_regulator_bulk_get(&spi->dev, st->chip_info->num_channels,
 				st->vref_reg);
 	if (ret)
-		goto error_free;
+		return ret;
 
 	ret = regulator_bulk_enable(st->chip_info->num_channels, st->vref_reg);
 	if (ret)
-		goto error_free_reg;
+		return ret;
 
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = id->name;
@@ -325,10 +325,6 @@ static int ad5449_spi_probe(struct spi_device *spi)
 
 error_disable_reg:
 	regulator_bulk_disable(st->chip_info->num_channels, st->vref_reg);
-error_free_reg:
-	regulator_bulk_free(st->chip_info->num_channels, st->vref_reg);
-error_free:
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -341,9 +337,6 @@ static int ad5449_spi_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 
 	regulator_bulk_disable(st->chip_info->num_channels, st->vref_reg);
-	regulator_bulk_free(st->chip_info->num_channels, st->vref_reg);
-
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
