Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37830 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdDHPtS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 11:49:18 -0400
Subject: Re: Digital I/O in IIO
To: Matt Ranostay <matt.ranostay@konsulko.com>,
        George McCollister <george.mccollister@gmail.com>
References: <CAFSKS=O-CrzxA6RJxrMNR=Vz-dN+zn1B95d+fUbUGcghRQgAjA@mail.gmail.com>
 <CAJCx=gmDBbSnNjJgqxhaZJ=LSmENf6_C1DXvazbuHvZDj16XwA@mail.gmail.com>
Cc: "open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d4da98ae-fb7a-10dc-afd2-e5a39de47d2b@kernel.org>
Date: Sat, 8 Apr 2017 16:49:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAJCx=gmDBbSnNjJgqxhaZJ=LSmENf6_C1DXvazbuHvZDj16XwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/17 07:21, Matt Ranostay wrote:
> On Thu, Apr 6, 2017 at 7:24 AM, George McCollister
> <george.mccollister@gmail.com> wrote:
>> In many industrial applications it's common to mix digital (binary)
>> and analog I/O. In many cases digital input modules have change
>> buffers and sometimes event time stamping capabilities. While the gpio
>> subsystem can support software timestamping and buffering it doesn't
>> fit well for many industrial digital applications where the host
>> process reads buffered digital samples or events from input modules.
>>
>> Would anyone appose or support the addition of digital channel type or
>> suggest an alternative path to supporting this use case?#
>>
>> A possible alternative is to use 1 bit for storage and use voltage for
>> type. For instance a 16 channel 24V DC Input module would present 16
>> input voltage channels with 1 bit of storage each. 0 would correspond
>> to 0VDC and 1 to 24VDC.
Pulled Linus Walleij in as he's always interested in these discussions.

Firstly, 24V for example could be made explicit by just having _scale set
appropriately. Often these units aren't that simple, but it'd be a start!

If we are dealing with data sampled on a regular clock (so like an ADC
sample) then we should indeed support it as a 1 bit voltage.  Mostly this
is easy to do, the fun question on this has always been what to do about
demuxing the buffers. Do we repack individual bits or not?  Don't really
want to store them in 8 bits each just to make repacking easy.

Hence we'd probably have to start allowing storage_bits values of less
than 8 (probably only for the 1 bit case initially!) and add the logic
to the demux to handle this. 

One previous suggestion on this was to have 1 bit values behave differently
from others, in that we don't repack them in the demux but just pass
on the byte they are contained within.  I don't like the semantics of
doing it that way but it would be a bit less code. I think if we are
going to do this we need a bit repacker in the demux.

> 
> I don't think IIO_VOLTAGE should be used for this since it is against
> the ABI definition.
> At the worse it should be reported as 0V and 24V, but I think using
> the events is a better solution.
> 
> IIO_EV_DIR_RISING  -> 24V
> IIO_EV_DIR_FALLING -> 0V
Events are certainly an option here, particularly if we have
a timestamp to go with them...

So your classic PLC had two types of input (which may well share
a given actual pin)

1) Scanned inputs - usually on something like a 5ms timer.
2) Capture inputs - these log a timestamp - and sometimes other things
such as a the position of than encoder unit at that instance (lets ignore
that one for now!)

Scanned inputs are as above - easy up to the demux extension needed.

Capture units either:
1) Events
2) Triggers driver buffers - allowing other channels to be sampled at the
capture instance if supported. Issue here is you then need one buffer per
capture input - plus point is that unlike a typically PLC you have a fifo
built in rather than having to shuffle these off before the next one shows
up.

Hmm. Non obvious what is the best approach.

Jonathan
> 
> 
>>
>> Cheers,
>> George McCollister
>> Software Architect
>> NovaTech LLC
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

