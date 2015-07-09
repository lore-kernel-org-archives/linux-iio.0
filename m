Return-Path: <harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2015 16:06:28 +0200
From: <harald@ccbib.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Bell <jonathan@raspberrypi.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Sanjeev Sharma <sanjeev_sharma@mentor.com>,
 Richard Weinberger <richard@nod.at>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH] iio: humidity: dht11: Rewrite decode algorithm, improve
 read reliability
In-Reply-To: <CACRpkdYPT2pKRjPLVcoYXiGGeoZ+kwTaBJoA03Mn+5gKj0HVzg@mail.gmail.com>
References: <op.x1bjac2cfh00o9@enterprised.lan> <33438a3f3e237279d0807a4241efa495@imap.cosmopool.net> <CACRpkdaj+bgGMjmJvCQhYtUGw2sZ4QG==tZ98sCrNfYfGe6b2A@mail.gmail.com> <6b362223e8468749e236652b1f602c1b@imap.cosmopool.net> <CACRpkdYPT2pKRjPLVcoYXiGGeoZ+kwTaBJoA03Mn+5gKj0HVzg@mail.gmail.com>
Message-ID: <df6bb9ff98580cdb20ab08b7351a8124@imap.cosmopool.net>
List-ID: <linux-iio@vger.kernel.org>

On Thu, 9 Jul 2015 12:59:16 +0200, Linus Walleij
<linus.walleij@linaro.org>
wrote:
> On Mon, Jul 6, 2015 at 10:02 AM,  <harald@ccbib.org> wrote:
> 
>>> I just don't understand this usecase. Can you explain to me
>>> what you are doing and why exactly so as to soften me up
>>> a bit?
>>
>> Sure. The HW setup where this makes most sense is if the GPIO pin has
>> a fixed drive strength (say 4mA) and is connected to some pullup or
>> pulldown
>> resistor - maybe on the client device.
> 
> Pull-up or not doesn't matter I think. That is only there to stabilize
> the line if the output is set to something like high impedance.
> You must certainly do not want an IRQ because a pull-up/down
> is dragging your line past a trigger point, you still know what
> is going on.

Okay, I can simplify my point actually:
If our GPIO pin is configured to use a drive strength of say 4mA and is
connected to a device with drive strength >4mA we can always get signal
edges during output. - Yes, this is not exactly what is going on with
DHT11, but it is the most obvious example I can think of right now.

> As in my other response, what could possibly make sense is
> open drain/collector or open emitter/source.
> https://en.wikipedia.org/wiki/Open_collector
> 
> I am open to patches handling IRQ events on GPIO descriptors flagged
> as open [drain/collector/emitter/source].
> 
> But then make sure this line is flagged as such in the machine
> descriptor / device tree.

With the DTH11 the sensor is open collector but not the GPIO.

>> In this case there are two uses for getting interrupts on our own
output
>> edges:
>> 1) We get feedback if we successfully pulled the line up/down.
> 
> Seems more apropriate to check by polling the line, possibly
> using a timer. 

Yes, we could probably work around by polling, but that's an odd argument
IMHO. That's a bit like "Don't bother with the FPU, we already know how
to do floating point math in software".

Of course polling is ugly: Even if we only have to do it once using a
timer, it makes it quite a bit more difficult to get the overall timing
of the data transmission right.

> IRQ seems highly inapropriate since it is an expected
> event and it must have a timeout anyways.

Well, the driver already has irq handler and timeout in place, so that's
not a problem. The version with interupts on output was less lines of
code than what we have now and we got the diagnostic data for free.
With polling we would have to add even more code to get this back.
So I decided to just drop that feature to keep the code simple.

>> 2) If we get interrupts on output edges, timestamps of all signal edges
>> can
>> be taken via the same codepath and thus be slightly more accurate. This
>> probably is not important, but it is a nice thing to support.
> 
> This seems more like a debug aid than something that should be done
> in drivers.

As said it's nothing terribly important, but I don't see why accurate
timestamps wouldn't be nice to everybody trying to decode a signal.
The DHT11 driver needs timestamps on all input edges to work. The
timestamps on output edges are mostly useful for debugging in this case.
It could be more important with the next driver to be written and it
is a nice thing to support anyway.

> I would think it is possibly something then that the driver
> can set up and handle internally using debugfs rather than exporting it
> to the gpiolib API.

What do you have in mind? I don't get your point.

>> Also, if we get spurious interrupts before receiving the actual data,
>> there
>> is less likelyhood of cache misses during reading the data, which might
>> improve reliability.
> 
> Isn't this usecase analogous to debouncing?

Ah, sorry. "spurious interrupts" probably has the wrong spin.
What I was trying to say was: If we get interrupts on output edges, then
the interrupt handler and data structures will already be in cache when
we start receiving the important input edges. Thus making the data
transmission more reliable. That's not a usecase of it's own. Just a
nice sideeffekt.

I hope the above explains what I had in mind when I wrote dht11.c - since
Richard changed it mongth ago to comply with your model, I have little
urge to convice you. However I do wonder: Did you find any real bugs with
this check againt interrupts on output? If yes, then maybe some
GPIO_I_KNOW_I_M_DOING_SOMETHING_ODD flag would be the way to go.

best regards,
Harald
