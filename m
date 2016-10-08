Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35649 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbcJHRKk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 13:10:40 -0400
Subject: Re: [PATCH 2/4] iio: accel: Add driver for dmard10 3-axis
 Accelerometer
To: Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20161008123426.8991-1-hdegoede@redhat.com>
 <20161008123426.8991-3-hdegoede@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e23b116d-ad5a-d0ea-a899-f61b06ba7790@kernel.org>
Date: Sat, 8 Oct 2016 18:10:37 +0100
MIME-Version: 1.0
In-Reply-To: <20161008123426.8991-3-hdegoede@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/10/16 13:34, Hans de Goede wrote:
> Add a driver for the Domintech ARD10 3-axis Accelerometer, based on the
> android driver found here: https://github.com/domintech/dmard10
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -prefix all defines with DMARD10_ and uppercase them all
> -Cleanup typography of some comments
> -Use defines for offsets in databuffer
> -Use i2c_smbus_write_byte_data() where applicable
> -Reduce unnecessarily large buffer size in dmard10_shutdown()
> -Use __le16 buffer in dmard10_read_raw()
> Changes in v3:
> -Express unit in m/s^2 instead of in "G"
Looks good to me. I thought about leaving it for a few days, but as the change
is so minor I would guess anyone who cared would have had plenty of time
to look at V2.

It'll be sat in my testing branch until next weekend anyway if anyone does
get a chance to take a look!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks. Another nice neat little driver.  Will be interesting to see
if anyone wants to ultimately try doing 'push' type data flows on these
devices.  Easy to add later though and I always like the approach where
the driver gains that feature after we are sure the simple stuff is
working well.

