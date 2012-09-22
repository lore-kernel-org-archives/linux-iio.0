Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52867 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab2IVJ0J (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2012 05:26:09 -0400
Message-ID: <505D8432.2020705@kernel.org>
Date: Sat, 22 Sep 2012 10:26:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 2/2] staging:iio:ad7780: Add support for the ad7170/ad7171
References: <1348234148-22669-1-git-send-email-lars@metafoo.de> <1348234148-22669-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1348234148-22669-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/21/2012 02:29 PM, Lars-Peter Clausen wrote:
> The ad7170/ad7171 have a software interface similar to the ad7780. They do not
> have an external pin which allows to change the internal gain and the what is
> used for the gain bit in the ad7780/ad7781 becomes part of the check pattern.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
added to togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/adc/Kconfig  |    4 ++--
>  drivers/staging/iio/adc/ad7780.c |   36 ++++++++++++++++++++++++++++++------
>  2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 1b4a356..a525143 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -82,12 +82,12 @@ config AD7887
>  	  module will be called ad7887.
>  
>  config AD7780
> -	tristate "Analog Devices AD7780 AD7781 ADC driver"
> +	tristate "Analog Devices AD7780 and similar ADCs driver"
>  	depends on SPI
>  	depends on GPIOLIB
>  	select AD_SIGMA_DELTA
>  	help
> -	  Say yes here to build support for Analog Devices
> +	  Say yes here to build support for Analog Devices AD7170, AD7171,
>  	  AD7780 and AD7781 SPI analog to digital converters (ADC).
>  	  If unsure, say N (but it's safe to say "Y").
>  
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 1dd7cdb..0a1328b 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -1,5 +1,5 @@
>  /*
> - * AD7780/AD7781 SPI ADC driver
> + * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
>   *
> @@ -34,7 +34,9 @@
>  #define AD7780_PAT0	(1 << 0)
>  
>  struct ad7780_chip_info {
> -	struct iio_chan_spec		channel;
> +	struct iio_chan_spec	channel;
> +	unsigned int		pattern_mask;
> +	unsigned int		pattern;
>  };
>  
>  struct ad7780_state {
> @@ -48,6 +50,8 @@ struct ad7780_state {
>  };
>  
>  enum ad7780_supported_device_ids {
> +	ID_AD7170,
> +	ID_AD7171,
>  	ID_AD7780,
>  	ID_AD7781,
>  };
> @@ -109,9 +113,10 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
>  	unsigned int raw_sample)
>  {
>  	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
> +	const struct ad7780_chip_info *chip_info = st->chip_info;
>  
>  	if ((raw_sample & AD7780_ERR) ||
> -		!((raw_sample & AD7780_PAT0) && !(raw_sample & AD7780_PAT1)))
> +		((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
>  		return -EIO;
>  
>  	if (raw_sample & AD7780_GAIN)
> @@ -128,12 +133,29 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
>  	.has_registers = false,
>  };
>  
> +#define AD7780_CHANNEL(bits, wordsize) \
> +	AD_SD_CHANNEL(1, 0, 0, bits, 32, wordsize - bits)
> +
>  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
> +	[ID_AD7170] = {
> +		.channel = AD7780_CHANNEL(12, 24),
> +		.pattern = 0x5,
> +		.pattern_mask = 0x7,
> +	},
> +	[ID_AD7171] = {
> +		.channel = AD7780_CHANNEL(16, 24),
> +		.pattern = 0x5,
> +		.pattern_mask = 0x7,
> +	},
>  	[ID_AD7780] = {
> -		.channel = AD_SD_CHANNEL(1, 0, 0, 24, 32, 8),
> +		.channel = AD7780_CHANNEL(24, 32),
> +		.pattern = 0x1,
> +		.pattern_mask = 0x3,
>  	},
>  	[ID_AD7781] = {
> -		.channel = AD_SD_CHANNEL(1, 0, 0, 20, 32, 12),
> +		.channel = AD7780_CHANNEL(20, 32),
> +		.pattern = 0x1,
> +		.pattern_mask = 0x3,
>  	},
>  };
>  
> @@ -247,6 +269,8 @@ static int __devexit ad7780_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id ad7780_id[] = {
> +	{"ad7170", ID_AD7170},
> +	{"ad7171", ID_AD7171},
>  	{"ad7780", ID_AD7780},
>  	{"ad7781", ID_AD7781},
>  	{}
> @@ -265,5 +289,5 @@ static struct spi_driver ad7780_driver = {
>  module_spi_driver(ad7780_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> -MODULE_DESCRIPTION("Analog Devices AD7780/1 ADC");
> +MODULE_DESCRIPTION("Analog Devices AD7780 and similar ADCs");
>  MODULE_LICENSE("GPL v2");
> 
