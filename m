Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45648 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbaJJKnO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Oct 2014 06:43:14 -0400
Message-ID: <5436DE42.5090809@kernel.org>
Date: Thu, 09 Oct 2014 20:13:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?U8O4cmVuIEFuZGVyc2Vu?= <san@rosetechnology.dk>
CC: linux-iio@vger.kernel.org
Subject: Re: [patch v4 2/3] iio: adc: mcp320x. Add support for more ADCs
References: <1412793720.3626.2.camel@sanws1.rosetechnology.dk>
In-Reply-To: <1412793720.3626.2.camel@sanws1.rosetechnology.dk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/10/14 19:42, Søren Andersen wrote:
> Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
Looks good.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
> Changes since v1:
> *Rename the file
>
> Changes since v2:
> * Functions moved around.
> * Return values is simpler
>
> Changes since v3:
> * Functions moved around, not to have any prototypes.
> * Return values is simpler
> * Added datasheet reference again
>
>  drivers/iio/adc/mcp320x.c | 222 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 187 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 28a086e..efbfd12 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -1,9 +1,30 @@
>  /*
>   * Copyright (C) 2013 Oskar Andero <oskar.andero@gmail.com>
> + * Copyright (C) 2014 Rose Technology
> + * 	   Allan Bendorff Jensen <abj@rosetechnology.dk>
> + *	   Soren Andersen <san@rosetechnology.dk>
> + *
> + * Driver for following ADC chips from Microchip Technology's:
> + * 10 Bit converter
> + * MCP3001
> + * MCP3002
> + * MCP3004
> + * MCP3008
> + * ------------
> + * 12 bit converter
> + * MCP3201
> + * MCP3202
> + * MCP3204
> + * MCP3208
> + * ------------
>   *
> - * Driver for Microchip Technology's MCP3204 and MCP3208 ADC chips.
>   * Datasheet can be found here:
> - * http://ww1.microchip.com/downloads/en/devicedoc/21298c.pdf
> + * http://ww1.microchip.com/downloads/en/DeviceDoc/21293C.pdf  mcp3001
> + * http://ww1.microchip.com/downloads/en/DeviceDoc/21294E.pdf  mcp3002
> + * http://ww1.microchip.com/downloads/en/DeviceDoc/21295d.pdf  mcp3004/08
> + * http://ww1.microchip.com/downloads/en/DeviceDoc/21290D.pdf  mcp3201
> + * http://ww1.microchip.com/downloads/en/DeviceDoc/21034D.pdf  mcp3202
> + * http://ww1.microchip.com/downloads/en/DeviceDoc/21298c.pdf  mcp3204/08
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -11,19 +32,29 @@
>   */
>
>  #include <linux/err.h>
> +#include <linux/delay.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
>
> -#define MCP_SINGLE_ENDED	(1 << 3)
> -#define MCP_START_BIT		(1 << 4)
> -
>  enum {
> +	mcp3001,
> +	mcp3002,
> +	mcp3004,
> +	mcp3008,
> +	mcp3201,
> +	mcp3202,
>  	mcp3204,
>  	mcp3208,
>  };
>
> +struct mcp320x_chip_info {
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +	unsigned int resolution;
> +};
> +
>  struct mcp320x {
>  	struct spi_device *spi;
>  	struct spi_message msg;
> @@ -34,19 +65,69 @@ struct mcp320x {
>
>  	struct regulator *reg;
>  	struct mutex lock;
> +	const struct mcp320x_chip_info *chip_info;
>  };
>
> -static int mcp320x_adc_conversion(struct mcp320x *adc, u8 msg)
> +static int mcp320x_channel_to_tx_data(int device_index,
> +			const unsigned int channel, bool differential)
> +{
> +	int start_bit = 1;
> +
> +	switch (device_index) {
> +	case mcp3001:
> +	case mcp3201:
> +		return 0;
> +	case mcp3002:
> +	case mcp3202:
> +		return ((start_bit << 4) | (!differential << 3) |
> +							(channel << 2));
> +	case mcp3004:
> +	case mcp3204:
> +	case mcp3008:
> +	case mcp3208:
> +		return ((start_bit << 6) | (!differential << 5) |
> +							(channel << 2));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
> +				  bool differential, int device_index)
>  {
>  	int ret;
>
> -	adc->tx_buf = msg;
> -	ret = spi_sync(adc->spi, &adc->msg);
> -	if (ret < 0)
> -		return ret;
> +	adc->rx_buf[0] = 0;
> +	adc->rx_buf[1] = 0;
> +	adc->tx_buf = mcp320x_channel_to_tx_data(device_index,
> +						channel, differential);
> +
> +	if (device_index != mcp3001 && device_index != mcp3201) {
> +		ret = spi_sync(adc->spi, &adc->msg);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		ret = spi_read(adc->spi, &adc->rx_buf, sizeof(adc->rx_buf));
> +		if (ret < 0)
> +			return ret;
> +	}
>
> -	return ((adc->rx_buf[0] & 0x3f) << 6)  |
> -		(adc->rx_buf[1] >> 2);
> +	switch (device_index) {
> +	case mcp3001:
> +		return (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
> +	case mcp3002:
> +	case mcp3004:
> +	case mcp3008:
> +		return (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
> +	case mcp3201:
> +		return (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
> +	case mcp3202:
> +	case mcp3204:
> +	case mcp3208:
> +		return (adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4);
> +	default:
> +		return -EINVAL;
> +	}
>  }
>
>  static int mcp320x_read_raw(struct iio_dev *indio_dev,
> @@ -55,18 +136,17 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct mcp320x *adc = iio_priv(indio_dev);
>  	int ret = -EINVAL;
> +	int device_index = 0;
>
>  	mutex_lock(&adc->lock);
>
> +	device_index = spi_get_device_id(adc->spi)->driver_data;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (channel->differential)
> -			ret = mcp320x_adc_conversion(adc,
> -				MCP_START_BIT | channel->address);
> -		else
> -			ret = mcp320x_adc_conversion(adc,
> -				MCP_START_BIT | MCP_SINGLE_ENDED |
> -				channel->address);
> +		ret = mcp320x_adc_conversion(adc, channel->address,
> +			channel->differential, device_index);
> +
>  		if (ret < 0)
>  			goto out;
>
> @@ -75,18 +155,15 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
>  		break;
>
>  	case IIO_CHAN_INFO_SCALE:
> -		/* Digital output code = (4096 * Vin) / Vref */
>  		ret = regulator_get_voltage(adc->reg);
>  		if (ret < 0)
>  			goto out;
>
> +		/* convert regulator output voltage to mV */
>  		*val = ret / 1000;
> -		*val2 = 12;
> +		*val2 = adc->chip_info->resolution;
>  		ret = IIO_VAL_FRACTIONAL_LOG2;
>  		break;
> -
> -	default:
> -		break;
>  	}
>
>  out:
> @@ -117,6 +194,16 @@ out:
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
>  	}
>
> +static const struct iio_chan_spec mcp3201_channels[] = {
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
> +};
> +
> +static const struct iio_chan_spec mcp3202_channels[] = {
> +	MCP320X_VOLTAGE_CHANNEL(0),
> +	MCP320X_VOLTAGE_CHANNEL(1),
> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
> +};
> +
>  static const struct iio_chan_spec mcp3204_channels[] = {
>  	MCP320X_VOLTAGE_CHANNEL(0),
>  	MCP320X_VOLTAGE_CHANNEL(1),
> @@ -146,19 +233,46 @@ static const struct iio_info mcp320x_info = {
>  	.driver_module = THIS_MODULE,
>  };
>
> -struct mcp3208_chip_info {
> -	const struct iio_chan_spec *channels;
> -	unsigned int num_channels;
> -};
> -
> -static const struct mcp3208_chip_info mcp3208_chip_infos[] = {
> +static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
> +	[mcp3001] = {
> +		.channels = mcp3201_channels,
> +		.num_channels = ARRAY_SIZE(mcp3201_channels),
> +		.resolution = 10
> +	},
> +	[mcp3002] = {
> +		.channels = mcp3202_channels,
> +		.num_channels = ARRAY_SIZE(mcp3202_channels),
> +		.resolution = 10
> +	},
> +	[mcp3004] = {
> +		.channels = mcp3204_channels,
> +		.num_channels = ARRAY_SIZE(mcp3204_channels),
> +		.resolution = 10
> +	},
> +	[mcp3008] = {
> +		.channels = mcp3208_channels,
> +		.num_channels = ARRAY_SIZE(mcp3208_channels),
> +		.resolution = 10
> +	},
> +	[mcp3201] = {
> +		.channels = mcp3201_channels,
> +		.num_channels = ARRAY_SIZE(mcp3201_channels),
> +		.resolution = 12
> +	},
> +	[mcp3202] = {
> +		.channels = mcp3202_channels,
> +		.num_channels = ARRAY_SIZE(mcp3202_channels),
> +		.resolution = 12
> +	},
>  	[mcp3204] = {
>  		.channels = mcp3204_channels,
> -		.num_channels = ARRAY_SIZE(mcp3204_channels)
> +		.num_channels = ARRAY_SIZE(mcp3204_channels),
> +		.resolution = 12
>  	},
>  	[mcp3208] = {
>  		.channels = mcp3208_channels,
> -		.num_channels = ARRAY_SIZE(mcp3208_channels)
> +		.num_channels = ARRAY_SIZE(mcp3208_channels),
> +		.resolution = 12
>  	},
>  };
>
> @@ -166,7 +280,7 @@ static int mcp320x_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct mcp320x *adc;
> -	const struct mcp3208_chip_info *chip_info;
> +	const struct mcp320x_chip_info *chip_info;
>  	int ret;
>
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> @@ -181,7 +295,7 @@ static int mcp320x_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &mcp320x_info;
>
> -	chip_info = &mcp3208_chip_infos[spi_get_device_id(spi)->driver_data];
> +	chip_info = &mcp320x_chip_infos[spi_get_device_id(spi)->driver_data];
>  	indio_dev->channels = chip_info->channels;
>  	indio_dev->num_channels = chip_info->num_channels;
>
> @@ -226,7 +340,45 @@ static int mcp320x_remove(struct spi_device *spi)
>  	return 0;
>  }
>
> +#if defined(CONFIG_OF)
> +static const struct of_device_id mcp320x_dt_ids[] = {
> +	{
> +		.compatible = "mcp3001",
> +		.data = &mcp320x_chip_infos[mcp3001],
> +	}, {
> +		.compatible = "mcp3002",
> +		.data = &mcp320x_chip_infos[mcp3002],
> +	}, {
> +		.compatible = "mcp3004",
> +		.data = &mcp320x_chip_infos[mcp3004],
> +	}, {
> +		.compatible = "mcp3008",
> +		.data = &mcp320x_chip_infos[mcp3008],
> +	}, {
> +		.compatible = "mcp3201",
> +		.data = &mcp320x_chip_infos[mcp3201],
> +	}, {
> +		.compatible = "mcp3202",
> +		.data = &mcp320x_chip_infos[mcp3202],
> +	}, {
> +		.compatible = "mcp3204",
> +		.data = &mcp320x_chip_infos[mcp3204],
> +	}, {
> +		.compatible = "mcp3208",
> +		.data = &mcp320x_chip_infos[mcp3208],
> +	}, {
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
> +#endif
> +
>  static const struct spi_device_id mcp320x_id[] = {
> +	{ "mcp3001", mcp3001 },
> +	{ "mcp3002", mcp3002 },
> +	{ "mcp3004", mcp3004 },
> +	{ "mcp3008", mcp3008 },
> +	{ "mcp3201", mcp3201 },
> +	{ "mcp3202", mcp3202 },
>  	{ "mcp3204", mcp3204 },
>  	{ "mcp3208", mcp3208 },
>  	{ }
> @@ -245,5 +397,5 @@ static struct spi_driver mcp320x_driver = {
>  module_spi_driver(mcp320x_driver);
>
>  MODULE_AUTHOR("Oskar Andero <oskar.andero@gmail.com>");
> -MODULE_DESCRIPTION("Microchip Technology MCP3204/08");
> +MODULE_DESCRIPTION("Microchip Technology MCP3x01/02/04/08");
>  MODULE_LICENSE("GPL v2");
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
