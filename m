Return-Path: <jic23@kernel.org>
Message-ID: <4FD10BC0.4090900@kernel.org>
Date: Thu, 07 Jun 2012 21:14:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/9] staging:iio:adc:ad7606: Use new triggered buffer
 setup helper function
References: <1338983756-31243-1-git-send-email-lars@metafoo.de> <1338983756-31243-7-git-send-email-lars@metafoo.de> <4FD10B6C.3080005@kernel.org>
In-Reply-To: <4FD10B6C.3080005@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/07/2012 09:13 PM, Jonathan Cameron wrote:
> On 06/06/2012 12:55 PM, Lars-Peter Clausen wrote:
>> Use the new triggered buffer setup helper function to allocate and register
>> buffer and pollfunc.
>>
>> Also as part of the conversion drop scan_timestamp being enabled by default,
>> since it is a left over of an earlier cleanup.
Oops, forgot the same excess select statements issue is here too..
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/staging/iio/adc/Kconfig       |    1 +
>>  drivers/staging/iio/adc/ad7606_core.c |    9 -------
>>  drivers/staging/iio/adc/ad7606_ring.c |   44 +++------------------------------
>>  3 files changed, 5 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
>> index 2f057e4..4761c58 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -27,6 +27,7 @@ config AD7606
>>  	select IIO_BUFFER
>>  	select IIO_TRIGGER
>>  	select IIO_KFIFO_BUF
>> +	select IIO_TRIGGERED_BUFFER
>>  	help
>>  	  Say yes here to build support for Analog Devices:
>>  	  ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
>> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
>> index 10ab6dc..954ac3e 100644
>> --- a/drivers/staging/iio/adc/ad7606_core.c
>> +++ b/drivers/staging/iio/adc/ad7606_core.c
>> @@ -532,20 +532,12 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
>>  	if (ret)
>>  		goto error_free_irq;
>>  
>> -	ret = iio_buffer_register(indio_dev,
>> -				  indio_dev->channels,
>> -				  indio_dev->num_channels);
>> -	if (ret)
>> -		goto error_cleanup_ring;
>>  	ret = iio_device_register(indio_dev);
>>  	if (ret)
>>  		goto error_unregister_ring;
>>  
>>  	return indio_dev;
>>  error_unregister_ring:
>> -	iio_buffer_unregister(indio_dev);
>> -
>> -error_cleanup_ring:
>>  	ad7606_ring_cleanup(indio_dev);
>>  
>>  error_free_irq:
>> @@ -570,7 +562,6 @@ int ad7606_remove(struct iio_dev *indio_dev, int irq)
>>  	struct ad7606_state *st = iio_priv(indio_dev);
>>  
>>  	iio_device_unregister(indio_dev);
>> -	iio_buffer_unregister(indio_dev);
>>  	ad7606_ring_cleanup(indio_dev);
>>  
>>  	free_irq(irq, indio_dev);
>> diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
>> index 24ce8fc..8637d99 100644
>> --- a/drivers/staging/iio/adc/ad7606_ring.c
>> +++ b/drivers/staging/iio/adc/ad7606_ring.c
>> @@ -91,54 +91,18 @@ done:
>>  	kfree(buf);
>>  }
>>  
>> -static const struct iio_buffer_setup_ops ad7606_ring_setup_ops = {
>> -	.preenable = &iio_sw_buffer_preenable,
>> -	.postenable = &iio_triggered_buffer_postenable,
>> -	.predisable = &iio_triggered_buffer_predisable,
>> -};
>> -
>>  int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>>  {
>>  	struct ad7606_state *st = iio_priv(indio_dev);
>> -	int ret;
>> -
>> -	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
>> -	if (!indio_dev->buffer) {
>> -		ret = -ENOMEM;
>> -		goto error_ret;
>> -	}
>> -
>> -	indio_dev->pollfunc = iio_alloc_pollfunc(&ad7606_trigger_handler_th_bh,
>> -						 &ad7606_trigger_handler_th_bh,
>> -						 0,
>> -						 indio_dev,
>> -						 "%s_consumer%d",
>> -						 indio_dev->name,
>> -						 indio_dev->id);
>> -	if (indio_dev->pollfunc == NULL) {
>> -		ret = -ENOMEM;
>> -		goto error_deallocate_kfifo;
>> -	}
>> -
>> -	/* Ring buffer functions - here trigger setup related */
>> -
>> -	indio_dev->setup_ops = &ad7606_ring_setup_ops;
>> -	indio_dev->buffer->scan_timestamp = true;
>>  
>>  	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
>>  
>> -	/* Flag that polled ring buffering is possible */
>> -	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>> -	return 0;
>> -
>> -error_deallocate_kfifo:
>> -	iio_kfifo_free(indio_dev->buffer);
>> -error_ret:
>> -	return ret;
>> +	return iio_triggered_buffer_setup(indio_dev,
>> +		&ad7606_trigger_handler_th_bh, &ad7606_trigger_handler_th_bh,
>> +		NULL);
>>  }
>>  
>>  void ad7606_ring_cleanup(struct iio_dev *indio_dev)
>>  {
>> -	iio_dealloc_pollfunc(indio_dev->pollfunc);
>> -	iio_kfifo_free(indio_dev->buffer);
>> +	iio_triggered_buffer_cleanup(indio_dev);
>>  }
> 
