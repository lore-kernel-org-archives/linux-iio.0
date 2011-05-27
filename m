Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 31/50] staging:iio:dds:ad9810: allocate chip state with iio_dev and use iio_priv for access.
Date: Fri, 27 May 2011 19:36:11 +0100
Message-Id: <1306521390-24897-32-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dds/ad9852.c |   38 ++++++++++++++------------------------
 1 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index 08020f9..0184585 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -58,7 +58,6 @@ struct ad9852_config {
 
 struct ad9852_state {
 	struct mutex lock;
-	struct iio_dev *idev;
 	struct spi_device *sdev;
 };
 
@@ -72,7 +71,7 @@ static ssize_t ad9852_set_parameter(struct device *dev,
 	int ret;
 	struct ad9852_config *config = (struct ad9852_config *)buf;
 	struct iio_dev *idev = dev_get_drvdata(dev);
-	struct ad9852_state *st = idev->dev_data;
+	struct ad9852_state *st = iio_priv(idev);
 
 	xfer.len = 3;
 	xfer.tx_buf = &config->phajst0[0];
@@ -230,30 +229,24 @@ static const struct iio_info ad9852_info = {
 static int __devinit ad9852_probe(struct spi_device *spi)
 {
 	struct ad9852_state *st;
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
+	st = iio_priv(idev);
+	spi_set_drvdata(spi, idev);
 	mutex_init(&st->lock);
 	st->sdev = spi;
 
-	st->idev = iio_allocate_device(0);
-	if (st->idev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->idev->dev.parent = &spi->dev;
+	idev->dev.parent = &spi->dev;
+	idev->info = &ad9852_info;
+	idev->modes = INDIO_DIRECT_MODE;
 
-	st->idev->info = &ad9852_info;
-	st->idev->dev_data = (void *)(st);
-	st->idev->modes = INDIO_DIRECT_MODE;
-
-	ret = iio_device_register(st->idev);
+	ret = iio_device_register(idev);
 	if (ret)
 		goto error_free_dev;
 	spi->max_speed_hz = 2000000;
@@ -261,22 +254,19 @@ static int __devinit ad9852_probe(struct spi_device *spi)
 	spi->bits_per_word = 8;
 	spi_setup(spi);
 	ad9852_init(st);
+
 	return 0;
 
 error_free_dev:
-	iio_free_device(st->idev);
-error_free_st:
-	kfree(st);
+	iio_free_device(idev);
+
 error_ret:
 	return ret;
 }
 
 static int __devexit ad9852_remove(struct spi_device *spi)
 {
-	struct ad9852_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->idev);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.3.4
