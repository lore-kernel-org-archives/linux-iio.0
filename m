Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: adc: ad7476 new SPI ADC driver
Date: Mon, 11 Oct 2010 13:44:54 +0200
Message-ID: <1286797494-13152-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

New driver handling:
	AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495
SPI micropower and high speed 12-/10-/8-Bit ADCs

staging: iio: adc: ad7476 apply list review feedback by Jonathan Cameron

Changes since last RFC post V1:
	Mainly list review feedback by Jonathan Cameron

-Remove scan_attrs from chip info structure.
-Remove name from chip info structure, use new spi_device_id instead.
-Allow transfer buffers to live in their own cache lines, to avoid DMA/cache coherency issues.
-Move scan el code into the ring buffer file.
-Use helper function to alloc the pollfunc.
-Use regulator framework and get vref_mv from the regulator in case not specified by pdata.
-Devices with buit-in reference use vref from the chip info structure
-Don't error on missing platform_data

-Make vref_mv type unsigned short
-Print in_scale "Vref / 2^(bits)" if fractional.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/Kconfig       |   11 ++
 drivers/staging/iio/adc/Makefile      |    4 +
 drivers/staging/iio/adc/ad7476.h      |   79 +++++++++
 drivers/staging/iio/adc/ad7476_core.c |  298 +++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/ad7476_ring.c |  207 +++++++++++++++++++++++
 5 files changed, 599 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/adc/ad7476.h
 create mode 100644 drivers/staging/iio/adc/ad7476_core.c
 create mode 100644 drivers/staging/iio/adc/ad7476_ring.c

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 3ea4da8..71713ee 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -46,3 +46,14 @@ config AD799X_RING_BUFFER
 	help
 	  Say yes here to include ring buffer support in the AD799X
 	  ADC driver.
+
+config AD7476
+	tristate "Analog Devices AD7475/6/7/8 AD7466/7/8 and AD7495 ADC driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices AD7475/6/7/8,
+	  AD7466/7/8 and AD7495 ADC driver.
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7476.
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 2094dbd..b62c319 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -10,3 +10,7 @@ obj-$(CONFIG_MAX1363) += max1363.o
 ad799x-y := ad799x_core.o
 ad799x-$(CONFIG_AD799X_RING_BUFFER) += ad799x_ring.o
 obj-$(CONFIG_AD799X) += ad799x.o
