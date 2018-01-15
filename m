Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:41059 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753698AbeAOIhl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Jan 2018 03:37:41 -0500
Subject: Re: [PATCH 2/2] iio: ad5272: Add support for Analog Devices digital
 potentiometers
To: alexandru.ardelean@analog.com, linux-iio@vger.kernel.org
References: <1515565051-72535-3-git-send-email-preid@electromag.com.au>
 <20180112104214.11614-1-alexandru.ardelean@analog.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <8fdbb426-8cef-7c1f-9c71-63e47f75bf11@electromag.com.au>
Date: Mon, 15 Jan 2018 16:37:38 +0800
MIME-Version: 1.0
In-Reply-To: <20180112104214.11614-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/01/2018 18:42, alexandru.ardelean@analog.com wrote:
> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> On 10/01/2018 14:17, Phil Reid wrote:
>> Add implementation for Analog Devices AD5272 and AD5274 digital
>> potentiometer devices.
>>
> 
> Hey,
> 
> Thanks for the patch.
> Replies inline

Thanks for reviewing.
> 
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>    drivers/iio/potentiometer/Kconfig  |  10 ++
>>    drivers/iio/potentiometer/Makefile |   1 +
>>    drivers/iio/potentiometer/ad5272.c | 219 +++++++++++++++++++++++++++++++++++++
>>    3 files changed, 230 insertions(+)
>>    create mode 100644 drivers/iio/potentiometer/ad5272.c
>>
>> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
>> index 8bf2825..0b04063 100644
>> --- a/drivers/iio/potentiometer/Kconfig
>> +++ b/drivers/iio/potentiometer/Kconfig
>> @@ -5,6 +5,16 @@
>>    
>>    menu "Digital potentiometers"
>>    
>> +config AD5272
>> +	tristate "Analog Devices AD5272 Digital Potentiometer driver"
>> +	depends on I2C
>> +	help
>> +	  Say yes here to build support for the Analog Devices AD5272
>> +	  digital potentiometer chip.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called ad5272.
>> +
>>    config DS1803
>>    	tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
>>    	depends on I2C
>> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
>> index 2260d40..498bbb8 100644
>> --- a/drivers/iio/potentiometer/Makefile
>> +++ b/drivers/iio/potentiometer/Makefile
>> @@ -3,6 +3,7 @@
>>    #
>>    
>>    # When adding new entries keep the list in alphabetical order
>> +obj-$(CONFIG_AD5272) += ad5272.o
>>    obj-$(CONFIG_DS1803) += ds1803.o
>>    obj-$(CONFIG_MAX5481) += max5481.o
>>    obj-$(CONFIG_MAX5487) += max5487.o
>> diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
>> new file mode 100644
>> index 0000000..b9208c2
>> --- /dev/null
>> +++ b/drivers/iio/potentiometer/ad5272.c
>> @@ -0,0 +1,219 @@
>> +/*
>> + * Analog Devices AD5372 digital potentiometer driver
>> + * Copyright (C) 2018 Phil Reid <preid@electromag.com.au>
>> + *
>> + * Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/AD5272_5274.pdf
>> + *
>> + * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
>> + * ad5272	1	1024		20, 50, 100		01011xx
>> + * ad5274	1	256		20, 100			01011xx
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + */
>> +
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/i2c.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/module.h>
>> +
>> +#define  AD5272_RDAC_WR  1
>> +#define  AD5272_RDAC_RD  2
>> +#define  AD5272_CTL      7
>> +
>> +#define  AD5272_RDAC_WR_EN  BIT(1)
>> +
>> +struct ad5272_cfg {
>> +	int max_pos;
>> +	int kohms;
>> +	int shift;
>> +};
>> +
>> +enum ad5272_type {
>> +	AD5272_020,
>> +	AD5272_050,
>> +	AD5272_100,
>> +	AD5274_020,
>> +	AD5274_100,
>> +};
>> +
>> +static const struct ad5272_cfg ad5272_cfg[] = {
>> +	/* on-semiconductor parts */
>> +	[AD5272_020] = { .max_pos = 1024, .kohms = 20 },
>> +	[AD5272_050] = { .max_pos = 1024, .kohms = 50 },
>> +	[AD5272_100] = { .max_pos = 1024, .kohms = 100 },
>> +	[AD5274_020] = { .max_pos = 256,  .kohms = 20,  .shift = 2 },
>> +	[AD5274_100] = { .max_pos = 256,  .kohms = 100, .shift = 2 },
>> +};
>> +
>> +struct ad5272_data {
>> +	struct i2c_client       *client;
>> +	struct mutex            lock;
>> +	const struct ad5272_cfg *cfg;
>> +};
>> +
>> +static const struct iio_chan_spec ad5272_channel = {
>> +	.type = IIO_RESISTANCE,
>> +	.output = 1,
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>> +};
>> +
>> +static int ad5272_write(struct ad5272_data *data, int reg, int val)
>> +{
>> +	u8 buf[2];
>> +	int ret;
>> +
>> +	buf[0] = ((reg & 0xf) << 2) | ((val >> 8) & 0x3);
>> +	buf[1] = (u8)val;
> 
> Maybe this should be masked with 0xff, to avoid any potential
> side-effects of downcasting.
> So, buf[1] = (u8)(0xff & val).
> 
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = i2c_master_send(data->client, buf, 2);
> 
> More of a preference from me.
> But, I'd use sizeof(buf) instead of value '2'.
> Same comment for other similar cases.

Ok , Jonathan also like that way.

> 
>> +	mutex_unlock(&data->lock);
>> +	return ret < 0 ? ret : 0;
>> +}
>> +
>> +static int ad5272_read(struct ad5272_data *data, int reg, int *val)
>> +{
>> +	u8 buf[2];
>> +	int ret;
>> +
>> +	buf[0] = (reg & 0xf) << 2;
>> +	buf[1] = 0;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = i2c_master_send(data->client, buf, 2);
>> +	if (ret < 0)
>> +		goto error;
>> +
>> +	ret = i2c_master_recv(data->client, buf, 2);
>> +	if (ret < 0)
>> +		goto error;
>> +
>> +	*val = ((buf[0] & 0x3) << 8) | buf[1];
>> +	ret = 0;
>> +error:
>> +	mutex_unlock(&data->lock);
>> +	return ret;
>> +}
>> +
>> +static int ad5272_read_raw(struct iio_dev *indio_dev,
>> +			   struct iio_chan_spec const *chan,
>> +			   int *val, int *val2, long mask)
>> +{
>> +	struct ad5272_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW: {
>> +		ret = ad5272_read(data, AD5272_RDAC_RD, val);
>> +		*val = *val >> data->cfg->shift;
>> +		return ret ? ret : IIO_VAL_INT;
>> +	}
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = 1000 * data->cfg->kohms;
>> +		*val2 = data->cfg->max_pos;
>> +		return IIO_VAL_FRACTIONAL;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int ad5272_write_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int val, int val2, long mask)
>> +{
>> +	struct ad5272_data *data = iio_priv(indio_dev);
>> +
>> +	if (mask != IIO_CHAN_INFO_RAW)
>> +		return -EINVAL;
>> +
>> +	if (val >= data->cfg->max_pos || val < 0)
>> +		return -EINVAL;
>> +
>> +	val = val << data->cfg->shift;
>> +
>> +	return ad5272_write(data, AD5272_RDAC_WR, val);
>> +}
>> +
>> +static const struct iio_info ad5272_info = {
>> +	.read_raw = ad5272_read_raw,
>> +	.write_raw = ad5272_write_raw,
>> +	.driver_module = THIS_MODULE,
>> +};
>> +
>> +static int ad5272_probe(struct i2c_client *client,
>> +			const struct i2c_device_id *id)
>> +{
>> +	struct device *dev = &client->dev;
>> +	struct gpio_desc *reset_gpio;
>> +	struct iio_dev *indio_dev;
>> +	struct ad5272_data *data;
>> +	int ret;
>> +
>> +	reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
>> +		GPIOD_OUT_LOW);
>> +	if (IS_ERR(reset_gpio))
>> +		return PTR_ERR(reset_gpio);
> 
> I think this may also need some more logic to perform a reset.
> Maybe setting the value with `gpiod_set_value(reset_gpio, 1)`
> Also, if `reset_gpio` is NULL, you could issue a software reset
> with command 4.
> 
> Something similar is done in `ad5592r-base.c`

