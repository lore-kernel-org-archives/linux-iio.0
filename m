Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <1430832038-21653-1-git-send-email-tiberiu.a.breana@intel.com>
References: <1430832038-21653-1-git-send-email-tiberiu.a.breana@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: accel: Add support for Sensortek STK8312
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 05 May 2015 14:43:32 +0100
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3C33160C-AC5A-4EAB-925A-FDD14D36F12C@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 5 May 2015 14:20:38 GMT+01:00, Tiberiu Breana <tiberiu.a.breana@intel.com> wrote:
>Minimal implementation of an IIO driver for the Sensortek
>STK8312 3-axis accelerometer.
>Datasheet:
>http://www.syi-group.com/uploadpic/data/201361817562681623.pdf
>
>Includes:
>- ACPI support;
>- read_raw for x,y,z axes;
>- reading and setting the scale (range) parameter.
>- power management
>
>Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>

Looks good. Will take another look when not stuck with only my phone (and a case of broken circuit boards) whilst my laptop is in the hold of the plane...
>---
> drivers/iio/accel/Kconfig   |  11 ++
> drivers/iio/accel/Makefile  |   2 +
>drivers/iio/accel/stk8312.c | 375
>++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 388 insertions(+)
> create mode 100644 drivers/iio/accel/stk8312.c
>
>diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
>index 7c9a9a9..8bd8ccb 100644
>--- a/drivers/iio/accel/Kconfig
>+++ b/drivers/iio/accel/Kconfig
>@@ -136,4 +136,15 @@ config MMA9553
> 
> 	  To compile this driver as a module, choose M here: the module
> 	  will be called mma9553.
>+
>+config STK8312
>+	tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
>+	depends on I2C
>+	help
>+	  Say yes here to get support for the Sensortek STK8312 3-axis
>+	  accelerometer.
>+
>+	  Choosing M will build the driver as a module. If so, the module
>+	  will be called stk8312.
>+
> endmenu
>diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
>index 99d89e4..8b327c1 100644
>--- a/drivers/iio/accel/Makefile
>+++ b/drivers/iio/accel/Makefile
>@@ -14,6 +14,8 @@ obj-$(CONFIG_MMA9551_CORE)	+= mma9551_core.o
> obj-$(CONFIG_MMA9551)		+= mma9551.o
> obj-$(CONFIG_MMA9553)		+= mma9553.o
> 
>+obj-$(CONFIG_STK8312)		+= stk8312.o
>+
> obj-$(CONFIG_IIO_SSP_SENSORS_COMMONS) += ssp_accel_sensor.o
> 
> obj-$(CONFIG_IIO_ST_ACCEL_3AXIS) += st_accel.o
>diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
>new file mode 100644
>index 0000000..ff27e6b
>--- /dev/null
>+++ b/drivers/iio/accel/stk8312.c
>@@ -0,0 +1,375 @@
>+/**
>+ * Sensortek STK8312 3-Axis Accelerometer
>+ *
>+ * Copyright (c) 2015, Intel Corporation.
>+ *
>+ * This file is subject to the terms and conditions of version 2 of
>+ * the GNU General Public License. See the file COPYING in the main
>+ * directory of this archive for more details.
>+ *
>+ * IIO driver for STK8312; 7-bit I2C address: 0x3D.
>+ */
>+
>+#include <linux/acpi.h>
>+#include <linux/i2c.h>
>+#include <linux/kernel.h>
>+#include <linux/module.h>
>+#include <linux/delay.h>
>+#include <linux/iio/iio.h>
>+#include <linux/iio/sysfs.h>
>+
>+#define STK8312_REG_XOUT		0x00
>+#define STK8312_REG_YOUT		0x01
>+#define STK8312_REG_ZOUT		0x02
>+#define STK8312_REG_MODE		0x07
>+#define STK8312_REG_STH			0x13
>+#define STK8312_REG_RESET		0x20
>+
>+#define STK8312_MODE_ACTIVE		1
>+#define STK8312_MODE_STANDBY		0
>+#define STK8312_MODE_MASK		0x01
>+#define STK8312_RNG_MASK		0xC0
>+#define STK8312_ALERT_MASK		0x40
>+#define STK8312_DATA6_MASK		0x3F
>+#define STK8312_RNG_SHIFT		6
>+#define STK8312_READ_RETRIES		16
>+
>+#define STK8312_DRIVER_NAME		"stk8312"
>+
>+#define STK8312_SCALE_AVAIL		"0.4747 0.4632 1.2354"
>+
>+static const int stk8312_scale_table[][2] = {
>+	{0, 474700}, {0, 463200}, {1, 235400}
>+};
>+
>+#define STK8312_ACCEL_CHANNEL(axis) {				\
>+	.type = IIO_ACCEL,					\
>+	.modified = 1,						\
>+	.channel2 = IIO_MOD_##axis,				\
>+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
>+}
>+
>+static const struct iio_chan_spec stk8312_channels[] = {
>+	STK8312_ACCEL_CHANNEL(X),
>+	STK8312_ACCEL_CHANNEL(Y),
>+	STK8312_ACCEL_CHANNEL(Z),
>+};
>+
>+struct stk8312_data {
>+	struct i2c_client *client;
>+	struct mutex lock;
>+	int range;
>+	u8 mode;
>+};
>+
>+static IIO_CONST_ATTR(in_accel_scale_available, STK8312_SCALE_AVAIL);
>+
>+static struct attribute *stk8312_attributes[] = {
>+	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
>+	NULL,
>+};
>+
>+static const struct attribute_group stk8312_attribute_group = {
>+	.attrs = stk8312_attributes
>+};
>+
>+static int stk8312_set_mode(struct stk8312_data *data, u8 mode)
>+{
>+	int ret;
>+	u8 masked_reg;
>+	struct i2c_client *client = data->client;
>+
>+	if (mode > 1)
>+		return -EINVAL;
>+	else if (mode == data->mode)
>+		return 0;
>+
>+	ret = i2c_smbus_read_byte_data(client, STK8312_REG_MODE);
>+	if (ret < 0) {
>+		dev_err(&client->dev, "register read failed\n");
>+		return ret;
>+	}
>+	masked_reg = ret & (~STK8312_MODE_MASK);
>+	masked_reg |= mode;
>+
>+	ret = i2c_smbus_write_byte_data(client, STK8312_REG_MODE,
>+					masked_reg);
>+	if (ret < 0)
>+		dev_err(&client->dev, "failed to change sensor mode\n");
>+	else
>+		data->mode = mode;
>+
>+	return ret;
>+}
>+
>+static int stk8312_set_range(struct stk8312_data *data, u8 range)
>+{
>+	int ret;
>+	int masked_reg;
>+	u8 mode;
>+	struct i2c_client *client = data->client;
>+
>+	if (range < 0 || range > 2)
>+		return -EINVAL;
>+
>+	if (range == data->range)
>+		return 0;
>+
>+	mode = data->mode;
>+	/* We need to go in standby mode to modify registers */
>+	ret = stk8312_set_mode(data, STK8312_MODE_STANDBY);
>+	if (ret < 0)
>+		return ret;
>+
>+	ret = i2c_smbus_read_byte_data(client, STK8312_REG_STH);
>+	if (ret < 0) {
>+		dev_err(&client->dev, "register read failed\n");
>+		return ret;
>+	}
>+
>+	masked_reg = ret & (~STK8312_RNG_MASK);
>+	masked_reg |= range << STK8312_RNG_SHIFT;
>+
>+	ret = i2c_smbus_write_byte_data(client, STK8312_REG_STH, masked_reg);
>+	if (ret < 0)
>+		dev_err(&client->dev, "failed to change sensor range\n");
>+	else
>+		data->range = range;
>+
>+	return stk8312_set_mode(data, mode);
>+}
>+
>+static int stk8312_read_accel(struct stk8312_data *data, int axis)
>+{
>+	int ret;
>+	u8 reg;
>+	int retries = STK8312_READ_RETRIES;
>+	struct i2c_client *client = data->client;
>+
>+	switch (axis) {
>+	case IIO_MOD_X:
>+		reg = STK8312_REG_XOUT;
>+		break;
>+	case IIO_MOD_Y:
>+		reg = STK8312_REG_YOUT;
>+		break;
>+	case IIO_MOD_Z:
>+		reg = STK8312_REG_ZOUT;
>+		break;
>+	default:
>+		return -EINVAL;
>+	}
>+
>+	ret = i2c_smbus_read_byte_data(client, reg);
>+	if (ret < 0) {
>+		dev_err(&client->dev, "register read failed\n");
>+		return ret;
>+	}
>+	if (data->range == 0) {
>+		/* 6bit mode */
>+		while (retries--) {
>+			if (ret & STK8312_ALERT_MASK) {
>+				/* The register is being updated. Try again. */
>+				msleep(20);
>+				ret = i2c_smbus_read_byte_data(client, reg);
>+				if (ret < 0) {
>+					dev_err(&data->client->dev,
>+						"register read failed\n");
>+					return ret;
>+				}
>+			} else {
>+				ret &= STK8312_DATA6_MASK;
>+				return sign_extend32(ret, 5);
>+			}
>+		}
>+		dev_err(&data->client->dev,
>+				"register read failed, data not ready\n");
>+		return -EIO;
>+	}
>+	/* 8bit mode */
>+	return sign_extend32(ret, 7);
>+}
>+
>+static int stk8312_read_raw(struct iio_dev *indio_dev,
>+			    struct iio_chan_spec const *chan,
>+			    int *val, int *val2, long mask)
>+{
>+	struct stk8312_data *data = iio_priv(indio_dev);
>+
>+	if (chan->type != IIO_ACCEL)
>+		return -EINVAL;
>+
>+	switch (mask) {
>+	case IIO_CHAN_INFO_RAW:
>+		mutex_lock(&data->lock);
>+		*val = stk8312_read_accel(data, chan->channel2);
>+		mutex_unlock(&data->lock);
>+		return IIO_VAL_INT;
>+	case IIO_CHAN_INFO_SCALE:
>+		*val = stk8312_scale_table[data->range][0];
>+		*val2 = stk8312_scale_table[data->range][1];
>+		return IIO_VAL_INT_PLUS_MICRO;
>+	}
>+
>+	return -EINVAL;
>+}
>+
>+static int stk8312_write_raw(struct iio_dev *indio_dev,
>+			     struct iio_chan_spec const *chan,
>+			     int val, int val2, long mask)
>+{
>+	int i;
>+	int index = -1;
>+	int ret;
>+	struct stk8312_data *data = iio_priv(indio_dev);
>+
>+	switch (mask) {
>+	case IIO_CHAN_INFO_SCALE:
>+		for (i = 0; i < ARRAY_SIZE(stk8312_scale_table); i++)
>+			if (val == stk8312_scale_table[i][0] &&
>+			    val2 == stk8312_scale_table[i][1]) {
>+				index = i;
>+				break;
>+			}
>+		if (index < 0)
>+			return -EINVAL;
>+
>+		mutex_lock(&data->lock);
>+		ret = stk8312_set_range(data, index);
>+		mutex_unlock(&data->lock);
>+
>+		return ret;
>+	}
>+
>+	return -EINVAL;
>+}
>+
>+static const struct iio_info stk8312_info = {
>+	.driver_module		= THIS_MODULE,
>+	.read_raw		= stk8312_read_raw,
>+	.write_raw		= stk8312_write_raw,
>+	.attrs			= &stk8312_attribute_group,
>+};
>+
>+static int stk8312_init(struct iio_dev *indio_dev)
>+{
>+	int ret;
>+	struct stk8312_data *data = iio_priv(indio_dev);
>+	struct i2c_client *client = data->client;
>+
>+	/* A software reset is recommended at power-on */
>+	ret = i2c_smbus_write_byte_data(data->client, STK8312_REG_RESET,
>0x00);
>+	if (ret < 0)
>+		dev_err(&client->dev, "failed to reset sensor");
>+
>+	ret = stk8312_set_mode(data, STK8312_MODE_ACTIVE);
>+	if (ret < 0)
>+		dev_err(&client->dev, "failed to enable sensor");
>+
>+	return ret;
>+}
>+
>+static int stk8312_probe(struct i2c_client *client,
>+			 const struct i2c_device_id *id)
>+{
>+	int ret;
>+	struct iio_dev *indio_dev;
>+	struct stk8312_data *data;
>+
>+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>+	if (!indio_dev) {
>+		dev_err(&client->dev, "iio allocation failed!\n");
>+		return -ENOMEM;
>+	}
>+
>+	data = iio_priv(indio_dev);
>+	data->client = client;
>+	i2c_set_clientdata(client, indio_dev);
>+	mutex_init(&data->lock);
>+
>+	indio_dev->dev.parent = &client->dev;
>+	indio_dev->info = &stk8312_info;
>+	indio_dev->name = STK8312_DRIVER_NAME;
>+	indio_dev->modes = INDIO_DIRECT_MODE;
>+	indio_dev->channels = stk8312_channels;
>+	indio_dev->num_channels = ARRAY_SIZE(stk8312_channels);
>+
>+	ret = stk8312_init(indio_dev);
>+	if (ret < 0) {
>+		dev_err(&client->dev, "sensor initialization failed\n");
>+		return ret;
>+	}
>+
>+	ret = iio_device_register(indio_dev);
>+	if (ret < 0) {
>+		dev_err(&client->dev, "device_register failed\n");
>+		stk8312_set_mode(data, STK8312_MODE_STANDBY);
>+	}
>+
>+	return ret;
>+}
>+
>+static int stk8312_remove(struct i2c_client *client)
>+{
>+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>+
>+	iio_device_unregister(indio_dev);
>+
>+	return stk8312_set_mode(iio_priv(indio_dev), STK8312_MODE_STANDBY);
>+}
>+
>+#ifdef CONFIG_PM_SLEEP
>+static int stk8312_suspend(struct device *dev)
>+{
>+	struct stk8312_data *data;
>+
>+	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>+
>+	return stk8312_set_mode(data, STK8312_MODE_STANDBY);
>+}
>+
>+static int stk8312_resume(struct device *dev)
>+{
>+	struct stk8312_data *data;
>+
>+	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
>+
>+	return stk8312_set_mode(data, STK8312_MODE_ACTIVE);
>+}
>+
>+static SIMPLE_DEV_PM_OPS(stk8312_pm_ops, stk8312_suspend,
>stk8312_resume);
>+
>+#define STK8312_PM_OPS (&stk8312_pm_ops)
>+#else
>+#define STK8312_PM_OPS NULL
>+#endif
>+
>+static const struct i2c_device_id stk8312_i2c_id[] = {
>+	{"STK8312", 0},
>+	{}
>+};
>+
>+static const struct acpi_device_id stk8312_acpi_id[] = {
>+	{"STK8312", 0},
>+	{}
>+};
>+
>+MODULE_DEVICE_TABLE(acpi, stk8312_acpi_id);
>+
>+static struct i2c_driver stk8312_driver = {
>+	.driver = {
>+		.name = "stk8312",
>+		.pm = STK8312_PM_OPS,
>+		.acpi_match_table = ACPI_PTR(stk8312_acpi_id),
>+	},
>+	.probe =            stk8312_probe,
>+	.remove =           stk8312_remove,
>+	.id_table =         stk8312_i2c_id,
>+};
>+
>+module_i2c_driver(stk8312_driver);
>+
>+MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
>+MODULE_DESCRIPTION("STK8312 3-Axis Accelerometer driver");
>+MODULE_LICENSE("GPL v2");

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
