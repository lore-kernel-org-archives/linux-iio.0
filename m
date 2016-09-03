Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44930 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753593AbcICPds (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 11:33:48 -0400
Subject: Re: iio_push_event() race conditions
To: Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <0e1e64ac-5c40-6319-1132-e5d7b2478f01@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <58a59b36-b528-038f-38ed-7ce1b1e9f35f@kernel.org>
Date: Sat, 3 Sep 2016 16:33:24 +0100
MIME-Version: 1.0
In-Reply-To: <0e1e64ac-5c40-6319-1132-e5d7b2478f01@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/16 16:08, Lars-Peter Clausen wrote:
> Hi,
> 
> A common pattern that we see with drivers that implement events is the
> following. I did not check all driver, but all those that I checked followed
> this pattern.
> 
> irqreturn_t event_callback(int irq, void *devid)
> {
> 	struct iio_dev *indio_dev = devid;
> 	...
> 	iio_push_event(indio_dev, ...);
> 	
> 	return IRQ_HANDLED;
> }
> 
> int driver_probe(struct device *dev)
> {
> 	struct iio_dev *indio_dev;
> 
> 	indio_dev = iio_device_alloc(...);
> 
> 	request_irq(event_irq, event_callback, ..., indio_dev);
> 
> 	return iio_device_register(indio_dev);
> }
Most of the time this is actually fine as we know the hardware
is in a state where it won't generate interrupts until they
are explicitly enabled from userspace (which requires
iio_device_register to have occurred).

However you are quite correct in thinking this isn't always the
case and we have a race to clean up here.
> 
> Now iio_push_event() accessed indio_dev->event_interface. The
> event_interface is only allocated and assigned in iio_device_register()
> though. This means there is a window of opportunity where the interrupt is
> live and can trigger, but event_interface is still NULL. So we'll hit a NULL
> pointer dereference if the IRQ fires before iio_device_register() completes.
> 
> I'm a bit conflicted on what is the best way to resolve this. On one hand
> the correct approach appears to be to simply delay the requesting of the IRQ
> until iio_device_register() has completed. 
I'm not keen on the churn that would cause.
>On the other hand it is possible
> to argue that users should be able to expect that it is safe to call APIs
> that take a struct iio_dev if iio_device_alloc() succeeded.
Agreed.  This is explicitly allowed in the equivalent in input.

See input_event in input.c description text.
> 
> The later approach also has the advantage that we only need to update
> iio_push_event() rather than all drivers that use it. But raises the obvious
> question what is the right behavior of iio_push_event() in case the event
> interface has not been registered yet? Return an error? What should the
> caller do if it encounters an error? Or maybe just silently become a no-op?
Input just does it by no-op. 

So what cases would that not make sense?
* We want an event to say a channel is already above a threshold level.
* err.

For the first one it's hardware dependent whether an interrupt even occurs
in that case so I'd have no problem with us making it disappear in all cases.

Jonathan
> 
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

