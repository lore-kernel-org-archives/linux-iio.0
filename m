Return-Path: <bigeasy@linutronix.de>
Message-ID: <5268E773.3020507@linutronix.de>
Date: Thu, 24 Oct 2013 11:25:07 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Felipe Balbi <balbi@ti.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: do not free the kfifo twice
References: <9ctn6ye3lkct930eq1ivw2wc.1382550258829@email.android.com> <5268F2C9.5010104@kernel.org>
In-Reply-To: <5268F2C9.5010104@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 10/24/2013 12:13 PM, Jonathan Cameron wrote:
> On 10/23/13 18:44, Lars-Peter Clausen wrote:
>> The code is actually fine as it is. The iio_kfifo_free() function drops a reference, but does not free the buffer's memory if somebody else is still holding a reference.
>>
>> - Lars
> I'm guessing this came from a crash though.... Sebastian, what motivated the patch?

tiadc_iio_buffered_hardware_remove() in staging-next looks like this:

 static void tiadc_iio_buffered_hardware_remove(struct iio_dev *indio_dev)
 {
         struct tiadc_device *adc_dev = iio_priv(indio_dev);

         free_irq(adc_dev->mfd_tscadc->irq, indio_dev);
         iio_kfifo_free(indio_dev->buffer);
         iio_buffer_unregister(indio_dev);
 }

and is called rmmod time. iio_kfifo_free() cleans up the buffer (there
is not a second reference so the memory is gone.
iio_buffer_unregister() crashes later because

void iio_buffer_unregister(struct iio_dev *indio_dev)
{
        kfree(indio_dev->buffer->scan_mask);
        kfree(indio_dev->buffer->scan_el_group.attrs);

iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
 }

the first kree() is looking at ->buffer which is gone by now. So at
first I changed switched the order of the two (iio_kfifi_free() and
iio_buffer_unregister()) and I had a crash later because iio_core
removes the buffer as well.
So I dropped the iio_kfifo_free() call since it seems to be already
done.

Sebastian
