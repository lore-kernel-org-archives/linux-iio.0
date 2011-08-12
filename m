Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/19] staging:iio:gyro:adis16130 drop control of adc resolution.
Date: Fri, 12 Aug 2011 17:08:41 +0100
Message-Id: <1313165333-3951-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
References: <1313165333-3951-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

There is no clear use case for this functionality in a driver
that only supports slow reading via sysfs. The interface
use was non compliant with the abi motiving it being dropped.

It can go back in if anyone ever implements buffered reading
support for this device.  Then it will be controlled as
part of the buffering abi where this should indeed be correctly
supported.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adis16130_core.c |   76 ++---------------------------
 1 files changed, 4 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index caf067c..6d3cd6c 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -41,34 +41,15 @@
 /**
  * struct adis16130_state - device instance specific data
  * @us:			actual spi_device to write data
- * @mode:		24 bits (1) or 16 bits (0)
  * @buf_lock:		mutex to protect tx and rx
  * @buf:		unified tx/rx buffer
  **/
 struct adis16130_state {
 	struct spi_device		*us;
-	u32                             mode;
 	struct mutex			buf_lock;
 	u8				buf[4] ____cacheline_aligned;
 };
 
-static int adis16130_spi_write(struct device *dev, u8 reg_addr,
-		u8 val)
-{
-	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16130_state *st = iio_priv(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->buf[0] = reg_addr;
-	st->buf[1] = val;
-
-	ret = spi_write(st->us, st->buf, 2);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
 static int adis16130_spi_read(struct device *dev, u8 reg_addr,
 		u32 *val)
 {
@@ -79,6 +60,7 @@ static int adis16130_spi_read(struct device *dev, u8 reg_addr,
 	struct spi_transfer xfer = {
 		.tx_buf = st->buf,
 		.rx_buf = st->buf,
+		.len = 4,
 	};
 
 	mutex_lock(&st->buf_lock);
@@ -86,22 +68,13 @@ static int adis16130_spi_read(struct device *dev, u8 reg_addr,
 	st->buf[0] = ADIS16130_CON_RD | reg_addr;
 	st->buf[1] = st->buf[2] = st->buf[3] = 0;
 
-	if (st->mode)
-		xfer.len = 4;
-	else
-		xfer.len = 3;
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfer, &msg);
 	ret = spi_sync(st->us, &msg);
-	if (ret == 0) {
-		if (st->mode)
-			*val = (st->buf[1] << 16) |
-				(st->buf[2] << 8) |
-				st->buf[3];
-		else
-			*val = (st->buf[1] << 8) | st->buf[2];
-	}
+	ret = spi_read(st->us, st->buf, 4);
 
+	if (ret == 0)
+		*val = (st->buf[1] << 16) | (st->buf[2] << 8) | st->buf[3];
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -127,54 +100,14 @@ static ssize_t adis16130_val_read(struct device *dev,
 		return ret;
 }
 
-static ssize_t adis16130_bitsmode_read(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16130_state *st = iio_priv(indio_dev);
-
-	if (st->mode == 1)
-		return sprintf(buf, "s24\n");
-	else
-		return sprintf(buf, "s16\n");
-}
-
-static ssize_t adis16130_bitsmode_write(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	int ret;
-	u8 val;
-
-	if (sysfs_streq(buf, "s16"))
-		val = 0;
-	else if (sysfs_streq(buf, "s24"))
-		val = 1;
-	else
-		return -EINVAL;
-
-	ret = adis16130_spi_write(dev, ADIS16130_MODE, val);
-
-	return ret ? ret : len;
-}
 static IIO_DEVICE_ATTR(temp_raw, S_IRUGO, adis16130_val_read, NULL,
 		      ADIS16130_TEMPDATA);
 
 static IIO_DEV_ATTR_GYRO_Z(adis16130_val_read, ADIS16130_RATEDATA);
 
-static IIO_DEVICE_ATTR(gyro_z_type, S_IWUSR | S_IRUGO, adis16130_bitsmode_read,
-			adis16130_bitsmode_write,
-			ADIS16130_MODE);
-
-static IIO_CONST_ATTR(gyro_z_type_available, "s16 s24");
-
 static struct attribute *adis16130_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_z_type.dev_attr.attr,
-	&iio_const_attr_gyro_z_type_available.dev_attr.attr,
 	NULL
 };
 
@@ -208,7 +141,6 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &adis16130_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	st->mode = 1;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-- 
1.7.3.4
