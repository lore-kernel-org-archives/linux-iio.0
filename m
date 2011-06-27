Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 33/54] staging:iio:dds:ad9850 allocate chip state with iio_dev + fix name of attr group.
Date: Mon, 27 Jun 2011 11:04:43 +0100
Message-Id: <1309169104-22139-34-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dds/ad9850.c |   37 ++++++++++++-------------------------
 1 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/dds/ad9850.c b/drivers/staging/iio/dds/ad9850.c
index b580d85..d7c9d05 100644
--- a/drivers/staging/iio/dds/ad9850.c
+++ b/drivers/staging/iio/dds/ad9850.c
@@ -30,7 +30,6 @@ struct ad9850_config {
 
 struct ad9850_state {
 	struct mutex lock;
-	struct iio_dev *idev;
 	struct spi_device *sdev;
 };
 
@@ -44,7 +43,7 @@ static ssize_t ad9850_set_parameter(struct device *dev,
 	int ret;
 	struct ad9850_config *config = (struct ad9850_config *)buf;
 	struct iio_dev *idev = dev_get_drvdata(dev);
-	struct ad9850_state *st = idev->dev_data;
+	struct ad9850_state *st = iio_priv(idev);
 
 	xfer.len = len;
 	xfer.tx_buf = config;
@@ -69,7 +68,6 @@ static struct attribute *ad9850_attributes[] = {
 };
 
 static const struct attribute_group ad9850_attribute_group = {
-	.name = DRV_NAME,
 	.attrs = ad9850_attributes,
 };
 
@@ -81,30 +79,24 @@ static const struct iio_info ad9850_info = {
 static int __devinit ad9850_probe(struct spi_device *spi)
 {
 	struct ad9850_state *st;
+	struct iio_dev *idev;
 	int ret = 0;
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
+	idev = iio_allocate_device(sizeof(*st));
+	if (idev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	spi_set_drvdata(spi, st);
-
+	spi_set_drvdata(spi, idev);
+	st = iio_priv(idev);
 	mutex_init(&st->lock);
 	st->sdev = spi;
 
-	st->idev = iio_allocate_device(0);
-	if (st->idev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->idev->dev.parent = &spi->dev;
-
-	st->idev->info = &ad9850_info;
-	st->idev->dev_data = (void *)(st);
-	st->idev->modes = INDIO_DIRECT_MODE;
+	idev->dev.parent = &spi->dev;
+	idev->info = &ad9850_info;
+	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->idev);
+	ret = iio_device_register(idev);
 	if (ret)
 		goto error_free_dev;
 	spi->max_speed_hz = 2000000;
@@ -115,19 +107,14 @@ static int __devinit ad9850_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(st->idev);
-error_free_st:
-	kfree(st);
+	iio_free_device(idev);
 error_ret:
 	return ret;
 }
 
 static int __devexit ad9850_remove(struct spi_device *spi)
 {
-	struct ad9850_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->idev);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.3.4
