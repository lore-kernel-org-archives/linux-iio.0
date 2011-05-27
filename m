Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 28/50] staging:iio:dds:ad9832: allocate chip state with iio_dev and use iio_priv to access.
Date: Fri, 27 May 2011 19:36:08 +0100
Message-Id: <1306521390-24897-29-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dds/ad9832.c |   69 +++++++++++++++++--------------------
 drivers/staging/iio/dds/ad9832.h |    2 -
 2 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index e8fe142..e3e61a4 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -77,7 +77,7 @@ static ssize_t ad9832_write(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad9832_state *st = dev_info->dev_data;
+	struct ad9832_state *st = iio_priv(dev_info);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	long val;
@@ -203,7 +203,9 @@ static const struct iio_info ad9832_info = {
 static int __devinit ad9832_probe(struct spi_device *spi)
 {
 	struct ad9832_platform_data *pdata = spi->dev.platform_data;
+	struct iio_dev *indio_dev;
 	struct ad9832_state *st;
+	struct regulator *reg;
 	int ret;
 
 	if (!pdata) {
@@ -211,35 +213,28 @@ static int __devinit ad9832_probe(struct spi_device *spi)
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
-	st->spi = spi;
-
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_disable_reg;
 	}
+	spi_set_drvdata(spi, indio_dev);
+	st = iio_priv(indio_dev);
+	st->reg = reg;
+	st->mclk = pdata->mclk;
+	st->spi = spi;
 
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->info = &ad9832_info;
-	st->indio_dev->dev_data = (void *) st;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad9832_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default messages */
 
@@ -310,35 +305,35 @@ static int __devinit ad9832_probe(struct spi_device *spi)
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
+
 	return ret;
 }
 
 static int __devexit ad9832_remove(struct spi_device *spi)
 {
-	struct ad9832_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->indio_dev);
-	if (!IS_ERR(st->reg)) {
-		regulator_disable(st->reg);
-		regulator_put(st->reg);
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad9832_state *st = iio_priv(indio_dev);
+	struct regulator *reg = st->reg;
+
+	iio_device_unregister(indio_dev);
+	if (!IS_ERR(reg)) {
+		regulator_disable(reg);
+		regulator_put(reg);
 	}
-	kfree(st);
 	return 0;
 }
 
diff --git a/drivers/staging/iio/dds/ad9832.h b/drivers/staging/iio/dds/ad9832.h
index 5d47454..c5b701f 100644
--- a/drivers/staging/iio/dds/ad9832.h
+++ b/drivers/staging/iio/dds/ad9832.h
@@ -57,7 +57,6 @@
 
 /**
  * struct ad9832_state - driver instance specific data
- * @indio_dev:		the industrial I/O device
  * @spi:		spi_device
  * @reg:		supply regulator
  * @mclk:		external master clock
@@ -76,7 +75,6 @@
  */
 
 struct ad9832_state {
-	struct iio_dev			*indio_dev;
 	struct spi_device		*spi;
 	struct regulator		*reg;
 	unsigned long			mclk;
-- 
1.7.3.4
