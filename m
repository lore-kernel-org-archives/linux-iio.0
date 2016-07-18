Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57929 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbcGSFge (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 01:36:34 -0400
Subject: Re: [PATCH] iio: accel: add support for the Domintech DMARD09 3-axis
 accelerometer
To: Jelle van der Waa <jelle@vdwaa.nl>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20160716195152.30109-1-jelle@vdwaa.nl>
 <20160716195152.30109-2-jelle@vdwaa.nl>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6fbb1730-fff9-1cb4-2106-59eb51bc7452@kernel.org>
Date: Mon, 18 Jul 2016 18:01:19 +0100
MIME-Version: 1.0
In-Reply-To: <20160716195152.30109-2-jelle@vdwaa.nl>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/07/16 20:51, Jelle van der Waa wrote:
> Minimal implementation of an IIO driver for the Domintech DMARD09 3-axis
> accelerometer. Only supports reading the x,y,z axes at the moment.
> 
> Implementation based on the Android driver from the Acer Liquid E2
> kernel sources.
> 
> Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
Nice little driver.  A few comments inline.

Thanks,

Jonathan
> ---
>  .../devicetree/bindings/iio/accel/dmard09.txt      |  13 ++
>  drivers/iio/accel/Kconfig                          |  10 ++
>  drivers/iio/accel/Makefile                         |   1 +
>  drivers/iio/accel/dmard09.c                        | 180 +++++++++++++++++++++
>  4 files changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard09.txt
>  create mode 100644 drivers/iio/accel/dmard09.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/dmard09.txt b/Documentation/devicetree/bindings/iio/accel/dmard09.txt
> new file mode 100644
> index 0000000..69b2a03
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/dmard09.txt
> @@ -0,0 +1,13 @@
> +Domintech DMARD09 accelerometer devicetree bindings
Could go in the i2c/trivial-devices.txt list.
> +
> +Required properties:
> +
> +  - compatible : should be "domintech,dmard09"
> +  - reg : the I2C address of the sensor
> +
> +Example:
> +
> +dmard09@0x1d {
> +	compatible = "domintech,dmard09";
domintech needs adding to devicetree/bindings/vendor-prefixes.txt
> +	reg = <0x1d>;
> +};
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index e4a758c..3fb16eb 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -40,6 +40,16 @@ config BMC150_ACCEL_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config DMARD09
> +	tristate "Domintech DMARD09 3-axis Accelerometer Driver"
> +	select I2C
> +	help
> +	  Say yes here to get support for the Domintech DMARD09 3-axis
> +	  accelerometer.
> +
> +	  Choosing M will build the driver as a module. If so, the module
> +	  will be called dmard09.
> +
>  config HID_SENSOR_ACCEL_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 71b6794..b1022a0 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
> +obj-$(CONFIG_DMARD09) += dmard09.o
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
> diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
> new file mode 100644
> index 0000000..8689c5a
> --- /dev/null
> +++ b/drivers/iio/accel/dmard09.c
> @@ -0,0 +1,180 @@
> +/*
> + *  3-axis accelerometer driver for DMARD09 3-axis sensor.
> + *
> + * Copyright (c) 2016, Jelle van der Waa <jelle@vdwaa.nl>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +
> +#define DMARD09_DRV_NAME	"dmard09"
> +
> +#define DMARD09_REG_CHIPID      0x18
> +#define DMARD09_REG_STAT	0x0A
> +#define DMARD09_REG_X		0x0C
> +#define DMARD09_REG_Y		0x0E
> +#define DMARD09_REG_Z		0x10
> +#define DMARD09_CHIPID		0x95
> +
> +#define DMARD09_BUF_LEN 8
> +#define DMARD09_AXES_NUM        3
> +#define DMARD09_AXIS_X 0
> +#define DMARD09_AXIS_Y 1
> +#define DMARD09_AXIS_Z 2
> +
> +/* Used for dev_info() */
> +struct dmard09_data {
> +	struct i2c_client *client;
> +	struct device *dev;
Given you can get this from client->dev, don't bother keeping a copy of
this as well.
> +};
> +
> +static const struct iio_chan_spec dmard09_channels[] = {
> +	{
> +		.type = IIO_ACCEL,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.modified = 1,
> +		.address = DMARD09_REG_X,
> +		.channel2 = IIO_MOD_X,
> +	},
> +	{
> +		.type = IIO_ACCEL,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.modified = 1,
> +		.address = DMARD09_REG_Y,
> +		.channel2 = IIO_MOD_Y,
> +	},
> +	{
> +		.type = IIO_ACCEL,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.modified = 1,
> +		.address = DMARD09_REG_Z,
> +		.channel2 = IIO_MOD_Z,
> +	}
> +};
> +
> +static int dmard09_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct dmard09_data *data = iio_priv(indio_dev);
> +	u8 buf[DMARD09_BUF_LEN] = {0};
I doubt you need the init... Should be filled by the read.
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +						    DMARD09_REG_STAT,
Why start at reg_stat?  Does it look like it's clearing a hold on the data
for example?
> +						    DMARD09_BUF_LEN, buf);
> +		if (ret < 0) {
> +			dev_err(data->dev, "Error reading reg %lu\n",
> +				chan->address);
> +			return ret;
> +		}
> +
> +		if (chan->address == DMARD09_REG_X)
Please put spaces around the + and * as per kernel style..
Also these look to be doing endian conversions (or might be depending
on which endian we are).  As such, it would be better to use the relevant
of be16tocpu or le16tocpu (I'm dozing off in an airport so will leave
it up to you to figure out which ;)  That makes it basically free for
one case.

