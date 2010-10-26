Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Barry Song <barry.song@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 21/36] staging: iio: gyro: new driver for ADIS16130 digital output gyros
Date: Tue, 26 Oct 2010 14:17:31 -0400
Message-Id: <1288117066-18055-22-git-send-email-vapier@gentoo.org>
In-Reply-To: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
References: <1288117066-18055-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <barry.song@analog.com>

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/gyro/Kconfig          |    7 +
 drivers/staging/iio/gyro/Makefile         |    3 +
 drivers/staging/iio/gyro/adis16130.h      |  108 ++++++++++
 drivers/staging/iio/gyro/adis16130_core.c |  313 +++++++++++++++++++++++++++++
 4 files changed, 431 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/gyro/adis16130.h
 create mode 100644 drivers/staging/iio/gyro/adis16130_core.c

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index f219c94..236f15f 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -17,6 +17,13 @@ config ADIS16080
 	  Say yes here to build support for Analog Devices adis16080/100 Yaw Rate
 	  Gyroscope with SPI.
 
+config ADIS16130
+	tristate "Analog Devices ADIS16130 High Precision Angular Rate Sensor driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices ADIS16130 High Precision
+	  Angular Rate Sensor driver.
+
 config ADIS16260
 	tristate "Analog Devices ADIS16260 ADIS16265 Digital Gyroscope Sensor SPI driver"
 	depends on SPI
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index 747823f..2764c15 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -8,6 +8,9 @@ obj-$(CONFIG_ADIS16060) += adis16060.o
 adis16080-y             := adis16080_core.o
 obj-$(CONFIG_ADIS16080) += adis16080.o
 
+adis16130-y             := adis16130_core.o
+obj-$(CONFIG_ADIS16130) += adis16130.o
+
 adis16260-y             := adis16260_core.o
 adis16260-$(CONFIG_IIO_RING_BUFFER) += adis16260_ring.o adis16260_trigger.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
