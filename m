Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:36622 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175AbcDHV1h (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Apr 2016 17:27:37 -0400
Date: Fri, 8 Apr 2016 23:27:25 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: potentiometer: add driver for Maxim Integrated DS1803
Message-ID: <20160408212725.GA10249@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following functions are supported:
 - write, read potentiometer value
 - potentiometer scale

Datasheet: https://datasheets.maximintegrated.com/en/ds/DS1803.pdf

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
Changes since v1:
- Removed unnecessary include file
- Use i2c_master_recv() in place of i2c_smbus_read_word_swapped()
- On raw write make sure val2 is zero
- Use ARRAY_SIZE when possible

 .../bindings/iio/potentiometer/ds1803.txt          |  21 +++
 drivers/iio/potentiometer/Kconfig                  |  10 ++
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/ds1803.c                 | 174 +++++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
 create mode 100644 drivers/iio/potentiometer/ds1803.c

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt b/Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
new file mode 100644
index 0000000..df77bf5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/ds1803.txt
@@ -0,0 +1,21 @@
+* Maxim Integrated DS1803 digital potentiometer driver
+
+The node for this driver must be a child node of a I2C controller, hence
+all mandatory properties for your controller must be specified. See directory:
+
+        Documentation/devicetree/bindings/i2c
+
+for more details.
+
+Required properties:
+	- compatible:  	Must be one of the following, depending on the
+			model:
+			"maxim,ds1803-010",
+			"maxim,ds1803-050",
+			"maxim,ds1803-100"
+
+Example:
+ds1803: ds1803@1 {
+	reg = <0x28>;
+	compatible = "maxim,ds1803-010";
+};
diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
index 7ea069b..6acb238 100644
--- a/drivers/iio/potentiometer/Kconfig
+++ b/drivers/iio/potentiometer/Kconfig
@@ -5,6 +5,16 @@
 
 menu "Digital potentiometers"
 
+config DS1803
+	tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
+	depends on I2C
+	help
+	  Say yes here to build support for the Maxim Integrated DS1803
+	  digital potentiomenter chip.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ds1803.
+
 config MCP4131
 	tristate "Microchip MCP413X/414X/415X/416X/423X/424X/425X/426X Digital Potentiometer driver"
 	depends on SPI
diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
index 91a80f8..6007faa 100644
--- a/drivers/iio/potentiometer/Makefile
+++ b/drivers/iio/potentiometer/Makefile
@@ -3,6 +3,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_DS1803) += ds1803.o
 obj-$(CONFIG_MCP4131) += mcp4131.o
 obj-$(CONFIG_MCP4531) += mcp4531.o
 obj-$(CONFIG_TPL0102) += tpl0102.o
diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
new file mode 100644
index 0000000..cfa4cc1
--- /dev/null
+++ b/drivers/iio/potentiometer/ds1803.c
@@ -0,0 +1,174 @@
+/*
+ * Maxim Integrated DS1803 digital potentiometer driver
+ * Copyright (c) 2016 Slawomir Stepien
+ *
+ * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS1803.pdf
+ *
+ * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
+ * ds1803	2	256		10, 50, 100		0101xxx
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#define DS1803_MAX_POS		255
+#define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
+
+enum ds1803_type {
+	DS1803_010,
+	DS1803_050,
+	DS1803_100,
+};
+
+struct ds1803_cfg {
+	int kohms;
+};
+
+static const struct ds1803_cfg ds1803_cfg[] = {
+	[DS1803_010] = { .kohms =  10, },
+	[DS1803_050] = { .kohms =  50, },
+	[DS1803_100] = { .kohms = 100, },
+};
+
+struct ds1803_data {
+	struct i2c_client *client;
+	const struct ds1803_cfg *cfg;
+};
+
+#define DS1803_CHANNEL(ch) {					\
+	.type = IIO_RESISTANCE,					\
+	.indexed = 1,						\
+	.output = 1,						\
+	.channel = (ch),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+}
+
+static const struct iio_chan_spec ds1803_channels[] = {
+	DS1803_CHANNEL(0),
+	DS1803_CHANNEL(1),
+};
+
+static int ds1803_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ds1803_data *data = iio_priv(indio_dev);
+	int pot = chan->channel;
+	int ret;
+	u16 result;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = i2c_master_recv(data->client, (char *)&result,
+				indio_dev->num_channels);
+		if (ret < 0)
+			return ret;
+
+		/* Get bits for given pot */
+		*val = (pot == 0 ? result & 0xff : result >> 8);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1000 * data->cfg->kohms;
+		*val2 = DS1803_MAX_POS;
+		return IIO_VAL_FRACTIONAL;
+	}
+
+	return -EINVAL;
+}
+
+static int ds1803_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct ds1803_data *data = iio_priv(indio_dev);
+	int pot = chan->channel;
+
+	if (val2 != 0)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val > DS1803_MAX_POS || val < 0)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
+}
+
+static const struct iio_info ds1803_info = {
+	.read_raw = ds1803_read_raw,
+	.write_raw = ds1803_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int ds1803_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct ds1803_data *data;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	data->cfg = &ds1803_cfg[id->driver_data];
+
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &ds1803_info;
+	indio_dev->channels = ds1803_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ds1803_channels);
+	indio_dev->name = client->name;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+#if defined(CONFIG_OF)
+static const struct of_device_id ds1803_dt_ids[] = {
+	{ .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
+	{ .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
+	{ .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ds1803_dt_ids);
+#endif /* CONFIG_OF */
+
+static const struct i2c_device_id ds1803_id[] = {
+	{ "ds1803-010", DS1803_010 },
+	{ "ds1803-050", DS1803_050 },
+	{ "ds1803-100", DS1803_100 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ds1803_id);
+
+static struct i2c_driver ds1803_driver = {
+	.driver = {
+		.name	= "ds1803",
+		.of_match_table = of_match_ptr(ds1803_dt_ids),
+	},
+	.probe		= ds1803_probe,
+	.id_table	= ds1803_id,
+};
+
+module_i2c_driver(ds1803_driver);
+
+MODULE_AUTHOR("Slawomir Stepien <sst@poczta.fm>");
+MODULE_DESCRIPTION("DS1803 digital potentiometer");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

