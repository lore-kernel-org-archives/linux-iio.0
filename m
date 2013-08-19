Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 07/14] iio: dac: ad5504: Use devm_* APIs
Date: Mon, 19 Aug 2013 17:08:18 +0530
Message-Id: <1376912305-6423-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/dac/ad5504.c |   31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 139206e..caffb16 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -281,16 +281,14 @@ static int ad5504_probe(struct spi_device *spi)
 	struct regulator *reg;
 	int ret, voltage_uv = 0;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	reg = regulator_get(&spi->dev, "vcc");
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+	reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(reg)) {
 		ret = regulator_enable(reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 
 		ret = regulator_get_voltage(reg);
 		if (ret < 0)
@@ -321,7 +319,7 @@ static int ad5504_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	if (spi->irq) {
-		ret = request_threaded_irq(spi->irq,
+		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
 					   NULL,
 					   &ad5504_event_handler,
 					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
@@ -333,22 +331,14 @@ static int ad5504_probe(struct spi_device *spi)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_irq;
+		goto error_disable_reg;
 
 	return 0;
 
-error_free_irq:
-	if (spi->irq)
-		free_irq(spi->irq, indio_dev);
 error_disable_reg:
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
-error_put_reg:
-	if (!IS_ERR(reg))
-		regulator_put(reg);
 
-	iio_device_free(indio_dev);
-error_ret:
 	return ret;
 }
 
@@ -358,14 +348,9 @@ static int ad5504_remove(struct spi_device *spi)
 	struct ad5504_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	if (spi->irq)
-		free_irq(spi->irq, indio_dev);
 
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
