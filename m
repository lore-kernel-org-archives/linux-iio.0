Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 39/50] staging:iio:meter:ade7753 allocate chip state with iio_dev; allocate buffers within state
Date: Fri, 27 May 2011 19:36:19 +0100
Message-Id: <1306521390-24897-40-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7753.c |   79 ++++++++++++----------------------
 drivers/staging/iio/meter/ade7753.h |   10 ++---
 2 files changed, 32 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 6c9c23f..59f47fd 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -29,7 +29,7 @@ static int ade7753_spi_write_reg_8(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7753_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7753_WRITE_REG(reg_address);
@@ -47,7 +47,7 @@ static int ade7753_spi_write_reg_16(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7753_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADE7753_WRITE_REG(reg_address);
@@ -64,7 +64,7 @@ static int ade7753_spi_read_reg_8(struct device *dev,
 		u8 *val)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7753_state *st = iio_priv(indio_dev);
 	ssize_t ret;
 
 	ret = spi_w8r8(st->us, ADE7753_READ_REG(reg_address));
@@ -83,7 +83,7 @@ static int ade7753_spi_read_reg_16(struct device *dev,
 		u16 *val)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7753_state *st = iio_priv(indio_dev);
 	ssize_t ret;
 
 	ret = spi_w8r16(st->us, ADE7753_READ_REG(reg_address));
@@ -105,7 +105,7 @@ static int ade7753_spi_read_reg_24(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7753_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -369,10 +369,11 @@ static int ade7753_stop_device(struct device *dev)
 	return ade7753_spi_write_reg_16(dev, ADE7753_MODE, val);
 }
 
-static int ade7753_initial_setup(struct ade7753_state *st)
+static int ade7753_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
+	struct device *dev = &indio_dev->dev;
+	struct ade7753_state *st = iio_priv(indio_dev);
 
 	/* use low spi speed for init */
 	st->us->mode = SPI_MODE_3;
@@ -416,7 +417,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7753_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7753_state *st = iio_priv(indio_dev);
 	unsigned long val;
 	int ret;
 	u16 reg, t;
@@ -512,62 +513,44 @@ static const struct iio_info ade7753_info = {
 static int __devinit ade7753_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
-	struct ade7753_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
+	struct ade7753_state *st;
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
+	spi_set_drvdata(spi, indio_dev);
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADE7753_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADE7753_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_rx;
-	}
+	st = iio_priv(indio_dev);
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
 
-	st->indio_dev->name = spi->dev.driver->name;
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->info = &ade7753_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = spi->dev.driver->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &ade7753_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 	regdone = 1;
 
 	/* Get the device into a sane initial state */
-	ret = ade7753_initial_setup(st);
+	ret = ade7753_initial_setup(indio_dev);
 	if (ret)
 		goto error_free_dev;
 	return 0;
 
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
@@ -576,19 +559,13 @@ error_ret:
 static int ade7753_remove(struct spi_device *spi)
 {
 	int ret;
-	struct ade7753_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	ret = ade7753_stop_device(&(indio_dev->dev));
 	if (ret)
 		goto err_ret;
 
 	iio_device_unregister(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
-
-	return 0;
 
 err_ret:
 	return ret;
diff --git a/drivers/staging/iio/meter/ade7753.h b/drivers/staging/iio/meter/ade7753.h
index 3b9c7f6..3f059d3 100644
--- a/drivers/staging/iio/meter/ade7753.h
+++ b/drivers/staging/iio/meter/ade7753.h
@@ -60,17 +60,15 @@
 /**
  * struct ade7753_state - device instance specific data
  * @us:			actual spi_device
- * @indio_dev:		industrial I/O device structure
  * @tx:			transmit buffer
  * @rx:			receive buffer
  * @buf_lock:		mutex to protect tx and rx
  **/
 struct ade7753_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
+	struct spi_device	*us;
+	struct mutex		buf_lock;
+	u8			tx[ADE7753_MAX_TX] ____cacheline_aligned;
+	u8			rx[ADE7753_MAX_RX];
 };
 
 #endif
-- 
1.7.3.4
