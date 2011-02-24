Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:gyro: adis16080 cleanup, move to abi and bug fixes.
Date: Thu, 24 Feb 2011 20:13:59 +0000
Message-Id: <1298578439-2080-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Much the same as teh adis16060 patch that preceeded it.

Moved to standard sysfs naming and got rid of direct register writing from
userspace.

The rx and tx buffers are never used together so just have one and avoid   
the need to malloc it by using putting it in the state structure and
using the ____cacheline_aligned trick.

Couple of obvious bug fixes whilst I was here.

I don't have one of these so can't test. This is done off datasheet.
Note that as with the adis16060 driver there are parts that definitely
wouldn't work before this patch.  Now it 'might' assuming I haven't
messed up too badly.

Would appreciate an Ack from someone at Analog.

I've been a little lazy and not tracked down all the scale / offset
values on the datasheet.  They can go in later.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

---
 drivers/staging/iio/gyro/adis16080.h      |   36 ---------
 drivers/staging/iio/gyro/adis16080_core.c |  113 ++++++++++++-----------------
 2 files changed, 47 insertions(+), 102 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16080.h b/drivers/staging/iio/gyro/adis16080.h
deleted file mode 100644
index f4e3851..0000000
--- a/drivers/staging/iio/gyro/adis16080.h
+++ /dev/null
@@ -1,36 +0,0 @@
-#ifndef SPI_ADIS16080_H_
-#define SPI_ADIS16080_H_
-
-/* Output data format setting. 0: Twos complement. 1: Offset binary. */
-#define ADIS16080_DIN_CODE   4
-#define ADIS16080_DIN_GYRO   (0 << 10) /* Gyroscope output */
-#define ADIS16080_DIN_TEMP   (1 << 10) /* Temperature output */
-#define ADIS16080_DIN_AIN1   (2 << 10)
-#define ADIS16080_DIN_AIN2   (3 << 10)
-
-/*
- * 1: Write contents on DIN to control register.
- * 0: No changes to control register.
- */
-
-#define ADIS16080_DIN_WRITE  (1 << 15)
-
-#define ADIS16080_MAX_TX     2
-#define ADIS16080_MAX_RX     2
-
-/**
- * struct adis16080_state - device instance specific data
- * @us:			actual spi_device to write data
- * @indio_dev:		industrial I/O device structure
- * @tx:			transmit buffer
- * @rx:			recieve buffer
- * @buf_lock:		mutex to protect tx and rx
- **/
-struct adis16080_state {
-	struct spi_device		*us;
-	struct iio_dev			*indio_dev;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
-};
-#endif /* SPI_ADIS16080_H_ */
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
index 252080b..fb4336c 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -5,9 +5,6 @@
  *
  * Licensed under the GPL-2 or later.
  */
-
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
@@ -16,14 +13,38 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
 #include "gyro.h"
 #include "../adc/adc.h"
 
-#include "adis16080.h"
+#define ADIS16080_DIN_GYRO   (0 << 10) /* Gyroscope output */
+#define ADIS16080_DIN_TEMP   (1 << 10) /* Temperature output */
+#define ADIS16080_DIN_AIN1   (2 << 10)
+#define ADIS16080_DIN_AIN2   (3 << 10)
+
+/*
+ * 1: Write contents on DIN to control register.
+ * 0: No changes to control register.
+ */
+
+#define ADIS16080_DIN_WRITE  (1 << 15)
+
+/**
+ * struct adis16080_state - device instance specific data
+ * @us:			actual spi_device to write data
+ * @indio_dev:		industrial I/O device structure
+ * @buf:		transmit or recieve buffer
+ * @buf_lock:		mutex to protect tx and rx
+ **/
+struct adis16080_state {
+	struct spi_device		*us;
+	struct iio_dev			*indio_dev;
+	struct mutex			buf_lock;
+
+	u8 buf[2] ____cacheline_aligned;
+};
 
 static int adis16080_spi_write(struct device *dev,
 		u16 val)
