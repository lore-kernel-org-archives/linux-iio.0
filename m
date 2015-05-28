Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net,
	knaack.h@gmx.de,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH v2] iio: light: Add support for ROHM RPR0521 sensor
Date: Thu, 28 May 2015 13:52:34 +0300
Message-Id: <1432810354-24745-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for ROHM RPR0521 ambient light and proximity
sensor. It offers raw readings for intensity and proximity.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
Changes since v1: (after Jonathan's review)
	* add static const to some structures
	* make some local functions static
	* added clarification for set_power_state function.

 drivers/iio/light/Kconfig   |  11 +
 drivers/iio/light/Makefile  |   1 +
 drivers/iio/light/rpr0521.c | 596 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 608 insertions(+)
 create mode 100644 drivers/iio/light/rpr0521.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index e6198b7..cbc4677 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -168,6 +168,17 @@ config JSA1212
 	 To compile this driver as a module, choose M here:
 	 the module will be called jsa1212.
 
+config RPR0521
+	tristate "ROHM RPR0521 ALS and proximity sensor driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	 Say Y here if you want to build support for ROHM's RPR0521
+	 ambient light and proximity sensor device.
+
+	 To compile this driver as a module, choose M here:
+	 the module will be called rpr0521.
+
 config SENSORS_LM3533
 	tristate "LM3533 ambient light sensor"
 	depends on MFD_LM3533
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index e2d50fd..66fc2fd 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
 obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
 obj-$(CONFIG_ISL29125)		+= isl29125.o
 obj-$(CONFIG_JSA1212)		+= jsa1212.o
+obj-$(CONFIG_RPR0521)		+= rpr0521.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
new file mode 100644
index 0000000..45d4df5
--- /dev/null
+++ b/drivers/iio/light/rpr0521.c
@@ -0,0 +1,596 @@
+/*
+ * RPR-0521 ROHM Ambient Light and Proximity Sensor
+ *
+ * Copyright (c) 2015, Intel Corporation.
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * IIO driver for RPR-0521RS (7-bit I2C slave address 0x38).
+ *
+ * TODO: illuminance channel, PM support, buffer
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include <linux/acpi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/pm_runtime.h>
+
+#define RPR0521_REG_SYSTEM_CTRL		0x40
+#define RPR0521_REG_MODE_CTRL		0x41
+#define RPR0521_REG_ALS_CTRL		0x42
+#define RPR0521_REG_PXS_CTRL		0x43
+#define RPR0521_REG_PXS_DATA		0x44 /* 16-bit, little endian */
+#define RPR0521_REG_ALS_DATA0		0x46 /* 16-bit, little endian */
+#define RPR0521_REG_ALS_DATA1		0x48 /* 16-bit, little endian */
+#define RPR0521_REG_ID			0x92
+
+#define RPR0521_MODE_ALS_MASK		BIT(7)
+#define RPR0521_MODE_PXS_MASK		BIT(6)
+#define RPR0521_MODE_MEAS_TIME_MASK	GENMASK(3, 0)
+#define RPR0521_ALS_DATA0_GAIN_MASK	(BIT(4) | BIT(5))
+#define RPR0521_ALS_DATA0_GAIN_SHIFT	4
+#define RPR0521_ALS_DATA1_GAIN_MASK	(BIT(2) | BIT(3))
+#define RPR0521_ALS_DATA1_GAIN_SHIFT	2
+#define RPR0521_PXS_GAIN_MASK		(BIT(4) | BIT(5))
+#define RPR0521_PXS_GAIN_SHIFT		4
+
+#define RPR0521_MODE_ALS_ENABLE		BIT(7)
+#define RPR0521_MODE_ALS_DISABLE	0x00
+#define RPR0521_MODE_PXS_ENABLE		BIT(6)
+#define RPR0521_MODE_PXS_DISABLE	0x00
+
+#define RPR0521_PXS_MAX_VAL		(BIT(13) - 1)
+#define RPR0521_MANUFACT_ID		0xE0
+#define RPR0521_DEFAULT_MEAS_TIME	0x06 /* ALS - 100ms, PXS - 100ms */
+
+#define RPR0521_DRV_NAME		"RPR0521"
+#define RPR0521_REGMAP_NAME		"rpr0521_regmap"
+
+#define RPR0521_SLEEP_DELAY_MS	2000
+
+static const int rpr0521_als_gain[4] = {1, 2, 64, 128};
+static const int rpr0521_pxs_gain[3] = {1, 2, 4};
+
+enum rpr0521_channel {
+	RPR0521_CHAN_ALS_DATA0,
+	RPR0521_CHAN_ALS_DATA1,
+	RPR0521_CHAN_PXS,
+};
+
+static const int rpr0521_data_reg[] = {
+	[RPR0521_CHAN_ALS_DATA0] = RPR0521_REG_ALS_DATA0,
+	[RPR0521_CHAN_ALS_DATA1] = RPR0521_REG_ALS_DATA1,
+	[RPR0521_CHAN_PXS] = RPR0521_REG_PXS_DATA,
+};
+
+static const struct rpr0521_gain_info {
+	u8 reg;
+	u8 mask;
+	u8 shift;
+	int *gain;
+	int size;
+} rpr0521_gain[] = {
+	[RPR0521_CHAN_ALS_DATA0] = {
+		.reg	= RPR0521_REG_ALS_CTRL,
+		.mask	= RPR0521_ALS_DATA0_GAIN_MASK,
+		.shift	= RPR0521_ALS_DATA0_GAIN_SHIFT,
+		.gain	= (int *)rpr0521_als_gain,
+		.size	= ARRAY_SIZE(rpr0521_als_gain),
+	},
+	[RPR0521_CHAN_ALS_DATA1] = {
+		.reg	= RPR0521_REG_ALS_CTRL,
+		.mask	= RPR0521_ALS_DATA1_GAIN_MASK,
+		.shift	= RPR0521_ALS_DATA1_GAIN_SHIFT,
+		.gain	= (int *)rpr0521_als_gain,
+		.size	= ARRAY_SIZE(rpr0521_als_gain),
+	},
+	[RPR0521_CHAN_PXS] = {
+		.reg	= RPR0521_REG_PXS_CTRL,
+		.mask	= RPR0521_PXS_GAIN_MASK,
+		.shift	= RPR0521_PXS_GAIN_SHIFT,
+		.gain	= (int *)rpr0521_pxs_gain,
+		.size	= ARRAY_SIZE(rpr0521_pxs_gain),
+	},
+};
+
+struct rpr0521_data {
+	struct i2c_client *client;
+
+	/* protect device params updates (e.g state, gain) */
+	struct mutex lock;
+
+	/* device active status */
+	bool als_dev_en;
+	bool pxs_dev_en;
+
+	/* optimize runtime pm ops - enable device only if needed */
+	bool als_ps_need_en;
+	bool pxs_ps_need_en;
+
+	struct regmap *regmap;
+};
+
+static const struct iio_chan_spec rpr0521_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.address = RPR0521_CHAN_ALS_DATA0,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_CALIBSCALE),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.address = RPR0521_CHAN_ALS_DATA1,
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_CALIBSCALE),
+	},
+	{
+		.type = IIO_PROXIMITY,
+		.address = RPR0521_CHAN_PXS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_CALIBSCALE),
+	}
+};
+
+static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
+				 RPR0521_MODE_ALS_MASK,
+				 status);
+	if (ret < 0)
+		return ret;
+
+	data->als_dev_en = true;
+
+	return 0;
+}
+
+static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
+				 RPR0521_MODE_PXS_MASK,
+				 status);
+	if (ret < 0)
+		return ret;
+
+	data->pxs_dev_en = true;
+
+	return 0;
+}
+
+/**
+ * rpr0521_set_power_state - handles runtime PM state and sensors enabled status
+ *
+ * @data: rpr0521 device private data
+ * @on: state to be set for devices in @device_mask
+ * @device_mask: bitmask specifying for which device we need to update @on state
+ *
+ * We rely on rpr0521_runtime_resume to enable our @device_mask devices, but
+ * if (for example) PXS was enabled (pxs_dev_en = true) by a previous call to
+ * rpr0521_runtime_resume and we want to enable ALS we MUST set ALS enable
+ * bit of RPR0521_REG_MODE_CTRL here because rpr0521_runtime_resume will not
+ * be called twice.
+ */
+static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
+				   u8 device_mask)
+{
+#ifdef CONFIG_PM
+	int ret;
+	u8 update_mask = 0;
+
+	if (device_mask & RPR0521_MODE_ALS_MASK) {
+		if (on && !data->als_ps_need_en && data->pxs_dev_en)
+			update_mask |= RPR0521_MODE_ALS_MASK;
+		else
+			data->als_ps_need_en = on;
+	}
+
+	if (device_mask & RPR0521_MODE_PXS_MASK) {
+		if (on && !data->pxs_ps_need_en && data->als_dev_en)
+			update_mask |= RPR0521_MODE_PXS_MASK;
+		else
+			data->pxs_ps_need_en = on;
+	}
+
+	if (update_mask) {
+		ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
+					 update_mask, update_mask);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (on) {
+		ret = pm_runtime_get_sync(&data->client->dev);
+	} else {
+		pm_runtime_mark_last_busy(&data->client->dev);
+		ret = pm_runtime_put_autosuspend(&data->client->dev);
+	}
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"Failed: rpr0521_set_power_state for %d, ret %d\n",
+			on, ret);
+		if (on)
+			pm_runtime_put_noidle(&data->client->dev);
+
+		return ret;
+	}
+#endif
+	return 0;
+}
+
+static int rpr0521_get_gain_index(int *gainv, int size, int gain)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		if (gain == gainv[i])
+			return i;
+
+	return -EINVAL;
+}
+
+static int rpr0521_get_gain(struct rpr0521_data *data, int chan, int *val)
+{
+	int ret, reg, idx;
+
+	ret = regmap_read(data->regmap, rpr0521_gain[chan].reg, &reg);
+	if (ret < 0)
+		return ret;
+
+	idx = (rpr0521_gain[chan].mask & reg) >> rpr0521_gain[chan].shift;
+	*val = rpr0521_gain[chan].gain[idx];
+
+	return 0;
+}
+
+static int rpr0521_set_gain(struct rpr0521_data *data, int chan, int val)
+{
+	int idx;
+
+	idx = rpr0521_get_gain_index(rpr0521_gain[chan].gain,
+				     rpr0521_gain[chan].size, val);
+	if (idx < 0)
+		return idx;
+
+	return regmap_update_bits(data->regmap, rpr0521_gain[chan].reg,
+				  rpr0521_gain[chan].mask,
+				  idx << rpr0521_gain[chan].shift);
+}
+
+static int rpr0521_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct rpr0521_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 device_mask;
+	__le16 raw_data;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_INTENSITY:
+			device_mask = RPR0521_MODE_ALS_MASK;
+			break;
+		case IIO_PROXIMITY:
+			device_mask = RPR0521_MODE_PXS_MASK;
+			break;
+		default:
+			return -EINVAL;
+		}
+		mutex_lock(&data->lock);
+		ret = rpr0521_set_power_state(data, true, device_mask);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+
+		ret = regmap_bulk_read(data->regmap,
+				       rpr0521_data_reg[chan->address],
+				       &raw_data, 2);
+		if (ret < 0) {
+			rpr0521_set_power_state(data, false, device_mask);
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+
+		ret = rpr0521_set_power_state(data, false, device_mask);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+
+		*val = le16_to_cpu(raw_data);
+		/*
+		 * proximity uses 12 bits, with bits 7:4 of PXS MSB DATA
+		 * being always zero. Also, proximity MUST be exposed as
+		 * a distance with lower values for closer objects.
+		 */
+		if (chan->type == IIO_PROXIMITY)
+			*val = RPR0521_PXS_MAX_VAL - *val;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		mutex_lock(&data->lock);
+		ret = rpr0521_get_gain(data, chan->address, val);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rpr0521_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct rpr0521_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		mutex_lock(&data->lock);
+		ret = rpr0521_set_gain(data, chan->address, val);
+		mutex_unlock(&data->lock);
+
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static IIO_CONST_ATTR(in_intensity_calibscale_available, "1 2 64 128");
+static IIO_CONST_ATTR(in_proximity_calibscale_available, "1 2 4");
+
+static struct attribute *rpr0521_attributes[] = {
+	&iio_const_attr_in_intensity_calibscale_available.dev_attr.attr,
+	&iio_const_attr_in_proximity_calibscale_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group rpr0521_attribute_group = {
+	.attrs = rpr0521_attributes,
+};
+
+static const struct iio_info rpr0521_info = {
+	.driver_module	= THIS_MODULE,
+	.read_raw	= rpr0521_read_raw,
+	.write_raw	= rpr0521_write_raw,
+	.attrs		= &rpr0521_attribute_group,
+};
+
+static int rpr0521_init(struct rpr0521_data *data)
+{
+	int ret;
+	int id;
+
+	ret = regmap_read(data->regmap, RPR0521_REG_ID, &id);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Failed to read REG_ID register\n");
+		return ret;
+	}
+
+	if (id != RPR0521_MANUFACT_ID) {
+		dev_err(&data->client->dev, "Wrong id, got %x expected %x\n",
+			id, RPR0521_MANUFACT_ID);
+		return -ENODEV;
+	}
+
+	/* set default measurement time - 100 ms for both ALS and PS */
+	ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
+				 RPR0521_MODE_MEAS_TIME_MASK,
+				 RPR0521_DEFAULT_MEAS_TIME);
+	if (ret) {
+		pr_err("regmap_update bits returned %d\n", ret);
+		return ret;
+	}
+
+	ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
+	if (ret < 0)
+		return ret;
+	ret = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rpr0521_poweroff(struct rpr0521_data *data)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
+				 RPR0521_MODE_ALS_MASK |
+				 RPR0521_MODE_PXS_MASK,
+				 0x00);
+	if (ret < 0)
+		return ret;
+
+	data->als_dev_en = false;
+	data->pxs_dev_en = false;
+
+	return 0;
+}
+
+static bool rpr0521_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RPR0521_REG_MODE_CTRL:
+	case RPR0521_REG_ALS_CTRL:
+	case RPR0521_REG_PXS_CTRL:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct regmap_config rpr0521_regmap_config = {
+	.name		= RPR0521_REGMAP_NAME,
+
+	.reg_bits	= 8,
+	.val_bits	= 8,
+
+	.max_register	= RPR0521_REG_ID,
+	.cache_type	= REGCACHE_RBTREE,
+	.volatile_reg	= rpr0521_is_volatile_reg,
+};
+
+static int rpr0521_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct rpr0521_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &rpr0521_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Regmap init failed!\n");
+		return PTR_ERR(regmap);
+	}
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+
+	mutex_init(&data->lock);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &rpr0521_info;
+	indio_dev->name = RPR0521_DRV_NAME;
+	indio_dev->channels = rpr0521_channels;
+	indio_dev->num_channels = ARRAY_SIZE(rpr0521_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = rpr0521_init(data);
+	if (ret < 0) {
+		dev_err(&client->dev, "rpr0521 chip init failed\n");
+		return ret;
+	}
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = pm_runtime_set_active(&client->dev);
+	if (ret < 0)
+		goto err_iio_unregister;
+
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev, RPR0521_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(&client->dev);
+
+	return 0;
+err_iio_unregister:
+	iio_device_unregister(indio_dev);
+	return ret;
+}
+
+static int rpr0521_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+
+	iio_device_unregister(indio_dev);
+	rpr0521_poweroff(iio_priv(indio_dev));
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int rpr0521_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct rpr0521_data *data = iio_priv(indio_dev);
+	int ret;
+
+	/* disable channels and sets {als,pxs}_dev_en to false */
+	mutex_lock(&data->lock);
+	ret = rpr0521_poweroff(data);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int rpr0521_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct rpr0521_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (data->als_ps_need_en) {
+		ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
+		if (ret < 0)
+			return ret;
+		data->als_ps_need_en = false;
+	}
+
+	if (data->pxs_ps_need_en) {
+		ret = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
+		if (ret < 0)
+			return ret;
+		data->pxs_ps_need_en = false;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops rpr0521_pm_ops = {
+	SET_RUNTIME_PM_OPS(rpr0521_runtime_suspend,
+			   rpr0521_runtime_resume, NULL)
+};
+
+static const struct acpi_device_id rpr0521_acpi_match[] = {
+	{"RPR0521", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rpr0521_acpi_match);
+
+static const struct i2c_device_id rpr0521_id[] = {
+	{"rpr0521", 0},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, rpr0521_id);
+
+static struct i2c_driver rpr0521_driver = {
+	.driver = {
+		.name	= RPR0521_DRV_NAME,
+		.pm	= &rpr0521_pm_ops,
+		.acpi_match_table = ACPI_PTR(rpr0521_acpi_match),
+	},
+	.probe		= rpr0521_probe,
+	.remove		= rpr0521_remove,
+	.id_table	= rpr0521_id,
+};
+
+module_i2c_driver(rpr0521_driver);
+
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
+MODULE_DESCRIPTION("RPR0521 ROHM Ambient Light and Proximity Sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
