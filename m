Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] staging:iio:dac:ad5624r: Convert to channel spec
Date: Tue, 15 Nov 2011 16:31:24 +0100
Message-ID: <1321371084-21519-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1321371084-21519-1-git-send-email-lars@metafoo.de>
References: <1321371084-21519-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/ad5624r.h     |    4 +-
 drivers/staging/iio/dac/ad5624r_spi.c |  126 ++++++++++++++++++++-------------
 2 files changed, 79 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5624r.h b/drivers/staging/iio/dac/ad5624r.h
index b71c6a0..5dca302 100644
--- a/drivers/staging/iio/dac/ad5624r.h
+++ b/drivers/staging/iio/dac/ad5624r.h
@@ -32,12 +32,12 @@
 
 /**
  * struct ad5624r_chip_info - chip specific information
- * @bits:		accuracy of the DAC in bits
+ * @channels:		channel spec for the DAC
  * @int_vref_mv:	AD5620/40/60: the internal reference voltage
  */
 
 struct ad5624r_chip_info {
-	u8				bits;
+	const struct iio_chan_spec	*channels;
 	u16				int_vref_mv;
 };
 
diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
index 284d879..2c5524e 100644
--- a/drivers/staging/iio/dac/ad5624r_spi.c
+++ b/drivers/staging/iio/dac/ad5624r_spi.c
@@ -21,29 +21,51 @@
 #include "dac.h"
 #include "ad5624r.h"
 
+#define AD5624R_CHANNEL(_chan, _bits) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.output = 1, \
+	.channel = (_chan), \
+	.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT, \
+	.address = (_chan), \
+	.scan_type = IIO_ST('u', (_bits), 16, 16 - (_bits)), \
+}
+
+#define DECLARE_AD5624R_CHANNELS(_name, _bits) \
+	const struct iio_chan_spec _name##_channels[] = { \
+		AD5624R_CHANNEL(0, _bits), \
+		AD5624R_CHANNEL(1, _bits), \
+		AD5624R_CHANNEL(2, _bits), \
+		AD5624R_CHANNEL(3, _bits), \
+}
+
+static DECLARE_AD5624R_CHANNELS(ad5624r, 12);
+static DECLARE_AD5624R_CHANNELS(ad5644r, 14);
+static DECLARE_AD5624R_CHANNELS(ad5664r, 16);
+
 static const struct ad5624r_chip_info ad5624r_chip_info_tbl[] = {
 	[ID_AD5624R3] = {
-		.bits = 12,
-		.int_vref_mv = 1250,
-	},
-	[ID_AD5644R3] = {
-		.bits = 14,
-		.int_vref_mv = 1250,
-	},
-	[ID_AD5664R3] = {
-		.bits = 16,
+		.channels = ad5624r_channels,
 		.int_vref_mv = 1250,
 	},
 	[ID_AD5624R5] = {
-		.bits = 12,
+		.channels = ad5624r_channels,
 		.int_vref_mv = 2500,
 	},
+	[ID_AD5644R3] = {
+		.channels = ad5644r_channels,
+		.int_vref_mv = 1250,
+	},
 	[ID_AD5644R5] = {
-		.bits = 14,
+		.channels = ad5644r_channels,
 		.int_vref_mv = 2500,
 	},
+	[ID_AD5664R3] = {
+		.channels = ad5664r_channels,
+		.int_vref_mv = 1250,
+	},
 	[ID_AD5664R5] = {
-		.bits = 16,
+		.channels = ad5664r_channels,
 		.int_vref_mv = 2500,
 	},
 };
@@ -70,24 +92,49 @@ static int ad5624r_spi_write(struct spi_device *spi,
 	return spi_write(spi, msg, 3);
 }
 
-static ssize_t ad5624r_write_dac(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t len)
+static int ad5624r_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
-	long readin;
-	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad5624r_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	unsigned long scale_uv;
 
