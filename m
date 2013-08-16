Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:58364 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab3HPONj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Aug 2013 10:13:39 -0400
Received: by mail-ee0-f45.google.com with SMTP id c50so961774eek.4
        for <linux-iio@vger.kernel.org>; Fri, 16 Aug 2013 07:13:38 -0700 (PDT)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: [PATCH v4 1/1] Add Microchip MCP3422/3/4 high resolution ADC.
Date: Fri, 16 Aug 2013 16:12:50 +0200
Message-Id: <1376662370-13933-1-git-send-email-angelo.compagnucci@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is the fourth iteration of the patch.
It solves the most outstanding problems arised by Peter and Jonathan.
The most important one is that the chip setup is differentiated by
the devide id.

To Jonathan: The PGA is the internal programmable gain amplifier circuitry, 
and it's not releated to the sample rate in any significative manner.
It amplifies the signal at the source and could be configured indipendently
by the user as stated in the datasheet.
So if I cannot use a new sysfs attribute because it's not in the ABI,
I should set it up to a default value and use the chip with suboptimal
features. Please give me a hint on how to solve this.

Thank you again for your support.


Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/Kconfig   |   10 ++
 drivers/iio/adc/Makefile  |    1 +
 drivers/iio/adc/mcp3422.c |  435 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 446 insertions(+)
 create mode 100644 drivers/iio/adc/mcp3422.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f725b45..e9879e6 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -145,6 +145,16 @@ config MCP320X
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp320x.
 
+config MCP3422
+	tristate "Microchip Technology MCP3422/3/4 driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Microchip Technology's MCP3422,
+	  MCP3423 or MCP3424 analog to digital converters.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mcp3422.
+
 config NAU7802
 	tristate "Nuvoton NAU7802 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 2a4324e..9772e3b 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
 obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
+obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_NAU7802) += nau7802.o
 obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
