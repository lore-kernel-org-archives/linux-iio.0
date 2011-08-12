Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/12] staging:iio:gyro:adis16060 convert to iio_chan_spec
Date: Fri, 12 Aug 2011 17:48:00 +0100
Message-Id: <1313167683-11881-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
References: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Still a very odd driver. This patch has the side effect of changing
it's name slightly.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adis16060_core.c |  115 +++++++++++++++--------------
 1 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index afa52d1..0cbe677 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -14,11 +14,8 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
-
 #include "../iio.h"
 #include "../sysfs.h"
-#include "gyro.h"
-#include "../adc/adc.h"
 
 #define ADIS16060_GYRO		0x20 /* Measure Angular Rate (Gyro) */
 #define ADIS16060_TEMP_OUT	0x10 /* Measure Temperature */
@@ -42,11 +39,9 @@ struct adis16060_state {
 
 static struct iio_dev *adis16060_iio_dev;
 
-static int adis16060_spi_write(struct device *dev,
-		u8 val)
+static int adis16060_spi_write(struct iio_dev *indio_dev, u8 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16060_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -57,11 +52,9 @@ static int adis16060_spi_write(struct device *dev,
 	return ret;
 }
 
-static int adis16060_spi_read(struct device *dev,
-		u16 *val)
+static int adis16060_spi_read(struct iio_dev *indio_dev, u16 *val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16060_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -82,60 +75,71 @@ static int adis16060_spi_read(struct device *dev,
 	return ret;
 }
 
-static ssize_t adis16060_read(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int adis16060_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
 {
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	u16 val = 0;
-	ssize_t ret;
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
+	u16 tval = 0;
+	int ret;
 
-	ret = adis16060_spi_write(dev, this_attr->address);
-	if (ret < 0)
-		goto error_ret;
-	ret = adis16060_spi_read(dev, &val);
-error_ret:
-	mutex_unlock(&indio_dev->mlock);
+	switch (mask) {
+	case 0:
+		/* Take the iio_dev status lock */
+		mutex_lock(&indio_dev->mlock);
+		ret = adis16060_spi_write(indio_dev, chan->address);
+		if (ret < 0) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+		ret = adis16060_spi_read(indio_dev, &tval);
+		mutex_unlock(&indio_dev->mlock);
+		*val = tval;
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+		*val = -7;
+		*val2 = 461117;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		*val = 0;
+		*val2 = 34000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
 
-	if (ret == 0)
-		return sprintf(buf, "%d\n", val);
-	else
-		return ret;
+	return -EINVAL;
 }
 
-static IIO_DEV_ATTR_GYRO_Z(adis16060_read, ADIS16060_GYRO);
-static IIO_DEVICE_ATTR(temp_raw, S_IRUGO, adis16060_read, NULL,
-		       ADIS16060_TEMP_OUT);
-static IIO_CONST_ATTR_TEMP_SCALE("34"); /* Milli degrees C */
-static IIO_CONST_ATTR_TEMP_OFFSET("-7461.117"); /* Milli degrees C */
-static IIO_DEV_ATTR_IN_RAW(0, adis16060_read, ADIS16060_AIN1);
-static IIO_DEV_ATTR_IN_RAW(1, adis16060_read, ADIS16060_AIN2);
-static IIO_CONST_ATTR(name, "adis16060");
-
-static struct attribute *adis16060_attributes[] = {
-	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group adis16060_attribute_group = {
-	.attrs = adis16060_attributes,
-};
-
 static const struct iio_info adis16060_info = {
-	.attrs = &adis16060_attribute_group,
+	.read_raw = &adis16060_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
+static const struct iio_chan_spec adis16060_channels[] = {
+	{
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.address = ADIS16060_GYRO,
+	}, {
+		.type = IIO_IN,
+		.indexed = 1,
+		.channel = 0,
+		.address = ADIS16060_AIN1,
+	}, {
+		.type = IIO_IN,
+		.indexed = 1,
+		.channel = 1,
+		.address = ADIS16060_AIN2,
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		.address = ADIS16060_TEMP_OUT,
+	}
+};
+
 static int __devinit adis16060_r_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -154,9 +158,12 @@ static int __devinit adis16060_r_probe(struct spi_device *spi)
 	st->us_r = spi;
 	mutex_init(&st->buf_lock);
 
+	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16060_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adis16060_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16060_channels);
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-- 
1.7.3.4
