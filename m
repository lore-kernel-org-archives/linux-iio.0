Return-Path: <peda@axentia.se>
Subject: Re: [PATCH v4 8/8] iio: envelope-detector: ADC driver based on a DAC
 and a comparator
To: Thomas Gleixner <tglx@linutronix.de>
References: <1478606339-31253-1-git-send-email-peda@axentia.se>
 <1478606339-31253-9-git-send-email-peda@axentia.se>
 <alpine.DEB.2.20.1611081630450.3501@nanos>
 <d8237286-d2ff-3146-d718-f54d05b0101d@axentia.se>
 <alpine.DEB.2.20.1611081809320.3501@nanos>
 <1c104a31-6c66-9537-9b90-ede58c8e1a92@axentia.se>
 <alpine.DEB.2.20.1611082146560.3501@nanos>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Slawomir Stepien <sst@poczta.fm>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <ac908a97-77b8-046a-a0e9-74cc97f56c9b@axentia.se>
Date: Wed, 9 Nov 2016 16:01:33 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611082146560.3501@nanos>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2016-11-08 22:47, Thomas Gleixner wrote:
> On Tue, 8 Nov 2016, Peter Rosin wrote:
>> So, to sum up, in order for this to work with threaded oneshot
>> interrupts, I still need to either keep the enable/sync/enable-dance
>> or tweak the irq core to handle my case better. The only gain would
>> be that I could fire the next step of the search from the threaded
>> irq handler directly (but it needs some new race-killing code).
>> Or am I missing something? If not, there's no pressing reason to
>> switch to threaded oneshot interrupts, right?
> 
> There is no pressing reason, but that misfire prevention dance looks
> fragile and overly complex to me.

I don't see any fragility? But I wouldn't complain if there was some
simpler way to enable an irq in such a way that only new and fresh
irqs are considered.

> The completely untested patch below should block the replay for edge

[it is missing a ')', see inline comment below]

> interrupts from the core code. It also makes sure that the edge interrupt
> is masked until the thread handler returns. All you have to do is
> requesting your threaded handler with IRQF_ONESHOT | IRQF_NO_REPLAY.

It doesn't appear to work. I still get irqs that reasonably should
only have happened *during* the handling of a previous irq. And I
still need to dance when enabling the irq, otherwise I get spurious
hits.

> I don't think you need extra race handling with that, but I might be wrong
> as usual.

There's obviously no way to determine which of the timeout or the
interrupt that happens first without some race handling, so I don't
know what you mean? If the timeout happens first, there is also a
need to handle late hits from the irq that might come in during the
preparation for the next step in the binary search. It gets messy
quickly compared to the simplicity of the current implementation.

Cheers,
Peter

> 8<------------------
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -74,6 +74,7 @@
>  #define IRQF_NO_THREAD		0x00010000
>  #define IRQF_EARLY_RESUME	0x00020000
>  #define IRQF_COND_SUSPEND	0x00040000
> +#define IRQF_NO_REPLAY		0x00080000
>  
>  #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
>  
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -57,6 +57,7 @@ enum {
>  	IRQS_WAITING		= 0x00000080,
>  	IRQS_PENDING		= 0x00000200,
>  	IRQS_SUSPENDED		= 0x00000800,
> +	IRQS_NO_REPLAY		= 0x00001000,
>  };
>  
>  #include "debug.h"
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1212,7 +1212,8 @@ static int
>  		 */
>  		if (!((old->flags & new->flags) & IRQF_SHARED) ||
>  		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK) ||
> -		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
> +		    ((old->flags ^ new->flags) & IRQF_ONESHOT) ||
> +		    ((old->flags ^ new->flags) & IRQF_NO_REPLAY))
>  			goto mismatch;
>  
>  		/* All handlers must agree on per-cpuness */
> @@ -1324,6 +1325,9 @@ static int
>  		if (new->flags & IRQF_ONESHOT)
>  			desc->istate |= IRQS_ONESHOT;
>  
> +		if (new->flags & IRQF_NO_REPLAY)
> +			desc->istate |= IRQS_NO_REPLAY;
> +
>  		if (irq_settings_can_autoenable(desc))
>  			irq_startup(desc, true);
>  		else
> --- a/kernel/irq/resend.c
> +++ b/kernel/irq/resend.c
> @@ -56,12 +56,12 @@ static DECLARE_TASKLET(resend_tasklet, r
>  void check_irq_resend(struct irq_desc *desc)
>  {
>  	/*
> -	 * We do not resend level type interrupts. Level type
> -	 * interrupts are resent by hardware when they are still
> -	 * active. Clear the pending bit so suspend/resume does not
> -	 * get confused.
> +	 * We do not resend level type interrupts. Level type interrupts
> +	 * are resent by hardware when they are still active. Also prevent
> +	 * resend when the user requested so.  Clear the pending bit so
> +	 * suspend/resume does not get confused.
>  	 */
> -	if (irq_settings_is_level(desc)) {
> +	if (irq_settings_is_level(desc) || (desc->istate & IRQS_NO_REPLAY)) {
>  		desc->istate &= ~IRQS_PENDING;
>  		return;
>  	}
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -643,7 +643,10 @@ void handle_edge_irq(struct irq_desc *de
>  	kstat_incr_irqs_this_cpu(desc);
>  
>  	/* Start handling the irq */
> -	desc->irq_data.chip->irq_ack(&desc->irq_data);
> +	if (!(desc->istate & (IRQS_NO_REPLAY | IRQS_ONESHOT))

Missing ')' at the end.

> +		desc->irq_data.chip->irq_ack(&desc->irq_data);
> +	else
> +		mask_ack_irq(desc);
>  
>  	do {
>  		if (unlikely(!desc->action)) {
> 
> 
