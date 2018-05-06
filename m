Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbeEFRhu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 May 2018 13:37:50 -0400
Date: Sun, 6 May 2018 18:37:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: add driver for Maxim Integrated
 DS1807
Message-ID: <20180506183745.325e67b8@archlinux>
In-Reply-To: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
References: <1525613447-32734-1-git-send-email-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  6 May 2018 15:30:47 +0200
Michael Trimarchi <michael@amarulasolutions.com> wrote:

> The following functions are supported:
> - write, read potentiometer value
> 
> Value are exported in DBm because it's used as an audio
> attenuator

This is interesting.  The problem is that there is no way for
userspace to know that it is reporting in DBm rather than
reporting a linear gain or a straight forward resistance.

This is rather closer in operation to the analog front end
driver I took the other day than to the other potentiometers
we have drivers for.

Anyhow, how to solve this?  Two options come to mind.
1) Look up table mapping to linear gain as per current ABI
2) Add a new channel type to represent the fact we are
looking at a logarithmic value, letting us handle it as DB.

Lars, this area is probably more familiar to you than it is
to me, what do you think?

Jonathan
> 
> Datasheet: https://datasheets.maximintegrated.com/en/ds/DS1807.pdf
> 
> Change-Id: I24f6b33cfa92ce16f489ff763f1df26126a1a7f2
Please remember to drop these change IDs on patches to the mailing list
They don't mean anything to us unfortunately!

> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  .../bindings/iio/potentiometer/ds1807.txt          |  17 +++
>  drivers/iio/potentiometer/Kconfig                  |  10 ++
>  drivers/iio/potentiometer/Makefile                 |   1 +
>  drivers/iio/potentiometer/ds1807.c                 | 156 +++++++++++++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ds1807.txt
>  create mode 100644 drivers/iio/potentiometer/ds1807.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/ds1807.txt b/Documentation/devicetree/bindings/iio/potentiometer/ds1807.txt
> new file mode 100644
> index 0000000..3e30f4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/ds1807.txt
> @@ -0,0 +1,17 @@
> +* Maxim Integrated DS1807 digital potentiometer driver

This might be a good candidate for the trivial-device.txt binding file.

> +
> +The node for this driver must be a child node of a I2C controller, hence
> +all mandatory properties for your controller must be specified. See directory:
> +
> +        Documentation/devicetree/bindings/i2c
> +
> +for more details.
> +
> +Required properties:
> +	- compatible: "maxim,ds1807",
> +
> +Example:
> +ds1807: ds1807@1 {
> +	reg = <0x28>;
> +	compatible = "maxim,ds1807";
> +};
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index 79ec2eb..92e5a6b 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -25,6 +25,16 @@ config DS1803
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ds1803.
>  
> +config DS1807
> +	tristate "Maxim Integrated DS1807 Digital Potentiometer driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Maxim Integrated DS1807
> +	  digital potentiometer chip. Value are reported back in DBm
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ds1807.
> +
>  config MAX5481
>          tristate "Maxim MAX5481-MAX5484 Digital Potentiometer driver"
>          depends on SPI
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> index 4af6578..3c409bb 100644
> --- a/drivers/iio/potentiometer/Makefile
> +++ b/drivers/iio/potentiometer/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD5272) += ad5272.o
>  obj-$(CONFIG_DS1803) += ds1803.o
> +obj-$(CONFIG_DS1807) += ds1807.o
>  obj-$(CONFIG_MAX5481) += max5481.o
>  obj-$(CONFIG_MAX5487) += max5487.o
>  obj-$(CONFIG_MCP4018) += mcp4018.o
> diff --git a/drivers/iio/potentiometer/ds1807.c b/drivers/iio/potentiometer/ds1807.c
> new file mode 100644
> index 0000000..acb4884
> --- /dev/null
> +++ b/drivers/iio/potentiometer/ds1807.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Maxim Integrated DS1807 digital potentiometer driver
> + * Copyright (c) 2018 Michael Trimarchi
> + *
> + * Datasheet: https://datasheets.maximintegrated.com/en/ds/DS1807.pdf
> + *
> + * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
> + * ds1807	2	65		45			0101xxx
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#define DS1807_MAX_VALUE	64
> +#define DS1807_MUTE		-90
> +#define DS1807_WRITE(chan)	(0xa8 | ((chan) + 1))
> +
> +#define DS1807_CHANNEL(ch) {					\
> +	.type = IIO_CHAN_INFO_HARDWAREGAIN,			\
> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.channel = (ch),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN),	\
> +}
> +
> +static const struct iio_chan_spec ds1807_channels[] = {
> +	DS1807_CHANNEL(0),
> +	DS1807_CHANNEL(1),
> +};
> +
> +struct ds1807_data {
> +	struct i2c_client *client;
> +};
> +
> +static int ds1807_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ds1807_data *data = iio_priv(indio_dev);
> +	int pot = chan->channel;
> +	int ret;
> +	u8 result[ARRAY_SIZE(ds1807_channels)];
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = i2c_master_recv(data->client, result,
> +				indio_dev->num_channels);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val2 = 0;
> +		if (result[pot] == DS1807_MAX_VALUE)
> +			*val = DS1807_MUTE;
> +		else
> +			*val = -result[pot];
> +
> +		return IIO_VAL_INT_PLUS_MICRO_DB;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ds1807_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ds1807_data *data = iio_priv(indio_dev);
> +	int pot = chan->channel;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		if (val2 != 0 || val < DS1807_MUTE || val > 0)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	val = (val == DS1807_MUTE) ? DS1807_MAX_VALUE : -val;
> +
> +	return i2c_smbus_write_byte_data(data->client, DS1807_WRITE(pot), val);
> +}
> +
> +static const struct iio_info ds1807_info = {
> +	.read_raw = ds1807_read_raw,
> +	.write_raw = ds1807_write_raw,
> +};
> +
> +static int ds1807_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct ds1807_data *data;
> +	struct iio_dev *indio_dev;
> +	int channel, ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &ds1807_info;
> +	indio_dev->channels = ds1807_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ds1807_channels);
> +	indio_dev->name = client->name;
> +
> +	/* reset device gain */
> +	for (channel = 0; channel < indio_dev->num_channels; channel++) {
> +		ret = i2c_smbus_write_byte_data(client, DS1807_WRITE(channel),
> +						DS1807_MUTE);
> +		if (ret < 0)
> +			return -ENODEV;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +#if defined(CONFIG_OF)
> +static const struct of_device_id ds1807_dt_ids[] = {
> +	{ .compatible = "maxim,ds1807", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ds1807_dt_ids);
> +#endif /* CONFIG_OF */
> +
> +static const struct i2c_device_id ds1807_id[] = {
> +	{ "ds1807", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ds1807_id);
> +
> +static struct i2c_driver ds1807_driver = {
> +	.driver = {
> +		.name	= "ds1807",
> +		.of_match_table = of_match_ptr(ds1807_dt_ids),
> +	},
> +	.probe		= ds1807_probe,
> +	.id_table	= ds1807_id,
> +};
> +
> +module_i2c_driver(ds1807_driver);
> +
> +MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
> +MODULE_DESCRIPTION("DS1807 digital potentiometer");
> +MODULE_LICENSE("GPL v2");

