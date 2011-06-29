Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47488 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435Ab1F2Ln4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2011 07:43:56 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, ldewangan@nvidia.com,
	shubhrajyoti@ti.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/24] staging:iio:gyro:adxrs450 move to iio_chan_spec registration
Date: Wed, 29 Jun 2011 12:51:35 +0100
Message-Id: <1309348316-7699-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
References: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adxrs450_core.c |  173 ++++++++++++++++++------------
 1 files changed, 102 insertions(+), 71 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 7502a26..a756262 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -20,7 +20,6 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "gyro.h"
 #include "../adc/adc.h"
 
 #include "adxrs450.h"
@@ -32,12 +31,11 @@
  * Second register's address is reg_address + 1.
  * @val: somewhere to pass back the value read
  **/
-static int adxrs450_spi_read_reg_16(struct device *dev,
-		u8 reg_address,
-		u16 *val)
+static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
+				    u8 reg_address,
+				    u16 *val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adxrs450_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
@@ -86,12 +84,11 @@ error_ret:
  * Second register's address is reg_address + 1.
  * @val: value to be written.
  **/
-static int adxrs450_spi_write_reg_16(struct device *dev,
-		u8 reg_address,
-		u16 val)
+static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
+				     u8 reg_address,
+				     u16 val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adxrs450_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers = {
@@ -126,10 +123,9 @@ static int adxrs450_spi_write_reg_16(struct device *dev,
  * @dev: device associated with child of actual iio_dev
  * @val: somewhere to pass back the value read
  **/
-static int adxrs450_spi_sensor_data(struct device *dev, s16 *val)
+static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
 {
 	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adxrs450_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
@@ -206,64 +202,39 @@ error_ret:
 	return ret;
 }
 
-static ssize_t adxrs450_read_temp(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int adxrs450_read_temp(struct iio_dev *indio_dev, int *val)
 {
 	int ret;
 	u16 t;
-	ret = adxrs450_spi_read_reg_16(dev,
-			ADXRS450_TEMP1,
-			&t);
+	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_TEMP1, &t);
 	if (ret)
 		return ret;
-	return sprintf(buf, "%d\n", t >> 7);
+	*val = t;
+	return 0;
 }
 
-static ssize_t adxrs450_read_quad(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int adxrs450_read_quad(struct iio_dev *indio_dev, int *val)
 {
 	int ret;
 	s16 t;
-	ret = adxrs450_spi_read_reg_16(dev,
-			ADXRS450_QUAD1,
-			&t);
+	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_QUAD1, &t);
 	if (ret)
 		return ret;
-	return sprintf(buf, "%d\n", t);
-}
-
-static ssize_t adxrs450_write_dnc(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	int ret;
-	long val;
-
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-	ret = adxrs450_spi_write_reg_16(dev,
-			ADXRS450_DNC1,
-			val & 0x3FF);
-error_ret:
-	return ret ? ret : len;
+	*val = t;
+	return 0;
 }
 
-static ssize_t adxrs450_read_sensor_data(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static int adxrs450_read_sensor_data(struct iio_dev *indio_dev, int *val)
 {
 	int ret;
 	s16 t;
 
-	ret = adxrs450_spi_sensor_data(dev, &t);
+	ret = adxrs450_spi_sensor_data(indio_dev, &t);
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%d\n", t);
+	*val = t;
+	return 0;
 }
 
 /* Recommended Startup Sequence by spec */
@@ -272,7 +243,6 @@ static int adxrs450_initial_setup(struct iio_dev *indio_dev)
 	u32 t;
 	u16 data;
 	int ret;
-	struct device *dev = &indio_dev->dev;
 	struct adxrs450_state *st = iio_priv(indio_dev);
 
 	msleep(ADXRS450_STARTUP_DELAY*2);
@@ -305,23 +275,23 @@ static int adxrs450_initial_setup(struct iio_dev *indio_dev)
 		return -EIO;
 
 	}
-	ret = adxrs450_spi_read_reg_16(dev, ADXRS450_FAULT1, &data);
+	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_FAULT1, &data);
 	if (ret)
 		return ret;
 	if (data & 0x0fff) {
 		dev_err(&st->us->dev, "The device is not in normal status!\n");
 		return -EINVAL;
 	}
-	ret = adxrs450_spi_read_reg_16(dev, ADXRS450_PID1, &data);
+	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_PID1, &data);
 	if (ret)
 		return ret;
 	dev_info(&st->us->dev, "The Part ID is 0x%x\n", data);
 
-	ret = adxrs450_spi_read_reg_16(dev, ADXRS450_SNL, &data);
+	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_SNL, &data);
 	if (ret)
 		return ret;
 	t = data;
-	ret = adxrs450_spi_read_reg_16(dev, ADXRS450_SNH, &data);
+	ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_SNH, &data);
 	if (ret)
 		return ret;
 	t |= data << 16;
@@ -330,29 +300,88 @@ static int adxrs450_initial_setup(struct iio_dev *indio_dev)
 	return 0;
 }
 
-static IIO_DEV_ATTR_GYRO_Z(adxrs450_read_sensor_data, 0);
-static IIO_DEV_ATTR_TEMP_RAW(adxrs450_read_temp);
-static IIO_DEV_ATTR_GYRO_Z_QUADRATURE_CORRECTION(adxrs450_read_quad, 0);
-static IIO_DEV_ATTR_GYRO_Z_CALIBBIAS(S_IWUSR,
-		NULL, adxrs450_write_dnc, 0);
-static IIO_CONST_ATTR(name, "adxrs450");
-
-static struct attribute *adxrs450_attributes[] = {
-	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_z_quadrature_correction_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_z_calibbias.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
-	NULL
-};
+static int adxrs450_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val,
+			      int val2,
+			      long mask)
+{
+	int ret;
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		ret = adxrs450_spi_write_reg_16(indio_dev,
+						ADXRS450_DNC1,
+						val & 0x3FF);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int adxrs450_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val,
+			     int *val2,
+			     long mask)
+{
+	int ret;
+	switch (mask) {
+	case 0:
+		switch (chan->type) {
+		case IIO_GYRO:
+			ret = adxrs450_read_sensor_data(indio_dev, val);
+			if (ret < 0)
+				break;
+			*val = ret;
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_TEMP:
+			ret = adxrs450_read_temp(indio_dev, val);
+			if (ret < 0)
+				break;
+			*val = ret;
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	case (1 << IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE):
+		ret = adxrs450_read_quad(indio_dev, val);
+		if (ret < 0)
+			break;
+		*val = ret;
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
 
-static const struct attribute_group adxrs450_attribute_group = {
-	.attrs = adxrs450_attributes,
+static const struct iio_chan_spec adxrs450_channels[] = {
+	{
+		.type = IIO_GYRO,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE)
+	}, {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+	}
 };
 
 static const struct iio_info adxrs450_info = {
-	.attrs = &adxrs450_attribute_group,
 	.driver_module = THIS_MODULE,
+	.read_raw = &adxrs450_read_raw,
+	.write_raw = &adxrs450_write_raw,
 };
 
 static int __devinit adxrs450_probe(struct spi_device *spi)
@@ -376,6 +405,8 @@ static int __devinit adxrs450_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adxrs450_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adxrs450_channels;
+	indio_dev->name = spi->dev.driver->name;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-- 
1.7.3.4

