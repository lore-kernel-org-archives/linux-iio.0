Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: humidity: add HDC100x support
Date: Sat, 29 Aug 2015 16:24:44 -0700
Message-Id: <1440890684-21310-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add support for the HDC100x temperature and humidity sensors
including the resistive heater element.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 .../ABI/testing/sysfs-bus-iio-humidity-hdc100x     |   7 +
 drivers/iio/humidity/Kconfig                       |  10 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hdc100x.c                     | 304 +++++++++++++++++++++
 4 files changed, 322 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
 create mode 100644 drivers/iio/humidity/hdc100x.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x b/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
new file mode 100644
index 0000000..7e823a8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
@@ -0,0 +1,7 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
+What:		/sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
+KernelVersion:	4.2
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Controls the heater device within the humidity sensor to get
+		rid of excess condensation.
diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 688c0d1..01906c8 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -12,6 +12,16 @@ config DHT11
 	  Other sensors should work as well as long as they speak the
 	  same protocol.
 
+config HDC100X
+	tristate "TI HDC100x relative humidity and temperature sensor"
+	depends on I2C
+	help
+	 Say yes here to build support for the TI HDC100x series of
+	 relative humidity and temperature sensor.
+
+	 To compile this driver as a module, choose M here: the module
+	 will be called hdc100x.
+
 config SI7005
 	tristate "SI7005 relative humidity and temperature sensor"
 	depends on I2C
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index 86e2d26..3e62c0a 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -3,5 +3,6 @@
 #
 
 obj-$(CONFIG_DHT11) += dht11.o
