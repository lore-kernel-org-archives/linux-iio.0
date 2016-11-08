Return-Path: <peda@axentia.se>
Subject: Re: [PATCH v4 8/8] iio: envelope-detector: ADC driver based on a DAC
 and a comparator
To: Thomas Gleixner <tglx@linutronix.de>
References: <1478606339-31253-1-git-send-email-peda@axentia.se>
 <1478606339-31253-9-git-send-email-peda@axentia.se>
 <alpine.DEB.2.20.1611081630450.3501@nanos>
 <d8237286-d2ff-3146-d718-f54d05b0101d@axentia.se>
 <alpine.DEB.2.20.1611081809320.3501@nanos>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, Daniel Baluta
	<daniel.baluta@intel.com>, Slawomir Stepien <sst@poczta.fm>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <1c104a31-6c66-9537-9b90-ede58c8e1a92@axentia.se>
Date: Tue, 8 Nov 2016 21:44:26 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611081809320.3501@nanos>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2016-11-08 19:38, Thomas Gleixner wrote:
> On Tue, 8 Nov 2016, Peter Rosin wrote:
>> On 2016-11-08 16:59, Thomas Gleixner wrote:
> 
>>> So you need that whole dance including the delayed work because you cannot
>>> call iio_write_channel_raw() from hard interrupt context, right?
>>
>> It's not the "cannot call from hard irq context" that made me do that, it's..
> 
> Well, what guarantees you that the DAC is writeable from IRQ context? It
> might be hanging off an i2c/spi bus as well....

Right, the DAC is actually on an i2c-bus so it's not possible to call
iio_write_channel_raw in hard irq context, I did not disagree with that.
But that was not the reason for not calling it in (hard or threaded) irq
context. The reason is that this was the simplest way to kill the race
with the timeout, and I wasn't in that much of a hurry to start the next
step (in the binary search) and was completely happy with just recording
if any interrupt did happen and then continue when the timeout eventually
happened. It's not like the delayed work connected to the timeout can be
left out anyway, since the design is to not get an interrupt before the
timeout in about half the cases. In some cases there might not be any
interrupts in eons...

>>> The core will mask the interrupt line until the threaded handler is
>>> finished. The threaded handler is invoked with preemption enabled, so you
>>> can sleep there as long as you want. So you can do everything in your
>>> handler and the above dance is just not required.
>>
>> ...that I couldn't work out how to reenable a oneshot irq once it had fired,
>> short of freeing the irq and requesting it again. That seemed entirely
>> bogus, the driver shouldn't risk losing a resource like that so I don't know
>> what I didn't see? Or maybe it was that I had a hard time resolving the race
>> between the irq and the timeout in a nice way. I honestly don't remember
>> why exactly I abandoned oneshot irqs, but this enable/sync/enable dance
>> was much nicer than what I came up with for the oneshot irq solution I
>> originally worked on.
> 
> Threaded ONESHOT irqs work this way:
> 
>  interrupt fires
>    mask interrupt
>    handler thread is woken
>  
>  handler thread runs
>    invokes isr
>    unmask interrupt
> 
> So if you rewrite the DAC to the new value in your ISR, then you should not
> get any spurious interrupt.
> 
> Note, that this only works for level type interrupts.
> 
> We do not mask edge type interrupts as we might lose an edge, but if that
> helps the cause of your problem it's simple enough to make it conditionally
> doing so in the core.
> 
>> Or maybe I had problems with the possibly pending irq also when using a
>> oneshot irq, but didn't realize it? That was something I discovered quite
>> late in the process, some time after moving away from oneshot irqs. Are
>> pending irqs cleared when requesting (or reenabling, however that is done)
>> a oneshot irq?
> 
> Pending irqs are only replayed, when you reenable an interrupt via
> enable_irq(). That can happen either by software or by hardware.

Ah, of course, the interrupt core does its best to not lose interrupts, but
in this case it is actually desired to lose the interrupts that happen
while the irq is disabled. Which means that the enable/sync/enable-dance is
needed for oneshot interrupts as well. Either that or make tweaks to the
core (yes, irqs are edge-triggered interrupts in my case).

>> Anyway, I do not want the interrupt to be serviced when no one is interested,
>> since I'm afraid that nasty input might generate a flood of interrupts that
>> might disturb other things that the cpu is doing. Which means that I need
>> to enable/disable the interrupt as needed.
> 
> So the main issue I'm seing here, is that your comparator does not have
> means to prevent it from firing interrupts.

Right, it's just a discrete op-amp. Only way to "turn it off", is to feed
it input that makes it silent. But I'd rather not have code in this driver
that knows how to do that, since then the driver mutates from something
fairly generic to something that is very specific with hairy dependencies.
It would probably also require code to handle trailing interrupts caused
by setting up the silent state. It just sounds horrible compared to
simply disabling the interrupt (and doing a dance when enabling them).

>> However, what *I* thought Jonathan wanted input on was the part where the
>> interrupt edge/level is flipped when requesting "inverted" signals in
>> envelope_store_invert(). That could perhaps be seen as unorthodox and in
>> need of more eyes?
> 
> Flipping the dectection level of the interrupt is fine, but what's the
> guarantee that it is correct in the first place? I don't see anything which
> makes that sure at all. Aside of that this bit does not makes sense:

That "guarantee" comes from devicetree. I.e. the person writing the
dts.

>> +	env->comp_irq_trigger = irq_get_trigger_type(env->comp_irq);
>> +	if (env->comp_irq_trigger & IRQF_TRIGGER_RISING)
>> +		env->comp_irq_trigger_inv |= IRQF_TRIGGER_FALLING;
> 
> What's the |= about?

env->comp_irq_trigger_inv is zero from the start, the idea is to

- set FALLING for ..._trigger_inv if RISING is set for ..._trigger
- set RISING for ..._trigger_inv if FALLING is set for ..._trigger
- set LOW for ..._trigger_inv if HIGH is set for ..._trigger
- set HIGH for ..._trigger_inv if LOW is set for ..._trigger

That way, ..._trigger_inv will be the opposite of ..._trigger at all
times, whichever way ..._trigger is set up from devicetree.

>> +	if (env->comp_irq_trigger & IRQF_TRIGGER_FALLING)
> 
> and this should be 'else if'. If the interrupt is configured for both
> edges, which is possible with some interrupt controllers then the whole
> thing does not work at all.

Right, if you do stupid thing in the devicetree, you get garbage. And
if ..._trigger is triggering on both edges, ..._trigger_inv might just
do the same stupid thing. That's only fair, methinks?

>> +		env->comp_irq_trigger_inv |= IRQF_TRIGGER_RISING;
>> +	if (env->comp_irq_trigger & IRQF_TRIGGER_HIGH)
>> +		env->comp_irq_trigger_inv |= IRQF_TRIGGER_LOW;
>> +	if (env->comp_irq_trigger & IRQF_TRIGGER_LOW)
>> +		env->comp_irq_trigger_inv |= IRQF_TRIGGER_HIGH;

So, to sum up, in order for this to work with threaded oneshot
interrupts, I still need to either keep the enable/sync/enable-dance
or tweak the irq core to handle my case better. The only gain would
be that I could fire the next step of the search from the threaded
irq handler directly (but it needs some new race-killing code).
Or am I missing something? If not, there's no pressing reason to
switch to threaded oneshot interrupts, right?

Cheers,
Peter
