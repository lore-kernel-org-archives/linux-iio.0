Return-Path: <SRS0=s/xG=MX=rockwellcollins.com=matthew.weber@kernel.org>
From: Matt Weber <matthew.weber@rockwellcollins.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
	Matt Weber <matthew.weber@rockwellcollins.com>
Subject: [PATCH v2 1/2] iio:temperature: Add MAX31856 thermocouple support
Date: Thu, 11 Oct 2018 11:38:09 -0500
Message-Id: <1539275890-38141-1-git-send-email-matthew.weber@rockwellcollins.com>
List-ID: <linux-iio@vger.kernel.org>

From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>

This patch adds support for Maxim MAX31856 thermocouple
temperature sensor support.

More information can be found in:
https://www.maximintegrated.com/en/ds/MAX31856.pdf

NOTE: Driver support only Comparator Mode.

Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
---
Changes v1 -> v2
[Peter
	1. Fixed all space & 'return' related comments
	2. Removed 'sysfs_create_group' api  because
	   iio_device_register function is handling sysfs entry
	3. Return -EIO if there is any fault
	4. Added check for 'read_size' before spi read call
	5. Removed license text from the source file
	6. Added .o file in alphabetic order
	7. Used #defines instead of magic bits

---
 MAINTAINERS                        |   5 +
 drivers/iio/temperature/Kconfig    |  10 +
 drivers/iio/temperature/Makefile   |   1 +
 drivers/iio/temperature/max31856.c | 372 +++++++++++++++++++++++++++++++++++++
 4 files changed, 388 insertions(+)
 create mode 100644 drivers/iio/temperature/max31856.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f642044..dd9a83d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7157,6 +7157,11 @@ F:	drivers/staging/iio/
 F:	include/linux/iio/
 F:	tools/iio/
 
+MAX31856 IIO DRIVER
+M:	Matthew Weber <matthew.weber@rockwellcollins.com>
+S:	Maintained
+F:	drivers/iio/temperature/max31856.c
+
 IIO UNIT CONVERTER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 82e4a62..c66eeb2 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -97,4 +97,14 @@ config TSYS02D
 	  This driver can also be built as a module. If so, the module will
 	  be called tsys02d.
 
+config MAX31856
+	tristate "MAX31856 thermocouple sensor"
+	depends on SPI
+	help
+	  If you say yes here you get support for MAX31856
+	  thermocouple sensor chip connected via SPI.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max31856.
+
 endmenu
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 34a31db..baca477 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
+obj-$(CONFIG_MAX31856) += max31856.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
 obj-$(CONFIG_TMP006) += tmp006.o
diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
new file mode 100644
index 0000000..b66ddb0
--- /dev/null
+++ b/drivers/iio/temperature/max31856.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0
+/* max31856.c
+ *
+ * Maxim MAX31856 thermocouple sensor driver
+ *
+ * Copyright (C) 2018 Rockwell Collins
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define MAX31856_READ_MODE	   0x7F
+#define MAX31856_WRITE_MODE	   0x80
+#define MAX31856_CR0_AUTOCONVERT   0x80
+#define MAX31856_CR0_1SHOT         0x40
+#define MAX31856_CR0_OCFAULT1      0x20
+#define MAX31856_CR0_OCFAULT0      0x10
+#define MAX31856_FAULT_OVUV        0x02
+#define MAX31856_FAULT_OPEN        0x01
+
+/* The MAX31856 registers */
+#define MAX31856_CR0_REG           0x00
+#define MAX31856_CR1_REG           0x01
+#define MAX31856_MASK_REG          0x02
+#define MAX31856_CJHF_REG          0x03
+#define MAX31856_CJLF_REG          0x04
+#define MAX31856_LTHFTH_REG        0x05
+#define MAX31856_LTHFTL_REG        0x06
+#define MAX31856_LTLFTH_REG        0x07
+#define MAX31856_LTLFTL_REG        0x08
+#define MAX31856_CJTO_REG          0x09
+#define MAX31856_CJTH_REG          0x0A
+#define MAX31856_CJTL_REG          0x0B
+#define MAX31856_LTCBH_REG         0x0C
+#define MAX31856_LTCBM_REG         0x0D
+#define MAX31856_LTCBL_REG         0x0E
+#define MAX31856_SR_REG            0x0F
+
+static const struct iio_chan_spec max31856_channels[] = {
+	{	/* Thermocouple Temperature */
+		.type = IIO_TEMP,
+		.address = 2,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{	/* Cold Junction Temperature */
+		.type = IIO_TEMP,
+		.channel2 = IIO_MOD_TEMP_AMBIENT,
+		.address = 0,
+		.modified = 1,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+struct max31856_data {
+	struct spi_device *spi;
+	bool one_shot;
+	u32 thermocouple_type;
+	int fault_ovuv;
+	int fault_oc;
+	u8 buf[3] ____cacheline_aligned;
+};
+
+static int max31856_read(struct max31856_data *data, unsigned int reg,
+			 s32 *val, int read_size)
+{
+	int ret;
+	u8 *buf = data->buf;
+
+	/* Make sure top bit is not set,
+	 * The MSB(A7) of this byte determines whether the following byte will
+	 * be written or read. If A7 is 0, one or more byte reads will follow
+	 * the address byte
+	 */
+
+	reg &= MAX31856_READ_MODE;
+
+	buf[0] = reg;
+	buf[1] = 0x00;
+	buf[2] = 0x00;
+
+	if (read_size > 3) {
+		pr_err("error: Unsupported read_size = %d by %s\n",
+			read_size,  __func__);
+		return -EINVAL;
+	}
+
+	ret = spi_write_then_read(data->spi, buf, 1, buf, read_size);
+	if (ret < 0)
+		return ret;
+
+	switch (read_size) {
+	case 1:
+		*val = buf[0];
+		return 0;
+	case 2:
+		*val = (buf[0] << 8) | buf[1];
+		return 0;
+	case 3:
+		*val = (buf[0] << 16) | (buf[1] << 8) | buf[2];
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max31856_write(struct max31856_data *data, unsigned int reg,
+			  unsigned int val)
+{
+	u8 *buf = data->buf;
+
+	/* Make sure top bit is set,
+	 * The MSB(A7) of this byte determines whether the following byte will
+	 * be written or read. If A7 is 1, one or more byte writes will follow
+	 * the address byte
+	 */
+
+	reg |= MAX31856_WRITE_MODE;
+
+	buf[0] = reg;
+	buf[1] = val;
+
+	return spi_write(data->spi, buf, 2);
+}
+
+static int max31856_init(struct max31856_data *data)
+{
+	int ret = 0;
+	s32 reg_val;
+
+	/* Enable Open circuit fault detection [01]
+	 * Read datasheet for more information: Table 4.
+	 * BITS [5:4]    | Fault Test
+	 * ---------------------------
+	 *	00    | Disabled
+	 * ---------------------------
+	 *	01    | Enabled (Once every 16 seconds)
+	 * ---------------------------
+	 *	10    | Enabled (Once every 16 seconds)
+	 * ---------------------------
+	 *	11    | Enabled (Once every 16 seconds)
+	 */
+	ret = max31856_read(data, MAX31856_CR0_REG, &reg_val, 1);
+	if (ret)
+		return ret;
+	reg_val &= ~MAX31856_CR0_OCFAULT1;
+	reg_val |= MAX31856_CR0_OCFAULT0;
+	ret = max31856_write(data, MAX31856_CR0_REG, reg_val);
+	if (ret)
+		return ret;
+
+	/* Set thermocouple type based on dts property */
+	ret = max31856_read(data, MAX31856_CR1_REG, &reg_val, 1);
+	if (ret)
+		return ret;
+
+	reg_val &= 0x00F0;
+	reg_val |= (data->thermocouple_type & 0x0F);
+	ret = max31856_write(data, MAX31856_CR1_REG, reg_val);
+	if (ret)
+		return ret;
+
+	/* Set Conversion Mode (Auto or Oneshot) based on dts property */
+	ret = max31856_read(data, MAX31856_CR0_REG, &reg_val, 1);
+	if (ret)
+		return ret;
+	if (data->one_shot) {
+		reg_val &= ~MAX31856_CR0_AUTOCONVERT;
+		reg_val |= MAX31856_CR0_1SHOT;
+	} else {
+		reg_val |= MAX31856_CR0_AUTOCONVERT;
+		reg_val &= ~MAX31856_CR0_1SHOT;
+	}
+
+	return max31856_write(data, MAX31856_CR0_REG, reg_val);
+}
+
+static int max31856_thermocouple_read(struct max31856_data *data,
+				      struct iio_chan_spec const *chan,
+				      int *val)
+{
+	int ret = 0, temp, offset_cjto;
+
+	switch (chan->channel2) {
+	case IIO_MOD_TEMP_AMBIENT:
+		/* Read register from 0x09-0x0B */
+		ret = max31856_read(data, MAX31856_CJTO_REG, val, 3);
+		/* Get Cold Junction Temp. offset register value */
+		offset_cjto = *val >> 16;
+		/* Mask last 2 bytes to get CJTH and CJTL reg. value */
+		*val &= 0x0000FFFF;
+		temp = *val;
+		/* last 2 bits unused in CJTL reg*/
+		*val >>= 2;
+		/* As per datasheet add offset into CJTH and CJTL */
+		*val += offset_cjto;
+		/* Check 15th bit for sign */
+		if (temp & 0x8000)
+			*val -= 0x4000;
+		break;
+	default:
+		ret = max31856_read(data, MAX31856_LTCBH_REG, val, 3);
+		temp = *val;
+		*val >>= 5;
+		/* Check 23th bit for sign */
+		if (temp & 0x800000)
+			*val -= 0x80000;
+	}
+
+	ret = max31856_read(data, MAX31856_SR_REG, &temp, 1);
+	/* Check for over voltage/under voltage fault */
+	data->fault_ovuv = (temp & MAX31856_FAULT_OVUV) ? 1 : 0;
+	/* Check for open circuit fault */
+	data->fault_oc = (temp & MAX31856_FAULT_OPEN) ? 1 : 0;
+	if (data->fault_oc || data->fault_ovuv)
+		return -EIO;
+
+	return ret;
+}
+
+static int max31856_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max31856_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = max31856_thermocouple_read(data, chan, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel2) {
+		case IIO_MOD_TEMP_AMBIENT:
+			/* Cold junction Temp. Data resolution is 0.015625 */
+			*val = 15;
+			*val2 = 625000; /* 1000 * 0.015625 */
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
+		default:
+			/* Thermocouple Temp. Data resolution is 0.0078125 */
+			*val = 7;
+			*val2 = 812500; /* 1000 * 0.0078125) */
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t show_fault_ovuv(struct device *dev,
+			       struct device_attribute *attr,
+			       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", data->fault_ovuv);
+}
+
+static ssize_t show_fault_oc(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct max31856_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", data->fault_oc);
+}
+
+static IIO_DEVICE_ATTR(fault_ovuv, 0444, show_fault_ovuv, NULL, 0);
+static IIO_DEVICE_ATTR(fault_oc, 0444, show_fault_oc, NULL, 0);
+
+static struct attribute *max31856_attributes[] = {
+	&iio_dev_attr_fault_ovuv.dev_attr.attr,
+	&iio_dev_attr_fault_oc.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group max31856_group = {
+	.attrs = max31856_attributes,
+};
+
+static const struct iio_info max31856_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = max31856_read_raw,
+	.attrs = &max31856_group,
+};
+
+static int max31856_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct iio_dev *indio_dev;
+	struct max31856_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->spi = spi;
+
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->info = &max31856_info;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = max31856_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max31856_channels);
+
+	data->one_shot = of_property_read_bool(spi->dev.of_node, "one-shot");
+
+	ret = of_property_read_u32(spi->dev.of_node, "type",
+				   &data->thermocouple_type);
+
+	if (ret) {
+		pr_info("Could not read thermocouple type DT property, Configuring as a K-Type\n");
+		data->thermocouple_type = 0x03; /* K-Type */
+	}
+
+	ret = max31856_init(data);
+	if (ret) {
+		pr_err("error: Failed to configure max31856\n");
+		return ret;
+	}
+
+	ret = iio_device_register(indio_dev);
+
+	data->fault_ovuv = 0;
+	data->fault_oc = 0;
+
+	return ret;
+}
+
+static int max31856_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct spi_device_id max31856_id[] = {
+	{ "max31856", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max31856_id);
+
+static struct spi_driver max31856_driver = {
+	.driver = {
+		.name = "max31856",
+		.owner = THIS_MODULE,
+	},
+	.probe = max31856_probe,
+	.remove = max31856_remove,
+	.id_table = max31856_id,
+};
+module_spi_driver(max31856_driver);
+
+MODULE_AUTHOR("Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>");
+MODULE_DESCRIPTION("Maxim MAX31856 thermocouple sensor driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
