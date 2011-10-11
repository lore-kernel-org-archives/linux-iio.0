Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:38926 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab1JKPjq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2011 11:39:46 -0400
Message-ID: <4E946342.4030807@cam.ac.uk>
Date: Tue, 11 Oct 2011 16:39:46 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Zoltan Devai <zdevai@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
References: <1318178172-7965-1-git-send-email-zoss@devai.org> <201110111617.52061.arnd@arndb.de> <20111011144005.GI3471@opensource.wolfsonmicro.com> <201110111724.48069.arnd@arndb.de>
In-Reply-To: <201110111724.48069.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/11/11 16:24, Arnd Bergmann wrote:
> On Tuesday 11 October 2011, Mark Brown wrote:
>> On Tue, Oct 11, 2011 at 04:17:51PM +0200, Arnd Bergmann wrote:
>>> On Monday 10 October 2011, Mark Brown wrote:
>>
>>>> At the minute it seems to me that arch/arm is as good a place as any
>>>> really - currently this code is getting dumped wherever the main device
>>>> is.
>>
>>> My feeling is that there is a general class of drivers involving
>>> the gpio, pinmux, pwm, led, adc and dac: these are basically all
>>> things you do with a single pin. Right now we have subsystems for
>>> some of them, adding some others and don't have anything for adc
>>> basides iio (which only partially fits here).
>>
>> We've been round this loop repeatedly before, trying to push all this
>> stuff into pins really doesn't map terribly well.  For example, SoCs
>> will frequently have PWM controllers which are isolated IP blocks within
>> the device and may each have multiple mappings out of the device onto
>> pins.  In the case of DACs, ADCs and PWM you definitely don't have a one
>> to one mapping with a single pin - they can be differential inputs and
>> outputs, or entirely internal to a device.  Trying to push everything
>> into a single namespace just makes things confusing.
> 
> I didn't mean to suggest that they should be the same subsystem, but
> it would be nice to use similar in-kernel interfaces so that a driver
> author doesn't have to learn about six different interfaces for
> a new soc. If we add an adc subsystem, I would definitely recommend
> looking at how the others work.
Yup, I'm reading the clk api stuff right now.
> 
>>> Since there is no externally visible interface for this kind of
>>> adc driver, we can always fix it later, which helps a lot. How
>>> about putting it into drivers/adc or drivers/misc/adc for now
>>> and waiting for others to join it? We can then later make it a
>>> proper subsystem along the lines of gpio and pwm and move
>>> interfaces for input, hwmon and iio into the subsystem.
>>
>> I'm not sure that IIO isn't the kernel subsystem we're looking for here
>> - as I keep saying when this comes up it's just representing bare DACs
>> and ADCs pretty directly which looks like a generic subsystem to me.
> 
> Possible, yes. Until now, IIO is a subsystem for user-level access
> not for kernel access though, so it's not the right place yet.
Technically proof of concept code for kernel access went out this morning
(sorry, didn't cc you as you hadn't entered this thread yet).   It's
all of 10 lines of code right now.  But yeah, its userspace focussed.

https://lkml.org/lkml/2011/10/11/141

Covers basic hwmon type usage (polled single channel read).  I'm not nearly
as sure how to handle complex channel scans.  There's a lot of infrastructure
involved in those.

> If we decide to let IIO handle all ADC input, do you think it would
> also be the right place to do PWM output, rather than having a
> separate subsystem for that?
That's one I've been avoiding talking about.  The fuzzy region is between
DDS (direct digital synthesis - waveform generator) chips which we have
been taking in IIO so far.   We don't actually handle these that well
at the moment.  Our core channel registration code doesn't handle the
weird routing these can do - single underlying generator does several
synchronized waveforms.

Pwm is small compact and nice.  Perhaps a similar shim to that I proposed
to hwmon alongside that patch earlier.  So simple pwm only device sits
in pwm, but we have a general purpose driver sitting on IIO that can
provide pwm from an appropriate channel of a more complex device.
It would need hooks that aren't there at the moment and more of the
DDS control to become part of the IIO core.

We may ultimately want to hive off more of IIO into a layer sitting
at same level as other users. It's tricky to know where to make
such divisions though.

Jonathan
