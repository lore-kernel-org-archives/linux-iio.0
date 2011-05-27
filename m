Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 36/50] staging:iio:gyro:adis16130: allocate chip state with iio_dev and use iio_priv to access it.
Date: Fri, 27 May 2011 19:36:16 +0100
Message-Id: <1306521390-24897-37-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16130_core.c |   50 +++++++++++-----------------
 1 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 14d5a34..c80e908 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -41,14 +41,12 @@
 /**
  * struct adis16130_state - device instance specific data
  * @us:			actual spi_device to write data
- * @indio_dev:		industrial I/O device structure
  * @mode:		24 bits (1) or 16 bits (0)
  * @buf_lock:		mutex to protect tx and rx
  * @buf:		unified tx/rx buffer
  **/
 struct adis16130_state {
 	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
 	u32                             mode;
 	struct mutex			buf_lock;
 	u8				buf[4] ____cacheline_aligned;
@@ -59,7 +57,7 @@ static int adis16130_spi_write(struct device *dev, u8 reg_addr,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16130_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16130_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->buf[0] = reg_addr;
@@ -76,7 +74,7 @@ static int adis16130_spi_read(struct device *dev, u8 reg_addr,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16130_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16130_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 
@@ -125,7 +123,7 @@ static ssize_t adis16130_bitsmode_read(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16130_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16130_state *st = iio_priv(indio_dev);
 
 	if (st->mode == 1)
 		return sprintf(buf, "s24\n");
@@ -183,39 +181,35 @@ static const struct iio_info adis16130_info = {
 static int __devinit adis16130_probe(struct spi_device *spi)
 {
 	int ret;
-	struct adis16130_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
+	struct adis16130_state *st;
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
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-
-	st->indio_dev->name = spi->dev.driver->name;
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->info = &adis16130_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16130_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 	st->mode = 1;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
 	return 0;
 
 error_free_dev:
-	iio_free_device(st->indio_dev);
-error_free_st:
-	kfree(st);
+	iio_free_device(indio_dev);
+
 error_ret:
 	return ret;
 }
@@ -223,11 +217,7 @@ error_ret:
 /* fixme, confirm ordering in this function */
 static int adis16130_remove(struct spi_device *spi)
 {
-	struct adis16130_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
-
-	iio_device_unregister(indio_dev);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.3.4
