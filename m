Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:gyro: adis16130 cleanup, move to abi and bug fixes.
Date: Fri, 25 Feb 2011 17:45:31 +0000
Message-Id: <1298655931-16896-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16130.h      |   42 --------
 drivers/staging/iio/gyro/adis16130_core.c |  148 +++++++++++++---------------
 2 files changed, 69 insertions(+), 121 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16130.h b/drivers/staging/iio/gyro/adis16130.h
deleted file mode 100644
index 9efc4c7..0000000
--- a/drivers/staging/iio/gyro/adis16130.h
+++ /dev/null
@@ -1,42 +0,0 @@
-#ifndef SPI_ADIS16130_H_
-#define SPI_ADIS16130_H_
-
-#define ADIS16130_CON         0x0
-#define ADIS16130_CON_RD      (1 << 6)
-#define ADIS16130_IOP         0x1
-
-/* 1 = data-ready signal low when unread data on all channels; */
-#define ADIS16130_IOP_ALL_RDY (1 << 3)
-#define ADIS16130_IOP_SYNC    (1 << 0) /* 1 = synchronization enabled */
-#define ADIS16130_RATEDATA    0x8 /* Gyroscope output, rate of rotation */
-#define ADIS16130_TEMPDATA    0xA /* Temperature output */
-#define ADIS16130_RATECS      0x28 /* Gyroscope channel setup */
-#define ADIS16130_RATECS_EN   (1 << 3) /* 1 = channel enable; */
-#define ADIS16130_TEMPCS      0x2A /* Temperature channel setup */
-#define ADIS16130_TEMPCS_EN   (1 << 3)
-#define ADIS16130_RATECONV    0x30
-#define ADIS16130_TEMPCONV    0x32
-#define ADIS16130_MODE        0x38
-#define ADIS16130_MODE_24BIT  (1 << 1) /* 1 = 24-bit resolution; */
-
-#define ADIS16130_MAX_TX     4
-#define ADIS16130_MAX_RX     4
-
-/**
- * struct adis16130_state - device instance specific data
- * @us:			actual spi_device to write data
- * @indio_dev:		industrial I/O device structure
- * @tx:			transmit buffer
- * @rx:			recieve buffer
- * @buf_lock:		mutex to protect tx and rx
- **/
-struct adis16130_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	u8				*tx;
-	u8				*rx;
-	u32                             mode; /* 1: 24bits mode 0:16bits mode */
-	struct mutex			buf_lock;
-};
-
-#endif /* SPI_ADIS16130_H_ */
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 04d81d4..70e2831 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -6,9 +6,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
@@ -23,7 +20,39 @@
 #include "gyro.h"
 #include "../adc/adc.h"
 
-#include "adis16130.h"
+#define ADIS16130_CON         0x0
+#define ADIS16130_CON_RD      (1 << 6)
+#define ADIS16130_IOP         0x1
+
+/* 1 = data-ready signal low when unread data on all channels; */
+#define ADIS16130_IOP_ALL_RDY (1 << 3)
+#define ADIS16130_IOP_SYNC    (1 << 0) /* 1 = synchronization enabled */
+#define ADIS16130_RATEDATA    0x8 /* Gyroscope output, rate of rotation */
+#define ADIS16130_TEMPDATA    0xA /* Temperature output */
+#define ADIS16130_RATECS      0x28 /* Gyroscope channel setup */
+#define ADIS16130_RATECS_EN   (1 << 3) /* 1 = channel enable; */
+#define ADIS16130_TEMPCS      0x2A /* Temperature channel setup */
+#define ADIS16130_TEMPCS_EN   (1 << 3)
+#define ADIS16130_RATECONV    0x30
+#define ADIS16130_TEMPCONV    0x32
+#define ADIS16130_MODE        0x38
+#define ADIS16130_MODE_24BIT  (1 << 1) /* 1 = 24-bit resolution; */
+
+/**
+ * struct adis16130_state - device instance specific data
+ * @us:			actual spi_device to write data
+ * @indio_dev:		industrial I/O device structure
+ * @mode:		24 bits (1) or 16 bits (0)
+ * @buf_lock:		mutex to protect tx and rx
+ * @buf:		unified tx/rx buffer
+ **/
+struct adis16130_state {
+	struct spi_device		*us;
+	struct iio_dev			*indio_dev;
+	u32                             mode;
+	struct mutex			buf_lock;
+	u8				buf[4] ____cacheline_aligned;
+};
 
 static int adis16130_spi_write(struct device *dev, u8 reg_addr,
 		u8 val)
