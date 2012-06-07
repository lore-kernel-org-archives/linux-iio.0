Return-Path: <jic23@kernel.org>
Message-ID: <4FD108C1.3020405@kernel.org>
Date: Thu, 07 Jun 2012 21:02:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/9] iio:adc:at91: Use new triggered buffer setup helper
References: <1338983756-31243-1-git-send-email-lars@metafoo.de> <1338983756-31243-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1338983756-31243-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/06/2012 12:55 PM, Lars-Peter Clausen wrote:
> Use the new triggered buffer setup helper function to allocate and register
> buffer and pollfunc.
> 
Other than dropping IIO_TRIGGER select this is fine.
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/adc/Kconfig    |    2 +-
>  drivers/iio/adc/at91_adc.c |   49 +++-----------------------------------------
>  2 files changed, 4 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9a0df81..bbd2291 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -7,7 +7,7 @@ config AT91_ADC
>  	tristate "Atmel AT91 ADC"
>  	depends on ARCH_AT91
>  	select IIO_BUFFER
> -	select IIO_KFIFO_BUF
> +	select IIO_TRIGGERED_BUFFER
>  	select IIO_TRIGGER
given IIO_TRIGGERED_BUFFER selects IIO_TRIGGER, drop that as well.
>  	select SYSFS
>  	help
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index f18a95d..ad2934a 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -318,58 +318,15 @@ static void at91_adc_trigger_remove(struct iio_dev *idev)
>  	}
>  }
>  
> -static const struct iio_buffer_setup_ops at91_adc_buffer_ops = {
> -	.preenable = &iio_sw_buffer_preenable,
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
> -};
> -
>  static int at91_adc_buffer_init(struct iio_dev *idev)
>  {
> -	int ret;
> -
> -	idev->buffer = iio_kfifo_allocate(idev);
> -	if (!idev->buffer) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> -
> -	idev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
> -					    &at91_adc_trigger_handler,
> -					    IRQF_ONESHOT,
> -					    idev,
> -					    "%s-consumer%d",
> -					    idev->name,
> -					    idev->id);
> -	if (idev->pollfunc == NULL) {
> -		ret = -ENOMEM;
> -		goto error_pollfunc;
> -	}
> -
> -	idev->setup_ops = &at91_adc_buffer_ops;
> -	idev->modes |= INDIO_BUFFER_TRIGGERED;
> -
> -	ret = iio_buffer_register(idev,
> -				  idev->channels,
> -				  idev->num_channels);
> -	if (ret)
> -		goto error_register;
> -
> -	return 0;
> -
> -error_register:
> -	iio_dealloc_pollfunc(idev->pollfunc);
> -error_pollfunc:
> -	iio_kfifo_free(idev->buffer);
> -error_ret:
> -	return ret;
> +	return iio_triggered_buffer_setup(idev, &iio_pollfunc_store_time,
> +		&at91_adc_trigger_handler, NULL);
>  }
>  
>  static void at91_adc_buffer_remove(struct iio_dev *idev)
>  {
> -	iio_buffer_unregister(idev);
> -	iio_dealloc_pollfunc(idev->pollfunc);
> -	iio_kfifo_free(idev->buffer);
> +	iio_triggered_buffer_cleanup(idev);
>  }
>  
>  static int at91_adc_read_raw(struct iio_dev *idev,