-	ret = strict_strtol(buf, 10, &readin);
-	if (ret)
-		return ret;
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
+		*val =  scale_uv / 1000;
+		*val2 = (scale_uv % 1000) * 1000;
+		return IIO_VAL_INT_PLUS_MICRO;
 
-	ret = ad5624r_spi_write(st->us, AD5624R_CMD_WRITE_INPUT_N_UPDATE_N,
-				this_attr->address, readin,
-				st->chip_info->bits);
-	return ret ? ret : len;
+	}
+	return -EINVAL;
+}
+
+static int ad5624r_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val,
+			       int val2,
+			       long mask)
+{
+	struct ad5624r_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case 0:
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
+			return -EINVAL;
+
+		return ad5624r_spi_write(st->us,
+				AD5624R_CMD_WRITE_INPUT_N_UPDATE_N,
+				chan->address, val,
+				chan->scan_type.shift);
+	default:
+		ret = -EINVAL;
+	}
+
+	return -EINVAL;
 }
 
 static ssize_t ad5624r_read_powerdown_mode(struct device *dev,
@@ -161,24 +208,6 @@ static ssize_t ad5624r_write_dac_powerdown(struct device *dev,
 	return ret ? ret : len;
 }
 
-static ssize_t ad5624r_show_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5624r_state *st = iio_priv(indio_dev);
-	/* Corresponds to Vref / 2^(bits) */
-	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
-
-	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
-}
-static IIO_DEVICE_ATTR(out_voltage_scale, S_IRUGO, ad5624r_show_scale, NULL, 0);
-
-static IIO_DEV_ATTR_OUT_RAW(0, ad5624r_write_dac, AD5624R_ADDR_DAC0);
-static IIO_DEV_ATTR_OUT_RAW(1, ad5624r_write_dac, AD5624R_ADDR_DAC1);
-static IIO_DEV_ATTR_OUT_RAW(2, ad5624r_write_dac, AD5624R_ADDR_DAC2);
-static IIO_DEV_ATTR_OUT_RAW(3, ad5624r_write_dac, AD5624R_ADDR_DAC3);
-
 static IIO_DEVICE_ATTR(out_voltage_powerdown_mode, S_IRUGO |
 			S_IWUSR, ad5624r_read_powerdown_mode,
 			ad5624r_write_powerdown_mode, 0);
@@ -200,17 +229,12 @@ static IIO_DEV_ATTR_DAC_POWERDOWN(3, ad5624r_read_dac_powerdown,
 				   ad5624r_write_dac_powerdown, 3);
 
 static struct attribute *ad5624r_attributes[] = {
-	&iio_dev_attr_out_voltage0_raw.dev_attr.attr,
-	&iio_dev_attr_out_voltage1_raw.dev_attr.attr,
-	&iio_dev_attr_out_voltage2_raw.dev_attr.attr,
-	&iio_dev_attr_out_voltage3_raw.dev_attr.attr,
 	&iio_dev_attr_out_voltage0_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage1_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage2_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage3_powerdown.dev_attr.attr,
 	&iio_dev_attr_out_voltage_powerdown_mode.dev_attr.attr,
 	&iio_const_attr_out_voltage_powerdown_mode_available.dev_attr.attr,
-	&iio_dev_attr_out_voltage_scale.dev_attr.attr,
 	NULL,
 };
 
@@ -219,6 +243,8 @@ static const struct attribute_group ad5624r_attribute_group = {
 };
 
 static const struct iio_info ad5624r_info = {
+	.write_raw = ad5624r_write_raw,
+	.read_raw = ad5624r_read_raw,
 	.attrs = &ad5624r_attribute_group,
 	.driver_module = THIS_MODULE,
 };
@@ -259,6 +285,8 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->info = &ad5624r_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = AD5624R_DAC_CHANNELS;
 
 	ret = ad5624r_spi_write(spi, AD5624R_CMD_INTERNAL_REFER_SETUP, 0,
 				!!voltage_uv, 16);
-- 
1.7.7.1
