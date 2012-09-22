Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1069 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab2IVI4D (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2012 04:56:03 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] staging:iio:sca3000: Do not return a error in remove function
Date: Sat, 22 Sep 2012 10:56:38 +0200
Message-Id: <1348304198-5793-8-git-send-email-lars@metafoo.de>
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
 drivers/staging/iio/accel/sca3000_core.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 6d72d97..ffd1697 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1237,11 +1237,9 @@ static int __devexit sca3000_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int ret;
+
 	/* Must ensure no interrupts can be generated after this!*/
-	ret = sca3000_stop_all_interrupts(st);
-	if (ret)
-		return ret;
+	sca3000_stop_all_interrupts(st);
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
 	iio_device_unregister(indio_dev);
-- 
1.7.10.4

