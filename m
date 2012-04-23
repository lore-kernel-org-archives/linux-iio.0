Return-Path: <jic23@kernel.org>
Message-ID: <4F95BEE0.6090803@kernel.org>
Date: Mon, 23 Apr 2012 21:43:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 3/8] staging:iio:dac:ad5446: Do not check for individual
 chip ids in probe
References: <1335203497-11041-1-git-send-email-lars@metafoo.de> <1335203497-11041-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1335203497-11041-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/23/2012 06:51 PM, Lars-Peter Clausen wrote:
> Use the chip_info's int_vref_mv field to decide whether a certain chip has a
> internal reference or not. There is no need to check for individual chip ids.
> 
That does indeed do the job.
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/ad5446.c |   20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index 0cfe445..9d9a452 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -355,22 +355,12 @@ static int __devinit ad5446_probe(struct spi_device *spi)
>  	spi_message_init(&st->msg);
>  	spi_message_add_tail(&st->xfer, &st->msg);
>  
> -	switch (spi_get_device_id(spi)->driver_data) {
> -	case ID_AD5620_2500:
> -	case ID_AD5620_1250:
> -	case ID_AD5640_2500:
> -	case ID_AD5640_1250:
> -	case ID_AD5660_2500:
> -	case ID_AD5660_1250:
> +	if (st->chip_info->int_vref_mv)
>  		st->vref_mv = st->chip_info->int_vref_mv;
> -		break;
> -	default:
> -		if (voltage_uv)
> -			st->vref_mv = voltage_uv / 1000;
> -		else
> -			dev_warn(&spi->dev,
> -				 "reference voltage unspecified\n");
> -	}
> +	else if (voltage_uv)
> +		st->vref_mv = voltage_uv / 1000;
> +	else
> +		dev_warn(&spi->dev, "reference voltage unspecified\n");
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
