Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 38/54] staging:iio:gyro:adis16080: allocate chip state with iio_dev
Date: Mon, 27 Jun 2011 11:04:48 +0100
Message-Id: <1309169104-22139-39-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adis16080_core.c |   48 +++++++++++-----------------
 1 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index d42690b..ad2db4d 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -34,13 +34,11 @@
 /**
  * struct adis16080_state - device instance specific data
  * @us:			actual spi_device to write data
- * @indio_dev:		industrial I/O device structure
  * @buf:		transmit or receive buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16080_state {
 	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
 	struct mutex			buf_lock;
 
 	u8 buf[2] ____cacheline_aligned;
@@ -51,7 +49,7 @@ static int adis16080_spi_write(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16080_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16080_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->buf[0] = val >> 8;
@@ -68,7 +66,7 @@ static int adis16080_spi_read(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16080_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16080_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 
@@ -131,31 +129,29 @@ static const struct iio_info adis16080_info = {
 static int __devinit adis16080_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct adis16080_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
+	struct adis16080_state *st;
+	struct iio_dev *indio_dev;
+
+	/* setup the industrialio driver allocated elements */
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
 		goto error_ret;
 	}
+	st = iio_priv(indio_dev);
 	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
+	spi_set_drvdata(spi, indio_dev);
 
 	/* Allocate the comms buffers */
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
 
-	st->indio_dev->name = spi->dev.driver->name;
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->info = &adis16080_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16080_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 	regdone = 1;
@@ -164,11 +160,9 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 
 error_free_dev:
 	if (regdone)
-		iio_device_unregister(st->indio_dev);
+		iio_device_unregister(indio_dev);
 	else
-		iio_free_device(st->indio_dev);
-error_free_st:
-	kfree(st);
+		iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
@@ -176,11 +170,7 @@ error_ret:
 /* fixme, confirm ordering in this function */
 static int adis16080_remove(struct spi_device *spi)
 {
-	struct adis16080_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
-
-	iio_device_unregister(indio_dev);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.3.4
