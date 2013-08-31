Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34191 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRNF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:13:05 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so3561978pad.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Aug 2013 10:13:04 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 6/9] staging: iio: ad7816: Use devm_* APIs
Date: Sat, 31 Aug 2013 22:42:36 +0530
Message-Id: <1377969159-2491-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_* APIs are device managed and make code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/adc/ad7816.c |   59 +++++++++++++-------------------------
 1 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 8470036..9f48e5c 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -356,11 +356,9 @@ static int ad7816_probe(struct spi_device *spi_dev)
 		return -EINVAL;
 	}
 
-	indio_dev = iio_device_alloc(sizeof(*chip));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
 	chip = iio_priv(indio_dev);
 	/* this is only used for device removal purposes */
 	dev_set_drvdata(&spi_dev->dev, indio_dev);
@@ -372,25 +370,28 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	chip->convert_pin = pins[1];
 	chip->busy_pin = pins[2];
 
-	ret = gpio_request(chip->rdwr_pin, spi_get_device_id(spi_dev)->name);
+	ret = devm_gpio_request(&spi_dev->dev, chip->rdwr_pin,
+					spi_get_device_id(spi_dev)->name);
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
 			chip->rdwr_pin);
-		goto error_free_device;
+		return ret;
 	}
 	gpio_direction_input(chip->rdwr_pin);
-	ret = gpio_request(chip->convert_pin, spi_get_device_id(spi_dev)->name);
+	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
+					spi_get_device_id(spi_dev)->name);
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
 			chip->convert_pin);
-		goto error_free_gpio_rdwr;
+		return ret;
 	}
 	gpio_direction_input(chip->convert_pin);
-	ret = gpio_request(chip->busy_pin, spi_get_device_id(spi_dev)->name);
+	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
+					spi_get_device_id(spi_dev)->name);
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
 			chip->busy_pin);
-		goto error_free_gpio_convert;
+		return ret;
 	}
 	gpio_direction_input(chip->busy_pin);
 
@@ -401,51 +402,31 @@ static int ad7816_probe(struct spi_device *spi_dev)
 
 	if (spi_dev->irq) {
 		/* Only low trigger is supported in ad7816/7/8 */
-		ret = request_threaded_irq(spi_dev->irq,
-					   NULL,
-					   &ad7816_event_handler,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					   indio_dev->name,
-					   indio_dev);
+		ret = devm_request_threaded_irq(&spi_dev->dev, spi_dev->irq,
+						NULL,
+						&ad7816_event_handler,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						indio_dev->name,
+						indio_dev);
 		if (ret)
-			goto error_free_gpio;
+			return ret;
 	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_irq;
+		return ret;
 
 	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
 			 indio_dev->name);
 
 	return 0;
-error_free_irq:
-	free_irq(spi_dev->irq, indio_dev);
-error_free_gpio:
-	gpio_free(chip->busy_pin);
-error_free_gpio_convert:
-	gpio_free(chip->convert_pin);
-error_free_gpio_rdwr:
-	gpio_free(chip->rdwr_pin);
-error_free_device:
-	iio_device_free(indio_dev);
-error_ret:
-	return ret;
 }
 
 static int ad7816_remove(struct spi_device *spi_dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
-	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	dev_set_drvdata(&spi_dev->dev, NULL);
-	if (spi_dev->irq)
-		free_irq(spi_dev->irq, indio_dev);
-	gpio_free(chip->busy_pin);
-	gpio_free(chip->convert_pin);
-	gpio_free(chip->rdwr_pin);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

