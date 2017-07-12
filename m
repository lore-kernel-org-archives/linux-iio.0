Return-Path: <SRS0=Xj4J=6P=gmail.com=narcisaanamaria12@kernel.org>
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: daniel.baluta@gmail.com,
	amsfield22@gmail.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH v2] iio: chemical: ccs811: Add support for AMS CCS811 VOC sensor
Date: Wed, 12 Jul 2017 12:40:23 +0300
Message-Id: <1499852423-5356-1-git-send-email-narcisaanamaria12@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add support for CCS811 VOC sensor. This patch adds support
for reading current and voltage across the sensor and TVOC
and equivalent CO2 values.

Scale and offset values have been computed according to datasheet:
    - For current: raw value is in microamps
        => 0.001 scale to convert to milliamps
    - For voltage: 1.65V = 1023, therefore 1650mV = 1023
        => 1650.0/1023 = 1.612903 scale to convert to millivolts
    - For eCO2: raw value range is from 400ppm to 8192ppm.
        => (val - 400) * (100 - 0) / (8192 - 400) + 0 =
           (val - 400) * 0.01283367 => offset: -400, scale = 0.012834
           to get a percentage value
    -For TVOC: raw value range is from 0ppb to 1187ppb.
        => (val - 0) * 100 / (1187 - 0) + 0 = val * 0.0842459 =>
           scale = 0.084246 for getting a percentage value

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Alison Schofield <amsfield22@gmail.com>
Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
Changes in v2:
    - Add scale and offset to obtain values expressed with correct units.
    - RAW_READ register is not read anymore, since values for current and
      voltage are read using ALG_RESULT_DATA register address. Remove the
      check for I2C_SMBUS_WORD_DATA, since the corresponding function
      is not used anymore.
    - Define packed struct to hold data read from alg_result_data register.
    - Add mutex to protect readings.
    - Add _remove function and set chip to IDLE inside it.
    - Group measurement reading and "data_ready" check inside new function.
    - Introduce sleeps to wait for data to be ready.
    - Add ccs811 prefix to enum operation_mode and to STATUS macros.
    - Use ret instead of status variable to hold return values from functions.
    - Use enum operation_mode instead of int as parameter to set_drive_mode().
    - Drop temporary variable meas_mode.
    - Drop pointless comments.
    - Add macro for error bit in STATUS register.
    - Drop useless break.
    - Drop useless return.
    - Change format of multi-line comment.
    - Change word "SENSOR" to lowercase letters inside MODULE_DESCRIPTION.
    - Remove empty comment line.
    - Introduce MIN and MAX values to ccs811_operation_mode to detect invalid
      values.
    - Change style of braces.
    - Replace VOC with "volatile organic compounds" in MODULE_DESCRIPTION.
    - Add datasheet link.
    - Check hardware version in probe

 drivers/iio/chemical/Kconfig  |   7 +
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/ccs811.c | 343 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+)
 create mode 100644 drivers/iio/chemical/ccs811.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index cea7f98..4d799b5 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -21,6 +21,13 @@ config ATLAS_PH_SENSOR
 	 To compile this driver as module, choose M here: the
 	 module will be called atlas-ph-sensor.
 
+config CCS811
+	tristate "AMS CCS811 VOC sensor"
+	depends on I2C
+	help
+	  Say Y here to build I2C interface support for the AMS
+	  CCS811 VOC (Volatile Organic Compounds) sensor
+
 config IAQCORE
 	tristate "AMS iAQ-Core VOC sensors"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index b02202b..a629b29 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -4,5 +4,6 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-ph-sensor.o
+obj-$(CONFIG_CCS811)		+= ccs811.o
 obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
