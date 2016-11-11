Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34015 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbcKKGf5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Nov 2016 01:35:57 -0500
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.usuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 2/2] staging: iio: ad7606: move out of staging
Date: Fri, 11 Nov 2016 14:34:38 +0800
Message-Id: <1478846078-22207-3-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the ad7606 driver from staging/iio/adc to iio/adc. Also, update the
corresponding Makefile and Kconfig associated with the change.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/iio/adc/Kconfig              |  34 +++
 drivers/iio/adc/Makefile             |   3 +
 drivers/iio/adc/ad7606.c             | 519 +++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h             |  78 ++++++
 drivers/iio/adc/ad7606_par.c         | 112 ++++++++
 drivers/iio/adc/ad7606_spi.c         |  78 ++++++
 drivers/staging/iio/adc/Kconfig      |  34 ---
 drivers/staging/iio/adc/Makefile     |   4 -
 drivers/staging/iio/adc/ad7606.c     | 519 -----------------------------------
 drivers/staging/iio/adc/ad7606.h     |  78 ------
 drivers/staging/iio/adc/ad7606_par.c | 112 --------
 drivers/staging/iio/adc/ad7606_spi.c |  78 ------
 12 files changed, 824 insertions(+), 825 deletions(-)
 create mode 100644 drivers/iio/adc/ad7606.c
 create mode 100644 drivers/iio/adc/ad7606.h
 create mode 100644 drivers/iio/adc/ad7606_par.c
 create mode 100644 drivers/iio/adc/ad7606_spi.c
 delete mode 100644 drivers/staging/iio/adc/ad7606.c
 delete mode 100644 drivers/staging/iio/adc/ad7606.h
 delete mode 100644 drivers/staging/iio/adc/ad7606_par.c
 delete mode 100644 drivers/staging/iio/adc/ad7606_spi.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index c3fe98d..742db8f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -58,6 +58,40 @@ config AD7476
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7476.
 
+config AD7606
+	tristate "Analog Devices AD7606 ADC driver"
+	depends on GPIOLIB || COMPILE_TEST
+	depends on HAS_IOMEM
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices:
+	  ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7606.
+
+config AD7606_IFACE_PARALLEL
+	tristate "parallel interface support"
+	depends on AD7606
+	help
+	  Say yes here to include parallel interface support on the AD7606
+	  ADC driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7606_parallel.
+
+config AD7606_IFACE_SPI
+	tristate "spi interface support"
+	depends on AD7606
+	depends on SPI
+	help
+	  Say yes here to include parallel interface support on the AD7606
+	  ADC driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7606_spi.
+
 config AD7766
 	tristate "Analog Devices AD7766/AD7767 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 96894b3..d06d3a9 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -9,6 +9,9 @@ obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7923) += ad7923.o
 obj-$(CONFIG_AD7476) += ad7476.o
+obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
+obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
+obj-$(CONFIG_AD7606) += ad7606.o
 obj-$(CONFIG_AD7766) += ad7766.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
