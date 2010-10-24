Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Barry Song <barry.song@analog.com>
Subject: [PATCH 20/36] staging: iio: gyro: new driver for ADIS16080 digital output gyros
Date: Sun, 24 Oct 2010 17:22:22 -0400
Message-Id: <1287955358-3153-21-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
References: <1287955358-3153-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <barry.song@analog.com>

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/gyro/Kconfig          |    7 +
 drivers/staging/iio/gyro/Makefile         |    3 +
 drivers/staging/iio/gyro/adis16080.h      |  102 +++++++++++
 drivers/staging/iio/gyro/adis16080_core.c |  271 +++++++++++++++++++++++++++++
 4 files changed, 383 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/gyro/adis16080.h
 create mode 100644 drivers/staging/iio/gyro/adis16080_core.c

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index d34410b..97fe8bc 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -10,6 +10,13 @@ config ADIS16060
 	  Say yes here to build support for Analog Devices adis16060 wide bandwidth
 	  yaw rate gyroscope with SPI.
 
+config ADIS16080
+	tristate "Analog Devices ADIS16080/100 Yaw Rate Gyroscope with SPI driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices adis16080/100 Yaw Rate
+	  Gyroscope with SPI.
+
 config ADIS16260
 	tristate "Analog Devices ADIS16260/5 Digital Gyroscope Sensor SPI driver"
 	depends on SPI
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index 7b3b478..fcc697f 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -5,6 +5,9 @@
 adis16060-y             := adis16060_core.o
 obj-$(CONFIG_ADIS16060) += adis16060.o
 
+adis16080-y             := adis16080_core.o
+obj-$(CONFIG_ADIS16080) += adis16080.o
+
 adis16260-y             := adis16260_core.o
 adis16260-$(CONFIG_IIO_RING_BUFFER) += adis16260_ring.o adis16260_trigger.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
