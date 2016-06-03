Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60337 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbcFCJjc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 05:39:32 -0400
Subject: Re: Interface between IIO driver and an input driver
To: Marc Titinger <mtitinger@baylibre.com>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	linux-iio@vger.kernel.org
References: <57512F0D.3050009@free-electrons.com>
 <57513C09.2060802@baylibre.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Antoine Tenart <antoine.tenart@free-electrons.com>,
	Lars-Peter Clausen <lars@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1fb6beed-af47-8ffc-3422-d5ac53c8e832@kernel.org>
Date: Fri, 3 Jun 2016 10:39:28 +0100
MIME-Version: 1.0
In-Reply-To: <57513C09.2060802@baylibre.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/06/16 09:12, Marc Titinger wrote:
> 
> Hi All,
> 
> 
> (sorry Quentin, I here just share a related thought, not actually
> helping you much).
> 
> a nice feature would be to have some sort of "mixer" interface,
> similar to the one common with audio APIs. 
Lars in particular has been looking at extending the media controller
interface somewhat in this direction (and into audio ;) This is
the big hammer solution. It'll be cool in the long run but I don't
get the impression it'll come terribly quickly.
> An IIO driver can already
> use a separate trigger device as an interrupt source and I believe
> there is some wip to allow for software trigger sources instantiated
> with configfs.
Some are already supported (high resolution timers and after today 
a spin as fast as you can threaded trigger)
Others need the interface adding.
> Similarly, being able to link standard interfaces from
> 'input' or 'gpio' as an event source for (an) iio driver(s) would be
> great.
Indeed.  The input one kind of faded away back in 2012 (usual case
of lots of interest but no one did the last bit of work needed)
but then at the time it was all board files still and needed hard
coding.  We've recently been talking about doing configfs based binding
setup recently for iio-hwmon and similar but no code or ABI defined
yet.  See the thread Matt Ranostay started called 
[RFC] dynamic iio consumer channel mapping

GPIO one came up recently as well. 
http://marc.info/?l=linux-iio&m=145621588017248&w=2
Upshot is you need a way of saying 'this gpio might be used as a source
for triggering so make it available'.  In much the same way IIRC
the userspace gpio interfaces require the pin in question to be
made available by device tree or similar.
> Another benefit would be to use libiio and iiod as the unique
> connector to enumerate and control those interfaces, for instance
> with a product that can record some voltage (plain iio streaming) and
> switch on/off that power source using a standard gpio.
Sure, the more complex case of this is driving an external mux which
we also talked about recently.
Right now I can't find the thread - but upshot is it's 'interesting'
to do, though there are various possible approaches.
We were really talking blue sky stuff for that though - earlier steps
include output buffers etc (Lars!)

Jonathan
> BR,
> Mar.
> 
> 
> On 03/06/2016 09:17, Quentin Schulz wrote:
>> Hi all,
>>
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> controller and a thermal sensor. We currently have a driver for the two
>> latter functions in drivers/input/touchscreen/sun4i-ts.c, but we don't
>> have access to the ADC feature at all.
>>
>> Hence, I've been working on an IIO driver for that IP, with the hope
>> that we could use iio-hwmon for the thermal sensor, and a
>> yet-to-be-developped driver for the touchscreen part.
>>
>> The thermal sensor using iio_hwmon to communicate with the IIO driver is
>> working fine.
>>
>> However, the touchscreen needs all the channels of the ADC to be able
>> to get the coordinates. Moreover, you need to poke a few bits in some
>> registers to switch the ADC mode and activate a few interrupts (pen-up
>> and pen-down) to be able to operate as a touchscreen controller.
>> Therefore, I need a way to ask the IIO driver to poke these bits from
>> the input driver. For now, I am calling a function defined in my IIO
>> driver from my input driver to ask to switch between modes. Is it how it
>> is supposed to be done?
>>
>> Now that I switched to touchscreen mode, I need to get data from the IIO
>> driver. I already get hardware interrupts in the IIO driver when
>> something occurs with the touchscreen but now I need to notify the input
>> driver that I received an interrupt for the touchscreen and make  the
>> associated data available to the input driver. For now, I am using a
>> callback I set when probing the input driver and call this callback when
>> the correct interrupt is detected in the IIO driver's interrupt handler.
>> I pass the data through a parameter of this callback. However, I don't
>> think it is a good idea since the IIO driver has no idea on what the
>> callback is doing and it might just take too long to execute or even
>> freeze, which is definitely not what we want in an interrupt handler.
>> I've seen iio_channel_get_all_cb
>> (http://lxr.free-electrons.com/source/include/linux/iio/consumer.h#L79)
>> but I don't understand what it is doing or how to use it since there is
>> not a single driver using this function. Can someone explain what it is
>> supposed to do?
>> If that callback mechanism isn't really supposed to address my use-case,
>> do you have a suggestion on how to implement such a thing?
>>
>> Thanks,
>>
>> Quentin
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

