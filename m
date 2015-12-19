Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55973 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932957AbbLSQGd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2015 11:06:33 -0500
Subject: Re: [RESEND RFC PATCH 0/2] Expose the PIO_ISR register on SAMA5D3
To: Peter Rosin <peda@axentia.se>,
	Linus Walleij <linus.walleij@linaro.org>
References: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
 <CACRpkdYN=n=Q+UpLbWjxJHP-FYi_e4cHFE_d1_fR2r7QYcqgYQ@mail.gmail.com>
 <566C6122.6040406@kernel.org>
 <85d1850f20c141b2952d93be72199fdf@EMAIL.axentia.se>
 <CACRpkdY9Nwg3B1bAJ53Y-tJJywC=ENvFR6S99+wUKzcUHTa5TQ@mail.gmail.com>
 <a5deeb3722254bd08d7a7e071fd42e7f@EMAIL.axentia.se>
Cc: Peter Rosin <peda@lysator.liu.se>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matt Porter <mporter@konsulko.com>,
	Marc Zyngier <marc.zyngier@arm.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56758082.7040705@kernel.org>
Date: Sat, 19 Dec 2015 16:06:26 +0000
MIME-Version: 1.0
In-Reply-To: <a5deeb3722254bd08d7a7e071fd42e7f@EMAIL.axentia.se>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/12/15 23:19, Peter Rosin wrote:
> Hi Linus,
> 
>> On Mon, Dec 14, 2015 at 11:38 AM, Peter Rosin <peda@axentia.se> wrote:
>>
>> I think I atleast half-understand what you're trying to do.
> 
> Good. It's really not that complicated, but I'm perhaps not describing
> it very clearly...
> 
>>> Userspace does the following when doing this w/o the isr patches:
>>>
>>> 1. select signal using the MUX
>>> 2. set the DAC so high that INPUT is never reaching that level.
>>>    C (and thus gpio) is now stable
>>> 3. start waiting for interrupts on gpio
>>> 4. adjust the DAC level to the level of interest
>>> 5. abort on interrupt or timeout
>> (...)
>>> With the isr patches, the above transforms into:
>>>
>>> 1. select signal using the MUX
>>> 2. set the DAC so high that INPUT is never reaching that level.
>>>    C (and thus gpio) is now stable
>>> 3. read the isr bit to clear it
>>> 4. adjust the DAC level to the level of interest
>>> 5. read the isr bit again after 50ms
>>>
>>> The result is available directly in the isr bit, no interrupts needed.
>>
>> The problem I see here as kernel developer is that there is a fuzzy
>> and implicit separation of concerns between userspace and
>> kernelspace.
>>
>> IMO reading hardware registers is the domain of the kernel, and
>> then the result thereof is presented to userspace. The kernel
>> handles hardware, simply.
>>
>> I think we need to reverse out of this solution and instead ask
>> the question what the kernel should provide your userspace.
>> Maybe parts of what you have in userspace needs to actually
>> go into the kernel?
>>
>> The goal of IIO seems to be to present raw and calibrated
>> (SI unit) data to userspace. So what data is it you want, and
>> why can't you just get that directly from the kernel without
>> tricksing around with reading registers bits in userspace?
> 
> This all makes sense. The reason is that I'm not familiar with
> the kernel APIs. I have to wrap my head around how to set up
> work to be performed later, etc etc. All of that is in all
> likelihood pretty straightforward, but I feel that I am
> flundering around every step of the way. End result; I find
> myself trying to do as little as possible inside the kernel.
> 
> I.e. I have a pretty clear picture of what needs to be done, but
> the devil is in the details...
> 
>> If a kernel module needs to read an interrupt bit directly from the
>> GPIO controller is another thing. That is akin to how polling
>> network drivers start polling registers for incoming packages
>> instead of waiting for them to fire interrupts. Just that these are
>> dedicated IRQ lines, not GPIOs.
> 
> Yes, there was also the NACK to adding new gpio sysfs files which
> emphasizes this.
> 
>> As struct irq_chip has irq_get_irqchip_state() I think this
>> is actually possible to achieve this by implementing that
>> and calling irq_get_irqchip_state().
> 
> I'll have a peek into that, but see below.
> 
>>> I have realized that I could work with one-shot-interrupts. Then the
>>> urgency to disable interrupts go away, as only one interrupt would
>>> be served. That was not my immediate solution though, as I have been
>>> using isr type registers in this way several times before.
>>
>> That sounds like the right solution. With ONESHOT a threaded IRQ
>> will have its line masked until you return from the ISR thread. Would this
>> work for your usecase?
> 
> The ISR thread would need to be able to disable further interrupts
> before it returned, is that possible without deadlock? If so, it's
> a good fit.
> 
>> I suspect this require you to move the logic into the kernel? Into IIO?
> bc 
> Yes, and yes IIO seems about right to me too.
Whilst the full approach could well be done in IIO I can also see
some possible demand for a simple latching gpio which is I think all you
were doing with the ISR stuff.

