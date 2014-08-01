Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:60009 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbaHAHzb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Aug 2014 03:55:31 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so3857889wgh.5
        for <linux-iio@vger.kernel.org>; Fri, 01 Aug 2014 00:55:28 -0700 (PDT)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH v4] iio: adc: Add TI ADC128S052
Date: Fri,  1 Aug 2014 09:55:14 +0200
Message-Id: <1406879714-8289-1-git-send-email-angelo.compagnucci@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for ADC128S052 from TI.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---

* Fixed spi_set_drvdata(spi, indio_dev); in adc128_probe.

 drivers/iio/adc/Kconfig         |  10 +++
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/ti-adc128s052.c | 179 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/iio/adc/ti-adc128s052.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 11b048a..3ea56a3 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -216,6 +216,16 @@ config TI_ADC081C
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-adc081c.
 
+config TI_ADC128S052
+	tristate "Texas Instruments ADC128S052"
+	depends on SPI
+	help
+	  If you say yes here you get support for Texas Instruments ADC128S052
+	  chip.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-adc128s052.
+
 config TI_AM335X_ADC
 	tristate "TI's AM335X ADC driver"
 	depends on MFD_TI_AM335X_TSCADC
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ad81b51..9cc37f6 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
+obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
 obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
 obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
new file mode 100644
index 0000000..56b78b0
--- /dev/null
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -0,0 +1,179 @@
+/*
+ * Copyright (C) 2014 Angelo Compagnucci <angelo.compagnucci@gmail.com>
+ *
+ * Driver for Texas Instruments' ADC128S052 ADC chip.
+ * Datasheet can be found here:
+ * http://www.ti.com/lit/ds/symlink/adc128s052.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/iio/iio.h>
+#include <linux/regulator/consumer.h>
+
+struct adc128 {
+	struct spi_device *spi;
+
+	struct regulator *reg;
+	struct mutex lock;
+
+	u8 buffer[2] ____cacheline_aligned;
+};
+
+static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
+{
+	int ret;
+
+	mutex_lock(&adc->lock);
+
+	adc->buffer[0] = channel << 3;
+	adc->buffer[1] = 0;
+
+	ret = spi_write(adc->spi, &adc->buffer, 2);
+	if (ret < 0) {
+		mutex_unlock(&adc->lock);
+		return ret;
+	}
+
+	ret = spi_read(adc->spi, &adc->buffer, 2);
+
+	mutex_unlock(&adc->lock);
+
+	if (ret < 0)
+		return ret;
+
+	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
+}
+
+static int adc128_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *channel, int *val,
+			   int *val2, long mask)
+{
+	struct adc128 *adc = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+
+		ret = adc128_adc_conversion(adc, channel->channel);
+		if (ret < 0)
+			return -EINVAL;
+
+		*val = ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+
+		ret = regulator_get_voltage(adc->reg);
+		if (ret < 0)
+			return -EINVAL;
+
+		*val = ret / 1000;
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+
+}
+
+#define ADC128_VOLTAGE_CHANNEL(num)	\
+	{ \
+		.type = IIO_VOLTAGE, \
+		.indexed = 1, \
+		.channel = (num), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
+	}
+
+static const struct iio_chan_spec adc128_channels[] = {
+	ADC128_VOLTAGE_CHANNEL(0),
+	ADC128_VOLTAGE_CHANNEL(1),
+	ADC128_VOLTAGE_CHANNEL(2),
+	ADC128_VOLTAGE_CHANNEL(3),
+	ADC128_VOLTAGE_CHANNEL(4),
+	ADC128_VOLTAGE_CHANNEL(5),
+	ADC128_VOLTAGE_CHANNEL(6),
+	ADC128_VOLTAGE_CHANNEL(7),
+};
+
+static const struct iio_info adc128_info = {
+	.read_raw = adc128_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int adc128_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adc128 *adc;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+	adc->spi = spi;
+
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &adc128_info;
+
+	indio_dev->channels = adc128_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adc128_channels);
+
+	adc->reg = devm_regulator_get(&spi->dev, "vref");
+	if (IS_ERR(adc->reg))
+		return PTR_ERR(adc->reg);
+
+	ret = regulator_enable(adc->reg);
+	if (ret < 0)
+		return ret;
+
+	mutex_init(&adc->lock);
+
+	ret = iio_device_register(indio_dev);
+
+	return ret;
+}
+
+static int adc128_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct adc128 *adc = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	regulator_disable(adc->reg);
+
+	return 0;
+}
+
+static const struct spi_device_id adc128_id[] = {
+	{ "adc128s052", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adc128_id);
+
+static struct spi_driver adc128_driver = {
+	.driver = {
+		.name = "adc128s052",
+		.owner = THIS_MODULE,
+	},
+	.probe = adc128_probe,
+	.remove = adc128_remove,
+	.id_table = adc128_id,
+};
+module_spi_driver(adc128_driver);
+
+MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
+MODULE_DESCRIPTION("Texas Instruments ADC128S052");
+MODULE_LICENSE("GPL v2");
-- 
2.0.3

