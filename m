Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42723 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab3HaRa7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:30:59 -0400
Message-ID: <52223664.7000803@kernel.org>
Date: Sat, 31 Aug 2013 19:31:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 1/9] staging: iio: ad7192: Use devm_* APIs
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/13 18:12, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> This series is compile tested and based on togreg branch
> of iio tree.

Just to note, there is a memory leak fixed by this patch as well
as the remove function didn't free the struct iio_dev before.

Thanks for these Sachin.  All look good to me.
I won't take them today as effectively IIO for 3.12 is now
closed, as I doubt we'll see more than one more rc on
3.11, and others may want to have time to look through these.

I'll pick them up in a few days and queue up for 3.13 assuming
no one spots anything I have missed.

Jonathan
> ---
>  drivers/staging/iio/adc/ad7192.c |   15 ++++-----------
>  1 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 3283e28..83bb44b 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -623,17 +623,17 @@ static int ad7192_probe(struct spi_device *spi)
>  		return -ENODEV;
>  	}
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->reg = regulator_get(&spi->dev, "vcc");
> +	st->reg = devm_regulator_get(&spi->dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
> -			goto error_put_reg;
> +			return ret;
>  
>  		voltage_uv = regulator_get_voltage(st->reg);
>  	}
> @@ -677,11 +677,6 @@ error_remove_trigger:
>  error_disable_reg:
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> -error_put_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_put(st->reg);
> -
> -	iio_device_free(indio_dev);
>  
>  	return ret;
>  }
> @@ -694,10 +689,8 @@ static int ad7192_remove(struct spi_device *spi)
>  	iio_device_unregister(indio_dev);
>  	ad_sd_cleanup_buffer_and_trigger(indio_dev);
>  
> -	if (!IS_ERR(st->reg)) {
> +	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> -		regulator_put(st->reg);
> -	}
>  
>  	return 0;
>  }
> 
