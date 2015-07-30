Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.galactique.jabatus.fr ([109.234.163.57]:52863 "EHLO
	mail.galactique.jabatus.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755284AbbG3JZ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jul 2015 05:25:56 -0400
From: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	ludovic.tancerel@maplehightech.com, William.Markezana@meas-spec.com
Subject: [PATCH V2 4/6] iio: Add htu21 meas-spec driver support
Date: Thu, 30 Jul 2015 11:25:43 +0200
Message-Id: <1438248345-25820-5-git-send-email-ludovic.tancerel@maplehightech.com>
In-Reply-To: <1438248345-25820-1-git-send-email-ludovic.tancerel@maplehightech.com>
References: <1438248345-25820-1-git-send-email-ludovic.tancerel@maplehightech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-meas-spec |   7 +
 drivers/iio/humidity/Kconfig                      |  11 ++
 drivers/iio/humidity/Makefile                     |   1 +
 drivers/iio/humidity/htu21.c                      | 228 ++++++++++++++++++++++
 4 files changed, 247 insertions(+)
 create mode 100644 drivers/iio/humidity/htu21.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
index 6d47e54..7b09d3a 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
+++ b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
@@ -5,3 +5,10 @@ Description:
                 Reading returns either '1' or '0'. '1' means that the
                 battery level supplied to sensor is below 2.25V.
                 This ABI is available for tsys02d, htu21, ms8607
+What:           /sys/bus/iio/devices/iio:deviceX/heater_enable
+KernelVersion:  4.1.0
+Contact:        linux-iio@vger.kernel.org
+Description:
+                Enable or disable heater function by writing either
+		'1' or '0'.
+                Same reading values apply
diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 4813b79..447a833 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -12,6 +12,17 @@ config DHT11
 	  Other sensors should work as well as long as they speak the
 	  same protocol.
 
+config HTU21
+	tristate "Measurement Specialties HTU21 humidity & temperature sensor"
+	depends on I2C
+        select IIO_MS_SENSORS_I2C
+	help
+	  If you say yes here you get support for the Measurement Specialties
+	  HTU21 humidity and temperature sensor.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called htu21.
+
 config SI7005
 	tristate "SI7005 relative humidity and temperature sensor"
 	depends on I2C
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index 86e2d26..826b1d5 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -3,5 +3,6 @@
 #
 
 obj-$(CONFIG_DHT11) += dht11.o
+obj-$(CONFIG_HTU21) += htu21.o
 obj-$(CONFIG_SI7005) += si7005.o
 obj-$(CONFIG_SI7020) += si7020.o
diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
new file mode 100644
index 0000000..870b631
--- /dev/null
+++ b/drivers/iio/humidity/htu21.c
@@ -0,0 +1,228 @@
+/*
+ * htu21.c - Support for Measurement-Specialties
+ *           htu21 temperature & humidity sensor
+ *
+ * Copyright (c) 2014 Measurement-Specialties
+ *
+ * Licensed under the GPL-2.
+ *
+ * (7-bit I2C slave address 0x40)
+ *
+ * Datasheet:
+ *  http://www.meas-spec.com/downloads/HTU21D.pdf
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/stat.h>
+#include <linux/module.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include "../common/ms_sensors/ms_sensors_i2c.h"
+
+#define HTU21_RESET				0xFE
+
+static const int htu21_samp_freq[4] = { 20, 40, 70, 120 };
+/* String copy of the above const for readability purpose */
+static const char htu21_show_samp_freq[] = "20 40 70 120";
+
+static int htu21_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *channel, int *val,
+			  int *val2, long mask)
+{
+	int ret, temperature;
+	unsigned int humidity;
+	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (channel->type) {
+		case IIO_TEMP:	/* in milli °C */
+			ret = ms_sensors_i2c_ht_read_temperature(dev_data,
+								 &temperature);
+			if (ret)
+				return ret;
+			*val = temperature;
+
+			return IIO_VAL_INT;
+		case IIO_HUMIDITYRELATIVE:	/* in milli %RH */
+			ret = ms_sensors_i2c_ht_read_humidity(dev_data,
+							      &humidity);
+			if (ret)
+				return ret;
+			*val = humidity;
+
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = htu21_samp_freq[dev_data->res_index];
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int htu21_write_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int val, int val2, long mask)
+{
+	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
+	int i, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		i = ARRAY_SIZE(htu21_samp_freq);
+		while (i-- > 0)
+			if (val == htu21_samp_freq[i])
+				break;
+		if (i < 0)
+			return -EINVAL;
+		mutex_lock(&dev_data->lock);
+		dev_data->res_index = i;
+		ret = ms_sensors_i2c_write_resolution(dev_data, i);
+		mutex_unlock(&dev_data->lock);
+
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec htu21_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	 },
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	 }
+};
+
+static ssize_t htu21_show_battery_low(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
+
+	return ms_sensors_i2c_show_battery_low(dev_data, buf);
+}
+
+static ssize_t htu21_show_heater(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
+
+	return ms_sensors_i2c_show_heater(dev_data, buf);
+}
+
+static ssize_t htu21_write_heater(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
+
+	return ms_sensors_i2c_write_heater(dev_data, buf, len);
+}
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(htu21_show_samp_freq);
+static IIO_DEVICE_ATTR(battery_low, S_IRUGO,
+		       htu21_show_battery_low, NULL, 0);
+static IIO_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR,
+		       htu21_show_heater, htu21_write_heater, 0);
+
+static struct attribute *htu21_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_battery_low.dev_attr.attr,
+	&iio_dev_attr_heater_enable.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group htu21_attribute_group = {
+	.attrs = htu21_attributes,
+};
+
+static const struct iio_info htu21_info = {
+	.read_raw = htu21_read_raw,
+	.write_raw = htu21_write_raw,
+	.attrs = &htu21_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+int htu21_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct ms_ht_dev *dev_data;
+	struct iio_dev *indio_dev;
+	int ret;
+	u64 serial_number;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WRITE_BYTE |
+				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+		dev_err(&client->dev,
+			"Adapter does not support some i2c transaction\n");
+		return -ENODEV;
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	dev_data = iio_priv(indio_dev);
+	dev_data->client = client;
+	dev_data->res_index = 0;
+	mutex_init(&dev_data->lock);
+
+	indio_dev->info = &htu21_info;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = htu21_channels;
+	indio_dev->num_channels = ARRAY_SIZE(htu21_channels);
+
+	i2c_set_clientdata(client, indio_dev);
+
+	ret = ms_sensors_i2c_reset(client, HTU21_RESET, 15000);
+	if (ret)
+		return ret;
+
+	ret = ms_sensors_i2c_read_serial(client, &serial_number);
+	if (ret)
+		return ret;
+	dev_info(&client->dev, "Serial number : %llx", serial_number);
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id htu21_id[] = {
+	{"htu21", 0},
+	{}
+};
+
+static struct i2c_driver htu21_driver = {
+	.probe = htu21_probe,
+	.id_table = htu21_id,
+	.driver = {
+		   .name = "htu21",
+		   .owner = THIS_MODULE,
+		   },
+};
+
+module_i2c_driver(htu21_driver);
+
+MODULE_DESCRIPTION("Measurement-Specialties htu21 temperature and humidity driver");
+MODULE_AUTHOR("William Markezana <william.markezana@meas-spec.com>");
+MODULE_AUTHOR("Ludovic Tancerel <ludovic.tancerel@maplehightech.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.3.7

