Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:42448 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3HXSss (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Aug 2013 14:48:48 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so1915106pde.37
        for <linux-iio@vger.kernel.org>; Sat, 24 Aug 2013 11:48:48 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, jic23@kernel.org, sachin.kamat@linaro.org,
	lars@metafoo.de
Subject: [PATCH 8/8] staging: iio: sca3000: Use devm_iio_device_alloc
Date: Sun, 25 Aug 2013 00:18:12 +0530
Message-Id: <1377370092-2436-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
References: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/accel/sca3000_core.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 32950ad..48a25ba 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1135,11 +1135,9 @@ static int sca3000_probe(struct spi_device *spi)
 	struct sca3000_state *st;
 	struct iio_dev *indio_dev;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
@@ -1162,7 +1160,7 @@ static int sca3000_probe(struct spi_device *spi)
 	sca3000_configure_ring(indio_dev);
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto error_free_dev;
+		return ret;
 
 	ret = iio_buffer_register(indio_dev,
 				  sca3000_channels,
@@ -1198,10 +1196,6 @@ error_unregister_ring:
 	iio_buffer_unregister(indio_dev);
 error_unregister_dev:
 	iio_device_unregister(indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
-
-error_ret:
 	return ret;
 }
 
@@ -1235,7 +1229,6 @@ static int sca3000_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	sca3000_unconfigure_ring(indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

