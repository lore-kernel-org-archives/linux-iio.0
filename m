Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Barry Song <barry.song@analog.com>
Subject: [PATCH 02/19] staging: iio: gyro: new driver ADIS16060 digital output gyros
Date: Sat, 23 Oct 2010 17:53:46 -0400
Message-Id: <1287870843-19835-2-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287870843-19835-1-git-send-email-vapier@gentoo.org>
References: <1287870843-19835-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <barry.song@analog.com>

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/gyro/Kconfig          |    7 +
 drivers/staging/iio/gyro/Makefile         |    3 +
 drivers/staging/iio/gyro/adis16060.h      |  101 +++++++++
 drivers/staging/iio/gyro/adis16060_core.c |  319 +++++++++++++++++++++++++++++
 4 files changed, 430 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/gyro/adis16060.h
 create mode 100644 drivers/staging/iio/gyro/adis16060_core.c

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index c463351..d34410b 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -3,6 +3,13 @@
 #
 comment "Digital gyroscope sensors"
 
+config ADIS16060
+	tristate "Analog Devices ADIS16060 Yaw Rate Gyroscope with SPI driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices adis16060 wide bandwidth
+	  yaw rate gyroscope with SPI.
+
 config ADIS16260
 	tristate "Analog Devices ADIS16260/5 Digital Gyroscope Sensor SPI driver"
 	depends on SPI
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index ce4aba5..7b3b478 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -2,6 +2,9 @@
 # Makefile for digital gyroscope sensor drivers
 #
 
+adis16060-y             := adis16060_core.o
+obj-$(CONFIG_ADIS16060) += adis16060.o
+
 adis16260-y             := adis16260_core.o
 adis16260-$(CONFIG_IIO_RING_BUFFER) += adis16260_ring.o adis16260_trigger.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
