Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:gyro: adis16060 cleanup, move to abi and bug fixes.
Date: Thu, 24 Feb 2011 19:42:41 +0000
Message-Id: <1298576561-17813-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Moved to standard sysfs naming and got rid of direct register writing from
userspace.       

The rx and tx buffers are never used together so just have one and avoid   
the need to malloc it by using putting it in the state structure and
using the ____cacheline_aligned trick.

A number of obvious bugs also fixed and correction of register address
defines in header which has now been squashed into the driver.

I don't have one of these so can't test. This is done off datasheet.
Note that the driver had parts that definitely wouldn't work before
this patch.  Now it 'might' assuming I haven't messed up too badly.

Would appreciate an Ack from someone at Analog.

I've left fixing the fact that you can only have one of these on a given
machine for another day.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16060.h      |   31 -------
 drivers/staging/iio/gyro/adis16060_core.c |  125 +++++++++++-----------------
 2 files changed, 49 insertions(+), 107 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16060.h b/drivers/staging/iio/gyro/adis16060.h
deleted file mode 100644
index e85121b..0000000
--- a/drivers/staging/iio/gyro/adis16060.h
+++ /dev/null
@@ -1,31 +0,0 @@
-#ifndef SPI_ADIS16060_H_
-#define SPI_ADIS16060_H_
-
-#define ADIS16060_GYRO       0x20 /* Measure Angular Rate (Gyro) */
-#define ADIS16060_SUPPLY_OUT 0x10 /* Measure Temperature */
-#define ADIS16060_AIN2       0x80 /* Measure AIN2 */
-#define ADIS16060_AIN1       0x40 /* Measure AIN1 */
-#define ADIS16060_TEMP_OUT   0x22 /* Set Positive Self-Test and Output for Angular Rate */
-#define ADIS16060_ANGL_OUT   0x21 /* Set Negative Self-Test and Output for Angular Rate */
-
-#define ADIS16060_MAX_TX     3
-#define ADIS16060_MAX_RX     3
-
-/**
- * struct adis16060_state - device instance specific data
- * @us_w:			actual spi_device to write data
- * @indio_dev:		industrial I/O device structure
- * @tx:			transmit buffer
- * @rx:			recieve buffer
- * @buf_lock:		mutex to protect tx and rx
- **/
-struct adis16060_state {
-	struct spi_device		*us_w;
-	struct spi_device		*us_r;
-	struct iio_dev			*indio_dev;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
-};
-
-#endif /* SPI_ADIS16060_H_ */
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
index 11f51f2..700eb39 100644
--- a/drivers/staging/iio/gyro/adis16060_core.c
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -6,9 +6,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
@@ -16,14 +13,34 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
+
 
 #include "../iio.h"
 #include "../sysfs.h"
 #include "gyro.h"
 #include "../adc/adc.h"
 
-#include "adis16060.h"
+#define ADIS16060_GYRO		0x20 /* Measure Angular Rate (Gyro) */
+#define ADIS16060_TEMP_OUT	0x10 /* Measure Temperature */
+#define ADIS16060_AIN2		0x80 /* Measure AIN2 */
+#define ADIS16060_AIN1		0x40 /* Measure AIN1 */
+
+/**
+ * struct adis16060_state - device instance specific data
+ * @us_w:		actual spi_device to write config
+ * @us_r:		actual spi_device to read back data
+ * @indio_dev:		industrial I/O device structure
+ * @buf:		transmit or recieve buffer
+ * @buf_lock:		mutex to protect tx and rx
+ **/
+struct adis16060_state {
+	struct spi_device		*us_w;
+	struct spi_device		*us_r;
+	struct iio_dev			*indio_dev;
+	struct mutex			buf_lock;
+
+	u8 buf[3] ____cacheline_aligned;
+};
 
 static struct adis16060_state *adis16060_st;
 
