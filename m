Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35671 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbcJHROO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 13:14:14 -0400
Subject: Re: [PATCH 3/4] iio: accel: Add driver for the MiraMEMS DA311 3-axis
 12-bit digital accelerometer
To: Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161008123426.8991-1-hdegoede@redhat.com>
 <20161008123426.8991-4-hdegoede@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <abbe6cb1-7ec5-3d9c-2d49-710353d6230f@kernel.org>
Date: Sat, 8 Oct 2016 18:14:10 +0100
MIME-Version: 1.0
In-Reply-To: <20161008123426.8991-4-hdegoede@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/10/16 13:34, Hans de Goede wrote:
> This driver is based on the DA311 Android driver which can be found here:
> https://git.matricom.net/Firmware/kernel_amlogic_meson-common/tree/1e70113a5befd07debb68f537156def84c5be57a/drivers/amlogic/input/sensor
> the mir3da_* files are the DA311 driver.
> 
> Unfortunately there is no datasheet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Again, minor well defined changes from V2 so I'm happy to take
this without it staying on the list for long first.

Lars, plenty of time to add Reviewed-by/Acked-by if you
want to give them. Not to worry if not (though you and
all other reviewers never get enough credit in my view!)

Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes in v2:
> -Add proper prefix to patch Subject
> -Use i2c_smbus_read_word_data() instead of i2c_smbus_read_i2c_block_data()
> Changes in v3:
> -Express unit in m/s^2 instead of in "G"
> -Drop le16_to_cpu, i2c_smbus_read_word_data() already does this
> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  drivers/iio/accel/Kconfig                          |  10 +
>  drivers/iio/accel/Makefile                         |   1 +
>  drivers/iio/accel/da311.c                          | 305 +++++++++++++++++++++
>  4 files changed, 317 insertions(+)
>  create mode 100644 drivers/iio/accel/da311.c
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 4689b31..b23ded3 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -124,6 +124,7 @@ microchip,mcp4662-502	Microchip 8-bit Dual I2C Digital Potentiometer with NV Mem
>  microchip,mcp4662-103	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (10k)
>  microchip,mcp4662-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (50k)
>  microchip,mcp4662-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
> +miramems,da311		MiraMEMS DA311 3-axis 12-bit digital accelerometer
>  national,lm63		Temperature sensor with integrated fan control
>  national,lm75		I2C TEMP SENSOR
>  national,lm80		Serial Interface ACPI-Compatible Microprocessor System Hardware Monitor
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 6236fd5..c94348f 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -52,6 +52,16 @@ config BMC150_ACCEL_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config DA311
> +	tristate "MiraMEMS DA311 3-axis 12-bit digital accelerometer driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the MiraMEMS DA311 3-axis 12-bit
> +	  digital accelerometer.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called da311.
> +
>  config DMARD06
>  	tristate "Domintech DMARD06 Digital Accelerometer Driver"
>  	depends on OF || COMPILE_TEST
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 9f51559..601ca59 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_BMA220) += bma220_spi.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
> +obj-$(CONFIG_DA311)	+= da311.o
>  obj-$(CONFIG_DMARD06)	+= dmard06.o
>  obj-$(CONFIG_DMARD09)	+= dmard09.o
>  obj-$(CONFIG_DMARD10)	+= dmard10.o
> diff --git a/drivers/iio/accel/da311.c b/drivers/iio/accel/da311.c
> new file mode 100644
> index 0000000..537cfa8
> --- /dev/null
> +++ b/drivers/iio/accel/da311.c
> @@ -0,0 +1,305 @@
> +/**
> + * IIO driver for the MiraMEMS DA311 3-axis accelerometer
> + *
> + * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
> + * Copyright (c) 2011-2013 MiraMEMS Sensing Technology Co., Ltd.
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
> +#define DA311_CHIP_ID			0x13
> +
> +/*
> + * Note register addressed go from 0 - 0x3f and then wrap.
> + * For some reason there are 2 banks with 0 - 0x3f addresses,
> + * rather then a single 0-0x7f bank.
> + */
> +
> +/* Bank 0 regs */
> +#define DA311_REG_BANK			0x0000
> +#define DA311_REG_LDO_REG		0x0006
> +#define DA311_REG_CHIP_ID		0x000f
> +#define DA311_REG_TEMP_CFG_REG		0x001f
> +#define DA311_REG_CTRL_REG1		0x0020
> +#define DA311_REG_CTRL_REG3		0x0022
> +#define DA311_REG_CTRL_REG4		0x0023
> +#define DA311_REG_CTRL_REG5		0x0024
> +#define DA311_REG_CTRL_REG6		0x0025
> +#define DA311_REG_STATUS_REG		0x0027
> +#define DA311_REG_OUT_X_L		0x0028
> +#define DA311_REG_OUT_X_H		0x0029
> +#define DA311_REG_OUT_Y_L		0x002a
> +#define DA311_REG_OUT_Y_H		0x002b
> +#define DA311_REG_OUT_Z_L		0x002c
> +#define DA311_REG_OUT_Z_H		0x002d
> +#define DA311_REG_INT1_CFG		0x0030
> +#define DA311_REG_INT1_SRC		0x0031
> +#define DA311_REG_INT1_THS		0x0032
> +#define DA311_REG_INT1_DURATION		0x0033
> +#define DA311_REG_INT2_CFG		0x0034
> +#define DA311_REG_INT2_SRC		0x0035
> +#define DA311_REG_INT2_THS		0x0036
> +#define DA311_REG_INT2_DURATION		0x0037
> +#define DA311_REG_CLICK_CFG		0x0038
> +#define DA311_REG_CLICK_SRC		0x0039
> +#define DA311_REG_CLICK_THS		0x003a
> +#define DA311_REG_TIME_LIMIT		0x003b
> +#define DA311_REG_TIME_LATENCY		0x003c
> +#define DA311_REG_TIME_WINDOW		0x003d
> +
> +/* Bank 1 regs */
> +#define DA311_REG_SOFT_RESET		0x0105
> +#define DA311_REG_OTP_XOFF_L		0x0110
> +#define DA311_REG_OTP_XOFF_H		0x0111
> +#define DA311_REG_OTP_YOFF_L		0x0112
> +#define DA311_REG_OTP_YOFF_H		0x0113
> +#define DA311_REG_OTP_ZOFF_L		0x0114
> +#define DA311_REG_OTP_ZOFF_H		0x0115
> +#define DA311_REG_OTP_XSO		0x0116
> +#define DA311_REG_OTP_YSO		0x0117
> +#define DA311_REG_OTP_ZSO		0x0118
> +#define DA311_REG_OTP_TRIM_OSC		0x011b
> +#define DA311_REG_LPF_ABSOLUTE		0x011c
> +#define DA311_REG_TEMP_OFF1		0x0127
> +#define DA311_REG_TEMP_OFF2		0x0128
> +#define DA311_REG_TEMP_OFF3		0x0129
> +#define DA311_REG_OTP_TRIM_THERM_H	0x011a
> +
> +/*
> + * a value of + or -1024 corresponds to + or - 1G
> + * scale = 9.81 / 1024 = 0.009580078
> + */
> +
> +static const int da311_nscale = 9580078;
> +
> +#define DA311_CHANNEL(reg, axis) {	\
> +	.type = IIO_ACCEL,	\
> +	.address = reg,	\
> +	.modified = 1,	\
> +	.channel2 = IIO_MOD_##axis,	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec da311_channels[] = {
> +	/* | 0x80 comes from the android driver */
> +	DA311_CHANNEL(DA311_REG_OUT_X_L | 0x80, X),
> +	DA311_CHANNEL(DA311_REG_OUT_Y_L | 0x80, Y),
> +	DA311_CHANNEL(DA311_REG_OUT_Z_L | 0x80, Z),
> +};
> +
> +struct da311_data {
> +	struct i2c_client *client;
> +};
> +
> +static int da311_register_mask_write(struct i2c_client *client, u16 addr,
> +				     u8 mask, u8 data)
> +{
> +	int ret;
> +	u8 tmp_data = 0;
> +
> +	if (addr & 0xff00) {
> +		/* Select bank 1 */
> +		ret = i2c_smbus_write_byte_data(client, DA311_REG_BANK, 0x01);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	if (mask != 0xff) {
> +		ret = i2c_smbus_read_byte_data(client, addr);
> +		if (ret < 0)
> +			return ret;
> +		tmp_data = ret;
> +	}
> +
> +	tmp_data &= ~mask;
> +	tmp_data |= data & mask;
> +	ret = i2c_smbus_write_byte_data(client, addr & 0xff, tmp_data);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (addr & 0xff00) {
> +		/* Back to bank 0 */
> +		ret = i2c_smbus_write_byte_data(client, DA311_REG_BANK, 0x00);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Init sequence taken from the android driver */
> +static int da311_reset(struct i2c_client *client)
> +{
> +	const struct {
> +		u16 addr;
> +		u8 mask;
> +		u8 data;
> +	} init_data[] = {
> +		{ DA311_REG_TEMP_CFG_REG,       0xff,   0x08 },
> +		{ DA311_REG_CTRL_REG5,          0xff,   0x80 },
> +		{ DA311_REG_CTRL_REG4,          0x30,   0x00 },
> +		{ DA311_REG_CTRL_REG1,          0xff,   0x6f },
> +		{ DA311_REG_TEMP_CFG_REG,       0xff,   0x88 },
> +		{ DA311_REG_LDO_REG,            0xff,   0x02 },
> +		{ DA311_REG_OTP_TRIM_OSC,       0xff,   0x27 },
> +		{ DA311_REG_LPF_ABSOLUTE,       0xff,   0x30 },
> +		{ DA311_REG_TEMP_OFF1,          0xff,   0x3f },
> +		{ DA311_REG_TEMP_OFF2,          0xff,   0xff },
> +		{ DA311_REG_TEMP_OFF3,          0xff,   0x0f },
> +	};
> +	int i, ret;
> +
> +	/* Reset */
> +	ret = da311_register_mask_write(client, DA311_REG_SOFT_RESET,
> +					0xff, 0xaa);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(init_data); i++) {
> +		ret = da311_register_mask_write(client,
> +						init_data[i].addr,
> +						init_data[i].mask,
> +						init_data[i].data);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int da311_enable(struct i2c_client *client, bool enable)
> +{
> +	u8 data = enable ? 0x00 : 0x20;
> +
> +	return da311_register_mask_write(client, DA311_REG_TEMP_CFG_REG,
> +					 0x20, data);
> +}
> +
> +static int da311_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct da311_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_smbus_read_word_data(data->client, chan->address);
> +		if (ret < 0)
> +			return ret;
> +		/*
> +		 * Values are 12 bits, stored as 16 bits with the 4
> +		 * least significant bits always 0.
> +		 */
> +		*val = (short)ret >> 4;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = da311_nscale;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info da311_info = {
> +	.driver_module	= THIS_MODULE,
> +	.read_raw	= da311_read_raw,
> +};
> +
> +static int da311_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev;
> +	struct da311_data *data;
> +
> +	ret = i2c_smbus_read_byte_data(client, DA311_REG_CHIP_ID);
> +	if (ret != DA311_CHIP_ID)
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
> +	indio_dev->info = &da311_info;
> +	indio_dev->name = "da311";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = da311_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(da311_channels);
> +
> +	ret = da311_reset(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = da311_enable(client, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "device_register failed\n");
> +		da311_enable(client, false);
> +	}
> +
> +	return ret;
> +}
> +
> +static int da311_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return da311_enable(client, false);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int da311_suspend(struct device *dev)
> +{
> +	return da311_enable(to_i2c_client(dev), false);
> +}
> +
> +static int da311_resume(struct device *dev)
> +{
> +	return da311_enable(to_i2c_client(dev), true);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(da311_pm_ops, da311_suspend, da311_resume);
> +
> +static const struct i2c_device_id da311_i2c_id[] = {
> +	{"da311", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, da311_i2c_id);
> +
> +static struct i2c_driver da311_driver = {
> +	.driver = {
> +		.name = "da311",
> +		.pm = &da311_pm_ops,
> +	},
> +	.probe		= da311_probe,
> +	.remove		= da311_remove,
> +	.id_table	= da311_i2c_id,
> +};
> +
> +module_i2c_driver(da311_driver);
> +
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_DESCRIPTION("MiraMEMS DA311 3-Axis Accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> 

