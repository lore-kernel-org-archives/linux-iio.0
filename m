Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	patches@linaro.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 4/8] iio: frequency: adf4350: Use devm_* APIs
Date: Mon, 22 Jul 2013 16:32:57 +0530
Message-Id: <1374490981-24373-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
References: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

devm_* APIs are device managed and make code simpler.
This also takes care of missing clk_put function calls implicitly.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/frequency/adf4350.c |   31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index a4157cd..a7b30be 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -515,7 +515,7 @@ static int adf4350_probe(struct spi_device *spi)
 	}
 
 	if (!pdata->clkin) {
-		clk = clk_get(&spi->dev, "clkin");
+		clk = devm_clk_get(&spi->dev, "clkin");
 		if (IS_ERR(clk))
 			return -EPROBE_DEFER;
 
@@ -524,17 +524,17 @@ static int adf4350_probe(struct spi_device *spi)
 			return ret;
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
+			goto error_disable_clk;
 	}
 
 	spi_set_drvdata(spi, indio_dev);
@@ -564,7 +564,8 @@ static int adf4350_probe(struct spi_device *spi)
 	memset(st->regs_hw, 0xFF, sizeof(st->regs_hw));
 
 	if (gpio_is_valid(pdata->gpio_lock_detect)) {
-		ret = gpio_request(pdata->gpio_lock_detect, indio_dev->name);
+		ret = devm_gpio_request(&spi->dev, pdata->gpio_lock_detect,
+					indio_dev->name);
 		if (ret) {
 			dev_err(&spi->dev, "fail to request lock detect GPIO-%d",
 				pdata->gpio_lock_detect);
@@ -576,29 +577,21 @@ static int adf4350_probe(struct spi_device *spi)
 	if (pdata->power_up_frequency) {
 		ret = adf4350_set_freq(st, pdata->power_up_frequency);
 		if (ret)
-			goto error_free_gpio;
+			goto error_disable_reg;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_gpio;
+		goto error_disable_reg;
 
 	return 0;
 
-error_free_gpio:
-	if (gpio_is_valid(pdata->gpio_lock_detect))
-		gpio_free(pdata->gpio_lock_detect);
-
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
-
+error_disable_clk:
 	if (clk)
 		clk_disable_unprepare(clk);
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -619,14 +612,8 @@ static int adf4350_remove(struct spi_device *spi)
 
 	if (!IS_ERR(reg)) {
 		regulator_disable(reg);
-		regulator_put(reg);
 	}
 
-	if (gpio_is_valid(st->pdata->gpio_lock_detect))
-		gpio_free(st->pdata->gpio_lock_detect);
-
-	iio_device_free(indio_dev);
-
 	return 0;
 }
 
-- 
1.7.9.5