diff --git a/drivers/staging/iio/gyro/adis16130.h b/drivers/staging/iio/gyro/adis16130.h
new file mode 100644
index 0000000..ab80ef6
--- /dev/null
+++ b/drivers/staging/iio/gyro/adis16130.h
@@ -0,0 +1,108 @@
+#ifndef SPI_ADIS16130_H_
+#define SPI_ADIS16130_H_
+
+#define ADIS16130_CON         0x0
+#define ADIS16130_CON_RD      (1 << 6)
+#define ADIS16130_IOP         0x1
+#define ADIS16130_IOP_ALL_RDY (1 << 3) /* 1 = data-ready signal low when unread data on all channels; */
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
+#define ADIS16130_MAX_TX     4
+#define ADIS16130_MAX_RX     4
+
+/**
+ * struct adis16130_state - device instance specific data
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
+struct adis16130_state {
+	struct spi_device		*us;
+	struct work_struct		work_trigger_to_ring;
+	s64				last_timestamp;
+	struct iio_dev			*indio_dev;
+	struct iio_trigger		*trig;
+	u8				*tx;
+	u8				*rx;
+	u32                             mode; /* 1: 24bits mode 0:16bits mode */
+	struct mutex			buf_lock;
+};
+
+#if defined(CONFIG_IIO_RING_BUFFER) && defined(THIS_HAS_RING_BUFFER_SUPPORT)
+/* At the moment triggers are only used for ring buffer
+ * filling. This may change!
+ */
+
+enum adis16130_scan {
+	ADIS16130_SCAN_GYRO,
+	ADIS16130_SCAN_TEMP,
+};
+
+void adis16130_remove_trigger(struct iio_dev *indio_dev);
+int adis16130_probe_trigger(struct iio_dev *indio_dev);
+
+ssize_t adis16130_read_data_from_ring(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf);
+
+
+int adis16130_configure_ring(struct iio_dev *indio_dev);
+void adis16130_unconfigure_ring(struct iio_dev *indio_dev);
+
+int adis16130_initialize_ring(struct iio_ring_buffer *ring);
+void adis16130_uninitialize_ring(struct iio_ring_buffer *ring);
+#else /* CONFIG_IIO_RING_BUFFER */
+
+static inline void adis16130_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16130_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline ssize_t
+adis16130_read_data_from_ring(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return 0;
+}
+
+static int adis16130_configure_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void adis16130_unconfigure_ring(struct iio_dev *indio_dev)
+{
+}
+
+static inline int adis16130_initialize_ring(struct iio_ring_buffer *ring)
+{
+	return 0;
+}
+
+static inline void adis16130_uninitialize_ring(struct iio_ring_buffer *ring)
+{
+}
+
+#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* SPI_ADIS16130_H_ */
diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
new file mode 100644
index 0000000..49ffc7b
--- /dev/null
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -0,0 +1,313 @@
+/*
+ * ADIS16130 Digital Output, High Precision Angular Rate Sensor driver
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
+#include "adis16130.h"
+
+#define DRIVER_NAME		"adis16130"
+
+struct adis16130_state *adis16130_st;
+
+int adis16130_spi_write(struct device *dev, u8 reg_addr,
+		u8 val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16130_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = reg_addr;
+	st->tx[1] = val;
+
+	ret = spi_write(st->us, st->tx, 2);
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+int adis16130_spi_read(struct device *dev, u8 reg_addr,
+		u32 *val)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16130_state *st = iio_dev_get_devdata(indio_dev);
+
+	mutex_lock(&st->buf_lock);
+
+	st->tx[0] = ADIS16130_CON_RD | reg_addr;
+	if (st->mode)
+		ret = spi_read(st->us, st->rx, 4);
+	else
+		ret = spi_read(st->us, st->rx, 3);
+
+	if (ret == 0) {
+		if (st->mode)
+			*val = (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
+		else
+			*val = (st->rx[1] << 8) | st->rx[2];
+	}
+
+	mutex_unlock(&st->buf_lock);
+
+	return ret;
+}
+
+static ssize_t adis16130_gyro_read(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	u32 val;
+	ssize_t ret;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret =  adis16130_spi_read(dev, ADIS16130_RATEDATA, &val);
+	mutex_unlock(&indio_dev->mlock);
+
+	if (ret == 0)
+		return sprintf(buf, "%d\n", val);
+	else
+		return ret;
+}
+
+static ssize_t adis16130_temp_read(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	u32 val;
+	ssize_t ret;
+
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret =  adis16130_spi_read(dev, ADIS16130_TEMPDATA, &val);
+	mutex_unlock(&indio_dev->mlock);
+
+	if (ret == 0)
+		return sprintf(buf, "%d\n", val);
+	else
+		return ret;
+}
+
+static ssize_t adis16130_bitsmode_read(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16130_state *st = iio_dev_get_devdata(indio_dev);
+
+	return sprintf(buf, "%d\n", st->mode);
+}
+
+static ssize_t adis16130_bitsmode_write(struct device *dev,
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
+	ret = adis16130_spi_write(dev, ADIS16130_MODE, !!val);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static IIO_DEV_ATTR_TEMP_RAW(adis16130_temp_read);
+
+static IIO_CONST_ATTR(name, "adis16130");
+
+static IIO_DEV_ATTR_GYRO(adis16130_gyro_read,
+		ADIS16130_RATEDATA);
+
+#define IIO_DEV_ATTR_BITS_MODE(_mode, _show, _store, _addr)	\
+	IIO_DEVICE_ATTR(bits_mode, _mode, _show, _store, _addr)
+
+static IIO_DEV_ATTR_BITS_MODE(S_IWUSR | S_IRUGO, adis16130_bitsmode_read, adis16130_bitsmode_write,
+			ADIS16130_MODE);
+
+static struct attribute *adis16130_event_attributes[] = {
+	NULL
+};
+
+static struct attribute_group adis16130_event_attribute_group = {
+	.attrs = adis16130_event_attributes,
+};
+
+static struct attribute *adis16130_attributes[] = {
+	&iio_dev_attr_temp_raw.dev_attr.attr,
+	&iio_const_attr_name.dev_attr.attr,
+	&iio_dev_attr_gyro_raw.dev_attr.attr,
+	&iio_dev_attr_bits_mode.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adis16130_attribute_group = {
+	.attrs = adis16130_attributes,
+};
+
+static int __devinit adis16130_probe(struct spi_device *spi)
+{
+	int ret, regdone = 0;
+	struct adis16130_state *st = kzalloc(sizeof *st, GFP_KERNEL);
+	if (!st) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+	/* this is only used for removal purposes */
+	spi_set_drvdata(spi, st);
+
+	/* Allocate the comms buffers */
+	st->rx = kzalloc(sizeof(*st->rx)*ADIS16130_MAX_RX, GFP_KERNEL);
+	if (st->rx == NULL) {
+		ret = -ENOMEM;
+		goto error_free_st;
+	}
+	st->tx = kzalloc(sizeof(*st->tx)*ADIS16130_MAX_TX, GFP_KERNEL);
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
+	st->indio_dev->event_attrs = &adis16130_event_attribute_group;
+	st->indio_dev->attrs = &adis16130_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	st->mode = 1;
+
+	ret = adis16130_configure_ring(st->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_unreg_ring_funcs;
+	regdone = 1;
+
+	ret = adis16130_initialize_ring(st->indio_dev->ring);
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
+				"adis16130");
+		if (ret)
+			goto error_uninitialize_ring;
+
+		ret = adis16130_probe_trigger(st->indio_dev);
+		if (ret)
+			goto error_unregister_line;
+	}
+
+	adis16130_st = st;
+	return 0;
+
+error_unregister_line:
+	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
+		iio_unregister_interrupt_line(st->indio_dev, 0);
+error_uninitialize_ring:
+	adis16130_uninitialize_ring(st->indio_dev->ring);
+error_unreg_ring_funcs:
+	adis16130_unconfigure_ring(st->indio_dev);
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
+static int adis16130_remove(struct spi_device *spi)
+{
+	struct adis16130_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	flush_scheduled_work();
+
+	adis16130_remove_trigger(indio_dev);
+	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
+		iio_unregister_interrupt_line(indio_dev, 0);
+
+	adis16130_uninitialize_ring(indio_dev->ring);
+	adis16130_unconfigure_ring(indio_dev);
+	iio_device_unregister(indio_dev);
+	kfree(st->tx);
+	kfree(st->rx);
+	kfree(st);
+
+	return 0;
+}
+
+static struct spi_driver adis16130_driver = {
+	.driver = {
+		.name = "adis16130",
+		.owner = THIS_MODULE,
+	},
+	.probe = adis16130_probe,
+	.remove = __devexit_p(adis16130_remove),
+};
+
+static __init int adis16130_init(void)
+{
+	return spi_register_driver(&adis16130_driver);
+}
+module_init(adis16130_init);
+
+static __exit void adis16130_exit(void)
+{
+	spi_unregister_driver(&adis16130_driver);
+}
+module_exit(adis16130_exit);
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADIS16130 High Precision Angular Rate Sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.3.2