Jonathan
> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  drivers/iio/accel/Kconfig                          |  10 +
>  drivers/iio/accel/Makefile                         |   1 +
>  drivers/iio/accel/dmard10.c                        | 266 +++++++++++++++++++++
>  4 files changed, 278 insertions(+)
>  create mode 100644 drivers/iio/accel/dmard10.c
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index ce9db50..4689b31 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -39,6 +39,7 @@ dallas,ds75		Digital Thermometer and Thermostat
>  dlg,da9053		DA9053: flexible system level PMIC with multicore support
>  dlg,da9063		DA9063: system PMIC for quad-core application processors
>  domintech,dmard09	DMARD09: 3-axis Accelerometer
> +domintech,dmard10	DMARD10: 3-axis Accelerometer
>  epson,rx8010		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
>  epson,rx8025		High-Stability. I2C-Bus INTERFACE REAL TIME CLOCK MODULE
>  epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 6bf1b64..6236fd5 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -73,6 +73,16 @@ config DMARD09
>  	  Choosing M will build the driver as a module. If so, the module
>  	  will be called dmard09.
>  
> +config DMARD10
> +	tristate "Domintech DMARD10 3-axis Accelerometer Driver"
> +	depends on I2C
> +	help
> +	  Say yes here to get support for the Domintech DMARD10 3-axis
> +	  accelerometer.
> +
> +	  Choosing M will build the driver as a module. If so, the module
> +	  will be called dmard10.
> +
>  config HID_SENSOR_ACCEL_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 07a0c72..9f51559 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
>  obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
>  obj-$(CONFIG_DMARD06)	+= dmard06.o
>  obj-$(CONFIG_DMARD09)	+= dmard09.o
> +obj-$(CONFIG_DMARD10)	+= dmard10.o
>  obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
>  obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>  obj-$(CONFIG_KXSD9)	+= kxsd9.o
> diff --git a/drivers/iio/accel/dmard10.c b/drivers/iio/accel/dmard10.c
> new file mode 100644
> index 0000000..b8736cc
> --- /dev/null
> +++ b/drivers/iio/accel/dmard10.c
> @@ -0,0 +1,266 @@
> +/**
> + * IIO driver for the 3-axis accelerometer Domintech ARD10.
> + *
> + * Copyright (c) 2016 Hans de Goede <hdegoede@redhat.com>
> + * Copyright (c) 2012 Domintech Technology Co., Ltd
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
> +#define DMARD10_REG_ACTR			0x00
> +#define DMARD10_REG_AFEM			0x0c
> +#define DMARD10_REG_STADR			0x12
> +#define DMARD10_REG_STAINT			0x1c
> +#define DMARD10_REG_MISC2			0x1f
> +#define DMARD10_REG_PD				0x21
> +
> +#define DMARD10_MODE_OFF			0x00
> +#define DMARD10_MODE_STANDBY			0x02
> +#define DMARD10_MODE_ACTIVE			0x06
> +#define DMARD10_MODE_READ_OTP			0x12
> +#define DMARD10_MODE_RESET_DATA_PATH		0x82
> +
> +/* AFEN set 1, ATM[2:0]=b'000 (normal), EN_Z/Y/X/T=1 */
> +#define DMARD10_VALUE_AFEM_AFEN_NORMAL		0x8f
> +/* ODR[3:0]=b'0111 (100Hz), CCK[3:0]=b'0100 (204.8kHZ) */
> +#define DMARD10_VALUE_CKSEL_ODR_100_204		0x74
> +/* INTC[6:5]=b'00 */
> +#define DMARD10_VALUE_INTC			0x00
> +/* TAP1/TAP2 Average 2 */
> +#define DMARD10_VALUE_TAPNS_AVE_2		0x11
> +
> +#define DMARD10_VALUE_STADR			0x55
> +#define DMARD10_VALUE_STAINT			0xaa
> +#define DMARD10_VALUE_MISC2_OSCA_EN		0x08
> +#define DMARD10_VALUE_PD_RST			0x52
> +
> +/* Offsets into the buffer read in dmard10_read_raw() */
> +#define DMARD10_X_OFFSET			1
> +#define DMARD10_Y_OFFSET			2
> +#define DMARD10_Z_OFFSET			3
> +
> +/*
> + * a value of + or -128 corresponds to + or - 1G
> + * scale = 9.81 / 128 = 0.076640625
> + */
> +
> +static const int dmard10_nscale = 76640625;
> +
> +#define DMARD10_CHANNEL(reg, axis) {	\
> +	.type = IIO_ACCEL,	\
> +	.address = reg,	\
> +	.modified = 1,	\
> +	.channel2 = IIO_MOD_##axis,	\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec dmard10_channels[] = {
> +	DMARD10_CHANNEL(DMARD10_X_OFFSET, X),
> +	DMARD10_CHANNEL(DMARD10_Y_OFFSET, Y),
> +	DMARD10_CHANNEL(DMARD10_Z_OFFSET, Z),
> +};
> +
> +struct dmard10_data {
> +	struct i2c_client *client;
> +};
> +
> +/* Init sequence taken from the android driver */
> +static int dmard10_reset(struct i2c_client *client)
> +{
> +	unsigned char buffer[7];
> +	int ret;
> +
> +	/* 1. Powerdown reset */
> +	ret = i2c_smbus_write_byte_data(client, DMARD10_REG_PD,
> +						DMARD10_VALUE_PD_RST);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * 2. ACTR => Standby mode => Download OTP to parameter reg =>
> +	 *    Standby mode => Reset data path => Standby mode
> +	 */
> +	buffer[0] = DMARD10_REG_ACTR;
> +	buffer[1] = DMARD10_MODE_STANDBY;
> +	buffer[2] = DMARD10_MODE_READ_OTP;
> +	buffer[3] = DMARD10_MODE_STANDBY;
> +	buffer[4] = DMARD10_MODE_RESET_DATA_PATH;
> +	buffer[5] = DMARD10_MODE_STANDBY;
> +	ret = i2c_master_send(client, buffer, 6);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* 3. OSCA_EN = 1, TSTO = b'000 (INT1 = normal, TEST0 = normal) */
> +	ret = i2c_smbus_write_byte_data(client, DMARD10_REG_MISC2,
> +						DMARD10_VALUE_MISC2_OSCA_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* 4. AFEN = 1 (AFE will powerdown after ADC) */
> +	buffer[0] = DMARD10_REG_AFEM;
> +	buffer[1] = DMARD10_VALUE_AFEM_AFEN_NORMAL;
> +	buffer[2] = DMARD10_VALUE_CKSEL_ODR_100_204;
> +	buffer[3] = DMARD10_VALUE_INTC;
> +	buffer[4] = DMARD10_VALUE_TAPNS_AVE_2;
> +	buffer[5] = 0x00; /* DLYC, no delay timing */
> +	buffer[6] = 0x07; /* INTD=1 push-pull, INTA=1 active high, AUTOT=1 */
> +	ret = i2c_master_send(client, buffer, 7);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* 5. Activation mode */
> +	ret = i2c_smbus_write_byte_data(client, DMARD10_REG_ACTR,
> +						DMARD10_MODE_ACTIVE);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/* Shutdown sequence taken from the android driver */
> +static int dmard10_shutdown(struct i2c_client *client)
> +{
> +	unsigned char buffer[3];
> +
> +	buffer[0] = DMARD10_REG_ACTR;
> +	buffer[1] = DMARD10_MODE_STANDBY;
> +	buffer[2] = DMARD10_MODE_OFF;
> +
> +	return i2c_master_send(client, buffer, 3);
> +}
> +
> +static int dmard10_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct dmard10_data *data = iio_priv(indio_dev);
> +	__le16 buf[4];
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/*
> +		 * Read 8 bytes starting at the REG_STADR register, trying to
> +		 * read the individual X, Y, Z registers will always read 0.
> +		 */
> +		ret = i2c_smbus_read_i2c_block_data(data->client,
> +						    DMARD10_REG_STADR,
> +						    sizeof(buf), (u8 *)buf);
> +		if (ret < 0)
> +			return ret;
> +		ret = le16_to_cpu(buf[chan->address]);
> +		*val = sign_extend32(ret, 12);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = dmard10_nscale;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info dmard10_info = {
> +	.driver_module	= THIS_MODULE,
> +	.read_raw	= dmard10_read_raw,
> +};
> +
> +static int dmard10_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev;
> +	struct dmard10_data *data;
> +
> +	/* These 2 registers have special POR reset values used for id */
> +	ret = i2c_smbus_read_byte_data(client, DMARD10_REG_STADR);
> +	if (ret != DMARD10_VALUE_STADR)
> +		return (ret < 0) ? ret : -ENODEV;
> +
> +	ret = i2c_smbus_read_byte_data(client, DMARD10_REG_STAINT);
> +	if (ret != DMARD10_VALUE_STAINT)
> +		return (ret < 0) ? ret : -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "iio allocation failed!\n");
> +		return -ENOMEM;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &dmard10_info;
> +	indio_dev->name = "dmard10";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = dmard10_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(dmard10_channels);
> +
> +	ret = dmard10_reset(client);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "device_register failed\n");
> +		dmard10_shutdown(client);
> +	}
> +
> +	return ret;
> +}
> +
> +static int dmard10_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	return dmard10_shutdown(client);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int dmard10_suspend(struct device *dev)
> +{
> +	return dmard10_shutdown(to_i2c_client(dev));
> +}
> +
> +static int dmard10_resume(struct device *dev)
> +{
> +	return dmard10_reset(to_i2c_client(dev));
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(dmard10_pm_ops, dmard10_suspend, dmard10_resume);
> +
> +static const struct i2c_device_id dmard10_i2c_id[] = {
> +	{"dmard10", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, dmard10_i2c_id);
> +
> +static struct i2c_driver dmard10_driver = {
> +	.driver = {
> +		.name = "dmard10",
> +		.pm = &dmard10_pm_ops,
> +	},
> +	.probe		= dmard10_probe,
> +	.remove		= dmard10_remove,
> +	.id_table	= dmard10_i2c_id,
> +};
> +
> +module_i2c_driver(dmard10_driver);
> +
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_DESCRIPTION("Domintech ARD10 3-Axis Accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> 

