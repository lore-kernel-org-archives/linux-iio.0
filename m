Return-Path: <ktsai@capellamicro.com>
From: Kevin Tsai <ktsai@capellamicro.com>
To: Kevin Tsai <ktsai@capellamicro.com>,
  Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>,
  Mark Rutland <mark.rutland@arm.com>,
  Ian Campbell <ijc+devicetree@hellion.org.uk>,
  Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>,
  Jonathan Cameron <jic23@kernel.org>, Grant Likely <grant.likely@linaro.org>,
  Peter Huewe <peterhuewe@gmx.de>,
  Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
  Teddy Reed <teddy@prosauce.org>, Kent Yoder <key@linux.vnet.ibm.com>,
  Arnaud Ebalard <arno@natisbad.org>, Peter Meerwald <pmeerw@pmeerw.net>,
  Lars-Peter Clausen <lars@metafoo.de>,
  Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
  Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
  linux-iio@vger.kernel.org
Subject: [PATCH V4 1/1] iio: add Capella CM32181 ambient light sensor driver.
Date: Mon, 23 Dec 2013 17:53:55 -0800
Message-Id: <1387850035-4030-1-git-send-email-ktsai@capellamicro.com>
List-ID: <linux-iio@vger.kernel.org>

Add Capella Microsystem CM32181 Ambient Light Sensor IIO driver.
This driver will convert raw data to lux value under open-air
condition. Change the calibscale based on the cover material.

Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
---
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/cm32181.c                        | 380 +++++++++++++++++++++
 4 files changed, 393 insertions(+)
 create mode 100644 drivers/iio/light/cm32181.c

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index b1cb341..c65f71c 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -16,6 +16,7 @@ adt7461			+/-1C TDM Extended Temp Range I.C
 at,24c08		i2c serial eeprom  (24cxx)
 atmel,24c02		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
+capella,cm32181		CM32181: Ambient Light Sensor
 catalyst,24c32		i2c serial eeprom
 dallas,ds1307		64 x 8, Serial, I2C Real-Time Clock
 dallas,ds1338		I2C RTC with 56-Byte NV RAM
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index a022f27..d12b2a0 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -27,6 +27,17 @@ config APDS9300
 	 To compile this driver as a module, choose M here: the
 	 module will be called apds9300.
 
+config CM32181
+	depends on I2C
+	tristate "CM32181 driver"
+	help
+	 Say Y here if you use cm32181.
+	 This option enables ambient light sensor using
+	 Capella cm32181 device driver.
+
+	 To compile this driver as a module, choose M here:
+	 the module will be called cm32181.
+
 config CM36651
 	depends on I2C
 	tristate "CM36651 driver"
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index daa327f..60e35ac 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -5,6 +5,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
+obj-$(CONFIG_CM32181)		+= cm32181.o
 obj-$(CONFIG_CM36651)		+= cm36651.o
 obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
 obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
