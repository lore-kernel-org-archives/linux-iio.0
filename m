Return-Path: <tremyfr@yahoo.fr>
From: Philippe Reynes <tremyfr@yahoo.fr>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	armadeus-forum@lists.sourceforge.net,
	jic23@kernel.org,
	devicetree@vger.kernel.org,
	julien.boibessot@free.fr,
	Philippe Reynes <tremyfr@yahoo.fr>
Subject: [PATCH] iio: add support of the max5821
Date: Mon, 14 Jul 2014 19:32:39 +0200
Message-Id: <1405359159-12379-1-git-send-email-tremyfr@yahoo.fr>
List-ID: <linux-iio@vger.kernel.org>


Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
---
 .../devicetree/bindings/iio/dac/max5821.txt        |   18 +
 drivers/iio/dac/Kconfig                            |    8 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/max5821.c                          |  368 ++++++++++++++++++++
 4 files changed, 395 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/max5821.txt
 create mode 100644 drivers/iio/dac/max5821.c

diff --git a/Documentation/devicetree/bindings/iio/dac/max5821.txt b/Documentation/devicetree/bindings/iio/dac/max5821.txt
new file mode 100644
index 0000000..242265f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/max5821.txt
@@ -0,0 +1,18 @@
+Maxim max5821 DAC device driver
+
+Required properties:
+	- compatible: Must be "maxim,max5821"
+	- reg: Should contain the ADC I2C address
+
+Optional properties:
+	- vref_mv: Reference input Voltage in mv. This should only be set if
+	there is an external reference voltage connected to the REF
+	pin. If the property is not set, 3600 is used as the reference voltage.
+
+Example:
+
+	max5821@38 {
+		compatible = "maxim,max5821";
+		reg = <0x38>;
+		vref_mv = <3600>;
+	};
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index f378ca8..4428acb 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -152,6 +152,14 @@ config MAX517
 	  This driver can also be built as a module.  If so, the module
 	  will be called max517.
 
+config MAX5821
+	tristate "Maxim MAX5821 DAC driver"
+	depends on I2C
+	depends on OF
+	help
+	  Say yes here to build support for Maxim MAX5821
+	  10 bits dac.
+
 config MCP4725
 	tristate "MCP4725 DAC driver"
 	depends on I2C
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index bb84ad6..82545c0 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -17,4 +17,5 @@ obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
 obj-$(CONFIG_AD7303) += ad7303.o
 obj-$(CONFIG_MAX517) += max517.o
+obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
new file mode 100644
index 0000000..92a1aa3
--- /dev/null
+++ b/drivers/iio/dac/max5821.c
@@ -0,0 +1,368 @@
+ /*
+  * iio/dac/max5821.c
+  * Copyright (C) 2014 Philippe Reynes
+  *
+  * This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License version 2 as
+  * published by the Free Software Foundation.
+  */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+
+#define MAX5821_DRV_NAME			"max5821"
+#define MAX5821_MAX_DAC_CHANNELS		2
+
+/* command bytes */
+#define MAX5821_LOAD_DAC_A_IN_REG_B		0x00
+#define MAX5821_LOAD_DAC_B_IN_REG_A		0x10
+#define MAX5821_EXTENDED_COMMAND_MODE		0xf0
+#define MAX5821_READ_DAC_A_COMMAND		0xf1
+#define MAX5821_READ_DAC_B_COMMAND		0xf2
+
+#define MAX5821_EXTENDED_POWER_UP		0x00
+#define MAX5821_EXTENDED_POWER_DOWN_MODE0	0x01
+#define MAX5821_EXTENDED_POWER_DOWN_MODE1	0x02
+#define MAX5821_EXTENDED_POWER_DOWN_MODE2	0x03
+#define MAX5821_EXTENDED_DAC_A			0x04
+#define MAX5821_EXTENDED_DAC_B			0x08
+
+enum max5821_device_ids {
+	ID_MAX5821,
+};
+
+struct max5821_data {
+	struct i2c_client	*client;
+	unsigned short		vref_mv;
+	bool			powerdown[MAX5821_MAX_DAC_CHANNELS];
+	u8			powerdown_mode[MAX5821_MAX_DAC_CHANNELS];
+};
+
+static const char * const max5821_powerdown_modes[] = {
+	"three_state",
+	"1kohm_to_gnd",
+	"100kohm_to_gnd",
+};
+
+static int max5821_get_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan)
+{
+	struct max5821_data *st = iio_priv(indio_dev);
+
+	return st->powerdown_mode[chan->channel];
+}
+
+static int max5821_set_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      unsigned int mode)
+{
+	struct max5821_data *st = iio_priv(indio_dev);
+
+	st->powerdown_mode[chan->channel] = mode;
+
+	return 0;
+}
+
+static const struct iio_enum max5821_powerdown_mode_enum = {
+	.items = max5821_powerdown_modes,
+	.num_items = ARRAY_SIZE(max5821_powerdown_modes),
+	.get = max5821_get_powerdown_mode,
+	.set = max5821_set_powerdown_mode,
+};
+
+static ssize_t max5821_read_dac_powerdown(struct iio_dev *indio_dev,
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  char *buf)
+{
+	struct max5821_data *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->powerdown[chan->channel]);
+}
+
+static int max5821_sync_powerdown_mode(struct max5821_data *data,
+				       const struct iio_chan_spec *chan)
+{
+	u8 outbuf[2];
+
+	outbuf[0] = MAX5821_EXTENDED_COMMAND_MODE;
+
+	if (chan->channel == 0)
+		outbuf[1] = MAX5821_EXTENDED_DAC_A;
+	else
+		outbuf[1] = MAX5821_EXTENDED_DAC_B;
+
+	if (data->powerdown[chan->channel])
+		outbuf[1] |= data->powerdown_mode[chan->channel] + 1;
+	else
+		outbuf[1] |= MAX5821_EXTENDED_POWER_UP;
+
+	return i2c_master_send(data->client, outbuf, 2);
+}
+
+static ssize_t max5821_write_dac_powerdown(struct iio_dev *indio_dev,
+					   uintptr_t private,
+					   const struct iio_chan_spec *chan,
+					   const char *buf, size_t len)
+{
+	struct max5821_data *data = iio_priv(indio_dev);
+	bool powerdown;
+	int ret;
+
+	ret = strtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	data->powerdown[chan->channel] = powerdown;
+
+	ret = max5821_sync_powerdown_mode(data, chan);
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+static const struct iio_chan_spec_ext_info max5821_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = max5821_read_dac_powerdown,
+		.write = max5821_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &max5821_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", &max5821_powerdown_mode_enum),
+	{ },
+};
+
+#define MAX5821_CHANNEL(chan) {					\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.output = 1,						\
+	.channel = (chan),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
+	.ext_info = max5821_ext_info,				\
+}
+
+static const struct iio_chan_spec max5821_channels[] = {
+	MAX5821_CHANNEL(0),
+	MAX5821_CHANNEL(1)
+};
+
+static int max5821_get_value(struct iio_dev *indio_dev,
+			     int *val, int channel)
+{
+	struct max5821_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	u8 outbuf[1];
+	u8 inbuf[2];
+	int ret;
+
+	switch (channel) {
+	case 0:
+		outbuf[0] = MAX5821_READ_DAC_A_COMMAND;
+		break;
+	case 1:
+		outbuf[0] = MAX5821_READ_DAC_B_COMMAND;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = i2c_master_send(client, outbuf, 1);
+	if (ret < 0)
+		return ret;
+	else if (ret != 1)
+		return -EIO;
+
+	ret = i2c_master_recv(client, inbuf, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+
+	*val = ((inbuf[0] & 0x0f) << 6) | (inbuf[1] >> 2);
+
+	return IIO_VAL_INT;
+}
+
+static int max5821_set_value(struct iio_dev *indio_dev,
+			     int val, int channel)
+{
+	struct max5821_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	u8 outbuf[2];
+	int ret;
+
+	if ((val < 0) || (val > 1023))
+		return -EINVAL;
+
+	switch (channel) {
+	case 0:
+		outbuf[0] = MAX5821_LOAD_DAC_A_IN_REG_B;
+		break;
+	case 1:
+		outbuf[0] = MAX5821_LOAD_DAC_B_IN_REG_A;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	outbuf[0] |= val >> 6;
+	outbuf[1] = (val & 0x3f) << 2;
+
+	ret = i2c_master_send(client, outbuf, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+	else
+		return 0;
+}
+
+static int max5821_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct max5821_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = max5821_get_value(indio_dev, val, chan->channel);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = data->vref_mv;
+		*val2 = 10;
+		ret = IIO_VAL_FRACTIONAL_LOG2;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int max5821_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = max5821_set_value(indio_dev, val, chan->channel);
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
+static int max5821_suspend(struct device *dev)
+{
+	u8 outbuf[2];
+
+	outbuf[0] = MAX5821_EXTENDED_COMMAND_MODE;
+	outbuf[1] = MAX5821_EXTENDED_DAC_A | MAX5821_EXTENDED_DAC_B
+				| MAX5821_EXTENDED_POWER_DOWN_MODE2;
+
+	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
+}
+
+static int max5821_resume(struct device *dev)
+{
+	u8 outbuf[2];
+
+	outbuf[0] = MAX5821_EXTENDED_COMMAND_MODE;
+	outbuf[1] = MAX5821_EXTENDED_DAC_A | MAX5821_EXTENDED_DAC_B
+				| MAX5821_EXTENDED_POWER_UP;
+
+	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
+}
+
+static SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend, max5821_resume);
+#define MAX5821_PM_OPS (&max5821_pm_ops)
+#else
+#define MAX5821_PM_OPS NULL
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct iio_info max5821_info = {
+	.read_raw = max5821_read_raw,
+	.write_raw = max5821_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static int max5821_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct max5821_data *data;
+	struct iio_dev *indio_dev;
+	struct device_node *np = client->dev.of_node;
+	u32 tmp;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	/* max5821 start in powerdown mode 100Kohm to ground */
+	for (tmp = 0; tmp < MAX5821_MAX_DAC_CHANNELS; tmp++) {
+		data->powerdown[tmp] = 1;
+		data->powerdown_mode[tmp] = 2; /* index of "100kohm_to_gnd" */
+	}
+
+	if (of_property_read_u32(np, "vref_mv", &tmp) == 0)
+		data->vref_mv = tmp;
+	else
+		data->vref_mv = 3600;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->num_channels = 2;
+	indio_dev->channels = max5821_channels;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &max5821_info;
+
+	return iio_device_register(indio_dev);
+}
+
+static int max5821_remove(struct i2c_client *client)
+{
+	iio_device_unregister(i2c_get_clientdata(client));
+	return 0;
+}
+
+static const struct i2c_device_id max5821_id[] = {
+	{ "max5821", ID_MAX5821 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, max5821_id);
+
+static const struct of_device_id max5821_of_match[] = {
+	{ .compatible = "maxim,max5821" },
+	{ }
+};
+
+static struct i2c_driver max5821_driver = {
+	.driver = {
+		.name	= "max5821",
+		.pm     = MAX5821_PM_OPS,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= max5821_probe,
+	.remove		= max5821_remove,
+	.id_table	= max5821_id,
+};
+module_i2c_driver(max5821_driver);
+
+MODULE_AUTHOR("Philippe Reynes <tremyfr@yahoo.fr>");
+MODULE_DESCRIPTION("MAX5821 DAC");
+MODULE_LICENSE("GPL v2");
-- 
1.7.4.4
