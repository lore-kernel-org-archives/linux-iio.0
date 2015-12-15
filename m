Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <85d1850f20c141b2952d93be72199fdf@EMAIL.axentia.se>
References: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
	<CACRpkdYN=n=Q+UpLbWjxJHP-FYi_e4cHFE_d1_fR2r7QYcqgYQ@mail.gmail.com>
	<566C6122.6040406@kernel.org>
	<85d1850f20c141b2952d93be72199fdf@EMAIL.axentia.se>
Date: Tue, 15 Dec 2015 15:20:45 +0100
Message-ID: <CACRpkdY9Nwg3B1bAJ53Y-tJJywC=ENvFR6S99+wUKzcUHTa5TQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/2] Expose the PIO_ISR register on SAMA5D3
From: Linus Walleij <linus.walleij@linaro.org>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@lysator.liu.se>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lars-Peter Clausen <lars@metafoo.de>,
	"mporter@linaro.org" <mporter@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Peter,

On Mon, Dec 14, 2015 at 11:38 AM, Peter Rosin <peda@axentia.se> wrote:

I think I atleast half-understand what you're trying to do.

> Userspace does the following when doing this w/o the isr patches:
>
> 1. select signal using the MUX
> 2. set the DAC so high that INPUT is never reaching that level.
>    C (and thus gpio) is now stable
> 3. start waiting for interrupts on gpio
> 4. adjust the DAC level to the level of interest
> 5. abort on interrupt or timeout
(...)
> With the isr patches, the above transforms into:
>
> 1. select signal using the MUX
> 2. set the DAC so high that INPUT is never reaching that level.
>    C (and thus gpio) is now stable
> 3. read the isr bit to clear it
> 4. adjust the DAC level to the level of interest
> 5. read the isr bit again after 50ms
>
> The result is available directly in the isr bit, no interrupts needed.

The problem I see here as kernel developer is that there is a fuzzy
and implicit separation of concerns between userspace and
kernelspace.

IMO reading hardware registers is the domain of the kernel, and
then the result thereof is presented to userspace. The kernel
handles hardware, simply.

I think we need to reverse out of this solution and instead ask
the question what the kernel should provide your userspace.
Maybe parts of what you have in userspace needs to actually
go into the kernel?

The goal of IIO seems to be to present raw and calibrated
(SI unit) data to userspace. So what data is it you want, and
why can't you just get that directly from the kernel without
tricksing around with reading registers bits in userspace?

If a kernel module needs to read an interrupt bit directly from the
GPIO controller is another thing. That is akin to how polling
network drivers start polling registers for incoming packages
instead of waiting for them to fire interrupts. Just that these are
dedicated IRQ lines, not GPIOs.

As struct irq_chip has irq_get_irqchip_state() I think this
is actually possible to achieve this by implementing that
and calling irq_get_irqchip_state().

> I have realized that I could work with one-shot-interrupts. Then the
> urgency to disable interrupts go away, as only one interrupt would
> be served. That was not my immediate solution though, as I have been
> using isr type registers in this way several times before.

That sounds like the right solution. With ONESHOT a threaded IRQ
will have its line masked until you return from the ISR thread. Would this
work for your usecase?

I suspect this require you to move the logic into the kernel? Into IIO?

> If this is to be done in IIO, I imagine that the sanest thing would
> be to integrate the whole DAC-loop and present a finished envelope
> value to user space? This envelope detector would have to be pretty
> configurable, or it will be next to useless to anybody but me.

Makes sense to me, but must be ACKed by Jonathan. But it
sounds pretty cool does it not?

> I could imaging that this new IIO driver should be able to work
> with any DAC type device, which in my case would be the mcp4531
> dpot. Which is not a DAC, maybe that could be solved with a new
> dac-dpot driver, applicable to cases where a dpot is wired as a
> simple voltage divider? The new IIO driver also needs to know how
> to get a reading from the comparator. I think the driver should
> support having a latch between the comparator and the gpio, so it
> need to know how to optionally "reset the comparator". That
> would have solved the whole problem, you would never have seen
> any of this if I had such a latch on my board. But the isr
> register is a latch, so...
>
> Regardless, I think such a driver still needs support from gpio
> and/or pinctrl. Either exposing the isr register or supporting
> one-shot-interrupts that disarm themselves before restoring the
> processor interrupt flag (maybe that exists?).

All irqchips support one-shot interrupts as long as you request a
threaded IRQ I think.

Your GPIO driver must support IRQs though but AT91 surely does.
Maybe you will need to implement irq_get_irqchip_state() on it
if you insist on polling the interrupt.

> Otherwise the
> core problem remains unsolved. Also, this imaginary IIO driver
> probably have to be totally oblivious of the MUX, or the number
> of possibilities explode.

Usually we try to follow the UNIX philisophy to do one thing
and do it good.

You haven't said much about how that MUX works, if it's another
userspace ThingOfABob or what it is. There is no generic
kernel framework for muxes so I see why people would want to
drive that using userspace GPIO lines for example.

If it is pinmuxing in a standard chip of some kind, pinctrl
handles it.

Yours,
Linus Walleij
