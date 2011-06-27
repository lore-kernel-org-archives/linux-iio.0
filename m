Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 30/54] staging:iio:dds:ad5930 Fix attr group location + allocate state with iio_dev
Date: Mon, 27 Jun 2011 11:04:40 +0100
Message-Id: <1309169104-22139-31-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The main attribute group was placed under driver name for some reason.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dds/ad5930.c |   37 ++++++++++++-------------------------
 1 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/dds/ad5930.c b/drivers/staging/iio/dds/ad5930.c
index 490c363..0b2aa4c 100644
--- a/drivers/staging/iio/dds/ad5930.c
+++ b/drivers/staging/iio/dds/ad5930.c
@@ -35,7 +35,6 @@ struct ad5903_config {
 
 struct ad5930_state {
 	struct mutex lock;
-	struct iio_dev *idev;
 	struct spi_device *sdev;
 };
 
@@ -49,7 +48,7 @@ static ssize_t ad5930_set_parameter(struct device *dev,
 	int ret;
 	struct ad5903_config *config = (struct ad5903_config *)buf;
 	struct iio_dev *idev = dev_get_drvdata(dev);
-	struct ad5930_state *st = idev->dev_data;
+	struct ad5930_state *st = iio_priv(idev);
 
 	config->control = (config->control & ~value_mask);
 	config->incnum = (config->control & ~value_mask) | (1 << addr_shift);
@@ -83,42 +82,35 @@ static struct attribute *ad5930_attributes[] = {
 };
 
 static const struct attribute_group ad5930_attribute_group = {
-	.name = DRV_NAME,
 	.attrs = ad5930_attributes,
 };
 
 static const struct iio_info ad5930_info = {
 	.attrs = &ad5930_attribute_group,
-
 	.driver_module = THIS_MODULE,
 };
 
 static int __devinit ad5930_probe(struct spi_device *spi)
 {
 	struct ad5930_state *st;
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
+	spi_set_drvdata(spi, idev);
+	st = iio_priv(idev);
 
 	mutex_init(&st->lock);
 	st->sdev = spi;
+	idev->dev.parent = &spi->dev;
+	idev->info = &ad5930_info;
+	idev->modes = INDIO_DIRECT_MODE;
 
-	st->idev = iio_allocate_device(0);
-	if (st->idev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->idev->dev.parent = &spi->dev;
-	st->idev->dev_data = (void *)(st);
-	st->idev->info = &ad5930_info;
-	st->idev->modes = INDIO_DIRECT_MODE;
-
-	ret = iio_device_register(st->idev);
+	ret = iio_device_register(idev);
 	if (ret)
 		goto error_free_dev;
 	spi->max_speed_hz = 2000000;
@@ -129,19 +121,14 @@ static int __devinit ad5930_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(st->idev);
-error_free_st:
-	kfree(st);
+	iio_free_device(idev);
 error_ret:
 	return ret;
 }
 
 static int __devexit ad5930_remove(struct spi_device *spi)
 {
-	struct ad5930_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->idev);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.3.4
