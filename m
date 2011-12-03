Return-Path: <lars@metafoo.de>
Message-ID: <4ED9FD99.8030704@metafoo.de>
Date: Sat, 03 Dec 2011 11:44:41 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH 05/10] staging:iio:gyro:adis16260: Use new ringbuffer
 setup helper function
References: <1322749170-21407-1-git-send-email-lars@metafoo.de> <1322749170-21407-6-git-send-email-lars@metafoo.de> <4ED7E9B8.5080206@kernel.org>
In-Reply-To: <4ED7E9B8.5080206@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/01/2011 09:55 PM, Jonathan Cameron wrote:
> On 12/01/2011 02:19 PM, Lars-Peter Clausen wrote:
>> Use the new ringbuffer setup helper function to allocate and register buffer and
>> pollfunc.
> Obviously it's unrelated to this patch, but why do we enable the
> timestamp by default for these?

I have actually no idea. Probably makes sens to not bother keeping it.

>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks.

Whats your plan for your buffer cleanup patches? They looked fine to me, except
the ones where I commented.

>> ---
>>  drivers/staging/iio/gyro/adis16260_core.c |   10 -------
>>  drivers/staging/iio/gyro/adis16260_ring.c |   39 ++++------------------------
>>  2 files changed, 6 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
>> index 871f76b..1e77eae 100644
>> --- a/drivers/staging/iio/gyro/adis16260_core.c
>> +++ b/drivers/staging/iio/gyro/adis16260_core.c
>> @@ -623,13 +623,6 @@ static int __devinit adis16260_probe(struct spi_device *spi)
>>  	if (ret)
>>  		goto error_free_dev;
>>  
>> -	ret = iio_buffer_register(indio_dev,
>> -				  indio_dev->channels,
>> -				  ARRAY_SIZE(adis16260_channels_x));
>> -	if (ret) {
>> -		printk(KERN_ERR "failed to initialize the ring\n");
>> -		goto error_unreg_ring_funcs;
>> -	}
>>  	if (indio_dev->buffer) {
>>  		/* Set default scan mode */
>>  		iio_scan_mask_set(indio_dev, indio_dev->buffer,
>> @@ -662,8 +655,6 @@ static int __devinit adis16260_probe(struct spi_device *spi)
>>  error_remove_trigger:
>>  	adis16260_remove_trigger(indio_dev);
>>  error_uninitialize_ring:
>> -	iio_buffer_unregister(indio_dev);
>> -error_unreg_ring_funcs:
>>  	adis16260_unconfigure_ring(indio_dev);
>>  error_free_dev:
>>  	iio_free_device(indio_dev);
>> @@ -685,7 +676,6 @@ static int adis16260_remove(struct spi_device *spi)
>>  	flush_scheduled_work();
>>  
>>  	adis16260_remove_trigger(indio_dev);
>> -	iio_buffer_unregister(indio_dev);
>>  	adis16260_unconfigure_ring(indio_dev);
>>  	iio_free_device(indio_dev);
>>  
>> diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
>> index 711f151..c2f5022 100644
>> --- a/drivers/staging/iio/gyro/adis16260_ring.c
>> +++ b/drivers/staging/iio/gyro/adis16260_ring.c
>> @@ -94,45 +94,18 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
>>  
>>  void adis16260_unconfigure_ring(struct iio_dev *indio_dev)
>>  {
>> -	iio_dealloc_pollfunc(indio_dev->pollfunc);
>> -	iio_sw_rb_free(indio_dev->buffer);
>> +	iio_sw_rb_simple_cleanup(indio_dev);
>>  }
>>  
>> -static const struct iio_buffer_setup_ops adis16260_ring_setup_ops = {
>> -	.preenable = &iio_sw_buffer_preenable,
>> -	.postenable = &iio_triggered_buffer_postenable,
>> -	.predisable = &iio_triggered_buffer_predisable,
>> -};
>> -
>>  int adis16260_configure_ring(struct iio_dev *indio_dev)
>>  {
>> -	int ret = 0;
>> -	struct iio_buffer *ring;
>> +	int ret;
>>  
>> -	ring = iio_sw_rb_allocate(indio_dev);
>> -	if (!ring) {
>> -		ret = -ENOMEM;
>> +	ret = iio_sw_rb_simple_setup(indio_dev, &iio_pollfunc_store_time,
>> +		&adis16260_trigger_handler);
>> +	if (ret)
>>  		return ret;
>> -	}
>> -	indio_dev->buffer = ring;
>> -	ring->scan_timestamp = true;
>> -	indio_dev->setup_ops = &adis16260_ring_setup_ops;
>> -
>> -	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
>> -						 &adis16260_trigger_handler,
>> -						 IRQF_ONESHOT,
>> -						 indio_dev,
>> -						 "adis16260_consumer%d",
>> -						 indio_dev->id);
>> -	if (indio_dev->pollfunc == NULL) {
>> -		ret = -ENOMEM;
>> -		goto error_iio_sw_rb_free;
>> -	}
>>  
>> -	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>> +	indio_dev->buffer->scan_timestamp = true;
>>  	return 0;
>> -
>> -error_iio_sw_rb_free:
>> -	iio_sw_rb_free(indio_dev->buffer);
>> -	return ret;
>>  }
> 
