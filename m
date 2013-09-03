Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33416 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756379Ab3ICBKU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:10:20 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Jon Brenner <jon.brenner@ams.com>
Subject: [PATCH v2] iio: Add tsl4531 ambient light sensor driver
Date: Tue,  3 Sep 2013 03:10:11 +0200
Message-Id: <1378170611-27795-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

driver for the TSL4531 family of 16-bit I2C ambient light
sensors; information is here:
http://www.ams.com/eng/Products/Light-Sensors/Ambient-Light-Sensor-ALS/TSL45315

the chip offers simple lux output

v2:
* rename to tsl4351
* use INT_TIME

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jon Brenner <jon.brenner@ams.com>
---
 drivers/iio/light/Kconfig   |   10 ++
 drivers/iio/light/Makefile  |    1 +
 drivers/iio/light/tsl4531.c |  252 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 drivers/iio/light/tsl4531.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index bf9fa0d..488fff7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -65,6 +65,16 @@ config SENSORS_TSL2563
 	 This driver can also be built as a module.  If so, the module
 	 will be called tsl2563.
 
+config TSL4531
+	tristate "TAOS TSL4531 ambient light sensors"
+	depends on I2C
+	help
+	 Say Y here if you want to build a driver for the TAOS TSL4531 family
+	 of ambient light sensors with direct lux output.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called tsl4531.
+
 config VCNL4000
 	tristate "VCNL4000 combined ALS and proximity sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 354ee9a..cd6f3cf 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_APDS9300)		+= apds9300.o
 obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
+obj-$(CONFIG_TSL4531)		+= tsl4531.o
 obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
new file mode 100644
index 0000000..6e82de6
--- /dev/null
+++ b/drivers/iio/light/tsl4531.c
@@ -0,0 +1,252 @@
+/*
+ * tsl4531.c - Support for TAOS TSL4531 ambient light sensor
+ *
+ * Copyright 2013 Peter Meerwald <pmeerw@pmeerw.net>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * IIO driver for the TSL4531x family
+ *   TSL45311/TSL45313: 7-bit I2C slave address 0x39
+ *   TSL45315/TSL45317: 7-bit I2C slave address 0x29
+ *
+ * TODO: single cycle measurement
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define TSL4531_DRV_NAME "tsl4531"
+
+#define TCS3472_COMMAND BIT(7)
+
+#define TSL4531_CONTROL (TCS3472_COMMAND | 0x00)
+#define TSL4531_CONFIG (TCS3472_COMMAND | 0x01)
+#define TSL4531_DATA (TCS3472_COMMAND | 0x04)
+#define TSL4531_ID (TCS3472_COMMAND | 0x0a)
+
+/* operating modes in control register */
+#define TSL4531_MODE_POWERDOWN 0x00
+#define TSL4531_MODE_SINGLE_ADC 0x02
+#define TSL4531_MODE_NORMAL 0x03
+
+/* integration time control in config register */
+#define TSL4531_TCNTRL_400MS 0x00
+#define TSL4531_TCNTRL_200MS 0x01
+#define TSL4531_TCNTRL_100MS 0x02
+
+/* part number in id register */
+#define TSL45311_ID 0x8
+#define TSL45313_ID 0x9
+#define TSL45315_ID 0xa
+#define TSL45317_ID 0xb
+#define TSL4531_ID_SHIFT 4
+
+struct tsl4531_data {
+	struct i2c_client *client;
+	int int_time;
+};
+
+static IIO_CONST_ATTR_INT_TIME_AVAIL("0.1 0.2 0.4");
+
+static struct attribute *tsl4531_attributes[] = {
+	&iio_const_attr_integration_time_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group tsl4531_attribute_group = {
+	.attrs = tsl4531_attributes,
+};
+
+static const struct iio_chan_spec tsl4531_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_INT_TIME)
+	}
+};
+
+static int tsl4531_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct tsl4531_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = i2c_smbus_read_word_data(data->client,
+			TSL4531_DATA);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* 0.. 1x, 1 .. 2x, 2 .. 4x */
+		*val = 1 << data->int_time;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_INT_TIME:
+		if (data->int_time == 0)
+			*val2 = 400000;
+		else if (data->int_time == 1)
+			*val2 = 200000;
+		else if (data->int_time == 2)
+			*val2 = 100000;
+		else
+			return -EINVAL;
+		*val = 0;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int tsl4531_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct tsl4531_data *data = iio_priv(indio_dev);
+	int int_time, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0)
+			return -EINVAL;
+		if (val2 == 400000)
+			int_time = 0;
+		else if (val2 == 200000)
+			int_time = 1;
+		else if (val2 == 100000)
+			int_time = 2;
+		else
+			return -EINVAL;
+		ret = i2c_smbus_write_byte_data(data->client,
+			TSL4531_CONFIG, int_time);
+		if (ret >= 0)
+			data->int_time = int_time;
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info tsl4531_info = {
+	.read_raw = tsl4531_read_raw,
+	.write_raw = tsl4531_write_raw,
+	.attrs = &tsl4531_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+static int tsl4531_check_id(struct i2c_client *client)
+{
+	int ret = i2c_smbus_read_byte_data(client, TSL4531_ID);
+	if (ret < 0)
+		return ret;
+
+	ret >>= TSL4531_ID_SHIFT;
+	return ret == TSL45313_ID || ret == TSL45315_ID ||
+		ret == TSL45315_ID || ret == TSL45317_ID;
+}
+
+static int tsl4531_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct tsl4531_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev =  devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	if (!tsl4531_check_id(client)) {
+		dev_err(&client->dev, "no TSL4531 sensor\n");
+		return -ENODEV;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, TSL4531_CONTROL,
+		TSL4531_MODE_NORMAL);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(data->client, TSL4531_CONFIG,
+		TSL4531_TCNTRL_400MS);
+	if (ret < 0)
+		return ret;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &tsl4531_info;
+	indio_dev->channels = tsl4531_channels;
+	indio_dev->num_channels = ARRAY_SIZE(tsl4531_channels);
+	indio_dev->name = TSL4531_DRV_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int tsl4531_powerdown(struct i2c_client *client)
+{
+	return i2c_smbus_write_byte_data(client, TSL4531_CONTROL,
+		TSL4531_MODE_POWERDOWN);
+}
+
+static int tsl4531_remove(struct i2c_client *client)
+{
+	iio_device_unregister(i2c_get_clientdata(client));
+	tsl4531_powerdown(client);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int tsl4531_suspend(struct device *dev)
+{
+	return tsl4531_powerdown(to_i2c_client(dev));
+}
+
+static int tsl4531_resume(struct device *dev)
+{
+	return i2c_smbus_write_byte_data(to_i2c_client(dev), TSL4531_CONTROL,
+		TSL4531_MODE_NORMAL);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(tsl4531_pm_ops, tsl4531_suspend, tsl4531_resume);
+
+static const struct i2c_device_id tsl4531_id[] = {
+	{ "tsl4531", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tsl4531_id);
+
+static struct i2c_driver tsl4531_driver = {
+	.driver = {
+		.name   = TSL4531_DRV_NAME,
+		.pm	= &tsl4531_pm_ops,
+		.owner  = THIS_MODULE,
+	},
+	.probe  = tsl4531_probe,
+	.remove = tsl4531_remove,
+	.id_table = tsl4531_id,
+};
+
+module_i2c_driver(tsl4531_driver);
+
+MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
+MODULE_DESCRIPTION("TAOS TSL4531 ambient light sensors driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5

