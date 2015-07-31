Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:59598 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659AbbGaQdE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 31 Jul 2015 12:33:04 -0400
Date: Fri, 31 Jul 2015 18:33:01 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Teodora Baluta <teodora.baluta@intel.com>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: accel: add support for mxc4005 accelerometer
In-Reply-To: <1438356340-13306-2-git-send-email-teodora.baluta@intel.com>
Message-ID: <alpine.DEB.2.02.1507311817360.12658@pmeerw.net>
References: <1438356340-13306-1-git-send-email-teodora.baluta@intel.com> <1438356340-13306-2-git-send-email-teodora.baluta@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 31 Jul 2015, Teodora Baluta wrote:

> This patch adds support for Memsic MXC4005XC 3-axis accelerometer. The
> current implementation is a minimal one as it adds raw readings for the
> three axes and setting scale from userspace.

some comments below
 
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
> ---
>  drivers/iio/accel/Kconfig   |  11 ++
>  drivers/iio/accel/Makefile  |   2 +
>  drivers/iio/accel/mxc4005.c | 373 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 386 insertions(+)
>  create mode 100644 drivers/iio/accel/mxc4005.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 00e7bcb..7f534a3 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -137,6 +137,17 @@ config MMA9553
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mma9553.
>  
> +config MXC4005
> +	tristate "Memsic MXC4005XC 3-Axis Accelerometer Driver"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes here to build support for the Memsic MXC4005XC 3-axis
> +	  accelerometer.
> +
> +	  To compile this driver as a module, choose M. The module will be
> +	  called mxc4005.
> +
>  config STK8312
>  	tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index ebd2675..020dda0 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -14,6 +14,8 @@ obj-$(CONFIG_MMA9551_CORE)	+= mma9551_core.o
>  obj-$(CONFIG_MMA9551)		+= mma9551.o
>  obj-$(CONFIG_MMA9553)		+= mma9553.o
>  
> +obj-$(CONFIG_MXC4005)		+= mxc4005.o
> +
>  obj-$(CONFIG_STK8312)		+= stk8312.o
>  obj-$(CONFIG_STK8BA50)		+= stk8ba50.o
>  
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> new file mode 100644
> index 0000000..0f0410c
> --- /dev/null
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -0,0 +1,373 @@
> +/*
> + * 3-axis accelerometer driver for MXC4005XC Memsic sensor
> + *
> + * Copyright (c) 2014, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/acpi.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define MXC4005_DRV_NAME		"mxc4005"
> +#define MXC4005_REGMAP_NAME		"mxc4005_regmap"
> +
> +#define MXC4005_REG_XOUT_UPPER		0x03
> +#define MXC4005_REG_XOUT_LOWER		0x04
> +#define MXC4005_REG_YOUT_UPPER		0x05
> +#define MXC4005_REG_YOUT_LOWER		0x06
> +#define MXC4005_REG_ZOUT_UPPER		0x07
> +#define MXC4005_REG_ZOUT_LOWER		0x08
> +
> +#define MXC4005_REG_CONTROL		0x0D
> +#define MXC4005_REG_CONTROL_MASK_FSR	GENMASK(6, 5)
> +#define MXC4005_CONTROL_FSR_SHIFT	5
> +
> +#define MXC4005_REG_DEVICE_ID		0x0E
> +
> +#define MXC4005_AXIS_TO_REG(axis)	(MXC4005_REG_XOUT_UPPER + (axis * 2))

maybe parenthesis around (axis)

> +
> +enum mxc4005_axis {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +};
> +
> +enum mxc4005_range {
> +	MXC4005_RANGE_2G,
> +	MXC4005_RANGE_4G,
> +	MXC4005_RANGE_8G,
> +};
> +
> +struct mxc4005_data {
> +	struct i2c_client *client;
> +	struct mutex mutex;
> +	struct regmap *regmap;
> +};
> +
> +/*
> + * MXC4005 can operate in the following ranges:
> + * +/- 2G, 4G, 8G (the default +/-2G)
> + *
> + * (2 + 2) * 9.81 / (2^12 - 1) = 0.009582
> + * (4 + 4) * 9.81 / (2^12 - 1) = 0.019164
> + * (8 + 8) * 9.81 / (2^12 - 1) = 0.038329
> + */
> +static const struct {
> +	u8 range;
> +	u16 scale;

scale should be int

> +} mxc4005_scale_table[] = {
> +	{MXC4005_RANGE_2G, 9582},
> +	{MXC4005_RANGE_4G, 19164},
> +	{MXC4005_RANGE_8G, 38329},
> +};
> +
> +
> +static IIO_CONST_ATTR(in_accel_scale_available, "0.009582 0.019164 0.038329");
> +
> +static struct attribute *mxc4005_attributes[] = {
> +	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group mxc4005_attrs_group = {
> +	.attrs = mxc4005_attributes,
> +};
> +
> +static bool mxc4005_is_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MXC4005_REG_XOUT_UPPER:
> +	case MXC4005_REG_XOUT_LOWER:
> +	case MXC4005_REG_YOUT_UPPER:
> +	case MXC4005_REG_YOUT_LOWER:
> +	case MXC4005_REG_ZOUT_UPPER:
> +	case MXC4005_REG_ZOUT_LOWER:
> +	case MXC4005_REG_DEVICE_ID:
> +	case MXC4005_REG_CONTROL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool mxc4005_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MXC4005_REG_CONTROL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config mxc4005_regmap_config = {
> +	.name = MXC4005_DRV_NAME,
> +
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = MXC4005_REG_DEVICE_ID,
> +	.cache_type = REGCACHE_NONE,
> +
> +	.readable_reg = mxc4005_is_readable_reg,
> +	.writeable_reg = mxc4005_is_writeable_reg,
> +};
> +
> +static int mxc4005_read_axis(struct mxc4005_data *data,
> +			     int axis)
> +{
> +	u16 reg;

be16

> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, MXC4005_AXIS_TO_REG(axis),
> +			       (u8 *) &reg, 2);

sizeof(reg) probably

> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "failed to read axis %d\n", axis);
> +		return ret;
> +	}
> +
> +	return reg;
> +}
> +
> +static int mxc4005_read_scale(struct mxc4005_data *data)
> +{
> +	unsigned int reg;
> +	int ret;
> +	int i;
> +
> +	ret = regmap_read(data->regmap, MXC4005_REG_CONTROL, &reg);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "failed to read reg_control");

