Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-051.synserver.de ([212.40.185.51]:1077 "EHLO
	smtp-out-051.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab3GQOoD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jul 2013 10:44:03 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/15] staging:iio:adis16260: Don't set default scan mask
Date: Wed, 17 Jul 2013 16:44:28 +0200
Message-Id: <1374072279-7140-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-1-git-send-email-lars@metafoo.de>
References: <1374072279-7140-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The recomentation for IIO driver is to leave all scan elements off by default
and let userspace decide which channels need to be enabled.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/adis16260_core.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 5cec675..e42a581 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -325,20 +325,6 @@ static int adis16260_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_dev;
 
-	if (indio_dev->buffer) {
-		/* Set default scan mode */
-		iio_scan_mask_set(indio_dev, indio_dev->buffer,
-				  ADIS16260_SCAN_SUPPLY);
-		iio_scan_mask_set(indio_dev, indio_dev->buffer,
-				  ADIS16260_SCAN_GYRO);
-		iio_scan_mask_set(indio_dev, indio_dev->buffer,
-				  ADIS16260_SCAN_AUX_ADC);
-		iio_scan_mask_set(indio_dev, indio_dev->buffer,
-				  ADIS16260_SCAN_TEMP);
-		iio_scan_mask_set(indio_dev, indio_dev->buffer,
-				  ADIS16260_SCAN_ANGL);
-	}
-
 	/* Get the device into a sane initial state */
 	ret = adis_initial_startup(adis);
 	if (ret)
-- 
1.8.0

