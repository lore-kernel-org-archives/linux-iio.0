Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41324 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab3HXSsi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Aug 2013 14:48:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1908529pbb.33
        for <linux-iio@vger.kernel.org>; Sat, 24 Aug 2013 11:48:38 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, jic23@kernel.org, sachin.kamat@linaro.org,
	lars@metafoo.de
Subject: [PATCH 5/8] staging: iio: adis16220: Use devm_iio_device_alloc
Date: Sun, 25 Aug 2013 00:18:09 +0530
Message-Id: <1377370092-2436-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
References: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/accel/adis16220_core.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 0e72f79..5c28961 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -428,11 +428,9 @@ static int adis16220_probe(struct spi_device *spi)
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
@@ -447,7 +445,7 @@ static int adis16220_probe(struct spi_device *spi)
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	ret = sysfs_create_bin_file(&indio_dev->dev.kobj, &accel_bin);
 	if (ret)
@@ -478,9 +476,6 @@ error_rm_accel_bin:
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
 error_unregister_dev:
 	iio_device_unregister(indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
 	return ret;
 }
 
@@ -492,7 +487,6 @@ static int adis16220_remove(struct spi_device *spi)
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
 	iio_device_unregister(indio_dev);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

