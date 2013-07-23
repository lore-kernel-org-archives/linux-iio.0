Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: [PATCH 05/11] iio: adc: ad7887: Use devm_* APIs
Date: Tue, 23 Jul 2013 14:28:11 +0530
Message-Id: <1374569897-3858-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
 drivers/iio/adc/ad7887.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index dd15a5b..9dd077b 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -237,25 +237,24 @@ static int ad7887_probe(struct spi_device *spi)
 {
 	struct ad7887_platform_data *pdata = spi->dev.platform_data;
 	struct ad7887_state *st;
-	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
+	struct iio_dev *indio_dev;
 	uint8_t mode;
 	int ret;
 
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 
 	if (!pdata || !pdata->use_onchip_ref) {
-		st->reg = regulator_get(&spi->dev, "vref");
-		if (IS_ERR(st->reg)) {
-			ret = PTR_ERR(st->reg);
-			goto error_free;
-		}
+		st->reg = devm_regulator_get(&spi->dev, "vref");
+		if (IS_ERR(st->reg))
+			return PTR_ERR(st->reg);
 
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 	}
 
 	st->chip_info =
@@ -331,11 +330,6 @@ error_unregister_ring:
 error_disable_reg:
 	if (st->reg)
 		regulator_disable(st->reg);
-error_put_reg:
-	if (st->reg)
-		regulator_put(st->reg);
-error_free:
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -347,11 +341,8 @@ static int ad7887_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	if (st->reg) {
+	if (st->reg)
 		regulator_disable(st->reg);
-		regulator_put(st->reg);
-	}
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
