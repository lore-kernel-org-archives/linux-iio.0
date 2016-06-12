Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 2/2] iio: humidity: sht31: add Sensirion SHT31 support
Date: Sat, 11 Jun 2016 22:13:17 -0700
Message-Id: <1465708397-19649-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
References: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add support for the Sensirion SHT31 humidity + temperature sensor.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 drivers/iio/humidity/Kconfig                       |  11 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/sht31.c                       | 416 +++++++++++++++++++++
 4 files changed, 429 insertions(+)
 create mode 100644 drivers/iio/humidity/sht31.c

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 539874490492..a651ccd15459 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -78,6 +78,7 @@ ricoh,rs5c372b		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,rv5c386		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 ricoh,rv5c387a		I2C bus SERIAL INTERFACE REAL-TIME CLOCK IC
 samsung,24ad0xd1	S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
+sensirion,sht31		Sensirion SHT31 humidity + temperature sensor
 sgx,vz89x		SGX Sensortech VZ89X Sensors
 sii,s35390a		2-wire CMOS real-time clock
 skyworks,sky81452	Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 738a86d9e4a9..21bff72511a5 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -45,6 +45,17 @@ config HTU21
 	  This driver can also be built as a module. If so, the module will
 	  be called htu21.
 
+config SHT31
+	tristate "Sensirion SHT31 humidity and temperature sensor"
+	depends on I2C
+	select CRC8
+	help
+	  If you say yes here you support for the Sensirion SHT31 humidity and
+	  temperature sensor.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called sht31.
+
 config SI7005
 	tristate "SI7005 relative humidity and temperature sensor"
 	depends on I2C
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index 4a73442fcd9c..a3b7727d47bf 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -6,5 +6,6 @@ obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
 obj-$(CONFIG_HDC100X) += hdc100x.o
 obj-$(CONFIG_HTU21) += htu21.o
+obj-$(CONFIG_SHT31) += sht31.o
 obj-$(CONFIG_SI7005) += si7005.o
 obj-$(CONFIG_SI7020) += si7020.o