Seems a sensible interface to support in some fashion even aside from this
discussion.  Devices like PLCs do this stuff all the time though usually
in conjunction with a capture unit that will stash a copy of some
associated counter...


> 
>>> If this is to be done in IIO, I imagine that the sanest thing would
>>> be to integrate the whole DAC-loop and present a finished envelope
>>> value to user space? This envelope detector would have to be pretty
>>> configurable, or it will be next to useless to anybody but me.
>>
>> Makes sense to me, but must be ACKed by Jonathan. But it
>> sounds pretty cool does it not?
> 
> Right, but I don't see why it should be a problem? An envelope detector
> surely fits IIO.
Sure - it's within scope I think, but there is probably a fair bit of
new interface needed to control it..
> 
>>> I could imaging that this new IIO driver should be able to work
>>> with any DAC type device, which in my case would be the mcp4531
>>> dpot. Which is not a DAC, maybe that could be solved with a new
>>> dac-dpot driver, applicable to cases where a dpot is wired as a
>>> simple voltage divider? The new IIO driver also needs to know how
>>> to get a reading from the comparator. I think the driver should
>>> support having a latch between the comparator and the gpio, so it
>>> need to know how to optionally "reset the comparator". That
>>> would have solved the whole problem, you would never have seen
>>> any of this if I had such a latch on my board. But the isr
>>> register is a latch, so...
>>>
>>> Regardless, I think such a driver still needs support from gpio
>>> and/or pinctrl. Either exposing the isr register or supporting
>>> one-shot-interrupts that disarm themselves before restoring the
>>> processor interrupt flag (maybe that exists?).
>>
>> All irqchips support one-shot interrupts as long as you request a
>> threaded IRQ I think.
>>
>> Your GPIO driver must support IRQs though but AT91 surely does.
>> Maybe you will need to implement irq_get_irqchip_state() on it
>> if you insist on polling the interrupt.
> 
> If I get the oneshot irqs to work, that indeed seems like the better
> and more general solution.
> 
>>> Otherwise the
>>> core problem remains unsolved. Also, this imaginary IIO driver
>>> probably have to be totally oblivious of the MUX, or the number
>>> of possibilities explode.
>>
>> Usually we try to follow the UNIX philisophy to do one thing
>> and do it good.
>>
>> You haven't said much about how that MUX works, if it's another
>> userspace ThingOfABob or what it is. There is no generic
>> kernel framework for muxes so I see why people would want to
>> drive that using userspace GPIO lines for example.
>>
>> If it is pinmuxing in a standard chip of some kind, pinctrl
>> handles it.
> 
> I'm afraid it's currently done from userspace with gpio-sysfs. If
> that's not changed, I need userspace to control *when* the kernel
> performs the envelope detector logic.
Definitely a case of doing this in stages.  Obviously you can
do some of the following in a different order!

1) Add a simple general purpose IIO driver to read gpios.
2) Add latching support to that - so rather than getting the current
   value allow it to (if possible) support setting up a 'pseudo'
   interrupt using the stuff Linus pointed you to above.
   You may need an explicit 'start now' signal - not sure.
3) Get your application running from userspace as:
   a) Configure your IIO 'latching gpio driver' and probably
      read it to force a reset.
   b) Set DAC value
   c) Wait a bit
   d) read from sysfs iio interface (can move to buffered stuff later)
   e) Set new Dac value based on result
   f) read here to burn any value set in between
   g) wait a bit
   h) read a gain
   etc.

4) Look at tying stuff together in kernel - driving towards your full
   setup. Ignoring mux for now this might look like.

A) An overarching driver that is a 'consumer' of both the dac and the
   latching gpio drivers.
   Latches onto the consumer interfaces of both and drives them in sync,
   in first instance probably using the in kernel equivalent of the sysfs
   interfaces. (can work out the nice fast version later using buffered
   interfaces ;)

B) Associated gpio capture driver as described above
C) Associated DAC driver.

Actually now I think about it, to get this first version up should be
pretty straight forward.  The most irritating bit will be working out
how to tie the various drivers together in a generic way.  Probably
something for the new configfs interfaces where you would create an instance
of the overarching driver, associate the dac and gpio interfaces then
set some 'instantiate' attribute to true to bring it all up.

Anyhow, sounds fun.  I've been mulling over a gpio based DIO driver
for IIO for a while (be it without the latching stuff).  The interface
stuff will also be handy for devices with general purpose inputs
alongside their ADC type ones (e.g. ADIS IMUs tend to have a couple
that can be read in the main data burst modes I think).

   
> 
> Thanks for your feedback! I think I have enough info to get
> started. Now I just need to find the time...
Know the feeling but it's always slightly easier when it is fun
and I think this sounds like it should be!

Good luck

Jonathan
> 
> Cheers,
> Peter
> N�����r��y���b�X��ǧv�^�)޺{.n�+����{��*"��^n�r���z���h����&���G���h�(�階�ݢj"���m�����z�ޖ���f���h���~�mml==
> 

