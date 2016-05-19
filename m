Return-Path: <cristina.moraru09@gmail.com>
From: Cristina Moraru <cristina.moraru09@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	sst@poczta.fm,
	peda@axentia.se,
	mranostay@gmail.com,
	manabian@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	daniel.baluta@intel.com,
	octavian.purdila@intel.com
Cc: Cristina Moraru <cristina.moraru09@gmail.com>
Subject: [PATCH v5] iio: max5487: Add support for Maxim digital potentiometers
Date: Thu, 19 May 2016 08:55:46 +0300
Message-Id: <1463637346-3098-1-git-send-email-cristina.moraru09@gmail.com>
In-Reply-To: <1458818485-2770-1-git-send-email-cristina.moraru09@gmail.com>
References: <1458818485-2770-1-git-send-email-cristina.moraru09@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add implementation for Maxim MAX5487, MAX5488, MAX5489
digital potentiometers.

Datasheet:
http://datasheets.maximintegrated.com/en/ds/MAX5487-MAX5489.pdf

Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
CC: Daniel Baluta <daniel.baluta@intel.com>
---
Changes since v4:
	Add year for copyright
Changes since v3:
        Fix size issue in max5487_write_cmd
        Fix typo
Changes since v2:
        Change switch statement in max5487_write_raw
        to if statement for consistency
        Add blank line before return statement
        Eliminate regmap support and use spi_write
        Use iio_device_register instead of devm_ version
Changes since v1:
        Fix spacing
        Eliminate max5487_cfg struct
        Add kohms as driver data

 drivers/iio/potentiometer/Kconfig   |  11 +++
 drivers/iio/potentiometer/Makefile  |   1 +
 drivers/iio/potentiometer/max5487.c | 161 ++++++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)
 create mode 100644 drivers/iio/potentiometer/max5487.c

diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 6acb238..0941c8d4 100644
--- a/drivers/iio/potentiometer/Kconfig
+++ b/drivers/iio/potentiometer/Kconfig
@@ -15,6 +15,17 @@ config DS1803
 	  To compile this driver as a module, choose M here: the
 	  module will be called ds1803.
 
+config MAX5487
+        tristate "Maxim MAX5487/MAX5488/MAX5489 Digital Potentiometer driver"
+        depends on SPI
+        help
+          Say yes here to build support for the Maxim
+          MAX5487, MAX5488, MAX5489 digital potentiometer
+          chips.
+
+          To compile this driver as a module, choose M here: the
+          module will be called max5487.
+
 config MCP4131
 	tristate "Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X Digital Potentiometer driver"
 	depends on SPI
diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
index 6007faa..8adb58f 100644
--- a/drivers/iio/potentiometer/Makefile
+++ b/drivers/iio/potentiometer/Makefile
@@ -4,6 +4,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_DS1803) += ds1803.o
+obj-$(CONFIG_MAX5487) += max5487.o
 obj-$(CONFIG_MCP4131) += mcp4131.o
 obj-$(CONFIG_MCP4531) += mcp4531.o
 obj-$(CONFIG_TPL0102) += tpl0102.o
diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
new file mode 100644
index 0000000..6c50939
--- /dev/null
+++ b/drivers/iio/potentiometer/max5487.c
@@ -0,0 +1,161 @@
+/*
+ * max5487.c - Support for MAX5487, MAX5488, MAX5489 digital potentiometers
+ *
+ * Copyright (C) 2016 Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/acpi.h>
+
+#include <linux/iio/sysfs.h>
+#include <linux/iio/iio.h>
+
+#define MAX5487_WRITE_WIPER_A	(0x01 << 8)
+#define MAX5487_WRITE_WIPER_B	(0x02 << 8)
+
+/* copy both wiper regs to NV regs */
+#define MAX5487_COPY_AB_TO_NV	(0x23 << 8)
+/* copy both NV regs to wiper regs */
+#define MAX5487_COPY_NV_TO_AB	(0x33 << 8)
+
+#define MAX5487_MAX_POS		255
+
+struct max5487_data {
+	struct spi_device *spi;
+	int kohms;
+};
+
+#define MAX5487_CHANNEL(ch, addr) {				\
+	.type = IIO_RESISTANCE,					\
+	.indexed = 1,						\
+	.output = 1,						\
+	.channel = ch,						\
+	.address = addr,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+}
+
+static const struct iio_chan_spec max5487_channels[] = {
+	MAX5487_CHANNEL(0, MAX5487_WRITE_WIPER_A),
+	MAX5487_CHANNEL(1, MAX5487_WRITE_WIPER_B),
+};
+
+static int max5487_write_cmd(struct spi_device *spi, u16 cmd)
+{
+	return spi_write(spi, (const void *) &cmd, sizeof(u16));
+}
+
+static int max5487_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct max5487_data *data = iio_priv(indio_dev);
+
+	if (mask != IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
+
+	*val = 1000 * data->kohms;
+	*val2 = MAX5487_MAX_POS;
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int max5487_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct max5487_data *data = iio_priv(indio_dev);
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	if (val < 0 || val > MAX5487_MAX_POS)
+		return -EINVAL;
+
+	return max5487_write_cmd(data->spi, chan->address | val);
+}
+
+static const struct iio_info max5487_info = {
+	.read_raw = max5487_read_raw,
+	.write_raw = max5487_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int max5487_spi_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct max5487_data *data;
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	dev_set_drvdata(&spi->dev, indio_dev);
+	data = iio_priv(indio_dev);
+
+	data->spi = spi;
+	data->kohms = id->driver_data;
+
+	indio_dev->info = &max5487_info;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = max5487_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max5487_channels);
+
+	/* restore both wiper regs from NV regs */
+	ret = max5487_write_cmd(data->spi, MAX5487_COPY_NV_TO_AB);
+	if (ret < 0)
+		return ret;
+
+	return iio_device_register(indio_dev);
+}
+
+static int max5487_spi_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
+
+	iio_device_unregister(indio_dev);
+
+	/* save both wiper regs to NV regs */
+	return max5487_write_cmd(spi, MAX5487_COPY_AB_TO_NV);
+}
+
+static const struct spi_device_id max5487_id[] = {
+	{ "MAX5487", 10 },
+	{ "MAX5488", 50 },
+	{ "MAX5489", 100 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max5487_id);
+
+static const struct acpi_device_id max5487_acpi_match[] = {
+	{ "MAX5487", 10 },
+	{ "MAX5488", 50 },
+	{ "MAX5489", 100 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, max5487_acpi_match);
+
+static struct spi_driver max5487_driver = {
+	.driver = {
+		.name = "max5487",
+		.owner = THIS_MODULE,
+		.acpi_match_table = ACPI_PTR(max5487_acpi_match),
+	},
+	.id_table = max5487_id,
+	.probe = max5487_spi_probe,
+	.remove = max5487_spi_remove
+};
+module_spi_driver(max5487_driver);
+
+MODULE_AUTHOR("Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>");
+MODULE_DESCRIPTION("max5487 SPI driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
