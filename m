Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1076 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab2IVIz4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2012 04:55:56 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] staging:iio:adis16400: Do not return a error in remove function
Date: Sat, 22 Sep 2012 10:56:32 +0200
Message-Id: <1348304198-5793-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1348304198-5793-1-git-send-email-lars@metafoo.de>
References: <1348304198-5793-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In the Linux device driver model the remove callback is not allowed to fail and
the device will be removed regardless of the return value of the remove
callback. So if we abort in the remove function and do not free all resources we
will create a resource leak. Also all kinds of undefined behaviour are expected
to happen since the IIO device is still there while its parent is already gone.

The error which the driver tries to handle in the remove function is
non-critical, so we can just ignore it and continue to free all resources and
remove the IIO device.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/imu/adis16400_core.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index b8c280c..b302c9b 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1208,13 +1208,10 @@ error_ret:
 /* fixme, confirm ordering in this function */
 static int __devexit adis16400_remove(struct spi_device *spi)
 {
-	int ret;
 	struct iio_dev *indio_dev =  spi_get_drvdata(spi);
 
 	iio_device_unregister(indio_dev);
-	ret = adis16400_stop_device(indio_dev);
-	if (ret)
-		goto err_ret;
+	adis16400_stop_device(indio_dev);
 
 	adis16400_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
@@ -1222,9 +1219,6 @@ static int __devexit adis16400_remove(struct spi_device *spi)
 	iio_device_free(indio_dev);
 
 	return 0;
-
-err_ret:
-	return ret;
 }
 
 static const struct spi_device_id adis16400_id[] = {
-- 
1.7.10.4

