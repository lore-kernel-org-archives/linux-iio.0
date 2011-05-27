Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 22/50] staging:iio:dac:ad5624r: allocate chip state with iio_dev and use iio_priv for access.
Date: Fri, 27 May 2011 19:36:02 +0100
Message-Id: <1306521390-24897-23-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/ad5624r.h     |    1 -
 drivers/staging/iio/dac/ad5624r_spi.c |   82 +++++++++++++++-----------------
 2 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5624r.h b/drivers/staging/iio/dac/ad5624r.h
index c16df4e..b71c6a0 100644
--- a/drivers/staging/iio/dac/ad5624r.h
+++ b/drivers/staging/iio/dac/ad5624r.h
@@ -53,7 +53,6 @@ struct ad5624r_chip_info {
  */
 
 struct ad5624r_state {
-	struct iio_dev			*indio_dev;
 	struct spi_device		*us;
 	const struct ad5624r_chip_info	*chip_info;
 	struct regulator		*reg;
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index c679981..0175cc0 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -77,7 +77,7 @@ static ssize_t ad5624r_write_dac(struct device *dev,
 	long readin;
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5624r_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = strict_strtol(buf, 10, &readin);
@@ -94,7 +94,7 @@ static ssize_t ad5624r_read_powerdown_mode(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5624r_state *st = iio_priv(indio_dev);
 
 	char mode[][15] = {"", "1kohm_to_gnd", "100kohm_to_gnd", "three_state"};
 
@@ -106,7 +106,7 @@ static ssize_t ad5624r_write_powerdown_mode(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5624r_state *st = iio_priv(indio_dev);
 	int ret;
 
 	if (sysfs_streq(buf, "1kohm_to_gnd"))
@@ -126,7 +126,7 @@ static ssize_t ad5624r_read_dac_powerdown(struct device *dev,
 					   char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5624r_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	return sprintf(buf, "%d\n",
@@ -140,7 +140,7 @@ static ssize_t ad5624r_write_dac_powerdown(struct device *dev,
 	long readin;
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5624r_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = strict_strtol(buf, 10, &readin);
@@ -166,7 +166,7 @@ static ssize_t ad5624r_show_scale(struct device *dev,
 				char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5624r_state *st = iio_priv(indio_dev);
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
 
@@ -226,24 +226,26 @@ static const struct iio_info ad5624r_info = {
 static int __devinit ad5624r_probe(struct spi_device *spi)
 {
 	struct ad5624r_state *st;
+	struct iio_dev *indio_dev;
+	struct regulator *reg;
 	int ret, voltage_uv = 0;
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	spi_set_drvdata(spi, st);
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
-
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_disable_reg;
+	}
+	st = iio_priv(indio_dev);
+	st->reg = reg;
+	spi_set_drvdata(spi, indio_dev);
 	st->chip_info =
 		&ad5624r_chip_info_tbl[spi_get_device_id(spi)->driver_data];
 
@@ -253,18 +255,13 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 		st->vref_mv = st->chip_info->int_vref_mv;
 
 	st->us = spi;
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->name = spi_get_device_id(spi)->name;
-	st->indio_dev->info = &ad5624r_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->indio_dev);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad5624r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -276,32 +273,29 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(st->indio_dev);
+	iio_free_device(indio_dev);
 error_disable_reg:
-	if (!IS_ERR(st->reg))
+	if (!IS_ERR(reg))
 		regulator_disable(st->reg);
 error_put_reg:
-	if (!IS_ERR(st->reg))
-		regulator_put(st->reg);
+	if (!IS_ERR(reg))
+		regulator_put(reg);
 
-	kfree(st);
-error_ret:
 	return ret;
 }
 
 static int __devexit ad5624r_remove(struct spi_device *spi)
 {
-	struct ad5624r_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->indio_dev);
-
-	if (!IS_ERR(st->reg)) {
-		regulator_disable(st->reg);
-		regulator_put(st->reg);
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad5624r_state *st = iio_priv(indio_dev);
+	struct regulator *reg = st->reg;
+
+	iio_device_unregister(indio_dev);
+	if (!IS_ERR(reg)) {
+		regulator_disable(reg);
+		regulator_put(reg);
 	}
 
-	kfree(st);
-
 	return 0;
 }
 
-- 
1.7.3.4
