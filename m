Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 27/54] staging:iio:dac:ad5446: allocate chip state with iio_dev and use iio_priv for access.
Date: Mon, 27 Jun 2011 11:04:37 +0100
Message-Id: <1309169104-22139-28-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dac/ad5446.c |   82 +++++++++++++++++--------------------
 drivers/staging/iio/dac/ad5446.h |    2 -
 2 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 86cb08c..e8a9d0b 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -68,7 +68,7 @@ static ssize_t ad5446_write(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = dev_info->dev_data;
+	struct ad5446_state *st = iio_priv(dev_info);
 	int ret;
 	long val;
 
@@ -98,7 +98,7 @@ static ssize_t ad5446_show_scale(struct device *dev,
 				char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_dev_get_devdata(dev_info);
+	struct ad5446_state *st = iio_priv(dev_info);
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
 
@@ -111,7 +111,7 @@ static ssize_t ad5446_write_powerdown_mode(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = dev_info->dev_data;
+	struct ad5446_state *st = iio_priv(dev_info);
 
 	if (sysfs_streq(buf, "1kohm_to_gnd"))
 		st->pwr_down_mode = MODE_PWRDWN_1k;
@@ -129,7 +129,7 @@ static ssize_t ad5446_read_powerdown_mode(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = dev_info->dev_data;
+	struct ad5446_state *st = iio_priv(dev_info);
 
 	char mode[][15] = {"", "1kohm_to_gnd", "100kohm_to_gnd", "three_state"};
 
@@ -141,7 +141,7 @@ static ssize_t ad5446_read_dac_powerdown(struct device *dev,
 					   char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = dev_info->dev_data;
+	struct ad5446_state *st = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", st->pwr_down);
 }
@@ -151,7 +151,7 @@ static ssize_t ad5446_write_dac_powerdown(struct device *dev,
 					    const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = dev_info->dev_data;
+	struct ad5446_state *st = iio_priv(dev_info);
 	unsigned long readin;
 	int ret;
 
@@ -201,7 +201,7 @@ static mode_t ad5446_attr_is_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_dev_get_devdata(dev_info);
+	struct ad5446_state *st = iio_priv(dev_info);
 
 	mode_t mode = attr->mode;
 
@@ -342,42 +342,37 @@ static const struct iio_info ad5446_info = {
 static int __devinit ad5446_probe(struct spi_device *spi)
 {
 	struct ad5446_state *st;
+	struct iio_dev *indio_dev;
+	struct regulator *reg;
 	int ret, voltage_uv = 0;
 
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
 
-		voltage_uv = regulator_get_voltage(st->reg);
+		voltage_uv = regulator_get_voltage(reg);
 	}
 
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_disable_reg;
+	}
+	st = iio_priv(indio_dev);
 	st->chip_info =
 		&ad5446_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
-	spi_set_drvdata(spi, st);
-
+	spi_set_drvdata(spi, indio_dev);
+	st->reg = reg;
 	st->spi = spi;
 
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
-
 	/* Estabilish that the iio_dev is a child of the spi device */
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->info = &ad5446_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad5446_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default message */
 
@@ -404,36 +399,35 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 				 "reference voltage unspecified\n");
 	}
 
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
 
 static int ad5446_remove(struct spi_device *spi)
 {
-	struct ad5446_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad5446_state *st = iio_priv(indio_dev);
+	struct regulator *reg = st->reg;
 
 	iio_device_unregister(indio_dev);
-	if (!IS_ERR(st->reg)) {
-		regulator_disable(st->reg);
-		regulator_put(st->reg);
+	if (!IS_ERR(reg)) {
+		regulator_disable(reg);
+		regulator_put(reg);
 	}
-	kfree(st);
 	return 0;
 }
 
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
index e6ffd2b..7118d65 100644
--- a/drivers/staging/iio/dac/ad5446.h
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -33,7 +33,6 @@
 
 /**
  * struct ad5446_state - driver instance specific data
- * @indio_dev:		the industrial I/O device
  * @spi:		spi_device
  * @chip_info:		chip model specific constants, available modes etc
  * @reg:		supply regulator
@@ -45,7 +44,6 @@
  */
 
 struct ad5446_state {
-	struct iio_dev			*indio_dev;
 	struct spi_device		*spi;
 	const struct ad5446_chip_info	*chip_info;
 	struct regulator		*reg;
-- 
1.7.3.4
