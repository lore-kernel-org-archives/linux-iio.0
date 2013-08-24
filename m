Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:64125 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab3HXSs3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Aug 2013 14:48:29 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so1890128pbb.38
        for <linux-iio@vger.kernel.org>; Sat, 24 Aug 2013 11:48:28 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, jic23@kernel.org, sachin.kamat@linaro.org,
	lars@metafoo.de
Subject: [PATCH 2/8] staging: iio: adis16203: Use devm_iio_device_alloc
Date: Sun, 25 Aug 2013 00:18:06 +0530
Message-Id: <1377370092-2436-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
References: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/accel/adis16203_core.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index b08ac8f..409a28e 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -148,11 +148,9 @@ static int adis16203_probe(struct spi_device *spi)
 	struct adis *st;
 
 	/* setup the industrialio driver allocated elements */
-	indio_dev = iio_device_alloc(sizeof(*st));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 	st = iio_priv(indio_dev);
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
@@ -166,11 +164,11 @@ static int adis16203_probe(struct spi_device *spi)
 
 	ret = adis_init(st, indio_dev, spi, &adis16203_data);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	/* Get the device into a sane initial state */
 	ret = adis_initial_startup(st);
@@ -185,9 +183,6 @@ static int adis16203_probe(struct spi_device *spi)
 
 error_cleanup_buffer_trigger:
 	adis_cleanup_buffer_and_trigger(st, indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
 	return ret;
 }
 
@@ -198,7 +193,6 @@ static int adis16203_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	adis_cleanup_buffer_and_trigger(st, indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

