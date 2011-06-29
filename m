Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47491 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab1F2Lnz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2011 07:43:55 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, ldewangan@nvidia.com,
	shubhrajyoti@ti.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/24] staging:iio:gyro:adis16080 convert to iio_chan_spec.
Date: Wed, 29 Jun 2011 12:51:38 +0100
Message-Id: <1309348316-7699-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
References: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a rare driver that is so simple it actually gets longer
as a result of this conversion.  Oh well, swings and roundabouts.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16080_core.c |   91 ++++++++++++++++-------------
 1 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index ad2db4d..7f9a346 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -16,8 +16,6 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "gyro.h"
-#include "../adc/adc.h"
 
 #define ADIS16080_DIN_GYRO   (0 << 10) /* Gyroscope output */
 #define ADIS16080_DIN_TEMP   (1 << 10) /* Temperature output */
@@ -44,11 +42,10 @@ struct adis16080_state {
 	u8 buf[2] ____cacheline_aligned;
 };
 
-static int adis16080_spi_write(struct device *dev,
+static int adis16080_spi_write(struct iio_dev *indio_dev,
 		u16 val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16080_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -61,11 +58,10 @@ static int adis16080_spi_write(struct device *dev,
 	return ret;
 }
 
-static int adis16080_spi_read(struct device *dev,
-		u16 *val)
+static int adis16080_spi_read(struct iio_dev *indio_dev,
+			      u16 *val)
 {
 	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16080_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
@@ -79,50 +75,62 @@ static int adis16080_spi_read(struct device *dev,
 	return ret;
 }
 
-static ssize_t adis16080_read(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int adis16080_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val,
+			     int *val2,
+			     long mask)
 {
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	u16 val = 0;
-	ssize_t ret;
-
+	int ret = -EINVAL;
+	u16 ut;
 	/* Take the iio_dev status lock */
+
 	mutex_lock(&indio_dev->mlock);
-	ret = adis16080_spi_write(dev,
-				  this_attr->address | ADIS16080_DIN_WRITE);
-	if (ret < 0)
-		goto error_ret;
-	ret =  adis16080_spi_read(dev, &val);
-error_ret:
+	switch (mask) {
+	case 0:
+		ret = adis16080_spi_write(indio_dev,
+					  chan->address |
+					  ADIS16080_DIN_WRITE);
+		if (ret < 0)
+			break;
+		ret = adis16080_spi_read(indio_dev, &ut);
+		if (ret < 0)
+			break;
+		*val = ut;
+		ret = IIO_VAL_INT;
+		break;
+	}
 	mutex_unlock(&indio_dev->mlock);
 
-	if (ret == 0)
-		return sprintf(buf, "%d\n", val);
-	else
-		return ret;
+	return ret;
 }
-static IIO_DEV_ATTR_GYRO_Z(adis16080_read, ADIS16080_DIN_GYRO);
-static IIO_DEVICE_ATTR(temp_raw, S_IRUGO, adis16080_read, NULL,
-		       ADIS16080_DIN_TEMP);
-static IIO_DEV_ATTR_IN_RAW(0, adis16080_read, ADIS16080_DIN_AIN1);
-static IIO_DEV_ATTR_IN_RAW(1, adis16080_read, ADIS16080_DIN_AIN2);
-
-static struct attribute *adis16080_attributes[] = {
-	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_in1_raw.dev_attr.attr,
-	NULL
-};
 
-static const struct attribute_group adis16080_attribute_group = {
-	.attrs = adis16080_attributes,
+static const struct iio_chan_spec adis16080_channels[] = {
+	{
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.address = ADIS16080_DIN_GYRO,
+	}, {
+		.type = IIO_IN,
+		.indexed = 1,
+		.channel = 0,
+		.address = ADIS16080_DIN_AIN1,
+	}, {
+		.type = IIO_IN,
+		.indexed = 1,
+		.channel = 1,
+		.address = ADIS16080_DIN_AIN2,
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.address = ADIS16080_DIN_TEMP,
+	}
 };
 
 static const struct iio_info adis16080_info = {
-	.attrs = &adis16080_attribute_group,
+	.read_raw = &adis16080_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
@@ -147,6 +155,7 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 	mutex_init(&st->buf_lock);
 
 	indio_dev->name = spi->dev.driver->name;
+	indio_dev->channels = adis16080_channels;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16080_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
1.7.3.4

