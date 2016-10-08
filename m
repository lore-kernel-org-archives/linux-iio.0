Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35693 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757910AbcJHRRv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 13:17:51 -0400
Subject: Re: [PATCH 4/4] iio: accel: Add driver for the MiraMEMS DA280 3-axis
 14-bit digital accelerometer
To: Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161008123426.8991-1-hdegoede@redhat.com>
 <20161008123426.8991-5-hdegoede@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <11db85a2-23a1-8f25-4ce1-061e88f02c32@kernel.org>
Date: Sat, 8 Oct 2016 18:17:47 +0100
MIME-Version: 1.0
In-Reply-To: <20161008123426.8991-5-hdegoede@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/10/16 13:34, Hans de Goede wrote:
> Add an iio driver for the MiraMEMS DA280 3-axis 14-bit accelerometer, as
> well as for the DA226 which is a fully compatible 2-axis version.
> 
> Datasheets for the DA280 and DA226 can be found at the manufacturers site:
> http://www.miramems.com/en/products.asp?list=1
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
How many more of these devices do you have? :)

You have another unwanted le16_to_cpu conversion of data coming off
the back of an smbus word read.

Otherwise, looks good to me.

Jonathan
> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
>  drivers/iio/accel/Kconfig                          |  10 ++
>  drivers/iio/accel/Makefile                         |   1 +
>  drivers/iio/accel/da280.c                          | 183 +++++++++++++++++++++
>  4 files changed, 196 insertions(+)
>  create mode 100644 drivers/iio/accel/da280.c
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index b23ded3..6e4ba81 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -124,6 +124,8 @@ microchip,mcp4662-502	Microchip 8-bit Dual I2C Digital Potentiometer with NV Mem
>  microchip,mcp4662-103	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
>  microchip,mcp4662-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
>  microchip,mcp4662-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
> +miramems,da226		MiraMEMS DA226 2-axis 14-bit digital accelerometer
> +miramems,da280		MiraMEMS DA280 3-axis 14-bit digital accelerometer
>  miramems,da311		MiraMEMS DA311 3-axis 12-bit digital accelerometer
>  national,lm63		Temperature sensor with integrated fan control
>  national,lm75		I2C TEMP SENSOR
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index c94348f..c2ed6cf 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -52,6 +52,16 @@ config BMC150_ACCEL_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config DA280
> +	tristate "MiraMEMS DA280 3-axis 14-bit digital accelerometer driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the MiraMEMS DA280 3-axis 14-bit
> +	  digital accelerometer.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called da280.
> +
>  config DA311
>  	tristate "MiraMEMS DA311 3-axis 12-bit digital accelerometer driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 601ca59..b7a9ba7 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_BMA220) += bma220_spi.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
> +obj-$(CONFIG_DA280)	+= da280.o
>  obj-$(CONFIG_DA311)	+= da311.o
>  obj-$(CONFIG_DMARD06)	+= dmard06.o
>  obj-$(CONFIG_DMARD09)	+= dmard09.o
> diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> new file mode 100644
> index 0000000..7b1fe88
> --- /dev/null
> +++ b/drivers/iio/accel/da280.c
> @@ -0,0 +1,183 @@
> +/**
> + * IIO driver for the MiraMEMS DA280 3-axis accelerometer and
> + * IIO driver for the MiraMEMS DA226 2-axis accelerometer
> + *
> + * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/byteorder/generic.h>
> +
> +#define DA280_REG_CHIP_ID		0x01
> +#define DA280_REG_ACC_X_LSB		0x02
> +#define DA280_REG_ACC_Y_LSB		0x04
> +#define DA280_REG_ACC_Z_LSB		0x06
> +#define DA280_REG_MODE_BW		0x11
> +
> +#define DA280_CHIP_ID			0x13
> +#define DA280_MODE_ENABLE		0x1e
> +#define DA280_MODE_DISABLE		0x9e
> +
> +enum { da226, da280 };
> +
> +/*
> + * a value of + or -4096 corresponds to + or - 1G
> + * scale = 9.81 / 4096 = 0.002395019
> + */
> +
> +static const int da280_nscale = 2395019;
> +
> +#define DA280_CHANNEL(reg, axis) {	\
> +	.type = IIO_ACCEL,	\
> +	.address = reg,	\
> +	.modified = 1,	\
> +	.channel2 = IIO_MOD_##axis,	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec da280_channels[] = {
> +	DA280_CHANNEL(DA280_REG_ACC_X_LSB, X),
> +	DA280_CHANNEL(DA280_REG_ACC_Y_LSB, Y),
> +	DA280_CHANNEL(DA280_REG_ACC_Z_LSB, Z),
> +};
> +
> +struct da280_data {
> +	struct i2c_client *client;
> +};
> +
> +static int da280_enable(struct i2c_client *client, bool enable)
> +{
> +	u8 data = enable ? DA280_MODE_ENABLE : DA280_MODE_DISABLE;
> +
> +	return i2c_smbus_write_byte_data(client, DA280_REG_MODE_BW, data);
> +}
> +
> +static int da280_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct da280_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_smbus_read_word_data(data->client, chan->address);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * Values are 14 bits, stored as 16 bits with the 2
> +		 * least significant bits always 0.
> +		 */
> +		*val = ((short)le16_to_cpu(ret)) >> 2;
Same thing Lars picked up on before I think...  It's already in cpu endian.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = da280_nscale;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info da280_info = {
> +	.driver_module	= THIS_MODULE,
> +	.read_raw	= da280_read_raw,
> +};
> +
> +static int da280_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev;
> +	struct da280_data *data;
> +
> +	ret = i2c_smbus_read_byte_data(client, DA280_REG_CHIP_ID);
> +	if (ret != DA280_CHIP_ID)
> +		return (ret < 0) ? ret : -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &da280_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = da280_channels;
> +	if (id->driver_data == da226) {
> +		indio_dev->name = "da226";
> +		indio_dev->num_channels = 2;
> +	} else {
> +		indio_dev->name = "da280";
> +		indio_dev->num_channels = 3;
> +	}
> +
> +	ret = da280_enable(client, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "device_register failed\n");
> +		da280_enable(client, false);
> +	}
> +
> +	return ret;
> +}
> +
> +static int da280_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return da280_enable(client, false);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int da280_suspend(struct device *dev)
> +{
> +	return da280_enable(to_i2c_client(dev), false);
> +}
> +
> +static int da280_resume(struct device *dev)
> +{
> +	return da280_enable(to_i2c_client(dev), true);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
> +
> +static const struct i2c_device_id da280_i2c_id[] = {
> +	{ "da226", da226 },
> +	{ "da280", da280 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, da280_i2c_id);
> +
> +static struct i2c_driver da280_driver = {
> +	.driver = {
> +		.name = "da280",
> +		.pm = &da280_pm_ops,
> +	},
> +	.probe		= da280_probe,
> +	.remove		= da280_remove,
> +	.id_table	= da280_i2c_id,
> +};
> +
> +module_i2c_driver(da280_driver);
> +
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_DESCRIPTION("MiraMEMS DA280 3-Axis Accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> 

