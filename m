Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/54] staging:iio:accel:kxsd9: allocate state with iio_dev and use iio_priv to access.
Date: Mon, 27 Jun 2011 11:04:22 +0100
Message-Id: <1309169104-22139-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/kxsd9.c |   64 ++++++++++---------------------------
 1 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index 973156e..c0b2b23 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -56,17 +56,15 @@
 /**
  * struct kxsd9_state - device related storage
  * @buf_lock:	protect the rx and tx buffers.
- * @indio_dev:	associated industrial IO device
  * @us:		spi device
  * @rx:		single rx buffer storage
  * @tx:		single tx buffer storage
  **/
 struct kxsd9_state {
 	struct mutex buf_lock;
-	struct iio_dev *indio_dev;
 	struct spi_device *us;
-	u8 *rx;
-	u8 *tx;
+	u8 rx[KXSD9_STATE_RX_SIZE] ____cacheline_aligned;
+	u8 tx[KXSD9_STATE_TX_SIZE];
 };
 
 /* This may want to move to mili g to allow for non integer ranges */
@@ -77,7 +75,7 @@ static ssize_t kxsd9_read_scale(struct device *dev,
 	int ret;
 	ssize_t len = 0;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct kxsd9_state *st = indio_dev->dev_data;
+	struct kxsd9_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfer = {
 		.bits_per_word = 8,
 		.len = 2,
@@ -125,7 +123,7 @@ static ssize_t kxsd9_write_scale(struct device *dev,
 	struct spi_message msg;
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct kxsd9_state *st = indio_dev->dev_data;
+	struct kxsd9_state *st = iio_priv(indio_dev);
 	u8 val;
 	struct spi_transfer xfers[] = {
 		{
@@ -190,7 +188,7 @@ static ssize_t kxsd9_read_accel(struct device *dev,
 	u16 val;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct kxsd9_state *st = indio_dev->dev_data;
+	struct kxsd9_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.bits_per_word = 8,
@@ -308,43 +306,26 @@ static const struct iio_info kxsd9_info = {
 
 static int __devinit kxsd9_probe(struct spi_device *spi)
 {
-
+	struct iio_dev *indio_dev;
 	struct kxsd9_state *st;
 	int ret = 0;
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
+	indio_dev = iio_allocate_device(0);
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	spi_set_drvdata(spi, st);
-
-	st->rx = kmalloc(sizeof(*st->rx)*KXSD9_STATE_RX_SIZE,
-			 GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kmalloc(sizeof(*st->tx)*KXSD9_STATE_TX_SIZE,
-			 GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_rx;
-	}
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
 
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->info = &kxsd9_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->indio_dev);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &kxsd9_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -355,25 +336,14 @@ static int __devinit kxsd9_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(st->indio_dev);
-error_free_tx:
-	kfree(st->tx);
-error_free_rx:
-	kfree(st->rx);
-error_free_st:
-	kfree(st);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
 
 static int __devexit kxsd9_remove(struct spi_device *spi)
 {
-	struct kxsd9_state *st = spi_get_drvdata(spi);
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
