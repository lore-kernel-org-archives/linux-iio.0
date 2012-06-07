Return-Path: <jic23@kernel.org>
Message-ID: <4FD109CE.8040903@kernel.org>
Date: Thu, 07 Jun 2012 21:06:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/9] staging:iio:adc:ad7192: Use new triggered buffer
 setup helper function
References: <1338983756-31243-1-git-send-email-lars@metafoo.de> <1338983756-31243-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1338983756-31243-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/06/2012 12:55 PM, Lars-Peter Clausen wrote:
> Use the new triggered buffer setup helper function to allocate and register
> buffer and pollfunc.
Same comment about the select IIO_TRIGGER
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/adc/Kconfig  |    1 +
>  drivers/staging/iio/adc/ad7192.c |   47 ++++----------------------------------
>  2 files changed, 6 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 2490dd2..8958fca 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -137,6 +137,7 @@ config AD7192
>  	select IIO_BUFFER
>  	select IIO_KFIFO_BUF
>  	select IIO_TRIGGER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices AD7190,
>  	  AD7192 or AD7195 SPI analog to digital converters (ADC).
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 5eaeaf1..548c8bf 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -542,41 +542,13 @@ static const struct iio_buffer_setup_ops ad7192_ring_setup_ops = {
>  
>  static int ad7192_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  {
> -	int ret;
> -
> -	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
> -	if (!indio_dev->buffer) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> -	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
> -						 &ad7192_trigger_handler,
> -						 IRQF_ONESHOT,
> -						 indio_dev,
> -						 "ad7192_consumer%d",
> -						 indio_dev->id);
> -	if (indio_dev->pollfunc == NULL) {
> -		ret = -ENOMEM;
> -		goto error_deallocate_kfifo;
> -	}
> -
> -	/* Ring buffer functions - here trigger setup related */
> -	indio_dev->setup_ops = &ad7192_ring_setup_ops;
> -
> -	/* Flag that polled ring buffering is possible */
> -	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> -	return 0;
> -
> -error_deallocate_kfifo:
> -	iio_kfifo_free(indio_dev->buffer);
> -error_ret:
> -	return ret;
> +	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +			&ad7192_trigger_handler, &ad7192_ring_setup_ops);
>  }
>  
>  static void ad7192_ring_cleanup(struct iio_dev *indio_dev)
>  {
> -	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_kfifo_free(indio_dev->buffer);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  }
>  
>  /**
> @@ -1077,23 +1049,15 @@ static int __devinit ad7192_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_ring_cleanup;
>  
> -	ret = iio_buffer_register(indio_dev,
> -				  indio_dev->channels,
> -				  indio_dev->num_channels);
> -	if (ret)
> -		goto error_remove_trigger;
> -
>  	ret = ad7192_setup(st);
>  	if (ret)
> -		goto error_unreg_ring;
> +		goto error_remove_trigger;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
> -		goto error_unreg_ring;
> +		goto error_remove_trigger;
>  	return 0;
>  
> -error_unreg_ring:
> -	iio_buffer_unregister(indio_dev);
>  error_remove_trigger:
>  	ad7192_remove_trigger(indio_dev);
>  error_ring_cleanup:
> @@ -1116,7 +1080,6 @@ static int ad7192_remove(struct spi_device *spi)
>  	struct ad7192_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	iio_buffer_unregister(indio_dev);
>  	ad7192_remove_trigger(indio_dev);
>  	ad7192_ring_cleanup(indio_dev);
>  