+obj-$(CONFIG_HDC100X) += hdc100x.o
 obj-$(CONFIG_SI7005) += si7005.o
 obj-$(CONFIG_SI7020) += si7020.o
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
new file mode 100644
index 0000000..88b21c8
--- /dev/null
+++ b/drivers/iio/humidity/hdc100x.c
@@ -0,0 +1,304 @@
+/*
+ * hdc100x.c - Support for the TI HDC100x temperature + humidity sensors
+ *
+ * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
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
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define HDC100X_REG_TEMP			0x00
+#define HDC100X_REG_HUMIDITY			0x01
+
+#define HDC100X_REG_CONFIG			0x02
+#define HDC100X_REG_CONFIG_HEATER_EN		BIT(13)
+
+struct hdc100x_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	u16 config;
+
+	/* integration time of the sensor */
+	int adc_int_us[2];
+};
+
+/* integration time in us */
+#define HDC100X_MAX_INT_TIME_ARRAY_SIZE		3
+static const int hdc100x_int_time[][HDC100X_MAX_INT_TIME_ARRAY_SIZE] = {
+	{ 6350, 3650, 0 },	/* IIO_TEMP channel*/
+	{ 6500, 3850, 2500 },	/* IIO_HUMIDITYRELATIVE channel */
+};
+
+static const int hdc100x_resolution_shift[][2] = { {10, 1}, {8, 2} };
+
+static IIO_CONST_ATTR(temp_integration_time_available,
+		"0.00365 0.00635");
+
+static IIO_CONST_ATTR(humidity_integration_time_available,
+		"0.0025 0.00385 0.0065");
+
+static IIO_CONST_ATTR(out_current_heater_raw_available,
+		"0 1");
+
+static struct attribute *hdc100x_attributes[] = {
+	&iio_const_attr_temp_integration_time_available.dev_attr.attr,
+	&iio_const_attr_humidity_integration_time_available.dev_attr.attr,
+	&iio_const_attr_out_current_heater_raw_available.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group hdc100x_attribute_group = {
+	.attrs = hdc100x_attributes,
+};
+
+static const struct iio_chan_spec hdc100x_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.channel = 0,
+		.address = HDC100X_REG_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_INT_TIME) |
+			BIT(IIO_CHAN_INFO_OFFSET),
+	},
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.channel = 1,
+		.address = HDC100X_REG_HUMIDITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_INT_TIME)
+	},
+
+	{
+		.type = IIO_CURRENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.extend_name = "heater",
+		.output = 1,
+	},
+};
+
+static int hdc100x_update_config(struct hdc100x_data *data, int mask, int val)
+{
+	data->config = (~mask & data->config) | val;
+
+	return i2c_smbus_write_word_data(data->client, HDC100X_REG_CONFIG,
+					 cpu_to_be16(data->config));
+}
+
+static int hdc100x_set_it_time(struct hdc100x_data *data, int chan, int val2)
+{
+	const int *int_time = (const int *) &hdc100x_int_time[chan];
+	int shift = hdc100x_resolution_shift[chan][0];
+	int ret = -EINVAL;
+	int i;
+
+	for (i = 0; i < HDC100X_MAX_INT_TIME_ARRAY_SIZE; i++) {
+		if (val2 && val2 == int_time[i]) {
+			ret = hdc100x_update_config(data,
+				hdc100x_resolution_shift[chan][1] << shift,
+				i << shift);
+			data->adc_int_us[chan] = val2;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int hdc100x_get_measurement(struct hdc100x_data *data,
+				   struct iio_chan_spec const *chan,
+				   int *val)
+{
+	struct i2c_client *client = data->client;
+	int delay = data->adc_int_us[chan->channel];
+	int ret;
+
+	/* start measurement */
+	ret = i2c_smbus_write_byte(client, chan->address);
+	if (ret < 0) {
+		dev_err(&client->dev, "cannot start measurement");
+		return ret;
+	}
+
+	/* wait for integration time to pass */
+	usleep_range(delay, delay + 1000);
+
+	if (ret < 0) {
+		dev_err(&client->dev, "cannot read low byte measurement");
+		return ret;
+	}
+	*val = ret >> 2;
+
+	ret = i2c_smbus_read_byte(client);
+	if (ret < 0) {
+		dev_err(&client->dev, "cannot read high byte measurement");
+		return ret;
+	}
+	*val |= ret << 6;
+
+	return 0;
+}
+
+static inline int get_heater_status(struct hdc100x_data *data)
+{
+	return !!(data->config & HDC100X_REG_CONFIG_HEATER_EN);
+}
+
+static int hdc100x_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct hdc100x_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->lock);
+		if (chan->type != IIO_CURRENT) {
+			ret = hdc100x_get_measurement(data, chan, val);
+			if (!ret)
+				ret = IIO_VAL_INT;
+		} else {
+			*val = get_heater_status(data);
+			ret = IIO_VAL_INT;
+		}
+		mutex_unlock(&data->lock);
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		mutex_lock(&data->lock);
+		*val = 0;
+		*val2 = data->adc_int_us[chan->channel];
+		mutex_unlock(&data->lock);
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_TEMP) {
+			*val = 165;
+			*val2 = 65536 >> 2;
+			ret = IIO_VAL_FRACTIONAL;
+		} else {
+			*val = 0;
+			*val2 = 10000;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		}
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -40;
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int hdc100x_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct hdc100x_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0)
+			return -EINVAL;
+
+		mutex_lock(&data->lock);
+		ret = hdc100x_set_it_time(data, chan->channel, val2);
+		mutex_unlock(&data->lock);
+		break;
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_CURRENT) {
+			if (val2 != 0)
+				return -EINVAL;
+
+			mutex_lock(&data->lock);
+			ret = hdc100x_update_config(data,
+					HDC100X_REG_CONFIG_HEATER_EN,
+					val ? 0 : HDC100X_REG_CONFIG_HEATER_EN);
+
+			if (!ret)
+				ret = IIO_VAL_INT;
+			mutex_unlock(&data->lock);
+		}
+		/* fall-thru */
+	}
+
+	return ret;
+}
+
+static const struct iio_info hdc100x_info = {
+	.read_raw = hdc100x_read_raw,
+	.write_raw = hdc100x_write_raw,
+	.attrs = &hdc100x_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+static int hdc100x_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct hdc100x_data *data;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	mutex_init(&data->lock);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = dev_name(&client->dev);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &hdc100x_info;
+
+	indio_dev->channels = hdc100x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(hdc100x_channels);
+
+	/* be sure we are in a known state */
+	hdc100x_set_it_time(data, 0, 6350);
+	hdc100x_set_it_time(data, 1, 6500);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id hdc100x_id[] = {
+	{ "hdc100x", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, hdc100x_id);
+
+static struct i2c_driver hdc100x_driver = {
+	.driver = {
+		.name	= "hdc100x",
+	},
+	.probe = hdc100x_probe,
+	.id_table = hdc100x_id,
+};
+module_i2c_driver(hdc100x_driver);
+
+MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_DESCRIPTION("TI HDC100x humidity and temperature sensor driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
