Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 22 Sep 2015 15:01:02 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Peter Rosin <peda@lysator.liu.se>
cc: linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
    Crt Mori <cmo@melexis.com>, Daniel Baluta <daniel.baluta@gmail.com>,
    Andreas Dannenberg <dannenberg@ti.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: mcp4531: Driver for Microchip digital
 potentiometers
In-Reply-To: <1442925594-21240-3-git-send-email-peda@lysator.liu.se>
Message-ID: <alpine.DEB.2.02.1509221445490.4538@pmeerw.net>
References: <1442925594-21240-1-git-send-email-peda@lysator.liu.se> <1442925594-21240-3-git-send-email-peda@lysator.liu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Add support for Microchip digital potentiometers and rheostats
> 	MCP4531, MCP4532, MCP4551, MCP4552
> 	MCP4631, MCP4632, MCP4651, MCP4652
> 
> These are either single (45xx) or dual (46xx) wipers with either
> 129 (4x3x) or 257 (4x5x) steps, and configured either as
> potentiometers (4xx1) or rheostats (4xx2).
> 
> Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22096b.pdf

some comments below

I find it useful to state the 7-bit i2c slave address somewhere, 
0101xxx in this case
 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  MAINTAINERS                         |    6 ++
>  drivers/iio/Kconfig                 |    1 +
>  drivers/iio/Makefile                |    1 +
>  drivers/iio/potentiometer/Kconfig   |   20 ++++
>  drivers/iio/potentiometer/Makefile  |    6 ++
>  drivers/iio/potentiometer/mcp4531.c |  200 +++++++++++++++++++++++++++++++++++
>  6 files changed, 234 insertions(+)
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
> index 000000000000..11039b215080
> --- /dev/null
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -0,0 +1,200 @@
> +/*
> + * Industrial I/O driver for Microchip digital potentiometers
> + * Copyright (c) 2015  Axentia Technologies AB
> + * Author: Peter Rosin <peda@axentia.se>
> + *
> + * Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22096b.pdf
> + *
> + * DEVID		#Wipers		#Positions	Resistor Options (kOhm)
> + * mcp4531		1		129		5, 10, 50, 100
> + * mcp4532		1		129		5, 10, 50, 100
> + * mcp4551		1		257		5, 10, 50, 100
> + * mcp4552		1		257		5, 10, 50, 100
> + * mcp4631		2		129		5, 10, 50, 100
> + * mcp4632		2		129		5, 10, 50, 100
> + * mcp4651		2		257		5, 10, 50, 100
> + * mcp4652		2		257		5, 10, 50, 100
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

drop extra newline

> +
> +#define MCP4531_CONF(wipers, max_pos, uid) \
> +	((((wipers) & 0xf) << 10) | \
> +	 (((max_pos) & 0xf) << 6) | \
> +	 ((uid) & 0x3f))
> +
> +#define MCP4531_UID(conf)     ((conf) & 0x3f)
> +#define MCP4531_MAX_POS(conf) (((conf) >> 6) & 0xf)
> +#define MCP4531_WIPERS(conf)  (((conf) >> 10) & 0xf)
> +
> +enum mcp4531_devid {
> +	MCP4531_ID = MCP4531_CONF(1, 7, 0),
> +	MCP4532_ID = MCP4531_CONF(1, 7, 1),
> +	MCP4551_ID = MCP4531_CONF(1, 8, 2),
> +	MCP4552_ID = MCP4531_CONF(1, 8, 3),
> +	MCP4631_ID = MCP4531_CONF(2, 7, 4),
> +	MCP4632_ID = MCP4531_CONF(2, 7, 5),
> +	MCP4651_ID = MCP4531_CONF(2, 8, 6),
> +	MCP4652_ID = MCP4531_CONF(2, 8, 7),
> +};
> +
> +struct mcp4531_data {
> +	struct i2c_client *client;
> +	unsigned int max_pos;
> +	unsigned long devid;
> +};
> +
> +static const struct iio_chan_spec mcp4531_channels[] = {
> +	{

could use a MACRO to deduplicate common channel parameters

> +		.type = IIO_RESISTANCE,
> +		.indexed = 1,
> +		.output = 1,
> +		.channel = 0,
> +		.address = 0 << 4,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		.type = IIO_RESISTANCE,
> +		.indexed = 1,
> +		.output = 1,
> +		.channel = 1,
> +		.address = 1 << 4,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}
> +};
> +
> +static int mcp4531_get_value(struct iio_dev *indio_dev,
> +			     int address, int *val)
> +{
> +	struct mcp4531_data *data = iio_priv(indio_dev);
> +	s32 value;

ret is arguably a more commonly used name

> +
> +	value = i2c_smbus_read_word_data(data->client,  address | 0xc);

extra space before address
what is 0xc? use a #define maybe

> +	if (value < 0)
> +		return value;
> +	*val = ((value >> 8) & 0xff) | ((value & 0xff) << 8);

use i2c_smbus_read_word_swapped(), the chip uses MSB first; no need to 
shuffle bytes for endianness

> +	return 0;
> +}
> +
> +static int mcp4531_set_value(struct iio_dev *indio_dev,
> +			     int address, int val)
> +{
> +	struct mcp4531_data *data = iio_priv(indio_dev);
> +
> +	if (val >= data->max_pos || val < 0)
> +		return -EINVAL;
> +
> +	return i2c_smbus_write_byte_data(data->client,
> +					 address | (val >> 8),
> +					 val & 0xff);
> +}
> +
> +static int mcp4531_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	int err;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		err = mcp4531_get_value(indio_dev, chan->address, val);
> +		if (err < 0)
> +			return err;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mcp4531_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return mcp4531_set_value(indio_dev, chan->address, val);
> +	}
> +
> +	return -EINVAL;
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
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +	data->devid = devid;
> +
> +	data->max_pos = (1 << MCP4531_MAX_POS(devid)) + 1;
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &mcp4531_info;
> +	indio_dev->channels = mcp4531_channels;
> +	indio_dev->num_channels = MCP4531_WIPERS(devid);
> +	indio_dev->name = client->name;
> +
> +	return iio_device_register(indio_dev);

use devm_ ...

> +}
> +
> +static int mcp4531_remove(struct i2c_client *client)
> +{


... and drop _remove()

> +	iio_device_unregister(i2c_get_clientdata(client));
> +	return 0;
> +}
> +
> +static const struct i2c_device_id mcp4531_id[] = {
> +	{ "mcp4531", MCP4531_ID },
> +	{ "mcp4532", MCP4532_ID },
> +	{ "mcp4551", MCP4551_ID },
> +	{ "mcp4552", MCP4552_ID },
> +	{ "mcp4631", MCP4631_ID },
> +	{ "mcp4632", MCP4632_ID },
> +	{ "mcp4651", MCP4651_ID },
> +	{ "mcp4652", MCP4652_ID },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp4531_id);
> +
> +static struct i2c_driver mcp4531_driver = {
> +	.driver = {
> +		.name	= "mcp4531",
> +	},
> +	.probe		= mcp4531_probe,
> +	.remove		= mcp4531_remove,
> +	.id_table	= mcp4531_id,
> +};
> +
> +module_i2c_driver(mcp4531_driver);
> +
> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
> +MODULE_DESCRIPTION("MCP4531 digital potentiometer");
> +MODULE_LICENSE("GPL");
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