Ok, that looks like a good approach.


> 
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(client, indio_dev);
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->client = client;
>> +	mutex_init(&data->lock);
>> +	data->cfg = &ad5272_cfg[id->driver_data];
>> +
>> +	ret = ad5272_write(data, AD5272_CTL, AD5272_RDAC_WR_EN);
>> +	if (ret < 0)
>> +		return -ENODEV;
>> +
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->info = &ad5272_info;
>> +	indio_dev->channels = &ad5272_channel;
>> +	indio_dev->num_channels = 1;
>> +	indio_dev->name = client->name;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id ad5272_dt_ids[] = {
>> +	{ .compatible = "adi,ad5272-020", .data = &ad5272_cfg[AD5272_020] },
>> +	{ .compatible = "adi,ad5272-050", .data = &ad5272_cfg[AD5272_050] },
>> +	{ .compatible = "adi,ad5272-100", .data = &ad5272_cfg[AD5272_100] },
>> +	{ .compatible = "adi,ad5274-020", .data = &ad5272_cfg[AD5274_020] },
>> +	{ .compatible = "adi,ad5274-100", .data = &ad5272_cfg[AD5274_100] },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, ad5272_dt_ids);
>> +#endif /* CONFIG_OF */
>> +
>> +static const struct i2c_device_id ad5272_id[] = {
>> +	{ "ad5272-020", AD5272_020 },
>> +	{ "ad5272-050", AD5272_050 },
>> +	{ "ad5272-100", AD5272_100 },
>> +	{ "ad5274-020", AD5274_020 },
>> +	{ "ad5274-100", AD5274_100 },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ad5272_id);
>> +
>> +static struct i2c_driver ad5272_driver = {
>> +	.driver = {
>> +		.name	= "ad5272",
>> +		.of_match_table = of_match_ptr(ad5272_dt_ids),
>> +	},
>> +	.probe		= ad5272_probe,
>> +	.id_table	= ad5272_id,
>> +};
>> +
>> +module_i2c_driver(ad5272_driver);
>> +
>> +MODULE_AUTHOR("Phil Reid <preid@eletromag.com.au>");
>> +MODULE_DESCRIPTION("AD5272 digital potentiometer");
>> +MODULE_LICENSE("GPL v2");
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
