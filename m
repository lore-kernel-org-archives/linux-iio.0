Return-Path: <jic23@kernel.org>
Message-ID: <4F96DB62.9050309@kernel.org>
Date: Tue, 24 Apr 2012 17:57:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH v2 10/11] staging:iio:dac:ad5446: Add support for the
 AD5662
References: <1335286181-20474-1-git-send-email-lars@metafoo.de> <1335286181-20474-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1335286181-20474-10-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/24/2012 05:49 PM, Lars-Peter Clausen wrote:
> The AD5662 is compatible to the AD5660, but uses an external
> reference instead of an internal.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/ad5446.c |    5 +++++
>  drivers/staging/iio/dac/ad5446.h |    1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index 9dc67c8..00b138e 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -217,6 +217,10 @@ static const struct ad5446_chip_info ad5446_chip_info_tbl[] = {
>  		.int_vref_mv = 1250,
>  		.write = ad5660_write,
>  	},
> +	[ID_AD5662] = {
> +		.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
> +		.write = ad5660_write,
> +	},
>  };
>  
>  static int ad5446_read_raw(struct iio_dev *indio_dev,
> @@ -370,6 +374,7 @@ static const struct spi_device_id ad5446_id[] = {
>  	{"ad5640-1250", ID_AD5640_1250},
>  	{"ad5660-2500", ID_AD5660_2500},
>  	{"ad5660-1250", ID_AD5660_1250},
> +	{"ad5662", ID_AD5662},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad5446_id);
> diff --git a/drivers/staging/iio/dac/ad5446.h b/drivers/staging/iio/dac/ad5446.h
> index 1a0fb4a..dfd68ce 100644
> --- a/drivers/staging/iio/dac/ad5446.h
> +++ b/drivers/staging/iio/dac/ad5446.h
> @@ -83,6 +83,7 @@ enum ad5446_supported_device_ids {
>  	ID_AD5640_1250,
>  	ID_AD5660_2500,
>  	ID_AD5660_1250,
> +	ID_AD5662,
>  };
>  
>  #endif /* IIO_DAC_AD5446_H_ */
