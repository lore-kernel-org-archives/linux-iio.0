Return-Path: <jic23@kernel.org>
Message-ID: <4ED7EA7D.3010903@kernel.org>
Date: Thu, 01 Dec 2011 20:58:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH 07/10] staging:iio:adc:max1363: Use new ringbuffer setup
 helper function
References: <1322749170-21407-1-git-send-email-lars@metafoo.de> <1322749170-21407-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1322749170-21407-8-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/01/2011 02:19 PM, Lars-Peter Clausen wrote:
> Use the new ringbuffer setup helper function to allocate and register buffer and
> pollfunc.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/adc/max1363_core.c |    9 ------
>  drivers/staging/iio/adc/max1363_ring.c |   43 ++-----------------------------
>  2 files changed, 3 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
> index 1ce89ef..a14329e 100644
> --- a/drivers/staging/iio/adc/max1363_core.c
> +++ b/drivers/staging/iio/adc/max1363_core.c
> @@ -1306,12 +1306,6 @@ static int __devinit max1363_probe(struct i2c_client *client,
>  	if (ret)
>  		goto error_free_available_scan_masks;
>  
> -	ret = iio_buffer_register(indio_dev,
> -				  st->chip_info->channels,
> -				  st->chip_info->num_channels);
> -	if (ret)
> -		goto error_cleanup_ring;
> -
>  	if (client->irq) {
>  		ret = request_threaded_irq(st->client->irq,
>  					   NULL,
> @@ -1332,8 +1326,6 @@ static int __devinit max1363_probe(struct i2c_client *client,
>  error_free_irq:
>  	free_irq(st->client->irq, indio_dev);
>  error_uninit_ring:
> -	iio_buffer_unregister(indio_dev);
> -error_cleanup_ring:
>  	max1363_ring_cleanup(indio_dev);
>  error_free_available_scan_masks:
>  	kfree(indio_dev->available_scan_masks);
> @@ -1356,7 +1348,6 @@ static int max1363_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  	if (client->irq)
>  		free_irq(st->client->irq, indio_dev);
> -	iio_buffer_unregister(indio_dev);
>  	max1363_ring_cleanup(indio_dev);
>  	kfree(indio_dev->available_scan_masks);
>  	if (!IS_ERR(reg)) {
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
> index d0a60a3..7a81070 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -89,50 +89,13 @@ done:
>  	return IRQ_HANDLED;
>  }
>  
> -static const struct iio_buffer_setup_ops max1363_ring_setup_ops = {
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.preenable = &iio_sw_buffer_preenable,
> -	.predisable = &iio_triggered_buffer_predisable,
> -};
> -
>  int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  {
> -	struct max1363_state *st = iio_priv(indio_dev);
> -	int ret = 0;
> -
> -	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
> -	if (!indio_dev->buffer) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> -	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
> -						 &max1363_trigger_handler,
> -						 IRQF_ONESHOT,
> -						 indio_dev,
> -						 "%s_consumer%d",
> -						 st->client->name,
> -						 indio_dev->id);
> -	if (indio_dev->pollfunc == NULL) {
> -		ret = -ENOMEM;
> -		goto error_deallocate_sw_rb;
> -	}
> -	/* Ring buffer functions - here trigger setup related */
> -	indio_dev->setup_ops = &max1363_ring_setup_ops;
> -
> -	/* Flag that polled ring buffering is possible */
> -	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> -
> -	return 0;
> -
> -error_deallocate_sw_rb:
> -	iio_sw_rb_free(indio_dev->buffer);
> -error_ret:
> -	return ret;
> +	return iio_sw_rb_simple_setup(indio_dev, NULL,
> +	    &max1363_trigger_handler);
>  }
>  
>  void max1363_ring_cleanup(struct iio_dev *indio_dev)
>  {
> -	/* ensure that the trigger has been detached */
> -	iio_dealloc_pollfunc(indio_dev->pollfunc);
> -	iio_sw_rb_free(indio_dev->buffer);
> +	iio_sw_rb_simple_cleanup(indio_dev);
>  }
