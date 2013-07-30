Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:35593 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758262Ab3G3JA7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2013 05:00:59 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so5781014pbc.1
        for <linux-iio@vger.kernel.org>; Tue, 30 Jul 2013 02:00:58 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, jic23@kernel.org, sachin.kamat@linaro.org,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 1/6] iio: imu: adis16400: Use devm_iio_device_alloc
Date: Tue, 30 Jul 2013 14:14:23 +0530
Message-Id: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
This series compile tested on togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
---
 drivers/iio/imu/adis16400_core.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index f60591f..3fb7757 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -871,7 +871,7 @@ static int adis16400_probe(struct spi_device *spi)
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = iio_device_alloc(sizeof(*st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -893,12 +893,12 @@ static int adis16400_probe(struct spi_device *spi)
 
 	ret = adis_init(&st->adis, indio_dev, spi, &adis16400_data);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev,
 			adis16400_trigger_handler);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	/* Get the device into a sane initial state */
 	ret = adis16400_initial_setup(indio_dev);
@@ -913,8 +913,6 @@ static int adis16400_probe(struct spi_device *spi)
 
 error_cleanup_buffer:
 	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
 	return ret;
 }
 
@@ -928,8 +926,6 @@ static int adis16400_remove(struct spi_device *spi)
 
 	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
 
-	iio_device_free(indio_dev);
-
 	return 0;
 }
 
-- 
1.7.9.5

