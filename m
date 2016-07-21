Return-Path: <pmeerw@pmeerw.net>
Date: Fri, 22 Jul 2016 00:41:39 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Aleksei Mamlin <mamlinav@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: Add support for Domintech DMARD06
 accelerometer
In-Reply-To: <1469133191-14812-1-git-send-email-mamlinav@gmail.com>
Message-ID: <alpine.DEB.2.02.1607220015530.6041@pmeerw.net>
References: <1469133140-14722-1-git-send-email-mamlinav@gmail.com> <1469133191-14812-1-git-send-email-mamlinav@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> This patch add support for Domintech DMARD06 accelerometer.

comments below
 
> Domintech DMARD06 is a low-g tri-axial digital accelerometer for
> cost-sensitive consumer application.
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/dmard06.txt      |  17 ++
>  drivers/iio/accel/Kconfig                          |  11 ++
>  drivers/iio/accel/Makefile                         |   1 +
>  drivers/iio/accel/dmard06.c                        | 219 +++++++++++++++++++++
>  4 files changed, 248 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
>  create mode 100644 drivers/iio/accel/dmard06.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/dmard06.txt b/Documentation/devicetree/bindings/iio/accel/dmard06.txt
> new file mode 100644
> index 0000000..cc2231a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/dmard06.txt
> @@ -0,0 +1,17 @@
> +Device tree bindings for Domintech DMARD06 acceletometer

typo: accelerometer

> +
> +Required properties:
> + - compatible		: Should be "domintech,dmard06"
> + - reg			: I2C address of the chip. Should be 0x1c
> +
> +Example:
> +	&i2c1 {
> +		/* ... */
> +
> +		accelerometer@1c {
> +			compatible = "domintech,dmard06";
> +			reg = <0x1c>;
> +		};
> +
> +		/* ... */
> +	};
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index e4a758c..abc8536 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -40,6 +40,17 @@ config BMC150_ACCEL_SPI
>  	tristate
>  	select REGMAP_SPI
>  
> +config DMARD06
> +	tristate "Domintech DMARD06 Digital Accelerometer Driver"
> +	depends on OF || COMPILE_TEST
> +	depends on I2C
> +	help
> +	  Say yes here to build support for the Domintech DMARD06 low-g
> +	  tri-axial digital accelerometer connected via an I2C bus.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called dmard06.
> +
>  config HID_SENSOR_ACCEL_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 71b6794..a96b269 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_BMA180) += bma180.o
>  obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
>  obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
> +obj-$(CONFIG_DMARD06)	+= dmard06.o
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
> diff --git a/drivers/iio/accel/dmard06.c b/drivers/iio/accel/dmard06.c
> new file mode 100644
> index 0000000..433e430
> --- /dev/null
> +++ b/drivers/iio/accel/dmard06.c
> @@ -0,0 +1,219 @@
> +/*
> + * IIO driver for Domintech DMARD06 accelerometer
> + *
> + * Copyright (C) 2016 Aleksei Mamlin <mamlinav@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +
> +struct dmard06_data {
> +	struct i2c_client *client;
> +};
> +
> +#define DMARD06_DRV_NAME		"dmard06"
> +
> +/* Device data registers */
> +#define DMARD06_CHIP_ID_REG		0x0f
> +#define DMARD06_TOUT_REG		0x40
> +#define DMARD06_XOUT_REG		0x41
> +#define DMARD06_YOUT_REG		0x42
> +#define DMARD06_ZOUT_REG		0x43
> +
> +/* Device ID value */
> +#define DMARD06_CHIP_ID			0x06
> +
> +/* Device values */
> +#define DMARD06_AXIS_MAX_VAL		64
> +#define DMARD06_AXIS_SCALE_VAL		31250
> +#define DMARD06_TEMP_CENTER_VAL		25
> +
> +static int dmard06_i2c_read(struct i2c_client *client, u8 reg, u8 *buf)
> +{
> +	int error;

'error' is a bit pessimistic, how about 'ret'? :-)

> +

can't use i2c_smbus_read_byte_data()?

> +	error = i2c_master_send(client, &reg, 1);
> +	if (unlikely(error < 0))
> +		return error;
> +
> +	error = i2c_master_recv(client, buf, 1);
> +	if (unlikely(error < 0))
> +		return error;

not sure if it is worth to annotate unlikely() here -- i2c is slooow
locking is needed if you really need two i2c_master calls

