Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 26/54] staging:iio:dac:ad5504: allocate chip state with iio_dev and use iio_priv for access.
Date: Mon, 27 Jun 2011 11:04:36 +0100
Message-Id: <1309169104-22139-27-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dac/ad5504.c |   89 +++++++++++++++++--------------------
 drivers/staging/iio/dac/ad5504.h |    2 -
 2 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index ed029cd..1915f45 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -55,7 +55,7 @@ static ssize_t ad5504_write_dac(struct device *dev,
 				 const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5504_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5504_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long readin;
 	int ret;
@@ -73,7 +73,7 @@ static ssize_t ad5504_read_dac(struct device *dev,
 					   char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5504_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5504_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	int ret;
 	u16 val;
@@ -89,7 +89,7 @@ static ssize_t ad5504_read_powerdown_mode(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5504_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5504_state *st = iio_priv(indio_dev);
 
 	const char mode[][14] = {"20kohm_to_gnd", "three_state"};
 
@@ -101,7 +101,7 @@ static ssize_t ad5504_write_powerdown_mode(struct device *dev,
 				       const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5504_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5504_state *st = iio_priv(indio_dev);
 	int ret;
 
 	if (sysfs_streq(buf, "20kohm_to_gnd"))
@@ -119,7 +119,7 @@ static ssize_t ad5504_read_dac_powerdown(struct device *dev,
 					   char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5504_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5504_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	return sprintf(buf, "%d\n",
@@ -133,7 +133,7 @@ static ssize_t ad5504_write_dac_powerdown(struct device *dev,
 	long readin;
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5504_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5504_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = strict_strtol(buf, 10, &readin);
@@ -162,7 +162,7 @@ static ssize_t ad5504_show_scale(struct device *dev,
 				char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5504_state *st = iio_dev_get_devdata(indio_dev);
+	struct ad5504_state *st = iio_priv(indio_dev);
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (st->vref_mv * 1000) >> AD5505_BITS;
 
@@ -277,26 +277,27 @@ static const struct iio_info ad5501_info = {
 static int __devinit ad5504_probe(struct spi_device *spi)
 {
 	struct ad5504_platform_data *pdata = spi->dev.platform_data;
+	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
+	struct regulator *reg;
 	int ret, voltage_uv = 0;
 
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
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
 
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_disable_reg;
+	}
+	spi_set_drvdata(spi, indio_dev);
+	st = iio_priv(indio_dev);
 	if (voltage_uv)
 		st->vref_mv = voltage_uv / 1000;
 	else if (pdata)
@@ -304,22 +305,17 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 	else
 		dev_warn(&spi->dev, "reference voltage unspecified\n");
 
+	st->reg = reg;
 	st->spi = spi;
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->name = spi_get_device_id(st->spi)->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(st->spi)->name;
 	if (spi_get_device_id(st->spi)->driver_data == ID_AD5501)
-		st->indio_dev->info = &ad5501_info;
+		indio_dev->info = &ad5501_info;
 	else
-		st->indio_dev->info = &ad5504_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+		indio_dev->info = &ad5504_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -329,7 +325,7 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 					   &ad5504_event_handler,
 					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   spi_get_device_id(st->spi)->name,
-					   st->indio_dev);
+					   indio_dev);
 		if (ret)
 			goto error_unreg_iio_device;
 	}
@@ -337,37 +333,34 @@ static int __devinit ad5504_probe(struct spi_device *spi)
 	return 0;
 
 error_unreg_iio_device:
-	iio_device_unregister(st->indio_dev);
+	iio_device_unregister(indio_dev);
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
 
 static int __devexit ad5504_remove(struct spi_device *spi)
 {
-	struct ad5504_state *st = spi_get_drvdata(spi);
-
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad5504_state *st = iio_priv(indio_dev);
+	struct regulator *reg = st->reg;
 	if (spi->irq)
-		free_irq(spi->irq, st->indio_dev);
+		free_irq(spi->irq, indio_dev);
 
-	iio_device_unregister(st->indio_dev);
+	iio_device_unregister(indio_dev);
 
-	if (!IS_ERR(st->reg)) {
-		regulator_disable(st->reg);
-		regulator_put(st->reg);
+	if (!IS_ERR(reg)) {
+		regulator_disable(reg);
+		regulator_put(reg);
 	}
 
-	kfree(st);
-
 	return 0;
 }
 
diff --git a/drivers/staging/iio/dac/ad5504.h b/drivers/staging/iio/dac/ad5504.h
index 13ef353..85beb1d 100644
--- a/drivers/staging/iio/dac/ad5504.h
+++ b/drivers/staging/iio/dac/ad5504.h
@@ -41,7 +41,6 @@ struct ad5504_platform_data {
 
 /**
  * struct ad5446_state - driver instance specific data
- * @indio_dev:		the industrial I/O device
  * @us:			spi_device
  * @reg:		supply regulator
  * @vref_mv:		actual reference voltage used
@@ -50,7 +49,6 @@ struct ad5504_platform_data {
  */
 
 struct ad5504_state {
-	struct iio_dev			*indio_dev;
 	struct spi_device		*spi;
 	struct regulator		*reg;
 	unsigned short			vref_mv;
-- 
1.7.3.4
