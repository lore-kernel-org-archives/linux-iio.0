Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53542 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604AbbDIQH2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 12:07:28 -0400
Message-ID: <5526A3BC.1030200@kernel.org>
Date: Thu, 09 Apr 2015 17:07:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-iio@vger.kernel.org
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: add m62332 DAC driver
References: <1427711081-7921-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1427711081-7921-1-git-send-email-dbaryshkov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/03/15 11:24, Dmitry Eremin-Solenikov wrote:
> m62332 is a simple 2-channel DAC used on several Sharp Zaurus boards to
> control LCD voltage, backlight and sound. The driver use regulators to
> control the reference voltage and enabling/disabling the DAC.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Looks pretty good to me.  I've commented on various trivial bits in line.
There are a few types that I think should be explicit kernel types of
appropriate length rather than unsigned chars.

That's just me being really fussy though.  It's a nice compact and clean
driver. Lots of time now anyway a I'm afraid my review is too late for
the upcoming merge window...

Thanks,

Jonathan
> ---
>  drivers/iio/dac/Kconfig  |  10 ++
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/m62332.c | 236 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 247 insertions(+)
>  create mode 100644 drivers/iio/dac/m62332.c
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 2236ea2..2ede061 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -142,6 +142,16 @@ config AD7303
>  	  To compile this driver as module choose M here: the module will be called
>  	  ad7303.
>  
> +config M62332
> +	tristate "Mitsubishi M62332 DAC driver"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for the Mitsubishi M62332
> +	  (I2C 8-Bit DACs with rail-to-rail outputs).
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called m62332.
> +
>  config MAX517
>  	tristate "Maxim MAX517/518/519 DAC driver"
>  	depends on I2C
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 52be7e1..63ae056 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD5764) += ad5764.o
>  obj-$(CONFIG_AD5791) += ad5791.o
>  obj-$(CONFIG_AD5686) += ad5686.o
>  obj-$(CONFIG_AD7303) += ad7303.o
> +obj-$(CONFIG_M62332) += m62332.o
>  obj-$(CONFIG_MAX517) += max517.o
>  obj-$(CONFIG_MAX5821) += max5821.o
>  obj-$(CONFIG_MCP4725) += mcp4725.o
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> new file mode 100644
> index 0000000..90574d7
> --- /dev/null
> +++ b/drivers/iio/dac/m62332.c
> @@ -0,0 +1,236 @@
> +/*
> + *  m62332.c - Support for Mitsubishi m62332 DAC
> + *
> + *  Copyright (c) 2014 Dmitry Eremin-Solenikov
> + *
> + *  Based on max517 driver:
> + *  Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +
> +#include <linux/regulator/consumer.h>
> +
> +struct m62332_data {
> +	struct i2c_client	*client;
> +	unsigned short		vref_mv;
I'd make this an int to match the regulator_get_voltage type or an unsigned
int perhaps as we know it isn't an error value (don't ask about negative
voltage regulators ;)
> +	unsigned char		raw[2];
u8 raw[2];
> +	struct regulator	*vcc;
> +#ifdef CONFIG_PM_SLEEP
> +	unsigned char		save[2];
u8 save[2];
(yeah, I know they are the same but as we have explicit types for 8 bit
unsigned integers, yets use them).

> +#endif
> +};
> +
> +static int m62332_set_value(struct iio_dev *indio_dev,
> +	unsigned char val, int channel)
> +{
> +	struct m62332_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	u8 outbuf[2];
> +	int res = 0;
> +
> +	if (val == data->raw[channel])
> +		return 0;
> +
> +	outbuf[0] = channel;
> +	outbuf[1] = val;
> +
> +	if (val || data->raw[!channel])
> +		res = regulator_enable(data->vcc);
> +	if (res)
> +		return res;
> +
> +	res = i2c_master_send(client, outbuf, 2);
> +	if (res < 0)
> +		return res;
> +	else if (res != 2)
> +		return -EIO;
> +
> +	data->raw[channel] = val;
> +
> +	if (!data->raw[0] && !data->raw[1])
> +		regulator_disable(data->vcc);
> +
> +	return 0;
> +}
> +
> +static int m62332_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long m)
> +{
> +	struct m62332_data *data = iio_priv(indio_dev);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Corresponds to Vref / 2^(bits) */
> +		*val = data->vref_mv;
> +		*val2 = 8;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_RAW:
> +		*val = data->raw[chan->channel];
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
I'd move this into the default above and save a line.
> +	return -EINVAL;
> +}
> +
> +static int m62332_write_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int val, int val2, long mask)
There is a current fad for running checkpatch with strict which moans
about the alignment of parameters, so you may well get a follow up patch
from someone with too much time on their hands, realigning all these.
Personally I couldn't care less either way.
> +{
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val > 255)
> +			return -EINVAL;
> +
> +		ret = m62332_set_value(indio_dev, val, chan->channel);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int m62332_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct m62332_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	data->save[0] = data->raw[0];
> +	data->save[1] = data->raw[1];
> +
> +	ret = m62332_set_value(indio_dev, 0, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return m62332_set_value(indio_dev, 0, 1);
> +}
> +
> +static int m62332_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
I'd roll the two lines above into one line btu that's just
a matter of personal taste so the current version is fine.
> +	struct m62332_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = m62332_set_value(indio_dev, data->save[0], 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return m62332_set_value(indio_dev, data->save[1], 1);
> +}
> +
> +static SIMPLE_DEV_PM_OPS(m62332_pm_ops, m62332_suspend, m62332_resume);
> +#define M62332_PM_OPS (&m62332_pm_ops)
> +#else
> +#define M62332_PM_OPS NULL
> +#endif
> +
> +static const struct iio_info m62332_info = {
> +	.read_raw = m62332_read_raw,
> +	.write_raw = m62332_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +#define M62332_CHANNEL(chan) {				\
> +	.type = IIO_VOLTAGE,				\
> +	.indexed = 1,					\
> +	.output = 1,					\
> +	.channel = (chan),				\
> +	.datasheet_name = "CH" #chan,			\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +}
> +
> +static const struct iio_chan_spec m62332_channels[] = {
> +	M62332_CHANNEL(0),
> +	M62332_CHANNEL(1)
> +};
> +
> +static int m62332_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct m62332_data *data;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	data->vcc = devm_regulator_get(&client->dev, "VCC");
> +	if (IS_ERR(data->vcc))
> +		return PTR_ERR(data->vcc);
ah. Was expecting a regulator enable here, but I see you do it on
a more fine grained basis and only ensure it is on when you need it.
A nice approach.
> +
> +	/* establish that the iio_dev is a child of the i2c device */
> +	indio_dev->dev.parent = &client->dev;
> +
> +	indio_dev->num_channels = 2;
> +	indio_dev->channels = m62332_channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &m62332_info;
> +
> +	data->vref_mv = regulator_get_voltage(data->vcc) / 1000; /* mV */
> +
> +	iio_map_array_register(indio_dev, client->dev.platform_data);
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int m62332_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_map_array_unregister(indio_dev);

perhaps a blank line here.  Hmm. Perhaps we want a devm_ version
of iio_map_array_register.  Ah well job for another day.

> +	return 0;
> +}
> +
> +static const struct i2c_device_id m62332_id[] = {
> +	{ "m62332", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, m62332_id);
> +
> +static struct i2c_driver m62332_driver = {
> +	.driver = {
> +		.name	= "m62332",
> +		.pm	= M62332_PM_OPS,
> +	},
> +	.probe		= m62332_probe,
> +	.remove		= m62332_remove,
> +	.id_table	= m62332_id,
> +};
> +module_i2c_driver(m62332_driver);
> +
> +MODULE_AUTHOR("Dmitry Eremin-Solenikov");
> +MODULE_DESCRIPTION("M62332 8-bit DAC");
> +MODULE_LICENSE("GPL v2");
> 

