Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	marex@denx.de,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 2/2] iio: temperature: add support for mcp98xx sensors
Date: Sat, 18 Jul 2015 20:04:13 -0700
Message-Id: <1437275053-16211-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1437275053-16211-1-git-send-email-mranostay@gmail.com>
References: <1437275053-16211-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add mcp98xx driver to allow temperature reading, and setting of
upper and lower alert thresholds.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/temperature/Kconfig   |  10 +
 drivers/iio/temperature/Makefile  |   1 +
 drivers/iio/temperature/mcp98xx.c | 588 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 599 insertions(+)
 create mode 100644 drivers/iio/temperature/mcp98xx.c

diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 21feaa4..1bab442 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -3,6 +3,16 @@
 #
 menu "Temperature sensors"
 
+config MCP98XX
+	tristate "MPC98xx temperature sensor"
+	depends on I2C
+	help
+	  If you say yes here you get support for the Microchip 98xx series
+	  of temperature sensors.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mcp98xx.
+
 config MLX90614
 	tristate "MLX90614 contact-less infrared sensor"
 	depends on I2C
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 40710a8..d67263d 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -2,5 +2,6 @@
 # Makefile for industrial I/O temperature drivers
 #
 
+obj-$(CONFIG_MCP98XX) += mcp98xx.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_TMP006) += tmp006.o
diff --git a/drivers/iio/temperature/mcp98xx.c b/drivers/iio/temperature/mcp98xx.c
new file mode 100644
index 0000000..2a98a26
--- /dev/null
+++ b/drivers/iio/temperature/mcp98xx.c
@@ -0,0 +1,588 @@
+/*
+ * mcp98xx.c - Support for Microchip MCP98xx series of temperature sensors
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
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/i2c.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
+
+#define MCP98XX_REG_CONFIG		0x01
+#define MCP98XX_REG_CONFIG_INT_EN	BIT(0)
+#define MCP98XX_REG_CONFIG_ALERT_EN	BIT(3)
+#define MCP98XX_REG_CONFIG_CLR_INT	BIT(5)
+#define MCP98XX_REG_CONFIG_SHDN		BIT(8)
+
+#define MCP98XX_REG_CONFIG_HYSTER_MASK		0x600
+#define MCP98XX_REG_CONFIG_HYSTER_MASK_SHIFT	9
+
+#define MCP98XX_REG_TUPPER	0x02
+#define MCP98XX_REG_TLOWER	0x03
+#define MCP98XX_REG_TCRIT	0x04
+
+#define MCP98XX_REG_TEMP	0x05
+#define MCP98XX_REG_TEMP_TSIGN	BIT(12)
+#define MCP98XX_REG_TEMP_TLOWER	BIT(13)
+#define MCP98XX_REG_TEMP_TUPPER	BIT(14)
+#define MCP98XX_REG_TEMP_MASK	0x1fff
+
+#define MCP98XX_REG_MANF_ID	0x06
+#define MCP98XX_REG_DEV_ID	0x07
+
+#define MCP98XX_REG_RESOLUTION		0x08
+#define MCP98XX_REG_RESOLUTION_MASK	0x03
+
+#define MCP98XX_MAX_INT_TIME_IN_US	300000
+
+#define MCP98XX_DRV_NAME	"mcp98xx"
+
+struct mcp98xx_data {
+	struct mutex lock;
+	struct regmap *regmap;
+	struct i2c_client *client;
+
+	/* config */
+	int low_thres_en;
+	int high_thres_en;
+
+	int it_time_in_us;
+	int hysteresis_idx;
+};
+
+static bool mcp98xx_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MCP98XX_REG_CONFIG:
+	case MCP98XX_REG_TEMP:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config mcp98xx_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.use_single_rw = 1,
+	.max_register = MCP98XX_REG_RESOLUTION,
+	.cache_type = REGCACHE_FLAT,
+	.volatile_reg = mcp98xx_is_volatile_reg,
+};
+
+static const int mcp98xx_it_time_map[] = { 30000, 65000, 130000, 250000 };
+
+static IIO_CONST_ATTR_INT_TIME_AVAIL("0.03 0.065 0.13 0.25");
+
+static const int mcp98xx_hysteresis_map[][2] = {
+	{0, 0}, {1, 500000}, {3, 0}, {6, 0}
+};
+
+static IIO_CONST_ATTR(hysteresis_scale_available, "0 1.5 3 6");
+
+static struct attribute *mcp98xx_attributes[] = {
+	&iio_const_attr_integration_time_available.dev_attr.attr,
+	&iio_const_attr_hysteresis_scale_available.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group mcp98xx_attribute_group = {
+	.attrs = mcp98xx_attributes,
+};
+
+static const struct iio_event_spec mcp98xx_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec mcp98xx_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.channel = 0,
+		.channel2 = IIO_MOD_TEMP_AMBIENT,
+		.address = MCP98XX_REG_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_INT_TIME) |
+				      BIT(IIO_CHAN_INFO_HYSTERESIS),
+		.modified = 1,
+		.scan_index = -1,
+
+		.event_spec = mcp98xx_event_spec,
+		.num_event_specs = ARRAY_SIZE(mcp98xx_event_spec),
+	}
+};
+
+static int mcp98xx_set_alert_state(struct mcp98xx_data *data, bool state)
+{
+	if (state) {
+		pm_runtime_get(&data->client->dev);
+	} else {
+		pm_runtime_put_autosuspend(&data->client->dev);
+
+		if (data->low_thres_en)
+			state = true;
+		if (data->high_thres_en)
+			state = true;
+	}
+
+	return regmap_update_bits(data->regmap, MCP98XX_REG_CONFIG,
+				  MCP98XX_REG_CONFIG_ALERT_EN,
+				  state ? MCP98XX_REG_CONFIG_ALERT_EN : 0);
+}
+
+static int mcp98xx_set_sleep(struct mcp98xx_data *data, bool state);
+
+static int mcp98xx_set_it_time(struct mcp98xx_data *data, int val2)
+{
+	int ret = -EINVAL;
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(mcp98xx_it_time_map); idx++) {
+		if (val2 == mcp98xx_it_time_map[idx]) {
+			mutex_lock(&data->lock);
+			ret = i2c_smbus_write_byte_data(data->client,
+							MCP98XX_REG_RESOLUTION,
+							idx);
+			if (!ret)
+				data->it_time_in_us = val2;
+			mutex_unlock(&data->lock);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int mcp98xx_set_hysteresis(struct mcp98xx_data *data, int val, int val2)
+{
+	int ret = -EINVAL;
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(mcp98xx_hysteresis_map); idx++) {
+		if (mcp98xx_hysteresis_map[idx][0] == val &&
+			mcp98xx_hysteresis_map[idx][1] == val2) {
+
+			mutex_lock(&data->lock);
+			ret = regmap_update_bits(data->regmap,
+				MCP98XX_REG_CONFIG,
+				MCP98XX_REG_CONFIG_HYSTER_MASK,
+				idx << MCP98XX_REG_CONFIG_HYSTER_MASK_SHIFT);
+
+			if (!ret)
+				data->hysteresis_idx = idx;
+			mutex_unlock(&data->lock);
+			break;
+		}
+	}
+	return ret;
+}
+
+#ifdef CONFIG_PM
+static int mcp98xx_power_get(struct mcp98xx_data *data)
+{
+	struct device *dev = &data->client->dev;
+	int suspended;
+	int ret;
+
+	mutex_lock(&data->lock);
+
+	suspended = pm_runtime_suspended(dev);
+	ret = pm_runtime_get_sync(dev);
+
+	/* Wait for a new sample to be ready */
+	if (suspended)
+		usleep_range(data->it_time_in_us, MCP98XX_MAX_INT_TIME_IN_US);
+
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int mcp98xx_set_sleep(struct mcp98xx_data *data, bool state)
+{
+	return regmap_update_bits(data->regmap, MCP98XX_REG_CONFIG,
+				  MCP98XX_REG_CONFIG_SHDN,
+				  state ? MCP98XX_REG_CONFIG_SHDN : 0);
+}
+#else
+static int mcp98xx_power_get(struct mcp98xx_data *data)
+{
+	return 0;
+}
+
+static int mcp98xx_set_sleep(struct mcp98xx_data *data, bool state)
+{
+	return 0;
+}
+#endif
+
+static int mcp98xx_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long mask)
+{
+	struct mcp98xx_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+	case IIO_CHAN_INFO_RAW: {
+		unsigned int reg;
+		int ret;
+
+		mcp98xx_power_get(data);
+		ret = regmap_read(data->regmap, MCP98XX_REG_TEMP, &reg);
+		pm_runtime_put_autosuspend(&data->client->dev);
+		if (ret)
+			return -EINVAL;
+		*val = sign_extend32(reg, 12) >> 4;
+		*val2 = (reg & 0xf) * 62500;
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		*val2 = data->it_time_in_us;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_HYSTERESIS:
+		mutex_lock(&data->lock);
+		*val = mcp98xx_hysteresis_map[data->hysteresis_idx][0];
+		*val2 = mcp98xx_hysteresis_map[data->hysteresis_idx][1];
+		mutex_unlock(&data->lock);
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp98xx_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct mcp98xx_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0)
+			return -EINVAL;
+		return mcp98xx_set_it_time(data, val2);
+	case IIO_CHAN_INFO_HYSTERESIS:
+		return mcp98xx_set_hysteresis(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp98xx_read_event(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir,
+			      enum iio_event_info info,
+			      int *val, int *val2)
+{
+	struct mcp98xx_data *data = iio_priv(indio_dev);
+	unsigned int reg;
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_read(data->regmap, MCP98XX_REG_TLOWER, &reg);
+		break;
+	case IIO_EV_DIR_RISING:
+		ret = regmap_read(data->regmap, MCP98XX_REG_TUPPER, &reg);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return -EINVAL;
+
+	*val = sign_extend32(reg & MCP98XX_REG_TEMP_MASK, 12) >> 4;
+	*val2 = ((reg & 0xf) >> 2) * 250000;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+};
+
+static int mcp98xx_write_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int val, int val2)
+{
+	struct mcp98xx_data *data = iio_priv(indio_dev);
+	u16 buf;
+
+	if (val < -40 || val > 125)
+		return -EINVAL;
+
+	if (val2 < 0 || val2 % 250000)
+		return -EINVAL;
+
+	buf = (val << 4 | (val2 / 250000) << 2) & 0x1ffc;
+
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		return regmap_write(data->regmap, MCP98XX_REG_TLOWER, buf);
+	case IIO_EV_DIR_RISING:
+		return regmap_write(data->regmap, MCP98XX_REG_TUPPER, buf);
+	default:
+		return -EINVAL;
+	}
+}
+
+
+static int mcp98xx_read_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	struct mcp98xx_data *data = iio_priv(indio_dev);
+
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		return data->low_thres_en;
+	case IIO_EV_DIR_RISING:
+		return data->high_thres_en;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp98xx_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      int state)
+{
+	struct mcp98xx_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	state = !!state;
+
+	switch (dir) {
+	case IIO_EV_DIR_FALLING:
+		if (data->low_thres_en == state)
+			return -EINVAL;
+		mutex_lock(&data->lock);
+		data->low_thres_en = state;
+
+		ret = mcp98xx_set_alert_state(data, state);
+		mutex_unlock(&data->lock);
+		break;
+	case IIO_EV_DIR_RISING:
+		if (data->high_thres_en == state)
+			return -EINVAL;
+		mutex_lock(&data->lock);
+		data->high_thres_en = state;
+
+		ret = mcp98xx_set_alert_state(data, state);
+		mutex_unlock(&data->lock);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct iio_info mcp98xx_info = {
+	.driver_module = THIS_MODULE,
+	.attrs = &mcp98xx_attribute_group,
+	.read_raw = &mcp98xx_read_raw,
+	.write_raw = &mcp98xx_write_raw,
+	.read_event_value = &mcp98xx_read_event,
+	.write_event_value = &mcp98xx_write_event,
+	.read_event_config = &mcp98xx_read_event_config,
+	.write_event_config = &mcp98xx_write_event_config,
+};
+
+static irqreturn_t mcp98xx_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct mcp98xx_data *data = iio_priv(indio_dev);
+	int ret, status;
+
+	ret = regmap_read(data->regmap, MCP98XX_REG_TEMP, &status);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "irq temp reg read failed\n");
+		return IRQ_HANDLED;
+	}
+
+	if ((status & MCP98XX_REG_TEMP_TLOWER) && data->low_thres_en) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       iio_get_time_ns());
+	}
+
+	if ((status & MCP98XX_REG_TEMP_TUPPER) && data->high_thres_en) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns());
+	}
+
+	regmap_update_bits(data->regmap, MCP98XX_REG_CONFIG,
+				MCP98XX_REG_CONFIG_CLR_INT, 0);
+
+	return IRQ_HANDLED;
+}
+
+static int mcp98xx_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct mcp98xx_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	indio_dev->info = &mcp98xx_info,
+	indio_dev->name = MCP98XX_DRV_NAME;
+	indio_dev->channels = mcp98xx_channels;
+	indio_dev->num_channels = 1;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	regmap = devm_regmap_init_i2c(client, &mcp98xx_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "regmap init failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+	mutex_init(&data->lock);
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+					&mcp98xx_interrupt_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					MCP98XX_DRV_NAME,
+					indio_dev);
+
+	if (ret) {
+		dev_err(&client->dev, "unable to request irq\n");
+		return ret;
+	}
+
+	/* Mask critical threshold interrupt by setting to MAX temp */
+	ret = regmap_write(regmap, MCP98XX_REG_TCRIT, 0xffc);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_set_active(&client->dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
+	pm_runtime_use_autosuspend(&client->dev);
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to register device\n");
+		return ret;
+	}
+
+	/* default to 250ms */
+	mcp98xx_set_it_time(data, 250000);
+
+	/* sleep till a data read or threshold event monitor is requested */
+	mcp98xx_set_sleep(data, true);
+
+	return 0;
+}
+
+static int mcp98xx_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	mcp98xx_set_sleep(iio_priv(indio_dev), true);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mcp98xx_runtime_suspend(struct device *dev)
+{
+	struct mcp98xx_data *data = iio_priv(i2c_get_clientdata(
+					     to_i2c_client(dev)));
+
+	return mcp98xx_set_sleep(data, true);
+}
+
+static int mcp98xx_runtime_resume(struct device *dev)
+{
+	struct mcp98xx_data *data = iio_priv(i2c_get_clientdata(
+					     to_i2c_client(dev)));
+
+	return mcp98xx_set_sleep(data, false);
+}
+#endif
+
+static const struct dev_pm_ops mcp98xx_pm_ops = {
+	SET_RUNTIME_PM_OPS(mcp98xx_runtime_suspend,
+			   mcp98xx_runtime_resume, NULL)
+};
+
+static const struct i2c_device_id mcp98xx_id[] = {
+	{"mcp98xx", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, mcp98xx_id);
+
+static struct i2c_driver mcp98xx_driver = {
+	.driver = {
+		.name	= "mcp98xx",
+		.pm	= &mcp98xx_pm_ops,
+		.owner	= THIS_MODULE,
+	},
+	.probe	= mcp98xx_probe,
+	.remove	= mcp98xx_remove,
+	.id_table = mcp98xx_id,
+};
+module_i2c_driver(mcp98xx_driver);
+
+MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_DESCRIPTION("Microchip MCP98xx temperature sensor");
+MODULE_LICENSE("GPL");
-- 
1.9.1
