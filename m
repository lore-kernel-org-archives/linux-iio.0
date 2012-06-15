Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Remove superfluous flush_scheduled_work
Date: Fri, 15 Jun 2012 18:14:36 +0200
Message-Id: <1339776877-26509-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

None of these drivers ever schedule any work, so there is no need to flush any
scheduled work when the driver is removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/adis16209_core.c |    2 --
 drivers/staging/iio/accel/adis16220_core.c |    2 --
 drivers/staging/iio/accel/adis16240_core.c |    2 --
 drivers/staging/iio/gyro/adis16260_core.c  |    2 --
 4 files changed, 8 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
index f6fd0d3..6fc426e 100644
--- a/drivers/staging/iio/accel/adis16209_core.c
+++ b/drivers/staging/iio/accel/adis16209_core.c
@@ -606,8 +606,6 @@ static int adis16209_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	flush_scheduled_work();
-
 	iio_device_unregister(indio_dev);
 	adis16209_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
index 6a9ac89..af5c576 100644
--- a/drivers/staging/iio/accel/adis16220_core.c
+++ b/drivers/staging/iio/accel/adis16220_core.c
@@ -694,8 +694,6 @@ static int adis16220_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	flush_scheduled_work();
-
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc2_bin);
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &adc1_bin);
 	sysfs_remove_bin_file(&indio_dev->dev.kobj, &accel_bin);
diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
index 8b15eae..2f59f83 100644
--- a/drivers/staging/iio/accel/adis16240_core.c
+++ b/drivers/staging/iio/accel/adis16240_core.c
@@ -641,8 +641,6 @@ static int adis16240_remove(struct spi_device *spi)
 
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
-	flush_scheduled_work();
-
 	iio_device_unregister(indio_dev);
 	adis16240_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index ec765f9..fdb84cc 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -728,8 +728,6 @@ static int adis16260_remove(struct spi_device *spi)
 	if (ret)
 		goto err_ret;
 
-	flush_scheduled_work();
-
 	adis16260_remove_trigger(indio_dev);
 	iio_buffer_unregister(indio_dev);
 	adis16260_unconfigure_ring(indio_dev);
-- 
1.7.10
