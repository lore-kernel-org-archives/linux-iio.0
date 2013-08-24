Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:52310 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353Ab3HXSsc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Aug 2013 14:48:32 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so1903447pab.15
        for <linux-iio@vger.kernel.org>; Sat, 24 Aug 2013 11:48:31 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, jic23@kernel.org, sachin.kamat@linaro.org,
	lars@metafoo.de
Subject: [PATCH 3/8] staging: iio: adis16204: Use devm_iio_device_alloc
Date: Sun, 25 Aug 2013 00:18:07 +0530
Message-Id: <1377370092-2436-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
References: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/accel/adis16204_core.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
index 792ec25..b8ea768 100644
--- a/drivers/staging/iio/accel/adis16204_core.c
+++ b/drivers/staging/iio/accel/adis16204_core.c
@@ -187,11 +187,9 @@ static int adis16204_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 
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
@@ -205,11 +203,11 @@ static int adis16204_probe(struct spi_device *spi)
 
 	ret = adis_init(st, indio_dev, spi, &adis16204_data);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	/* Get the device into a sane initial state */
 	ret = adis_initial_startup(st);
@@ -223,9 +221,6 @@ static int adis16204_probe(struct spi_device *spi)
 
 error_cleanup_buffer_trigger:
 	adis_cleanup_buffer_and_trigger(st, indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
 	return ret;
 }
 
@@ -236,7 +231,6 @@ static int adis16204_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	adis_cleanup_buffer_and_trigger(st, indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