@@ -33,10 +54,10 @@ static int adis16080_spi_write(struct device *dev,
 	struct adis16080_state *st = iio_dev_get_devdata(indio_dev);
 
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = val >> 8;
-	st->tx[1] = val;
+	st->buf[0] = val >> 8;
+	st->buf[1] = val;
 
-	ret = spi_write(st->us, st->tx, 2);
+	ret = spi_write(st->us, st->buf, 2);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -51,10 +72,10 @@ static int adis16080_spi_read(struct device *dev,
 
 	mutex_lock(&st->buf_lock);
 
-	ret = spi_read(st->us, st->rx, 2);
+	ret = spi_read(st->us, st->buf, 2);
 
 	if (ret == 0)
-		*val = ((st->rx[0] & 0xF) << 8) | st->rx[1];
+		*val = ((st->buf[0] & 0xF) << 8) | st->buf[1];
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -64,13 +85,19 @@ static ssize_t adis16080_read(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	u16 val = 0;
 	ssize_t ret;
 
 	/* Take the iio_dev status lock */
 	mutex_lock(&indio_dev->mlock);
+	ret = adis16080_spi_write(dev,
+				  this_attr->address | ADIS16080_DIN_WRITE);
+	if (ret < 0)
+		goto error_ret;
 	ret =  adis16080_spi_read(dev, &val);
+error_ret:
 	mutex_unlock(&indio_dev->mlock);
 
 	if (ret == 0)
@@ -78,46 +105,18 @@ static ssize_t adis16080_read(struct device *dev,
 	else
 		return ret;
 }
-
-static ssize_t adis16080_write(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	int ret;
-	long val;
-
-	ret = strict_strtol(buf, 16, &val);
-	if (ret)
-		goto error_ret;
-	ret = adis16080_spi_write(dev, val);
-
-error_ret:
-	return ret ? ret : len;
-}
-
-#define IIO_DEV_ATTR_IN(_show)				\
-	IIO_DEVICE_ATTR(in, S_IRUGO, _show, NULL, 0)
-
-#define IIO_DEV_ATTR_OUT(_store)				\
-	IIO_DEVICE_ATTR(out, S_IRUGO, NULL, _store, 0)
-
-static IIO_DEV_ATTR_IN(adis16080_read);
-static IIO_DEV_ATTR_OUT(adis16080_write);
-
+static IIO_DEV_ATTR_GYRO_Z(adis16080_read, ADIS16080_DIN_GYRO);
+static IIO_DEVICE_ATTR(temp_raw, S_IRUGO, adis16080_read, NULL,
+		       ADIS16080_DIN_TEMP);
+static IIO_DEV_ATTR_IN_RAW(0, adis16080_read, ADIS16080_DIN_AIN1);
+static IIO_DEV_ATTR_IN_RAW(1, adis16080_read, ADIS16080_DIN_AIN2);
 static IIO_CONST_ATTR(name, "adis16080");
 
-static struct attribute *adis16080_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group adis16080_event_attribute_group = {
-	.attrs = adis16080_event_attributes,
-};
-
 static struct attribute *adis16080_attributes[] = {
-	&iio_dev_attr_in.dev_attr.attr,
-	&iio_dev_attr_out.dev_attr.attr,
+	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
+	&iio_dev_attr_temp_raw.dev_attr.attr,
+	&iio_dev_attr_in0_raw.dev_attr.attr,
+	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
 	NULL
 };
@@ -138,28 +137,16 @@ static int __devinit adis16080_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, st);
 
 	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16080_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16080_MAX_TX, GFP_KERNEL);
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
-	st->indio_dev->event_attrs = &adis16080_event_attribute_group;
 	st->indio_dev->attrs = &adis16080_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
@@ -177,10 +164,6 @@ error_free_dev:
 		iio_device_unregister(st->indio_dev);
 	else
 		iio_free_device(st->indio_dev);
-error_free_tx:
-	kfree(st->tx);
-error_free_rx:
-	kfree(st->rx);
 error_free_st:
 	kfree(st);
 error_ret:
@@ -194,8 +177,6 @@ static int adis16080_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = st->indio_dev;
 
 	iio_device_unregister(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
 	kfree(st);
 
 	return 0;
-- 
1.7.3.4