new file mode 100644
index 0000000..cceb18c
--- /dev/null
+++ b/drivers/iio/adc/ad7606.c
@@ -0,0 +1,519 @@
+/*
+ * AD7606 SPI ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "ad7606.h"
+
+static int ad7606_reset(struct ad7606_state *st)
+{
+	if (st->gpio_reset) {
+		gpiod_set_value(st->gpio_reset, 1);
+		ndelay(100); /* t_reset >= 100ns */
+		gpiod_set_value(st->gpio_reset, 0);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static int ad7606_read_samples(struct ad7606_state *st)
+{
+	unsigned int num = st->chip_info->num_channels;
+	u16 *data = st->data;
+	int ret;
+
+	/*
+	 * The frstdata signal is set to high while and after reading the sample
+	 * of the first channel and low for all other channels. This can be used
+	 * to check that the incoming data is correctly aligned. During normal
+	 * operation the data should never become unaligned, but some glitch or
+	 * electrostatic discharge might cause an extra read or clock cycle.
+	 * Monitoring the frstdata signal allows to recover from such failure
+	 * situations.
+	 */
+
+	if (st->gpio_frstdata) {
+		ret = st->bops->read_block(st->dev, 1, data);
+		if (ret)
+			return ret;
+
+		if (!gpiod_get_value(st->gpio_frstdata)) {
+			ad7606_reset(st);
+			return -EIO;
+		}
+
+		data++;
+		num--;
+	}
+
+	return st->bops->read_block(st->dev, num, data);
+}
+
+static irqreturn_t ad7606_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct ad7606_state *st = iio_priv(pf->indio_dev);
+
+	gpiod_set_value(st->gpio_convst, 1);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring buffer
+ * @work_s:	the work struct through which this was scheduled
+ *
+ * Currently there is no option in this driver to disable the saving of
+ * timestamps within the ring.
+ * I think the one copy of this at a time was to avoid problems if the
+ * trigger was set far too high and the reads then locked up the computer.
+ **/
+static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
+{
+	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
+						poll_work);
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
+	int ret;
+
+	ret = ad7606_read_samples(st);
+	if (ret == 0)
+		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
+						   iio_get_time_ns(indio_dev));
+
+	gpiod_set_value(st->gpio_convst, 0);
+	iio_trigger_notify_done(indio_dev->trig);
+}
+
+static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->done = false;
+	gpiod_set_value(st->gpio_convst, 1);
+
+	ret = wait_event_interruptible(st->wq_data_avail, st->done);
+	if (ret)
+		goto error_ret;
+
+	ret = ad7606_read_samples(st);
+	if (ret == 0)
+		ret = st->data[ch];
+
+error_ret:
+	gpiod_set_value(st->gpio_convst, 0);
+
+	return ret;
+}
+
+static int ad7606_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	int ret;
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ad7606_scan_direct(indio_dev, chan->address);
+		iio_device_release_direct_mode(indio_dev);
+
+		if (ret < 0)
+			return ret;
+		*val = (short)ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->range * 2;
+		*val2 = st->chip_info->channels[0].scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->oversampling;
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+static IIO_CONST_ATTR(in_voltage_scale_available, "5000 10000");
+
+static int ad7606_oversampling_get_index(unsigned int val)
+{
+	unsigned char supported[] = {1, 2, 4, 8, 16, 32, 64};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(supported); i++)
+		if (val == supported[i])
+			return i;
+
+	return -EINVAL;
+}
+
+static int ad7606_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	int values[3];
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val2)
+			return -EINVAL;
+
+		if (!(val == 5000 || val == 10000))
+			return -EINVAL;
+
+		mutex_lock(&indio_dev->mlock);
+		gpiod_set_value(st->gpio_range, val == 10000);
+		st->range = val;
+		mutex_unlock(&indio_dev->mlock);
+
+		return 0;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if (val2)
+			return -EINVAL;
+		ret = ad7606_oversampling_get_index(val);
+		if (ret < 0)
+			return ret;
+
+		values[0] = (ret >> 0) & 1;
+		values[1] = (ret >> 1) & 1;
+		values[2] = (ret >> 2) & 1;
+
+		mutex_lock(&indio_dev->mlock);
+		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
+				      values);
+		st->oversampling = val;
+		mutex_unlock(&indio_dev->mlock);
+
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
+
+static struct attribute *ad7606_attributes_os_and_range[] = {
+	&iio_const_attr_in_voltage_scale_available.dev_attr.attr,
+	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7606_attribute_group_os_and_range = {
+	.attrs = ad7606_attributes_os_and_range,
+};
+
+static struct attribute *ad7606_attributes_os[] = {
+	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7606_attribute_group_os = {
+	.attrs = ad7606_attributes_os,
+};
+
+static struct attribute *ad7606_attributes_range[] = {
+	&iio_const_attr_in_voltage_scale_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7606_attribute_group_range = {
+	.attrs = ad7606_attributes_range,
+};
+
+#define AD7606_CHANNEL(num)					\
+	{							\
+		.type = IIO_VOLTAGE,				\
+		.indexed = 1,					\
+		.channel = num,					\
+		.address = num,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
+		.info_mask_shared_by_all =			\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		.scan_index = num,				\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 16,				\
+			.storagebits = 16,			\
+			.endianness = IIO_CPU,			\
+		},						\
+	}
+
+static const struct iio_chan_spec ad7606_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7606_CHANNEL(0),
+	AD7606_CHANNEL(1),
+	AD7606_CHANNEL(2),
+	AD7606_CHANNEL(3),
+	AD7606_CHANNEL(4),
+	AD7606_CHANNEL(5),
+	AD7606_CHANNEL(6),
+	AD7606_CHANNEL(7),
+};
+
+static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
+	/*
+	 * More devices added in future
+	 */
+	[ID_AD7606_8] = {
+		.channels = ad7606_channels,
+		.num_channels = 9,
+	},
+	[ID_AD7606_6] = {
+		.channels = ad7606_channels,
+		.num_channels = 7,
+	},
+	[ID_AD7606_4] = {
+		.channels = ad7606_channels,
+		.num_channels = 5,
+	},
+};
+
+static int ad7606_request_gpios(struct ad7606_state *st)
+{
+	struct device *dev = st->dev;
+
+	st->gpio_convst = devm_gpiod_get(dev, "conversion-start",
+					 GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_convst))
+		return PTR_ERR(st->gpio_convst);
+
+	st->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_reset))
+		return PTR_ERR(st->gpio_reset);
+
+	st->gpio_range = devm_gpiod_get_optional(dev, "range", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_range))
+		return PTR_ERR(st->gpio_range);
+
+	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
+						   GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_standby))
+		return PTR_ERR(st->gpio_standby);
+
+	st->gpio_frstdata = devm_gpiod_get_optional(dev, "first-data",
+						    GPIOD_IN);
+	if (IS_ERR(st->gpio_frstdata))
+		return PTR_ERR(st->gpio_frstdata);
+
+	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
+			GPIOD_OUT_LOW);
+	return PTR_ERR_OR_ZERO(st->gpio_os);
+}
+
+/**
+ *  Interrupt handler
+ */
+static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev)) {
+		schedule_work(&st->poll_work);
+	} else {
+		st->done = true;
+		wake_up_interruptible(&st->wq_data_avail);
+	}
+
+	return IRQ_HANDLED;
+};
+
+static const struct iio_info ad7606_info_no_os_or_range = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7606_read_raw,
+};
+
+static const struct iio_info ad7606_info_os_and_range = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7606_read_raw,
+	.write_raw = &ad7606_write_raw,
+	.attrs = &ad7606_attribute_group_os_and_range,
+};
+
+static const struct iio_info ad7606_info_os = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7606_read_raw,
+	.write_raw = &ad7606_write_raw,
+	.attrs = &ad7606_attribute_group_os,
+};
+
+static const struct iio_info ad7606_info_range = {
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7606_read_raw,
+	.attrs = &ad7606_attribute_group_range,
+};
+
+int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
+		 const char *name, unsigned int id,
+		 const struct ad7606_bus_ops *bops)
+{
+	struct ad7606_state *st;
+	int ret;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->dev = dev;
+	st->bops = bops;
+	st->base_address = base_address;
+	st->range = 5000;
+	st->oversampling = 1;
+	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
+
+	st->reg = devm_regulator_get(dev, "avcc");
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(dev, "Failed to enable specified AVcc supply\n");
+		return ret;
+	}
+
+	ret = ad7606_request_gpios(st);
+	if (ret)
+		goto error_disable_reg;
+
+	st->chip_info = &ad7606_chip_info_tbl[id];
+
+	indio_dev->dev.parent = dev;
+	if (st->gpio_os) {
+		if (st->gpio_range)
+			indio_dev->info = &ad7606_info_os_and_range;
+		else
+			indio_dev->info = &ad7606_info_os;
+	} else {
+		if (st->gpio_range)
+			indio_dev->info = &ad7606_info_range;
+		else
+			indio_dev->info = &ad7606_info_no_os_or_range;
+	}
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->name = name;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+
+	init_waitqueue_head(&st->wq_data_avail);
+
+	ret = ad7606_reset(st);
+	if (ret)
+		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
+
+	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
+			  indio_dev);
+	if (ret)
+		goto error_disable_reg;
+
+	ret = iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
+					 NULL, NULL);
+	if (ret)
+		goto error_free_irq;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unregister_ring;
+
+	dev_set_drvdata(dev, indio_dev);
+
+	return 0;
+error_unregister_ring:
+	iio_triggered_buffer_cleanup(indio_dev);
+
+error_free_irq:
+	free_irq(irq, indio_dev);
+
+error_disable_reg:
+	regulator_disable(st->reg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ad7606_probe);
+
+int ad7606_remove(struct device *dev, int irq)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+
+	free_irq(irq, indio_dev);
+	regulator_disable(st->reg);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ad7606_remove);
+
+#ifdef CONFIG_PM_SLEEP
+
+static int ad7606_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (st->gpio_standby) {
+		gpiod_set_value(st->gpio_range, 1);
+		gpiod_set_value(st->gpio_standby, 0);
+	}
+
+	return 0;
+}
+
+static int ad7606_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	if (st->gpio_standby) {
+		gpiod_set_value(st->gpio_range, st->range == 10000);
+		gpiod_set_value(st->gpio_standby, 1);
+		ad7606_reset(st);
+	}
+
+	return 0;
+}
+
+SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
+EXPORT_SYMBOL_GPL(ad7606_pm_ops);
+
+#endif
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
new file mode 100644
index 0000000..746f955
--- /dev/null
+++ b/drivers/iio/adc/ad7606.h
@@ -0,0 +1,78 @@
+/*
+ * AD7606 ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef IIO_ADC_AD7606_H_
+#define IIO_ADC_AD7606_H_
+
+/**
+ * struct ad7606_chip_info - chip specific information
+ * @name:		identification string for chip
+ * @channels:		channel specification
+ * @num_channels:	number of channels
+ */
+
+struct ad7606_chip_info {
+	const struct iio_chan_spec	*channels;
+	unsigned int			num_channels;
+};
+
+/**
+ * struct ad7606_state - driver instance specific data
+ */
+
+struct ad7606_state {
+	struct device			*dev;
+	const struct ad7606_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct work_struct		poll_work;
+	wait_queue_head_t		wq_data_avail;
+	const struct ad7606_bus_ops	*bops;
+	unsigned int			range;
+	unsigned int			oversampling;
+	bool				done;
+	void __iomem			*base_address;
+
+	struct gpio_desc		*gpio_convst;
+	struct gpio_desc		*gpio_reset;
+	struct gpio_desc		*gpio_range;
+	struct gpio_desc		*gpio_standby;
+	struct gpio_desc		*gpio_frstdata;
+	struct gpio_descs		*gpio_os;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 * 8 * 16-bit samples + 64-bit timestamp
+	 */
+	unsigned short			data[12] ____cacheline_aligned;
+};
+
+struct ad7606_bus_ops {
+	/* more methods added in future? */
+	int (*read_block)(struct device *, int, void *);
+};
+
+int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
+		 const char *name, unsigned int id,
+		 const struct ad7606_bus_ops *bops);
+int ad7606_remove(struct device *dev, int irq);
+
+enum ad7606_supported_device_ids {
+	ID_AD7606_8,
+	ID_AD7606_6,
+	ID_AD7606_4
+};
+
+#ifdef CONFIG_PM_SLEEP
+extern const struct dev_pm_ops ad7606_pm_ops;
+#define AD7606_PM_OPS (&ad7606_pm_ops)
+#else
+#define AD7606_PM_OPS NULL
+#endif
+
+#endif /* IIO_ADC_AD7606_H_ */
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
new file mode 100644
index 0000000..cd6c410c
--- /dev/null
+++ b/drivers/iio/adc/ad7606_par.c
@@ -0,0 +1,112 @@
+/*
+ * AD7606 Parallel Interface ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <linux/iio/iio.h>
+#include "ad7606.h"
+
+static int ad7606_par16_read_block(struct device *dev,
+				   int count, void *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	insw((unsigned long)st->base_address, buf, count);
+
+	return 0;
+}
+
+static const struct ad7606_bus_ops ad7606_par16_bops = {
+	.read_block	= ad7606_par16_read_block,
+};
+
+static int ad7606_par8_read_block(struct device *dev,
+				  int count, void *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct ad7606_state *st = iio_priv(indio_dev);
+
+	insb((unsigned long)st->base_address, buf, count * 2);
+
+	return 0;
+}
+
+static const struct ad7606_bus_ops ad7606_par8_bops = {
+	.read_block	= ad7606_par8_read_block,
+};
+
+static int ad7606_par_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct resource *res;
+	void __iomem *addr;
+	resource_size_t remap_size;
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "no irq\n");
+		return -ENODEV;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
+
+	remap_size = resource_size(res);
+
+	return ad7606_probe(&pdev->dev, irq, addr,
+			    id->name, id->driver_data,
+			    remap_size > 1 ? &ad7606_par16_bops :
+			    &ad7606_par8_bops);
+}
+
+static int ad7606_par_remove(struct platform_device *pdev)
+{
+	return ad7606_remove(&pdev->dev, platform_get_irq(pdev, 0));
+}
+
+static const struct platform_device_id ad7606_driver_ids[] = {
+	{
+		.name		= "ad7606-8",
+		.driver_data	= ID_AD7606_8,
+	}, {
+		.name		= "ad7606-6",
+		.driver_data	= ID_AD7606_6,
+	}, {
+		.name		= "ad7606-4",
+		.driver_data	= ID_AD7606_4,
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
+
+static struct platform_driver ad7606_driver = {
+	.probe = ad7606_par_probe,
+	.remove	= ad7606_par_remove,
+	.id_table = ad7606_driver_ids,
+	.driver = {
+		.name	 = "ad7606",
+		.pm	 = AD7606_PM_OPS,
+	},
+};
+
+module_platform_driver(ad7606_driver);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
new file mode 100644
index 0000000..c9b1f266
--- /dev/null
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -0,0 +1,78 @@
+/*
+ * AD7606 SPI ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/err.h>
+
+#include <linux/iio/iio.h>
+#include "ad7606.h"
+
+#define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
+
+static int ad7606_spi_read_block(struct device *dev,
+				 int count, void *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	int i, ret;
+	unsigned short *data = buf;
+	__be16 *bdata = buf;
+
+	ret = spi_read(spi, buf, count * 2);
+	if (ret < 0) {
+		dev_err(&spi->dev, "SPI read error\n");
+		return ret;
+	}
+
+	for (i = 0; i < count; i++)
+		data[i] = be16_to_cpu(bdata[i]);
+
+	return 0;
+}
+
+static const struct ad7606_bus_ops ad7606_spi_bops = {
+	.read_block	= ad7606_spi_read_block,
+};
+
+static int ad7606_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+
+	return ad7606_probe(&spi->dev, spi->irq, NULL,
+			    id->name, id->driver_data,
+			    &ad7606_spi_bops);
+}
+
+static int ad7606_spi_remove(struct spi_device *spi)
+{
+	return ad7606_remove(&spi->dev, spi->irq);
+}
+
+static const struct spi_device_id ad7606_id[] = {
+	{"ad7606-8", ID_AD7606_8},
+	{"ad7606-6", ID_AD7606_6},
+	{"ad7606-4", ID_AD7606_4},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad7606_id);
+
+static struct spi_driver ad7606_driver = {
+	.driver = {
+		.name = "ad7606",
+		.pm = AD7606_PM_OPS,
+	},
+	.probe = ad7606_spi_probe,
+	.remove = ad7606_spi_remove,
+	.id_table = ad7606_id,
+};
+module_spi_driver(ad7606_driver);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index deff899..995867b 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -3,40 +3,6 @@
 #
 menu "Analog to digital converters"
 
-config AD7606
-	tristate "Analog Devices AD7606 ADC driver"
-	depends on GPIOLIB || COMPILE_TEST
-	depends on HAS_IOMEM
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for Analog Devices:
-	  ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606.
-
-config AD7606_IFACE_PARALLEL
-	tristate "parallel interface support"
-	depends on AD7606
-	help
-	  Say yes here to include parallel interface support on the AD7606
-	  ADC driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606_parallel.
-
-config AD7606_IFACE_SPI
-	tristate "spi interface support"
-	depends on AD7606
-	depends on SPI
-	help
-	  Say yes here to include parallel interface support on the AD7606
-	  ADC driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7606_spi.
-
 config AD7780
 	tristate "Analog Devices AD7780 and similar ADCs driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index ac09485..549032b 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -2,10 +2,6 @@
 # Makefile for industrial I/O ADC drivers
 #
 
-obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
-obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
-obj-$(CONFIG_AD7606) += ad7606.o
-
 obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_AD7192) += ad7192.o
diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
deleted file mode 100644
index cceb18c..0000000
--- a/drivers/staging/iio/adc/ad7606.c
+++ /dev/null
@@ -1,519 +0,0 @@
-/*
- * AD7606 SPI ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/regulator/consumer.h>
-#include <linux/err.h>
-#include <linux/gpio/consumer.h>
-#include <linux/delay.h>
-#include <linux/sched.h>
-#include <linux/module.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
-
-#include "ad7606.h"
-
-static int ad7606_reset(struct ad7606_state *st)
-{
-	if (st->gpio_reset) {
-		gpiod_set_value(st->gpio_reset, 1);
-		ndelay(100); /* t_reset >= 100ns */
-		gpiod_set_value(st->gpio_reset, 0);
-		return 0;
-	}
-
-	return -ENODEV;
-}
-
-static int ad7606_read_samples(struct ad7606_state *st)
-{
-	unsigned int num = st->chip_info->num_channels;
-	u16 *data = st->data;
-	int ret;
-
-	/*
-	 * The frstdata signal is set to high while and after reading the sample
-	 * of the first channel and low for all other channels. This can be used
-	 * to check that the incoming data is correctly aligned. During normal
-	 * operation the data should never become unaligned, but some glitch or
-	 * electrostatic discharge might cause an extra read or clock cycle.
-	 * Monitoring the frstdata signal allows to recover from such failure
-	 * situations.
-	 */
-
-	if (st->gpio_frstdata) {
-		ret = st->bops->read_block(st->dev, 1, data);
-		if (ret)
-			return ret;
-
-		if (!gpiod_get_value(st->gpio_frstdata)) {
-			ad7606_reset(st);
-			return -EIO;
-		}
-
-		data++;
-		num--;
-	}
-
-	return st->bops->read_block(st->dev, num, data);
-}
-
-static irqreturn_t ad7606_trigger_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf = p;
-	struct ad7606_state *st = iio_priv(pf->indio_dev);
-
-	gpiod_set_value(st->gpio_convst, 1);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring buffer
- * @work_s:	the work struct through which this was scheduled
- *
- * Currently there is no option in this driver to disable the saving of
- * timestamps within the ring.
- * I think the one copy of this at a time was to avoid problems if the
- * trigger was set far too high and the reads then locked up the computer.
- **/
-static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
-{
-	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
-						poll_work);
-	struct iio_dev *indio_dev = iio_priv_to_dev(st);
-	int ret;
-
-	ret = ad7606_read_samples(st);
-	if (ret == 0)
-		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
-						   iio_get_time_ns(indio_dev));
-
-	gpiod_set_value(st->gpio_convst, 0);
-	iio_trigger_notify_done(indio_dev->trig);
-}
-
-static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-	int ret;
-
-	st->done = false;
-	gpiod_set_value(st->gpio_convst, 1);
-
-	ret = wait_event_interruptible(st->wq_data_avail, st->done);
-	if (ret)
-		goto error_ret;
-
-	ret = ad7606_read_samples(st);
-	if (ret == 0)
-		ret = st->data[ch];
-
-error_ret:
-	gpiod_set_value(st->gpio_convst, 0);
-
-	return ret;
-}
-
-static int ad7606_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val,
-			   int *val2,
-			   long m)
-{
-	int ret;
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	switch (m) {
-	case IIO_CHAN_INFO_RAW:
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret)
-			return ret;
-
-		ret = ad7606_scan_direct(indio_dev, chan->address);
-		iio_device_release_direct_mode(indio_dev);
-
-		if (ret < 0)
-			return ret;
-		*val = (short)ret;
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		*val = st->range * 2;
-		*val2 = st->chip_info->channels[0].scan_type.realbits;
-		return IIO_VAL_FRACTIONAL_LOG2;
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		*val = st->oversampling;
-		return IIO_VAL_INT;
-	}
-	return -EINVAL;
-}
-
-static IIO_CONST_ATTR(in_voltage_scale_available, "5000 10000");
-
-static int ad7606_oversampling_get_index(unsigned int val)
-{
-	unsigned char supported[] = {1, 2, 4, 8, 16, 32, 64};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(supported); i++)
-		if (val == supported[i])
-			return i;
-
-	return -EINVAL;
-}
-
-static int ad7606_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val,
-			    int val2,
-			    long mask)
-{
-	struct ad7606_state *st = iio_priv(indio_dev);
-	int values[3];
-	int ret;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		if (val2)
-			return -EINVAL;
-
-		if (!(val == 5000 || val == 10000))
-			return -EINVAL;
-
-		mutex_lock(&indio_dev->mlock);
-		gpiod_set_value(st->gpio_range, val == 10000);
-		st->range = val;
-		mutex_unlock(&indio_dev->mlock);
-
-		return 0;
-	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		if (val2)
-			return -EINVAL;
-		ret = ad7606_oversampling_get_index(val);
-		if (ret < 0)
-			return ret;
-
-		values[0] = (ret >> 0) & 1;
-		values[1] = (ret >> 1) & 1;
-		values[2] = (ret >> 2) & 1;
-
-		mutex_lock(&indio_dev->mlock);
-		gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
-				      values);
-		st->oversampling = val;
-		mutex_unlock(&indio_dev->mlock);
-
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
-static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
-
-static struct attribute *ad7606_attributes_os_and_range[] = {
-	&iio_const_attr_in_voltage_scale_available.dev_attr.attr,
-	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7606_attribute_group_os_and_range = {
-	.attrs = ad7606_attributes_os_and_range,
-};
-
-static struct attribute *ad7606_attributes_os[] = {
-	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7606_attribute_group_os = {
-	.attrs = ad7606_attributes_os,
-};
-
-static struct attribute *ad7606_attributes_range[] = {
-	&iio_const_attr_in_voltage_scale_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7606_attribute_group_range = {
-	.attrs = ad7606_attributes_range,
-};
-
-#define AD7606_CHANNEL(num)					\
-	{							\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = num,					\
-		.address = num,					\
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
-		.info_mask_shared_by_all =			\
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
-		.scan_index = num,				\
-		.scan_type = {					\
-			.sign = 's',				\
-			.realbits = 16,				\
-			.storagebits = 16,			\
-			.endianness = IIO_CPU,			\
-		},						\
-	}
-
-static const struct iio_chan_spec ad7606_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0),
-	AD7606_CHANNEL(1),
-	AD7606_CHANNEL(2),
-	AD7606_CHANNEL(3),
-	AD7606_CHANNEL(4),
-	AD7606_CHANNEL(5),
-	AD7606_CHANNEL(6),
-	AD7606_CHANNEL(7),
-};
-
-static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
-	/*
-	 * More devices added in future
-	 */
-	[ID_AD7606_8] = {
-		.channels = ad7606_channels,
-		.num_channels = 9,
-	},
-	[ID_AD7606_6] = {
-		.channels = ad7606_channels,
-		.num_channels = 7,
-	},
-	[ID_AD7606_4] = {
-		.channels = ad7606_channels,
-		.num_channels = 5,
-	},
-};
-
-static int ad7606_request_gpios(struct ad7606_state *st)
-{
-	struct device *dev = st->dev;
-
-	st->gpio_convst = devm_gpiod_get(dev, "conversion-start",
-					 GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_convst))
-		return PTR_ERR(st->gpio_convst);
-
-	st->gpio_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_reset))
-		return PTR_ERR(st->gpio_reset);
-
-	st->gpio_range = devm_gpiod_get_optional(dev, "range", GPIOD_OUT_LOW);
-	if (IS_ERR(st->gpio_range))
-		return PTR_ERR(st->gpio_range);
-
-	st->gpio_standby = devm_gpiod_get_optional(dev, "standby",
-						   GPIOD_OUT_HIGH);
-	if (IS_ERR(st->gpio_standby))
-		return PTR_ERR(st->gpio_standby);
-
-	st->gpio_frstdata = devm_gpiod_get_optional(dev, "first-data",
-						    GPIOD_IN);
-	if (IS_ERR(st->gpio_frstdata))
-		return PTR_ERR(st->gpio_frstdata);
-
-	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
-			GPIOD_OUT_LOW);
-	return PTR_ERR_OR_ZERO(st->gpio_os);
-}
-
-/**
- *  Interrupt handler
- */
-static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
-{
-	struct iio_dev *indio_dev = dev_id;
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	if (iio_buffer_enabled(indio_dev)) {
-		schedule_work(&st->poll_work);
-	} else {
-		st->done = true;
-		wake_up_interruptible(&st->wq_data_avail);
-	}
-
-	return IRQ_HANDLED;
-};
-
-static const struct iio_info ad7606_info_no_os_or_range = {
-	.driver_module = THIS_MODULE,
-	.read_raw = &ad7606_read_raw,
-};
-
-static const struct iio_info ad7606_info_os_and_range = {
-	.driver_module = THIS_MODULE,
-	.read_raw = &ad7606_read_raw,
-	.write_raw = &ad7606_write_raw,
-	.attrs = &ad7606_attribute_group_os_and_range,
-};
-
-static const struct iio_info ad7606_info_os = {
-	.driver_module = THIS_MODULE,
-	.read_raw = &ad7606_read_raw,
-	.write_raw = &ad7606_write_raw,
-	.attrs = &ad7606_attribute_group_os,
-};
-
-static const struct iio_info ad7606_info_range = {
-	.driver_module = THIS_MODULE,
-	.read_raw = &ad7606_read_raw,
-	.attrs = &ad7606_attribute_group_range,
-};
-
-int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-		 const char *name, unsigned int id,
-		 const struct ad7606_bus_ops *bops)
-{
-	struct ad7606_state *st;
-	int ret;
-	struct iio_dev *indio_dev;
-
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	st = iio_priv(indio_dev);
-
-	st->dev = dev;
-	st->bops = bops;
-	st->base_address = base_address;
-	st->range = 5000;
-	st->oversampling = 1;
-	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
-
-	st->reg = devm_regulator_get(dev, "avcc");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(dev, "Failed to enable specified AVcc supply\n");
-		return ret;
-	}
-
-	ret = ad7606_request_gpios(st);
-	if (ret)
-		goto error_disable_reg;
-
-	st->chip_info = &ad7606_chip_info_tbl[id];
-
-	indio_dev->dev.parent = dev;
-	if (st->gpio_os) {
-		if (st->gpio_range)
-			indio_dev->info = &ad7606_info_os_and_range;
-		else
-			indio_dev->info = &ad7606_info_os;
-	} else {
-		if (st->gpio_range)
-			indio_dev->info = &ad7606_info_range;
-		else
-			indio_dev->info = &ad7606_info_no_os_or_range;
-	}
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = name;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = st->chip_info->num_channels;
-
-	init_waitqueue_head(&st->wq_data_avail);
-
-	ret = ad7606_reset(st);
-	if (ret)
-		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
-
-	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
-			  indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	ret = iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
-					 NULL, NULL);
-	if (ret)
-		goto error_free_irq;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_unregister_ring;
-
-	dev_set_drvdata(dev, indio_dev);
-
-	return 0;
-error_unregister_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-
-error_free_irq:
-	free_irq(irq, indio_dev);
-
-error_disable_reg:
-	regulator_disable(st->reg);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(ad7606_probe);
-
-int ad7606_remove(struct device *dev, int irq)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	free_irq(irq, indio_dev);
-	regulator_disable(st->reg);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ad7606_remove);
-
-#ifdef CONFIG_PM_SLEEP
-
-static int ad7606_suspend(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, 1);
-		gpiod_set_value(st->gpio_standby, 0);
-	}
-
-	return 0;
-}
-
-static int ad7606_resume(struct device *dev)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	if (st->gpio_standby) {
-		gpiod_set_value(st->gpio_range, st->range == 10000);
-		gpiod_set_value(st->gpio_standby, 1);
-		ad7606_reset(st);
-	}
-
-	return 0;
-}
-
-SIMPLE_DEV_PM_OPS(ad7606_pm_ops, ad7606_suspend, ad7606_resume);
-EXPORT_SYMBOL_GPL(ad7606_pm_ops);
-
-#endif
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
deleted file mode 100644
index 746f955..0000000
--- a/drivers/staging/iio/adc/ad7606.h
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * AD7606 ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#ifndef IIO_ADC_AD7606_H_
-#define IIO_ADC_AD7606_H_
-
-/**
- * struct ad7606_chip_info - chip specific information
- * @name:		identification string for chip
- * @channels:		channel specification
- * @num_channels:	number of channels
- */
-
-struct ad7606_chip_info {
-	const struct iio_chan_spec	*channels;
-	unsigned int			num_channels;
-};
-
-/**
- * struct ad7606_state - driver instance specific data
- */
-
-struct ad7606_state {
-	struct device			*dev;
-	const struct ad7606_chip_info	*chip_info;
-	struct regulator		*reg;
-	struct work_struct		poll_work;
-	wait_queue_head_t		wq_data_avail;
-	const struct ad7606_bus_ops	*bops;
-	unsigned int			range;
-	unsigned int			oversampling;
-	bool				done;
-	void __iomem			*base_address;
-
-	struct gpio_desc		*gpio_convst;
-	struct gpio_desc		*gpio_reset;
-	struct gpio_desc		*gpio_range;
-	struct gpio_desc		*gpio_standby;
-	struct gpio_desc		*gpio_frstdata;
-	struct gpio_descs		*gpio_os;
-
-	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
-	 * 8 * 16-bit samples + 64-bit timestamp
-	 */
-	unsigned short			data[12] ____cacheline_aligned;
-};
-
-struct ad7606_bus_ops {
-	/* more methods added in future? */
-	int (*read_block)(struct device *, int, void *);
-};
-
-int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-		 const char *name, unsigned int id,
-		 const struct ad7606_bus_ops *bops);
-int ad7606_remove(struct device *dev, int irq);
-
-enum ad7606_supported_device_ids {
-	ID_AD7606_8,
-	ID_AD7606_6,
-	ID_AD7606_4
-};
-
-#ifdef CONFIG_PM_SLEEP
-extern const struct dev_pm_ops ad7606_pm_ops;
-#define AD7606_PM_OPS (&ad7606_pm_ops)
-#else
-#define AD7606_PM_OPS NULL
-#endif
-
-#endif /* IIO_ADC_AD7606_H_ */
diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
deleted file mode 100644
index cd6c410c..0000000
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ /dev/null
@@ -1,112 +0,0 @@
-/*
- * AD7606 Parallel Interface ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/types.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
-#include <linux/iio/iio.h>
-#include "ad7606.h"
-
-static int ad7606_par16_read_block(struct device *dev,
-				   int count, void *buf)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	insw((unsigned long)st->base_address, buf, count);
-
-	return 0;
-}
-
-static const struct ad7606_bus_ops ad7606_par16_bops = {
-	.read_block	= ad7606_par16_read_block,
-};
-
-static int ad7606_par8_read_block(struct device *dev,
-				  int count, void *buf)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct ad7606_state *st = iio_priv(indio_dev);
-
-	insb((unsigned long)st->base_address, buf, count * 2);
-
-	return 0;
-}
-
-static const struct ad7606_bus_ops ad7606_par8_bops = {
-	.read_block	= ad7606_par8_read_block,
-};
-
-static int ad7606_par_probe(struct platform_device *pdev)
-{
-	const struct platform_device_id *id = platform_get_device_id(pdev);
-	struct resource *res;
-	void __iomem *addr;
-	resource_size_t remap_size;
-	int irq;
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq\n");
-		return -ENODEV;
-	}
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	addr = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(addr))
-		return PTR_ERR(addr);
-
-	remap_size = resource_size(res);
-
-	return ad7606_probe(&pdev->dev, irq, addr,
-			    id->name, id->driver_data,
-			    remap_size > 1 ? &ad7606_par16_bops :
-			    &ad7606_par8_bops);
-}
-
-static int ad7606_par_remove(struct platform_device *pdev)
-{
-	return ad7606_remove(&pdev->dev, platform_get_irq(pdev, 0));
-}
-
-static const struct platform_device_id ad7606_driver_ids[] = {
-	{
-		.name		= "ad7606-8",
-		.driver_data	= ID_AD7606_8,
-	}, {
-		.name		= "ad7606-6",
-		.driver_data	= ID_AD7606_6,
-	}, {
-		.name		= "ad7606-4",
-		.driver_data	= ID_AD7606_4,
-	},
-	{ }
-};
-
-MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
-
-static struct platform_driver ad7606_driver = {
-	.probe = ad7606_par_probe,
-	.remove	= ad7606_par_remove,
-	.id_table = ad7606_driver_ids,
-	.driver = {
-		.name	 = "ad7606",
-		.pm	 = AD7606_PM_OPS,
-	},
-};
-
-module_platform_driver(ad7606_driver);
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
deleted file mode 100644
index c9b1f266..0000000
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ /dev/null
@@ -1,78 +0,0 @@
-/*
- * AD7606 SPI ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/module.h>
-#include <linux/spi/spi.h>
-#include <linux/types.h>
-#include <linux/err.h>
-
-#include <linux/iio/iio.h>
-#include "ad7606.h"
-
-#define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
-
-static int ad7606_spi_read_block(struct device *dev,
-				 int count, void *buf)
-{
-	struct spi_device *spi = to_spi_device(dev);
-	int i, ret;
-	unsigned short *data = buf;
-	__be16 *bdata = buf;
-
-	ret = spi_read(spi, buf, count * 2);
-	if (ret < 0) {
-		dev_err(&spi->dev, "SPI read error\n");
-		return ret;
-	}
-
-	for (i = 0; i < count; i++)
-		data[i] = be16_to_cpu(bdata[i]);
-
-	return 0;
-}
-
-static const struct ad7606_bus_ops ad7606_spi_bops = {
-	.read_block	= ad7606_spi_read_block,
-};
-
-static int ad7606_spi_probe(struct spi_device *spi)
-{
-	const struct spi_device_id *id = spi_get_device_id(spi);
-
-	return ad7606_probe(&spi->dev, spi->irq, NULL,
-			    id->name, id->driver_data,
-			    &ad7606_spi_bops);
-}
-
-static int ad7606_spi_remove(struct spi_device *spi)
-{
-	return ad7606_remove(&spi->dev, spi->irq);
-}
-
-static const struct spi_device_id ad7606_id[] = {
-	{"ad7606-8", ID_AD7606_8},
-	{"ad7606-6", ID_AD7606_6},
-	{"ad7606-4", ID_AD7606_4},
-	{}
-};
-MODULE_DEVICE_TABLE(spi, ad7606_id);
-
-static struct spi_driver ad7606_driver = {
-	.driver = {
-		.name = "ad7606",
-		.pm = AD7606_PM_OPS,
-	},
-	.probe = ad7606_spi_probe,
-	.remove = ad7606_spi_remove,
-	.id_table = ad7606_id,
-};
-module_spi_driver(ad7606_driver);
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4

