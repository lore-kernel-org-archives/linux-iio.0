Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57211 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbbLLSGJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2015 13:06:09 -0500
Subject: Re: [RESEND RFC PATCH 0/2] Expose the PIO_ISR register on SAMA5D3
To: Linus Walleij <linus.walleij@linaro.org>,
	Peter Rosin <peda@lysator.liu.se>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
 <CACRpkdYN=n=Q+UpLbWjxJHP-FYi_e4cHFE_d1_fR2r7QYcqgYQ@mail.gmail.com>
 <566C6122.6040406@kernel.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Peter Rosin <peda@axentia.se>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matt Porter <mporter@konsulko.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <566C620D.3000705@kernel.org>
Date: Sat, 12 Dec 2015 18:06:05 +0000
MIME-Version: 1.0
In-Reply-To: <566C6122.6040406@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

My address for Matt was out of date..
Here's hoping there is only one Matt Porter writing IIO drivers and
trying a more recent email address.

On 12/12/15 18:02, Jonathan Cameron wrote:
> On 11/12/15 12:53, Linus Walleij wrote:
>> Quoting extensively since I'm involving the linux-iio mailinglist.
>>
>> The use case you describe is hand-in-glove with Industrial I/O.
>> I think you want a trigger interface from IIO and read events from
>> userspace using the IIO character device.
>>
>> Look at the userspace examples in tools/iio for how it's used
>> in userspace, the subsystem is in drivers/iio. I suspect
>> drivers/iio/adc/polled-gpio.c or something is where you actually
>> want to go with this. The module should do all the fastpath
>> work and then expose what you actually want to know to
>> userspace using the IIO triggers or events.
>>
>> I have used IIO myself, it is really neat for this kind of usecase,
>> and designed right from the ground up.
>>
>> I think you whould think about how to write the right kind of
>> driver for IIO to do what you want.
> Peter has a spot of IIO experience as well :)
> 
> I'm not sure I entirely understand what the data flows are here so I may
> get this completely wrong!
> 
> Sounds like a quick, dirty and simple 'capture unit' like you'd find on a PLC to
> me (be bit one that doesn't grab much data - I use these all the time at
> work to catch the output from beam break sensor on automated systems and
> stuff like that).  Timers often support a copy to register on a gpio
> signal but I'm not sure I've ever seen that supported in kernel either
> (some discussion about doing this in IIO occurred a while ago but I don't
> think anything ever came of it unfortunately). It was for the TI ECAP devices
> by Matt Porter (cc'd)  Not that closely related but perhaps Matt will
> have some insight here.
> 
> So:
> 
> Are we looking to synchronised control of the DAC
> feeding the comparator or is that entirely autonomous?
> (for now I'll assume autonomous - it gets interesting if
>  not - we'd need the buffered output stuff Lars has for that)
> 
> How fast are we talking?
> 
> So I think we are basically looking for fast sampling of the gpio with latching.
> 
> I suspect the rates are high enough that an IIO trigger is going to be too expensive
> (as it effectively runs as an irq).  That's fine though as they are optional if
> you have a good reason not to use them and a direct polling of the isr and filling a
> buffer might work.
> 
> We don't currently have 1 bit channel support in IIO and in this particular case
> our normal buffers are going to be very inefficient as they are kfifo based
> and hence will burn 1 byte per sample if we do this the simple way.
> The closest we have gotten to a 1 bit support was a comparator driver and
> in the end the author decided to support that via events which have way higher
> overhead than I think you want.
> 
> So if IIO is the sensible way to support this I think we need something like
> the following:
> 
> 1) 1 bit data type support in IIO - not too bad to add, though will need
>    to have some restrictions in the demux as arbitary bit channel recombining
>    would be horrible and costly.  So in the first instance we'd probably burn 1 byte
>    per 1 bit channel each sample - address this later perhaps.  If burning
>    a byte, just specify that you have a channel with realbits = 1, storagebits = 8
>    and it should all work.  I'd like to add 1 bit support fully if you are
>    interested though!
> 
> 2) A driver that can effectively check and clear the interrupt register and
>    push that to the kfifo.  Probably running a kthread to keep the overhead
>    low - something like the recent INA2XX driver is doing (though for a rather
>    different reason).  That would then shove data into the buffer at regular
>    intervals.
> 
> 3) Normal userspace code would then read this - ideally with updates to
>    correctly interpret it as boolean data.
> 
> Doesn't sound too bad - just a question of whether it will be lightweight
> enough for your use case.
> 
> Assuming I have understood even vaguely what you are doing ;)
>  
> Sounds fun.
> 
> Jonathan
>>
>> Yours,
>> Linus Walleij
>>
>> On Tue, Dec 8, 2015 at 4:20 AM, Peter Rosin <peda@lysator.liu.se> wrote:
>>> From: Peter Rosin <peda@axentia.se>
>>>
>>> Hi!
>>>
>>> I have a signal connected to a gpio pin which is the output of
>>> a comparator. By changing the level of one of the inputs to the
>>> comparator, I can detect the envelope of the other input to
>>> the comparator by using a series of measurements much in the
>>> same maner a manual ADC works, but watching for changes on the
>>> comparator over a period of time instead of only the immediate
>>> output.
>>>
>>> Now, the input signal to the comparator might have a high frequency,
>>> which will cause the output from the comparator (and thus the GPIO
>>> input) to change rapidly.
>>>
>>> A common(?) idiom for this is to use the interrupt status register
>>> to catch the glitches, but then not have any interrupt tied to
>>> the pin as that could possibly generate pointless bursts of
>>> (expensive) interrupts.
>>>
>>> So, these two patches expose an interface to the PIO_ISR register
>>> of the pio controllers on the platform I'm targetting. The first
>>> patch adds some infrastructure to the gpio core and the second
>>> patch hooks up "my" pin controller.
>>>
>>> But hey, this seems like an old problem and I was surprised that
>>> I had to touch the source to do it. Which makes me wonder what I'm
>>> missing and what others needing to see short pulses on a pin but not
>>> needing/wanting interrupts are doing?
> Basically a capture unit... Be it one that doesn't grab anything else
> at the moment.
>>>
>>> Yes, there needs to be a way to select the interrupt edge w/o
>>> actually arming the interrupt, that is missing. And probably
>>> other things too, but I didn't want to do more work in case this
>>> is a dead end for some reason...
>>>
>>> Cheers,
>>> Peter
>>>
>>> Peter Rosin (2):
>>>   gpio: Add isr property of gpio pins
>>>   pinctrl: at91: expose the isr bit
>>>
>>>  Documentation/gpio/sysfs.txt   |   12 ++++++++++
>>>  drivers/gpio/gpiolib-sysfs.c   |   30 ++++++++++++++++++++++++
>>>  drivers/gpio/gpiolib.c         |   15 ++++++++++++
>>>  drivers/pinctrl/pinctrl-at91.c |   50 ++++++++++++++++++++++++++++++++++++----
>>>  include/linux/gpio/consumer.h  |    1 +
>>>  include/linux/gpio/driver.h    |    2 ++
>>>  6 files changed, 106 insertions(+), 4 deletions(-)
>>>
>>> --
>>> 1.7.10.4
>>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