new file mode 100644
index 0000000..a357598
--- /dev/null
+++ b/drivers/iio/adc/mcp3422.c
@@ -0,0 +1,435 @@
+/*
+ * mcp3422.c - driver for the Microchip mcp3422/3/4 chip family
+ *
+ * Copyright (C) 2013, Angelo Compagnucci
+ * Author: Angelo Compagnucci <angelo.compagnucci@gmail.com>
+ *
+ * Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/22088b.pdf
+ *
+ * This driver exports the value of analog input voltage to sysfs, the
+ * voltage unit is nV.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/sysfs.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* Masks */
+#define MCP3422_CHANNEL_MASK	0x60
+#define MCP3422_PGA_MASK	0x03
+#define MCP3422_SRATE_MASK	0x0C
+#define MCP3422_SRATE_240	0x0
+#define MCP3422_SRATE_60	0x1
+#define MCP3422_SRATE_15	0x2
+#define MCP3422_SRATE_3	0x3
+#define MCP3422_PGA_1	0
+#define MCP3422_PGA_2	1
+#define MCP3422_PGA_4	2
+#define MCP3422_PGA_8	3
+#define MCP3422_CONT_SAMPLING	0x10
+
+#define MCP3422_CHANNEL(config)	((((config) & MCP3422_CHANNEL_MASK) >> 5) + 1)
+#define MCP3422_PGA(config)	((config) & MCP3422_PGA_MASK)
+#define MCP3422_SAMPLE_RATE(config)	(((config) & MCP3422_SRATE_MASK) >> 2)
+
+#define MCP3422_CHANNEL_VALUE(value) (((value - 1) << 5) & MCP3422_CHANNEL_MASK)
+#define MCP3422_PGA_VALUE(value) ((value) & MCP3422_PGA_MASK)
+#define MCP3422_SAMPLE_RATE_VALUE(value) ((value << 2) & MCP3422_SRATE_MASK)
+
+#define MCP3422_CHAN(index) \
+	{ \
+		.type = IIO_VOLTAGE, \
+		.indexed = 1, \
+		.channel = index, \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) \
+				| BIT(IIO_CHAN_INFO_SCALE), \
+	}
+
+/* LSB is in nV to eliminate floating point */
+static const u32 rates_to_lsb[] = {1000000, 250000, 62500, 15625};
+
+/* Client data (each client gets its own) */
+struct mcp3422 {
+	struct i2c_client *i2c;
+	u8 config;
+	struct mutex lock;
+};
+
+static int mcp3422_update_config(struct mcp3422 *adc, u8 newconfig)
+{
+	int ret;
+
+	mutex_lock(&adc->lock);
+
+	ret = i2c_master_send(adc->i2c, &newconfig, 1);
+	if (ret > 0)
+		adc->config = newconfig;
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static int mcp3422_read(struct mcp3422 *adc, int *value, u8 *config)
+{
+	int ret = 0;
+	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
+	u8 buf[4] = {0, 0, 0, 0};
+	u32 temp;
+
+	if (sample_rate == MCP3422_SRATE_3) {
+		ret = i2c_master_recv(adc->i2c, buf, 4);
+		temp = buf[0] << 16 | buf[1] << 8 | buf[2];
+		*config = buf[3];
+	} else {
+		ret = i2c_master_recv(adc->i2c, buf, 3);
+		temp = buf[0] << 8 | buf[1];
+		*config = buf[2];
+	}
+
+	switch (sample_rate) {
+	case MCP3422_SRATE_240:
+		*value = sign_extend32(temp, 12);
+		break;
+	case MCP3422_SRATE_60:
+		*value = sign_extend32(temp, 14);
+		break;
+	case MCP3422_SRATE_15:
+		*value = sign_extend32(temp, 16);
+		break;
+	case MCP3422_SRATE_3:
+		*value = sign_extend32(temp, 18);
+		break;
+	}
+
+	return ret;
+}
+
+static int mcp3422_read_channel(struct mcp3422 *adc,
+				struct iio_chan_spec const *channel, int *value)
+{
+	int ret, mtime = 0;
+	u8 config = 0;
+	u8 req_channel = channel->channel;
+
+	if (req_channel != MCP3422_CHANNEL(adc->config)) {
+		config = adc->config;
+		config &= ~MCP3422_CHANNEL_MASK;
+		config |= MCP3422_CHANNEL_VALUE(req_channel);
+		mcp3422_update_config(adc, config);
+		switch (MCP3422_SAMPLE_RATE(config)) {
+		case MCP3422_SRATE_240:
+			mtime = 1000 / 240;
+			break;
+		case MCP3422_SRATE_60:
+			mtime = 1000 / 60;
+			break;
+		case MCP3422_SRATE_15:
+			mtime = 1000 / 15;
+			break;
+		case MCP3422_SRATE_3:
+			mtime = 1000 / 3;
+			break;
+		}
+		msleep(mtime);
+	}
+
+	ret = mcp3422_read(adc, value, &config);
+	return ret;
+}
+
+static int mcp3422_read_raw(struct iio_dev *iio,
+			    struct iio_chan_spec const *channel, int *val1,
+			    int *val2, long mask)
+{
+	struct mcp3422 *adc = iio_priv(iio);
+	int err, temp = 0;
+
+	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
+	u8 pga         = MCP3422_PGA(adc->config);
+
+	err = mcp3422_read_channel(adc, channel, &temp);
+	if (err < 0)
+		return err;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val1 = temp;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+
+		temp = (temp * rates_to_lsb[sample_rate])
+			/ (pga ? 1 << pga : 1);
+
+		*val1 = temp / 1000000000;
+		*val2 = temp % 1000000000;
+
+		return IIO_VAL_INT_PLUS_NANO;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t mcp3422_set_sample_rate(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *iio = i2c_get_clientdata(client);
+	struct mcp3422 *adc = iio_priv(iio);
+	u8 value = 0;
+	u8 config = adc->config;
+
+	if (kstrtou8(buf, 10, &value) < 0)
+		return -EINVAL;
+
+	switch (value) {
+	case 240:
+		value = MCP3422_SRATE_240;
+		break;
+	case 60:
+		value = MCP3422_SRATE_60;
+		break;
+	case 15:
+		value = MCP3422_SRATE_15;
+		break;
+	case 3:
+		value = MCP3422_SRATE_3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	config &= ~MCP3422_SRATE_MASK;
+	config |= MCP3422_SAMPLE_RATE_VALUE(value);
+
+	mcp3422_update_config(adc, config);
+
+	return count;
+}
+
+static ssize_t mcp3422_get_sample_rate(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *iio = i2c_get_clientdata(client);
+	struct mcp3422 *adc = iio_priv(iio);
+	u8 value = 0;
+
+	switch (MCP3422_SAMPLE_RATE(adc->config)) {
+	case 0:
+		value = 240;
+		break;
+	case 1:
+		value = 60;
+		break;
+	case 2:
+		value = 15;
+		break;
+	case 3:
+		value = 3;
+		break;
+	}
+
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t mcp3422_set_pga(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *iio = i2c_get_clientdata(client);
+	struct mcp3422 *adc = iio_priv(iio);
+	u8 value = 0;
+	u8 config = adc->config;
+
+	if (kstrtou8(buf, 10, &value) < 0)
+		return -EINVAL;
+
+	switch (value) {
+	case 1:
+		value = MCP3422_PGA_1;
+		break;
+	case 2:
+		value = MCP3422_PGA_2;
+		break;
+	case 4:
+		value = MCP3422_PGA_4;
+		break;
+	case 8:
+		value = MCP3422_PGA_8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	config &= ~MCP3422_PGA_MASK;
+	config |= MCP3422_PGA_VALUE(value);
+
+	mcp3422_update_config(adc, config);
+
+	return count;
+}
+
+static ssize_t mcp3422_get_pga(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *iio = i2c_get_clientdata(client);
+	struct mcp3422 *adc = iio_priv(iio);
+
+	return sprintf(buf, "%d\n", 1 << MCP3422_PGA(adc->config));
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR,
+			mcp3422_get_sample_rate,
+			mcp3422_set_sample_rate);
+static IIO_DEVICE_ATTR(pga,
+			S_IRUGO | S_IWUSR,
+			mcp3422_get_pga,
+			mcp3422_set_pga, 0);
+static IIO_CONST_ATTR(sampling_frequency_available, "240 60 15 3");
+static IIO_CONST_ATTR(pga_available, "1 2 4 8");
+
+static struct attribute *mcp3422_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_pga.dev_attr.attr,
+	&iio_const_attr_pga_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group mcp3422_attribute_group = {
+	.attrs = mcp3422_attributes,
+};
+
+static const struct iio_chan_spec mcp3422_channels[] = {
+	MCP3422_CHAN(1),
+	MCP3422_CHAN(2),
+};
+
+static const struct iio_chan_spec mcp3424_channels[] = {
+	MCP3422_CHAN(1),
+	MCP3422_CHAN(2),
+	MCP3422_CHAN(3),
+	MCP3422_CHAN(4),
+};
+
+static const struct iio_info mcp3422_info = {
+	.read_raw = mcp3422_read_raw,
+	.attrs = &mcp3422_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
+static int mcp3422_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct mcp3422 *adc;
+	int err;
+	u8 config;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc = iio_priv(indio_dev);
+	adc->i2c = client;
+
+	mutex_init(&adc->lock);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = dev_name(&client->dev);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &mcp3422_info;
+
+	switch ((unsigned int)(id->driver_data)) {
+	case 2:
+	case 3:
+		indio_dev->channels = mcp3422_channels;
+		indio_dev->num_channels = ARRAY_SIZE(mcp3422_channels);
+		break;
+	case 4:
+		indio_dev->channels = mcp3424_channels;
+		indio_dev->num_channels = ARRAY_SIZE(mcp3424_channels);
+		break;
+	}
+
+	err = iio_device_register(indio_dev);
+	if (err < 0)
+		return err;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	/* meaningful default configuration */
+	config = (MCP3422_CONT_SAMPLING
+		| MCP3422_CHANNEL_VALUE(1)
+		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
+		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
+	mcp3422_update_config(adc, config);
+
+	return 0;
+}
+
+static int mcp3422_remove(struct i2c_client *client)
+{
+	struct iio_dev *iio = i2c_get_clientdata(client);
+
+	iio_device_unregister(iio);
+	iio_device_free(iio);
+
+	return 0;
+}
+
+static const struct i2c_device_id mcp3422_id[] = {
+	{ "mcp3422", 2 },
+	{ "mcp3423", 3 },
+	{ "mcp3424", 4 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp3422_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id mcp3422_of_match[] = {
+	{ .compatible = "mcp3422" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp3422_of_match);
+#endif
+
+static struct i2c_driver mcp3422_driver = {
+	.driver = {
+		.name = "mcp3422",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(mcp3422_of_match),
+	},
+	.probe = mcp3422_probe,
+	.remove = mcp3422_remove,
+	.id_table = mcp3422_id,
+};
+module_i2c_driver(mcp3422_driver);
+
+MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
+MODULE_DESCRIPTION("Microchip mcp3422/3/4 driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

