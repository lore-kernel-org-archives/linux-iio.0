Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38833 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbcGJNXa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 09:23:30 -0400
Subject: Re: [PATCH] iio: temperature: mcp9808: add Microchip MCP9808
 temperature sensor
To: Alison Schofield <amsfield22@gmail.com>
References: <20160703210448.GA14874@d830.WORKGROUP>
From: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <96a21d2e-3728-7f45-f562-ff07c6e2a599@kernel.org>
Date: Sun, 10 Jul 2016 14:23:27 +0100
MIME-Version: 1.0
In-Reply-To: <20160703210448.GA14874@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/16 22:04, Alison Schofield wrote:
> IIO driver, perhaps a reference driver, since this sensor is already
> supported in hwmon/jc42 driver.
> 
> Driver supports continuous conversion, resolution changes and
> suspend/resume power ops.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
Hi Alison,

Thanks for posting this.  Given the work was done it's a useful exercise to put
it out for review.

Mostly very good little driver.  The complex corner is the multiple resolution
support.  My guess is that this is purely a bit of 'mystified' oversampling
on the chip and I'd suggest supporting it as such.

Jonathan
> ---
>  drivers/iio/temperature/Kconfig   |  10 ++
>  drivers/iio/temperature/Makefile  |   1 +
>  drivers/iio/temperature/mcp9808.c | 269 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 280 insertions(+)
>  create mode 100644 drivers/iio/temperature/mcp9808.c
> 
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index c4664e5..25915d2 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -3,6 +3,16 @@
>  #
>  menu "Temperature sensors"
>  
> +config MCP9808
> +	tristate "MCP9808 temperature sensor"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for the Microchip
> +	  MCP9808 temperature sensor connected with I2C.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mcp9808.
> +
>  config MLX90614
>  	tristate "MLX90614 contact-less infrared sensor"
>  	depends on I2C
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 02bc79d..92cd1e6 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for industrial I/O temperature drivers
>  #
>  
> +obj-$(CONFIG_MCP9808) += mcp9808.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_TMP006) += tmp006.o
>  obj-$(CONFIG_TSYS01) += tsys01.o
> diff --git a/drivers/iio/temperature/mcp9808.c b/drivers/iio/temperature/mcp9808.c
> new file mode 100644
> index 0000000..adab708
> --- /dev/null
> +++ b/drivers/iio/temperature/mcp9808.c
> @@ -0,0 +1,269 @@
> +/*
> + * mcp9808.c - Support for Microchip MCP9808 Digital Temperature Sensor
> + *
> + * Copyright (C) 2016 Alison Schofield <amsfield22@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/25095A.pdf
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define MCP9808_REG_CONFIG		0x01
> +#define MCP9808_REG_TAMBIENT		0x05
> +#define MCP9808_REG_MANUF_ID		0x06
> +#define MCP9808_REG_DEVICE_ID		0x07
> +#define MCP9808_REG_RESOLUTION		0x08
> +
> +#define MCP9808_CONFIG_DEFAULT		0x00
There's a lot of other stuff in this register.
I guess most of it is alert related and that isn't supported here though
so fair enough.  Can be introduced when it becomes relevant.

> +#define MCP9808_CONFIG_SHUTDOWN		0x0100
> +
> +#define MCP9808_RES_DEFAULT		62500
> +
> +#define MCP9808_MANUF_ID		0x54
> +#define MCP9808_DEVICE_ID		0x0400
> +#define MCP9808_DEVICE_ID_MASK		0xff00
> +
> +struct mcp9808_data {
> +	struct i2c_client *client;
> +	struct mutex	   lock;	/* protect resolution changes  */
> +	int		   res_index;	/* current resolution index    */
> +};
> +
> +/* Resolution, MCP9808_REG_RESOLUTION bits, Conversion Time ms  */
> +static const int mcp9808_res[][3] = {
> +	{500000, 0,  30},
> +	{250000, 1,  65},
> +	{125000, 2, 130},
> +	{ 62500, 3, 250},
> +};
> +
> +static IIO_CONST_ATTR(temp_integration_time_available,
> +	"0.5 0.25 0.125 0.0625");
> +
> +static struct attribute *mcp9808_attributes[] = {
> +	&iio_const_attr_temp_integration_time_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group mcp9808_attribute_group = {
> +	.attrs = mcp9808_attributes,
> +};
> +
> +static int mcp9808_set_resolution(struct mcp9808_data *data, int val2)
> +{
> +	int i;
> +	int ret = -EINVAL;
> +	int conv_t = mcp9808_res[data->res_index][2];
> +
> +	for (i = 0; i < ARRAY_SIZE(mcp9808_res); i++) {
> +		if (val2 == mcp9808_res[i][0]) {
> +			mutex_lock(&data->lock);
> +			ret = i2c_smbus_write_byte_data(data->client,
> +							MCP9808_REG_RESOLUTION,
> +							mcp9808_res[i][1]);
> +			data->res_index = i;
> +			mutex_unlock(&data->lock);
> +
> +			/* delay old + new conversion time */
> +			msleep(conv_t + mcp9808_res[i][2]);
> +			break;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int mcp9808_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel,
> +			    int *val, int *val2, long mask)
> +
> +{
> +	struct mcp9808_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_smbus_read_word_swapped(data->client,
> +						  MCP9808_REG_TAMBIENT);
> +		if (ret < 0)
> +			return ret;
> +		*val = sign_extend32(ret, 12);
I just laughed when I saw the pile of BS they have in the datasheet to
describe exactly what you have here...

> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = 62500;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = mcp9808_res[data->res_index][0];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mcp9808_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *channel,
> +			     int val, int val2, long mask)
> +{
> +	struct mcp9808_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	if (mask == IIO_CHAN_INFO_INT_TIME) {
> +		if (!val)
> +			ret = mcp9808_set_resolution(data, val2);

Hmm.  Is this integration time?  I think it is more likely to be either:
1) The number of stages of the ADC. (normally gives a very minor time
difference in a SAR ADC or similar as going from say 8 to 10 bits is only
a 20% increase).
2) Number of averages samples (oversampling). (almost certainly true here).

Integration time doesn't make much sense for a temperature sensor.  These
tend to be analog parts with a track and hold type ADC that just gets what
ever is on the wire when a reading is requested.  Integration time is more
for things like light sensors where you are looking at counting number
of photons (very badly) in a fixed time period.

Hmm. So how should it be supported..
Could use sampling_frequency as that also reflects sampling period.
It's not ideal though.  Often we've just not bothered to support anything
other than the highest resolution (particularly on fast devices), but here
it really does lead to very low speeds...  Basis for not supporting it in
the past was that mostly the cost was minor to increase the resolution and

If we knew it really was just oversampling this would be easy. I suppose it
doesn't actually matter what the hardware is doing.  That's what the software
is effectively seeing .

Unfortunately, for oversampling to be used you'd probably also want an
indication of the sampling frequency so you'd need that one as well.

So I think the best option is oversampling_ratio and sampling_frequency.
Control via oversampling_ratio.

> +	}
> +	return ret;
> +}
> +
> +static const struct iio_chan_spec mcp9808_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_INT_TIME)
> +	}
> +};
> +
> +static const struct iio_info mcp9808_info = {
> +	.read_raw = mcp9808_read_raw,
> +	.write_raw = mcp9808_write_raw,
> +	.attrs = &mcp9808_attribute_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static bool mcp9808_check_id(struct i2c_client *client)
> +{
> +	int mid, did;
> +
> +	mid = i2c_smbus_read_word_swapped(client, MCP9808_REG_MANUF_ID);
> +	if (mid < 0)
> +		return false;
You are potentially eating more informative errors here. I'd have preferred
a function of the form
static int mcp9808_check_id(struct i2c_client *client) that simply
returned -ENODEV if the reads were good but the id wrong.  In other error
cases it could return the result of the i2c calls.

These are the first i2c calls, so if there is something going wrong
with the i2c controller or similar, we definitely don't want it to
simply indicate that the wrong device was present.
> +
> +	did = i2c_smbus_read_word_swapped(client, MCP9808_REG_DEVICE_ID);
> +	if (did < 0)
> +		return false;
> +
> +	return ((mid == MCP9808_MANUF_ID) &&
> +		((did & MCP9808_DEVICE_ID_MASK) == MCP9808_DEVICE_ID));
> +}
> +
> +static int mcp9808_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mcp9808_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA
> +				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
> +		return -EOPNOTSUPP;
> +
> +	if (!mcp9808_check_id(client)) {
> +		dev_err(&client->dev, "no MCP9808 sensor\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->info = &mcp9808_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = mcp9808_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mcp9808_channels);
> +
> +	/* set config register to power-on default */
> +	ret = i2c_smbus_write_word_swapped(data->client, MCP9808_REG_CONFIG,
> +					   MCP9808_CONFIG_DEFAULT);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* set resolution register to power-on default */
> +	ret = mcp9808_set_resolution(data, MCP9808_RES_DEFAULT);
> +	if (ret < 0)
> +		return ret;
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int mcp9808_shutdown(struct mcp9808_data *data)
> +{
> +	return i2c_smbus_write_word_swapped(data->client, MCP9808_REG_CONFIG,
> +					    MCP9808_CONFIG_SHUTDOWN);
> +}
> +
> +static int mcp9808_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return mcp9808_shutdown(iio_priv(indio_dev));
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int mcp9808_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	return mcp9808_shutdown(iio_priv(indio_dev));
> +}
> +
> +static int mcp9808_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mcp9808_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = mcp9808_set_resolution(data, mcp9808_res[data->res_index][0]);
> +	if (ret < 0)
> +		return ret;
> +
> +	return i2c_smbus_write_word_swapped(data->client, MCP9808_REG_CONFIG,
> +					    MCP9808_CONFIG_DEFAULT);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(mcp9808_pm_ops, mcp9808_suspend, mcp9808_resume);
> +
> +static const struct i2c_device_id mcp9808_id[] = {
> +	{ "mcp9808", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp9808_id);
> +
> +static struct i2c_driver mcp9808_driver = {
> +	.driver = {
> +		.name	= "mcp9808",
> +		.pm	= &mcp9808_pm_ops,
> +	},
> +	.probe = mcp9808_probe,
> +	.remove = mcp9808_remove,
> +	.id_table = mcp9808_id,
> +};
> +module_i2c_driver(mcp9808_driver);
> +
> +MODULE_AUTHOR("Alison Schofield <amsfield22@gmail.com>");
> +MODULE_DESCRIPTION("MCP9808 Temperature Sensor Driver");
> +MODULE_LICENSE("GPL v2");
> 