@@ -35,11 +52,8 @@ static int adis16060_spi_write(struct device *dev,
 	struct adis16060_state *st = iio_dev_get_devdata(indio_dev);
 
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = 0;
-	st->tx[1] = 0;
-	st->tx[2] = val; /* The last 8 bits clocked in are latched */
-
-	ret = spi_write(st->us_w, st->tx, 3);
+	st->buf[2] = val; /* The last 8 bits clocked in are latched */
+	ret = spi_write(st->us_w, st->buf, 3);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -54,7 +68,7 @@ static int adis16060_spi_read(struct device *dev,
 
 	mutex_lock(&st->buf_lock);
 
-	ret = spi_read(st->us_r, st->rx, 3);
+	ret = spi_read(st->us_r, st->buf, 3);
 
 	/* The internal successive approximation ADC begins the
 	 * conversion process on the falling edge of MSEL1 and
@@ -62,9 +76,9 @@ static int adis16060_spi_read(struct device *dev,
 	 * the 6th falling edge of SCLK
 	 */
 	if (ret == 0)
-		*val = ((st->rx[0] & 0x3) << 12) |
-			(st->rx[1] << 4) |
-			((st->rx[2] >> 4) & 0xF);
+		*val = ((st->buf[0] & 0x3) << 12) |
+			(st->buf[1] << 4) |
+			((st->buf[2] >> 4) & 0xF);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -74,13 +88,19 @@ static ssize_t adis16060_read(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	u16 val = 0;
 	ssize_t ret;
 
 	/* Take the iio_dev status lock */
 	mutex_lock(&indio_dev->mlock);
-	ret =  adis16060_spi_read(dev, &val);
+
+	ret = adis16060_spi_write(dev, this_attr->address);
+	if (ret < 0)
+		goto error_ret;
+	ret = adis16060_spi_read(dev, &val);
+error_ret:
 	mutex_unlock(&indio_dev->mlock);
 
 	if (ret == 0)
@@ -89,45 +109,22 @@ static ssize_t adis16060_read(struct device *dev,
 		return ret;
 }
 
-static ssize_t adis16060_write(struct device *dev,
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
-	ret = adis16060_spi_write(dev, val);
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
-static IIO_DEV_ATTR_IN(adis16060_read);
-static IIO_DEV_ATTR_OUT(adis16060_write);
-
+static IIO_DEV_ATTR_GYRO_Z(adis16060_read, ADIS16060_GYRO);
+static IIO_DEVICE_ATTR(temp_raw, S_IRUGO, adis16060_read, NULL,
+		       ADIS16060_TEMP_OUT);
+static IIO_CONST_ATTR_TEMP_SCALE("34"); /* Milli degrees C */
+static IIO_CONST_ATTR_TEMP_OFFSET("-7461.117"); /* Milli degrees C */
+static IIO_DEV_ATTR_IN_RAW(0, adis16060_read, ADIS16060_AIN1);
+static IIO_DEV_ATTR_IN_RAW(1, adis16060_read, ADIS16060_AIN2);
 static IIO_CONST_ATTR(name, "adis16060");
 
-static struct attribute *adis16060_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group adis16060_event_attribute_group = {
-	.attrs = adis16060_event_attributes,
-};
-
 static struct attribute *adis16060_attributes[] = {
-	&iio_dev_attr_in.dev_attr.attr,
-	&iio_dev_attr_out.dev_attr.attr,
+	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
+	&iio_dev_attr_temp_raw.dev_attr.attr,
+	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_const_attr_temp_offset.dev_attr.attr,
+	&iio_dev_attr_in0_raw.dev_attr.attr,
+	&iio_dev_attr_in1_raw.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
 	NULL
 };
@@ -147,29 +144,16 @@ static int __devinit adis16060_r_probe(struct spi_device *spi)
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, st);
 
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16060_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16060_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_rx;
-	}
 	st->us_r = spi;
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
-	st->indio_dev->event_attrs = &adis16060_event_attribute_group;
 	st->indio_dev->attrs = &adis16060_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
@@ -188,10 +172,6 @@ error_free_dev:
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
@@ -204,14 +184,7 @@ static int adis16060_r_remove(struct spi_device *spi)
 	struct adis16060_state *st = spi_get_drvdata(spi);
 	struct iio_dev *indio_dev = st->indio_dev;
 
-	flush_scheduled_work();
-
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
 	iio_device_unregister(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
 	kfree(st);
 
 	return 0;
-- 
1.7.3.4
