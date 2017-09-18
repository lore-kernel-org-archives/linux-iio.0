Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:27008
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750883AbdIRWKt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Sep 2017 18:10:49 -0400
From: Ismail Kose <Ismail.Kose@maximintegrated.com>
Cc: ihkose@gmail.com, Ismail.Kose@maximintegrated.com,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Peter Rosin <peda@axentia.se>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: dac: ds4422/ds4424 dac driver
Date: Mon, 18 Sep 2017 15:09:59 -0700
Message-Id: <20170918221029.3610-1-Ismail.Kose@maximintegrated.com>
In-Reply-To: <20170623230404.2283-1-Ismail.Kose@maximintegrated.com>
References: <20170623230404.2283-1-Ismail.Kose@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain
To: unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: "Ismail H. Kose" <ihkose@gmail.com>

This patch provides an iio device driver for DS4422/DS4424 chips that support
two/four channel 7-bit Sink/Source Current DAC.

Signed-off-by: Ismail Kose <Ismail.Kose@maximintegrated.com>
---
v3:
	* Removed iio-map and platform file support
	* Removed ds4424.h file
	* Fixed ADC value read bug
	* Removed confused comments
	* Added device tree binding file
	* Fixed bugs in probe and read function

v2: (https://lkml.org/lkml/2017/9/14/546)
	* Fixed coding style and removed unncessary code
	* Removed min/max rfs, ifs-scale, etc values from device tree
	* Removed unused code, definitions and some comments
	* Removed regulator control and made standard structure
	* Removed data processing and channel scale
	* Removed device tree binding file

 .../devicetree/bindings/iio/dac/ds4424.txt         |  20 ++
 drivers/iio/dac/Kconfig                            |   9 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ds4424.c                           | 399 +++++++++++++++++++++
 4 files changed, 429 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ds4424.txt
 create mode 100644 drivers/iio/dac/ds4424.c

diff --git a/Documentation/devicetree/bindings/iio/dac/ds4424.txt b/Documentation/devicetree/bindings/iio/dac/ds4424.txt
new file mode 100644
index 000000000000..840b11e1d813
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ds4424.txt
@@ -0,0 +1,20 @@
+Maxim Integrated DS4422/DS4424 7-bit Sink/Source Current DAC Device Driver
+
+Datasheet publicly available at:
+https://datasheets.maximintegrated.com/en/ds/DS4422-DS4424.pdf
+
+Required properties:
+	- compatible: Must be "maxim,ds4422" or "maxim,ds4424"
+	- reg: Should contain the DAC I2C address
+	- maxim,rfs-resistors-ohms: Should contain reference resistor
+
+Optional properties:
+	- vcc-supply: Power supply is optional. If not defined, driver will ignore it.
+
+Example:
+	ds4224@10 {
+		compatible = "maxim,ds4424";
+		reg = <0x10>; /* When A0, A1 pins are ground */
+		vcc-supply = "dac_vcc_3v3";
+		maxim,rfs-resistors-ohms = <400 800 1000 1600>;
+	};
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 25bed2d7d2b9..db6ceba1c76f 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -310,4 +310,13 @@ config VF610_DAC
 	  This driver can also be built as a module. If so, the module will
 	  be called vf610_dac.
 
+config DS4424
+	tristate "Maxim Integrated DS4422/DS4424 DAC driver"
+	depends on I2C
+	help
+	  If you say yes here you get support for Maxim chips DS4422, DS4424.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ds4424.
+
 endmenu
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 603587cc2f07..f29f929a0587 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -33,3 +33,4 @@ obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
 obj-$(CONFIG_STM32_DAC) += stm32-dac.o
 obj-$(CONFIG_VF610_DAC) += vf610_dac.o
+obj-$(CONFIG_DS4424) += ds4424.o
diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
new file mode 100644
index 000000000000..46ae28081cf0
--- /dev/null
+++ b/drivers/iio/dac/ds4424.c
@@ -0,0 +1,399 @@
+/*
+ * Maxim Integrated
+ * 7-bit, Multi-Channel Sink/Source Current DAC Driver
+ * Copyright (C) 2017 Maxim Integrated
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/machine.h>
+#include <linux/iio/consumer.h>
+
+#define DS4422_MAX_DAC_CHANNELS		2
+#define DS4424_MAX_DAC_CHANNELS		4
+
+#define DS4424_DAC_ADDR(chan)   ((chan) + 0xf8)
+#define DS4424_SOURCE_I		1
+#define DS4424_SINK_I		0
+
+#define DS4424_CHANNEL(chan) { \
+	.type = IIO_CURRENT, \
+	.indexed = 1, \
+	.output = 1, \
+	.channel = chan, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.address = DS4424_DAC_ADDR(chan), \
+}
+
+/*
+ * DS4424 DAC control register 8 bits
+ * [7]		0: to sink; 1: to source
+ * [6:0]	steps to sink/source
+ * bit[7] looks like a sign bit, but the value of the register is
+ * not a two's complement code considering the bit[6:0] is a absolute
+ * distance from the zero point.
+ */
+union ds4424_raw_data {
+	struct {
+		u8 dx:7;
+		u8 source_bit:1;
+	};
+	u8 bits;
+};
+
+enum ds4424_device_ids {
+	ID_DS4422,
+	ID_DS4424,
+};
+
+struct ds4424_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	__maybe_unused uint16_t save[DS4424_MAX_DAC_CHANNELS];
+	uint32_t rfs_res[DS4424_MAX_DAC_CHANNELS];
+	struct regulator *vcc_reg;
+	uint8_t raw[DS4424_MAX_DAC_CHANNELS];
+};
+
+static const struct iio_chan_spec ds4424_channels[] = {
+	DS4424_CHANNEL(0),
+	DS4424_CHANNEL(1),
+	DS4424_CHANNEL(2),
+	DS4424_CHANNEL(3),
+};
+
+static int ds4424_get_value(struct iio_dev *indio_dev,
+			     int *val, int channel)
+{
+	struct ds4424_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_read_byte_data(data->client, DS4424_DAC_ADDR(channel));
+	if (ret < 0)
+		goto fail;
+
+	*val = ret;
+	mutex_unlock(&data->lock);
+	return 0;
+
+fail:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int ds4424_set_value(struct iio_dev *indio_dev,
+			     int val, struct iio_chan_spec const *chan)
+{
+	struct ds4424_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (val < 0 || val > U8_MAX)
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	ret = i2c_smbus_write_byte_data(data->client,
+			DS4424_DAC_ADDR(chan->channel), val);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	data->raw[chan->channel] = val;
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static int ds4424_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	union ds4424_raw_data raw;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ds4424_get_value(indio_dev, val, chan->channel);
+		if (ret < 0) {
+			pr_err("%s : ds4424_get_value returned %d\n",
+							__func__, ret);
+			return ret;
+		}
+		raw.bits = *val;
+		*val = raw.dx;
+		if (raw.source_bit == DS4424_SINK_I)
+			*val = -*val;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ds4424_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	union ds4424_raw_data raw;
+
+	if (val2 != 0)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < S8_MIN || val > S8_MAX)
+			return -EINVAL;
+
+		if (val > 0) {
+			raw.source_bit = DS4424_SOURCE_I;
+			raw.dx = val;
+		} else {
+			raw.source_bit = DS4424_SINK_I;
+			raw.dx = -val;
+		}
+
+		return ds4424_set_value(indio_dev, raw.bits, chan);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ds4424_verify_chip(struct iio_dev *indio_dev)
+{
+	int ret = 0, val;
+
+	ret = ds4424_get_value(indio_dev, &val, DS4424_DAC_ADDR(0));
+	if (ret < 0)
+		dev_err(&indio_dev->dev,
+				"%s failed. ret: %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int __maybe_unused ds4424_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ds4424_data *data = iio_priv(indio_dev);
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		data->save[i] = data->raw[i];
+		ret = ds4424_set_value(indio_dev, 0,
+				&indio_dev->channels[i]);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
+static int __maybe_unused ds4424_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ds4424_data *data = iio_priv(indio_dev);
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		ret = ds4424_set_value(indio_dev, data->save[i],
+				&indio_dev->channels[i]);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend, ds4424_resume);
+
+static const struct iio_info ds4424_info = {
+	.read_raw = ds4424_read_raw,
+	.write_raw = ds4424_write_raw,
+};
+
+#ifdef CONFIG_OF
+static int ds4424_parse_dt(struct iio_dev *indio_dev)
+{
+	int ret;
+	int len;
+	int count;
+	struct property *prop;
+	struct ds4424_data *data = iio_priv(indio_dev);
+	struct device_node *node = indio_dev->dev.of_node;
+
+	if (!node) {
+		pr_info("%s:%d ds4424 DT not found\n", __func__, __LINE__);
+		return -ENODEV;
+	}
+
+	prop = of_find_property(node, "maxim,rfs-resistors-ohms", &len);
+	if (!prop) {
+		pr_err("ds4424 maxim,rfs-resistor not found in DT.\n");
+		return -EINVAL;
+	}
+
+	if (len != (DS4424_MAX_DAC_CHANNELS * sizeof(uint32_t))) {
+		pr_err("ds4424 maxim,rfs-resistor length in DT not valid.\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32_array(node, "maxim,rfs-resistors-ohms",
+				 data->rfs_res, DS4424_MAX_DAC_CHANNELS);
+	if (ret < 0) {
+		pr_err("ds4424 reading maxim,rfs-resistors from DT failed.\n");
+		return ret;
+	}
+
+	pr_info("ds4424 maxim,rfs-resistors: %d, %d, %d, %d\n",
+			data->rfs_res[0], data->rfs_res[1],
+			data->rfs_res[2], data->rfs_res[3]);
+
+	return 0;
+}
+#else
+static int ds4424_parse_dt(struct iio_dev *indio_dev)
+{
+	return -ENODEV;
+}
+#endif
+
+static int ds4424_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct ds4424_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev) {
+		dev_err(&client->dev, "iio dev alloc failed.\n");
+		return -ENOMEM;
+	}
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	indio_dev->name = id->name;
+	indio_dev->dev.of_node = client->dev.of_node;
+	indio_dev->dev.parent = &client->dev;
+
+	if (!client->dev.of_node) {
+		dev_err(&client->dev,
+				"Not found DT.\n");
+		return -EPERM;
+	}
+
+	indio_dev->dev.of_node = client->dev.of_node;
+	ret = ds4424_parse_dt(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev,
+				"%s - of_node error\n", __func__);
+		return -EINVAL;
+	}
+
+	data->vcc_reg = devm_regulator_get(&client->dev, "vcc");
+	if (IS_ERR(data->vcc_reg)) {
+		ret = PTR_ERR(data->vcc_reg);
+		dev_err(&client->dev,
+			"Failed to get vcc-supply regulator: %d\n", ret);
+		return ret;
+	}
+
+	mutex_init(&data->lock);
+	ret = regulator_enable(data->vcc_reg);
+	if (ret < 0) {
+		dev_err(&client->dev,
+				"Unable to enable the regulator.\n");
+		return ret;
+	}
+
+	usleep_range(1000, 1200);
+	ret = ds4424_verify_chip(indio_dev);
+	if (ret < 0)
+		return -ENXIO;
+
+	switch (id->driver_data) {
+	case ID_DS4422:
+		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
+		break;
+	case ID_DS4424:
+		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
+		break;
+	default:
+		dev_err(&client->dev,
+				"ds4424: Invalid chip id.\n");
+		regulator_disable(data->vcc_reg);
+		return -ENXIO;
+	}
+
+	indio_dev->channels = ds4424_channels;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ds4424_info;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev,
+				"iio_device_register failed. ret: %d\n", ret);
+		regulator_disable(data->vcc_reg);
+	}
+
+	return ret;
+}
+
+static int ds4424_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ds4424_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	regulator_disable(data->vcc_reg);
+
+	return 0;
+}
+
+static const struct i2c_device_id ds4424_id[] = {
+	{ "ds4422", ID_DS4422 },
+	{ "ds4424", ID_DS4424 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, ds4424_id);
+
+static const struct of_device_id ds4424_of_match[] = {
+	{ .compatible = "maxim,ds4422" },
+	{ .compatible = "maxim,ds4424" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, ds4424_of_match);
+
+static struct i2c_driver ds4424_driver = {
+	.driver = {
+		.name	= "ds4424",
+		.of_match_table = ds4424_of_match,
+		.pm     = &ds4424_pm_ops,
+	},
+	.probe		= ds4424_probe,
+	.remove		= ds4424_remove,
+	.id_table	= ds4424_id,
+};
+module_i2c_driver(ds4424_driver);
+
+MODULE_DESCRIPTION("Maxim DS4424 DAC Driver");
+MODULE_AUTHOR("Ismail H. Kose <ismail.kose@maximintegrated.com>");
+MODULE_AUTHOR("Vishal Sood <vishal.sood@maximintegrated.com>");
+MODULE_AUTHOR("David Jung <david.jung@maximintegrated.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

