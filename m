Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55835 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932798AbcKHSlZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2016 13:41:25 -0500
Date: Tue, 8 Nov 2016 19:38:31 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Peter Rosin <peda@axentia.se>
cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Slawomir Stepien <sst@poczta.fm>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 8/8] iio: envelope-detector: ADC driver based on a
 DAC and a comparator
In-Reply-To: <d8237286-d2ff-3146-d718-f54d05b0101d@axentia.se>
Message-ID: <alpine.DEB.2.20.1611081809320.3501@nanos>
References: <1478606339-31253-1-git-send-email-peda@axentia.se> <1478606339-31253-9-git-send-email-peda@axentia.se> <alpine.DEB.2.20.1611081630450.3501@nanos> <d8237286-d2ff-3146-d718-f54d05b0101d@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 8 Nov 2016, Peter Rosin wrote:
> On 2016-11-08 16:59, Thomas Gleixner wrote:

> > So you need that whole dance including the delayed work because you cannot
> > call iio_write_channel_raw() from hard interrupt context, right?
> 
> It's not the "cannot call from hard irq context" that made me do that, it's..

Well, what guarantees you that the DAC is writeable from IRQ context? It
might be hanging off an i2c/spi bus as well....

> > The core will mask the interrupt line until the threaded handler is
> > finished. The threaded handler is invoked with preemption enabled, so you
> > can sleep there as long as you want. So you can do everything in your
> > handler and the above dance is just not required.
> 
> ...that I couldn't work out how to reenable a oneshot irq once it had fired,
> short of freeing the irq and requesting it again. That seemed entirely
> bogus, the driver shouldn't risk losing a resource like that so I don't know
> what I didn't see? Or maybe it was that I had a hard time resolving the race
> between the irq and the timeout in a nice way. I honestly don't remember
> why exactly I abandoned oneshot irqs, but this enable/sync/enable dance
> was much nicer than what I came up with for the oneshot irq solution I
> originally worked on.

Threaded ONESHOT irqs work this way:

 interrupt fires
   mask interrupt
   handler thread is woken
 
 handler thread runs
   invokes isr
   unmask interrupt

So if you rewrite the DAC to the new value in your ISR, then you should not
get any spurious interrupt.

Note, that this only works for level type interrupts.

We do not mask edge type interrupts as we might lose an edge, but if that
helps the cause of your problem it's simple enough to make it conditionally
doing so in the core.

> Or maybe I had problems with the possibly pending irq also when using a
> oneshot irq, but didn't realize it? That was something I discovered quite
> late in the process, some time after moving away from oneshot irqs. Are
> pending irqs cleared when requesting (or reenabling, however that is done)
> a oneshot irq?

Pending irqs are only replayed, when you reenable an interrupt via
enable_irq(). That can happen either by software or by hardware.

> Anyway, I do not want the interrupt to be serviced when no one is interested,
> since I'm afraid that nasty input might generate a flood of interrupts that
> might disturb other things that the cpu is doing. Which means that I need
> to enable/disable the interrupt as needed.

So the main issue I'm seing here, is that your comparator does not have
means to prevent it from firing interrupts.

> However, what *I* thought Jonathan wanted input on was the part where the
> interrupt edge/level is flipped when requesting "inverted" signals in
> envelope_store_invert(). That could perhaps be seen as unorthodox and in
> need of more eyes?

Flipping the dectection level of the interrupt is fine, but what's the
guarantee that it is correct in the first place? I don't see anything which
makes that sure at all. Aside of that this bit does not makes sense:

> +	env->comp_irq_trigger = irq_get_trigger_type(env->comp_irq);
> +	if (env->comp_irq_trigger & IRQF_TRIGGER_RISING)
> +		env->comp_irq_trigger_inv |= IRQF_TRIGGER_FALLING;

What's the |= about?

> +	if (env->comp_irq_trigger & IRQF_TRIGGER_FALLING)

and this should be 'else if'. If the interrupt is configured for both
edges, which is possible with some interrupt controllers then the whole
thing does not work at all.

> +		env->comp_irq_trigger_inv |= IRQF_TRIGGER_RISING;
> +	if (env->comp_irq_trigger & IRQF_TRIGGER_HIGH)
> +		env->comp_irq_trigger_inv |= IRQF_TRIGGER_LOW;
> +	if (env->comp_irq_trigger & IRQF_TRIGGER_LOW)
> +		env->comp_irq_trigger_inv |= IRQF_TRIGGER_HIGH;

Thanks,

	tglx