new file mode 100644
index 0000000..d816daa
--- /dev/null
+++ b/drivers/iio/chemical/ccs811.c
@@ -0,0 +1,343 @@
+/*
+ * ccs811.c - Support for AMS CCS811 VOC Sensor
+ *
+ * Copyright (C) 2017 Narcisa Vasile <narcisaanamaria12@gmail.com>
+ *
+ * Datasheet: ams.com/content/download/951091/2269479/CCS811_DS000459_3-00.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * IIO driver for AMS CCS811 (I2C address 0x5A/0x5B set by ADDR Low/High)
+ *
+ * TODO:
+ * 1. Make the drive mode selectable form userspace
+ * 2. Add support for interrupts
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+
+#define CCS811_STATUS		0x00
+#define CCS811_MEAS_MODE	0x01
+#define CCS811_ALG_RESULT_DATA	0x02
+#define CCS811_RAW_DATA		0x03
+#define CCS811_HW_ID		0x20
+#define CCS811_HW_VERSION	0x21
+#define CCS811_ERR		0xE0
+
+/* Used to transition from boot to application mode */
+#define CCS811_APP_START	0xF4
+
+#define CCS811_VOLTAGE_MASK	0x3FF
+
+#define CCS811_STATUS_ERROR		BIT(0)
+#define CCS811_STATUS_DATA_READY	BIT(3)
+#define CCS811_STATUS_APP_VALID	BIT(4)
+#define CCS811_STATUS_FW_MODE		BIT(7)
+
+enum ccs811_operation_mode {
+	CCS811_MIN_MODE = -1,
+	CCS811_MODE_IDLE = 0,
+	CCS811_MODE_IAQ_SEC_1 = 1,
+	CCS811_MODE_IAQ_SEC_10 = 2,
+	CCS811_MODE_IAQ_SEC_60 = 3,
+	CCS811_MODE_RAW_DATA = 4,
+	CCS811_MAX_MODE
+};
+
+struct ccs811_reading {
+	__be16 co2;
+	__be16 voc;
+	u8 status;
+	u8 error;
+	__be16 resistance;
+} __attribute__((__packed__));
+
+struct ccs811_data {
+	struct i2c_client *client;
+	struct mutex lock; /* Protect readings */
+	struct ccs811_reading buffer;
+};
+
+static const struct iio_chan_spec ccs811_channels[] = {
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE)
+	}, {
+		.type = IIO_VOLTAGE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE)
+	}, {
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_CO2,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_OFFSET) |
+				      BIT(IIO_CHAN_INFO_SCALE)
+	}, {
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_VOC,
+		.modified = 1,
+		.info_mask_separate =  BIT(IIO_CHAN_INFO_RAW) |
+				       BIT(IIO_CHAN_INFO_SCALE)
+	},
+};
+
+static int ccs811_set_drive_mode(struct i2c_client *client,
+				 enum ccs811_operation_mode mode)
+{
+	int ret;
+
+	if (mode <= CCS811_MIN_MODE || mode >= CCS811_MAX_MODE)
+		return -EINVAL;
+
+	ret = i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE, (mode << 4));
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_byte_data(client, CCS811_STATUS);
+	if (ret < 0)
+		return ret;
+
+	if (ret & CCS811_STATUS_ERROR)
+		return -EIO;
+
+	return 0;
+}
+
+static int ccs811_switch_to_application_mode(struct i2c_client *client)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(client, CCS811_STATUS);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & CCS811_STATUS_APP_VALID))
+		return -EIO;
+
+	ret = i2c_smbus_read_byte_data(client, CCS811_APP_START);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_byte_data(client, CCS811_STATUS);
+	if (ret < 0)
+		return ret;
+
+	if (!(ret & CCS811_STATUS_FW_MODE))
+		return -EIO;
+
+	return 0;
+}
+
+static int ccs811_setup(struct i2c_client *client)
+{
+	int ret;
+
+	ret = ccs811_switch_to_application_mode(client);
+	if (ret < 0)
+		return ret;
+
+	ret = ccs811_set_drive_mode(client, CCS811_MODE_IAQ_SEC_1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ccs811_get_measurement(struct ccs811_data *data)
+{
+	int ret, tries = 11;
+
+	/*
+	 * After 11 tries, more than a second has passed (11 * 100ms > 1s) after
+	 * the first checking of "data_ready" bit. As measurements are
+	 * made every second, data should be ready now. Error out if it's not.
+	 */
+	while (tries-- > 0) {
+		ret = i2c_smbus_read_byte_data(data->client, CCS811_STATUS);
+		if (ret < 0)
+			return ret;
+
+		if (ret & CCS811_STATUS_DATA_READY)
+			break;
+		msleep(100);
+	}
+	if (tries < 0)
+		return -EIO;
+
+	ret = i2c_smbus_read_i2c_block_data(data->client,
+					    CCS811_ALG_RESULT_DATA, 8,
+					    (char *)&data->buffer);
+
+	if (ret != 8 || (data->buffer.status & CCS811_STATUS_ERROR))
+		return -EIO;
+
+	return 0;
+}
+
+static int ccs811_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ccs811_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->lock);
+		ret = ccs811_get_measurement(data);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = be16_to_cpu(data->buffer.resistance) &
+					   CCS811_VOLTAGE_MASK;
+			return IIO_VAL_INT;
+		case IIO_CURRENT:
+			*val = be16_to_cpu(data->buffer.resistance) >> 10;
+			return IIO_VAL_INT;
+		case IIO_CONCENTRATION:
+			switch (chan->channel2) {
+			case IIO_MOD_CO2:
+				*val = be16_to_cpu(data->buffer.co2);
+				return IIO_VAL_INT;
+			case IIO_MOD_VOC:
+				*val = be16_to_cpu(data->buffer.voc);
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = 1;
+			*val2 = 612903;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_CURRENT:
+			*val = 0;
+			*val2 = 1000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_CONCENTRATION:
+			switch (chan->channel2) {
+			case IIO_MOD_CO2:
+				*val = 0;
+				*val2 = 12834;
+				return IIO_VAL_INT_PLUS_MICRO;
+			case IIO_MOD_VOC:
+				*val = 0;
+				*val2 = 84246;
+				return IIO_VAL_INT_PLUS_MICRO;
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		if (!(chan->type == IIO_CONCENTRATION &&
+		      chan->channel2 == IIO_MOD_CO2))
+			return -EINVAL;
+		*val = -400;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ccs811_info = {
+	.read_raw = ccs811_read_raw,
+};
+
+static int ccs811_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct ccs811_data *data;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA
+				     | I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+		return -EOPNOTSUPP;
+
+	/* Check hardware id (should be 0x81 for this family of devices) */
+	ret = i2c_smbus_read_byte_data(client, CCS811_HW_ID);
+	if (ret < 0)
+		return ret;
+
+	if (ret != 0x81) {
+		dev_err(&client->dev, "hardware id doesn't match CCS81x\n");
+		return -ENODEV;
+	}
+
+	ret = i2c_smbus_read_byte_data(client, CCS811_HW_VERSION);
+	if (ret < 0)
+		return ret;
+
+	if ((ret & 0xF0) != 0x10) {
+		dev_err(&client->dev, "no CCS811 sensor\n");
+		return -ENODEV;
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ret = ccs811_setup(client);
+	if (ret < 0)
+		return ret;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	mutex_init(&data->lock);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
+	indio_dev->info = &ccs811_info;
+
+	indio_dev->channels = ccs811_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ccs811_channels);
+
+	return iio_device_register(indio_dev);
+}
+
+static int ccs811_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+
+	return ccs811_set_drive_mode(client, CCS811_MODE_IDLE);
+}
+
+static const struct i2c_device_id ccs811_id[] = {
+	{"ccs811", 0},
+	{	}
+};
+MODULE_DEVICE_TABLE(i2c, ccs811_id);
+
+static struct i2c_driver ccs811_driver = {
+	.driver = {
+		.name = "ccs811",
+	},
+	.probe = ccs811_probe,
+	.remove = ccs811_remove,
+	.id_table = ccs811_id,
+};
+module_i2c_driver(ccs811_driver);
+
+MODULE_AUTHOR("Narcisa Vasile <narcisaanamaria12@gmail.com>");
+MODULE_DESCRIPTION("CCS811 volatile organic compounds sensor");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