diff --git a/drivers/staging/iio/gyro/adis16080.h b/drivers/staging/iio/gyro/adis16080.h
new file mode 100644
index 0000000..78fabff
--- /dev/null
+++ b/drivers/staging/iio/gyro/adis16080.h
@@ -0,0 +1,102 @@
+#ifndef SPI_ADIS16080_H_
+#define SPI_ADIS16080_H_
+
+#define ADIS16080_DIN_CODE   4 /* Output data format setting. 0: Twos complement. 1: Offset binary. */
+#define ADIS16080_DIN_GYRO   (0 << 10) /* Gyroscope output */
+#define ADIS16080_DIN_TEMP   (1 << 10) /* Temperature output */
+#define ADIS16080_DIN_AIN1   (2 << 10)
+#define ADIS16080_DIN_AIN2   (3 << 10)
+#define ADIS16080_DIN_WRITE  (1 << 15) /* 1: Write contents on DIN to control register.
+					* 0: No changes to control register.
+					*/
+
+#define ADIS16080_MAX_TX     2
+#define ADIS16080_MAX_RX     2
+
+/**
+ * struct adis16080_state - device instance specific data
+ * @us:			actual spi_device to write data
+ * @work_trigger_to_ring: bh for triggered event handling
+ * @inter:		used to check if new interrupt has been triggered
+ * @last_timestamp:	passing timestamp from th to bh of interrupt handler
+ * @indio_dev:		industrial I/O device structure
+ * @trig:		data ready trigger registered with iio
+ * @tx:			transmit buffer
+ * @rx:			recieve buffer
+ * @buf_lock:		mutex to protect tx and rx
+ **/
+struct adis16080_state {
+	struct spi_device		*us;
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
+enum adis16080_scan {
+	ADIS16080_SCAN_GYRO,
+	ADIS16080_SCAN_TEMP,
+	ADIS16080_SCAN_ADC_1,
+	ADIS16080_SCAN_ADC_2,
+};
+
+void adis16080_remove_trigger(struct iio_dev *indio_dev);
+int adis16080_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t adis16080_read_data_from_ring(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf);
+
+
+int adis16080_configure_ring(struct iio_dev *indio_dev);
+void adis16080_unconfigure_ring(struct iio_dev *indio_dev);
+
+int adis16080_initialize_ring(struct iio_ring_buffer *ring);
+void adis16080_uninitialize_ring(struct iio_ring_buffer *ring);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void adis16080_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16080_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline ssize_t
+adis16080_read_data_from_ring(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return 0;
+}
+
+static int adis16080_configure_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void adis16080_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16080_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return 0;
+}
+
+static inline void adis16080_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+}
+
+#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* SPI_ADIS16080_H_ */
diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/staging/iio/gyro/adis16080_core.c
new file mode 100644
index 0000000..0efb768
--- /dev/null
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -0,0 +1,271 @@
+/*
+ * ADIS16080/100 Yaw Rate Gyroscope with SPI driver
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
+#include "adis16080.h"
+
+#define DRIVER_NAME		"adis16080"
+
+struct adis16080_state *adis16080_st;
+
+int adis16080_spi_write(struct device *dev,
+		u16 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16080_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = val >> 8;
+	st->tx[1] = val;
+
+	ret = spi_write(st->us, st->tx, 2);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+int adis16080_spi_read(struct device *dev,
+		u16 *val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16080_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+
+	ret = spi_read(st->us, st->rx, 2);
+
+	if (ret == 0)
+		*val = ((st->rx[0] & 0xF) << 8) | st->rx[1];
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static ssize_t adis16080_read(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	u16 val;
+	ssize_t ret;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret =  adis16080_spi_read(dev, &val);
+	mutex_unlock(&indio_dev->mlock);
+
+	if (ret == 0)
+		return sprintf(buf, "%d\n", val);
+	else
+		return ret;
+}
+
+static ssize_t adis16080_write(struct device *dev,
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
+	ret = adis16080_spi_write(dev, val);
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
+static IIO_DEV_ATTR_IN(adis16080_read);
+static IIO_DEV_ATTR_OUT(adis16080_write);
+
+static IIO_CONST_ATTR(name, "adis16080");
+
+static struct attribute *adis16080_event_attributes[] = {
+	NULL
+};
+
+static struct attribute_group adis16080_event_attribute_group = {
+	.attrs = adis16080_event_attributes,
+};
+
+static struct attribute *adis16080_attributes[] = {
+	&iio_dev_attr_in.dev_attr.attr,
+	&iio_dev_attr_out.dev_attr.attr,
+	&iio_const_attr_name.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adis16080_attribute_group = {
+	.attrs = adis16080_attributes,
+};
+
+static int __devinit adis16080_probe(struct spi_device *spi)
+{
+	int ret, regdone = 0;
+	struct adis16080_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, st);
+
+	/* Allocate the comms buffers */
+	st->rx = kzalloc(sizeof(*st->rx)*ADIS16080_MAX_RX, GFP_KERNEL);
+	if (st->rx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->tx = kzalloc(sizeof(*st->tx)*ADIS16080_MAX_TX, GFP_KERNEL);
+	if (st->tx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_rx;
+	}
+	st->us = spi;
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
+	st->indio_dev->event_attrs = &adis16080_event_attribute_group;
+	st->indio_dev->attrs = &adis16080_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = adis16080_configure_ring(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_unreg_ring_funcs;
+	regdone = 1;
+
+	ret = adis16080_initialize_ring(st->indio_dev->ring);
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
+				"adis16080");
+		if (ret)
+			goto error_uninitialize_ring;
+
+		ret = adis16080_probe_trigger(st->indio_dev);
+		if (ret)
+			goto error_unregister_line;
+	}
+
+	adis16080_st = st;
+	return 0;
+
+error_unregister_line:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
+error_uninitialize_ring:
+	adis16080_uninitialize_ring(st->indio_dev->ring);
+error_unreg_ring_funcs:
+	adis16080_unconfigure_ring(st->indio_dev);
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
+static int adis16080_remove(struct spi_device *spi)
+{
+	struct adis16080_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	flush_scheduled_work();
+
+	adis16080_remove_trigger(indio_dev);
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+		iio_unregister_interrupt_line(indio_dev, 0);
+
+	adis16080_uninitialize_ring(indio_dev->ring);
+	adis16080_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
+	kfree(st->tx);
+	kfree(st->rx);
+	kfree(st);
+
+	return 0;
+}
+
+static struct spi_driver adis16080_driver = {
+	.driver = {
+		.name = "adis16080",
+		.owner = THIS_MODULE,
+	},
+	.probe = adis16080_probe,
+	.remove = __devexit_p(adis16080_remove),
+};
+
+static __init int adis16080_init(void)
+{
+	return spi_register_driver(&adis16080_driver);
+}
+module_init(adis16080_init);
+
+static __exit void adis16080_exit(void)
+{
+	spi_unregister_driver(&adis16080_driver);
+}
+module_exit(adis16080_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16080/100 Yaw Rate Gyroscope with SPI driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.3.2
