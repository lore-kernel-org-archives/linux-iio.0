Return-Path: <jic23@kernel.org>
Message-ID: <4FD10B3E.3070304@kernel.org>
Date: Thu, 07 Jun 2012 21:12:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/9] staging:iio:adc:ad7476: Use new triggered buffer
 setup helper function
References: <1338983756-31243-1-git-send-email-lars@metafoo.de> <1338983756-31243-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1338983756-31243-6-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/06/2012 12:55 PM, Lars-Peter Clausen wrote:
> Use the new triggered buffer setup helper function to allocate and register
> buffer and pollfunc.
> 
> Also as part of the conversion drop scan_timestamp being enabled by default,
> since it is a left over of an earlier cleanup.
Drop the excess select statements and I'm happy...
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/adc/Kconfig       |    1 +
>  drivers/staging/iio/adc/ad7476_core.c |    9 -------
>  drivers/staging/iio/adc/ad7476_ring.c |   44 +++------------------------------
>  3 files changed, 4 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index b9ff3d3..2f057e4 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -75,6 +75,7 @@ config AD7476
>  	select IIO_BUFFER
>  	select IIO_KFIFO_BUF
>  	select IIO_TRIGGER
here again and IIO_KFIFO_BUF as well this time...
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices
>  	  AD7475, AD7476, AD7477, AD7478, AD7466, AD7467, AD7468, AD7495
> diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
> index be1c260..4d30a79 100644
> --- a/drivers/staging/iio/adc/ad7476_core.c
> +++ b/drivers/staging/iio/adc/ad7476_core.c
> @@ -177,20 +177,12 @@ static int __devinit ad7476_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ret = iio_buffer_register(indio_dev,
> -				  st->chip_info->channel,
> -				  ARRAY_SIZE(st->chip_info->channel));
> -	if (ret)
> -		goto error_cleanup_ring;
> -
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
>  		goto error_ring_unregister;
>  	return 0;
>  
>  error_ring_unregister:
> -	iio_buffer_unregister(indio_dev);
> -error_cleanup_ring:
>  	ad7476_ring_cleanup(indio_dev);
>  error_disable_reg:
>  	if (!IS_ERR(st->reg))
> @@ -210,7 +202,6 @@ static int ad7476_remove(struct spi_device *spi)
>  	struct ad7476_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	iio_buffer_unregister(indio_dev);
>  	ad7476_ring_cleanup(indio_dev);
>  	if (!IS_ERR(st->reg)) {
>  		regulator_disable(st->reg);
> diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
> index 383611b..176c050 100644
> --- a/drivers/staging/iio/adc/ad7476_ring.c
> +++ b/drivers/staging/iio/adc/ad7476_ring.c
> @@ -52,51 +52,13 @@ done:
>  	return IRQ_HANDLED;
>  }
>  
> -static const struct iio_buffer_setup_ops ad7476_ring_setup_ops = {
> -	.preenable = &iio_sw_buffer_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
> -};
> -
>  int ad7476_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  {
> -	struct ad7476_state *st = iio_priv(indio_dev);
> -	int ret = 0;
> -
> -	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
> -	if (!indio_dev->buffer) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> -	indio_dev->pollfunc
> -		= iio_alloc_pollfunc(NULL,
> -				     &ad7476_trigger_handler,
> -				     IRQF_ONESHOT,
> -				     indio_dev,
> -				     "%s_consumer%d",
> -				     spi_get_device_id(st->spi)->name,
> -				     indio_dev->id);
> -	if (indio_dev->pollfunc == NULL) {
> -		ret = -ENOMEM;
> -		goto error_deallocate_kfifo;
> -	}
> -
> -	/* Ring buffer functions - here trigger setup related */
> -	indio_dev->setup_ops = &ad7476_ring_setup_ops;
> -	indio_dev->buffer->scan_timestamp = true;
> -
> -	/* Flag that polled ring buffering is possible */
> -	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> -	return 0;
> -
> -error_deallocate_kfifo:
> -	iio_kfifo_free(indio_dev->buffer);
> -error_ret:
> -	return ret;
> +	return iio_triggered_buffer_setup(indio_dev, NULL,
> +			&ad7476_trigger_handler, NULL);
>  }
>  
>  void ad7476_ring_cleanup(struct iio_dev *indio_dev)
>  {
> -	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_kfifo_free(indio_dev->buffer);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  }
