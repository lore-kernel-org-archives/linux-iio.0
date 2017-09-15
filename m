Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbdIOCXL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 14 Sep 2017 22:23:11 -0400
Date: Thu, 14 Sep 2017 19:23:08 -0700
From: Jonathan Cameron <jic23@kernel.org>
To: Ismail Kose <Ismail.Kose@maximintegrated.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, jeff.dagenais@gmail.com,
        fabrice.gasnier@st.com, gwenhael.goavec-merou@trabucayre.com,
        peda@axentia.se, maxime.roussinbelanger@gmail.com,
        mike.looijmans@topic.nl, ihkose@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ds4422/ds4424 dac driver
Message-ID: <20170914192308.341199ff@archlinux>
In-Reply-To: <20170914202449.31283-1-Ismail.Kose@maximintegrated.com>
References: <20170914202449.31283-1-Ismail.Kose@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 14 Sep 2017 13:24:49 -0700
Ismail Kose <Ismail.Kose@maximintegrated.com> wrote:

> From: "Ismail H. Kose" <ihkose@gmail.com>
> 
> This patch provides an iio device driver for DS4422/DS4424 chips that support
> two/four channel 7-bit Sink/Source Current DAC.
> 
> The driver supports device tree and platform files for the configurations.

So silly question to start things off.  Do you actually have users for this
who are using platform data still?  If not there is no obligation at all
to provide platform data configuration.  If you do then it's fine to provide
support.

> 
> Datasheet publicly available at:
> https://datasheets.maximintegrated.com/en/ds/DS4422-DS4424.pdf
> 
> Signed-off-by: Ismail Kose <Ismail.Kose@maximintegrated.com>
> ---

This is version 2 of the driver? So should have [PATCH V2] at the
start of the subject and a revision history here under the cut line
but above the stats.

>  drivers/iio/dac/Kconfig        |   9 +
>  drivers/iio/dac/Makefile       |   1 +
>  drivers/iio/dac/ds4424.c       | 476 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/dac/ds4424.h |  24 +++

Given this is platform data only, it now belongs in /include/linux/platform_data.
(a change that occurred a few years back)

