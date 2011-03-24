Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: ADC: New driver for the AD7880 / AD7781 24-bit Sigma-Delta ADC
Date: Thu, 24 Mar 2011 15:10:14 +0100
Message-ID: <1300975814-14423-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/Kconfig  |   11 ++
 drivers/staging/iio/adc/Makefile |    1 +
 drivers/staging/iio/adc/ad7780.c |  324 ++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/ad7780.h |   20 +++
 4 files changed, 356 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/adc/ad7780.c
 create mode 100644 drivers/staging/iio/adc/ad7780.h

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 6692a3d..4159389 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -142,6 +142,17 @@ config AD7887
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7887.
 
+config AD7780
+	tristate "Analog Devices AD7780 AD7781 ADC driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices
+	  AD7780 and AD7781 SPI analog to digital convertors (ADC).
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7780.
+
 config AD7745
 	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
 	depends on I2C
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 31067de..1d9b3f5 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_AD7152) += ad7152.o
 obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7314) += ad7314.o
 obj-$(CONFIG_AD7745) += ad7745.o
+obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_ADT75) += adt75.o
 obj-$(CONFIG_ADT7310) += adt7310.o
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
new file mode 100644
index 0000000..eba733d
--- /dev/null
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -0,0 +1,324 @@
+/*
+ * AD7780/AD7781 SPI ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
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
+#include <linux/sched.h>
+#include <linux/gpio.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+#include "../ring_generic.h"
+#include "adc.h"
+
+#include "ad7780.h"
+
+#define AD7780_RDY	(1 << 7)
+#define AD7780_FILTER	(1 << 6)
+#define AD7780_ERR	(1 << 5)
+#define AD7780_ID1	(1 << 4)
+#define AD7780_ID0	(1 << 3)
+#define AD7780_GAIN	(1 << 2)
+#define AD7780_PAT1	(1 << 1)
+#define AD7780_PAT0	(1 << 0)
+
+struct ad7780_chip_info {
+	u8				bits;
+	u8				storagebits;
+	u8				res_shift;
+};
+
+struct ad7780_state {
+	struct iio_dev			*indio_dev;
+	struct spi_device		*spi;
+	const struct ad7780_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct ad7780_platform_data	*pdata;
+	wait_queue_head_t		wq_data_avail;
+	bool				done;
+	u16				int_vref_mv;
+	struct spi_transfer		xfer;
+	struct spi_message		msg;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	unsigned char			data[4] ____cacheline_aligned;
+};
+
+enum ad7780_supported_device_ids {
+	ID_AD7780,
+	ID_AD7781,
+};
+
+static int ad7780_read(struct ad7780_state *st, int *val)
+{
+	int ret;
+
+	spi_bus_lock(st->spi->master);
+
+	enable_irq(st->spi->irq);
+	st->done = false;
+	gpio_set_value(st->pdata->gpio_pdrst, 1);
+
+	ret = wait_event_interruptible(st->wq_data_avail, st->done);
+	disable_irq_nosync(st->spi->irq);
+	if (ret)
+		goto out;
+
+	ret = spi_sync_locked(st->spi, &st->msg);
+	*val = be32_to_cpu(st->data);
+out:
+	gpio_set_value(st->pdata->gpio_pdrst, 0);
+	spi_bus_unlock(st->spi->master);
+
+	return ret;
+}
+
+static ssize_t ad7780_scan(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad7780_state *st = dev_info->dev_data;
+	int ret, val, smpl;
+
+	mutex_lock(&dev_info->mlock);
+	ret = ad7780_read(st, &smpl);
+	mutex_unlock(&dev_info->mlock);
+
+	if (ret < 0)
+		return ret;
+
+	if ((smpl & AD7780_ERR) ||
+		!((smpl & AD7780_PAT0) && !(smpl & AD7780_PAT1)))
+		return -EIO;
+
+	val = (smpl >> st->chip_info->res_shift) &
+		((1 << (st->chip_info->bits)) - 1);
+	val -= (1 << (st->chip_info->bits - 1));
+
+	if (!(smpl & AD7780_GAIN))
+		val *= 128;
+
+	return sprintf(buf, "%d\n", val);
+}
+static IIO_DEV_ATTR_IN_RAW(0, ad7780_scan, 0);
+
+static ssize_t ad7780_show_scale(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad7780_state *st = iio_dev_get_devdata(dev_info);
+	/* Corresponds to Vref / 2^(bits-1) */
+	unsigned int scale = (st->int_vref_mv * 100000) >>
+		(st->chip_info->bits - 1);
+
+	return sprintf(buf, "%d.%05d\n", scale / 100000, scale % 100000);
+}
+static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7780_show_scale, NULL, 0);
+
+static ssize_t ad7780_show_name(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad7780_state *st = iio_dev_get_devdata(dev_info);
+
+	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
+}
+static IIO_DEVICE_ATTR(name, S_IRUGO, ad7780_show_name, NULL, 0);
+
+static struct attribute *ad7780_attributes[] = {
+	&iio_dev_attr_in0_raw.dev_attr.attr,
+	&iio_dev_attr_in_scale.dev_attr.attr,
+	&iio_dev_attr_name.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7780_attribute_group = {
+	.attrs = ad7780_attributes,
+};
+
+static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
+	[ID_AD7780] = {
+		.bits = 24,
+		.storagebits = 32,
+		.res_shift = 8,
+	},
+	[ID_AD7781] = {
+		.bits = 20,
+		.storagebits = 32,
+		.res_shift = 12,
+	},
+};
+
+/**
+ *  Interrupt handler
+ */
+static irqreturn_t ad7780_interrupt(int irq, void *dev_id)
+{
+	struct ad7780_state *st = dev_id;
+
+	st->done = true;
+	wake_up_interruptible(&st->wq_data_avail);
+
+	return IRQ_HANDLED;
+};
+
+static int __devinit ad7780_probe(struct spi_device *spi)
+{
+	struct ad7780_platform_data *pdata = spi->dev.platform_data;
+	struct ad7780_state *st;
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
+		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+
+	st->pdata = pdata;
+
+	if (pdata && pdata->vref_mv)
+		st->int_vref_mv = pdata->vref_mv;
+	else if (voltage_uv)
+		st->int_vref_mv = voltage_uv / 1000;
+	else
+		dev_warn(&spi->dev, "reference voltage unspecified\n");
+
+	spi_set_drvdata(spi, st);
+	st->spi = spi;
+
+	st->indio_dev = iio_allocate_device();
+	if (st->indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_disable_reg;
+	}
+
+	/* Establish that the iio_dev is a child of the spi device */
+	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->attrs = &ad7780_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	init_waitqueue_head(&st->wq_data_avail);
+
+	/* Setup default message */
+
+	st->xfer.rx_buf = &st->data;
+	st->xfer.len = st->chip_info->storagebits / 8;
+
+	spi_message_init(&st->msg);
+	spi_message_add_tail(&st->xfer, &st->msg);
+
+	ret = gpio_request_one(st->pdata->gpio_pdrst, GPIOF_OUT_INIT_LOW,
+			       "AD7877 /PDRST");
+	if (ret) {
+		dev_err(&spi->dev, "failed to request GPIO PDRST\n");
+		goto error_free_device;
+	}
+
+	ret = request_irq(spi->irq, ad7780_interrupt,
+		IRQF_TRIGGER_FALLING, spi_get_device_id(spi)->name, st);
+	if (ret)
+		goto error_free_device;
+
+	disable_irq(spi->irq);
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_free_irq;
+
+	return 0;
+
+error_free_irq:
+	free_irq(spi->irq, st);
+
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
+static int ad7780_remove(struct spi_device *spi)
+{
+	struct ad7780_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+	free_irq(spi->irq, st);
+	gpio_free(st->pdata->gpio_pdrst);
+	iio_device_unregister(indio_dev);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
+	}
+	kfree(st);
+	return 0;
+}
+
+static const struct spi_device_id ad7780_id[] = {
+	{"ad7780", ID_AD7780},
+	{"ad7781", ID_AD7781},
+	{}
+};
+
+static struct spi_driver ad7780_driver = {
+	.driver = {
+		.name	= "ad7780",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad7780_probe,
+	.remove		= __devexit_p(ad7780_remove),
+	.id_table	= ad7780_id,
+};
+
+static int __init ad7780_init(void)
+{
+	return spi_register_driver(&ad7780_driver);
+}
+module_init(ad7780_init);
+
+static void __exit ad7780_exit(void)
+{
+	spi_unregister_driver(&ad7780_driver);
+}
+module_exit(ad7780_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD7780/1 ADC");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/ad7780.h b/drivers/staging/iio/adc/ad7780.h
new file mode 100644
index 0000000..ec77486
--- /dev/null
+++ b/drivers/staging/iio/adc/ad7780.h
@@ -0,0 +1,20 @@
+/*
+ * AD7780/AD7781 SPI ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+#ifndef IIO_ADC_AD7780_H_
+#define IIO_ADC_AD7780_H_
+
+/*
+ * TODO: struct ad7780_platform_data needs to go into include/linux/iio
+ */
+
+struct ad7780_platform_data {
+	u16				vref_mv;
+	int				gpio_pdrst;
+};
+
+#endif /* IIO_ADC_AD7780_H_ */
-- 
1.6.0.2
