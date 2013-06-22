Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36909 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab3FVVyV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 22 Jun 2013 17:54:21 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: add ds1077 programmable oscillator driver
Date: Sat, 22 Jun 2013 23:54:03 +0200
Message-Id: <1371938043-3865-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/frequency/Kconfig        |  10 +
 drivers/iio/frequency/Makefile       |   1 +
 drivers/iio/frequency/ds1077.c       | 425 +++++++++++++++++++++++++++++++++++
 include/linux/iio/frequency/ds1077.h |  22 ++
 4 files changed, 458 insertions(+)
 create mode 100644 drivers/iio/frequency/ds1077.c
 create mode 100644 include/linux/iio/frequency/ds1077.h

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 6aaa33e..f1cdb15 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -7,6 +7,16 @@
 
 menu "Frequency Synthesizers DDS/PLL"
 
+config DS1077
+	tristate "Maxim DS1077 Programmable Fixed-Frequency Oscillator"
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Maxim DS1077
+	  Programmable Fixed-Frequency Oscillator.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ds1077.
+
 menu "Clock Generator/Distribution"
 
 config AD9523
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index 00d26e5..095dcad 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
+obj-$(CONFIG_DS1077) += ds1077.o
diff --git a/drivers/iio/frequency/ds1077.c b/drivers/iio/frequency/ds1077.c
new file mode 100644
index 0000000..a0bc532
--- /dev/null
+++ b/drivers/iio/frequency/ds1077.c
@@ -0,0 +1,425 @@
+/*
+ * ds1077.c - Support for Maxim DS1077 programmable fixed-frequency
+ * oscillator
+ *
+ * Copyright 2013 Peter Meerwald <pmeerw@pmeerw.net>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * IIO driver for the DS1077 with 7-bit I2C slave address 0x58
+ *
+ * Driver can optionally use two GPIOs specified via platform data; these
+ * allow to enable/disable output 1 and to enter power-down mode (TODO).
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/frequency/ds1077.h>
+
+#define DS1077_DRV_NAME "ds1077"
+
+#define DS1077_DIV 0x01
+#define DS1077_MUX 0x02
+#define DS1077_BUS 0x0d
+#define DS1077_E2 0x3f
+
+#define DS1077_DIV1_MASK 0x0040
+#define DS1077_M1_MASK 0x0180
+#define DS1077_M1_SHIFT 7
+#define DS1077_M0_MASK 0x0600
+#define DS1077_M0_SHIFT 9
+#define DS1077_N1_MASK 0xffc0
+#define DS1077_N1_SHIFT 6
+#define DS1077_EN0_MASK 0x0800
+#define DS1077_SEL0_MASK 0x1000
+#define DS1077_PDN0_MASK 0x2000
+#define DS1077_PDN1_MASK 0x4000
+#define DS1077_WC_MASK 0x08
+
+#define DS1077_DIV1(data) ((data)->mux & DS1077_DIV1_MASK)
+#define DS1077_M1(data) (((data)->mux & DS1077_M1_MASK) >> DS1077_M1_SHIFT)
+#define DS1077_M0(data) (((data)->mux & DS1077_M0_MASK) >> DS1077_M0_SHIFT)
+#define DS1077_N1(data) ((data)->div >> DS1077_N1_SHIFT)
+#define DS1077_EN0(data) ((data)->mux & DS1077_EN0_MASK)
+#define DS1077_SEL0(data) ((data)->mux & DS1077_SEL0_MASK)
+#define DS1077_PDN0(data) ((data)->mux & DS1077_PDN0_MASK)
+#define DS1077_PDN1(data) ((data)->mux & DS1077_PDN1_MASK)
+
+#define DS1077_FREQDIFF(f, m, d) ((div) ? abs((long) ((f) - (m)/(d))) : (m))
+
+struct ds1077_data {
+	struct i2c_client *client;
+	struct ds1077_platform_data *pdata;
+	struct mutex lock;
+	unsigned long master_freq;
+	bool en0;
+	bool en1;
+	bool pdn;
+	int gpio_ctrl0;
+	int gpio_ctrl1;
+	u16 mux;
+	u16 div;
+};
+
+static unsigned long ds1077_master_freq[] = {
+	133333000,
+	125000000,
+	120000000,
+	100000000,
+	66666000
+};
+
+static const struct i2c_device_id ds1077_id[] = {
+	{ "ds1077-133", 0 },
+	{ "ds1077-125", 1 },
+	{ "ds1077-120", 2 },
+	{ "ds1077-100", 3 },
+	{ "ds1077-66", 4 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ds1077_id);
+
+static int ds1077_store_eeprom(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ds1077_data *data = iio_priv(indio_dev);
+	bool state;
+	int ret;
+
+	ret = strtobool(buf, &state);
+	if (ret < 0)
+		return ret;
+
+	if (!state)
+		return 0;
+
+	ret = i2c_smbus_write_byte(data->client, DS1077_E2);
+
+	return ret ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(store_eeprom, S_IWUSR, NULL, ds1077_store_eeprom, 0);
+
+static struct attribute *ds1077_attributes[] = {
+	&iio_dev_attr_store_eeprom.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ds1077_attribute_group = {
+	.attrs = ds1077_attributes,
+};
+
+static const struct iio_chan_spec ds1077_channels[] = {
+	{
+		.type = IIO_ALTVOLTAGE,
+		.output = 1,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_ALTVOLTAGE,
+		.output = 1,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	}
+};
+
+static int ds1077_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	int ret = -EINVAL;
+	struct ds1077_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->channel == 0) {
+			*val = data->en0;
+			return IIO_VAL_INT;
+		} else if (chan->channel == 1) {
+			*val = data->en1;
+			return IIO_VAL_INT;
+		}
+		break;
+	case IIO_CHAN_INFO_FREQUENCY:
+		if (chan->channel == 0) {
+			*val = data->master_freq / (1 << DS1077_M0(data));
+			return IIO_VAL_INT;
+		} else if (chan->channel == 1) {
+			*val = data->master_freq / (1 << DS1077_M1(data)) /
+			    (DS1077_DIV1(data) ? 1 : (DS1077_N1(data) + 2));
+			return IIO_VAL_INT;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static unsigned ds1077_find_prescaler(unsigned long mf, unsigned long f)
+{
+	unsigned long p = (mf + mf/2) / f;
+	unsigned m = 0;
+
+	if (p >= 8)
+		m = 3;
+	else if (p >= 4)
+		m = 2;
+	else if (p >= 2)
+		m = 1;
+
+	return m;
+}
+
+static void ds1077_find_divider(struct ds1077_data *data, unsigned long f)
+{
+	unsigned m = 0, n = 0;
+
+	unsigned long div = data->master_freq / f;
+	if (DS1077_FREQDIFF(f, data->master_freq, div) >
+	    DS1077_FREQDIFF(f, data->master_freq, div + 1))
+		div++;
+	if (div <= 1)
+		data->mux |= DS1077_DIV1_MASK;
+	else {
+		data->mux &= ~DS1077_DIV1_MASK;
+
+		m = ds1077_find_prescaler(div, 1025);
+		div /= (1 << m);
+
+		if (div >= 2)
+			n = min(div - 2, 1023ul);
+	}
+
+	data->div = n << DS1077_N1_SHIFT;
+	data->mux = (data->mux & ~(DS1077_M1_MASK)) |
+		(m << DS1077_M1_SHIFT);
+}
+
+static int ds1077_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	int ret = -EINVAL;
+	struct ds1077_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->channel == 0) {
+			if (!!val == data->en0)
+				return 0;
+			if (val)
+				data->mux |= DS1077_EN0_MASK |
+					DS1077_SEL0_MASK;
+			else
+				data->mux &= ~(DS1077_EN0_MASK |
+					DS1077_SEL0_MASK);
+			ret = i2c_smbus_write_word_data(data->client,
+				DS1077_MUX, cpu_to_be16(data->mux));
+			if (ret < 0)
+				return ret;
+			data->en0 = !data->en0;
+			return 0;
+		} else if (chan->channel == 1) {
+			if (!!val == data->en1)
+				return 0;
+			if (!data->pdata ||
+				!gpio_is_valid(data->pdata->gpio_ctrl1))
+				goto out;
+			gpio_set_value(data->pdata->gpio_ctrl1, !val);
+			data->en1 = !data->en1;
+			return 0;
+		}
+		break;
+	case IIO_CHAN_INFO_FREQUENCY:
+		if (val <= 0 || val > data->master_freq)
+			goto out;
+
+		if (chan->channel == 0) {
+			u16 m0 = ds1077_find_prescaler(data->master_freq,
+				val);
+			data->mux = (data->mux & ~DS1077_M0_MASK) |
+				(m0 << DS1077_M0_SHIFT);
+		} else if (chan->channel == 1)
+			ds1077_find_divider(data, val);
+
+		mutex_lock(&data->lock);
+		ret = i2c_smbus_write_word_data(data->client, DS1077_MUX,
+			cpu_to_be16(data->mux));
+		if (ret < 0)
+			return ret;
+
+		ret = i2c_smbus_write_word_data(data->client, DS1077_DIV,
+			cpu_to_be16(data->div));
+		if (ret < 0)
+			return ret;
+		mutex_unlock(&data->lock);
+		break;
+	default:
+		break;
+	}
+
+out:
+	return ret;
+}
+
+static const struct iio_info ds1077_info = {
+	.read_raw = ds1077_read_raw,
+	.write_raw = ds1077_write_raw,
+	.attrs = &ds1077_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+static int ds1077_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct ds1077_platform_data *pdata = client->dev.platform_data;
+	struct ds1077_data *data;
+	struct iio_dev *indio_dev;
+	u8 bus;
+	int ret;
+
+	indio_dev = iio_device_alloc(sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->pdata = pdata;
+	mutex_init(&data->lock);
+
+	data->master_freq = ds1077_master_freq[id->driver_data];
+
+	ret = i2c_smbus_read_word_data(client, DS1077_MUX);
+	if (ret < 0)
+		goto error_free_dev;
+	data->mux = be16_to_cpu(ret);
+
+	if (DS1077_PDN0(data) || DS1077_PDN1(data)) {
+		dev_err(&client->dev, "unsupported power-down muxing");
+		goto error_free_dev;
+	}
+
+	if ((!DS1077_EN0(data) && DS1077_SEL0(data)) ||
+		(DS1077_EN0(data) && !DS1077_SEL0(data))) {
+		dev_err(&client->dev, "unsupported mode muxing");
+		goto error_free_dev;
+	}
+
+	ret = i2c_smbus_read_word_data(client, DS1077_DIV);
+	if (ret < 0)
+		goto error_free_dev;
+	data->div = be16_to_cpu(ret);
+
+	if (pdata) {
+		if (gpio_is_valid(pdata->gpio_ctrl0)) {
+			ret = gpio_request(pdata->gpio_ctrl0, "ds1077 ctrl0");
+			if (ret) {
+				dev_err(&client->dev, "failed to request ctrl0 GPIO%d",
+					pdata->gpio_ctrl0);
+				goto error_free_gpio0;
+			}
+			gpio_direction_output(pdata->gpio_ctrl0, 0);
+		}
+
+		if (gpio_is_valid(pdata->gpio_ctrl1)) {
+			ret = gpio_request(pdata->gpio_ctrl0, "ds1077 ctrl1");
+			if (ret) {
+				dev_err(&client->dev, "failed to request ctrl1 GPIO%d",
+					pdata->gpio_ctrl1);
+				goto error_free_gpio1;
+			}
+			gpio_direction_output(pdata->gpio_ctrl1, pdata->ctrl1);
+		}
+	}
+
+	/* disable automatic EEPROM update on write */
+	ret = i2c_smbus_read_byte_data(client, DS1077_BUS);
+	if (ret < 0)
+		goto error_free_gpio1;
+	bus = ret;
+	if (!(bus & DS1077_WC_MASK)) {
+		ret = i2c_smbus_write_byte_data(client, DS1077_BUS,
+			bus | DS1077_WC_MASK);
+		if (ret < 0)
+			goto error_free_gpio1;
+	}
+
+	data->en0 = DS1077_EN0(data);
+	data->en1 = pdata ? !pdata->ctrl1 : true;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ds1077_info;
+	indio_dev->channels = ds1077_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ds1077_channels);
+	indio_dev->name = DS1077_DRV_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto error_free_gpio1;
+
+	dev_info(&client->dev, "%s registered\n", id->name);
+
+	return 0;
+
+error_free_gpio1:
+	if (pdata && gpio_is_valid(pdata->gpio_ctrl1))
+		gpio_free(pdata->gpio_ctrl1);
+error_free_gpio0:
+	if (pdata && gpio_is_valid(pdata->gpio_ctrl0))
+		gpio_free(pdata->gpio_ctrl0);
+error_free_dev:
+	iio_device_free(indio_dev);
+	return ret;
+}
+
+static int ds1077_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ds1077_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	if (data->pdata) {
+		if (gpio_is_valid(data->pdata->gpio_ctrl1))
+			gpio_free(data->pdata->gpio_ctrl1);
+		if (gpio_is_valid(data->pdata->gpio_ctrl0))
+			gpio_free(data->pdata->gpio_ctrl0);
+	}
+	iio_device_free(indio_dev);
+
+	return 0;
+}
+
+static struct i2c_driver ds1077_driver = {
+	.driver = {
+		.name   = DS1077_DRV_NAME,
+		.owner  = THIS_MODULE,
+	},
+	.probe  = ds1077_probe,
+	.remove = ds1077_remove,
+	.id_table = ds1077_id,
+};
+
+module_i2c_driver(ds1077_driver);
+
+MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
+MODULE_DESCRIPTION("Maxim DS1077 programmable fixed-frequency oscillator driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/frequency/ds1077.h b/include/linux/iio/frequency/ds1077.h
new file mode 100644
index 0000000..1dcb41e
--- /dev/null
+++ b/include/linux/iio/frequency/ds1077.h
@@ -0,0 +1,22 @@
+/*
+ * ds1077.h - Support for Maxim DS1077 programmable fixed-frequency
+ * oscillator
+ *
+ * Copyright 2013 Peter Meerwald <pmeerw@pmeerw.net>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ */
+
+#ifndef IIO_FREQUENCY_DS1077_H_
+#define IIO_FREQUENCY_DS1077_H_
+
+struct ds1077_platform_data {
+	int gpio_ctrl0;
+	int gpio_ctrl1;
+	bool ctrl1;
+};
+
+#endif /* IIO_FREQUENCY_DS1077_H_ */
+
-- 
1.8.3.1

