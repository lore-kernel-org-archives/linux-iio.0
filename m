Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54303 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768AbbCNOAr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2015 10:00:47 -0400
Message-ID: <55016958.8050102@kernel.org>
Date: Thu, 12 Mar 2015 10:24:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, ktsai@capellamicro.com
Subject: Re: [PATCH] iio: light: Add support for Capella CM3323 color sensor
References: <1425988438-9330-1-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1425988438-9330-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/03/15 11:53, Daniel Baluta wrote:
> Minimal implementation providing raw light intensity
> and integration time attribute.
> 
> Userspace applications can use GREEN channel for raw
> illuminance readings following this table:
> 
> Integration Time | G Sensitivity
> ================================
> 40 ms            | 0.18
> 80 ms            | 0.09
> 160 ms           | 0.045
> 320 ms           | 0.0225
> 640 ms           | 0.01125
> 1280 ms          | 0.005625
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
There is a race possibility between the userspace interfaces
being removed and the device disabled.  devm_iio_device_register
is a dangerous beast unfortunately.  It is more or less only
usable if there is no remove function (e.g. everything is
devm_ managed).

Otherwise, looks good to me.

Jonathan
> ---
>  drivers/iio/light/Kconfig  |  10 ++
>  drivers/iio/light/Makefile |   1 +
>  drivers/iio/light/cm3323.c | 273 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 284 insertions(+)
>  create mode 100644 drivers/iio/light/cm3323.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index ae68c64..cd937d9 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -59,6 +59,16 @@ config CM3232
>  	 To compile this driver as a module, choose M here:
>  	 the module will be called cm3232.
>  
> +config CM3323
> +	depends on I2C
> +	tristate "Capella CM3323 color light sensor"
> +	help
> +	 Say Y here if you want to build a driver for Capela CM3323
> +	 color sensor.
> +
> +	 To compile this driver as a module, choose M here: the module will
> +	 be called cm3323.
> +
>  config CM36651
>  	depends on I2C
>  	tristate "CM36651 driver"
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index b12a516..ad7c30f 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_AL3320A)		+= al3320a.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
>  obj-$(CONFIG_CM32181)		+= cm32181.o
>  obj-$(CONFIG_CM3232)		+= cm3232.o
> +obj-$(CONFIG_CM3323)		+= cm3323.o
>  obj-$(CONFIG_CM36651)		+= cm36651.o
>  obj-$(CONFIG_GP2AP020A00F)	+= gp2ap020a00f.o
>  obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> new file mode 100644
> index 0000000..a3f040e
> --- /dev/null
> +++ b/drivers/iio/light/cm3323.c
> @@ -0,0 +1,273 @@
> +/*
> + * CM3323 - Capella Color Light Sensor
> + *
> + * Copyright (c) 2015, Intel Corporation.
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * IIO driver for CM3323 (7-bit I2C slave address 0x10)
> + *
> + * TODO: calibscale to correct the lens factor
> + */
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define CM3323_DRV_NAME "cm3323"
> +
> +#define CM3323_CMD_CONF		0x00
> +#define CM3323_CMD_RED_DATA	0x08
> +#define CM3323_CMD_GREEN_DATA	0x09
> +#define CM3323_CMD_BLUE_DATA	0x0A
> +#define CM3323_CMD_CLEAR_DATA	0x0B
> +
> +#define CM3323_CONF_SD_BIT	BIT(0) /* sensor disable */
> +#define CM3323_CONF_AF_BIT	BIT(1) /* auto/manual force mode */
> +#define CM3323_CONF_IT_MASK	(BIT(4) | BIT(5) | BIT(6))
> +#define CM3323_CONF_IT_SHIFT	4
> +
> +#define CM3323_INT_TIME_AVAILABLE "0.04 0.08 0.16 0.32 0.64 1.28"
> +
> +static const struct {
> +	int val;
> +	int val2;
> +} cm3323_int_time[] = {
> +	{0, 40000},  /* 40 ms */
> +	{0, 80000},  /* 80 ms */
> +	{0, 160000}, /* 160 ms */
> +	{0, 320000}, /* 320 ms */
> +	{0, 640000}, /* 640 ms */
> +	{1, 280000}, /* 1280 ms */
> +};
> +
> +struct cm3323_data {
> +	struct i2c_client *client;
> +	u16 reg_conf;
> +	struct mutex mutex;
> +};
> +
> +#define CM3323_COLOR_CHANNEL(_color, _addr) { \
> +	.type = IIO_INTENSITY, \
> +	.modified = 1, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME), \
> +	.channel2 = IIO_MOD_LIGHT_##_color, \
> +	.address = _addr, \
> +}
> +
> +static const struct iio_chan_spec cm3323_channels[] = {
> +	CM3323_COLOR_CHANNEL(RED, CM3323_CMD_RED_DATA),
> +	CM3323_COLOR_CHANNEL(GREEN, CM3323_CMD_GREEN_DATA),
> +	CM3323_COLOR_CHANNEL(BLUE, CM3323_CMD_BLUE_DATA),
> +	CM3323_COLOR_CHANNEL(CLEAR, CM3323_CMD_CLEAR_DATA),
> +};
> +
> +static IIO_CONST_ATTR_INT_TIME_AVAIL(CM3323_INT_TIME_AVAILABLE);
> +
> +static struct attribute *cm3323_attributes[] = {
> +	&iio_const_attr_integration_time_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group cm3323_attribute_group = {
> +	.attrs = cm3323_attributes,
> +};
> +
> +static int cm3323_init(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct cm3323_data *data = iio_priv(indio_dev);
> +
> +	ret = i2c_smbus_read_word_data(data->client, CM3323_CMD_CONF);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_conf\n");
> +		return ret;
> +	}
> +
> +	/* enable sensor and set auto force mode */
> +	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
> +
> +	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_conf\n");
> +		return ret;
> +	}
> +
> +	data->reg_conf = ret;
> +
> +	return 0;
> +}
> +
> +static int cm3323_set_it_bits(struct cm3323_data *data, int val, int val2)
> +{
> +	int i, ret;
> +	u16 reg_conf;
> +
> +	for (i = 0; i < ARRAY_SIZE(cm3323_int_time); i++) {
> +		if (val == cm3323_int_time[i].val &&
> +			val2 == cm3323_int_time[i].val2) {
> +			reg_conf = data->reg_conf;
> +			reg_conf |= i << CM3323_CONF_IT_SHIFT;
> +
> +			ret = i2c_smbus_write_word_data(data->client,
> +				 CM3323_CMD_CONF, reg_conf);
> +			if (ret < 0)
> +				return ret;
> +
> +			data->reg_conf = reg_conf;
> +			return 0;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +static int cm3323_get_it_bits(struct cm3323_data *data)
> +{
> +	int bits;
> +
> +	bits = (data->reg_conf & CM3323_CONF_IT_MASK) >>
> +		CM3323_CONF_IT_SHIFT;
> +
> +	if (bits >= ARRAY_SIZE(cm3323_int_time))
> +		return -EINVAL;
> +	return bits;
> +}
> +
> +static int cm3323_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	int i, ret;
> +	struct cm3323_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->mutex);
> +		ret = i2c_smbus_read_word_data(data->client, chan->address);
> +		if (ret < 0) {
> +			mutex_unlock(&data->mutex);
> +			return ret;
> +		}
> +		*val = ret;
> +		mutex_unlock(&data->mutex);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		mutex_lock(&data->mutex);
> +		i = cm3323_get_it_bits(data);
> +		if (i < 0) {
> +			mutex_unlock(&data->mutex);
> +			return -EINVAL;
> +		}
> +
> +		*val = cm3323_int_time[i].val;
> +		*val2 = cm3323_int_time[i].val2;
> +		mutex_unlock(&data->mutex);
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cm3323_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long mask)
> +{
> +	struct cm3323_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		mutex_lock(&data->mutex);
> +		ret = cm3323_set_it_bits(data, val, val2);
> +		mutex_unlock(&data->mutex);
> +
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info cm3323_info = {
> +	.driver_module	= THIS_MODULE,
> +	.read_raw	= cm3323_read_raw,
> +	.write_raw	= cm3323_write_raw,
> +	.attrs		= &cm3323_attribute_group,
> +};
> +
> +static int cm3323_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct cm3323_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &cm3323_info;
> +	indio_dev->name = CM3323_DRV_NAME;
> +	indio_dev->channels = cm3323_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(cm3323_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = cm3323_init(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cm3323 chip init failed\n");
> +		return ret;
> +	}
> +	return devm_iio_device_register(&client->dev, indio_dev);
All sorts of nasty ordering issues occur if you use managed register.
The userspace interface will be available after you have turned off
the device (be it briefly).

Please do the unregister manualy in the correct location to maintain
ordering.


> +}
> +
> +static int cm3323_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct cm3323_data *data  = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	/* disable sensor */
> +	ret = i2c_smbus_write_word_data(client, CM3323_CMD_CONF,
> +					CM3323_CONF_SD_BIT);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Error writing reg_conf\n");
> +
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +
> +static const struct i2c_device_id cm3323_id[] = {
> +	{"cm3323", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, cm3323_id);
> +
> +static struct i2c_driver cm3323_driver = {
> +	.driver = {
> +		.name = CM3323_DRV_NAME,
> +	},
> +	.probe		= cm3323_probe,
> +	.remove		= cm3323_remove,
> +	.id_table	= cm3323_id,
> +};
> +
> +module_i2c_driver(cm3323_driver);
> +
> +MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
> +MODULE_DESCRIPTION("Capella CM3323 Color Light Sensor driver");
> +MODULE_LICENSE("GPL v2");
> 

