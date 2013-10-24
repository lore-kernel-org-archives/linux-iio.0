Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-175.synserver.de ([212.40.185.175]:1112 "EHLO
	smtp-out-175.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab3JXJlR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 05:41:17 -0400
Message-ID: <5268EB39.7010208@metafoo.de>
Date: Thu, 24 Oct 2013 11:41:13 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Jonathan Cameron <jic23@kernel.org>, Felipe Balbi <balbi@ti.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: do not free the kfifo twice
References: <9ctn6ye3lkct930eq1ivw2wc.1382550258829@email.android.com> <5268F2C9.5010104@kernel.org> <5268E773.3020507@linutronix.de>
In-Reply-To: <5268E773.3020507@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/2013 11:25 AM, Sebastian Andrzej Siewior wrote:
> On 10/24/2013 12:13 PM, Jonathan Cameron wrote:
>> On 10/23/13 18:44, Lars-Peter Clausen wrote:
>>> The code is actually fine as it is. The iio_kfifo_free() function drops a reference, but does not free the buffer's memory if somebody else is still holding a reference.
>>>
>>> - Lars
>> I'm guessing this came from a crash though.... Sebastian, what motivated the patch?
> 
> tiadc_iio_buffered_hardware_remove() in staging-next looks like this:
> 
>  static void tiadc_iio_buffered_hardware_remove(struct iio_dev *indio_dev)
>  {
>          struct tiadc_device *adc_dev = iio_priv(indio_dev);
> 
>          free_irq(adc_dev->mfd_tscadc->irq, indio_dev);
>          iio_kfifo_free(indio_dev->buffer);
>          iio_buffer_unregister(indio_dev);
>  }
> 
> and is called rmmod time. iio_kfifo_free() cleans up the buffer (there
> is not a second reference so the memory is gone.
> iio_buffer_unregister() crashes later because
> 
> void iio_buffer_unregister(struct iio_dev *indio_dev)
> {
>         kfree(indio_dev->buffer->scan_mask);
>         kfree(indio_dev->buffer->scan_el_group.attrs);
> 
> iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
>  }
> 
> the first kree() is looking at ->buffer which is gone by now. So at
> first I changed switched the order of the two (iio_kfifi_free() and
> iio_buffer_unregister()) and I had a crash later because iio_core
> removes the buffer as well.
> So I dropped the iio_kfifo_free() call since it seems to be already
> done.

The driver seems to be missing the iio_buffer_attach() call. Something like
this should fix the problem:

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index ef54d8a..bf9c89c 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -229,12 +229,15 @@ static int tiadc_iio_buffered_hardware_setup(struct
iio_dev *indio_dev,
 	unsigned long flags,
 	const struct iio_buffer_setup_ops *setup_ops)
 {
+	struct iio_buffer *buffer;
 	int ret;

-	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
-	if (!indio_dev->buffer)
+	buffer = iio_kfifo_allocate(indio_dev);
+	if (!buffer)
 		return -ENOMEM;

+	iio_device_attach_buffer(indio_dev, buffer);
+
 	ret = request_threaded_irq(irq,	pollfunc_th, pollfunc_bh,
 				flags, indio_dev->name, indio_dev);
 	if (ret)

