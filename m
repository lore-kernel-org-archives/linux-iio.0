Return-Path: <lars@metafoo.de>
Message-ID: <5268F9F7.5020701@metafoo.de>
Date: Thu, 24 Oct 2013 12:44:07 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Jonathan Cameron <jic23@kernel.org>, Felipe Balbi <balbi@ti.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: do not free the kfifo twice
References: <9ctn6ye3lkct930eq1ivw2wc.1382550258829@email.android.com> <5268F2C9.5010104@kernel.org> <5268E773.3020507@linutronix.de> <5268EB39.7010208@metafoo.de> <5268F7BD.2010508@linutronix.de>
In-Reply-To: <5268F7BD.2010508@linutronix.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 10/24/2013 12:34 PM, Sebastian Andrzej Siewior wrote:
> On 10/24/2013 11:41 AM, Lars-Peter Clausen wrote:
>> The driver seems to be missing the iio_buffer_attach() call. Something like
>> this should fix the problem:
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index ef54d8a..bf9c89c 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -229,12 +229,15 @@ static int tiadc_iio_buffered_hardware_setup(struct
>> iio_dev *indio_dev,
>>  	unsigned long flags,
>>  	const struct iio_buffer_setup_ops *setup_ops)
>>  {
>> +	struct iio_buffer *buffer;
>>  	int ret;
>>
>> -	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
>> -	if (!indio_dev->buffer)
>> +	buffer = iio_kfifo_allocate(indio_dev);
>> +	if (!buffer)
>>  		return -ENOMEM;
>>
>> +	iio_device_attach_buffer(indio_dev, buffer);
>> +
>>  	ret = request_threaded_irq(irq,	pollfunc_th, pollfunc_bh,
>>  				flags, indio_dev->name, indio_dev);
>>  	if (ret)
> 
> Yep, that works, thanks.
> 
> Shouldn't the two
> 
>          tiadc_iio_buffered_hardware_remove(indio_dev);
>          tiadc_channels_remove(indio_dev);
> 
> in tiadc_remove() be reversed in their call order? The second alter is
> accessing the buffer which is released by the former one.
> 

As far as I can see tiadc_channels_remove() only does a
kfree(indio_dev->channels), so it does not access the buffer at all.

> btw: is all this ref counting really required? I mean I would assume
> allocate buffer in one place (at probe time) release it remove time
> should be enough.

It is required. Userspace may still be reading from the buffer when the
driver frees it. So we need proper refcounting here.