+
+ad7476-y := ad7476_core.o
+ad7476-$(CONFIG_IIO_RING_BUFFER) += ad7476_ring.o
+obj-$(CONFIG_AD7476) += ad7476.o
diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
new file mode 100644
index 0000000..6e4a85b
--- /dev/null
+++ b/drivers/staging/iio/adc/ad7476.h
@@ -0,0 +1,79 @@
+/*
+ * AD7476/5/7/8 (A) SPI ADC driver
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+#ifndef IIO_ADC_AD7476_H_
+#define IIO_ADC_AD7476_H_
+
+#define RES_MASK(bits)	((1 << (bits)) - 1)
+
+/*
+ * TODO: struct ad7476_platform_data needs to go into include/linux/iio
+ */
+
+struct ad7476_platform_data {
+	u16				vref_mv;
+};
+
+struct ad7476_chip_info {
+	u8				bits;
+	u8				storagebits;
+	u8				res_shift;
+	char				sign;
+	u16				int_vref_mv;
+};
+
+struct ad7476_state {
+	struct iio_dev			*indio_dev;
+	struct spi_device		*spi;
+	const struct ad7476_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct work_struct		poll_work;
+	atomic_t			protect_ring;
+	u16				int_vref_mv;
+	struct spi_transfer		xfer;
+	struct spi_message		msg;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	unsigned char			data[2] ____cacheline_aligned;
+};
+
+enum ad7476_supported_device_ids {
+	ID_AD7466,
+	ID_AD7467,
+	ID_AD7468,
+	ID_AD7475,
+	ID_AD7476,
+	ID_AD7477,
+	ID_AD7478,
+	ID_AD7495
+};
+
+#ifdef CONFIG_IIO_RING_BUFFER
+int ad7476_scan_from_ring(struct ad7476_state *st);
+int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev);
+void ad7476_ring_cleanup(struct iio_dev *indio_dev);
+#else /* CONFIG_IIO_RING_BUFFER */
+static inline ssize_t ad7476_scan_from_ring(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	return 0;
+}
+
+static inline int
+ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline void ad7476_ring_cleanup(struct iio_dev *indio_dev)
+{
+}
+#endif /* CONFIG_IIO_RING_BUFFER */
+#endif /* IIO_ADC_AD7476_H_ */
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
new file mode 100644
index 0000000..bbd72a6
--- /dev/null
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -0,0 +1,298 @@
+/*
+ * AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/workqueue.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "../ring_generic.h"
+#include "adc.h"
+
+#include "ad7476.h"
+
+static int ad7476_scan_direct(struct ad7476_state *st)
+{
+	struct spi_device *spi = st->spi;
+	int ret;
+
+	ret = spi_sync(spi, &st->msg);
+	if (ret)
+		return ret;
+
+	return (st->data[0] << 8) | st->data[1];
+}
+
+static ssize_t ad7476_scan(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad7476_state *st = dev_info->dev_data;
+	int ret;
+
+	mutex_lock(&dev_info->mlock);
+	if (iio_ring_enabled(dev_info))
+		ret = ad7476_scan_from_ring(st);
+	else
+		ret = ad7476_scan_direct(st);
+	mutex_unlock(&dev_info->mlock);
+
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", (ret >> st->chip_info->res_shift) &
+		       RES_MASK(st->chip_info->bits));
+}
+static IIO_DEV_ATTR_IN_RAW(0, ad7476_scan, 0);
+
+static ssize_t ad7476_show_scale(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	/* Driver currently only support internal vref */
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad7476_state *st = iio_dev_get_devdata(dev_info);
+	/* Corresponds to Vref / 2^(bits) */
+
+	if ((1 << (st->chip_info->bits + 1)) > st->int_vref_mv)
+		return sprintf(buf, "%d/2^%d\n",
+			       st->int_vref_mv, st->chip_info->bits);
+	else
+		return sprintf(buf, "%d\n",
+			       st->int_vref_mv >> st->chip_info->bits);
+}
+static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7476_show_scale, NULL, 0);
+
+static ssize_t ad7476_show_name(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad7476_state *st = iio_dev_get_devdata(dev_info);
+
+	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
+}
+static IIO_DEVICE_ATTR(name, S_IRUGO, ad7476_show_name, NULL, 0);
+
+static struct attribute *ad7476_attributes[] = {
+	&iio_dev_attr_in0_raw.dev_attr.attr,
+	&iio_dev_attr_in_scale.dev_attr.attr,
+	&iio_dev_attr_name.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7476_attribute_group = {
+	.attrs = ad7476_attributes,
+};
+
+static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
+	[ID_AD7466] = {
+		.bits = 12,
+		.storagebits = 16,
+		.res_shift = 0,
+		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+	},
+	[ID_AD7467] = {
+		.bits = 10,
+		.storagebits = 16,
+		.res_shift = 2,
+		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+	},
+	[ID_AD7468] = {
+		.bits = 8,
+		.storagebits = 16,
+		.res_shift = 4,
+		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+	},
+	[ID_AD7475] = {
+		.bits = 12,
+		.storagebits = 16,
+		.res_shift = 0,
+		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+	},
+	[ID_AD7476] = {
+		.bits = 12,
+		.storagebits = 16,
+		.res_shift = 0,
+		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+	},
+	[ID_AD7477] = {
+		.bits = 10,
+		.storagebits = 16,
+		.res_shift = 2,
+		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+	},
+	[ID_AD7478] = {
+		.bits = 8,
+		.storagebits = 16,
+		.res_shift = 4,
+		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+	},
+	[ID_AD7495] = {
+		.bits = 12,
+		.storagebits = 16,
+		.res_shift = 0,
+		.int_vref_mv = 2500,
+		.sign = IIO_SCAN_EL_TYPE_UNSIGNED,
+	},
+};
+
+static int __devinit ad7476_probe(struct spi_device *spi)
+{
+	struct ad7476_platform_data *pdata = spi->dev.platform_data;
+	struct ad7476_state *st;
+	int ret, voltage_uv = 0;
+
+	st = kzalloc(sizeof(*st), GFP_KERNEL);
+	if (st == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	st->reg = regulator_get(&spi->dev, "vcc");
+	if (!IS_ERR(st->reg)) {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			goto error_put_reg;
+
+		voltage_uv = regulator_get_voltage(st->reg);
+	}
+
+	st->chip_info =
+		&ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+
+	if (st->chip_info->int_vref_mv)
+		st->int_vref_mv = st->chip_info->int_vref_mv;
+	else if (pdata && pdata->vref_mv)
+		st->int_vref_mv = pdata->vref_mv;
+	else if (voltage_uv)
+		st->int_vref_mv = voltage_uv / 1000;
+	else
+		dev_warn(&spi->dev, "reference voltage unspecified\n");
+
+	spi_set_drvdata(spi, st);
+
+	atomic_set(&st->protect_ring, 0);
+	st->spi = spi;
+
+	st->indio_dev = iio_allocate_device();
+	if (st->indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_disable_reg;
+	}
+
+	/* Estabilish that the iio_dev is a child of the i2c device */
+	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->attrs = &ad7476_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/* Setup default message */
+
+	st->xfer.rx_buf = &st->data;
+	st->xfer.len = st->chip_info->storagebits / 8;
+
+	spi_message_init(&st->msg);
+	spi_message_add_tail(&st->xfer, &st->msg);
+
+	ret = ad7476_register_ring_funcs_and_init(st->indio_dev);
+	if (ret)
+		goto error_free_device;
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_free_device;
+
+	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	if (ret)
+		goto error_cleanup_ring;
+	return 0;
+
+error_cleanup_ring:
+	ad7476_ring_cleanup(st->indio_dev);
+	iio_device_unregister(st->indio_dev);
+error_free_device:
+	iio_free_device(st->indio_dev);
+error_disable_reg:
+	if (!IS_ERR(st->reg))
+		regulator_disable(st->reg);
+error_put_reg:
+	if (!IS_ERR(st->reg))
+		regulator_put(st->reg);
+	kfree(st);
+error_ret:
+	return ret;
+}
+
+static int ad7476_remove(struct spi_device *spi)
+{
+	struct ad7476_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+	iio_ring_buffer_unregister(indio_dev->ring);
+	ad7476_ring_cleanup(indio_dev);
+	iio_device_unregister(indio_dev);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
+	}
+	kfree(st);
+	return 0;
+}
+
+static const struct spi_device_id ad7476_id[] = {
+	{"ad7466", ID_AD7466},
+	{"ad7467", ID_AD7467},
+	{"ad7468", ID_AD7468},
+	{"ad7475", ID_AD7475},
+	{"ad7476", ID_AD7476},
+	{"ad7476a", ID_AD7476},
+	{"ad7477", ID_AD7477},
+	{"ad7477a", ID_AD7477},
+	{"ad7478", ID_AD7478},
+	{"ad7478a", ID_AD7478},
+	{"ad7495", ID_AD7495},
+	{}
+};
+
+static struct spi_driver ad7476_driver = {
+	.driver = {
+		.name	= "ad7476",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad7476_probe,
+	.remove		= __devexit_p(ad7476_remove),
+	.id_table	= ad7476_id,
+};
+
+static int __init ad7476_init(void)
+{
+	return spi_register_driver(&ad7476_driver);
+}
+module_init(ad7476_init);
+
+static void __exit ad7476_exit(void)
+{
+	spi_unregister_driver(&ad7476_driver);
+}
+module_exit(ad7476_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD7475/6/7/8(A) AD7466/7/8 ADC");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:ad7476");
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
new file mode 100644
index 0000000..85de142
--- /dev/null
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -0,0 +1,207 @@
+/*
+ * Copyright 2010 Analog Devices Inc.
+ * Copyright (C) 2008 Jonathan Cameron
+ *
+ * Licensed under the GPL-2 or later.
+ *
+ * ad7476_ring.c
+ */
+
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/workqueue.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+#include <linux/spi/spi.h>
+
+#include "../iio.h"
+#include "../ring_generic.h"
+#include "../ring_sw.h"
+#include "../trigger.h"
+#include "../sysfs.h"
+
+#include "ad7476.h"
+
+static IIO_SCAN_EL_C(in0, 0, 0, NULL);
+
+static ssize_t ad7476_show_type(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = ring->indio_dev;
+	struct ad7476_state *st = indio_dev->dev_data;
+
+	return sprintf(buf, "%c%d/%d>>%d\n", st->chip_info->sign,
+		       st->chip_info->bits, st->chip_info->storagebits,
+		       st->chip_info->res_shift);
+}
+static IIO_DEVICE_ATTR(in_type, S_IRUGO, ad7476_show_type, NULL, 0);
+
+static struct attribute *ad7476_scan_el_attrs[] = {
+	&iio_scan_el_in0.dev_attr.attr,
+	&iio_const_attr_in0_index.dev_attr.attr,
+	&iio_dev_attr_in_type.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ad7476_scan_el_group = {
+	.name = "scan_elements",
+	.attrs = ad7476_scan_el_attrs,
+};
+
+int ad7476_scan_from_ring(struct ad7476_state *st)
+{
+	struct iio_ring_buffer *ring = st->indio_dev->ring;
+	int ret;
+	u8 *ring_data;
+
+	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL);
+	if (ring_data == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	ret = ring->access.read_last(ring, ring_data);
+	if (ret)
+		goto error_free_ring_data;
+
+	ret = (ring_data[0] << 8) | ring_data[1];
+
+error_free_ring_data:
+	kfree(ring_data);
+error_ret:
+	return ret;
+}
+
+/**
+ * ad7476_ring_preenable() setup the parameters of the ring before enabling
+ *
+ * The complex nature of the setting of the nuber of bytes per datum is due
+ * to this driver currently ensuring that the timestamp is stored at an 8
+ * byte boundary.
+ **/
+static int ad7476_ring_preenable(struct iio_dev *indio_dev)
+{
+	struct ad7476_state *st = indio_dev->dev_data;
+	size_t d_size;
+
+	if (indio_dev->ring->access.set_bytes_per_datum) {
+		d_size = st->chip_info->storagebits / 8 + sizeof(s64);
+		if (d_size % 8)
+			d_size += 8 - (d_size % 8);
+		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring,
+							    d_size);
+	}
+
+	return 0;
+}
+
+/**
+ * ad7476_poll_func_th() th of trigger launched polling to ring buffer
+ *
+ * As sampling only occurs on i2c comms occuring, leave timestamping until
+ * then.  Some triggers will generate their own time stamp.  Currently
+ * there is no way of notifying them when no one cares.
+ **/
+static void ad7476_poll_func_th(struct iio_dev *indio_dev, s64 time)
+{
+	struct ad7476_state *st = indio_dev->dev_data;
+
+	schedule_work(&st->poll_work);
+	return;
+}
+/**
+ * ad7476_poll_bh_to_ring() bh of trigger launched polling to ring buffer
+ * @work_s:	the work struct through which this was scheduled
+ *
+ * Currently there is no option in this driver to disable the saving of
+ * timestamps within the ring.
+ * I think the one copy of this at a time was to avoid problems if the
+ * trigger was set far too high and the reads then locked up the computer.
+ **/
+static void ad7476_poll_bh_to_ring(struct work_struct *work_s)
+{
+	struct ad7476_state *st = container_of(work_s, struct ad7476_state,
+						  poll_work);
+	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
+	s64 time_ns;
+	__u8 *rxbuf;
+	int b_sent;
+	size_t d_size;
+
+	/* Ensure the timestamp is 8 byte aligned */
+	d_size = st->chip_info->storagebits / 8 + sizeof(s64);
+	if (d_size % sizeof(s64))
+		d_size += sizeof(s64) - (d_size % sizeof(s64));
+
+	/* Ensure only one copy of this function running at a time */
+	if (atomic_inc_return(&st->protect_ring) > 1)
+		return;
+
+	rxbuf = kzalloc(d_size,	GFP_KERNEL);
+	if (rxbuf == NULL)
+		return;
+
+	b_sent = spi_read(st->spi, rxbuf, st->chip_info->storagebits / 8);
+	if (b_sent < 0)
+		goto done;
+
+	time_ns = iio_get_time_ns();
+
+	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
+
+	indio_dev->ring->access.store_to(&sw_ring->buf, rxbuf, time_ns);
+done:
+	kfree(rxbuf);
+	atomic_dec(&st->protect_ring);
+}
+
+int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
+{
+	struct ad7476_state *st = indio_dev->dev_data;
+	int ret = 0;
+
+	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
+	if (!indio_dev->ring) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	/* Effectively select the ring buffer implementation */
+	iio_ring_sw_register_funcs(&indio_dev->ring->access);
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &ad7476_poll_func_th);
+	if (ret)
+		goto error_deallocate_sw_rb;
+
+	/* Ring buffer functions - here trigger setup related */
+
+	indio_dev->ring->preenable = &ad7476_ring_preenable;
+	indio_dev->ring->postenable = &iio_triggered_ring_postenable;
+	indio_dev->ring->predisable = &iio_triggered_ring_predisable;
+	indio_dev->ring->scan_el_attrs = &ad7476_scan_el_group;
+
+	INIT_WORK(&st->poll_work, &ad7476_poll_bh_to_ring);
+
+	/* Flag that polled ring buffering is possible */
+	indio_dev->modes |= INDIO_RING_TRIGGERED;
+	return 0;
+error_deallocate_sw_rb:
+	iio_sw_rb_free(indio_dev->ring);
+error_ret:
+	return ret;
+}
+
+void ad7476_ring_cleanup(struct iio_dev *indio_dev)
+{
+	/* ensure that the trigger has been detached */
+	if (indio_dev->trig) {
+		iio_put_trigger(indio_dev->trig);
+		iio_trigger_dettach_poll_func(indio_dev->trig,
+					      indio_dev->pollfunc);
+	}
+	kfree(indio_dev->pollfunc);
+	iio_sw_rb_free(indio_dev->ring);
+}
-- 
1.6.0.2
