Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 28/54] staging:iio:dac:ad5791: allocate chip state with iio_dev and use iio_priv for access.
Date: Mon, 27 Jun 2011 11:04:38 +0100
Message-Id: <1309169104-22139-29-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Slightly fiddly case with two regulators - could reorder, but this is the approach with
smallest likely impact.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dac/ad5791.c |  112 +++++++++++++++++++-------------------
 drivers/staging/iio/dac/ad5791.h |    2 -
 2 files changed, 55 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 4eda25c..64770d2 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -76,7 +76,7 @@ static ssize_t ad5791_write_dac(struct device *dev,
 				 const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5791_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long readin;
 	int ret;
@@ -98,7 +98,7 @@ static ssize_t ad5791_read_dac(struct device *dev,
 					   char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5791_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	int val;
@@ -118,7 +118,7 @@ static ssize_t ad5791_read_powerdown_mode(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5791_state *st = iio_priv(indio_dev);
 
 	const char mode[][14] = {"6kohm_to_gnd", "three_state"};
 
@@ -130,7 +130,7 @@ static ssize_t ad5791_write_powerdown_mode(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5791_state *st = iio_priv(indio_dev);
 	int ret;
 
 	if (sysfs_streq(buf, "6kohm_to_gnd"))
@@ -148,7 +148,7 @@ static ssize_t ad5791_read_dac_powerdown(struct device *dev,
 					   char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5791_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%d\n", st->pwr_down);
 }
@@ -160,7 +160,7 @@ static ssize_t ad5791_write_dac_powerdown(struct device *dev,
 	long readin;
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5791_state *st = iio_priv(indio_dev);
 
 	ret = strict_strtol(buf, 10, &readin);
 	if (ret)
@@ -188,7 +188,7 @@ static ssize_t ad5791_show_scale(struct device *dev,
 				char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5791_state *st = iio_priv(indio_dev);
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
 
@@ -201,7 +201,7 @@ static ssize_t ad5791_show_name(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5791_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
 }
@@ -295,36 +295,39 @@ static const struct iio_info ad5791_info = {
 static int __devinit ad5791_probe(struct spi_device *spi)
 {
 	struct ad5791_platform_data *pdata = spi->dev.platform_data;
+	struct iio_dev *indio_dev;
+	struct regulator *reg_vdd, *reg_vss;
 	struct ad5791_state *st;
 	int ret, pos_voltage_uv = 0, neg_voltage_uv = 0;
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	spi_set_drvdata(spi, st);
-
-	st->reg_vdd = regulator_get(&spi->dev, "vdd");
-	if (!IS_ERR(st->reg_vdd)) {
-		ret = regulator_enable(st->reg_vdd);
+	reg_vdd = regulator_get(&spi->dev, "vdd");
+	if (!IS_ERR(reg_vdd)) {
+		ret = regulator_enable(reg_vdd);
 		if (ret)
 			goto error_put_reg_pos;
 
-		pos_voltage_uv = regulator_get_voltage(st->reg_vdd);
+		pos_voltage_uv = regulator_get_voltage(reg_vdd);
 	}
 
-	st->reg_vss = regulator_get(&spi->dev, "vss");
-	if (!IS_ERR(st->reg_vss)) {
-		ret = regulator_enable(st->reg_vss);
+	reg_vss = regulator_get(&spi->dev, "vss");
+	if (!IS_ERR(reg_vss)) {
+		ret = regulator_enable(reg_vss);
 		if (ret)
 			goto error_put_reg_neg;
 
-		neg_voltage_uv = regulator_get_voltage(st->reg_vss);
+		neg_voltage_uv = regulator_get_voltage(reg_vss);
 	}
 
-	if (!IS_ERR(st->reg_vss) && !IS_ERR(st->reg_vdd))
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_disable_reg_neg;
+	}
+	st = iio_priv(indio_dev);
+	st->pwr_down = true;
+	st->spi = spi;
+
+	if (!IS_ERR(reg_vss) && !IS_ERR(reg_vdd))
 		st->vref_mv = (pos_voltage_uv - neg_voltage_uv) / 1000;
 	else if (pdata)
 		st->vref_mv = pdata->vref_pos_mv - pdata->vref_neg_mv;
@@ -333,7 +336,7 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 
 	ret = ad5791_spi_write(spi, AD5791_ADDR_SW_CTRL, AD5791_SWCTRL_RESET);
 	if (ret)
-		goto error_disable_reg_neg;
+		goto error_free_dev;
 
 	st->chip_info =
 		&ad5791_chip_info_tbl[spi_get_device_id(spi)->driver_data];
@@ -346,66 +349,61 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 	ret = ad5791_spi_write(spi, AD5791_ADDR_CTRL, st->ctrl |
 		AD5791_CTRL_OPGND | AD5791_CTRL_DACTRI);
 	if (ret)
-		goto error_disable_reg_neg;
+		goto error_free_dev;
 
-	st->pwr_down = true;
+	st->reg_vdd = reg_vdd;
+	st->reg_vss = reg_vss;
 
-	st->spi = spi;
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg_neg;
-	}
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->info = &ad5791_info;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	spi_set_drvdata(spi, indio_dev);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &ad5791_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
 	return 0;
 
 error_free_dev:
-	iio_free_device(st->indio_dev);
+	iio_free_device(indio_dev);
 
 error_disable_reg_neg:
-	if (!IS_ERR(st->reg_vss))
-		regulator_disable(st->reg_vss);
+	if (!IS_ERR(reg_vss))
+		regulator_disable(reg_vss);
 error_put_reg_neg:
-	if (!IS_ERR(st->reg_vss))
-		regulator_put(st->reg_vss);
+	if (!IS_ERR(reg_vss))
+		regulator_put(reg_vss);
 
-	if (!IS_ERR(st->reg_vdd))
-		regulator_disable(st->reg_vdd);
+	if (!IS_ERR(reg_vdd))
+		regulator_disable(reg_vdd);
 error_put_reg_pos:
-	if (!IS_ERR(st->reg_vdd))
-		regulator_put(st->reg_vdd);
+	if (!IS_ERR(reg_vdd))
+		regulator_put(reg_vdd);
 
-	kfree(st);
 error_ret:
 	return ret;
 }
 
 static int __devexit ad5791_remove(struct spi_device *spi)
 {
-	struct ad5791_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad5791_state *st = iio_priv(indio_dev);
+	struct regulator *reg_vdd = st->reg_vdd;
+	struct regulator *reg_vss = st->reg_vss;
 
-	iio_device_unregister(st->indio_dev);
+	iio_device_unregister(indio_dev);
 
 	if (!IS_ERR(st->reg_vdd)) {
-		regulator_disable(st->reg_vdd);
-		regulator_put(st->reg_vdd);
+		regulator_disable(reg_vdd);
+		regulator_put(reg_vdd);
 	}
 
 	if (!IS_ERR(st->reg_vss)) {
-		regulator_disable(st->reg_vss);
-		regulator_put(st->reg_vss);
+		regulator_disable(reg_vss);
+		regulator_put(reg_vss);
 	}
 
-	kfree(st);
-
 	return 0;
 }
 
diff --git a/drivers/staging/iio/dac/ad5791.h b/drivers/staging/iio/dac/ad5791.h
index f09ad9a..c807f26 100644
--- a/drivers/staging/iio/dac/ad5791.h
+++ b/drivers/staging/iio/dac/ad5791.h
@@ -81,7 +81,6 @@ struct ad5791_chip_info {
 
 /**
  * struct ad5791_state - driver instance specific data
- * @indio_dev:		the industrial I/O device
  * @us:			spi_device
  * @reg_vdd:		positive supply regulator
  * @reg_vss:		negative supply regulator
@@ -91,7 +90,6 @@ struct ad5791_chip_info {
  */
 
 struct ad5791_state {
-	struct iio_dev			*indio_dev;
 	struct spi_device		*spi;
 	struct regulator		*reg_vdd;
 	struct regulator		*reg_vss;
-- 
1.7.3.4
