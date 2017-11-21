Return-Path: <SRS0=TKcW=CT=googlemail.com=chf.fritz@kernel.org>
Message-ID: <1511262622.1737.96.camel@googlemail.com>
Subject: Re: [PATCH v2 3/3] iio: light: isl76683 add way to adjust irq
 threshold
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>,  linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 21 Nov 2017 12:10:22 +0100
In-Reply-To: <20171119112625.073f5d66@archlinux>
References: <1511047230-7021-1-git-send-email-chf.fritz@googlemail.com>
	 <1511047230-7021-4-git-send-email-chf.fritz@googlemail.com>
	 <20171119112625.073f5d66@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

 thanks for your input. Please see my questions and answers below.

On Sun, 2017-11-19 at 11:26 +0000, Jonathan Cameron wrote:
> On Sun, 19 Nov 2017 00:20:30 +0100
> Christoph Fritz <chf.fritz@googlemail.com> wrote:
> 
> > This patch adds sysfs read/write support for upper and lower irq
> > thresholds. So it's possible that only on certain lux ranges the
> > irq triggered measurement happens.
> > 
> > Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> 
> hmm, this is 'unusual' to say the least...
> 
> From the datasheet it initially looks like a straight forward threshold
> interrupt - which should be supported as an IIO event.
> 
> However, there seems to not be a generic monitoring mode, but rather the
> device has to be polled?  (which makes this a 'funny' sort of interrupt..)

It's not polling, it's just that in this "external timing mode" host has
to do one part of adc integration timing (accurate waiting) on its own.

This is suboptimal because doing timing in the driver cannot be that
accurate as the external osc beside the chip with its "internal timing
mode". To compensate this inaccuracy there are Timing-Registers which
would then need to be red and finally calculated too.

So I prefer "internal timing mode" (with IRQ) because I do get data as
accurate and as fast as possible (especially in buffered mode) without
the hassle of compensation.

> 
> So I think you are ultimately using this threshold interrupt to provide
> a dataready signal when there isn't a real one provided?

I don't get this point. Why shouldn't the IRQ be a real data-ready
signal?

The usage is this:
    set threshold,
  in a loop for example(
    clear IRQ               isl76683_start_measurement()
    now wait for IRQ which triggers when sensordata passes threshold
    read the data           isl76683_get_sensordata()
  )

 What may confuse is that this chip needs to get the IRQ cleared before
a next "data-ready-because-it-passed-threshold-IRQ"?

By the way, without this patch sensordata always passes threshold and
the IRQ is a real "data-ready-IRQ".

> 
> That's horrible and makes it very hard to fit this device into standard
> frameworks.  My gut feeling would be to:

If you don't like the adjustable threshold because you really feel it
doesn't fit into iio-framework, you can purge patch 3 and I'll keep it
away from mainline. And it would be great if you could
reconsider :-) ...

> 
> * stop using the interrupt for data ready at all, but dead reckon
>   that with a timer delay. 

Please see my points above why using "internal timing mode" adds
complexity.

> * use this 'interrupt' (actually a hardware threshold signal rather than
>   an interrupt really)

Please see above: Why shouldn't the IRQ be a real data-ready signal?

>  for event detection and handle it
>   as an event with all the standard infrastructure that is in place
>   for that.
> 
> I can see the hardware designers logic that you might only want to read
> the values back when the light level has changed from your expected value,
> but given you have to manually trigger readings, the utility of this is
> somewhat limited...

No, adc readings are done continuously inside the chip if sensor value
fails threshold test. You get an IRQ if light changes so that threshold
test gets passed.

What do you think?

Thanks
 -- Christoph