> +			*val = (s16)((buf[(DMARD09_AXIS_X+1)*2+1] << 8)
> +					| (buf[(DMARD09_AXIS_X+1)*2]));
> +		if (chan->address == DMARD09_REG_Y)
> +			*val = (s16)((buf[(DMARD09_AXIS_Y+1)*2+1] << 8)
> +					| (buf[(DMARD09_AXIS_Y+1)*2]));
> +		if (chan->address == DMARD09_REG_Z)
> +			*val = (s16)((buf[(DMARD09_AXIS_Z+1)*2+1] << 8)
> +					| (buf[(DMARD09_AXIS_Z+1)*2]));
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info dmard09_info = {
> +	.driver_module	= THIS_MODULE,
> +	.read_raw	= dmard09_read_raw,
> +};
> +
> +static int dmard09_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev;
> +	struct dmard09_data *data;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "iio allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = &client->dev;
> +	data->client = client;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, DMARD09_REG_CHIPID);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error reading chip id %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ret != DMARD09_CHIPID) {
> +		dev_err(&client->dev, "Invalid chip id %d\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = DMARD09_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = dmard09_channels;
> +	indio_dev->num_channels = DMARD09_AXES_NUM;
> +	indio_dev->info = &dmard09_info;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int dmard09_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
As there is nothing else to be done in remove, you should
be fine to use
devm_iio_device_register in probe and drop the remove entirely,
leaving the managed devm stuff to deal with the unregister.
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id dmard09_id[] = {
> +	{ "dmard09", 0},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, dmard09_id);
> +
> +static struct i2c_driver dmard09_driver = {
> +	.driver = {
> +		.name = DMARD09_DRV_NAME
> +	},
> +	.probe = dmard09_probe,
> +	.remove = dmard09_remove,
> +	.id_table = dmard09_id,
> +};
> +
> +module_i2c_driver(dmard09_driver);
> +
> +MODULE_AUTHOR("Jelle van der Waa <jelle@vdwaa.nl>");
> +MODULE_DESCRIPTION("DMARD09 3-axis accelerometer driver");
> +MODULE_LICENSE("GPL");
> 

