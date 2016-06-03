Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60272 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbcFCJZe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 05:25:34 -0400
Subject: Re: Interface between IIO driver and an input driver
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
	linux-iio@vger.kernel.org
References: <57512F0D.3050009@free-electrons.com>
 <e5bf00ec-e40e-7b2c-a68f-bcc5e15c0761@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f8ece832-444e-532f-f54d-a4665652ffc2@kernel.org>
Date: Fri, 3 Jun 2016 10:25:32 +0100
MIME-Version: 1.0
In-Reply-To: <e5bf00ec-e40e-7b2c-a68f-bcc5e15c0761@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/16 10:21, Jonathan Cameron wrote:
> On 03/06/16 08:17, Quentin Schulz wrote:
>> Hi all,
> Hi Quentin,
>>
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> controller and a thermal sensor. We currently have a driver for the two
>> latter functions in drivers/input/touchscreen/sun4i-ts.c, but we don't
>> have access to the ADC feature at all.
> A common situation unfortunately.
>>
>> Hence, I've been working on an IIO driver for that IP, with the hope
>> that we could use iio-hwmon for the thermal sensor, and a
>> yet-to-be-developped driver for the touchscreen part.
> Cool.
>>
>> The thermal sensor using iio_hwmon to communicate with the IIO driver is
>> working fine.
>>
>> However, the touchscreen needs all the channels of the ADC to be able
>> to get the coordinates. Moreover, you need to poke a few bits in some
>> registers to switch the ADC mode and activate a few interrupts (pen-up
>> and pen-down) to be able to operate as a touchscreen controller.
> These corner elements are what has led to slightly different handling in
> every combined driver that exists so far.  I'm not particularly a touchscreen
> expert (all my boards are headless!) but have hit this a few time in
> reviewing previous drivers.
> 
>> Therefore, I need a way to ask the IIO driver to poke these bits from
>> the input driver. For now, I am calling a function defined in my IIO
>> driver from my input driver to ask to switch between modes. Is it how it
>> is supposed to be done?
> So we have two data interfaces in IIO for inkernel use at the moment. Both
> are related to 'in band data' - basically reading adc data.
> 1) Pull - iio-hwmon type polling when it wants to know.
> 2) Push - see below, but they basically hook in a callback where data passes
> into buffers.
> 
> What we are definitely missing (though it doesn't solve all your problems)
> is a means of passing on what we term 'events' - i.e. out of band data.
> Whether pen up and down are really out of bound or not I'm not sure - they
> could just be considered a 1bit channel or similar.
> 
> From IIO point of view, to poke these they need to be either info-mask
> elements of extended elements (though we don't have nice wrappers for
> extended elements yet). If we treat these interrupts as events, then
> we also need a way of requesting events from a touch screen driver.
> (Adding this is more a question of figuring out sensible ish APIs than
> anything else - as it's in kernel we can evolve them as necessary anyway)
>>
>> Now that I switched to touchscreen mode, I need to get data from the IIO
>> driver. I already get hardware interrupts in the IIO driver when
>> something occurs with the touchscreen but now I need to notify the input
>> driver that I received an interrupt for the touchscreen and make  the
>> associated data available to the input driver. For now, I am using a
>> callback I set when probing the input driver and call this callback when
>> the correct interrupt is detected in the IIO driver's interrupt handler.
> Basically you are running as an MFD by the sound of it.  A valid approach
> though I'd suggest it may make sense to formalise it a bit more and do
> an interrupt chip etc as per a modern MFD.  Leads to nicer driver separation
> etc.
>> I pass the data through a parameter of this callback. However, I don't
>> think it is a good idea since the IIO driver has no idea on what the
>> callback is doing and it might just take too long to execute or even
>> freeze, which is definitely not what we want in an interrupt handler.
> I'd certainly suggest this needs to be in threaded context at the very
> least.  If it hangs, it hangs - that's a bug in the touch screen driver that
> simply needs to be fixed.  
>> I've seen iio_channel_get_all_cb
>> (http://lxr.free-electrons.com/source/include/linux/iio/consumer.h#L79)
>> but I don't understand what it is doing or how to use it since there is
>> not a single driver using this function. Can someone explain what it is
>> supposed to do?
> See the input bridge mentioned below. There are also I think some out of
> tree users (analog devices tree) largely because I get the odd fix from
> them for this code.
Looking at their latest tree, this might just be Lars having been reviewing
code as they don't seem to have any users (though they run a lot of branches)
so might be one somewhere.  Lots of magic in that tree I never get
enough time to read through!
> 
>> If that callback mechanism isn't really supposed to address my use-case,
>> do you have a suggestion on how to implement such a thing?
> The basic approaches that have been taken before are:
> 1) Monolithic driver (we don't really like this one) which registers
> both IIO and input devices.
> 2) MFD layer underneath - this allows low level arbitration of access to
> the data.  This works just fine and gives a nice split but never feels
> as generic as it might be.. (which I think is where you are coming from).
> Something like the am335x driver would be an example of this (there are
> several).
> 3) Using a similar strategy to the iio-hwmon interface. I did write
> an iio-input bridge a long time ago that gives some idea of how this
> might work, but never got the time to finish it.
> http://www.spinics.net/lists/linux-iio/msg06879.html 
> specifically patch 4 http://www.spinics.net/lists/linux-iio/msg06881.html
> (I'm a little - *very* embarrassed at how long this one has taken -
> if anyone wants to pick it up and run with it I'd be most grateful!)
> 
> There are some 'sticky' issues with that still from what I recall
> * It is typically an either or with many drivers as they will either
> operate in the push mode (buffered within IIO) or the polled mode
> used by iio-hwmon.   This can be fixed by playing games within
> individual drivers, but a more general layer providing registered
> clients with cached readings when in push mode would be a great
> addition.
> * It was really targeted at the simpler accelerometer usecase.
> * We don't have support for passing what are considered 'events' by
> IIO - out of band data.  In your case the pen touch events.
> Passing them over is easy enough, but working out the correlation
> with the main data flow is going to be a little trickier.
> Meta data channels are possible, but we don't have a well defined
> interface for them yet.
> 
> Now I'd love to see a generic touch screen driver, but as you no
> doubt know there are some fiddly hooks in many of these where semi
> manual switching of feed voltages are needed.  A nice controller
> wrapping up a scheduled pass over the relevant combinations would
> be easier to handle I guess.  
> 
> Perhaps there are classes of device that are similar enough to
> allow a single simple driver?  I never learnt enough about these
> to be sure either way on that.  It comes up every time this
> question gets raised and yet no one has yet had time to do all that
> much about it :(
> 
> So as ever which way makes sense for you might be more a question
> of how much time you have available than anything else.
> Best is of course to make everything magic for everyone in the
> future and put together a generic touch screen driver ;) 
> Good is MFD.
> Anything else is worse.
> 
> Jonathan
>>
>> Thanks,
>>
>> Quentin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

