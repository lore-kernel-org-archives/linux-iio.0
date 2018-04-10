Return-Path: <SRS0=k1Fe=G7=prevas.dk=Sean.Nyekjaer@kernel.org>
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: jic23@kernel.org,
	robh+dt@kernel.org
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mark.rutland@arm.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [RFC PATCH v2 1/2] iio: dac: add TI DAC5755 family support
Date: Tue, 10 Apr 2018 10:44:52 +0200
Message-Id: <20180410084453.6189-1-sean.nyekjaer@prevas.dk>
In-Reply-To: <20180322102336.32268-1-sean.nyekjaer@prevas.dk>
References: <20180322102336.32268-1-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for the Texas Intruments DAC5755 Family.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---

Still not have hardware :-( Ready next week I hope. So still RFC.

v2:
Addressed comments from Jonathan and Peter
- improved readability
- i2c return check fixed
- added structure pointer instead of copying elements
- splitted single and quad operations with function pointers

 drivers/iio/dac/Kconfig      |  10 +
 drivers/iio/dac/Makefile     |   1 +
 drivers/iio/dac/ti-dac5571.c | 430 +++++++++++++++++++++++++++++++++++
 3 files changed, 441 insertions(+)
 create mode 100644 drivers/iio/dac/ti-dac5571.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 965d5c0d2468..b64fabbc74f8 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -320,6 +320,16 @@ config TI_DAC082S085
 
 	  If compiled as a module, it will be called ti-dac082s085.
 
+config TI_DAC5571
+	tristate "Texas Instruments 8/10/12/16-bit 1/2/4-channel DAC driver"
+	depends on I2C
+	help
+	  Driver for the Texas Instruments
+	  DAC5571, DAC6571, DAC7571, DAC5574, DAC6574, DAC7574, DAC5573,
+	  DAC6573, DAC7573, DAC8571, DAC8574.
+
+	  If compiled as a module, it will be called ti-dac5571.
+
 config VF610_DAC
 	tristate "Vybrid vf610 DAC driver"
 	depends on OF
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 81e710ed7491..1ab358d522ee 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -35,4 +35,5 @@ obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
 obj-$(CONFIG_STM32_DAC) += stm32-dac.o
 obj-$(CONFIG_TI_DAC082S085) += ti-dac082s085.o
+obj-$(CONFIG_TI_DAC5571) += ti-dac5571.o
 obj-$(CONFIG_VF610_DAC) += vf610_dac.o
diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
new file mode 100644
index 000000000000..0ee5ca1ce6eb
--- /dev/null
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -0,0 +1,430 @@
+/*
+ * ti-dac5571.c - Texas Instruments 8/10/12-bit 1/4-channel DAC driver
+ *
+ * Copyright (C) 2018 Prevas A/S
+ *
+ * http://www.ti.com/lit/ds/symlink/dac5571.pdf
+ * http://www.ti.com/lit/ds/symlink/dac6571.pdf
+ * http://www.ti.com/lit/ds/symlink/dac7571.pdf
+ * http://www.ti.com/lit/ds/symlink/dac5574.pdf
+ * http://www.ti.com/lit/ds/symlink/dac6574.pdf
+ * http://www.ti.com/lit/ds/symlink/dac7574.pdf
+ * http://www.ti.com/lit/ds/symlink/dac5573.pdf
+ * http://www.ti.com/lit/ds/symlink/dac6573.pdf
+ * http://www.ti.com/lit/ds/symlink/dac7573.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2) as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+enum chip_id {
+	single_8bit, single_10bit, single_12bit,
+	quad_8bit, quad_10bit, quad_12bit
+};
+
+#define DAC5571_SINGLE_CHANNEL		1
+#define DAC5571_QUAD_CHANNEL		4
+
+struct dac5571_spec {
+	u8 num_channels;
+	u8 resolution;
+};
+
+static const struct dac5571_spec dac5571_spec[] = {
+	[single_8bit]  = {.num_channels = 1, .resolution =  8},
+	[single_10bit] = {.num_channels = 1, .resolution = 10},
+	[single_12bit] = {.num_channels = 1, .resolution = 12},
+	[quad_8bit]    = {.num_channels = 4, .resolution =  8},
+	[quad_10bit]   = {.num_channels = 4, .resolution = 10},
+	[quad_12bit]   = {.num_channels = 4, .resolution = 12},
+};
+
+struct dac5571_data {
+	struct i2c_client *client;
+	int id;
+	struct mutex lock;
+	struct regulator *vref;
+	u16 val[4];
+	bool powerdown;
+	u8 powerdown_mode;
+	struct dac5571_spec const *spec;
+	int (*dac5571_cmd) (struct dac5571_data *, int, u16);
+	int (*dac5571_pwrdwn) (struct dac5571_data *, int, u8);
+	u8 buf[3] ____cacheline_aligned;
+};
+
+#define DAC5571_POWERDOWN(mode)		((mode) + 1)
+#define DAC5571_POWERDOWN_FLAG		BIT(0)
+#define DAC5571_CHANNEL_SELECT		BIT(1)
+#define DAC5571_LOADMODE_DIRECT		BIT(4)
+#define DAC5571_SINGLE_PWRDWN_BITS	4
+#define DAC5571_QUAD_PWRDWN_BITS	6
+
+static int dac5571_cmd_single(struct dac5571_data *data, int channel, u16 val)
+{
+	unsigned int shift;
+
+	shift = 12 - data->spec->resolution;
+	data->buf[0] = val << shift;
+	data->buf[1] = val >> (8 - shift);
+	return i2c_master_send(data->client, data->buf, 2);
+}
+
+
+static int dac5571_cmd_quad(struct dac5571_data *data, int channel, u16 val)
+{
+	unsigned int shift;
+
+	shift = 16 - data->spec->resolution;
+	data->buf[0] = val << shift;
+	data->buf[1] = (val >> (8 - shift));
+	data->buf[2] = (channel << DAC5571_CHANNEL_SELECT) |
+		       DAC5571_LOADMODE_DIRECT;
+	return i2c_master_send(data->client, data->buf, 3);
+}
+
+static int dac5571_pwrdwn_single(struct dac5571_data *data, int channel, u8 pwrdwn)
+{
+	unsigned int shift;
+
+	shift = 12 - data->spec->resolution;
+	data->buf[0] = 0;
+	data->buf[1] = pwrdwn << DAC5571_SINGLE_PWRDWN_BITS;
+	return i2c_master_send(data->client, data->buf, 2);
+}
+
+static int dac5571_pwrdwn_quad(struct dac5571_data *data, int channel, u8 pwrdwn)
+{
+	unsigned int shift;
+
+	shift = 16 - data->spec->resolution;
+	data->buf[0] = 0;
+	data->buf[1] = pwrdwn << DAC5571_QUAD_PWRDWN_BITS;
+	data->buf[2] = (channel << DAC5571_CHANNEL_SELECT) |
+		       DAC5571_LOADMODE_DIRECT | DAC5571_POWERDOWN_FLAG;
+	return i2c_master_send(data->client, data->buf, 3);
+}
+
+static const char *const dac5571_powerdown_modes[] = {
+	"1kohm_to_gnd", "100kohm_to_gnd", "three_state",
+};
+
+static int dac5571_get_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan)
+{
+	struct dac5571_data *data = iio_priv(indio_dev);
+
+	return data->powerdown_mode;
+}
+
+static int dac5571_set_powerdown_mode(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      unsigned int mode)
+{
+	struct dac5571_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (data->powerdown_mode == mode)
+		return 0;
+
+	mutex_lock(&data->lock);
+	if (data->powerdown) {
+		ret = data->dac5571_pwrdwn(data, chan->channel,
+					   DAC5571_POWERDOWN(mode));
+		if (ret <= 0)
+			goto out;
+	}
+	data->powerdown_mode = mode;
+
+ out:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static const struct iio_enum dac5571_powerdown_mode = {
+	.items = dac5571_powerdown_modes,
+	.num_items = ARRAY_SIZE(dac5571_powerdown_modes),
+	.get = dac5571_get_powerdown_mode,
+	.set = dac5571_set_powerdown_mode,
+};
+
+static ssize_t dac5571_read_powerdown(struct iio_dev *indio_dev,
+				      uintptr_t private,
+				      const struct iio_chan_spec *chan,
+				      char *buf)
+{
+	struct dac5571_data *data = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", data->powerdown);
+}
+
+static ssize_t dac5571_write_powerdown(struct iio_dev *indio_dev,
+				       uintptr_t private,
+				       const struct iio_chan_spec *chan,
+				       const char *buf, size_t len)
+{
+	struct dac5571_data *data = iio_priv(indio_dev);
+	bool powerdown;
+	int ret;
+
+	ret = strtobool(buf, &powerdown);
+	if (ret)
+		return ret;
+
+	if (data->powerdown == powerdown)
+		return len;
+
+	mutex_lock(&data->lock);
+	if (powerdown)
+		ret = data->dac5571_pwrdwn(data, chan->channel,
+					   DAC5571_POWERDOWN(data->powerdown_mode));
+	else
+		ret = data->dac5571_cmd(data, chan->channel, data->val[0]);
+	if (ret <= 0)
+		data->powerdown = powerdown;
+	mutex_unlock(&data->lock);
+
+	return ret ? ret : len;
+}
+
+
+static const struct iio_chan_spec_ext_info dac5571_ext_info[] = {
+	{
+		.name	   = "powerdown",
+		.read	   = dac5571_read_powerdown,
+		.write	   = dac5571_write_powerdown,
+		.shared	   = IIO_SHARED_BY_TYPE,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SHARED_BY_TYPE, &dac5571_powerdown_mode),
+	IIO_ENUM_AVAILABLE("powerdown_mode", &dac5571_powerdown_mode),
+	{},
+};
+
+#define dac5571_CHANNEL(chan, name) {				\
+	.type = IIO_VOLTAGE,					\
+	.channel = (chan),					\
+	.address = (chan),					\
+	.indexed = true,					\
+	.output = true,						\
+	.datasheet_name = name,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.ext_info = dac5571_ext_info,				\
+}
+
+static const struct iio_chan_spec dac5571_channels[] = {
+	dac5571_CHANNEL(0, "A"),
+	dac5571_CHANNEL(1, "B"),
+	dac5571_CHANNEL(2, "C"),
+	dac5571_CHANNEL(3, "D"),
+};
+
+static int dac5571_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct dac5571_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = data->val[chan->channel];
+		return IIO_VAL_INT;
+		break;
+
+	case IIO_CHAN_INFO_SCALE:
+		ret = regulator_get_voltage(data->vref);
+		if (ret < 0)
+			return ret;
+
+		*val = ret / 1000;
+		*val2 = data->spec->resolution;
+		return IIO_VAL_FRACTIONAL_LOG2;
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int dac5571_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct dac5571_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (data->val[chan->channel] == val)
+			return 0;
+
+		if (val >= (1 << data->spec->resolution) || val < 0)
+			return -EINVAL;
+
+		if (data->powerdown)
+			return -EBUSY;
+
+		mutex_lock(&data->lock);
+		ret = data->dac5571_cmd(data, chan->channel, val);
+		if (ret <= 0)
+			data->val[chan->channel] = val;
+		mutex_unlock(&data->lock);
+		return ret;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int dac5571_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info dac5571_info = {
+	.read_raw = dac5571_read_raw,
+	.write_raw = dac5571_write_raw,
+	.write_raw_get_fmt = dac5571_write_raw_get_fmt,
+};
+
+static int dac5571_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	const struct dac5571_spec *spec;
+	struct dac5571_data *data;
+	struct iio_dev *indio_dev;
+	int ret, i;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	indio_dev->dev.parent = dev;
+	indio_dev->dev.of_node = client->dev.of_node;
+	indio_dev->info = &dac5571_info;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = dac5571_channels;
+
+	spec = &dac5571_spec[id->driver_data];
+	indio_dev->num_channels = spec->num_channels;
+	data->spec = spec;
+
+	data->vref = devm_regulator_get(dev, "vref");
+	if (IS_ERR(data->vref))
+		return PTR_ERR(data->vref);
+
+	ret = regulator_enable(data->vref);
+	if (ret < 0)
+		return ret;
+
+	mutex_init(&data->lock);
+
+	switch (spec->num_channels) {
+	case DAC5571_SINGLE_CHANNEL:
+		data->dac5571_cmd = dac5571_cmd_single;
+		data->dac5571_pwrdwn = dac5571_pwrdwn_single;
+		break;
+	case DAC5571_QUAD_CHANNEL:
+		data->dac5571_cmd = dac5571_cmd_quad;
+		data->dac5571_pwrdwn = dac5571_pwrdwn_quad;
+		break;
+	default:
+		goto err;
+		break;
+	}
+
+	for (i = 0; i < spec->num_channels; i++) {
+		ret = data->dac5571_cmd(data, i, 0);
+		if (ret <= 0) {
+			dev_err(dev, "failed to initialize channel %d to 0\n", i);
+			goto err;
+		}
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto err;
+
+	return 0;
+
+ err:
+	regulator_disable(data->vref);
+	return ret;
+}
+
+static int dac5571_remove(struct i2c_client *i2c)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(i2c);
+	struct dac5571_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	regulator_disable(data->vref);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id dac5571_of_id[] = {
+	{.compatible = "ti,dac5571"},
+	{.compatible = "ti,dac6571"},
+	{.compatible = "ti,dac7571"},
+	{.compatible = "ti,dac5574"},
+	{.compatible = "ti,dac6574"},
+	{.compatible = "ti,dac7574"},
+	{.compatible = "ti,dac5573"},
+	{.compatible = "ti,dac6573"},
+	{.compatible = "ti,dac7573"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, dac5571_of_id);
+#endif
+
+static const struct i2c_device_id dac5571_id[] = {
+	{"dac5571", single_8bit},
+	{"dac6571", single_10bit},
+	{"dac7571", single_12bit},
+	{"dac5574", quad_8bit},
+	{"dac6574", quad_10bit},
+	{"dac7574", quad_12bit},
+	{"dac5573", quad_8bit},
+	{"dac6573", quad_10bit},
+	{"dac7573", quad_12bit},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, dac5571_id);
+
+static struct i2c_driver dac5571_driver = {
+	.driver = {
+		   .name = "ti-dac5571",
+	},
+	.probe	  = dac5571_probe,
+	.remove   = dac5571_remove,
+	.id_table = dac5571_id,
+};
+module_i2c_driver(dac5571_driver);
+
+MODULE_AUTHOR("Sean Nyekjaer <sean.nyekjaer@prevas.dk>");
+MODULE_DESCRIPTION("Texas Instruments 8/10/12-bit 1/4-channel DAC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0
