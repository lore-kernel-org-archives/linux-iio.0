Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/5] staging:iio: use spi->irq valid rather than querying available modes
Date: Sat,  3 Mar 2012 11:39:13 +0000
Message-Id: <1330774755-18031-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1330774755-18031-1-git-send-email-jic23@kernel.org>
References: <1330774755-18031-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

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
1.7.9.2
