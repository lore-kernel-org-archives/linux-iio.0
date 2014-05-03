Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51299 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECKhW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 06:37:22 -0400
Message-ID: <5364C73E.5000309@kernel.org>
Date: Sat, 03 May 2014 11:38:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Add Melexis mlx90614 contact-less infrared temperature
 sensor driver
References: <1399046226-6673-1-git-send-email-pmeerw@pmeerw.net> <1399046226-6673-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1399046226-6673-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/14 16:57, Peter Meerwald wrote:
> I2C-controlled sensor measures ambient and object temperatuer
>
> see
> http://www.melexis.com/Infrared-Thermometer-Sensors/Infrared-Thermometer-Sensors/MLX90614-615.aspx
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Another nice short excelent driver.

Applied to the togreg branch of iio.git initially pushed out as testing
for the autobuilders to play.

J
> ---
>   drivers/iio/temperature/Kconfig    |  10 +++
>   drivers/iio/temperature/Makefile   |   1 +
>   drivers/iio/temperature/mlx90614.c | 150 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 161 insertions(+)
>   create mode 100644 drivers/iio/temperature/mlx90614.c
>
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index 372f8fb..21feaa4 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -3,6 +3,16 @@
>   #
>   menu "Temperature sensors"
>
> +config MLX90614
> +	tristate "MLX90614 contact-less infrared sensor"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for the Melexis
> +	  MLX90614 contact-less infrared sensor connected with I2C.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called mlx90614.
> +
>   config TMP006
>   	tristate "TMP006 infrared thermopile sensor"
>   	depends on I2C
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 24d7b60..40710a8 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -2,4 +2,5 @@
>   # Makefile for industrial I/O temperature drivers
>   #
>
> +obj-$(CONFIG_MLX90614) += mlx90614.o
>   obj-$(CONFIG_TMP006) += tmp006.o
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> new file mode 100644
> index 0000000..c8b6ac8
> --- /dev/null
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -0,0 +1,150 @@
> +/*
> + * mlx90614.c - Support for Melexis MLX90614 contactless IR temperature sensor
> + *
> + * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License.  See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * Driver for the Melexis MLX90614 I2C 16-bit IR thermopile sensor
> + *
> + * (7-bit I2C slave address 0x5a, 100KHz bus speed only!)
> + *
> + * TODO: sleep mode, configuration EEPROM
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define MLX90614_OP_RAM 0x00
> +
> +/* RAM offsets with 16-bit data, MSB first */
> +#define MLX90614_TA 0x06 /* ambient temperature */
> +#define MLX90614_TOBJ1 0x07 /* object temperature */
> +
> +struct mlx90614_data {
> +	struct i2c_client *client;
> +};
> +
> +static int mlx90614_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct mlx90614_data *data = iio_priv(indio_dev);
> +	s32 ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: /* 0.02K / LSB */
> +		switch (channel->channel2) {
> +		case IIO_MOD_TEMP_AMBIENT:
> +			ret = i2c_smbus_read_word_data(data->client,
> +			    MLX90614_OP_RAM | MLX90614_TA);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		case IIO_MOD_TEMP_OBJECT:
> +			ret = i2c_smbus_read_word_data(data->client,
> +			    MLX90614_OP_RAM | MLX90614_TOBJ1);
> +			if (ret < 0)
> +				return ret;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 13657;
> +		*val2 = 500000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 20;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec mlx90614_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_TEMP_AMBIENT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		    BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_TEMP_OBJECT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		    BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static const struct iio_info mlx90614_info = {
> +	.read_raw = mlx90614_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int mlx90614_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mlx90614_data *data;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &mlx90614_info;
> +
> +	indio_dev->channels = mlx90614_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mlx90614_channels);
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int mlx90614_remove(struct i2c_client *client)
> +{
> +	iio_device_unregister(i2c_get_clientdata(client));
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id mlx90614_id[] = {
> +	{ "mlx90614", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mlx90614_id);
> +
> +static struct i2c_driver mlx90614_driver = {
> +	.driver = {
> +		.name	= "mlx90614",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe = mlx90614_probe,
> +	.remove = mlx90614_remove,
> +	.id_table = mlx90614_id,
> +};
> +module_i2c_driver(mlx90614_driver);
> +
> +MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
> +MODULE_DESCRIPTION("Melexis MLX90614 contactless IR temperature sensor driver");
> +MODULE_LICENSE("GPL");
>

