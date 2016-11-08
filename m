Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55293 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbcKHQCP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2016 11:02:15 -0500
Date: Tue, 8 Nov 2016 16:59:20 +0100 (CET)
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
In-Reply-To: <1478606339-31253-9-git-send-email-peda@axentia.se>
Message-ID: <alpine.DEB.2.20.1611081630450.3501@nanos>
References: <1478606339-31253-1-git-send-email-peda@axentia.se> <1478606339-31253-9-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 8 Nov 2016, Peter Rosin wrote:
> +/*
> + * The envelope_detector_comp_latch function works together with the compare
> + * interrupt service routine below (envelope_detector_comp_isr) as a latch
> + * (one-bit memory) for if the interrupt has triggered since last calling
> + * this function.
> + * The ..._comp_isr function disables the interrupt so that the cpu does not
> + * need to service a possible interrupt flood from the comparator when no-one
> + * cares anyway, and this ..._comp_latch function reenables them again if
> + * needed.
> + */
> +static int envelope_detector_comp_latch(struct envelope *env)
> +{
> +	int comp;
> +
> +	spin_lock_irq(&env->comp_lock);
> +	comp = env->comp;
> +	env->comp = 0;
> +	spin_unlock_irq(&env->comp_lock);
> +
> +	if (!comp)
> +		return 0;
> +
> +	/*
> +	 * The irq was disabled, and is reenabled just now.
> +	 * But there might have been a pending irq that
> +	 * happened while the irq was disabled that fires
> +	 * just as the irq is reenabled. That is not what
> +	 * is desired.
> +	 */
> +	enable_irq(env->comp_irq);
> +
> +	/* So, synchronize this possibly pending irq... */
> +	synchronize_irq(env->comp_irq);
> +
> +	/* ...and redo the whole dance. */
> +	spin_lock_irq(&env->comp_lock);
> +	comp = env->comp;
> +	env->comp = 0;
> +	spin_unlock_irq(&env->comp_lock);
> +
> +	if (comp)
> +		enable_irq(env->comp_irq);

So you need that whole dance including the delayed work because you cannot
call iio_write_channel_raw() from hard interrupt context, right?

So you might just register a threaded interrupt handler, which should make
this whole thing way simpler.

     devm_request_threaded_irq(dev, irq, NULL, your_isr, IRQF_ONESHOT, ...);

The core will mask the interrupt line until the threaded handler is
finished. The threaded handler is invoked with preemption enabled, so you
can sleep there as long as you want. So you can do everything in your
handler and the above dance is just not required.

Thanks,

	tglx
