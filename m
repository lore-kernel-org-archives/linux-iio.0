Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36289 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab2DJULS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:11:18 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6/6] staging:iio: use spi->irq valid rather than querying available modes
Date: Tue, 10 Apr 2012 21:11:09 +0100
Message-Id: <1334088669-21032-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1334088669-21032-1-git-send-email-jic23@kernel.org>
References: <1334088669-21032-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Given these drivers only try to add the trigger if a valid
irq is present it is clearer to check the same condition when
deciding whether to remove it on a later trigger.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/imu/adis16400_core.c |    2 +-
 drivers/staging/iio/meter/ade7758_core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index e73ad78..a027d6d 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -1172,7 +1172,7 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
+	if (spi->irq)
 		adis16400_remove_trigger(indio_dev);
 error_uninitialize_ring:
 	iio_buffer_unregister(indio_dev);
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index dcb2029..9374d6b 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -800,7 +800,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	return 0;
 
 error_remove_trigger:
-	if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
+	if (spi->irq)
 		ade7758_remove_trigger(indio_dev);
 error_uninitialize_ring:
 	ade7758_uninitialize_ring(indio_dev);
-- 
1.7.9.4

