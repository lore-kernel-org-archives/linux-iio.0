Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35268 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbGPNNZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2015 09:13:25 -0400
Received: by obbop1 with SMTP id op1so46388829obb.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2015 06:13:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <df6bb9ff98580cdb20ab08b7351a8124@imap.cosmopool.net>
References: <op.x1bjac2cfh00o9@enterprised.lan>
	<33438a3f3e237279d0807a4241efa495@imap.cosmopool.net>
	<CACRpkdaj+bgGMjmJvCQhYtUGw2sZ4QG==tZ98sCrNfYfGe6b2A@mail.gmail.com>
	<6b362223e8468749e236652b1f602c1b@imap.cosmopool.net>
	<CACRpkdYPT2pKRjPLVcoYXiGGeoZ+kwTaBJoA03Mn+5gKj0HVzg@mail.gmail.com>
	<df6bb9ff98580cdb20ab08b7351a8124@imap.cosmopool.net>
Date: Thu, 16 Jul 2015 15:13:25 +0200
Message-ID: <CACRpkdYaAxguEsW7m7KWhRJH14N+gzSTPkRdLGMK7WwPLtUw5A@mail.gmail.com>
Subject: Re: [RFC PATCH] iio: humidity: dht11: Rewrite decode algorithm,
 improve read reliability
From: Linus Walleij <linus.walleij@linaro.org>
To: Harald Geyer <harald@ccbib.org>
Cc: Jonathan Bell <jonathan@raspberrypi.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>,
	Richard Weinberger <richard@nod.at>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jul 9, 2015 at 4:06 PM,  <harald@ccbib.org> wrote:
> On Thu, 9 Jul 2015 12:59:16 +0200, Linus Walleij

>> Pull-up or not doesn't matter I think. That is only there to stabilize
>> the line if the output is set to something like high impedance.
>> You must certainly do not want an IRQ because a pull-up/down
>> is dragging your line past a trigger point, you still know what
>> is going on.
>
> Okay, I can simplify my point actually:
> If our GPIO pin is configured to use a drive strength of say 4mA and is
> connected to a device with drive strength >4mA we can always get signal
> edges during output. - Yes, this is not exactly what is going on with
> DHT11, but it is the most obvious example I can think of right now.

I think I need to understand exactly what is going on then, because
I don't understand this. Why can you always get signal edges
during output?

>> As in my other response, what could possibly make sense is
>> open drain/collector or open emitter/source.
>> https://en.wikipedia.org/wiki/Open_collector
>>
>> I am open to patches handling IRQ events on GPIO descriptors flagged
>> as open [drain/collector/emitter/source].
>>
>> But then make sure this line is flagged as such in the machine
>> descriptor / device tree.
>
> With the DTH11 the sensor is open collector but not the GPIO.

The GPIO flags are set by the consumer, not the provider.

The gpiolib can very well be made aware that the consumer is
open collector and allow IRQs on the line, without the provider
actually providing it.

It is a electronically speaking a violation of good design principles
and should maybe result in a comment in dmesg but as you
point out, this hardware design seems to request open collector
from a provider that doesn't really support it, but has been hacked
to survive the usecase anyways.

>>> In this case there are two uses for getting interrupts on our own
> output
>>> edges:
>>> 1) We get feedback if we successfully pulled the line up/down.
>>
>> Seems more apropriate to check by polling the line, possibly
>> using a timer.
>
> Yes, we could probably work around by polling, but that's an odd argument
> IMHO. That's a bit like "Don't bother with the FPU, we already know how
> to do floating point math in software".
>
> Of course polling is ugly: Even if we only have to do it once using a
> timer, it makes it quite a bit more difficult to get the overall timing
> of the data transmission right.

An argument could be that you don't know if the IRQ will be
instantiated and unmasked quickly enough under all
circumstances. Then a crititical poll loop is more stable.
Are we certain this cannot happen?

>>> 2) If we get interrupts on output edges, timestamps of all signal edges
>>> can
>>> be taken via the same codepath and thus be slightly more accurate. This
>>> probably is not important, but it is a nice thing to support.
>>
>> This seems more like a debug aid than something that should be done
>> in drivers.
>
> As said it's nothing terribly important, but I don't see why accurate
> timestamps wouldn't be nice to everybody trying to decode a signal.
> The DHT11 driver needs timestamps on all input edges to work. The
> timestamps on output edges are mostly useful for debugging in this case.
> It could be more important with the next driver to be written and it
> is a nice thing to support anyway.
>
>> I would think it is possibly something then that the driver
>> can set up and handle internally using debugfs rather than exporting it
>> to the gpiolib API.
>
> What do you have in mind? I don't get your point.

Instead of putting such interfaces in <linux/gpio/driver.h>,
put it in a local header in drivers/gpio/debug.h so that the
drivers that can share this cleverness can still do so, in their
debugfs hooks for example.

>>> Also, if we get spurious interrupts before receiving the actual data,
>>> there
>>> is less likelyhood of cache misses during reading the data, which might
>>> improve reliability.
>>
>> Isn't this usecase analogous to debouncing?
>
> Ah, sorry. "spurious interrupts" probably has the wrong spin.
> What I was trying to say was: If we get interrupts on output edges, then
> the interrupt handler and data structures will already be in cache when
> we start receiving the important input edges. Thus making the data
> transmission more reliable. That's not a usecase of it's own. Just a
> nice sideeffekt.

This seems race-prony and relies on speediness and timing,
that makes ever more convinced that polling is a stabler
approach.

> I hope the above explains what I had in mind when I wrote dht11.c - since
> Richard changed it mongth ago to comply with your model, I have little
> urge to convice you. However I do wonder: Did you find any real bugs with
> this check againt interrupts on output? If yes, then maybe some
> GPIO_I_KNOW_I_M_DOING_SOMETHING_ODD flag would be the way to go.

My concern is mostly with long term maintenance of the gpio
subsystem and not adding too many "good to have" features making
it obscure. Locally in specific drivers I am open to lots and lots of
mysterious code, also to the point of catching and handling interrupts
without exporting any irqchip for it, if that is what is needed.

I think overall that if this fix can be contained inside this specific
GPIO driver and not have us support IRQs on output lines at all,
I would be happier. These IRQs can be used to stabilize the output,
but only locally then, not all over the kernel.

Yours,
Linus Walleij
