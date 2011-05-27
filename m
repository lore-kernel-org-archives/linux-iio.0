Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 32/50] staging:iio:dds:ad9910: allocate chip state with iio_dev
Date: Fri, 27 May 2011 19:36:12 +0100
Message-Id: <1306521390-24897-33-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dds/ad9910.c |   36 ++++++++++++------------------------
 1 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index 97d75d7..0fa217f 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -110,7 +110,6 @@ struct ad9910_config {
 
 struct ad9910_state {
 	struct mutex lock;
-	struct iio_dev *idev;
 	struct spi_device *sdev;
 };
 
@@ -124,7 +123,7 @@ static ssize_t ad9910_set_parameter(struct device *dev,
 	int ret;
 	struct ad9910_config *config = (struct ad9910_config *)buf;
 	struct iio_dev *idev = dev_get_drvdata(dev);
-	struct ad9910_state *st = idev->dev_data;
+	struct ad9910_state *st = iio_priv(idev);
 
 	xfer.len = 5;
 	xfer.tx_buf = &config->auxdac[0];
@@ -365,30 +364,24 @@ static const struct iio_info ad9910_info = {
 static int __devinit ad9910_probe(struct spi_device *spi)
 {
 	struct ad9910_state *st;
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
-	st->idev->info = &ad9910_info;
-	st->idev->dev_data = (void *)(st);
-	st->idev->modes = INDIO_DIRECT_MODE;
+	idev->dev.parent = &spi->dev;
+	idev->info = &ad9910_info;
+	idev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->idev);
+	ret = iio_device_register(idev);
 	if (ret)
 		goto error_free_dev;
 	spi->max_speed_hz = 2000000;
@@ -399,19 +392,14 @@ static int __devinit ad9910_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(st->idev);
-error_free_st:
-	kfree(st);
+	iio_free_device(idev);
 error_ret:
 	return ret;
 }
 
 static int __devexit ad9910_remove(struct spi_device *spi)
 {
-	struct ad9910_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->idev);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.3.4
