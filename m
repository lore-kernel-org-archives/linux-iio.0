Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/16] staging:iio:dac:ad5791 chan spec conversion.
Date: Fri, 26 Aug 2011 11:19:18 +0100
Message-Id: <1314353973-7662-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/ad5791.c |  158 +++++++++++++++++---------------------
 drivers/staging/iio/dac/ad5791.h |    4 -
 2 files changed, 72 insertions(+), 90 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index b266513..d904c14 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -71,48 +71,22 @@ static int ad5791_spi_read(struct spi_device *spi, u8 addr, u32 *val)
 	return ret;
 }
 
-static ssize_t ad5791_write_dac(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	long readin;
-	int ret;
-
-	ret = strict_strtol(buf, 10, &readin);
-	if (ret)
-		return ret;
-
-	readin += (1 << (st->chip_info->bits - 1));
-	readin &= AD5791_RES_MASK(st->chip_info->bits);
-	readin <<= st->chip_info->left_shift;
-
-	ret = ad5791_spi_write(st->spi, this_attr->address, readin);
-	return ret ? ret : len;
+#define AD5791_CHAN(bits, shift) {			\
+	.type = IIO_VOLTAGE,				\
+	.output = 1,					\
+	.indexed = 1,					\
+	.address = AD5791_ADDR_DAC0,			\
+	.channel = 0,					\
+	.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),	\
+	.scan_type = IIO_ST('u', bits, 24, shift)	\
 }
 
-static ssize_t ad5791_read_dac(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret;
-	int val;
-
-	ret = ad5791_spi_read(st->spi, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	val &= AD5791_DAC_MASK;
-	val >>= st->chip_info->left_shift;
-	val -= (1 << (st->chip_info->bits - 1));
-
-	return sprintf(buf, "%d\n", val);
-}
+static const struct iio_chan_spec ad5791_channels[] = {
+	[ID_AD5760] = AD5791_CHAN(16, 4),
+	[ID_AD5780] = AD5791_CHAN(18, 2),
+	[ID_AD5781] = AD5791_CHAN(18, 2),
+	[ID_AD5791] = AD5791_CHAN(20, 0)
+};
 
 static ssize_t ad5791_read_powerdown_mode(struct device *dev,
 				      struct device_attribute *attr, char *buf)
@@ -183,37 +157,6 @@ static ssize_t ad5791_write_dac_powerdown(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t ad5791_show_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_priv(indio_dev);
-	/* Corresponds to Vref / 2^(bits) */
-	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
-
-	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
-}
-static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5791_show_scale, NULL, 0);
-
-static ssize_t ad5791_show_name(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5791_state *st = iio_priv(indio_dev);
-
-	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
-}
-static IIO_DEVICE_ATTR(name, S_IRUGO, ad5791_show_name, NULL, 0);
-
-#define IIO_DEV_ATTR_OUT_RW_RAW(_num, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(out##_num##_raw,				\
-			S_IRUGO | S_IWUSR, _show, _store, _addr)
-
-static IIO_DEV_ATTR_OUT_RW_RAW(0, ad5791_read_dac,
-	ad5791_write_dac, AD5791_ADDR_DAC0);
-
 static IIO_DEVICE_ATTR(out_powerdown_mode, S_IRUGO |
 			S_IWUSR, ad5791_read_powerdown_mode,
 			ad5791_write_powerdown_mode, 0);
@@ -229,12 +172,9 @@ static IIO_DEV_ATTR_DAC_POWERDOWN(0, ad5791_read_dac_powerdown,
 				   ad5791_write_dac_powerdown, 0);
 
 static struct attribute *ad5791_attributes[] = {
-	&iio_dev_attr_out0_raw.dev_attr.attr,
 	&iio_dev_attr_out0_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
 	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
-	&iio_dev_attr_out_scale.dev_attr.attr,
-	&iio_dev_attr_name.dev_attr.attr,
 	NULL,
 };
 
@@ -263,31 +203,74 @@ static int ad5780_get_lin_comp(unsigned int span)
 	else
 		return AD5780_LINCOMP_10_20;
 }
-
 static const struct ad5791_chip_info ad5791_chip_info_tbl[] = {
 	[ID_AD5760] = {
-		.bits = 16,
-		.left_shift = 4,
 		.get_lin_comp = ad5780_get_lin_comp,
 	},
 	[ID_AD5780] = {
-		.bits = 18,
-		.left_shift = 2,
 		.get_lin_comp = ad5780_get_lin_comp,
 	},
 	[ID_AD5781] = {
-		.bits = 18,
-		.left_shift = 2,
 		.get_lin_comp = ad5791_get_lin_comp,
 	},
 	[ID_AD5791] = {
-		.bits = 20,
-		.left_shift = 0,
 		.get_lin_comp = ad5791_get_lin_comp,
 	},
 };
 
+static int ad5791_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (m) {
+	case 0:
+		ret = ad5791_spi_read(st->spi, chan->address, val);
+		if (ret)
+			return ret;
+		*val &= AD5791_DAC_MASK;
+		*val >>= chan->scan_type.shift;
+		*val -= (1 << (chan->scan_type.storagebits - 1));
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		*val = 0;
+		*val2 = (st->vref_mv * 1000) >> chan->scan_type.storagebits;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+
+};
+
+
+static int ad5791_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case 0:
+		val += (1 << (chan->scan_type.storagebits - 1));
+		val &= AD5791_RES_MASK(chan->scan_type.storagebits);
+		val <<= chan->scan_type.shift;
+
+		return ad5791_spi_write(st->spi, chan->address, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ad5791_info = {
+	.read_raw = &ad5791_read_raw,
+	.write_raw = &ad5791_write_raw,
 	.attrs = &ad5791_attribute_group,
 	.driver_module = THIS_MODULE,
 };
@@ -337,8 +320,8 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 	if (ret)
 		goto error_disable_reg_neg;
 
-	st->chip_info =
-		&ad5791_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+	st->chip_info =	&ad5791_chip_info_tbl[spi_get_device_id(spi)
+					      ->driver_data];
 
 
 	st->ctrl = AD5761_CTRL_LINCOMP(st->chip_info->get_lin_comp(st->vref_mv))
@@ -354,7 +337,10 @@ static int __devinit ad5791_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad5791_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-
+	indio_dev->channels
+		= &ad5791_channels[spi_get_device_id(spi)->driver_data];
+	indio_dev->num_channels = 1;
+	indio_dev->name = spi_get_device_id(st->spi)->name;
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_disable_reg_neg;
diff --git a/drivers/staging/iio/dac/ad5791.h b/drivers/staging/iio/dac/ad5791.h
index c807f26..2a50a11 100644
--- a/drivers/staging/iio/dac/ad5791.h
+++ b/drivers/staging/iio/dac/ad5791.h
@@ -68,14 +68,10 @@ struct ad5791_platform_data {
 
 /**
  * struct ad5791_chip_info - chip specific information
- * @bits:		accuracy of the DAC in bits
- * @left_shift:		number of bits the datum must be shifted
  * @get_lin_comp:	function pointer to the device specific function
  */
 
 struct ad5791_chip_info {
-	u8			bits;
-	u8			left_shift;
 	int (*get_lin_comp)	(unsigned int span);
 };
 
-- 
1.7.3.4
