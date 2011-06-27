Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 32/54] staging:iio:ad9834: allocate chip state with iio_dev and use iio_priv to access.
Date: Mon, 27 Jun 2011 11:04:42 +0100
Message-Id: <1309169104-22139-33-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dds/ad9834.c |   81 +++++++++++++++++--------------------
 drivers/staging/iio/dds/ad9834.h |    2 -
 2 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index 0ebe8d5..e6454d5 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -66,7 +66,7 @@ static ssize_t ad9834_write(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = dev_info->dev_data;
+	struct ad9834_state *st = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	long val;
@@ -145,7 +145,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 				 size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = dev_info->dev_data;
+	struct ad9834_state *st = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret = 0;
 	bool is_ad9833_7 = (st->devid == ID_AD9833) || (st->devid == ID_AD9837);
@@ -203,7 +203,7 @@ static ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
 						char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_dev_get_devdata(dev_info);
+	struct ad9834_state *st = iio_priv(dev_info);
 	char *str;
 
 	if ((st->devid == ID_AD9833) || (st->devid == ID_AD9837))
@@ -225,7 +225,7 @@ static ssize_t ad9834_show_out1_wavetype_available(struct device *dev,
 						char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_dev_get_devdata(dev_info);
+	struct ad9834_state *st = iio_priv(dev_info);
 	char *str;
 
 	if (st->control & AD9834_MODE)
@@ -285,7 +285,7 @@ static mode_t ad9834_attr_is_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_dev_get_devdata(dev_info);
+	struct ad9834_state *st = iio_priv(dev_info);
 
 	mode_t mode = attr->mode;
 
@@ -314,6 +314,8 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 {
 	struct ad9834_platform_data *pdata = spi->dev.platform_data;
 	struct ad9834_state *st;
+	struct iio_dev *indio_dev;
+	struct regulator *reg;
 	int ret;
 
 	if (!pdata) {
@@ -321,37 +323,28 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	st->reg = regulator_get(&spi->dev, "vcc");
-	if (!IS_ERR(st->reg)) {
-		ret = regulator_enable(st->reg);
+	reg = regulator_get(&spi->dev, "vcc");
+	if (!IS_ERR(reg)) {
+		ret = regulator_enable(reg);
 		if (ret)
 			goto error_put_reg;
 	}
 
-	st->mclk = pdata->mclk;
-
-	spi_set_drvdata(spi, st);
-
-	st->spi = spi;
-	st->devid = spi_get_device_id(spi)->driver_data;
-
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
 	}
-
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->info = &ad9834_info;
-	st->indio_dev->dev_data = (void *) st;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	spi_set_drvdata(spi, indio_dev);
+	st = iio_priv(indio_dev);
+	st->mclk = pdata->mclk;
+	st->spi = spi;
+	st->devid = spi_get_device_id(spi)->driver_data;
+	st->reg = reg;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad9834_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default messages */
 
@@ -402,35 +395,35 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_device;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_device;
 
 	return 0;
 
 error_free_device:
-	iio_free_device(st->indio_dev);
+	iio_free_device(indio_dev);
 error_disable_reg:
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
+	if (!IS_ERR(reg))
+		regulator_disable(reg);
 error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
-	kfree(st);
-error_ret:
+	if (!IS_ERR(reg))
+		regulator_put(reg);
 	return ret;
 }
 
 static int __devexit ad9834_remove(struct spi_device *spi)
 {
-	struct ad9834_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->indio_dev);
-	if (!IS_ERR(st->reg)) {
-		regulator_disable(st->reg);
-		regulator_put(st->reg);
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad9834_state *st = iio_priv(indio_dev);
+	struct regulator *reg = st->reg;
+
+	iio_device_unregister(indio_dev);
+	if (!IS_ERR(reg)) {
+		regulator_disable(reg);
+		regulator_put(reg);
 	}
-	kfree(st);
+
 	return 0;
 }
 
diff --git a/drivers/staging/iio/dds/ad9834.h b/drivers/staging/iio/dds/ad9834.h
index 2abd635..ed5ed8d 100644
--- a/drivers/staging/iio/dds/ad9834.h
+++ b/drivers/staging/iio/dds/ad9834.h
@@ -38,7 +38,6 @@
 
 /**
  * struct ad9834_state - driver instance specific data
- * @indio_dev:		the industrial I/O device
  * @spi:		spi_device
  * @reg:		supply regulator
  * @mclk:		external master clock
@@ -52,7 +51,6 @@
  */
 
 struct ad9834_state {
-	struct iio_dev			*indio_dev;
 	struct spi_device		*spi;
 	struct regulator		*reg;
 	unsigned int			mclk;
-- 
1.7.3.4
