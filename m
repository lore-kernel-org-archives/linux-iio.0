Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:33107 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757425AbbIVH2J (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2015 03:28:09 -0400
Received: by lamp12 with SMTP id p12so1662145lam.0
        for <linux-iio@vger.kernel.org>; Tue, 22 Sep 2015 00:28:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1442870306-26128-2-git-send-email-peda@lysator.liu.se>
References: <1442870306-26128-1-git-send-email-peda@lysator.liu.se> <1442870306-26128-2-git-send-email-peda@lysator.liu.se>
From: Crt Mori <cmo@melexis.com>
Date: Tue, 22 Sep 2015 09:27:28 +0200
Message-ID: <CAKv63usCLv=dbmHQPdK89WVEwq5UvSgR5RsMb3SXuJdthXbn0A@mail.gmail.com>
Subject: Re: [PATCH v2] iio: mcp4xxx_dpot: Driver for Microchip digital potentiometers
To: Peter Rosin <peda@lysator.liu.se>
Cc: linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,
Just follow advice and it will get better. Maybe a bit of naming
advice since that needs to be fixed all over.
Usual naming convention is chipname_function_name not
chipname_part_function_name as you have
now. There was a newly added  IIO_RESISTANCE channel in case you would
think of the change (more
depends on what you would rather expect as input/output of your driver
to user-space).

Few more comments inline.

On 21 September 2015 at 23:18, Peter Rosin <peda@lysator.liu.se> wrote:
>
> From: Peter Rosin <peda@axentia.se>
>
> Add support for Microchip digital potentiometers and rheostats
>         MCP4531, MCP4532, MCP4551, MCP4552,
>         MCP4631, MCP4632, MCP4651, MCP4652
>
> These are either single (45xx) or dual (46xx) wipers with either
> 129 (4x3x) or 257 (4x5x) steps, and configured either as
> potentiometers (4xx1) or rheostats (4xx2).
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  MAINTAINERS                    |    5 +
>  drivers/iio/Kconfig            |    1 +
>  drivers/iio/Makefile           |    1 +
>  drivers/iio/pot/Kconfig        |   20 ++++
>  drivers/iio/pot/Makefile       |    6 ++
>  drivers/iio/pot/mcp4xxx_dpot.c |  218 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 251 insertions(+)
>  create mode 100644 drivers/iio/pot/Kconfig
>  create mode 100644 drivers/iio/pot/Makefile
>  create mode 100644 drivers/iio/pot/mcp4xxx_dpot.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b60e2b2369d2..2a34b75b3034 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6600,6 +6600,11 @@ W:       http://linuxtv.org
>  S:     Maintained
>  F:     drivers/media/radio/radio-maxiradio*
>
> +MCP4XXX MICROCHIP DIGITAL POTENTIOMETER DRIVER
> +M:     Peter Rosin <peda@axentia.se>
You are missing +L: linux-iio@vger.kernel.org
> +S:     Maintained
> +F:     drivers/iio/pot/mcp4xxx_dpot.*
I would put a .c here since you do not have a .h anymore?
> +
>  MEDIA DRIVERS FOR RENESAS - VSP1
>  M:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:     linux-media@vger.kernel.org
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 4011effe4c05..837aabad4b9a 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -73,6 +73,7 @@ source "drivers/iio/orientation/Kconfig"
>  if IIO_TRIGGER
>     source "drivers/iio/trigger/Kconfig"
>  endif #IIO_TRIGGER
> +source "drivers/iio/pot/Kconfig"
>  source "drivers/iio/pressure/Kconfig"
>  source "drivers/iio/proximity/Kconfig"
>  source "drivers/iio/temperature/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 698afc2d17ce..df026289309f 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -23,6 +23,7 @@ obj-y += imu/
>  obj-y += light/
>  obj-y += magnetometer/
>  obj-y += orientation/
> +obj-y += pot/
>  obj-y += pressure/
>  obj-y += proximity/
>  obj-y += temperature/
> diff --git a/drivers/iio/pot/Kconfig b/drivers/iio/pot/Kconfig
> new file mode 100644
> index 000000000000..48ebc7ef6b6b
> --- /dev/null
> +++ b/drivers/iio/pot/Kconfig
> @@ -0,0 +1,20 @@
> +#
> +# Potentiometer drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Digital potentiometers"
> +
> +config MCP4XXX_DPOT
> +       tristate "Microchip MCP45xx/MCP46xx Digital Potentiometer driver"
> +       depends on I2C
> +       help
> +         Say yes here to build support for the Microship
> +         MCP4531, MCP4532, MCP4551, MCP4552,
> +         MCP4631, MCP4632, MCP4651, MCP4652
> +         digital potentiomenter chips.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called mcp4xxx_dpot.
> +
> +endmenu
> diff --git a/drivers/iio/pot/Makefile b/drivers/iio/pot/Makefile
> new file mode 100644
> index 000000000000..763628ed649a
> --- /dev/null
> +++ b/drivers/iio/pot/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for industrial I/O potentiometer drivers
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_MCP4XXX_DPOT) += mcp4xxx_dpot.o
> diff --git a/drivers/iio/pot/mcp4xxx_dpot.c b/drivers/iio/pot/mcp4xxx_dpot.c
> new file mode 100644
> index 000000000000..30a1fb8fa46d
> --- /dev/null
> +++ b/drivers/iio/pot/mcp4xxx_dpot.c
> @@ -0,0 +1,218 @@
> +/*
> + * Industrial I/O driver for Microchip digital potentiometers
> + * Copyright (c) 2015  Axentia Technologies AB
> + * Author: Peter Rosin <peda@axentia.se>
> + *
> + * DEVID               #Wipers         #Positions      Resistor Options (kOhm)
> + * mcp4531             1               129             5, 10, 50, 100
> + * mcp4532             1               129             5, 10, 50, 100
> + * mcp4551             1               257             5, 10, 50, 100
> + * mcp4552             1               257             5, 10, 50, 100
> + * mcp4631             2               129             5, 10, 50, 100
> + * mcp4632             2               129             5, 10, 50, 100
> + * mcp4651             2               257             5, 10, 50, 100
> + * mcp4652             2               257             5, 10, 50, 100
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
> +
> +#define DPOT_CONF(wipers, max_pos, uid) \
> +       ((((wipers) & 0xf) << 10) | \
> +        (((max_pos) & 0xf) << 6) | \
> +        ((uid) & 0x3f))
> +
> +#define DPOT_UID(conf)     ((conf) & 0x3f)
> +#define DPOT_MAX_POS(conf) (((conf) >> 6) & 0xf)
> +#define DPOT_WIPERS(conf)  (((conf) >> 10) & 0xf)
> +
> +enum mcp4xxx_dpot_devid {
> +       MCP4531_ID = DPOT_CONF(1, 7, 0),
> +       MCP4532_ID = DPOT_CONF(1, 7, 1),
> +       MCP4551_ID = DPOT_CONF(1, 8, 2),
> +       MCP4552_ID = DPOT_CONF(1, 8, 3),
> +       MCP4631_ID = DPOT_CONF(2, 7, 4),
> +       MCP4632_ID = DPOT_CONF(2, 7, 5),
> +       MCP4651_ID = DPOT_CONF(2, 8, 6),
> +       MCP4652_ID = DPOT_CONF(2, 8, 7),
> +};
> +
> +struct mcp4xxx_dpot_data {
> +       struct i2c_client *client;
> +       unsigned int max_pos;
> +       unsigned long devid;
> +       int cache[2];
> +};
> +
> +static const struct iio_chan_spec mcp4xxx_dpot_channels[] = {
> +       {
> +               .type = IIO_STEPS,
> +               .indexed = 1,
> +               .output = 1,
> +               .channel = 0,
> +               .address = 0 << 4,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +       }, {
> +               .type = IIO_STEPS,
> +               .indexed = 1,
> +               .output = 1,
> +               .channel = 1,
> +               .address = 1 << 4,
> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +       }
> +};
> +
> +static int mcp4xxx_dpot_get_value(struct iio_dev *indio_dev,
> +                                 int address, int *val)
> +{
> +       struct mcp4xxx_dpot_data *data = iio_priv(indio_dev);
> +       s32 value;
> +
> +       value = i2c_smbus_read_word_data(data->client,  address | 0xc);
> +       if (value < 0)
> +               return value;
> +       *val = ((value >> 8) & 0xff) | ((value & 0xff) << 8);
> +       return 0;
> +}
> +
> +static int mcp4xxx_dpot_set_value(struct iio_dev *indio_dev,
> +                                 int address, int val)
> +{
> +       struct mcp4xxx_dpot_data *data = iio_priv(indio_dev);
> +
> +       if (val >= data->max_pos || val < 0)
> +               return -EINVAL;
> +
> +       return i2c_smbus_write_byte_data(data->client,
> +                                        address | (val >> 8),
> +                                        val & 0xff);
> +}
> +
> +static int mcp4xxx_dpot_read_raw(struct iio_dev *indio_dev,
> +                                struct iio_chan_spec const *chan,
> +                                int *val, int *val2, long mask)
> +{
> +       struct mcp4xxx_dpot_data *data = iio_priv(indio_dev);
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:

I would expect an actual read here rather than something from cache?
Imagine two applications are
reading and setting the output...

> +               *val = data->cache[chan->channel];
> +               return IIO_VAL_INT;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int mcp4xxx_dpot_write_raw(struct iio_dev *indio_dev,
> +                                 struct iio_chan_spec const *chan,
> +                                 int val, int val2, long mask)
> +{
> +       struct mcp4xxx_dpot_data *data = iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret = mcp4xxx_dpot_set_value(indio_dev, chan->address, val);
> +               if (ret >= 0)
> +                       data->cache[chan->channel] = val;
> +               break;
> +       default:
> +               ret = -EINVAL;
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +static const struct iio_info mcp4xxx_dpot_info = {
> +       .read_raw = mcp4xxx_dpot_read_raw,
> +       .write_raw = mcp4xxx_dpot_write_raw,
> +       .driver_module = THIS_MODULE,
> +};
> +
> +static int mcp4xxx_dpot_probe(struct i2c_client *client,
> +                             const struct i2c_device_id *id)
> +{
> +       struct device *dev = &client->dev;
> +       unsigned long devid = id->driver_data;
> +       struct mcp4xxx_dpot_data *data;
> +       struct iio_dev *indio_dev;
> +       int ch;
> +       int err;
> +
> +       if (!i2c_check_functionality(client->adapter,
> +                                    I2C_FUNC_SMBUS_WORD_DATA)) {
> +               dev_err(dev, "SMBUS Word Data not supported\n");
> +               return -EIO;
> +       }
> +
> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +       data = iio_priv(indio_dev);
> +       i2c_set_clientdata(client, indio_dev);
> +       data->client = client;
> +       data->devid = devid;
> +
> +       data->max_pos = (1 << DPOT_MAX_POS(devid)) + 1;
> +
> +       indio_dev->dev.parent = dev;
> +       indio_dev->info = &mcp4xxx_dpot_info;
> +       indio_dev->channels = mcp4xxx_dpot_channels;
> +       indio_dev->num_channels = DPOT_WIPERS(devid);
> +       indio_dev->name = client->name;
> +
> +       for (i = 0; i < indio_dev->num_channels; ++i) {
> +               err = mcp4xxx_dpot_get_value(indio_dev,
> +                                            indio_dev->channels[i].address,
> +                                            &data->cache[i]);
> +               if (err) {
> +                       dev_err(dev, "failed to read potentiometer value\n");
> +                       return err;
> +               }
> +       }
> +
> +       return iio_device_register(indio_dev);
> +}
> +
> +static int mcp4xxx_dpot_remove(struct i2c_client *client)
> +{
> +       iio_device_unregister(i2c_get_clientdata(client));
> +       return 0;
> +}
> +
> +static const struct i2c_device_id mcp4xxx_dpot_id[] = {
> +       { "mcp4531", MCP4531_ID },
> +       { "mcp4532", MCP4532_ID },
> +       { "mcp4551", MCP4551_ID },
> +       { "mcp4552", MCP4552_ID },
> +       { "mcp4631", MCP4631_ID },
> +       { "mcp4632", MCP4632_ID },
> +       { "mcp4651", MCP4651_ID },
> +       { "mcp4652", MCP4652_ID },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp4xxx_dpot_id);
> +
> +static struct i2c_driver mcp4xxx_dpot_driver = {
> +       .driver = {
> +               .name   = "mcp4xxx_dpot",
> +       },
> +       .probe          = mcp4xxx_dpot_probe,
> +       .remove         = mcp4xxx_dpot_remove,
> +       .id_table       = mcp4xxx_dpot_id,
> +};
> +
> +module_i2c_driver(mcp4xxx_dpot_driver);
> +
> +MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
> +MODULE_DESCRIPTION("MCP4XXX digital potentiometer");
> +MODULE_LICENSE("GPL");
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
