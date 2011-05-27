Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 38/50] staging:iio:gyro:adxrs450: allocate chip state with iio_dev
Date: Fri, 27 May 2011 19:36:18 +0100
Message-Id: <1306521390-24897-39-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adxrs450.h      |   13 +++---
 drivers/staging/iio/gyro/adxrs450_core.c |   71 ++++++++++--------------------
 2 files changed, 30 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450.h b/drivers/staging/iio/gyro/adxrs450.h
index c92f694..b6b6828 100644
--- a/drivers/staging/iio/gyro/adxrs450.h
+++ b/drivers/staging/iio/gyro/adxrs450.h
@@ -42,17 +42,16 @@
 /**
  * struct adxrs450_state - device instance specific data
  * @us:			actual spi_device
- * @indio_dev:		industrial I/O device structure
+ * @buf_lock:		mutex to protect tx and rx
  * @tx:			transmit buffer
  * @rx:			recieve buffer
- * @buf_lock:		mutex to protect tx and rx
  **/
 struct adxrs450_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
+	struct spi_device	*us;
+	struct mutex		buf_lock;
+	u8			tx[ADXRS450_MAX_RX] ____cacheline_aligned;
+	u8			rx[ADXRS450_MAX_TX];
+
 };
 
 #endif /* SPI_ADXRS450_H_ */
diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 3714e4a..7502a26 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -38,7 +38,7 @@ static int adxrs450_spi_read_reg_16(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adxrs450_state *st = iio_dev_get_devdata(indio_dev);
+	struct adxrs450_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -92,7 +92,7 @@ static int adxrs450_spi_write_reg_16(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adxrs450_state *st = iio_dev_get_devdata(indio_dev);
+	struct adxrs450_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers = {
 		.tx_buf = st->tx,
@@ -130,7 +130,7 @@ static int adxrs450_spi_sensor_data(struct device *dev, s16 *val)
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adxrs450_state *st = iio_dev_get_devdata(indio_dev);
+	struct adxrs450_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -267,12 +267,13 @@ static ssize_t adxrs450_read_sensor_data(struct device *dev,
 }
 
 /* Recommended Startup Sequence by spec */
-static int adxrs450_initial_setup(struct adxrs450_state *st)
+static int adxrs450_initial_setup(struct iio_dev *indio_dev)
 {
 	u32 t;
 	u16 data;
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
+	struct device *dev = &indio_dev->dev;
+	struct adxrs450_state *st = iio_priv(indio_dev);
 
 	msleep(ADXRS450_STARTUP_DELAY*2);
 	ret = adxrs450_spi_initial(st, &t, 1);
@@ -357,46 +358,32 @@ static const struct iio_info adxrs450_info = {
 static int __devinit adxrs450_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct adxrs450_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
-		goto error_ret;
-	}
-	/* This is only used for removal purposes */
-	spi_set_drvdata(spi, st);
+	struct adxrs450_state *st;
+	struct iio_dev *indio_dev;
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADXRS450_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADXRS450_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
+	/* setup the industrialio driver allocated elements */
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
-		goto error_free_rx;
+		goto error_ret;
 	}
+	st = iio_priv(indio_dev);
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
+	/* This is only used for removal purposes */
+	spi_set_drvdata(spi, indio_dev);
 
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->info = &adxrs450_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &adxrs450_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 	regdone = 1;
 
 	/* Get the device into a sane initial state */
-	ret = adxrs450_initial_setup(st);
+	ret = adxrs450_initial_setup(indio_dev);
 	if (ret)
 		goto error_initial;
 	return 0;
@@ -404,27 +391,17 @@ static int __devinit adxrs450_probe(struct spi_device *spi)
 error_initial:
 error_free_dev:
 	if (regdone)
-		iio_device_unregister(st->indio_dev);
+		iio_device_unregister(indio_dev);
 	else
-		iio_free_device(st->indio_dev);
-error_free_tx:
-	kfree(st->tx);
-error_free_rx:
-	kfree(st->rx);
-error_free_st:
-	kfree(st);
+		iio_free_device(indio_dev);
+
 error_ret:
 	return ret;
 }
 
 static int adxrs450_remove(struct spi_device *spi)
 {
-	struct adxrs450_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.3.4
