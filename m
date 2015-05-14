Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36723 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933310AbbENOV2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2015 10:21:28 -0400
Received: by wizk4 with SMTP id k4so243258221wiz.1
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2015 07:21:27 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: [PATCH v4] iio: add m62332 DAC driver
Date: Thu, 14 May 2015 17:21:16 +0300
Message-Id: <1431613276-13496-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

m62332 is a simple 2-channel DAC used on several Sharp Zaurus boards to
control LCD voltage, backlight and sound. The driver use regulators to
control the reference voltage and enabling/disabling the DAC.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---

Changes since v3:

 * Use IIO_CHAN_INFO_OFFSET to represent DAC output more precisely
 * Handle regulator_get_voltage() error
 * Minor changes in m62332_set_value()

 drivers/iio/dac/Kconfig  |  10 ++
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/m62332.c | 269 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+)
 create mode 100644 drivers/iio/dac/m62332.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 13471a7..e701e28 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -142,6 +142,16 @@ config AD7303
 	  To compile this driver as module choose M here: the module will be called
 	  ad7303.
 
+config M62332
+	tristate "Mitsubishi M62332 DAC driver"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Mitsubishi M62332
+	  (I2C 8-Bit DACs with rail-to-rail outputs).
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called m62332.
+
 config MAX517
 	tristate "Maxim MAX517/518/519/520/521 DAC driver"
 	depends on I2C
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 52be7e1..63ae056 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
 obj-$(CONFIG_AD7303) += ad7303.o
+obj-$(CONFIG_M62332) += m62332.o
 obj-$(CONFIG_MAX517) += max517.o
 obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
new file mode 100644
index 0000000..c23d7fa
--- /dev/null
+++ b/drivers/iio/dac/m62332.c
@@ -0,0 +1,269 @@
+/*
+ *  m62332.c - Support for Mitsubishi m62332 DAC
+ *
+ *  Copyright (c) 2014 Dmitry Eremin-Solenikov
+ *
+ *  Based on max517 driver:
+ *  Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+
+#include <linux/regulator/consumer.h>
+
+#define M62332_CHANNELS 2
+
+struct m62332_data {
+	struct i2c_client	*client;
+	u16			vref_mv;
+	struct regulator	*vcc;
+	struct mutex		mutex;
+	u8			raw[M62332_CHANNELS];
+#ifdef CONFIG_PM_SLEEP
+	u8			save[M62332_CHANNELS];
+#endif
+};
+
+static int m62332_set_value(struct iio_dev *indio_dev,
+	u8 val, int channel)
+{
+	struct m62332_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	u8 outbuf[2];
+	int res;
+
+	if (val == data->raw[channel])
+		return 0;
+
+	outbuf[0] = channel;
+	outbuf[1] = val;
+
+	mutex_lock(&data->mutex);
+
+	if (val) {
+		res = regulator_enable(data->vcc);
+		if (res)
+			goto out;
+	}
+
+	res = i2c_master_send(client, outbuf, 2);
+	if (res >= 0 && res != 2)
+		res = -EIO;
+	if (res < 0)
+		goto out;
+
+	data->raw[channel] = val;
+
+	if (!val)
+		regulator_disable(data->vcc);
+
+	mutex_unlock(&data->mutex);
+
+	return 0;
+
+out:
+	mutex_unlock(&data->mutex);
+
+	return res;
+}
+
+static int m62332_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	struct m62332_data *data = iio_priv(indio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		/* Corresponds to Vref / 2^(bits) */
+		*val = data->vref_mv;
+		*val2 = 8;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_RAW:
+		*val = data->raw[chan->channel];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 1;
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static int m62332_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val > 255)
+			return -EINVAL;
+
+		ret = m62332_set_value(indio_dev, val, chan->channel);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int m62332_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct m62332_data *data = iio_priv(indio_dev);
+	int ret;
+
+	data->save[0] = data->raw[0];
+	data->save[1] = data->raw[1];
+
+	ret = m62332_set_value(indio_dev, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	return m62332_set_value(indio_dev, 0, 1);
+}
+
+static int m62332_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct m62332_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = m62332_set_value(indio_dev, data->save[0], 0);
+	if (ret < 0)
+		return ret;
+
+	return m62332_set_value(indio_dev, data->save[1], 1);
+}
+
+static SIMPLE_DEV_PM_OPS(m62332_pm_ops, m62332_suspend, m62332_resume);
+#define M62332_PM_OPS (&m62332_pm_ops)
+#else
+#define M62332_PM_OPS NULL
+#endif
+
+static const struct iio_info m62332_info = {
+	.read_raw = m62332_read_raw,
+	.write_raw = m62332_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+#define M62332_CHANNEL(chan) {				\
+	.type = IIO_VOLTAGE,				\
+	.indexed = 1,					\
+	.output = 1,					\
+	.channel = (chan),				\
+	.datasheet_name = "CH" #chan,			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+		BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_OFFSET),		\
+}
+
+static const struct iio_chan_spec m62332_channels[M62332_CHANNELS] = {
+	M62332_CHANNEL(0),
+	M62332_CHANNEL(1)
+};
+
+static int m62332_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct m62332_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	mutex_init(&data->mutex);
+
+	data->vcc = devm_regulator_get(&client->dev, "VCC");
+	if (IS_ERR(data->vcc))
+		return PTR_ERR(data->vcc);
+
+	/* establish that the iio_dev is a child of the i2c device */
+	indio_dev->dev.parent = &client->dev;
+
+	indio_dev->num_channels = M62332_CHANNELS;
+	indio_dev->channels = m62332_channels;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &m62332_info;
+
+	ret = regulator_get_voltage(data->vcc);
+	if (ret < 0)
+		return ret;
+	data->vref_mv = ret / 1000; /* mV */
+
+	ret = iio_map_array_register(indio_dev, client->dev.platform_data);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto err;
+
+	return 0;
+
+err:
+	iio_map_array_unregister(indio_dev);
+	return ret;
+}
+
+static int m62332_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	iio_map_array_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id m62332_id[] = {
+	{ "m62332", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, m62332_id);
+
+static struct i2c_driver m62332_driver = {
+	.driver = {
+		.name	= "m62332",
+		.pm	= M62332_PM_OPS,
+	},
+	.probe		= m62332_probe,
+	.remove		= m62332_remove,
+	.id_table	= m62332_id,
+};
+module_i2c_driver(m62332_driver);
+
+MODULE_AUTHOR("Dmitry Eremin-Solenikov");
+MODULE_DESCRIPTION("M62332 8-bit DAC");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

