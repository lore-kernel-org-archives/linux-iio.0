Return-Path: <jic23@kernel.org>
Message-ID: <4F966001.5080708@kernel.org>
Date: Tue, 24 Apr 2012 09:10:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 8/8] staging:iio:dac:ad5446: Add support for the AD5662
References: <1335203497-11041-1-git-send-email-lars@metafoo.de> <1335203497-11041-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1335203497-11041-8-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 4/23/2012 6:51 PM, Lars-Peter Clausen wrote:
> The AD5662 is compatible to the AD5660, but uses an external reference instead
> of an internal.
Ah, I wondered why you were going though this driver with such a fine 
toothed comb!
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
> ---
>   drivers/staging/iio/dac/Kconfig  |    2 +-
>   drivers/staging/iio/dac/ad5446.c |    5 +++++
>   drivers/staging/iio/dac/ad5446.h |    1 +
>   3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
> index a57803a..1a2be98 100644
> --- a/drivers/staging/iio/dac/Kconfig
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -56,7 +56,7 @@ config AD5624R_SPI
>   	  AD5664R converters (DAC). This driver uses the common SPI interface.
>
>   config AD5446
> -	tristate "Analog Devices AD5444/6, AD5620/40/60 and AD5542A/12A DAC SPI driver"
> +	tristate "Analog Devices AD5444/6, AD5620/40/60/62 and AD5542A/12A DAC SPI driver"
>   	depends on SPI
>   	help
>   	  Say yes here to build support for Analog Devices AD5444, AD5446,
The odd bit is it is already in the description... hmm. There is quite a 
disconnect between parts in the two
lists... Don't suppose you'd mind verifying this and cleaning up.  At 
somepoint the list of parts in here
is going to get two long.  Maybe it is already time to go to "AD5444 and 
similar SPI DACs"
and rely on the help to tell people what it supports.
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index 90461b2..bcb849b 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -216,6 +216,10 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>   		.int_vref_mv = 1250,
>   		.store_sample = ad5660_store_sample,
>   	},
> +	[ID_AD5662] = {
> +		.channel = AD5446_CHANNEL(16, 16, 0),
> +		.store_sample = ad5660_store_sample,
> +	},
>   };
>
>   static int ad5446_read_raw(struct iio_dev *indio_dev,
> @@ -375,6 +379,7 @@ static const struct spi_device_id ad5446_id[] = {
>   	{"ad5640-1250", ID_AD5640_1250},
>   	{"ad5660-2500", ID_AD5660_2500},
>   	{"ad5660-1250", ID_AD5660_1250},
> +	{"ad5662", ID_AD5662},
>   	{}
>   };
>   MODULE_DEVICE_TABLE(spi, ad5446_id);
> diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
> index 264df1e..071ce39 100644
> --- a/drivers/staging/iio/dac/ad5446.h
> +++ b/drivers/staging/iio/dac/ad5446.h
> @@ -94,6 +94,7 @@ enum ad5446_supported_device_ids {
>   	ID_AD5640_1250,
>   	ID_AD5660_2500,
>   	ID_AD5660_1250,
> +	ID_AD5662,
>   };
>
>   #endif /* IIO_DAC_AD5446_H_ */
