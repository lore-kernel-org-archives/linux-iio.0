Return-Path: <bigeasy@linutronix.de>
Message-ID: <5268FB95.7010601@linutronix.de>
Date: Thu, 24 Oct 2013 12:51:01 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, Felipe Balbi <balbi@ti.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: do not free the kfifo twice
References: <9ctn6ye3lkct930eq1ivw2wc.1382550258829@email.android.com> <5268F2C9.5010104@kernel.org> <5268E773.3020507@linutronix.de> <5268EB39.7010208@metafoo.de> <5268F7BD.2010508@linutronix.de> <5268F9F7.5020701@metafoo.de>
In-Reply-To: <5268F9F7.5020701@metafoo.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 10/24/2013 12:44 PM, Lars-Peter Clausen wrote:
>> Shouldn't the two
>>
>>          tiadc_iio_buffered_hardware_remove(indio_dev);
>>          tiadc_channels_remove(indio_dev);
>>
>> in tiadc_remove() be reversed in their call order? The second alter is
>> accessing the buffer which is released by the former one.
>>
> 
> As far as I can see tiadc_channels_remove() only does a
> kfree(indio_dev->channels), so it does not access the buffer at all.

I'm sorry I meant
         iio_kfifo_free(indio_dev->buffer);
         iio_buffer_unregister(indio_dev);

in tiadc_iio_buffered_hardware_remove()

>> btw: is all this ref counting really required? I mean I would assume
>> allocate buffer in one place (at probe time) release it remove time
>> should be enough.
> 
> It is required. Userspace may still be reading from the buffer when the
> driver frees it. So we need proper refcounting here.

Ach okay then.

Sebastian
