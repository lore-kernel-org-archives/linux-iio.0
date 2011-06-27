Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 47/54] staging:iio:resolver:ad2s90 general cleanup
Date: Mon, 27 Jun 2011 11:04:57 +0100
Message-Id: <1309169104-22139-48-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Very simple driver, so not much to do.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/resolver/ad2s90.c |   48 ++++++++------------------------
 1 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 9b72a95..166e241 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -24,29 +24,19 @@ struct ad2s90_state {
 	struct mutex lock;
 	struct iio_dev *idev;
 	struct spi_device *sdev;
-	u8 rx[2];
-	u8 tx[2];
+	u8 rx[2] ____cacheline_aligned;
 };
 
 static ssize_t ad2s90_show_angular(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct spi_message msg;
-	struct spi_transfer xfer;
 	int ret;
 	ssize_t len = 0;
 	u16 val;
-	struct iio_dev *idev = dev_get_drvdata(dev);
-	struct ad2s90_state *st = idev->dev_data;
+	struct ad2s90_state *st = iio_priv(dev_get_drvdata(dev));
 
-	xfer.len = 1;
-	xfer.tx_buf = st->tx;
-	xfer.rx_buf = st->rx;
 	mutex_lock(&st->lock);
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
+	ret = spi_read(st->sdev, st->rx, 2);
 	if (ret)
 		goto error_ret;
 	val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
@@ -60,12 +50,9 @@ error_ret:
 #define IIO_DEV_ATTR_SIMPLE_RESOLVER(_show) \
 	IIO_DEVICE_ATTR(angular, S_IRUGO, _show, NULL, 0)
 
-static IIO_CONST_ATTR(description,
-	"Low Cost, Complete 12-Bit Resolver-to-Digital Converter");
 static IIO_DEV_ATTR_SIMPLE_RESOLVER(ad2s90_show_angular);
 
 static struct attribute *ad2s90_attributes[] = {
-	&iio_const_attr_description.dev_attr.attr,
 	&iio_dev_attr_angular.dev_attr.attr,
 	NULL,
 };
@@ -82,29 +69,23 @@ static const struct iio_info ad2s90_info = {
 
 static int __devinit ad2s90_probe(struct spi_device *spi)
 {
+	struct iio_dev *indio_dev;
 	struct ad2s90_state *st;
 	int ret = 0;
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	spi_set_drvdata(spi, st);
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
-
-	st->idev = iio_allocate_device(0);
-	if (st->idev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->idev->dev.parent = &spi->dev;
-
-	st->idev->info = &ad2s90_info;
-	st->idev->dev_data = (void *)(st);
-	st->idev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &ad2s90_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = iio_device_register(st->idev);
 	if (ret)
@@ -119,18 +100,13 @@ static int __devinit ad2s90_probe(struct spi_device *spi)
 
 error_free_dev:
 	iio_free_device(st->idev);
-error_free_st:
-	kfree(st);
 error_ret:
 	return ret;
 }
 
 static int __devexit ad2s90_remove(struct spi_device *spi)
 {
-	struct ad2s90_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->idev);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.3.4
