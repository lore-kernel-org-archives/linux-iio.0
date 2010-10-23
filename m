Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Sonic Zhang <sonic.zhang@analog.com>
Subject: [PATCH 04/14] staging: iio: adc: new driver for AD7314 devices
Date: Sat, 23 Oct 2010 16:29:07 -0400
Message-Id: <1287865757-1031-4-git-send-email-vapier@gentoo.org>
In-Reply-To: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Sonic Zhang <sonic.zhang@analog.com>

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/adc/Kconfig  |    7 +
 drivers/staging/iio/adc/Makefile |    1 +
 drivers/staging/iio/adc/ad7314.c |  308 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 316 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/adc/ad7314.c

diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 847f5f2..6d3b8bc 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -54,3 +54,10 @@ config AD7298
 	help
 	  Say yes here to build support for Analog Devices AD7298
 	  temperature sensors and ADC.
+
+config AD7314
+	tristate "Analog Devices AD7314 temperature sensor driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices AD7314
+	  temperature sensors.
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index d0ea747..04fd93b 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_AD7150) += ad7150.o
 obj-$(CONFIG_AD7152) += ad7152.o
 obj-$(CONFIG_AD7291) += ad7291.o
 obj-$(CONFIG_AD7298) += ad7298.o
+obj-$(CONFIG_AD7314) += ad7314.o
diff --git a/drivers/staging/iio/adc/ad7314.c b/drivers/staging/iio/adc/ad7314.c
new file mode 100644
index 0000000..8c17b1f
--- /dev/null
+++ b/drivers/staging/iio/adc/ad7314.c
@@ -0,0 +1,308 @@
+/*
+ * AD7314 digital temperature sensor driver for AD7314, ADT7301 and ADT7302
+ *
+ * Copyright 2010 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
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
+#include <linux/rtc.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+
+/*
+ * AD7314 power mode
+ */
+#define AD7314_PD		0x2000
+
+/*
+ * AD7314 temperature masks
+ */
+#define AD7314_TEMP_SIGN		0x200
+#define AD7314_TEMP_MASK		0x7FE0
+#define AD7314_TEMP_OFFSET		5
+#define AD7314_TEMP_FLOAT_OFFSET	2
+#define AD7314_TEMP_FLOAT_MASK		0x3
+
+/*
+ * ADT7301 and ADT7302 temperature masks
+ */
+#define ADT7301_TEMP_SIGN		0x2000
+#define ADT7301_TEMP_MASK		0x2FFF
+#define ADT7301_TEMP_FLOAT_OFFSET	5
+#define ADT7301_TEMP_FLOAT_MASK		0x1F
+
+/*
+ * struct ad7314_chip_info - chip specifc information
+ */
+
+struct ad7314_chip_info {
+	const char *name;
+	struct spi_device *spi_dev;
+	struct iio_dev *indio_dev;
+	s64 last_timestamp;
+	u8  mode;
+};
+
+/*
+ * ad7314 register access by SPI
+ */
+
+static int ad7314_spi_read(struct ad7314_chip_info *chip, u16 *data)
+{
+	struct spi_device *spi_dev = chip->spi_dev;
+	int ret = 0;
+	u16 value;
+
+	ret = spi_read(spi_dev, (u8 *)&value, sizeof(value));
+	if (ret < 0) {
+		dev_err(&spi_dev->dev, "SPI read error\n");
+		return ret;
+	}
+
+	*data = be16_to_cpu((u16)value);
+
+	return ret;
+}
+
+static int ad7314_spi_write(struct ad7314_chip_info *chip, u16 data)
+{
+	struct spi_device *spi_dev = chip->spi_dev;
+	int ret = 0;
+	u16 value = cpu_to_be16(data);
+
+	ret = spi_write(spi_dev, (u8 *)&value, sizeof(value));
+	if (ret < 0)
+		dev_err(&spi_dev->dev, "SPI write error\n");
+
+	return ret;
+}
+
+static ssize_t ad7314_show_mode(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad7314_chip_info *chip = dev_info->dev_data;
+
+	if (chip->mode)
+		return sprintf(buf, "power-save\n");
+	else
+		return sprintf(buf, "full\n");
+}
+
+static ssize_t ad7314_store_mode(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad7314_chip_info *chip = dev_info->dev_data;
+	u16 mode = 0;
+	int ret;
+
+	if (!strcmp(buf, "full"))
+		mode = AD7314_PD;
+
+	ret = ad7314_spi_write(chip, mode);
+	if (ret)
+		return -EIO;
+
+	chip->mode = mode;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
+		ad7314_show_mode,
+		ad7314_store_mode,
+		0);
+
+static ssize_t ad7314_show_available_modes(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	return sprintf(buf, "full\npower-save\n");
+}
+
+static IIO_DEVICE_ATTR(available_modes, S_IRUGO, ad7314_show_available_modes, NULL, 0);
+
+static ssize_t ad7314_show_temperature(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad7314_chip_info *chip = dev_info->dev_data;
+	u16 data;
+	char sign = ' ';
+	int ret;
+
+	if (chip->mode) {
+		ret = ad7314_spi_write(chip, 0);
+		if (ret)
+			return -EIO;
+	}
+
+	ret = ad7314_spi_read(chip, &data);
+	if (ret)
+		return -EIO;
+
+	if (chip->mode)
+		ad7314_spi_write(chip, chip->mode);
+
+	if (strcmp(chip->name, "ad7314")) {
+		data = (data & AD7314_TEMP_MASK) >>
+			AD7314_TEMP_OFFSET;
+		if (data & AD7314_TEMP_SIGN) {
+			data = (AD7314_TEMP_SIGN << 1) - data;
+			sign = '-';
+		}
+
+		return sprintf(buf, "%c%d.%.2d\n", sign,
+				data >> AD7314_TEMP_FLOAT_OFFSET,
+				(data & AD7314_TEMP_FLOAT_MASK) * 25);
+	} else {
+		data &= ADT7301_TEMP_MASK;
+		if (data & ADT7301_TEMP_SIGN) {
+			data = (ADT7301_TEMP_SIGN << 1) - data;
+			sign = '-';
+		}
+
+		return sprintf(buf, "%c%d.%.5d\n", sign,
+				data >> ADT7301_TEMP_FLOAT_OFFSET,
+				(data & ADT7301_TEMP_FLOAT_MASK) * 3125);
+	}
+}
+
+static IIO_DEVICE_ATTR(temperature, S_IRUGO, ad7314_show_temperature, NULL, 0);
+
+static ssize_t ad7314_show_name(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *dev_info = dev_get_drvdata(dev);
+	struct ad7314_chip_info *chip = dev_info->dev_data;
+	return sprintf(buf, "%s\n", chip->name);
+}
+
+static IIO_DEVICE_ATTR(name, S_IRUGO, ad7314_show_name, NULL, 0);
+
+static struct attribute *ad7314_attributes[] = {
+	&iio_dev_attr_available_modes.dev_attr.attr,
+	&iio_dev_attr_mode.dev_attr.attr,
+	&iio_dev_attr_temperature.dev_attr.attr,
+	&iio_dev_attr_name.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7314_attribute_group = {
+	.attrs = ad7314_attributes,
+};
+
+/*
+ * device probe and remove
+ */
+
+static int __devinit ad7314_probe(struct spi_device *spi_dev)
+{
+	struct ad7314_chip_info *chip;
+	int ret = 0;
+
+	chip = kzalloc(sizeof(struct ad7314_chip_info), GFP_KERNEL);
+
+	if (chip == NULL)
+		return -ENOMEM;
+
+	/* this is only used for device removal purposes */
+	dev_set_drvdata(&spi_dev->dev, chip);
+
+	chip->spi_dev = spi_dev;
+	chip->name = spi_dev->modalias;
+
+	chip->indio_dev = iio_allocate_device();
+	if (chip->indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_free_chip;
+	}
+
+	chip->indio_dev->dev.parent = &spi_dev->dev;
+	chip->indio_dev->attrs = &ad7314_attribute_group;
+	chip->indio_dev->dev_data = (void *)chip;
+	chip->indio_dev->driver_module = THIS_MODULE;
+
+	ret = iio_device_register(chip->indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	dev_info(&spi_dev->dev, "%s temperature sensor registered.\n",
+			 chip->name);
+
+	return 0;
+error_free_dev:
+	iio_free_device(chip->indio_dev);
+error_free_chip:
+	kfree(chip);
+
+	return ret;
+}
+
+static int __devexit ad7314_remove(struct spi_device *spi_dev)
+{
+	struct ad7314_chip_info *chip = dev_get_drvdata(&spi_dev->dev);
+	struct iio_dev *indio_dev = chip->indio_dev;
+
+	dev_set_drvdata(&spi_dev->dev, NULL);
+	if (spi_dev->irq)
+		iio_unregister_interrupt_line(indio_dev, 0);
+	iio_device_unregister(indio_dev);
+	iio_free_device(chip->indio_dev);
+	kfree(chip);
+
+	return 0;
+}
+
+static const struct spi_device_id ad7314_id[] = {
+	{ "adt7301", 0 },
+	{ "adt7302", 0 },
+	{ "ad7314", 0 },
+	{}
+};
+
+static struct spi_driver ad7314_driver = {
+	.driver = {
+		.name = "ad7314",
+		.bus = &spi_bus_type,
+		.owner = THIS_MODULE,
+	},
+	.probe = ad7314_probe,
+	.remove = __devexit_p(ad7314_remove),
+	.id_table = ad7314_id,
+};
+
+static __init int ad7314_init(void)
+{
+	return spi_register_driver(&ad7314_driver);
+}
+
+static __exit void ad7314_exit(void)
+{
+	spi_unregister_driver(&ad7314_driver);
+}
+
+MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7314, ADT7301 and ADT7302 digital"
+			" temperature sensor driver");
+MODULE_LICENSE("GPL v2");
+
+module_init(ad7314_init);
+module_exit(ad7314_exit);
-- 
1.7.3.2
