Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55268 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759357Ab3HNJXP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 14 Aug 2013 05:23:15 -0400
Date: Wed, 14 Aug 2013 11:23:11 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] Add mcp3422 kernel driver
In-Reply-To: <1376471047-9636-2-git-send-email-angelo.compagnucci@gmail.com>
Message-ID: <alpine.DEB.2.01.1308141109300.10024@pmeerw.net>
References: <1376471047-9636-1-git-send-email-angelo.compagnucci@gmail.com> <1376471047-9636-2-git-send-email-angelo.compagnucci@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>  drivers/iio/adc/Kconfig   |   10 ++
>  drivers/iio/adc/Makefile  |    1 +
>  drivers/iio/adc/mcp3422.c |  400 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 411 insertions(+)
>  create mode 100644 drivers/iio/adc/mcp3422.c

an I2C ADC, yeah, like!

comments inline

> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 93129ec..372667c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -143,6 +143,16 @@ config MCP320X
>  	  This driver can also be built as a module. If so, the module will be
>  	  called mcp320x.
>  
> +config MCP3422
> +	tristate "Microchip Technology MCP3422/3/4 driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Microchip Technology's MCP3422,
> +	  MCP3423 or MCP3424 analog to digital converters.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called mcp3422.
> +
>  config TI_ADC081C
>  	tristate "Texas Instruments ADC081C021/027"
>  	depends on I2C
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 8f475d3..bae9f67 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MCP320X) += mcp320x.o
> +obj-$(CONFIG_MCP3422) += mcp3422.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> new file mode 100644
> index 0000000..d45bbbe
> --- /dev/null
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -0,0 +1,400 @@
> +/*
> + * mcp3422.c - driver for the Microchip mcp3422/3/4 chip family
> + *
> + * Copyright (C) 2013, Angelo Compagnucci
> + * Author: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> + *
> + * Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/22088b.pdf
> + *
> + * This driver export the value of analog input voltage to sysfs, the

exports

> + * voltage unit is nV.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/sysfs.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +/* Masks */
> +#define MCP3422_CHANNEL_MASK	0x60
> +#define MCP3422_PGA_MASK	0x03
> +#define MCP3422_SRATE_MASK	0x0C
> +#define MCP3422_SRATE_240	0x0
> +#define MCP3422_SRATE_60	0x1
> +#define MCP3422_SRATE_15	0x2
> +#define MCP3422_SRATE_3	0x3
> +
> +#define MCP3422_CHANNEL(config)	(((config) & MCP3422_CHANNEL_MASK) >> 5)
> +#define MCP3422_PGA(config)	((config) & MCP3422_PGA_MASK)
> +#define MCP3422_SAMPLE_RATE(config)	(((config) & MCP3422_SRATE_MASK) >> 2)
> +
> +#define VREF 2048
> +
> +#define MCP3422_CHAN(index) \
> +	{ \
> +		.type = IIO_VOLTAGE, \
> +		.indexed = 1, \
> +		.channel = index, \
> +		.address = index, \

address is not used

> +		.scan_index = index, \

scan index is not used

> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	}
> +
> +/* LSB is in nV to eliminate floating point */
> +static const u32 rates_to_lsb[] = {1000000, 250000, 62500, 15625};
> +
> +/*
> + * Client data (each client gets its own)
> + */

single line comment