diff --git a/drivers/iio/humidity/sht31.c b/drivers/iio/humidity/sht31.c
new file mode 100644
index 000000000000..c1d74dcaf8c6
--- /dev/null
+++ b/drivers/iio/humidity/sht31.c
@@ -0,0 +1,416 @@
+/*
+ * sht31.c - Support for the Sensirion SHT31 temperature + humidity sensor
+ *
+ * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/crc8.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#define SHT31_DRV_NAME	"sht31"
+
+#define SHT31_HEATER_CMD_MSB		0x30
+#define SHT31_HEATER_CMD_ENABLE		0x6d
+#define SHT31_HEATER_CMD_DISABLE	0x66
+
+#define SHT31_MEASUREMENT_CMD_MSB	(0x2C << 8)
+
+#define SHT31_STATUS_CMD		0xF32D
+#define SHT31_STATUS_CMD_CHKSUM		BIT(0)
+
+struct sht31_data {
+	struct iio_dev *indio_dev;
+	struct i2c_client *client;
+	struct mutex lock;
+
+	/* config */
+	int heater_status;
+	int it_time;
+
+	u8 crc_table[CRC8_TABLE_SIZE];
+	u16 buffer[8]; /* 4 byte data + 2 byte pad + 8 byte */
+};
+
+static const struct iio_chan_spec sht31_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.address = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+		},
+	},
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.address = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.extend_name = "heater",
+		.scan_index = -1,
+		.output = 1,
+	},
+};
+
+static IIO_CONST_ATTR(integration_time_available,
+		"0.0025 0.0045 0.0125");
+
+static IIO_CONST_ATTR(out_current_heater_raw_available,
+		"0 1");
+
+/* integration time + LSB of I2C command */
+static const int sht31_integration_time[][2] = {
+	{2500, 0x10},
+	{4500, 0x0d},
+	{12500, 0x06}
+};
+
+static const unsigned long sht31_scan_masks[] = {0x3, 0};
+
+static struct attribute *sht31_attributes[] = {
+	&iio_const_attr_integration_time_available.dev_attr.attr,
+	&iio_const_attr_out_current_heater_raw_available.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group sht31_attribute_group = {
+	.attrs = sht31_attributes,
+};
+
+static int sht31_crc8_check(struct sht31_data *data, u8 *vals)
+{
+	int ret = crc8(data->crc_table, vals, 2, 0xff);
+
+	if (ret != vals[2])
+		return -EINVAL;
+
+	return 0;
+}
+
+static int sht31_get_measurement(struct sht31_data *data, u16 *buf)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_msg msg[2];
+	u16 reg = cpu_to_be16(SHT31_MEASUREMENT_CMD_MSB |
+		  sht31_integration_time[data->it_time][1]);
+	u8 vals[6];
+	int ret, i;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = client->flags;
+	msg[0].len = 2;
+	msg[0].buf = (char *) &reg;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = client->flags | I2C_M_RD;
+	msg[1].len = sizeof(vals);
+	msg[1].buf = (char *) &vals;
+
+	ret = i2c_transfer(client->adapter, msg, 2);
+	if (ret != 2)
+		return -EIO;
+
+	for (i = 0; i < 2; i++) {
+		ret = sht31_crc8_check(data, (u8 *) &vals[3 * i]);
+		if (ret)
+			return -EINVAL;
+		*buf++ = be16_to_cpu(*((u16 *) &vals[3 * i]));
+	}
+
+	return 0;
+}
+
+static irqreturn_t sht31_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct sht31_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = sht31_get_measurement(data, data->buffer);
+	if (!ret)
+		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+						   iio_get_time_ns());
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int sht31_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	struct sht31_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+	u16 buf[2];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		mutex_lock(&data->lock);
+		*val = 0;
+		*val2 = sht31_integration_time[data->it_time][0];
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		mutex_unlock(&data->lock);
+		break;
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+		case IIO_TEMP:
+			if (iio_device_claim_direct_mode(indio_dev))
+				return -EBUSY;
+
+			ret = sht31_get_measurement(data, (u16 *) &buf);
+			if (!ret) {
+				*val = buf[chan->address];
+				ret = IIO_VAL_INT;
+			}
+			iio_device_release_direct_mode(indio_dev);
+			break;
+		case IIO_CURRENT:
+			mutex_lock(&data->lock);
+			*val = data->heater_status;
+			ret = IIO_VAL_INT;
+			mutex_unlock(&data->lock);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			*val = 100;
+			*val2 = 65535;
+			break;
+		case IIO_TEMP:
+			*val = 175000;
+			*val2 = 65535;
+			break;
+		default:
+			return -EINVAL;
+		}
+		ret = IIO_VAL_FRACTIONAL;
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 18349; /* 18349.8 */
+		*val2 = 800000;
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	}
+
+	return ret;
+}
+
+static int sht31_set_it_time(struct sht31_data *data, int val2)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sht31_integration_time); i++) {
+		if (sht31_integration_time[i][0] == val2) {
+			data->it_time = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int sht31_validate_checksum(struct sht31_data *data)
+{
+	struct i2c_client *client = data->client;
+	struct i2c_msg msg[2];
+	u16 reg = cpu_to_be16(SHT31_STATUS_CMD);
+	u8 vals[3];
+	int ret;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = client->flags;
+	msg[0].len = 2;
+	msg[0].buf = (char *) &reg;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = client->flags | I2C_M_RD;
+	msg[1].len = sizeof(vals);
+	msg[1].buf = (char *) &vals;
+
+	ret = i2c_transfer(client->adapter, msg, 2);
+	if (ret != 2)
+		return -EIO;
+
+	ret = sht31_crc8_check(data, (u8 *) &vals);
+	if (ret)
+		return ret;
+
+	return (vals[1] & SHT31_STATUS_CMD_CHKSUM) ? -EINVAL : 0;
+}
+
+static int sht31_set_heater_status(struct sht31_data *data, int val)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, SHT31_HEATER_CMD_MSB,
+		val ? SHT31_HEATER_CMD_ENABLE : SHT31_HEATER_CMD_DISABLE);
+	if (ret < 0)
+		return ret;
+
+	ret = sht31_validate_checksum(data);
+	if (!ret)
+		data->heater_status = !!val;
+
+	return ret;
+}
+
+static int sht31_write_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int val, int val2, long mask)
+{
+	struct sht31_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0)
+			return -EINVAL;
+
+		mutex_lock(&data->lock);
+		ret = sht31_set_it_time(data, val2);
+		mutex_unlock(&data->lock);
+		break;
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_CURRENT || val2 != 0)
+			return -EINVAL;
+
+		mutex_lock(&data->lock);
+		ret = sht31_set_heater_status(data, val);
+		mutex_unlock(&data->lock);
+		break;
+	}
+
+	return ret;
+}
+
+static const struct iio_info sht31_info = {
+	.driver_module = THIS_MODULE,
+	.read_raw = sht31_read_raw,
+	.write_raw = sht31_write_raw,
+	.attrs = &sht31_attribute_group,
+};
+
+static int sht31_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	struct sht31_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+	data = iio_priv(indio_dev);
+
+	indio_dev->info = &sht31_info;
+	indio_dev->name = SHT31_DRV_NAME;
+	indio_dev->channels = sht31_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sht31_channels);
+	indio_dev->available_scan_masks = sht31_scan_masks;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &client->dev;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	data->client = client;
+	data->indio_dev = indio_dev;
+	mutex_init(&data->lock);
+
+	/* CRC polynomial x8 + x5 + x4 + 1 */
+	crc8_populate_msb(data->crc_table, 0x31);
+
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+					 sht31_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_unreg_buffer;
+
+	return 0;
+
+error_unreg_buffer:
+	iio_triggered_buffer_cleanup(indio_dev);
+
+	return ret;
+}
+
+static int sht31_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+
+	return 0;
+}
+
+static const struct of_device_id sht31_dt_ids[] = {
+	{ .compatible = "sensirion,sht31" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sht31_dt_ids);
+
+static const struct i2c_device_id sht31_id[] = {
+	{ "sht31", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sht31_id);
+
+static struct i2c_driver sht31_driver = {
+	.driver = {
+		.name = SHT31_DRV_NAME,
+	},
+	.probe = sht31_probe,
+	.remove = sht31_remove,
+	.id_table = sht31_id,
+};
+module_i2c_driver(sht31_driver);
+
+MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_DESCRIPTION("Sensirion SHT31 humidity and temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4
