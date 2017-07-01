Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751752AbdGASBg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Jul 2017 14:01:36 -0400
Date: Sat, 1 Jul 2017 19:01:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <linux-iio@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Guidelines for ADC resistive touchscreen
Message-ID: <20170701190132.5643e341@kernel.org>
In-Reply-To: <073067e9-4c8e-32f1-d68c-8fb10682a8f3@microchip.com>
References: <073067e9-4c8e-32f1-d68c-8fb10682a8f3@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Jun 2017 13:05:01 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Hello Jonathan,
> 
> I want to kindly ask for some advice regarding the support for our
> resistive touchscreen over ADC for SAMA5D2 SoC.
> 
> The ADC block supports both classic ADC and can use 4/5 channels
> for a connected resistive touchscreen measurements.
> A MFD driver works ok, but I was considering doing it a little
> bit better (or different, that is).
> 
> One idea that comes to my mind is to change the channel exposure
> for the ADC towards the subsystem and add distance or another type of
> channel (perhaps a x-y mod ?) and pressure channels, and then report
> events on those channels using the event system from the iio.
Interesting thought.  Certainly valid to have distance channels +
some sort of pressure channel.  Would need to come through the standard
buffer interface rather than events in IIO (though that is just
a case of terminology)
> 
> This way, the touchscreen input driver would be minimal and register
> to the events and report them to the input subsystem (The ADC
> driver would handle the register settings, continuous trigger start,
> touchscreen IRQ, retrieving the data from the touch, and then report
> them as events).
This is where it gets messy.  The very nature of touch makes it meta
data heavy.  We tend to get a 'pen down' event - in IIO that would be
a pressure threshold so would count as an event (so out of band with
the data flow) followed by the stream of data - effectively fed from
a trigger gated on the pressure event.

At the moment we don't have in kernel consumer support for IIO events.
All IIO events are basically thresholds of one type or another.  The
normal sampled data isn't considered and event as such.  Now,
it's been on the todo list for a very long time so I'm certainly
keen on adding such support!  For touch, as long as the pen down event
made it through fast enough that the buffer could absorb any racing
with x,y,pressure tripples that would be fine I think.
> 
> This can also include exposing the continuous trigger for touch sampling
> and the channels as digital values and let the touchscreen driver
> register them as a consumer for the trigger.
This is nice.   We've previously had resistive touch screen controllers
using the ADC channels directly, but they've always been heavier on the
'special sauce' in the touch screen driver itself.
> 
> Or you think a MFD driver is still the best idea, and divide the
> register settings between the two subdrivers ? (and have the common
> grounds like regulators in the MFD driver)
It can work well when the two functionalities are well separated -
sometimes we are looking at separate sequencers for touch and general
purpose ADC for example.  In those cases it's clean.

The tricky bit for the consumer approach you describe, comes when you
are using some channels for fast general purpose ADC (so buffered)
and some for touch.  In those cases you tend to be looking
at separate sequencers and separate interrupts.  This means you have
two sets of differently timed data.   Once that happens, it has to be
two separate IIO buffers and the only way to do that is multiple
IIO devices.  At this point you are rapidly heading into mfd territory
anyway, so sometimes it is cleaner to go the whole way. 

On this particular part (quick skim of datasheet later...)
http://www.mouser.com/ds/2/268/Atmel-11267-32-bit-Cortex-A5-Microcontroller-SAMA5-1065498.pdf
61.6.15.7
It looks like it does run on the same trigger as the adc but
with a divider allowed so that it only runs every N triggers...
Hmm. That would be awkward to support as a single device.

Interesting that it doesn't explicitly only capture when
pen detected, it's just suggesting using that for post
processing... Makes life slightly easier.
> 
> I see some other drivers have an input device registered directly
> from the iio driver. Is that still applicable ?
I'll let Dmitry add to this, but generally we've let that happen where
the amount of code needed to add touch support has been very small and
hence it didn't seem worth the hassle of an mfd.  Of course, there is
always a trade off with putting driver elements in other subsystems.

So far Dmitry has been fine with this but it's definitely on a case
by case basis.

Interested to see how you progress with this!

Jonathan
> 
> Any insight is appreciated and thanks,
> Eugen

