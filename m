Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch3vs03.rockwellcollins.com ([205.175.226.47]:5822 "EHLO
        ch3vs03.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727439AbeJZC0H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Oct 2018 22:26:07 -0400
From: Matt Weber <matthew.weber@rockwellcollins.com>
To: linux-iio@vger.kernel.org
Cc: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>
Subject: [PATCH v4 1/2] iio:temperature: Add MAX31856 thermocouple support
Date: Thu, 25 Oct 2018 12:42:44 -0500
Message-Id: <1540489365-3464-1-git-send-email-matthew.weber@rockwellcollins.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>

This patch adds support for Maxim MAX31856 thermocouple
temperature sensor support.

More information can be found in:
https://www.maximintegrated.com/en/ds/MAX31856.pdf

NOTE: Driver support only Comparator Mode.

Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
---
Changes
v1 -> v2
[Peter
	1. Fixed all space & 'return' related comments
	2. Removed 'sysfs_create_group' api  because
	   iio_device_register function is handling sysfs entry
	3. Return -EIO if there is any fault
	4. Added check for 'read_size' before spi read call
	5. Removed license text from the source file
	6. Added .o file in alphabetic order
	7. Used #defines instead of magic bits

v2 -> v3
[Jonathan
	1. Used bool for fault_oc and fault_ovuv
	2. Changed 'max31856_read' function and use byte array to
	   store registers value.
	3. Used 'GENMASK' where required
        4. Changed logic 'max31856_thermocouple_read' function. Used
	   array to read registers value.
	5. Used 'devm_iio_device_register' and removed 'max31856_remove'.
	6. Fixed other cosmetic changes.
	7. Added 'sysfs-bus-iio-temperature-max31856' file and updated
	   'MAINTAINERS' file.

v3 -> v4
[Jonathan
	1. Removed unwanted logic
	2. Updated code to handle return value of max31856_read call
	3. Added devicetree id table
	4. Removed one-shot support from driver as this support was not
	   implemented with correct design.
---
 .../ABI/testing/sysfs-bus-iio-temperature-max31856 |  23 ++
 MAINTAINERS                                        |   7 +
 drivers/iio/temperature/Kconfig                    |  10 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/max31856.c                 | 357 +++++++++++++++++++++
 5 files changed, 398 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
 create mode 100644 drivers/iio/temperature/max31856.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
new file mode 100644
index 0000000..d3238b8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
@@ -0,0 +1,23 @@
+What:		/sys/bus/iio/devices/iio:deviceX/fault_oc
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Open-circuit fault. The detection of open-circuit faults,
+		such as those caused by broken thermocouple wires.
+		Reading returns either '1' or '0'.
+		'1' = An open circuit such as broken thermocouple wires
+		      has been detected.
+		'0' = No open circuit or broken thermocouple wires are detected
+
+What:		/sys/bus/iio/devices/iio:deviceX/fault_ovuv
+KernelVersion:	4.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Overvoltage or Undervoltage Input Fault. The internal circuitry
+		is protected from excessive voltages applied to the thermocouple
+		cables by integrated MOSFETs at the T+ and T- inputs, and the
+		BIAS output. These MOSFETs turn off when the input voltage is
+		negative or greater than VDD.
+		Reading returns either '1' or '0'.
+		'1' = The input voltage is negative or greater than VDD.
+		'0' = The input voltage is positive and less than VDD(default).
diff --git a/MAINTAINERS b/MAINTAINERS
index f642044..3cfa518 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7157,6 +7157,13 @@ F:	drivers/staging/iio/
 F:	include/linux/iio/
 F:	tools/iio/
 
+MAX31856 IIO DRIVER
+M:	Matthew Weber <matthew.weber@rockwellcollins.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/temperature/max31856.c
+F:	Documentation/ABI/testing/sysfs-bus-iio-temperature-max31856
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
index 0000000..80b0ea5
--- /dev/null
+++ b/drivers/iio/temperature/max31856.c
@@ -0,0 +1,357 @@
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
+#define MAX31856_RD_WR_BIT_POS     7
+#define MAX31856_CR0_AUTOCONVERT   0x80
+#define MAX31856_CR0_1SHOT         0x40
+#define MAX31856_CR0_OCFAULT       BIT(4)
+#define MAX31856_CR0_OCFAULT_MASK  GENMASK(5, 4)
+#define MAX31856_TC_TYPE_MASK      GENMASK(3, 0)
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
+	u32 thermocouple_type;
+	bool fault_ovuv;
+	bool fault_oc;
+	u8 buf[3] ____cacheline_aligned;
+};
+
+static int max31856_read(struct max31856_data *data, unsigned int reg,
+			 u8 val[], int read_size)
+{
+	int ret;
+	u8 *buf = data->buf;
+
+	/*
+	 * Make sure top bit is not set,
+	 * The MSB(A7) of this byte determines whether the following byte will
+	 * be written or read. If A7 is 0, one or more byte reads will follow
+	 * the address byte
+	 */
+
+	reg &= ~(1 << MAX31856_RD_WR_BIT_POS);
+
+	buf[0] = reg;
+	buf[1] = 0x00;
+	buf[2] = 0x00;
+
+	if (read_size > 3 || read_size <= 0) {
+		pr_err("error: Unsupported read_size = %d by %s\n",
+			read_size,  __func__);
+		return -EINVAL;
+	}
+
+	ret = spi_write_then_read(data->spi, buf, 1, buf, read_size);
+	if (ret < 0)
+		return ret;
+
+	memcpy(val, buf, read_size);
+
+	return 0;
+}
+
+static int max31856_write(struct max31856_data *data, unsigned int reg,
+			  unsigned int val)
+{
+	u8 *buf = data->buf;
+
+	/*
+	 * Make sure top bit is set,
+	 * The MSB(A7) of this byte determines whether the following byte will
+	 * be written or read. If A7 is 1, one or more byte writes will follow
+	 * the address byte
+	 */
+
+	buf[0] = reg | (1 << MAX31856_RD_WR_BIT_POS);
+	buf[1] = val;
+
+	return spi_write(data->spi, buf, 2);
+}
+
+static int max31856_init(struct max31856_data *data)
+{
+	int ret;
+	u8 reg_val[1];
+
+	/*
+	 * Enable Open circuit fault detection [01]
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
+	ret = max31856_read(data, MAX31856_CR0_REG, reg_val, 1);
+	if (ret)
+		return ret;
+	reg_val[0] &= ~MAX31856_CR0_OCFAULT_MASK;
+	reg_val[0] |= MAX31856_CR0_OCFAULT;
+	ret = max31856_write(data, MAX31856_CR0_REG, reg_val[0]);
+	if (ret)
+		return ret;
+
+	/* Set thermocouple type based on dts property */
+	ret = max31856_read(data, MAX31856_CR1_REG, reg_val, 1);
+	if (ret)
+		return ret;
+
+	reg_val[0] &= ~MAX31856_TC_TYPE_MASK;
+	reg_val[0] |= data->thermocouple_type;
+	ret = max31856_write(data, MAX31856_CR1_REG, reg_val[0]);
+	if (ret)
+		return ret;
+
+	/* Set Auto Conversion Mode */
+	ret = max31856_read(data, MAX31856_CR0_REG, reg_val, 1);
+	if (ret)
+		return ret;
+	reg_val[0] |= MAX31856_CR0_AUTOCONVERT;
+	reg_val[0] &= ~MAX31856_CR0_1SHOT;
+
+	return max31856_write(data, MAX31856_CR0_REG, reg_val[0]);
+}
+
+static int max31856_thermocouple_read(struct max31856_data *data,
+				      struct iio_chan_spec const *chan,
+				      int *val)
+{
+	int ret, offset_cjto;
+	u8 reg_val[3];
+
+	switch (chan->channel2) {
+	case IIO_MOD_TEMP_AMBIENT:
+		/*
+		 * Multibyte Read
+		 * MAX31856_CJTO_REG, MAX31856_CJTH_REG, MAX31856_CJTL_REG
+		 */
+		ret = max31856_read(data, MAX31856_CJTO_REG, reg_val, 3);
+		if (ret)
+			return ret;
+		/* Get Cold Junction Temp. offset register value */
+		offset_cjto = reg_val[0];
+		/* Get CJTH and CJTL value and skip last 2 dead bits of CJTL*/
+		*val = (reg_val[1] << 8 | reg_val[2]) >> 2;
+		/* As per datasheet add offset into CJTH and CJTL */
+		*val += offset_cjto;
+		/* Check 7th bit of CJTH reg. value for sign */
+		if (reg_val[1] & 0x80)
+			*val -= 0x4000;
+		break;
+	default:
+		/*
+		 * Multibyte Read
+		 * MAX31856_LTCBH_REG, MAX31856_LTCBM_REG, MAX31856_LTCBL_REG
+		 */
+		ret = max31856_read(data, MAX31856_LTCBH_REG, reg_val, 3);
+		if (ret)
+			return ret;
+		/* Skip last 5 dead bits of LTCBL */
+		*val = (reg_val[0] << 16 | reg_val[1] << 8 | reg_val[2]) >> 5;
+		/* Check 7th bit of LTCBH reg. value for sign*/
+		if (reg_val[0] & 0x80)
+			*val -= 0x80000;
+	}
+
+	ret = max31856_read(data, MAX31856_SR_REG, reg_val, 1);
+	if (ret)
+		return ret;
+	/* Check for over voltage/under voltage fault */
+	data->fault_ovuv = (reg_val[0] & MAX31856_FAULT_OVUV) ? true : false;
+	/* Check for open circuit fault */
+	data->fault_oc = (reg_val[0] & MAX31856_FAULT_OPEN) ? true : false;
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
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id max31856_id[] = {
+	{ "max31856", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max31856_id);
+
+static const struct of_device_id max31856_of_match[] = {
+	{ .compatible = "maxim,max31856" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max31856_of_match);
+
+static struct spi_driver max31856_driver = {
+	.driver = {
+		.name = "max31856",
+		.of_match_table = max31856_of_match,
+	},
+	.probe = max31856_probe,
+	.id_table = max31856_id,
+};
+module_spi_driver(max31856_driver);
+
+MODULE_AUTHOR("Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>");
+MODULE_DESCRIPTION("Maxim MAX31856 thermocouple sensor driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
