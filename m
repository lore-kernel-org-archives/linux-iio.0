Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: [PATCH 02/11] iio: adc: ad7476: Use devm_* APIs
Date: Tue, 23 Jul 2013 14:28:08 +0530
Message-Id: <1374569897-3858-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
 drivers/iio/adc/ad7476.c |   26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 2e98bef4..6d2b1d8 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -213,24 +213,21 @@ static int ad7476_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
 	st = iio_priv(indio_dev);
 	st->chip_info =
 		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	st->reg = regulator_get(&spi->dev, "vcc");
-	if (IS_ERR(st->reg)) {
-		ret = PTR_ERR(st->reg);
-		goto error_free_dev;
-	}
+	st->reg = devm_regulator_get(&spi->dev, "vcc");
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
 
 	ret = regulator_enable(st->reg);
 	if (ret)
-		goto error_put_reg;
+		return ret;
 
 	spi_set_drvdata(spi, indio_dev);
 
@@ -268,12 +265,7 @@ error_ring_unregister:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_reg:
 	regulator_disable(st->reg);
-error_put_reg:
-	regulator_put(st->reg);
-error_free_dev:
-	iio_device_free(indio_dev);
 
-error_ret:
 	return ret;
 }
 
@@ -285,8 +277,6 @@ static int ad7476_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	regulator_disable(st->reg);
-	regulator_put(st->reg);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.9.5
