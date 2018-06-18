Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39137 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935955AbeFRXjA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2018 19:39:00 -0400
From: Karim Eshapa <karim.eshapa@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:adc:ad7816: Backward resources cleanups in probe
Date: Tue, 19 Jun 2018 01:38:51 +0200
Message-Id: <20180618233851.7992-1-karim.eshapa@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Backward cleanups for all resources allocated in probing
in case of failure at any regestering or allocation step.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index bf76a8620bdb..5ff14c830451 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -373,7 +373,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request rdwr gpio PIN %d.\n",
 			chip->rdwr_pin);
-		return ret;
+		goto device_free;
 	}
 	gpio_direction_input(chip->rdwr_pin);
 	ret = devm_gpio_request(&spi_dev->dev, chip->convert_pin,
@@ -381,7 +381,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request convert gpio PIN %d.\n",
 			chip->convert_pin);
-		return ret;
+		goto free_rdwr_pin;
 	}
 	gpio_direction_input(chip->convert_pin);
 	ret = devm_gpio_request(&spi_dev->dev, chip->busy_pin,
@@ -389,7 +389,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	if (ret) {
 		dev_err(&spi_dev->dev, "Fail to request busy gpio PIN %d.\n",
 			chip->busy_pin);
-		return ret;
+		goto free_convert_pin;
 	}
 	gpio_direction_input(chip->busy_pin);
 
@@ -407,17 +407,29 @@ static int ad7816_probe(struct spi_device *spi_dev)
 						indio_dev->name,
 						indio_dev);
 		if (ret)
-			return ret;
+			goto free_busy_pin;
 	}
 
 	ret = devm_iio_device_register(&spi_dev->dev, indio_dev);
 	if (ret)
-		return ret;
+		goto free_dev_irq;
 
 	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
 		 indio_dev->name);
 
 	return 0;
+free_dev_irq:
+	devm_free_irq(&spi_dev->dev, spi_dev->irq, indio_dev);
+free_busy_pin:
+	devm_gpio_free(&spi_dev->dev, chip->busy_pin);
+free_convert_pin:
+	devm_gpio_free(&spi_dev->dev, chip->convert_pin);
+free_rdwr_pin:
+	devm_gpio_free(&spi_dev->dev, chip->rdwr_pin);
+device_free:
+	devm_iio_device_free(&spi_dev->dev, indio_dev);
+
+	return ret;
 }
 
 static const struct spi_device_id ad7816_id[] = {
-- 
2.17.1

