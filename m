Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 33/50] staging:iio:dds:ad9951: allocate chip state with iio_dev
Date: Fri, 27 May 2011 19:36:13 +0100
Message-Id: <1306521390-24897-34-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dds/ad9951.c |   36 +++++++++++++-----------------------
 1 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index d4dfcd4..d361d1f 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -51,7 +51,6 @@ struct ad9951_config {
 
 struct ad9951_state {
 	struct mutex lock;
-	struct iio_dev *idev;
 	struct spi_device *sdev;
 };
 
@@ -65,7 +64,7 @@ static ssize_t ad9951_set_parameter(struct device *dev,
 	int ret;
 	struct ad9951_config *config = (struct ad9951_config *)buf;
 	struct iio_dev *idev = dev_get_drvdata(dev);
-	struct ad9951_state *st = idev->dev_data;
+	struct ad9951_state *st = iio_priv(idev);
 
 	xfer.len = 3;
 	xfer.tx_buf = &config->asf[0];
@@ -174,30 +173,25 @@ static const struct iio_info ad9951_info = {
 static int __devinit ad9951_probe(struct spi_device *spi)
 {
 	struct ad9951_state *st;
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
+	idev->dev.parent = &spi->dev;
 
-	st->idev->info = &ad9951_info;
-	st->idev->dev_data = (void *)(st);
-	st->idev->modes = INDIO_DIRECT_MODE;
+	idev->info = &ad9951_info;
+	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->idev);
+	ret = iio_device_register(idev);
 	if (ret)
 		goto error_free_dev;
 	spi->max_speed_hz = 2000000;
@@ -208,19 +202,15 @@ static int __devinit ad9951_probe(struct spi_device *spi)
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
 
 static int __devexit ad9951_remove(struct spi_device *spi)
 {
-	struct ad9951_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->idev);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.3.4