new file mode 100644
index 0000000..40cc394
--- /dev/null
+++ b/drivers/iio/light/cm32181.c
@@ -0,0 +1,380 @@
+/*
+ * Copyright (C) 2013 Capella Microsystems Inc.
+ * Author: Kevin Tsai <ktsai@capellamicro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2, as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/init.h>
+
+/* Registers Address */
+#define CM32181_REG_ADDR_CMD		0x00
+#define CM32181_REG_ADDR_ALS		0x04
+#define CM32181_REG_ADDR_STATUS		0x06
+#define CM32181_REG_ADDR_ID		0x07
+
+/* Number of Configurable Registers */
+#define CM32181_CONF_REG_NUM		0x01
+
+/* CMD register */
+#define CM32181_CMD_ALS_ENABLE		0x00
+#define CM32181_CMD_ALS_DISABLE		0x01
+#define CM32181_CMD_ALS_INT_EN		0x02
+
+#define CM32181_CMD_ALS_IT_SHIFT	6
+#define CM32181_CMD_ALS_IT_MASK		(0x0F << CM32181_CMD_ALS_IT_SHIFT)
+#define CM32181_CMD_ALS_IT_DEFAULT	(0x00 << CM32181_CMD_ALS_IT_SHIFT)
+
+#define CM32181_CMD_ALS_SM_SHIFT	11
+#define CM32181_CMD_ALS_SM_MASK		(0x03 << CM32181_CMD_ALS_SM_SHIFT)
+#define CM32181_CMD_ALS_SM_DEFAULT	(0x01 << CM32181_CMD_ALS_SM_SHIFT)
+
+#define CM32181_MLUX_PER_BIT		5	/* ALS_SM=01 IT=800ms */
+#define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=800ms */
+#define	CM32181_CALIBSCALE_DEFAULT	1000
+#define CM32181_CALIBSCALE_RESOLUTION	1000
+#define MLUX_PER_LUX			1000
+
+static const u8 cm32181_reg[CM32181_CONF_REG_NUM] = {
+	CM32181_REG_ADDR_CMD,
+};
+
+static const int als_it_bits[] = {12, 8, 0, 1, 2, 3};
+static const int als_it_value[] = {25000, 50000, 100000, 200000, 400000,
+	800000};
+
+struct cm32181_chip {
+	struct i2c_client *client;
+	struct mutex lock;
+	u16 conf_regs[CM32181_CONF_REG_NUM];
+	int calibscale;
+};
+
+/**
+ * cm32181_reg_init() - Initialize CM32181 registers
+ * @cm32181:	pointer of struct cm32181.
+ *
+ * Initialize CM32181 ambient light sensor register to default values.
+ *
+ * Return: 0 for success; otherwise for error code.
+ */
+static int cm32181_reg_init(struct cm32181_chip *cm32181)
+{
+	struct i2c_client *client = cm32181->client;
+	int i;
+	s32 ret;
+
+	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ID);
+	if (ret < 0)
+		return ret;
+
+	/* check device ID */
+	if ((ret & 0xFF) != 0x81)
+		return -ENODEV;
+
+	/* Default Values */
+	cm32181->conf_regs[CM32181_REG_ADDR_CMD] = CM32181_CMD_ALS_ENABLE |
+			CM32181_CMD_ALS_IT_DEFAULT | CM32181_CMD_ALS_SM_DEFAULT;
+	cm32181->calibscale = CM32181_CALIBSCALE_DEFAULT;
+
+	/* Initialize registers*/
+	for (i = 0; i < CM32181_CONF_REG_NUM; i++) {
+		ret = i2c_smbus_write_word_data(client, cm32181_reg[i],
+			cm32181->conf_regs[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ *  cm32181_read_als_it() - Get sensor integration time (ms)
+ *  @cm32181:	pointer of struct cm32181
+ *  @val:	pointer of int to load the als_it value.
+ *
+ *  Report the current integartion time by millisecond.
+ *
+ *  Return: IIO_VAL_INT for success, otherwise -EINVAL.
+ */
+static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val)
+{
+	u16 als_it;
+	int i;
+
+	als_it = cm32181->conf_regs[CM32181_REG_ADDR_CMD];
+	als_it &= CM32181_CMD_ALS_IT_MASK;
+	als_it >>= CM32181_CMD_ALS_IT_SHIFT;
+	for (i = 0; i < ARRAY_SIZE(als_it_bits); i++) {
+		if (als_it == als_it_bits[i]) {
+			*val = als_it_value[i];
+			return IIO_VAL_INT;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * cm32181_write_als_it() - Write sensor integration time
+ * @cm32181:	pointer of struct cm32181.
+ * @val:	integration time by millisecond.
+ *
+ * Convert integration time (ms) to sensor value.
+ *
+ * Return: i2c_smbus_write_word_data command return value.
+ */
+static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
+{
+	struct i2c_client *client = cm32181->client;
+	u16 als_it;
+	int ret, i, n;
+
+	n = ARRAY_SIZE(als_it_value);
+	for (i = 0; i < n; i++)
+		if (val <= als_it_value[i])
+			break;
+	if (i >= n)
+		i = n - 1;
+
+	als_it = als_it_bits[i];
+	als_it <<= CM32181_CMD_ALS_IT_SHIFT;
+
+	mutex_lock(&cm32181->lock);
+	cm32181->conf_regs[CM32181_REG_ADDR_CMD] &=
+		~CM32181_CMD_ALS_IT_MASK;
+	cm32181->conf_regs[CM32181_REG_ADDR_CMD] |=
+		als_it;
+	ret = i2c_smbus_write_word_data(client, CM32181_REG_ADDR_CMD,
+			cm32181->conf_regs[CM32181_REG_ADDR_CMD]);
+	mutex_unlock(&cm32181->lock);
+
+	return ret;
+}
+
+/**
+ * cm32181_get_lux() - report current lux value
+ * @cm32181:	pointer of struct cm32181.
+ *
+ * Convert sensor raw data to lux.  It depends on integration
+ * time and claibscale variable.
+ *
+ * Return: Positive value is lux, otherwise is error code.
+ */
+static int cm32181_get_lux(struct cm32181_chip *cm32181)
+{
+	struct i2c_client *client = cm32181->client;
+	int ret;
+	int als_it;
+	unsigned long lux;
+
+	ret = cm32181_read_als_it(cm32181, &als_it);
+	if (ret < 0)
+		return -EINVAL;
+
+	lux = CM32181_MLUX_PER_BIT;
+	lux *= CM32181_MLUX_PER_BIT_BASE_IT;
+	lux /= als_it;
+
+	ret = i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ALS);
+	if (ret < 0)
+		return ret;
+
+	lux *= ret;
+	lux *= cm32181->calibscale;
+	lux /= CM32181_CALIBSCALE_RESOLUTION;
+	lux /= MLUX_PER_LUX;
+
+	if (lux > 0xFFFF)
+		lux = 0xFFFF;
+
+	return lux;
+}
+
+static int cm32181_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct cm32181_chip *cm32181 = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		ret = cm32181_get_lux(cm32181);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*val = cm32181->calibscale;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = cm32181_read_als_it(cm32181, val);
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+static int cm32181_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct cm32181_chip *cm32181 = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		cm32181->calibscale = val;
+		return val;
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = cm32181_write_als_it(cm32181, val);
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * cm32181_get_it_available() - Get available ALS IT value
+ * @dev:	pointer of struct device.
+ * @attr:	pointer of struct device_attribute.
+ * @buf:	pointer of return string buffer.
+ *
+ * Display the available integration time values by millisecond.
+ *
+ * Return: string length.
+ */
+static ssize_t cm32181_get_it_available(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int i, n, len;
+
+	n = ARRAY_SIZE(als_it_value);
+	for (i = 0, len = 0; i < n; i++)
+		len += sprintf(buf + len, "%d ", als_it_value[i]);
+	return len + sprintf(buf + len, "\n");
+}
+
+static const struct iio_chan_spec cm32181_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_PROCESSED) |
+			BIT(IIO_CHAN_INFO_CALIBSCALE) |
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	}
+};
+
+
+static IIO_DEVICE_ATTR(in_illuminance_integration_time_available,
+			S_IRUGO, cm32181_get_it_available, NULL, 0);
+
+static struct attribute *cm32181_attributes[] = {
+	&iio_dev_attr_in_illuminance_integration_time_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group cm32181_attribute_group = {
+	.attrs = cm32181_attributes
+};
+
+static const struct iio_info cm32181_info = {
+	.driver_module		= THIS_MODULE,
+	.read_raw		= &cm32181_read_raw,
+	.write_raw		= &cm32181_write_raw,
+	.attrs			= &cm32181_attribute_group,
+};
+
+static int cm32181_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct cm32181_chip *cm32181;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm32181));
+	if (!indio_dev) {
+		dev_err(&client->dev, "devm_iio_device_alloc failed\n");
+		return -ENOMEM;
+	}
+
+	cm32181 = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	cm32181->client = client;
+
+	mutex_init(&cm32181->lock);
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->channels = cm32181_channels;
+	indio_dev->num_channels = ARRAY_SIZE(cm32181_channels);
+	indio_dev->info = &cm32181_info;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = cm32181_reg_init(cm32181);
+	if (ret) {
+		dev_err(&client->dev,
+			"%s: register init failed\n",
+			__func__);
+		return ret;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&client->dev,
+			"%s: regist device failed\n",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cm32181_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	return 0;
+}
+
+static const struct i2c_device_id cm32181_id[] = {
+	{ "cm32181", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, cm32181_id);
+
+static const struct of_device_id cm32181_of_match[] = {
+	{ .compatible = "capella,cm32181" },
+	{ }
+};
+
+static struct i2c_driver cm32181_driver = {
+	.driver = {
+		.name	= "cm32181",
+		.of_match_table = of_match_ptr(cm32181_of_match),
+		.owner	= THIS_MODULE,
+	},
+	.id_table       = cm32181_id,
+	.probe		= cm32181_probe,
+	.remove		= cm32181_remove,
+};
+
+module_i2c_driver(cm32181_driver);
+
+MODULE_AUTHOR("Kevin Tsai <ktsai@capellamicro.com>");
+MODULE_DESCRIPTION("CM32181 ambient light sensor driver");
+MODULE_LICENSE("GPL");
-- 
1.8.3.1
