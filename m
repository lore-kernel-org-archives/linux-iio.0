Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbdKYPIe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Nov 2017 10:08:34 -0500
Date: Sat, 25 Nov 2017 15:08:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: light: isl76683 add way to adjust irq
 threshold
Message-ID: <20171125150830.3f9b4b58@archlinux>
In-Reply-To: <1511262622.1737.96.camel@googlemail.com>
References: <1511047230-7021-1-git-send-email-chf.fritz@googlemail.com>
        <1511047230-7021-4-git-send-email-chf.fritz@googlemail.com>
        <20171119112625.073f5d66@archlinux>
        <1511262622.1737.96.camel@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 21 Nov 2017 12:10:22 +0100
Christoph Fritz <chf.fritz@googlemail.com> wrote:

> Hi Jonathan,
> 
>  thanks for your input. Please see my questions and answers below.
> 
> On Sun, 2017-11-19 at 11:26 +0000, Jonathan Cameron wrote:
> > On Sun, 19 Nov 2017 00:20:30 +0100
> > Christoph Fritz <chf.fritz@googlemail.com> wrote:
> >   
> > > This patch adds sysfs read/write support for upper and lower irq
> > > thresholds. So it's possible that only on certain lux ranges the
> > > irq triggered measurement happens.
> > > 
> > > Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>  
> > 
> > hmm, this is 'unusual' to say the least...
> > 
> > From the datasheet it initially looks like a straight forward threshold
> > interrupt - which should be supported as an IIO event.
> > 
> > However, there seems to not be a generic monitoring mode, but rather the
> > device has to be polled?  (which makes this a 'funny' sort of interrupt..)  
> 
> It's not polling, it's just that in this "external timing mode" host has
> to do one part of adc integration timing (accurate waiting) on its own.

> 
> This is suboptimal because doing timing in the driver cannot be that
> accurate as the external osc beside the chip with its "internal timing
> mode". To compensate this inaccuracy there are Timing-Registers which
> would then need to be red and finally calculated too.
> 
> So I prefer "internal timing mode" (with IRQ) because I do get data as
> accurate and as fast as possible (especially in buffered mode) without
> the hassle of compensation.
Yes, that's fine, but as I read it you still need to actually start
the reading?

Reading on below I think I may have missunderstood this due to unfortunate
choice of function naming in the driver and frankly a less than clear
datasheet.

So, when in internal mode is this device:

1) Always capturing readings on a internally timed sequence?
2) Only capturing a reading when an explicit signal is sent to ask
it to do so?

> 
> > 
> > So I think you are ultimately using this threshold interrupt to provide
> > a dataready signal when there isn't a real one provided?  
> 
> I don't get this point. Why shouldn't the IRQ be a real data-ready
> signal?
Because it isn't. It's a data ready that only fires in some
circumstances, not simply when the data is ready...

I have no problem with an 'event' in IIO terminology (a
threshold pass) being used to provide a trigger.  We have
devices already doing this - though we could provide better
generic infrastructure for it - but that doesn't make it
a dataready trigger. It's a threshold trigger.

> 
> The usage is this:
>     set threshold,
>   in a loop for example(
>     clear IRQ               isl76683_start_measurement()
>     now wait for IRQ which triggers when sensordata passes threshold
>     read the data           isl76683_get_sensordata()
>   )
> 
>  What may confuse is that this chip needs to get the IRQ cleared before
> a next "data-ready-because-it-passed-threshold-IRQ"?

That's absolutely fine, but a data ready trigger is about data ready,
not some other condition AND data ready.

> 
> By the way, without this patch sensordata always passes threshold and
> the IRQ is a real "data-ready-IRQ".

OK, in that case it is a valid data ready signal in the conventional
sense - but only in that case.

> 
> > 
> > That's horrible and makes it very hard to fit this device into standard
> > frameworks.  My gut feeling would be to:  
> 
> If you don't like the adjustable threshold because you really feel it
> doesn't fit into iio-framework, you can purge patch 3 and I'll keep it
> away from mainline. And it would be great if you could
> reconsider :-) ...

The issue here is that we are introducing new ABI that no standard
userspace tooling is going to know what to do with.  Hmm. Lets
think about how we could at least make this more standard that it is
and then consider that...

> 
> > 
> > * stop using the interrupt for data ready at all, but dead reckon
> >   that with a timer delay.   
> 
> Please see my points above why using "internal timing mode" adds
> complexity.
Not really - you just add a slight margin (typically 10%) to the timing
you know it is set to and then read the data after that... Simple
sleep really.

> 
> > * use this 'interrupt' (actually a hardware threshold signal rather than
> >   an interrupt really)  
> 
> Please see above: Why shouldn't the IRQ be a real data-ready signal?

When we use the term data-ready it has to correspond to the standard
understanding of what a data ready signal is across other parts - otherwise
userspace will have no idea what to expect.

Data ready is used when you have an internally clocked sequencer that
generates a series of samples at a particular sampling frequency - each
set of which results in an interrupt.

I'm still not sure whether that is true here or not?

> 
> >  for event detection and handle it
> >   as an event with all the standard infrastructure that is in place
> >   for that.
> > 
> > I can see the hardware designers logic that you might only want to read
> > the values back when the light level has changed from your expected value,
> > but given you have to manually trigger readings, the utility of this is
> > somewhat limited...  
> 
> No, adc readings are done continuously inside the chip if sensor value
> fails threshold test. You get an IRQ if light changes so that threshold
> test gets passed.

I'm really confused.  Your driver seems to always start a capture manually.
Ah - maybe this is because what you have called it is:

isl76683_start_measurement when all it is actually doing is clearing
the interrupt and the documentation that says that it triggers
a new measurement is wrong? 

If it just clears the interrupt to allow us to know when a new capture
has finished which would have been running anyway then rename it
to make that clear.

> 
> What do you think?

That I'm really confused!

Anyhow I'm going to assume that we actually have a fully self clocked chip
here and that start measurement is actually 'reset_interrupt' which
allows us to see the end of the previous interrupt. If this is true
then we want the following changes at the minimum...

1) The reset should not be in the try_reenable callback of the trigger
- it is a facet of the trigger not the buffer - this also removes the
need to ensure this trigger is only used for this device.  The initial
trigger enable can clear it once to start the process.  The trigger
disable will ensure the reenable is not called again (check this - I'm
not 100% sure what the core will do and we may need to modify it slightly
or if we have to disable the irq to avoid false triggers after disable).

2) The threshold changes you are making here are characteristics of
the trigger not the device so the new ABI needs to be trigger abi
under /sys/bus/iio/devices/iio:triggerX/ not the device.

Whether we claim it is a dataready trigger with some 'quirks' or
a threshold trigger that we can set to fire for all values isn't
clear yet.

Jonathan

> 
> Thanks
>  -- Christoph
> 

