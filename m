Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49160 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570Ab3CQWmf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Mar 2013 18:42:35 -0400
Message-ID: <51462517.1000502@kernel.org>
Date: Sun, 17 Mar 2013 20:18:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Patrick Vasseur <patrick.vasseur@c-s.fr>,
	Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 3/3] iio:adc:ad7923: Add support for the ad7904/ad7914/ad7924
References: <1362425431-24725-1-git-send-email-lars@metafoo.de> <1362425431-24725-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1362425431-24725-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/2013 07:30 PM, Lars-Peter Clausen wrote:
> The ad7924 is software compatible with the ad7923. The ad7904 and ad7914 are the
> 8 and 10 bit version of the ad7924.
> 
> While we are at it also drop the "with temperature sensor" from the Kconfig
> entry, since the chips do not have a temperature sensor.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Patrick Vasseur <patrick.vasseur@c-s.fr>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
All three applied to togreg branch of iio.git

Thanks.
> ---
>  drivers/iio/adc/Kconfig  |  6 ++---
>  drivers/iio/adc/ad7923.c | 63 ++++++++++++++++++++++++++++++++++++++----------
>  2 files changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index a40d3c2..3f05834 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -31,13 +31,13 @@ config AD7298
>  	  module will be called ad7298.
>  
>  config AD7923
> -	tristate "Analog Devices AD7923 ADC driver"
> +	tristate "Analog Devices AD7923 and similar ADCs driver"
>  	depends on SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  Say yes here to build support for Analog Devices AD7923
> -	  4 Channel ADC with temperature sensor.
> +	  Say yes here to build support for Analog Devices
> +	  AD7904, AD7914, AD7923, AD7924 4 Channel ADCs.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7923.
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 11ccc42..97fa0d3 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -1,5 +1,5 @@
>  /*
> - * AD7923 SPI ADC driver
> + * AD7904/AD7914/AD7923/AD7924 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
>   * Copyright 2012 CS Systemes d'Information
> @@ -70,7 +70,18 @@ struct ad7923_state {
>  	__be16				tx_buf[4];
>  };
>  
> -#define AD7923_V_CHAN(index)						\
> +struct ad7923_chip_info {
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};
> +
> +enum ad7923_id {
> +	AD7904,
> +	AD7914,
> +	AD7924,
> +};
> +
> +#define AD7923_V_CHAN(index, bits)					\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.indexed = 1,						\
> @@ -81,18 +92,38 @@ struct ad7923_state {
>  		.scan_index = index,					\
>  		.scan_type = {						\
>  			.sign = 'u',					\
> -			.realbits = 12,					\
> +			.realbits = (bits),				\
>  			.storagebits = 16,				\
>  			.endianness = IIO_BE,				\
>  		},							\
>  	}
>  
> -static const struct iio_chan_spec ad7923_channels[] = {
> -	AD7923_V_CHAN(0),
> -	AD7923_V_CHAN(1),
> -	AD7923_V_CHAN(2),
> -	AD7923_V_CHAN(3),
> -	IIO_CHAN_SOFT_TIMESTAMP(4),
> +#define DECLARE_AD7923_CHANNELS(name, bits) \
> +const struct iio_chan_spec name ## _channels[] = { \
> +	AD7923_V_CHAN(0, bits), \
> +	AD7923_V_CHAN(1, bits), \
> +	AD7923_V_CHAN(2, bits), \
> +	AD7923_V_CHAN(3, bits), \
> +	IIO_CHAN_SOFT_TIMESTAMP(4), \
> +}
> +
> +static DECLARE_AD7923_CHANNELS(ad7904, 8);
> +static DECLARE_AD7923_CHANNELS(ad7914, 10);
> +static DECLARE_AD7923_CHANNELS(ad7924, 12);
> +
> +static const struct ad7923_chip_info ad7923_chip_info[] = {
> +	[AD7904] = {
> +		.channels = ad7904_channels,
> +		.num_channels = ARRAY_SIZE(ad7904_channels),
> +	},
> +	[AD7914] = {
> +		.channels = ad7914_channels,
> +		.num_channels = ARRAY_SIZE(ad7914_channels),
> +	},
> +	[AD7924] = {
> +		.channels = ad7924_channels,
> +		.num_channels = ARRAY_SIZE(ad7924_channels),
> +	},
>  };
>  
>  /**
> @@ -245,6 +276,7 @@ static int ad7923_probe(struct spi_device *spi)
>  {
>  	struct ad7923_state *st;
>  	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
> +	const struct ad7923_chip_info *info;
>  	int ret;
>  
>  	if (indio_dev == NULL)
> @@ -258,11 +290,13 @@ static int ad7923_probe(struct spi_device *spi)
>  	st->settings = AD7923_CODING | AD7923_RANGE |
>  			AD7923_PM_MODE_WRITE(AD7923_PM_MODE_OPS);
>  
> +	info = &ad7923_chip_info[spi_get_device_id(spi)->driver_data];
> +
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = ad7923_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ad7923_channels);
> +	indio_dev->channels = info->channels;
> +	indio_dev->num_channels = info->num_channels;
>  	indio_dev->info = &ad7923_info;
>  
>  	/* Setup default message */
> @@ -324,7 +358,10 @@ static int ad7923_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id ad7923_id[] = {
> -	{"ad7923", 0},
> +	{"ad7904", AD7904},
> +	{"ad7914", AD7914},
> +	{"ad7923", AD7924},
> +	{"ad7924", AD7924},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad7923_id);
> @@ -342,5 +379,5 @@ module_spi_driver(ad7923_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
>  MODULE_AUTHOR("Patrick Vasseur <patrick.vasseur@c-s.fr>");
> -MODULE_DESCRIPTION("Analog Devices AD7923 ADC");
> +MODULE_DESCRIPTION("Analog Devices AD7904/AD7914/AD7923/AD7924 ADC");
>  MODULE_LICENSE("GPL v2");
> 