> +struct mcp3422 {
> +	struct i2c_client *i2c;
> +	u8 config;
> +};
> +
> +static int mcp3422_update_config(struct mcp3422 *adc)
> +{
> +	u8 buf[1];

maybe just 'u8 buf' ?

> +	buf[0] = adc->config;
> +	return i2c_master_send(adc->i2c, buf, 1);
> +}
> +
> +static int mcp3422_read(struct mcp3422 *adc, int *value, u8 *config)
> +{
> +	int ret = 0;
> +	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
> +	u8 buf[4] = {'\0', '\0', '\0', '\0'};
> +
> +	*value = 0;
> +
> +	if (sample_rate == MCP3422_SRATE_3) {
> +		ret = i2c_master_recv(adc->i2c, buf, 4);
> +		*value += (s8)buf[0];
> +		*value <<= 16;
> +		*value |= buf[1] << 8;
> +		*value |= buf[2];
> +		*config = buf[3];
> +		if (*value == 0xFFFFFFFF)
> +			*value = 0;
> +	} else {
> +		ret = i2c_master_recv(adc->i2c, buf, 3);
> +		*value += (s8)buf[0];
> +		*value <<= 8;
> +		*value |= buf[1];
> +		*config = buf[2];
> +	}
> +
> +	return ret;
> +}
> +
> +static int mcp3422_read_channel(struct mcp3422 *adc,
> +				struct iio_chan_spec const *channel, int *value)
> +{
> +	int ret, mtime = 0;
> +	u8 current_config = 0;
> +	u8 req_channel = channel->channel - 1;
> +
> +	ret = mcp3422_read(adc, value, &current_config);

is it not possible to know beforehand that the current read is
for a different channel?

noone except the driver should control the device's configuration

locking seems necessary for the present strategy; the configuration could 
change in the meanwhile

> +
> +	if (req_channel != MCP3422_CHANNEL(current_config)) {
> +		adc->config &= ~MCP3422_CHANNEL_MASK;
> +		adc->config |= ((req_channel << 5) & MCP3422_CHANNEL_MASK);
> +		mcp3422_update_config(adc);
> +		switch (MCP3422_SAMPLE_RATE(current_config)) {
> +		case MCP3422_SRATE_240:
> +			mtime = 1000 / 240;
> +			break;
> +		case MCP3422_SRATE_60:
> +			mtime = 1000 / 60;
> +			break;
> +		case MCP3422_SRATE_15:
> +			mtime = 1000 / 15;
> +			break;
> +		case MCP3422_SRATE_3:
> +			mtime = 1000 / 3;
> +			break;
> +		}
> +		msleep(mtime);
> +		ret = mcp3422_read(adc, value, &current_config);
> +	}
> +	return ret;
> +}
> +
> +static int mcp3422_read_raw(struct iio_dev *iio,
> +			    struct iio_chan_spec const *channel, int *value,
> +			    int *shift, long mask)
> +{
> +	struct mcp3422 *adc = iio_priv(iio);
> +	int err, temp = 0;
> +
> +	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
> +	u8 pga         = MCP3422_PGA(adc->config);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		err = mcp3422_read_channel(adc, channel, &temp);
> +		if (err < 0)
> +			return err;
> +
> +		/*
> +		* Converting the output
> +		*/

single line comment

> +		*value = (temp * rates_to_lsb[sample_rate])
> +					/ (pga ? 1 << pga : 1);
> +

scaling to be done in INFO_SCALE

> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +
> +		*value = VREF * 1000000;
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t mcp3422_set_sample_rate(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *iio = i2c_get_clientdata(client);
> +	struct mcp3422 *adc = iio_priv(iio);
> +	u8 value = 0;
> +
> +	if (kstrtou8(buf, 10, &value) < 0)
> +		return -EINVAL;
> +
> +	switch (value) {
> +	case 240:
> +		value = MCP3422_SRATE_240;
> +		break;
> +	case 60:
> +		value = MCP3422_SRATE_60;
> +		break;
> +	case 15:
> +		value = MCP3422_SRATE_15;
> +		break;
> +	case 3:
> +		value = MCP3422_SRATE_3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	adc->config &= ~MCP3422_SRATE_MASK;
> +	adc->config |= ((value << 2) & MCP3422_SRATE_MASK);
> +
> +	mcp3422_update_config(adc);
> +
> +	return count;
> +}
> +
> +static ssize_t mcp3422_get_sample_rate(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *iio = i2c_get_clientdata(client);
> +	struct mcp3422 *adc = iio_priv(iio);
> +	u8 value = 0;
> +
> +	switch (MCP3422_SAMPLE_RATE(adc->config)) {
> +	case 0:
> +		value = 240;
> +		break;
> +	case 1:
> +		value = 60;
> +		break;
> +	case 2:
> +		value = 15;
> +		break;
> +	case 3:
> +		value = 3;
> +		break;
> +	}
> +
> +	return sprintf(buf, "%d\n", value);
> +}
> +
> +static ssize_t mcp3422_set_pga(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *iio = i2c_get_clientdata(client);
> +	struct mcp3422 *adc = iio_priv(iio);
> +	u8 value = 0;
> +
> +	if (kstrtou8(buf, 10, &value) < 0)
> +		return -EINVAL;
> +
> +	switch (value) {
> +	case 1:
> +		value = 0;
> +		break;
> +	case 2:
> +		value = 1;
> +		break;
> +	case 4:
> +		value = 2;
> +		break;
> +	case 8:
> +		value = 3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	adc->config &= ~MCP3422_PGA_MASK;
> +	adc->config |= (value & MCP3422_PGA_MASK);
> +
> +	mcp3422_update_config(adc);
> +
> +	return count;
> +}
> +
> +static ssize_t mcp3422_get_pga(struct device *dev,
> +		struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *iio = i2c_get_clientdata(client);
> +	struct mcp3422 *adc = iio_priv(iio);
> +
> +	return sprintf(buf, "%d\n", 1 << MCP3422_PGA(adc->config));
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR,
> +			mcp3422_get_sample_rate,
> +			mcp3422_set_sample_rate);
> +static IIO_DEVICE_ATTR(pga,
> +			S_IRUGO | S_IWUSR,
> +			mcp3422_get_pga,
> +			mcp3422_set_pga, 0);
> +static IIO_CONST_ATTR(sampling_frequency_available, "240 60 15 3");
> +static IIO_CONST_ATTR(pga_available, "1 2 4 8");
> +
> +static struct attribute *mcp3422_attributes[] = {
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_pga.dev_attr.attr,
> +	&iio_const_attr_pga_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group mcp3422_attribute_group = {
> +	.attrs = mcp3422_attributes,
> +};
> +
> +static const struct iio_chan_spec mcp3422_channels[] = {
> +	MCP3422_CHAN(1),
> +	MCP3422_CHAN(2),
> +	MCP3422_CHAN(3),
> +	MCP3422_CHAN(4),
> +};
> +
> +static const struct iio_info mcp3422_info = {
> +	.read_raw = mcp3422_read_raw,
> +	.attrs = &mcp3422_attribute_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int mcp3422_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *iio;
> +	struct mcp3422 *adc;
> +	int err;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;

driver does not use WORD transfers

> +
> +	iio = iio_device_alloc(sizeof(*adc));
> +	if (!iio)
> +		return -ENOMEM;

devm_iio_device_alloc()

> +
> +	adc = iio_priv(iio);
> +	adc->i2c = client;
> +
> +	/* meaningful default configuration */
> +	adc->config = 0x10;

0x10 could/should be replaced by meaningful constants like SRATE_XX, PGA, 
etc.

> +
> +	iio->dev.parent = &client->dev;
> +	iio->name = dev_name(&client->dev);
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->info = &mcp3422_info;
> +
> +	iio->channels = mcp3422_channels;
> +	iio->num_channels = ARRAY_SIZE(mcp3422_channels);
> +
> +	err = iio_device_register(iio);
> +	if (err < 0)
> +		goto iio_free;
> +
> +	i2c_set_clientdata(client, iio);
> +
> +	mcp3422_update_config(adc);
> +
> +	return 0;
> +
> +iio_free:
> +	iio_device_free(iio);
> +
> +	return err;
> +}
> +
> +static int mcp3422_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *iio = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(iio);
> +	iio_device_free(iio);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id mcp3422_id[] = {
> +	{ "mcp3422", 2 },
> +	{ "mcp3423", 3 },
> +	{ "mcp3424", 4 },
> +	{ }
> +};

what is the difference between the devices? 
id doesn't get used?

> +MODULE_DEVICE_TABLE(i2c, mcp3422_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id mcp3422_of_match[] = {
> +	{ .compatible = "mcp3422" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mcp3422_of_match);
> +#endif
> +
> +static struct i2c_driver mcp3422_driver = {
> +	.driver = {
> +		.name = "mcp3422",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(mcp3422_of_match),
> +	},
> +	.probe = mcp3422_probe,
> +	.remove = mcp3422_remove,
> +	.id_table = mcp3422_id,
> +};
> +module_i2c_driver(mcp3422_driver);
> +
> +MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
> +MODULE_DESCRIPTION("Microchip mcp3422/3/4 driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
