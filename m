Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47868 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab2JMQFg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2012 12:05:36 -0400
Message-ID: <5079914C.3030100@kernel.org>
Date: Sat, 13 Oct 2012 17:05:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, maxime.ripard@free-electrons.com
Subject: Re: WARNING: at kernel/irq/handle.c, irq_default_primary_handler
 enabled interrupts
References: <alpine.DEB.2.01.1209280806040.15718@pmeerw.net> <alpine.DEB.2.01.1209290134230.8022@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1209290134230.8022@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/29/2012 12:44 AM, Peter Meerwald wrote:
> Hello myself :),
> 
>> si114x_irq() checks the irq status of the chip by reading and checking 
>> some register via i2c and then depending on the buffer being enabled or 
>> not
>>
>> 	if (iio_buffer_enabled(indio_dev))
>>         	iio_trigger_poll(indio_dev->trig, 0);
>>         else {
>> 		data->got_data = true;
>> 		wake_up_interruptible(&data->data_avail);
>> 	}
> 
> it should be iio_trigger_poll_chained(), not iio_trigger_poll(), since 
> this is an interrupt handler; this solves my WARN_ON()
That's not the reason, it's because you are calling it from a bottom half.
The nature of the trigger code is that it would normally be called from the
top half (as it's normally just calling a tree of other interrupt handlers
which may or may not have their own top halves.)

The chained call is probably ok, but does limit what other devices may use
this as a trigger source.  Lars-Peter had another approach that is used
in the sysfs trigger using irq_work_queues which might work here (I haven't
thought about it in much depth...) see drivers/staging/triggers/iio-trig-sysfs.c


Looking at rest of driver but thought I'd get back to you on this.
> 
> iio_trigger_poll_chained() will call handle_nested_irq(), while 
> iio_trigger_poll() calls generic_handle_irq()
> 
> 
> I modelled my code after ad91_adc which has iio_trigger_poll() in 
> at91_adc_eoc_trigger() together with disable_irq_nosync()/enable_irq() -- 
> is this correct? not sure, my code uses threaded irq, at91_adc not so
> 
> comments?
> 
> thanks, regards, p.
> 