> +	return 0;
> +}
> +
> +static int dmard06_read_chip_id(struct dmard06_data *dmard06)
> +{
> +	u8 buf;
> +	u8 chip_id;
> +	int error;
> +
> +	error = dmard06_i2c_read(dmard06->client, DMARD06_CHIP_ID_REG, &buf);
> +	if (error) {
> +		dev_err(&dmard06->client->dev, "Failed to read chip id: %d\n",
> +			error);
> +		return error;
> +	}
> +
> +	chip_id = (buf & 0x00ff);

why? buf is u8 anyways

> +	if (chip_id != DMARD06_CHIP_ID) {
> +		dev_err(&dmard06->client->dev, "Invalid chip id: %02x\n",
> +			chip_id);
> +		return -EINVAL;

often ENODEV is used for this case

> +	}
> +
> +	dev_info(&dmard06->client->dev, "Found DMARD%02x chip\n", chip_id);

we prefer silent probing of the driver, please don't clutter the log

> +
> +	return 0;
> +}
> +
> +static int dmard06_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct dmard06_data *dmard06 = iio_priv(indio_dev);
> +	u8 buf;
> +	bool reversed;
> +	int error;
> +	int tmp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		error = dmard06_i2c_read(dmard06->client, chan->address, &buf);
> +		if (error) {
> +			dev_err(&dmard06->client->dev,
> +				"Failed to read data %d\n", error);
> +			return error;
> +		}
> +
> +		reversed = (buf >> 7) & 1;
> +		tmp = (int)((buf & 0x7f) >> 1);


> +
> +		switch (chan->type) {
> +		case IIO_ACCEL:

wouldn't sign_extend32(buf >> 1, 6) do the job?

> +			*val = reversed ? (tmp - DMARD06_AXIS_MAX_VAL) : tmp;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val = reversed ? -tmp : tmp;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = DMARD06_TEMP_CENTER_VAL;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			*val = 0;
> +			*val2 = DMARD06_AXIS_SCALE_VAL;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info dmard06_info = {
> +	.driver_module	= THIS_MODULE,
> +	.read_raw	= dmard06_read_raw,
> +};
> +
> +#define DMARD06_ACCEL_CHANNEL(_axis, reg) {			\

maybe rename reg to _reg

> +	.type = IIO_ACCEL,					\
> +	.address = reg,						\
> +	.channel2 = IIO_MOD_##_axis,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.modified = 1,						\
> +}
> +
> +#define DMARD06_TEMP_CHANNEL(reg) {				\
> +	.type = IIO_TEMP,					\
> +	.address = reg,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +			      BIT(IIO_CHAN_INFO_OFFSET),	\
> +}
> +
> +static const struct iio_chan_spec dmard06_channels[] = {
> +	DMARD06_ACCEL_CHANNEL(X, DMARD06_XOUT_REG),
> +	DMARD06_ACCEL_CHANNEL(Y, DMARD06_YOUT_REG),
> +	DMARD06_ACCEL_CHANNEL(Z, DMARD06_ZOUT_REG),
> +	DMARD06_TEMP_CHANNEL(DMARD06_TOUT_REG),
> +};
> +
> +static int dmard06_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	int error;
> +	struct iio_dev *indio_dev;
> +	struct dmard06_data *dmard06;
> +
> +	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);

not needed

> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&client->dev, "I2C check functionality failed\n");
> +		return -ENXIO;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dmard06));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "Failed to allocate iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	dmard06 = iio_priv(indio_dev);
> +	dmard06->client = client;
> +
> +	error = dmard06_read_chip_id(dmard06);
> +	if (error)
> +		return error;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = DMARD06_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = dmard06_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(dmard06_channels);
> +	indio_dev->info = &dmard06_info;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id dmard06_id[] = {
> +	{ "dmard06", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, dmard06_id);
> +
> +static const struct of_device_id dmard06_of_match[] = {
> +	{ .compatible = "domintech,dmard06" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, dmard06_of_match);
> +
> +static struct i2c_driver dmard06_driver = {
> +	.probe = dmard06_probe,
> +	.id_table = dmard06_id,
> +	.driver = {
> +		.name = DMARD06_DRV_NAME,
> +		.of_match_table = of_match_ptr(dmard06_of_match),
> +	},
> +};
> +module_i2c_driver(dmard06_driver);
> +
> +MODULE_AUTHOR("Aleksei Mamlin <mamlinav@gmail.com>");
> +MODULE_DESCRIPTION("Domintech DMARD06 accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
