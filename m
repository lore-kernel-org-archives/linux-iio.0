Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0099.outbound.protection.outlook.com ([104.47.0.99]:26548
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932247AbcKHViY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 16:38:24 -0500
Subject: Re: [PATCH v4 8/8] iio: envelope-detector: ADC driver based on a DAC
 and a comparator
To: Thomas Gleixner <tglx@linutronix.de>
References: <1478606339-31253-1-git-send-email-peda@axentia.se>
 <1478606339-31253-9-git-send-email-peda@axentia.se>
 <alpine.DEB.2.20.1611081630450.3501@nanos>
CC: <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Slawomir Stepien <sst@poczta.fm>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <d8237286-d2ff-3146-d718-f54d05b0101d@axentia.se>
Date: Tue, 8 Nov 2016 18:03:04 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611081630450.3501@nanos>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2016-11-08 16:59, Thomas Gleixner wrote:
> On Tue, 8 Nov 2016, Peter Rosin wrote:
>> +/*
>> + * The envelope_detector_comp_latch function works together with the compare
>> + * interrupt service routine below (envelope_detector_comp_isr) as a latch
>> + * (one-bit memory) for if the interrupt has triggered since last calling
>> + * this function.
>> + * The ..._comp_isr function disables the interrupt so that the cpu does not
>> + * need to service a possible interrupt flood from the comparator when no-one
>> + * cares anyway, and this ..._comp_latch function reenables them again if
>> + * needed.
>> + */
>> +static int envelope_detector_comp_latch(struct envelope *env)
>> +{
>> +	int comp;
>> +
>> +	spin_lock_irq(&env->comp_lock);
>> +	comp = env->comp;
>> +	env->comp = 0;
>> +	spin_unlock_irq(&env->comp_lock);
>> +
>> +	if (!comp)
>> +		return 0;
>> +
>> +	/*
>> +	 * The irq was disabled, and is reenabled just now.
>> +	 * But there might have been a pending irq that
>> +	 * happened while the irq was disabled that fires
>> +	 * just as the irq is reenabled. That is not what
>> +	 * is desired.
>> +	 */
>> +	enable_irq(env->comp_irq);
>> +
>> +	/* So, synchronize this possibly pending irq... */
>> +	synchronize_irq(env->comp_irq);
>> +
>> +	/* ...and redo the whole dance. */
>> +	spin_lock_irq(&env->comp_lock);
>> +	comp = env->comp;
>> +	env->comp = 0;
>> +	spin_unlock_irq(&env->comp_lock);
>> +
>> +	if (comp)
>> +		enable_irq(env->comp_irq);
> 
> So you need that whole dance including the delayed work because you cannot
> call iio_write_channel_raw() from hard interrupt context, right?

It's not the "cannot call from hard irq context" that made me do that, it's...

> So you might just register a threaded interrupt handler, which should make
> this whole thing way simpler.
> 
>      devm_request_threaded_irq(dev, irq, NULL, your_isr, IRQF_ONESHOT, ...);
> 
> The core will mask the interrupt line until the threaded handler is
> finished. The threaded handler is invoked with preemption enabled, so you
> can sleep there as long as you want. So you can do everything in your
> handler and the above dance is just not required.

...that I couldn't work out how to reenable a oneshot irq once it had fired,
short of freeing the irq and requesting it again. That seemed entirely
bogus, the driver shouldn't risk losing a resource like that so I don't know
what I didn't see? Or maybe it was that I had a hard time resolving the race
between the irq and the timeout in a nice way. I honestly don't remember
why exactly I abandoned oneshot irqs, but this enable/sync/enable dance
was much nicer than what I came up with for the oneshot irq solution I
originally worked on.

Or maybe I had problems with the possibly pending irq also when using a
oneshot irq, but didn't realize it? That was something I discovered quite
late in the process, some time after moving away from oneshot irqs. Are
pending irqs cleared when requesting (or reenabling, however that is done)
a oneshot irq?

Anyway, I do not want the interrupt to be serviced when no one is interested,
since I'm afraid that nasty input might generate a flood of interrupts that
might disturb other things that the cpu is doing. Which means that I need
to enable/disable the interrupt as needed.

However, what *I* thought Jonathan wanted input on was the part where the
interrupt edge/level is flipped when requesting "inverted" signals in
envelope_store_invert(). That could perhaps be seen as unorthodox and in
need of more eyes?

Cheers,
Peter
