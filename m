Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755643AbeATPZd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 Jan 2018 10:25:33 -0500
Date: Sat, 20 Jan 2018 15:25:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Phil Reid <preid@electromag.com.au>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: ad5272: Add support for Analog Devices digital
 potentiometers
Message-ID: <20180120152528.3b9836cf@archlinux>
In-Reply-To: <7e5f624d-35a4-20a9-337d-8593542630f8@electromag.com.au>
References: <1515565051-72535-1-git-send-email-preid@electromag.com.au>
        <1515565051-72535-3-git-send-email-preid@electromag.com.au>
        <20180114133953.2d2b7491@archlinux>
        <7e5f624d-35a4-20a9-337d-8593542630f8@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 15 Jan 2018 16:47:35 +0800
Phil Reid <preid@electromag.com.au> wrote:

> G'day Jonathan,
> 
> On 14/01/2018 21:39, Jonathan Cameron wrote:
> > On Wed, 10 Jan 2018 14:17:31 +0800
> > Phil Reid <preid@electromag.com.au> wrote:
> >   
> >> Add implementation for Analog Devices AD5272 and AD5274 digital
> >> potentiometer devices.
> >>
> >> Signed-off-by: Phil Reid <preid@electromag.com.au>  
> > 
> > Hi Phil,
> > 
> > A few minor comments inline, but looking pretty good.  
> 
> Thanks for the review.
> 
> > 
> > Jonathan
> >   
> >> ---
> >>   drivers/iio/potentiometer/Kconfig  |  10 ++
> >>   drivers/iio/potentiometer/Makefile |   1 +
> >>   drivers/iio/potentiometer/ad5272.c | 219 +++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 230 insertions(+)
> >>   create mode 100644 drivers/iio/potentiometer/ad5272.c
> >>
> >> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> >> index 8bf2825..0b04063 100644
> >> --- a/drivers/iio/potentiometer/Kconfig
> >> +++ b/drivers/iio/potentiometer/Kconfig
> >> @@ -5,6 +5,16 @@
> >>   
> >>   menu "Digital potentiometers"
> >>   
> >> +config AD5272
> >> +	tristate "Analog Devices AD5272 Digital Potentiometer driver"
> >> +	depends on I2C
> >> +	help
> >> +	  Say yes here to build support for the Analog Devices AD5272
> >> +	  digital potentiometer chip.
> >> +
> >> +	  To compile this driver as a module, choose M here: the
> >> +	  module will be called ad5272.
> >> +
> >>   config DS1803
> >>   	tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
> >>   	depends on I2C
> >> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> >> index 2260d40..498bbb8 100644
> >> --- a/drivers/iio/potentiometer/Makefile
> >> +++ b/drivers/iio/potentiometer/Makefile
> >> @@ -3,6 +3,7 @@
> >>   #
> >>   
> >>   # When adding new entries keep the list in alphabetical order
> >> +obj-$(CONFIG_AD5272) += ad5272.o
> >>   obj-$(CONFIG_DS1803) += ds1803.o
> >>   obj-$(CONFIG_MAX5481) += max5481.o
> >>   obj-$(CONFIG_MAX5487) += max5487.o
> >> diff --git a/drivers/iio/potentiometer/ad5272.c b/drivers/iio/potentiometer/ad5272.c
> >> new file mode 100644
> >> index 0000000..b9208c2
> >> --- /dev/null
> >> +++ b/drivers/iio/potentiometer/ad5272.c
> >> @@ -0,0 +1,219 @@
> >> +/*
> >> + * Analog Devices AD5372 digital potentiometer driver
> >> + * Copyright (C) 2018 Phil Reid <preid@electromag.com.au>
> >> + *
> >> + * Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/AD5272_5274.pdf
> >> + *
> >> + * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
> >> + * ad5272	1	1024		20, 50, 100		01011xx
> >> + * ad5274	1	256		20, 100			01011xx
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify it
> >> + * under the terms of the GNU General Public License version 2 as published by
> >> + * the Free Software Foundation.  
> > 
> > Could go all SPDX with the gpl part of this.  Personally I don't mind
> > much but we'll probably end up converting it over soon anyway.
> >   
> >> + */
> >> +
> >> +#include <linux/gpio/consumer.h>
> >> +#include <linux/i2c.h>
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/module.h>
> >> +
> >> +#define  AD5272_RDAC_WR  1
> >> +#define  AD5272_RDAC_RD  2
> >> +#define  AD5272_CTL      7
> >> +
> >> +#define  AD5272_RDAC_WR_EN  BIT(1)
> >> +
> >> +struct ad5272_cfg {
> >> +	int max_pos;
> >> +	int kohms;
> >> +	int shift;
> >> +};
> >> +
> >> +enum ad5272_type {
> >> +	AD5272_020,
> >> +	AD5272_050,
> >> +	AD5272_100,
> >> +	AD5274_020,
> >> +	AD5274_100,
> >> +};
> >> +
> >> +static const struct ad5272_cfg ad5272_cfg[] = {
> >> +	/* on-semiconductor parts */
> >> +	[AD5272_020] = { .max_pos = 1024, .kohms = 20 },
> >> +	[AD5272_050] = { .max_pos = 1024, .kohms = 50 },
> >> +	[AD5272_100] = { .max_pos = 1024, .kohms = 100 },
> >> +	[AD5274_020] = { .max_pos = 256,  .kohms = 20,  .shift = 2 },
> >> +	[AD5274_100] = { .max_pos = 256,  .kohms = 100, .shift = 2 },
> >> +};
> >> +
> >> +struct ad5272_data {
> >> +	struct i2c_client       *client;
> >> +	struct mutex            lock;
> >> +	const struct ad5272_cfg *cfg;
> >> +};
> >> +
> >> +static const struct iio_chan_spec ad5272_channel = {
> >> +	.type = IIO_RESISTANCE,
> >> +	.output = 1,
> >> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> >> +};
> >> +
> >> +static int ad5272_write(struct ad5272_data *data, int reg, int val)
> >> +{
> >> +	u8 buf[2];
> >> +	int ret;
> >> +
> >> +	buf[0] = ((reg & 0xf) << 2) | ((val >> 8) & 0x3);
> >> +	buf[1] = (u8)val;  
> > 
> > again, could do as buf[2]  = {...};  
> ok
> >   
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	ret = i2c_master_send(data->client, buf, 2);  
> > 
> > sizeof(buf) preferred.  
> ok
> >   
> >> +	mutex_unlock(&data->lock);
> >> +	return ret < 0 ? ret : 0;
> >> +}
> >> +
> >> +static int ad5272_read(struct ad5272_data *data, int reg, int *val)
> >> +{
> >> +	u8 buf[2];  
> > 
> > Could assign value here for compactness.
> > 	u8 buf[2] = {(reg & 0xf) << 2, 0) >
> > It's a little paranoid to mask reg given you are controlling it entirely
> > in the driver and anything of more than 4 bits is a bug anyway.  
> ok
> 
> >> +	int ret;
> >> +
> >> +	buf[0] = (reg & 0xf) << 2;
> >> +	buf[1] = 0;
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	ret = i2c_master_send(data->client, buf, 2);
> >> +	if (ret < 0)
> >> +		goto error;
> >> +
> >> +	ret = i2c_master_recv(data->client, buf, 2);
> >> +	if (ret < 0)
> >> +		goto error;
> >> +
> >> +	*val = ((buf[0] & 0x3) << 8) | buf[1];
> >> +	ret = 0;
> >> +error:
> >> +	mutex_unlock(&data->lock);
> >> +	return ret;
> >> +}
> >> +
> >> +static int ad5272_read_raw(struct iio_dev *indio_dev,
> >> +			   struct iio_chan_spec const *chan,
> >> +			   int *val, int *val2, long mask)
> >> +{
> >> +	struct ad5272_data *data = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW: {
> >> +		ret = ad5272_read(data, AD5272_RDAC_RD, val);
> >> +		*val = *val >> data->cfg->shift;
> >> +		return ret ? ret : IIO_VAL_INT;
> >> +	}
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		*val = 1000 * data->cfg->kohms;
> >> +		*val2 = data->cfg->max_pos;
> >> +		return IIO_VAL_FRACTIONAL;
> >> +	}
> >> +
> >> +	return -EINVAL;
> >> +}
> >> +
> >> +static int ad5272_write_raw(struct iio_dev *indio_dev,
> >> +			    struct iio_chan_spec const *chan,
> >> +			    int val, int val2, long mask)
> >> +{
> >> +	struct ad5272_data *data = iio_priv(indio_dev);
> >> +
> >> +	if (mask != IIO_CHAN_INFO_RAW)
> >> +		return -EINVAL;
> >> +
> >> +	if (val >= data->cfg->max_pos || val < 0)
> >> +		return -EINVAL;  
> > 
> > Also verify that val2 = 0 as otherwise the classic
> > 1.999999 evaluates to 1 rather surprises users.  
> yeap, that'd surprise me too.
> 
> >   
> >> +
> >> +	val = val << data->cfg->shift;  
> > 
> > I would role this into the next line.  
> ok
> 
> > 
> > 	return ad5272_write(data, AD5272_RDAC_WR, val << data->cfg->shift);  
> >> +
> >> +	return ad5272_write(data, AD5272_RDAC_WR, val);
> >> +}
> >> +
> >> +static const struct iio_info ad5272_info = {
> >> +	.read_raw = ad5272_read_raw,
> >> +	.write_raw = ad5272_write_raw,
> >> +	.driver_module = THIS_MODULE,  
> > 
> > .driver_module no longer exists so just drop this.
> > We do the equivalent with some macro tricks to avoid having
> > to have this same line in every driver.  
> ok
> 
> >   
> >> +};
> >> +
> >> +static int ad5272_probe(struct i2c_client *client,
> >> +			const struct i2c_device_id *id)
> >> +{
> >> +	struct device *dev = &client->dev;
> >> +	struct gpio_desc *reset_gpio;
> >> +	struct iio_dev *indio_dev;
> >> +	struct ad5272_data *data;
> >> +	int ret;
> >> +
> >> +	reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> >> +		GPIOD_OUT_LOW);
> >> +	if (IS_ERR(reset_gpio))
> >> +		return PTR_ERR(reset_gpio);
> >> +
> >> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> >> +	if (!indio_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	i2c_set_clientdata(client, indio_dev);
> >> +
> >> +	data = iio_priv(indio_dev);
> >> +	data->client = client;
> >> +	mutex_init(&data->lock);
> >> +	data->cfg = &ad5272_cfg[id->driver_data];  
> > 
> > Calling it cfg kind of implies config to me whereas this is
> > chip type specific data.  
> I just followed what seemed to be the existing convention for the iio/potentmeters.
> ds1803, mcp4531, max5481
> 
> Happy to change.
> 
> >   
> >> +
> >> +	ret = ad5272_write(data, AD5272_CTL, AD5272_RDAC_WR_EN);
> >> +	if (ret < 0)
> >> +		return -ENODEV;
> >> +
> >> +	indio_dev->dev.parent = dev;
> >> +	indio_dev->info = &ad5272_info;
> >> +	indio_dev->channels = &ad5272_channel;
> >> +	indio_dev->num_channels = 1;
> >> +	indio_dev->name = client->name;
> >> +
> >> +	return devm_iio_device_register(dev, indio_dev);
> >> +}
> >> +
> >> +#if defined(CONFIG_OF)
> >> +static const struct of_device_id ad5272_dt_ids[] = {
> >> +	{ .compatible = "adi,ad5272-020", .data = &ad5272_cfg[AD5272_020] },  
> > 
> > Why do this rather than stash the index in the data parameter and look up later
> > (more consistent with the i2c_device_id table below)?  
> 
> Yeah I was a bit confused by this.
> I was following how the ds1803.c driver was doing things.
> To be honest I don't have a good grasp of how .data works here or how it gets referenced or if it's
> even used...
Good point - you aren't currently using it.

This gets more interesting when i2c actually starts using the
of tables for devicetree rather than the older i2c_device_id tables.

The .data field is used for the same purpose as the indexes in
the other table, but you have to explicitly request it
with of_get_match_data

Jonathan
> 
> 
> >   
> >> +	{ .compatible = "adi,ad5272-050", .data = &ad5272_cfg[AD5272_050] },
> >> +	{ .compatible = "adi,ad5272-100", .data = &ad5272_cfg[AD5272_100] },
> >> +	{ .compatible = "adi,ad5274-020", .data = &ad5272_cfg[AD5274_020] },
> >> +	{ .compatible = "adi,ad5274-100", .data = &ad5272_cfg[AD5274_100] },
> >> +	{}
> >> +};
> >> +MODULE_DEVICE_TABLE(of, ad5272_dt_ids);
> >> +#endif /* CONFIG_OF */
> >> +
> >> +static const struct i2c_device_id ad5272_id[] = {
> >> +	{ "ad5272-020", AD5272_020 },
> >> +	{ "ad5272-050", AD5272_050 },
> >> +	{ "ad5272-100", AD5272_100 },
> >> +	{ "ad5274-020", AD5274_020 },
> >> +	{ "ad5274-100", AD5274_100 },
> >> +	{}
> >> +};
> >> +MODULE_DEVICE_TABLE(i2c, ad5272_id);
> >> +
> >> +static struct i2c_driver ad5272_driver = {
> >> +	.driver = {
> >> +		.name	= "ad5272",
> >> +		.of_match_table = of_match_ptr(ad5272_dt_ids),
> >> +	},
> >> +	.probe		= ad5272_probe,
> >> +	.id_table	= ad5272_id,
> >> +};
> >> +
> >> +module_i2c_driver(ad5272_driver);
> >> +
> >> +MODULE_AUTHOR("Phil Reid <preid@eletromag.com.au>");
> >> +MODULE_DESCRIPTION("AD5272 digital potentiometer");
> >> +MODULE_LICENSE("GPL v2");  
> > 
> > 
> >   
> 
> 

