Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37283 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116AbbI0Pur (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 11:50:47 -0400
Subject: Re: [PATCH v6 2/2] iio: mcp4531: Driver for Microchip digital
 potentiometers
To: Peter Rosin <peda@lysator.liu.se>, linux-iio@vger.kernel.org
References: <1443018383-16578-1-git-send-email-peda@lysator.liu.se>
 <1443018383-16578-3-git-send-email-peda@lysator.liu.se>
Cc: Peter Rosin <peda@axentia.se>, Crt Mori <cmo@melexis.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Andreas Dannenberg <dannenberg@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56081053.2080209@kernel.org>
Date: Sun, 27 Sep 2015 16:50:43 +0100
MIME-Version: 1.0
In-Reply-To: <1443018383-16578-3-git-send-email-peda@lysator.liu.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/15 15:26, Peter Rosin wrote:
> From: Peter Rosin <peda@axentia.se>
> 
> Add support for Microchip digital potentiometers and rheostats
> 	MCP4531, MCP4532, MCP4551, MCP4552
> 	MCP4631, MCP4632, MCP4651, MCP4652
> 
> DEVICE   Wipers  Steps  Resistor Opts (kOhm)  i2c address
> MCP4531  1       129    5, 10, 50, 100        010111x
> MCP4532  1       129    5, 10, 50, 100        01011xx
> MCP4551  1       257    5, 10, 50, 100        010111x
> MCP4552  1       257    5, 10, 50, 100        01011xx
> MCP4631  2       129    5, 10, 50, 100        0101xxx
> MCP4632  2       129    5, 10, 50, 100        01011xx
> MCP4651  2       257    5, 10, 50, 100        0101xxx
> MCP4652  2       257    5, 10, 50, 100        01011xx
> 
> Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22096b.pdf
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

If anyone wants to add reviewed-by / acked-by then as I'll be
rebasing sometime in next few days anyway there is still time!

Jonathan
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  MAINTAINERS                         |    6 +
>  drivers/iio/Kconfig                 |    1 +
>  drivers/iio/Makefile                |    1 +
>  drivers/iio/potentiometer/Kconfig   |   20 +++
>  drivers/iio/potentiometer/Makefile  |    6 +
>  drivers/iio/potentiometer/mcp4531.c |  231 +++++++++++++++++++++++++++++++++++
>  6 files changed, 265 insertions(+)
>  create mode 100644 drivers/iio/potentiometer/Kconfig
>  create mode 100644 drivers/iio/potentiometer/Makefile
>  create mode 100644 drivers/iio/potentiometer/mcp4531.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b60e2b2369d2..27862156c7a7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6600,6 +6600,12 @@ W:	http://linuxtv.org
>  S:	Maintained
>  F:	drivers/media/radio/radio-maxiradio*
>  
> +MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVER
> +M:	Peter Rosin <peda@axentia.se>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/potentiometer/mcp4531.c
> +
>  MEDIA DRIVERS FOR RENESAS - VSP1
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 4011effe4c05..7cc87f322655 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -73,6 +73,7 @@ source "drivers/iio/orientation/Kconfig"
>  if IIO_TRIGGER
>     source "drivers/iio/trigger/Kconfig"
>  endif #IIO_TRIGGER
> +source "drivers/iio/potentiometer/Kconfig"
>  source "drivers/iio/pressure/Kconfig"
>  source "drivers/iio/proximity/Kconfig"
>  source "drivers/iio/temperature/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 698afc2d17ce..121c814e366b 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -23,6 +23,7 @@ obj-y += imu/
>  obj-y += light/
>  obj-y += magnetometer/
>  obj-y += orientation/
> +obj-y += potentiometer/
>  obj-y += pressure/
>  obj-y += proximity/
>  obj-y += temperature/
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> new file mode 100644
> index 000000000000..fd75db73e582
> --- /dev/null
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -0,0 +1,20 @@
> +#
> +# Potentiometer drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Digital potentiometers"
> +
> +config MCP4531
> +	tristate "Microchip MCP45xx/MCP46xx Digital Potentiometer driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Microchip
> +	  MCP4531, MCP4532, MCP4551, MCP4552,
> +	  MCP4631, MCP4632, MCP4651, MCP4652
> +	  digital potentiomenter chips.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mcp4531.
> +
> +endmenu
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> new file mode 100644
> index 000000000000..8afe49227012
> --- /dev/null
> +++ b/drivers/iio/potentiometer/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for industrial I/O potentiometer drivers
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_MCP4531) += mcp4531.o
> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> new file mode 100644
> index 000000000000..a3f66874ee2e
> --- /dev/null
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -0,0 +1,231 @@
> +/*
> + * Industrial I/O driver for Microchip digital potentiometers
> + * Copyright (c) 2015  Axentia Technologies AB
> + * Author: Peter Rosin <peda@axentia.se>
> + *
> + * Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22096b.pdf
> + *
> + * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)	i2c address
> + * mcp4531	1	129		5, 10, 50, 100          010111x
> + * mcp4532	1	129		5, 10, 50, 100          01011xx
> + * mcp4551	1	257		5, 10, 50, 100          010111x
> + * mcp4552	1	257		5, 10, 50, 100          01011xx
> + * mcp4631	2	129		5, 10, 50, 100          0101xxx
> + * mcp4632	2	129		5, 10, 50, 100          01011xx
> + * mcp4651	2	257		5, 10, 50, 100          0101xxx
> + * mcp4652	2	257		5, 10, 50, 100          01011xx
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +
> +#include <linux/iio/iio.h>
> +
> +struct mcp4531_cfg {
> +	int wipers;
> +	int max_pos;
> +	int kohms;
> +};
> +
> +enum mcp4531_type {
> +	MCP453x_502,
> +	MCP453x_103,
> +	MCP453x_503,
> +	MCP453x_104,
> +	MCP455x_502,
> +	MCP455x_103,
> +	MCP455x_503,
> +	MCP455x_104,
> +	MCP463x_502,
> +	MCP463x_103,
> +	MCP463x_503,
> +	MCP463x_104,
> +	MCP465x_502,
> +	MCP465x_103,
> +	MCP465x_503,
> +	MCP465x_104,
> +};
> +
> +static const struct mcp4531_cfg mcp4531_cfg[] = {
> +	[MCP453x_502] = { .wipers = 1, .max_pos = 128, .kohms =   5, },
> +	[MCP453x_103] = { .wipers = 1, .max_pos = 128, .kohms =  10, },
> +	[MCP453x_503] = { .wipers = 1, .max_pos = 128, .kohms =  50, },
> +	[MCP453x_104] = { .wipers = 1, .max_pos = 128, .kohms = 100, },
> +	[MCP455x_502] = { .wipers = 1, .max_pos = 256, .kohms =   5, },
> +	[MCP455x_103] = { .wipers = 1, .max_pos = 256, .kohms =  10, },
> +	[MCP455x_503] = { .wipers = 1, .max_pos = 256, .kohms =  50, },
> +	[MCP455x_104] = { .wipers = 1, .max_pos = 256, .kohms = 100, },
> +	[MCP463x_502] = { .wipers = 2, .max_pos = 128, .kohms =   5, },
> +	[MCP463x_103] = { .wipers = 2, .max_pos = 128, .kohms =  10, },
> +	[MCP463x_503] = { .wipers = 2, .max_pos = 128, .kohms =  50, },
> +	[MCP463x_104] = { .wipers = 2, .max_pos = 128, .kohms = 100, },
> +	[MCP465x_502] = { .wipers = 2, .max_pos = 256, .kohms =   5, },
> +	[MCP465x_103] = { .wipers = 2, .max_pos = 256, .kohms =  10, },
> +	[MCP465x_503] = { .wipers = 2, .max_pos = 256, .kohms =  50, },
> +	[MCP465x_104] = { .wipers = 2, .max_pos = 256, .kohms = 100, },
> +};
> +
> +#define MCP4531_WRITE (0 << 2)
> +#define MCP4531_INCR  (1 << 2)
> +#define MCP4531_DECR  (2 << 2)
> +#define MCP4531_READ  (3 << 2)
> +
> +#define MCP4531_WIPER_SHIFT (4)
> +
> +struct mcp4531_data {
> +	struct i2c_client *client;
> +	unsigned long devid;
> +};
> +
> +#define MCP4531_CHANNEL(ch) {					\
> +	.type = IIO_RESISTANCE,					\
> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.channel = (ch),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec mcp4531_channels[] = {
> +	MCP4531_CHANNEL(0),
> +	MCP4531_CHANNEL(1),
> +};
> +
> +static int mcp4531_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct mcp4531_data *data = iio_priv(indio_dev);
> +	int address = chan->channel << MCP4531_WIPER_SHIFT;
> +	s32 ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_smbus_read_word_swapped(data->client,
> +						  MCP4531_READ | address);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1000 * mcp4531_cfg[data->devid].kohms;
> +		*val2 = mcp4531_cfg[data->devid].max_pos;
> +		return IIO_VAL_FRACTIONAL;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mcp4531_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mcp4531_data *data = iio_priv(indio_dev);
> +	int address = chan->channel << MCP4531_WIPER_SHIFT;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val > mcp4531_cfg[data->devid].max_pos || val < 0)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return i2c_smbus_write_byte_data(data->client,
> +					 MCP4531_WRITE | address | (val >> 8),
> +					 val & 0xff);
> +}
> +
> +static const struct iio_info mcp4531_info = {
> +	.read_raw = mcp4531_read_raw,
> +	.write_raw = mcp4531_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int mcp4531_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	unsigned long devid = id->driver_data;
> +	struct mcp4531_data *data;
> +	struct iio_dev *indio_dev;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_WORD_DATA)) {
> +		dev_err(dev, "SMBUS Word Data not supported\n");
> +		return -EIO;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	data->devid = devid;
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &mcp4531_info;
> +	indio_dev->channels = mcp4531_channels;
> +	indio_dev->num_channels = mcp4531_cfg[devid].wipers;
> +	indio_dev->name = client->name;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id mcp4531_id[] = {
> +	{ "mcp4531-502", MCP453x_502 },
> +	{ "mcp4531-103", MCP453x_103 },
> +	{ "mcp4531-503", MCP453x_503 },
> +	{ "mcp4531-104", MCP453x_104 },
> +	{ "mcp4532-502", MCP453x_502 },
> +	{ "mcp4532-103", MCP453x_103 },
> +	{ "mcp4532-503", MCP453x_503 },
> +	{ "mcp4532-104", MCP453x_104 },
> +	{ "mcp4551-502", MCP455x_502 },
> +	{ "mcp4551-103", MCP455x_103 },
> +	{ "mcp4551-503", MCP455x_503 },
> +	{ "mcp4551-104", MCP455x_104 },
> +	{ "mcp4552-502", MCP455x_502 },
> +	{ "mcp4552-103", MCP455x_103 },
> +	{ "mcp4552-503", MCP455x_503 },
> +	{ "mcp4552-104", MCP455x_104 },
> +	{ "mcp4631-502", MCP463x_502 },
> +	{ "mcp4631-103", MCP463x_103 },
> +	{ "mcp4631-503", MCP463x_503 },
> +	{ "mcp4631-104", MCP463x_104 },
> +	{ "mcp4632-502", MCP463x_502 },
> +	{ "mcp4632-103", MCP463x_103 },
> +	{ "mcp4632-503", MCP463x_503 },
> +	{ "mcp4632-104", MCP463x_104 },
> +	{ "mcp4651-502", MCP465x_502 },
> +	{ "mcp4651-103", MCP465x_103 },
> +	{ "mcp4651-503", MCP465x_503 },
> +	{ "mcp4651-104", MCP465x_104 },
> +	{ "mcp4652-502", MCP465x_502 },
> +	{ "mcp4652-103", MCP465x_103 },
> +	{ "mcp4652-503", MCP465x_503 },
> +	{ "mcp4652-104", MCP465x_104 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp4531_id);
> +
> +static struct i2c_driver mcp4531_driver = {
> +	.driver = {
> +		.name	= "mcp4531",
> +	},
> +	.probe		= mcp4531_probe,
> +	.id_table	= mcp4531_id,
> +};
> +
> +module_i2c_driver(mcp4531_driver);
> +
> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
> +MODULE_DESCRIPTION("MCP4531 digital potentiometer");
> +MODULE_LICENSE("GPL");
> 

