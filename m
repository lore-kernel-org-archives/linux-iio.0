Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 34/50] staging:iio:gyro:adis16060 allocate chip state with iio_dev.
Date: Fri, 27 May 2011 19:36:14 +0100
Message-Id: <1306521390-24897-35-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is still a very odd driver.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16060_core.c |   59 ++++++++++++----------------
 1 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index edf9e3b..afa52d1 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -29,27 +29,25 @@
  * struct adis16060_state - device instance specific data
  * @us_w:		actual spi_device to write config
  * @us_r:		actual spi_device to read back data
- * @indio_dev:		industrial I/O device structure
  * @buf:		transmit or receive buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct adis16060_state {
 	struct spi_device		*us_w;
 	struct spi_device		*us_r;
-	struct iio_dev			*indio_dev;
 	struct mutex			buf_lock;
 
 	u8 buf[3] ____cacheline_aligned;
 };
 
-static struct adis16060_state *adis16060_st;
+static struct iio_dev *adis16060_iio_dev;
 
 static int adis16060_spi_write(struct device *dev,
 		u8 val)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16060_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16060_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->buf[2] = val; /* The last 8 bits clocked in are latched */
@@ -64,7 +62,7 @@ static int adis16060_spi_read(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16060_state *st = iio_dev_get_devdata(indio_dev);
+	struct adis16060_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 
@@ -141,43 +139,38 @@ static const struct iio_info adis16060_info = {
 static int __devinit adis16060_r_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct adis16060_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
+	struct adis16060_state *st;
+	struct iio_dev *indio_dev;
+
+	/* setup the industrialio driver allocated elements */
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
 		goto error_ret;
 	}
 	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
-
+	spi_set_drvdata(spi, indio_dev);
+	st = iio_priv(indio_dev);
 	st->us_r = spi;
 	mutex_init(&st->buf_lock);
-	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
 
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->info = &adis16060_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adis16060_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 	regdone = 1;
 
-	adis16060_st = st;
+	adis16060_iio_dev = indio_dev;
 	return 0;
 
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
@@ -185,11 +178,7 @@ error_ret:
 /* fixme, confirm ordering in this function */
 static int adis16060_r_remove(struct spi_device *spi)
 {
-	struct adis16060_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
-
-	iio_device_unregister(indio_dev);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
@@ -197,12 +186,14 @@ static int adis16060_r_remove(struct spi_device *spi)
 static int __devinit adis16060_w_probe(struct spi_device *spi)
 {
 	int ret;
-	struct adis16060_state *st = adis16060_st;
-	if (!st) {
+	struct iio_dev *indio_dev = adis16060_iio_dev;
+	struct adis16060_state *st;
+	if (!indio_dev) {
 		ret =  -ENODEV;
 		goto error_ret;
 	}
-	spi_set_drvdata(spi, st);
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
 	st->us_w = spi;
 	return 0;
 
-- 
1.7.3.4
