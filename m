Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44828 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932560AbcBIWDX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 17:03:23 -0500
Subject: Re: [PATCH] staging:iio:ad7192: Add support for the AD7193
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1454928304-18838-1-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56BA6228.30907@kernel.org>
Date: Tue, 9 Feb 2016 22:03:20 +0000
MIME-Version: 1.0
In-Reply-To: <1454928304-18838-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/16 10:45, Lars-Peter Clausen wrote:
> The AD7193 is mostly register map compatible to the AD7192. The main
> difference is that it has 8 instead of 4 inputs, so the way the input
> channels are selected is slightly different.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Looks good.

Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/Kconfig  |  4 +--
>  drivers/staging/iio/adc/ad7192.c | 76 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 63 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 58d4517..a700f19 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -58,12 +58,12 @@ config AD7816
>  	  temperature sensors and ADC.
>  
>  config AD7192
> -	tristate "Analog Devices AD7190 AD7192 AD7195 ADC driver"
> +	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
>  	depends on SPI
>  	select AD_SIGMA_DELTA
>  	help
>  	  Say yes here to build support for Analog Devices AD7190,
> -	  AD7192 or AD7195 SPI analog to digital converters (ADC).
> +	  AD7192, AD7193 or AD7195 SPI analog to digital converters (ADC).
>  	  If unsure, say N (but it's safe to say "Y").
>  
>  	  To compile this driver as a module, choose M here: the
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 92f2b72..f843f19 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -1,7 +1,7 @@
>  /*
> - * AD7190 AD7192 AD7195 SPI ADC driver
> + * AD7190 AD7192 AD7193 AD7195 SPI ADC driver
>   *
> - * Copyright 2011-2012 Analog Devices Inc.
> + * Copyright 2011-2015 Analog Devices Inc.
>   *
>   * Licensed under the GPL-2.
>   */
> @@ -92,26 +92,43 @@
>  
>  #define AD7192_CONF_CHOP	BIT(23) /* CHOP enable */
>  #define AD7192_CONF_REFSEL	BIT(20) /* REFIN1/REFIN2 Reference Select */
> -#define AD7192_CONF_CHAN(x)	(((1 << (x)) & 0xFF) << 8) /* Channel select */
> -#define AD7192_CONF_CHAN_MASK	(0xFF << 8) /* Channel select mask */
> +#define AD7192_CONF_CHAN(x)	((x) << 8) /* Channel select */
> +#define AD7192_CONF_CHAN_MASK	(0x7FF << 8) /* Channel select mask */
>  #define AD7192_CONF_BURN	BIT(7) /* Burnout current enable */
>  #define AD7192_CONF_REFDET	BIT(6) /* Reference detect enable */
>  #define AD7192_CONF_BUF		BIT(4) /* Buffered Mode Enable */
>  #define AD7192_CONF_UNIPOLAR	BIT(3) /* Unipolar/Bipolar Enable */
>  #define AD7192_CONF_GAIN(x)	((x) & 0x7) /* Gain Select */
>  
> -#define AD7192_CH_AIN1P_AIN2M	0 /* AIN1(+) - AIN2(-) */
> -#define AD7192_CH_AIN3P_AIN4M	1 /* AIN3(+) - AIN4(-) */
> -#define AD7192_CH_TEMP		2 /* Temp Sensor */
> -#define AD7192_CH_AIN2P_AIN2M	3 /* AIN2(+) - AIN2(-) */
> -#define AD7192_CH_AIN1		4 /* AIN1 - AINCOM */
> -#define AD7192_CH_AIN2		5 /* AIN2 - AINCOM */
> -#define AD7192_CH_AIN3		6 /* AIN3 - AINCOM */
> -#define AD7192_CH_AIN4		7 /* AIN4 - AINCOM */
> +#define AD7192_CH_AIN1P_AIN2M	BIT(0) /* AIN1(+) - AIN2(-) */
> +#define AD7192_CH_AIN3P_AIN4M	BIT(1) /* AIN3(+) - AIN4(-) */
> +#define AD7192_CH_TEMP		BIT(2) /* Temp Sensor */
> +#define AD7192_CH_AIN2P_AIN2M	BIT(3) /* AIN2(+) - AIN2(-) */
> +#define AD7192_CH_AIN1		BIT(4) /* AIN1 - AINCOM */
> +#define AD7192_CH_AIN2		BIT(5) /* AIN2 - AINCOM */
> +#define AD7192_CH_AIN3		BIT(6) /* AIN3 - AINCOM */
> +#define AD7192_CH_AIN4		BIT(7) /* AIN4 - AINCOM */
> +
> +#define AD7193_CH_AIN1P_AIN2M	0x000  /* AIN1(+) - AIN2(-) */
> +#define AD7193_CH_AIN3P_AIN4M	0x001  /* AIN3(+) - AIN4(-) */
> +#define AD7193_CH_AIN5P_AIN6M	0x002  /* AIN5(+) - AIN6(-) */
> +#define AD7193_CH_AIN7P_AIN8M	0x004  /* AIN7(+) - AIN8(-) */
> +#define AD7193_CH_TEMP		0x100 /* Temp senseor */
> +#define AD7193_CH_AIN2P_AIN2M	0x200 /* AIN2(+) - AIN2(-) */
> +#define AD7193_CH_AIN1		0x401 /* AIN1 - AINCOM */
> +#define AD7193_CH_AIN2		0x402 /* AIN2 - AINCOM */
> +#define AD7193_CH_AIN3		0x404 /* AIN3 - AINCOM */
> +#define AD7193_CH_AIN4		0x408 /* AIN4 - AINCOM */
> +#define AD7193_CH_AIN5		0x410 /* AIN5 - AINCOM */
> +#define AD7193_CH_AIN6		0x420 /* AIN6 - AINCOM */
> +#define AD7193_CH_AIN7		0x440 /* AIN7 - AINCOM */
> +#define AD7193_CH_AIN8		0x480 /* AIN7 - AINCOM */
> +#define AD7193_CH_AINCOM	0x600 /* AINCOM - AINCOM */
>  
>  /* ID Register Bit Designations (AD7192_REG_ID) */
>  #define ID_AD7190		0x4
>  #define ID_AD7192		0x0
> +#define ID_AD7193		0x2
>  #define ID_AD7195		0x6
>  #define AD7192_ID_MASK		0x0F
>  
> @@ -607,6 +624,24 @@ static const struct iio_chan_spec ad7192_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>  
> +static const struct iio_chan_spec ad7193_channels[] = {
> +	AD_SD_DIFF_CHANNEL(0, 1, 2, AD7193_CH_AIN1P_AIN2M, 24, 32, 0),
> +	AD_SD_DIFF_CHANNEL(1, 3, 4, AD7193_CH_AIN3P_AIN4M, 24, 32, 0),
> +	AD_SD_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M, 24, 32, 0),
> +	AD_SD_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M, 24, 32, 0),
> +	AD_SD_TEMP_CHANNEL(4, AD7193_CH_TEMP, 24, 32, 0),
> +	AD_SD_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M, 24, 32, 0),
> +	AD_SD_CHANNEL(6, 1, AD7193_CH_AIN1, 24, 32, 0),
> +	AD_SD_CHANNEL(7, 2, AD7193_CH_AIN2, 24, 32, 0),
> +	AD_SD_CHANNEL(8, 3, AD7193_CH_AIN3, 24, 32, 0),
> +	AD_SD_CHANNEL(9, 4, AD7193_CH_AIN4, 24, 32, 0),
> +	AD_SD_CHANNEL(10, 5, AD7193_CH_AIN5, 24, 32, 0),
> +	AD_SD_CHANNEL(11, 6, AD7193_CH_AIN6, 24, 32, 0),
> +	AD_SD_CHANNEL(12, 7, AD7193_CH_AIN7, 24, 32, 0),
> +	AD_SD_CHANNEL(13, 8, AD7193_CH_AIN8, 24, 32, 0),
> +	IIO_CHAN_SOFT_TIMESTAMP(14),
> +};
> +
>  static int ad7192_probe(struct spi_device *spi)
>  {
>  	const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
> @@ -651,8 +686,18 @@ static int ad7192_probe(struct spi_device *spi)
>  	indio_dev->dev.parent = &spi->dev;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = ad7192_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
> +
> +	switch (st->devid) {
> +	case ID_AD7193:
> +		indio_dev->channels = ad7193_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7193_channels);
> +		break;
> +	default:
> +		indio_dev->channels = ad7192_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
> +		break;
> +	}
> +
>  	if (st->devid == ID_AD7195)
>  		indio_dev->info = &ad7195_info;
>  	else
> @@ -699,6 +744,7 @@ static int ad7192_remove(struct spi_device *spi)
>  static const struct spi_device_id ad7192_id[] = {
>  	{"ad7190", ID_AD7190},
>  	{"ad7192", ID_AD7192},
> +	{"ad7193", ID_AD7193},
>  	{"ad7195", ID_AD7195},
>  	{}
>  };
> @@ -715,5 +761,5 @@ static struct spi_driver ad7192_driver = {
>  module_spi_driver(ad7192_driver);
>  
>  MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> -MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7195 ADC");
> +MODULE_DESCRIPTION("Analog Devices AD7190, AD7192, AD7193, AD7195 ADC");
>  MODULE_LICENSE("GPL v2");
> 

