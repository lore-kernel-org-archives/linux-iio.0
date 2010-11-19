Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: dac: Enable driver support for AD5444 and AD5446 DA converters
Date: Fri, 19 Nov 2010 12:50:59 +0100
Message-ID: <1290167459-24148-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Enable support for AD5444 and AD5446:  12-/14-Bit High Bandwidth
Multiplying DACs with Serial Interface.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/dac/Kconfig  |   10 ++
 drivers/staging/iio/dac/Makefile |    1 +
 drivers/staging/iio/dac/ad5446.c |  228 ++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/dac/ad5446.h |   44 ++++++++
 4 files changed, 283 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/dac/ad5446.c
 create mode 100644 drivers/staging/iio/dac/ad5446.h

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index 583df78..88914e9 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -9,3 +9,13 @@ config AD5624R_SPI
 	help
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
 	  AD5664R convertors (DAC). This driver uses the common SPI interface.
+
+config AD5446
+	tristate "Analog Devices AD5444, AD5446 DAC SPI driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices AD5444 and AD5446
+	  multiplying DACs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5446.
diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio/dac/Makefile
index 7ddf05d..7cf331b 100644
--- a/drivers/staging/iio/dac/Makefile
+++ b/drivers/staging/iio/dac/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_AD5624R_SPI) += ad5624r_spi.o
+obj-$(CONFIG_AD5446) += ad5446.o
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
new file mode 100644
index 0000000..c70243a
--- /dev/null
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -0,0 +1,228 @@
+/*
+ * AD5446 SPI DAC driver
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
+#include "dac.h"
+
+#include "ad5446.h"
+
+static ssize_t ad5446_write(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad5446_state *st = dev_info->dev_data;
+	int ret;
+	long val;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+
+	if (val > RES_MASK(st->chip_info->bits)) {
+		ret = -EINVAL;
+		goto error_ret;
+	}
+
+	mutex_lock(&dev_info->mlock);
+	st->data = cpu_to_be16(AD5446_LOAD |
+			       (val << st->chip_info->res_shift));
+
+	ret = spi_sync(st->spi, &st->msg);
+	mutex_unlock(&dev_info->mlock);
+
+error_ret:
+	return ret ? ret : len;
+}
+
+static IIO_DEV_ATTR_OUT_RAW(0, ad5446_write, 0);
+
+static ssize_t ad5446_show_scale(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad5446_state *st = iio_dev_get_devdata(dev_info);
+	/* Corresponds to Vref / 2^(bits) */
+	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
+
+	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
+}
+static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5446_show_scale, NULL, 0);
+
+static ssize_t ad5446_show_name(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad5446_state *st = iio_dev_get_devdata(dev_info);
+
+	return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
+}
+static IIO_DEVICE_ATTR(name, S_IRUGO, ad5446_show_name, NULL, 0);
+
+static struct attribute *ad5446_attributes[] = {
+	&iio_dev_attr_out0_raw.dev_attr.attr,
+	&iio_dev_attr_out_scale.dev_attr.attr,
+	&iio_dev_attr_name.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad5446_attribute_group = {
+	.attrs = ad5446_attributes,
+};
+
+static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
+	[ID_AD5444] = {
+		.bits = 12,
+		.storagebits = 16,
+		.res_shift = 2,
+		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+	},
+	[ID_AD5446] = {
+		.bits = 14,
+		.storagebits = 16,
+		.res_shift = 0,
+		.sign = 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
+	},
+};
+
+static int __devinit ad5446_probe(struct spi_device *spi)
+{
+	struct ad5446_state *st;
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
+		&ad5446_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+
+	spi_set_drvdata(spi, st);
+
+	st->spi = spi;
+
+	st->indio_dev = iio_allocate_device();
+	if (st->indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_disable_reg;
+	}
+
+	/* Estabilish that the iio_dev is a child of the spi device */
+	st->indio_dev->dev.parent = &spi->dev;
+	st->indio_dev->attrs = &ad5446_attribute_group;
+	st->indio_dev->dev_data = (void *)(st);
+	st->indio_dev->driver_module = THIS_MODULE;
+	st->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	/* Setup default message */
+
+	st->xfer.rx_buf = NULL;
+	st->xfer.tx_buf = &st->data,
+	st->xfer.len = 2,
+
+	spi_message_init(&st->msg);
+	spi_message_add_tail(&st->xfer, &st->msg);
+
+	if (voltage_uv)
+		st->vref_mv = voltage_uv / 1000;
+	else
+		dev_warn(&spi->dev, "reference voltage unspecified\n");
+
+	ret = iio_device_register(st->indio_dev);
+	if (ret)
+		goto error_free_device;
+
+
+	return 0;
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
+static int ad5446_remove(struct spi_device *spi)
+{
+	struct ad5446_state *st = spi_get_drvdata(spi);
+	struct iio_dev *indio_dev = st->indio_dev;
+
+	iio_device_unregister(indio_dev);
+	if (!IS_ERR(st->reg)) {
+		regulator_disable(st->reg);
+		regulator_put(st->reg);
+	}
+	kfree(st);
+	return 0;
+}
+
+static const struct spi_device_id ad5446_id[] = {
+	{"ad5444", ID_AD5444},
+	{"ad5446", ID_AD5446},
+	{}
+};
+
+static struct spi_driver ad5446_driver = {
+	.driver = {
+		.name	= "ad5446",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad5446_probe,
+	.remove		= __devexit_p(ad5446_remove),
+	.id_table	= ad5446_id,
+};
+
+static int __init ad5446_init(void)
+{
+	return spi_register_driver(&ad5446_driver);
+}
+module_init(ad5446_init);
+
+static void __exit ad5446_exit(void)
+{
+	spi_unregister_driver(&ad5446_driver);
+}
+module_exit(ad5446_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD5444/AD5446 DAC");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:ad5446");
diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
new file mode 100644
index 0000000..3456382
--- /dev/null
+++ b/drivers/staging/iio/dac/ad5446.h
@@ -0,0 +1,44 @@
+/*
+ * AD5446 SPI DAC driver
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+#ifndef IIO_ADC_AD5446_H_
+#define IIO_ADC_AD5446_H_
+
+/* DAC Control Bits */
+
+#define AD5446_LOAD		(0x0 << 14) /* Load and update */
+#define AD5446_SDO_DIS		(0x1 << 14) /* Disable SDO */
+#define AD5446_NOP		(0x2 << 14) /* No operation */
+#define AD5446_CLK_RISING	(0x3 << 14) /* Clock data on rising edge */
+
+#define RES_MASK(bits)	((1 << (bits)) - 1)
+
+struct ad5446_chip_info {
+	u8				bits;
+	u8				storagebits;
+	u8				res_shift;
+	char				sign;
+};
+
+struct ad5446_state {
+	struct iio_dev			*indio_dev;
+	struct spi_device		*spi;
+	const struct ad5446_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct work_struct		poll_work;
+	unsigned short			vref_mv;
+	struct spi_transfer		xfer;
+	struct spi_message		msg;
+	unsigned short			data;
+};
+
+enum ad5446_supported_device_ids {
+	ID_AD5444,
+	ID_AD5446,
+};
+
+#endif /* IIO_ADC_AD5446_H_ */
-- 
1.6.0.2