@@ -33,10 +62,10 @@ static int adis16130_spi_write(struct device *dev, u8 reg_addr,
 	struct adis16130_state *st = iio_dev_get_devdata(indio_dev);
 
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = reg_addr;
-	st->tx[1] = val;
+	st->buf[0] = reg_addr;
+	st->buf[1] = val;
 
-	ret = spi_write(st->us, st->tx, 2);
+	ret = spi_write(st->us, st->buf, 2);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -51,17 +80,19 @@ static int adis16130_spi_read(struct device *dev, u8 reg_addr,
 
 	mutex_lock(&st->buf_lock);
 
-	st->tx[0] = ADIS16130_CON_RD | reg_addr;
+	st->buf[0] = ADIS16130_CON_RD | reg_addr;
 	if (st->mode)
-		ret = spi_read(st->us, st->rx, 4);
+		ret = spi_read(st->us, st->buf, 4);
 	else
-		ret = spi_read(st->us, st->rx, 3);
+		ret = spi_read(st->us, st->buf, 3);
 
 	if (ret == 0) {
 		if (st->mode)
-			*val = (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
+			*val = (st->buf[1] << 16) |
+				(st->buf[2] << 8) |
+				st->buf[3];
 		else
-			*val = (st->rx[1] << 8) | st->rx[2];
+			*val = (st->buf[1] << 8) | st->buf[2];
 	}
 
 	mutex_unlock(&st->buf_lock);
@@ -69,36 +100,18 @@ static int adis16130_spi_read(struct device *dev, u8 reg_addr,
 	return ret;
 }
 
-static ssize_t adis16130_gyro_read(struct device *dev,
+static ssize_t adis16130_val_read(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	u32 val;
 	ssize_t ret;
 
 	/* Take the iio_dev status lock */
 	mutex_lock(&indio_dev->mlock);
-	ret =  adis16130_spi_read(dev, ADIS16130_RATEDATA, &val);
-	mutex_unlock(&indio_dev->mlock);
-
-	if (ret == 0)
-		return sprintf(buf, "%d\n", val);
-	else
-		return ret;
-}
-
-static ssize_t adis16130_temp_read(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	u32 val;
-	ssize_t ret;
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-	ret =  adis16130_spi_read(dev, ADIS16130_TEMPDATA, &val);
+	ret =  adis16130_spi_read(dev, this_attr->address, &val);
 	mutex_unlock(&indio_dev->mlock);
 
 	if (ret == 0)
@@ -114,7 +127,10 @@ static ssize_t adis16130_bitsmode_read(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16130_state *st = iio_dev_get_devdata(indio_dev);
 
-	return sprintf(buf, "%d\n", st->mode);
+	if (st->mode == 1)
+		return sprintf(buf, "s24\n");
+	else
+		return sprintf(buf, "s16\n");
 }
 
 static ssize_t adis16130_bitsmode_write(struct device *dev,
@@ -123,44 +139,38 @@ static ssize_t adis16130_bitsmode_write(struct device *dev,
 		size_t len)
 {
 	int ret;
-	long val;
+	u8 val;
 
-	ret = strict_strtol(buf, 16, &val);
-	if (ret)
-		goto error_ret;
-	ret = adis16130_spi_write(dev, ADIS16130_MODE, !!val);
+	if (sysfs_streq(buf, "s16"))
+		val = 0;
+	else if (sysfs_streq(buf, "s24"))
+		val = 1;
+	else
+		return -EINVAL;
+
+	ret = adis16130_spi_write(dev, ADIS16130_MODE, val);
 
-error_ret:
 	return ret ? ret : len;
 }
-
-static IIO_DEV_ATTR_TEMP_RAW(adis16130_temp_read);
+static IIO_DEVICE_ATTR(temp_raw, S_IRUGO, adis16130_val_read, NULL,
+		      ADIS16130_TEMPDATA);
 
 static IIO_CONST_ATTR(name, "adis16130");
 
-static IIO_DEV_ATTR_GYRO(adis16130_gyro_read,
-		ADIS16130_RATEDATA);
-
-#define IIO_DEV_ATTR_BITS_MODE(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(bits_mode, _mode, _show, _store, _addr)
+static IIO_DEV_ATTR_GYRO_Z(adis16130_val_read, ADIS16130_RATEDATA);
 
-static IIO_DEV_ATTR_BITS_MODE(S_IWUSR | S_IRUGO, adis16130_bitsmode_read,
+static IIO_DEVICE_ATTR(gyro_z_type, S_IWUSR | S_IRUGO, adis16130_bitsmode_read,
 			adis16130_bitsmode_write,
 			ADIS16130_MODE);
 
-static struct attribute *adis16130_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group adis16130_event_attribute_group = {
-	.attrs = adis16130_event_attributes,
-};
+static IIO_CONST_ATTR(gyro_z_type_available, "s16 s24");
 
 static struct attribute *adis16130_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
-	&iio_dev_attr_gyro_raw.dev_attr.attr,
-	&iio_dev_attr_bits_mode.dev_attr.attr,
+	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
+	&iio_dev_attr_gyro_z_type.dev_attr.attr,
+	&iio_const_attr_gyro_z_type_available.dev_attr.attr,
 	NULL
 };
 
@@ -178,30 +188,16 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 	}
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, st);
-
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16130_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16130_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_rx;
-	}
 	st->us = spi;
 	mutex_init(&st->buf_lock);
 	/* setup the industrialio driver allocated elements */
 	st->indio_dev = iio_allocate_device();
 	if (st->indio_dev == NULL) {
 		ret = -ENOMEM;
-		goto error_free_tx;
+		goto error_free_st;
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &adis16130_event_attribute_group;
 	st->indio_dev->attrs = &adis16130_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
@@ -216,10 +212,6 @@ static int __devinit adis16130_probe(struct spi_device *spi)
 
 error_free_dev:
 	iio_free_device(st->indio_dev);
-error_free_tx:
-	kfree(st->tx);
-error_free_rx:
-	kfree(st->rx);
 error_free_st:
 	kfree(st);
 error_ret:
@@ -233,8 +225,6 @@ static int adis16130_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = st->indio_dev;
 
 	iio_device_unregister(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
 	kfree(st);
 
 	return 0;
@@ -262,5 +252,5 @@ static __exit void adis16130_exit(void)
 module_exit(adis16130_exit);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices ADIS16130 High Precision Angular Rate Sensor driver");
+MODULE_DESCRIPTION("Analog Devices ADIS16130 High Precision Angular Rate");
 MODULE_LICENSE("GPL v2");
-- 
1.7.3.4
