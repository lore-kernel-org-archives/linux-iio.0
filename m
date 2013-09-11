Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:59421 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab3IKKNn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Sep 2013 06:13:43 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so8850847pbc.26
        for <linux-iio@vger.kernel.org>; Wed, 11 Sep 2013 03:13:43 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org,
	Graff Yang <graff.yang@gmail.com>
Subject: [PATCH 02/10] staging: iio: ad2s1200: Use devm_* APIs
Date: Wed, 11 Sep 2013 15:25:17 +0530
Message-Id: <1378893325-31764-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org>
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_* APIs are device managed and make code simpler.
This patch also fixes the missing gpio_free call in remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Graff Yang <graff.yang@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 7122116..76f6d65 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -107,16 +107,16 @@ static int ad2s1200_probe(struct spi_device *spi)
 	unsigned short *pins = spi->dev.platform_data;
 
 	for (pn = 0; pn < AD2S1200_PN; pn++)
-		if (gpio_request_one(pins[pn], GPIOF_DIR_OUT, DRV_NAME)) {
+		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
+					    DRV_NAME);
+		if (ret) {
 			pr_err("%s: request gpio pin %d failed\n",
 						DRV_NAME, pins[pn]);
-			goto error_ret;
+			return ret;
 		}
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
@@ -133,26 +133,18 @@ static int ad2s1200_probe(struct spi_device *spi)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	spi->max_speed_hz = AD2S1200_HZ;
 	spi->mode = SPI_MODE_3;
 	spi_setup(spi);
 
 	return 0;
-
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
-	for (--pn; pn >= 0; pn--)
-		gpio_free(pins[pn]);
-	return ret;
 }
 
 static int ad2s1200_remove(struct spi_device *spi)
 {
 	iio_device_unregister(spi_get_drvdata(spi));
-	iio_device_free(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.9.5