diff --git a/drivers/staging/iio/gyro/adis16060.h b/drivers/staging/iio/gyro/adis16060.h
new file mode 100644
index 0000000..22b564b
--- /dev/null
+++ b/drivers/staging/iio/gyro/adis16060.h
@@ -0,0 +1,101 @@
+#ifndef SPI_ADIS16060_H_
+#define SPI_ADIS16060_H_
+
+#define ADIS16060_GYRO       0x20 /* Measure Angular Rate (Gyro) */
+#define ADIS16060_SUPPLY_OUT 0x10 /* Measure Temperature */
+#define ADIS16060_AIN2       0x80 /* Measure AIN2 */
+#define ADIS16060_AIN1       0x40 /* Measure AIN1 */
+#define ADIS16060_TEMP_OUT   0x22 /* Set Positive Self-Test and Output for Angular Rate */
+#define ADIS16060_ANGL_OUT   0x21 /* Set Negative Self-Test and Output for Angular Rate */
+
+#define ADIS16060_MAX_TX     3
+#define ADIS16060_MAX_RX     3
+
+/**
+ * struct adis16060_state - device instance specific data
+ * @us_w:			actual spi_device to write data
+ * @work_trigger_to_ring: bh for triggered event handling
+ * @inter:		used to check if new interrupt has been triggered
+ * @last_timestamp:	passing timestamp from th to bh of interrupt handler
+ * @indio_dev:		industrial I/O device structure
+ * @trig:		data ready trigger registered with iio
+ * @tx:			transmit buffer
+ * @rx:			recieve buffer
+ * @buf_lock:		mutex to protect tx and rx
+ **/
+struct adis16060_state {
+	struct spi_device		*us_w;
+	struct spi_device		*us_r;
+	struct work_struct		work_trigger_to_ring;
+	s64				last_timestamp;
+	struct iio_dev			*indio_dev;
+	struct iio_trigger		*trig;
+	u8				*tx;
+	u8				*rx;
+	struct mutex			buf_lock;
+};
+
+#ifdef CONFIG_IIO_RING_BUFFER
+/* At the moment triggers are only used for ring buffer
+ * filling. This may change!
+ */
+
+enum adis16060_scan {
+	ADIS16060_SCAN_GYRO,
+	ADIS16060_SCAN_TEMP,
+	ADIS16060_SCAN_ADC_1,
+	ADIS16060_SCAN_ADC_2,
+};
+
+void adis16060_remove_trigger(struct iio_dev *indio_dev);
+int adis16060_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t adis16060_read_data_from_ring(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf);
+
+
+int adis16060_configure_ring(struct iio_dev *indio_dev);
+void adis16060_unconfigure_ring(struct iio_dev *indio_dev);
+
+int adis16060_initialize_ring(struct iio_ring_buffer *ring);
+void adis16060_uninitialize_ring(struct iio_ring_buffer *ring);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void adis16060_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16060_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline ssize_t
+adis16060_read_data_from_ring(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return 0;
+}
+
+static int adis16060_configure_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void adis16060_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16060_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return 0;
+}
+
+static inline void adis16060_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+}
+
+#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* SPI_ADIS16060_H_ */
diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
new file mode 100644
index 0000000..fc48aca
--- /dev/null
+++ b/drivers/staging/iio/gyro/adis16060_core.c
@@ -0,0 +1,319 @@
+/*
+ * ADIS16060 Wide Bandwidth Yaw Rate Gyroscope with SPI driver
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "gyro.h"
+#include "../adc/adc.h"
+
+#include "adis16060.h"
+
+#define DRIVER_NAME		"adis16060"
+
+struct adis16060_state *adis16060_st;
+
+int adis16060_spi_write(struct device *dev,
+		u8 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16060_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = 0;
+	st->tx[1] = 0;
+	st->tx[2] = val; /* The last 8 bits clocked in are latched */
+
+	ret = spi_write(st->us_w, st->tx, 3);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+int adis16060_spi_read(struct device *dev,
+		u16 *val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16060_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+
+	ret = spi_read(st->us_r, st->rx, 3);
+
+	/* The internal successive approximation ADC begins the conversion process
+	 * on the falling edge of MSEL1 and starts to place data MSB first on the
+	 * DOUT line at the 6th falling edge of SCLK
+	 */
+	if (ret == 0)
+		*val = ((st->rx[0] & 0x3) << 12) | (st->rx[1] << 4) | ((st->rx[2] >> 4) & 0xF);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static ssize_t adis16060_read(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	u16 val;
+	ssize_t ret;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret =  adis16060_spi_read(dev, &val);
+	mutex_unlock(&indio_dev->mlock);
+
+	if (ret == 0)
+		return sprintf(buf, "%d\n", val);
+	else
+		return ret;
+}
+
+static ssize_t adis16060_write(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	int ret;
+	long val;
+
+	ret = strict_strtol(buf, 16, &val);
+	if (ret)
+		goto error_ret;
+	ret = adis16060_spi_write(dev, val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+#define IIO_DEV_ATTR_IN(_show)				\
+	IIO_DEVICE_ATTR(in, S_IRUGO, _show, NULL, 0)
+
+#define IIO_DEV_ATTR_OUT(_store)				\
+	IIO_DEVICE_ATTR(out, S_IRUGO, NULL, _store, 0)
+
+static IIO_DEV_ATTR_IN(adis16060_read);
+static IIO_DEV_ATTR_OUT(adis16060_write);
+
+static IIO_CONST_ATTR(name, "adis16060");
+
+static struct attribute *adis16060_event_attributes[] = {
+	NULL
+};
+
+static struct attribute_group adis16060_event_attribute_group = {
+	.attrs = adis16060_event_attributes,
+};
+
+static struct attribute *adis16060_attributes[] = {
+	&iio_dev_attr_in.dev_attr.attr,
+	&iio_dev_attr_out.dev_attr.attr,
+	&iio_const_attr_name.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adis16060_attribute_group = {
+	.attrs = adis16060_attributes,
+};
+
+static int __devinit adis16060_r_probe(struct spi_device *spi)
+{
+	int ret, regdone = 0;
+	struct adis16060_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, st);
+
+	/* Allocate the comms buffers */
+	st->rx = kzalloc(sizeof(*st->rx)*ADIS16060_MAX_RX, GFP_KERNEL);
+	if (st->rx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->tx = kzalloc(sizeof(*st->tx)*ADIS16060_MAX_TX, GFP_KERNEL);
+	if (st->tx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_rx;
+	}
+	st->us_r = spi;
+	mutex_init(&st->buf_lock);
+	/* setup the industrialio driver allocated elements */
+	st->indio_dev = iio_allocate_device();
+	if (st->indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_free_tx;
+	}
+
+	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->num_interrupt_lines = 1;
+	st->indio_dev->event_attrs = &adis16060_event_attribute_group;
+	st->indio_dev->attrs = &adis16060_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis16060_configure_ring(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_unreg_ring_funcs;
+	regdone = 1;
+
+	ret = adis16060_initialize_ring(st->indio_dev->ring);
+	if (ret) {
+		printk(KERN_ERR "failed to initialize the ring\n");
+		goto error_unreg_ring_funcs;
+	}
+
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
+		ret = iio_register_interrupt_line(spi->irq,
+				st->indio_dev,
+				0,
+				IRQF_TRIGGER_RISING,
+				"adis16060");
+		if (ret)
+			goto error_uninitialize_ring;
+
+		ret = adis16060_probe_trigger(st->indio_dev);
+		if (ret)
+			goto error_unregister_line;
+	}
+
+	adis16060_st = st;
+	return 0;
+
+error_unregister_line:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
+error_uninitialize_ring:
+	adis16060_uninitialize_ring(st->indio_dev->ring);
+error_unreg_ring_funcs:
+	adis16060_unconfigure_ring(st->indio_dev);
+error_free_dev:
+	if (regdone)
+		iio_device_unregister(st->indio_dev);
+	else
+		iio_free_device(st->indio_dev);
+error_free_tx:
+	kfree(st->tx);
+error_free_rx:
+	kfree(st->rx);
+error_free_st:
+	kfree(st);
+error_ret:
+	return ret;
+}
+
+/* fixme, confirm ordering in this function */
+static int adis16060_r_remove(struct spi_device *spi)
+{
+	struct adis16060_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	flush_scheduled_work();
+
+	adis16060_remove_trigger(indio_dev);
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+		iio_unregister_interrupt_line(indio_dev, 0);
+
+	adis16060_uninitialize_ring(indio_dev->ring);
+	adis16060_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
+	kfree(st->tx);
+	kfree(st->rx);
+	kfree(st);
+
+	return 0;
+}
+
+static int __devinit adis16060_w_probe(struct spi_device *spi)
+{
+	int ret;
+	struct adis16060_state *st = adis16060_st;
+	if (!st) {
+		ret =  -ENODEV;
+		goto error_ret;
+	}
+	spi_set_drvdata(spi, st);
+	st->us_w = spi;
+	return 0;
+
+error_ret:
+	return ret;
+}
+
+static int adis16060_w_remove(struct spi_device *spi)
+{
+	return 0;
+}
+
+static struct spi_driver adis16060_r_driver = {
+	.driver = {
+		.name = "adis16060_r",
+		.owner = THIS_MODULE,
+	},
+	.probe = adis16060_r_probe,
+	.remove = __devexit_p(adis16060_r_remove),
+};
+
+static struct spi_driver adis16060_w_driver = {
+	.driver = {
+		.name = "adis16060_w",
+		.owner = THIS_MODULE,
+	},
+	.probe = adis16060_w_probe,
+	.remove = __devexit_p(adis16060_w_remove),
+};
+
+static __init int adis16060_init(void)
+{
+	int ret;
+
+	ret = spi_register_driver(&adis16060_r_driver);
+	if (ret < 0)
+		return ret;
+
+	ret = spi_register_driver(&adis16060_w_driver);
+	if (ret < 0) {
+		spi_unregister_driver(&adis16060_r_driver);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(adis16060_init);
+
+static __exit void adis16060_exit(void)
+{
+	spi_unregister_driver(&adis16060_w_driver);
+	spi_unregister_driver(&adis16060_r_driver);
+}
+module_exit(adis16060_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16060 Yaw Rate Gyroscope with SPI driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.3.2
