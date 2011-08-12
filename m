Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/12] staging:iio:gyro:adis16130 move to iio_chan_spec registration.
Date: Fri, 12 Aug 2011 17:47:59 +0100
Message-Id: <1313167683-11881-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
References: <1313167683-11881-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Simple conversion now we've dropped the type attributes.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adis16130_core.c |   57 +++++++++++++----------------
 1 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 6d3cd6c..5ddaefc 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -17,8 +17,6 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "gyro.h"
-#include "../adc/adc.h"
 
 #define ADIS16130_CON         0x0
 #define ADIS16130_CON_RD      (1 << 6)
@@ -50,11 +48,9 @@ struct adis16130_state {
 	u8				buf[4] ____cacheline_aligned;
 };
 
-static int adis16130_spi_read(struct device *dev, u8 reg_addr,
-		u32 *val)
+static int adis16130_spi_read(struct iio_dev *indio_dev, u8 reg_addr, u32 *val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16130_state *st = iio_priv(indio_dev);
 	struct spi_message msg;
 	struct spi_transfer xfer = {
@@ -80,43 +76,40 @@ static int adis16130_spi_read(struct device *dev, u8 reg_addr,
 	return ret;
 }
 
-static ssize_t adis16130_val_read(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int adis16130_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2,
+			      long mask)
 {
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	u32 val;
-	ssize_t ret;
+	int ret;
+	u32 temp;
 
 	/* Take the iio_dev status lock */
 	mutex_lock(&indio_dev->mlock);
-	ret =  adis16130_spi_read(dev, this_attr->address, &val);
+	ret =  adis16130_spi_read(indio_dev, chan->address, &temp);
 	mutex_unlock(&indio_dev->mlock);
-
-	if (ret == 0)
-		return sprintf(buf, "%d\n", val);
-	else
+	if (ret)
 		return ret;
+	*val = temp;
+	return IIO_VAL_INT;
 }
 
-static IIO_DEVICE_ATTR(temp_raw, S_IRUGO, adis16130_val_read, NULL,
-		      ADIS16130_TEMPDATA);
-
-static IIO_DEV_ATTR_GYRO_Z(adis16130_val_read, ADIS16130_RATEDATA);
-
-static struct attribute *adis16130_attributes[] = {
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group adis16130_attribute_group = {
-	.attrs = adis16130_attributes,
+static const struct iio_chan_spec adis16130_channels[] = {
+	{
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.address = ADIS16130_RATEDATA,
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.address = ADIS16130_TEMPDATA,
+	}
 };
 
 static const struct iio_info adis16130_info = {
-	.attrs = &adis16130_attribute_group,
+	.read_raw = &adis16130_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
@@ -138,6 +131,8 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	indio_dev->name = spi->dev.driver->name;
+	indio_dev->channels = adis16130_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adis16130_channels);
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16130_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
1.7.3.4