\n missing

> +		return ret;
> +	}
> +
> +	i = reg >> MXC4005_CONTROL_FSR_SHIFT;

maybe mask the relevant bits...

> +
> +	if (i < 0 || i >= ARRAY_SIZE(mxc4005_scale_table))
> +		return -EINVAL;

.. instead of returning an error

> +
> +	return mxc4005_scale_table[i].scale;
> +}
> +
> +static int mxc4005_set_scale(struct mxc4005_data *data, int val)
> +{
> +	int i;
> +	int ret;
> +	int scale;
> +
> +	for (i = 0; i < ARRAY_SIZE(mxc4005_scale_table); i++) {
> +		if (mxc4005_scale_table[i].scale == val) {
> +			scale = i << MXC4005_CONTROL_FSR_SHIFT;

reg would be a better name for variable scale (and consistent with 
read_scale()), could be moved to local scope

> +			ret = regmap_update_bits(data->regmap,
> +						 MXC4005_REG_CONTROL,
> +						 MXC4005_REG_CONTROL_MASK_FSR,
> +						 scale);
> +			if (ret < 0)
> +				dev_err(&data->client->dev,
> +					"failed to write reg_control %d\n",
> +					ret);

ret is only shown here, but not for read_scale();
maybe "failed to write reg_control, ret = %d\n" would be clearer

> +			return ret;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mxc4005_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct mxc4005_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			if (iio_buffer_enabled(indio_dev))
> +				return -EBUSY;
> +
> +			mutex_lock(&data->mutex);
> +			ret = mxc4005_read_axis(data, chan->address);
> +			mutex_unlock(&data->mutex);
> +			if (ret < 0)
> +				return ret;
> +			ret = be16_to_cpu(ret);

I'd move the be16_to_cpu() to read_axis()

> +			*val = sign_extend32(ret >> 4, 11);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;

maybe move this assignment down where you set val2

> +		mutex_lock(&data->mutex);
> +		ret = mxc4005_read_scale(data);
> +		mutex_unlock(&data->mutex);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val2 = ret;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mxc4005_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mxc4005_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val != 0)
> +			return -EINVAL;
> +
> +		mutex_lock(&data->mutex);
> +		ret = mxc4005_set_scale(data, val2);
> +		mutex_unlock(&data->mutex);
> +		break;

return ret;

> +	default:
> +		ret = -EINVAL;

return -EINVAL;

> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info mxc4005_info = {
> +	.driver_module	= THIS_MODULE,
> +	.read_raw	= mxc4005_read_raw,
> +	.write_raw	= mxc4005_write_raw,
> +	.attrs		= &mxc4005_attrs_group,
> +};
> +
> +#define MXC4005_CHANNEL(_axis) {				\
> +	.type = IIO_ACCEL,					\
> +	.modified = 1,						\
> +	.channel2 = IIO_MOD_##_axis,				\
> +	.address = AXIS_##_axis,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec mxc4005_channels[] = {
> +	MXC4005_CHANNEL(X),
> +	MXC4005_CHANNEL(Y),
> +	MXC4005_CHANNEL(Z),
> +};
> +
> +static int mxc4005_chip_init(struct mxc4005_data *data)
> +{
> +	int ret;
> +	unsigned int reg;
> +
> +	ret = regmap_read(data->regmap, MXC4005_REG_DEVICE_ID, &reg);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "failed to read chip id\n");
> +		return ret;
> +	}
> +
> +	dev_dbg(&data->client->dev, "MXC4005 chip id %d\n", reg);

probably better to format as %02x

> +
> +	return 0;
> +}
> +
> +static int mxc4005_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct mxc4005_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &mxc4005_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "failed to initialize regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	data->regmap = regmap;
> +
> +	ret = mxc4005_chip_init(data);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to init chip\n");
> +		return ret;
> +	}
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = mxc4005_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mxc4005_channels);
> +	indio_dev->name = MXC4005_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &mxc4005_info;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"unable to register iio device %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxc4005_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id mxc4005_acpi_match[] = {
> +	{"MXC4005",	0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, mxc4005_acpi_match);
> +
> +static const struct i2c_device_id mxc4005_id[] = {
> +	{"mxc4005",	0},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, mxc4005_id);
> +
> +static struct i2c_driver mxc4005_driver = {
> +	.driver = {
> +		.name = MXC4005_DRV_NAME,
> +		.acpi_match_table = ACPI_PTR(mxc4005_acpi_match),
> +	},
> +	.probe		= mxc4005_probe,
> +	.remove		= mxc4005_remove,
> +	.id_table	= mxc4005_id,
> +};
> +
> +module_i2c_driver(mxc4005_driver);
> +
> +MODULE_AUTHOR("Teodora Baluta <teodora.baluta@intel.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("MXC4005 3-axis accelerometer driver");
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
