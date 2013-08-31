Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:47845 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRNC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:13:02 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so3563877pab.15
        for <linux-iio@vger.kernel.org>; Sat, 31 Aug 2013 10:13:02 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 5/9] staging: iio: ad7780: Use devm_* APIs
Date: Sat, 31 Aug 2013 22:42:35 +0530
Message-Id: <1377969159-2491-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/adc/ad7780.c |   28 +++++++---------------------
 1 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index e1f8860..4f2522a 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -171,7 +171,7 @@ static int ad7780_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -180,11 +180,11 @@ static int ad7780_probe(struct spi_device *spi)
 
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
 
-	st->reg = regulator_get(&spi->dev, "vcc");
+	st->reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-			goto error_put_reg;
+			return ret;
 
 		voltage_uv = regulator_get_voltage(st->reg);
 	}
@@ -210,8 +210,8 @@ static int ad7780_probe(struct spi_device *spi)
 
 	if (pdata && gpio_is_valid(pdata->gpio_pdrst)) {
 
-		ret = gpio_request_one(pdata->gpio_pdrst, GPIOF_OUT_INIT_LOW,
-			       "AD7780 /PDRST");
+		ret = devm_gpio_request_one(&spi->dev, pdata->gpio_pdrst,
+					GPIOF_OUT_INIT_LOW, "AD7780 /PDRST");
 		if (ret) {
 			dev_err(&spi->dev, "failed to request GPIO PDRST\n");
 			goto error_disable_reg;
@@ -223,7 +223,7 @@ static int ad7780_probe(struct spi_device *spi)
 
 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
 	if (ret)
-		goto error_free_gpio;
+		goto error_disable_reg;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -233,17 +233,9 @@ static int ad7780_probe(struct spi_device *spi)
 
 error_cleanup_buffer_and_trigger:
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_free_gpio:
-	if (pdata && gpio_is_valid(pdata->gpio_pdrst))
-		gpio_free(pdata->gpio_pdrst);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
-
-	iio_device_free(indio_dev);
 
 	return ret;
 }
@@ -256,14 +248,8 @@ static int ad7780_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
-	if (gpio_is_valid(st->powerdown_gpio))
-		gpio_free(st->powerdown_gpio);
-
-	if (!IS_ERR(st->reg)) {
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
-		regulator_put(st->reg);
-	}
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