>  4 files changed, 510 insertions(+)
>  create mode 100644 drivers/iio/dac/ds4424.c
>  create mode 100644 include/linux/iio/dac/ds4424.h
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 25bed2d7d2b9..db6ceba1c76f 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -310,4 +310,13 @@ config VF610_DAC
>  	  This driver can also be built as a module. If so, the module will
>  	  be called vf610_dac.
>  
> +config DS4424
> +	tristate "Maxim Integrated DS4422/DS4424 DAC driver"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for Maxim chips DS4422, DS4424.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called ds4424.
> +
>  endmenu
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 603587cc2f07..f29f929a0587 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -33,3 +33,4 @@ obj-$(CONFIG_MCP4922) += mcp4922.o
>  obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
>  obj-$(CONFIG_STM32_DAC) += stm32-dac.o
>  obj-$(CONFIG_VF610_DAC) += vf610_dac.o
> +obj-$(CONFIG_DS4424) += ds4424.o
> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> new file mode 100644
> index 000000000000..8765bf20ab62
> --- /dev/null
> +++ b/drivers/iio/dac/ds4424.c
> @@ -0,0 +1,476 @@
> +/*
> + * Maxim Integrated
> + * 7-bit, Multi-Channel Sink/Source Current DAC Driver
> + * Copyright (C) 2017 Maxim Integrated
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/dac/ds4424.h>
> +
> +#define DS4424_DAC_ADDR(chan)   ((chan) + 0xf8)
> +#define DS4424_SOURCE_I		1
> +#define DS4424_SINK_I		0
> +
> +#define DS4424_CHANNEL(chan) { \
> +	.type = IIO_CURRENT, \
> +	.indexed = 1, \
> +	.output = 1, \
> +	.channel = chan, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET), \
> +	.address = DS4424_DAC_ADDR(chan), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 8, \
> +		.storagebits = 8, \
> +		}, \
> +}
> +
> +union ds4424_raw_data {
> +	struct {
> +		u8 dx:7;
> +		u8 source_bit:1;  /* 1 is source, 0 is sink */
> +	};
> +	u8 bits;
> +};
> +
> +enum ds4424_device_ids {
> +	ID_DS4422,
> +	ID_DS4424,
> +};
> +
> +struct ds4424_data {
> +	struct i2c_client *client;
> +	struct mutex lock;
> +	uint16_t raw[DS4424_MAX_DAC_CHANNELS];
> +	__maybe_unused uint16_t save[DS4424_MAX_DAC_CHANNELS];
> +	uint32_t rfs_res[DS4424_MAX_DAC_CHANNELS];
> +	struct regulator *vcc_reg;
> +};
> +
> +static struct iio_map ds4424_iio_maps[] = {
> +	{	.consumer_dev_name = "ds4424_dac-consumer-dev_name-1",
> +		.consumer_channel = "ds4424_dac1",
> +		.adc_channel_label = "OUT1"
> +	},
> +	{
> +		.consumer_dev_name = "ds4424_dac-consumer-dev_name-2",
> +		.consumer_channel = "ds4424_dac2",
> +		.adc_channel_label = "OUT2"
> +	},
> +	{
> +		.consumer_dev_name = "ds4424_dac-consumer-dev_name-3",
> +		.consumer_channel = "ds4424_dac3",
> +		.adc_channel_label = "OUT3"
> +	},
> +	{
> +		.consumer_dev_name = "ds4424_dac-consumer-dev_name-4",
> +		.consumer_channel = "ds4424_dac4",
> +		.adc_channel_label = "OUT4"
> +	},
> +	{ },

This doesn't belong in the driver at all.  Could you describe what the
intent of this map is?

> +};
> +
> +
> +static const struct ds4424_pdata ds4424_pdata = {
> +	.rfs_res = {400, 800, 1000, 1600},
> +	.dac_iio_map = ds4424_iio_maps,
> +};
> +
> +static const struct iio_chan_spec ds4424_channels[] = {
> +	DS4424_CHANNEL(0),
> +	DS4424_CHANNEL(1),
> +	DS4424_CHANNEL(2),
> +	DS4424_CHANNEL(3),
> +};
> +
> +static int ds4424_get_value(struct iio_dev *indio_dev,
> +			     int *val, int channel)
> +{
> +	struct ds4424_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_write_byte_data(data->client,
> +			DS4424_DAC_ADDR(channel), 1);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, 1);
> +	if (ret < 0)
> +		goto fail;
> +
> +	*val = ret;
> +	mutex_unlock(&data->lock);
> +	return 0;
> +
> +fail:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
> +/*
> + * DS4424 DAC control register 8 bits
> + * [7]		0: to sink; 1: to source
> + * [6:0]	steps to sink/source
> + * bit[7] looks like a sign bit, but the value of the register is
> + * not a complemental code considering the bit[6:0] is a absolute
> + * distance from the zero point.
> + */
> +
> +/*
> + * val is positive if sourcing
> + *  val is negative if sinking
> + *  val can be -127 to 127
> + */
> +static int ds4424_set_value(struct iio_dev *indio_dev,
> +			     int val, struct iio_chan_spec const *chan)
> +{
> +	struct ds4424_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (val < 0 || val > U8_MAX)
> +		return -EINVAL;
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_write_byte_data(data->client,
> +			DS4424_DAC_ADDR(chan->channel), val);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	data->raw[chan->channel] = val;
> +	mutex_unlock(&data->lock);
> +
> +	return 0;
> +}
> +
> +static int ds4424_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	union ds4424_raw_data raw;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ds4424_get_value(indio_dev, val, chan->channel);
> +		if (ret < 0) {
> +			pr_err("%s : ds4424_get_value returned %d\n",
> +							__func__, ret);
> +			return ret;
> +		}
> +		raw.bits = *val;
> +		*val = raw.dx;
> +		if (raw.source_bit == DS4424_SINK_I)
> +			*val = -*val;
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ds4424_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	union ds4424_raw_data raw;
> +
> +	if (val2 != 0)
> +		return -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +
> +		if (val > S8_MAX || val < S8_MIN)
> +			return -EINVAL;
> +
> +		if (val > 0) {
> +			raw.source_bit = DS4424_SOURCE_I;
> +			raw.dx = val;
> +		} else {
> +			raw.source_bit = DS4424_SINK_I;
> +			raw.dx = -val;
> +		}
> +
> +		return ds4424_set_value(indio_dev, raw.bits, chan);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ds4424_verify_chip(struct iio_dev *indio_dev)
> +{
> +	int ret = 0, val;
> +
> +	ret = ds4424_get_value(indio_dev, &val, DS4424_DAC_ADDR(0));
> +	if (ret < 0)
> +		dev_err(&indio_dev->dev,
> +				"ds4424 i2c read failed. ret: %d\n", ret);

The error message could more informative of 'what read' failed.
Either that or get rid of it entirely as it provides very little information.
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused ds4424_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ds4424_data *data = iio_priv(indio_dev);
> +	int ret = 0;
> +	u32 i;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		data->save[i] = data->raw[i];
> +		ret = ds4424_set_value(indio_dev, 0,
> +				&indio_dev->channels[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return ret;
> +}
> +
> +static int __maybe_unused ds4424_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ds4424_data *data = iio_priv(indio_dev);
> +	int ret = 0;
> +	u32 i;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		ret = ds4424_set_value(indio_dev, data->save[i],
> +				&indio_dev->channels[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend, ds4424_resume);
> +
> +static const struct iio_info ds4424_info = {
> +	.read_raw = ds4424_read_raw,
> +	.write_raw = ds4424_write_raw,
> +	.driver_module = THIS_MODULE,

Specifying .driver_module is now handled by some macro magic.
Don't worry about this though, I'll just fix it up when applying
(this cycle) as the code for that change is only in my branches for
the next cycle.

> +};
> +
> +#ifdef CONFIG_OF
> +static int ds4424_parse_dt(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	int len;
> +	int count;
> +	struct property *prop;
> +	struct ds4424_data *data = iio_priv(indio_dev);
> +	struct device_node *node = indio_dev->dev.of_node;
> +
> +	if (!node) {
> +		pr_info("%s:%d ds4424 DT not found\n", __func__, __LINE__);
> +		return -ENODEV;
> +	}
> +
> +	prop = of_find_property(node, "maxim,rfs-resistors-ohms", &len);

This binding needs documenting.  Given you had documentation in v1 it is
a little surprising not to see it here.

> +	if (!prop) {
> +		pr_err("ds4424 maxim,rfs-resistor not found in DT.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len != (DS4424_MAX_DAC_CHANNELS * sizeof(uint32_t))) {
> +		pr_err("ds4424 maxim,rfs-resistor length in DT not valid.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32_array(node, "maxim,rfs-resistors-ohms",
> +				 data->rfs_res, DS4424_MAX_DAC_CHANNELS);
> +	if (ret < 0) {
> +		pr_err("ds4424 reading maxim,rfs-resistors from DT failed.\n");
> +		return ret;
> +	}
> +
> +	pr_info("ds4424 maxim,rfs-resistors: %d, %d, %d, %d\n",
> +			data->rfs_res[0], data->rfs_res[1],
> +			data->rfs_res[2], data->rfs_res[3]);
> +
> +	count = of_property_count_strings(node, "maxim,dac-iio-map");
> +	if (count < 0) {
> +		pr_info("ds4424 maxim,dac-iio-map not found in DT\n");
> +		return count;
> +	}
> +
> +	if (count != DS4424_MAX_DAC_CHANNELS * 3 &&
> +		count != DS4424_MAX_DAC_CHANNELS * 3) {
> +		pr_info("ds4424 maxim,dac-iio-map in DT not valid.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int ds4424_parse_dt(struct iio_dev *indio_dev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +static int ds4424_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	const struct ds4424_pdata *pdata;
> +	struct ds4424_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "iio dev alloc failed.\n");
> +		return -ENOMEM;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	indio_dev->name = id->name;
> +	indio_dev->dev.of_node = client->dev.of_node;
> +	indio_dev->dev.parent = &client->dev;
> +
> +	if (client->dev.of_node) {
> +		indio_dev->dev.of_node = client->dev.of_node;
> +		ret = ds4424_parse_dt(indio_dev);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +					"%s - of_node error\n", __func__);
> +			return -EINVAL;
> +		}
> +	} else {
> +		pdata = client->dev.platform_data;
> +		if (!pdata) {
> +			dev_err(&client->dev,
> +				"dts/platform data not found.\n");
> +			pdata = &ds4424_pdata;
> +		}
> +
> +		pdata = client->dev.platform_data;
> +		memcpy(data->rfs_res, pdata->rfs_res,
> +			sizeof(uint32_t) * DS4424_MAX_DAC_CHANNELS);
> +	}
> +
> +	data->vcc_reg = devm_regulator_get(&client->dev, "vcc");
> +	if (IS_ERR(data->vcc_reg)) {
> +		ret = PTR_ERR(data->vcc_reg);
> +		dev_err(&client->dev,
> +			"Failed to get vcc-supply regulator: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&data->lock);
> +	ret = regulator_enable(data->vcc_reg);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +				"Unable to enable the regulator.\n");
> +		return ret;
> +	}
> +
> +	usleep_range(1000, 1200);
> +	ret = ds4424_verify_chip(indio_dev);
> +	if (ret < 0)
> +		return -ENXIO;
> +
> +	switch (id->driver_data) {
> +	case ID_DS4422:
> +		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
> +		break;
> +	case ID_DS4424:
> +		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
> +		break;
> +	default:
> +		dev_err(&client->dev,
> +				"ds4424: Invalid chip id.\n");
> +		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;

I would fault out here rather than effectively guessing..  The configuration
is inconsistent so we shouldn't just try to carry on.

> +		break;
> +	}
> +
> +	indio_dev->channels = ds4424_channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ds4424_info;
> +
> +	ret = iio_map_array_register(indio_dev, ds4424_pdata.dac_iio_map);
> +	if (ret < 0)
> +		goto err_iio_map_register;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +				"iio_device_register failed. ret: %d\n", ret);
> +		goto err_iio_dev_register;
> +	}
> +
> +	return ret;
> +
> +err_iio_map_register:
> +	regulator_disable(data->vcc_reg);
> +
> +err_iio_dev_register:
> +	iio_map_array_unregister(indio_dev);
> +	return ret;
> +}
> +
> +static int ds4424_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ds4424_data *data = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_map_array_unregister(indio_dev);
> +	regulator_disable(data->vcc_reg);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ds4424_id[] = {
> +	{ "ds4422", ID_DS4422 },
> +	{ "ds4424", ID_DS4424 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ds4424_id);
> +
> +static const struct of_device_id ds4424_of_match[] = {
> +	{ .compatible = "maxim,ds4422" },
> +	{ .compatible = "maxim,ds4424" },
> +	{ }
> +};
> +

For consistency don't have a blank line here.

> +MODULE_DEVICE_TABLE(of, ds4424_of_match);
> +
> +static struct i2c_driver ds4424_driver = {
> +	.driver = {
> +		.name	= "ds4424",
> +		.of_match_table = ds4424_of_match,
> +		.pm     = &ds4424_pm_ops,
> +	},
> +	.probe		= ds4424_probe,
> +	.remove		= ds4424_remove,
> +	.id_table	= ds4424_id,
> +};
> +module_i2c_driver(ds4424_driver);
> +
> +MODULE_DESCRIPTION("Maxim DS4424 DAC Driver");
> +MODULE_AUTHOR("Ismail H. Kose <ismail.kose@maximintegrated.com>");
> +MODULE_AUTHOR("Vishal Sood <vishal.sood@maximintegrated.com>");
> +MODULE_AUTHOR("David Jung <david.jung@maximintegrated.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/iio/dac/ds4424.h b/include/linux/iio/dac/ds4424.h
> new file mode 100644
> index 000000000000..2c814118df38
> --- /dev/null
> +++ b/include/linux/iio/dac/ds4424.h
> @@ -0,0 +1,24 @@
> +/*
> + * Maxim Integrated
> + * 7-bit, Multi-Channel Sink/Source Current DAC Driver
> + * Copyright (C) 2017 Maxim Integrated
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef IIO_DAC_DS4424_H_
> +#define IIO_DAC_DS4424_H_
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +
> +#define DS4422_MAX_DAC_CHANNELS		2
> +#define DS4424_MAX_DAC_CHANNELS		4
> +
> +struct ds4424_pdata {
> +	const char *vcc_supply_name;
> +	uint32_t rfs_res[DS4424_MAX_DAC_CHANNELS];
> +	struct iio_map *dac_iio_map;
> +};
> +#endif /* IIO_DAC_DS4424_H_ */

