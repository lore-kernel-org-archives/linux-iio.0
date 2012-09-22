Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1072 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab2IVI4B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2012 04:56:01 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] staging:iio:lis3l02dq: Do not return a error in remove function
Date: Sat, 22 Sep 2012 10:56:37 +0200
Message-Id: <1348304198-5793-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1348304198-5793-1-git-send-email-lars@metafoo.de>
References: <1348304198-5793-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In the Linux device driver model the remove callback is not allowed to fail and
the device will be removed regardless of the return value of the remove
callback. So if we abort in the remove function and do not free all resources we
will create a resource leak. Also all kinds of undefined behaviour are expected
to happen since the IIO device is still there while its parent is already gone.

The errors which the driver tries to handle in the remove function are
non-critical, so we can just ignore them and continue to free all resources and
remove the IIO device.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index d900d63..21b0469 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -782,19 +782,13 @@ err_ret:
 /* fixme, confirm ordering in this function */
 static int __devexit lis3l02dq_remove(struct spi_device *spi)
 {
-	int ret;
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
-	ret = lis3l02dq_disable_all_events(indio_dev);
-	if (ret)
-		goto err_ret;
-
-	ret = lis3l02dq_stop_device(indio_dev);
-	if (ret)
-		goto err_ret;
+	lis3l02dq_disable_all_events(indio_dev);
+	lis3l02dq_stop_device(indio_dev);
 
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
 		free_irq(st->us->irq, indio_dev);
@@ -804,8 +798,8 @@ static int __devexit lis3l02dq_remove(struct spi_device *spi)
 	lis3l02dq_unconfigure_buffer(indio_dev);
 
 	iio_device_free(indio_dev);
-err_ret:
-	return ret;
+
+	return 0;
 }
 
 static struct spi_driver lis3l02dq_driver = {
-- 
1.7.10.4

