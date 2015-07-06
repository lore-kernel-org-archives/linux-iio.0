Return-Path: <harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2015 10:02:26 +0200
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
In-Reply-To: <CACRpkdaj+bgGMjmJvCQhYtUGw2sZ4QG==tZ98sCrNfYfGe6b2A@mail.gmail.com>
References: <op.x1bjac2cfh00o9@enterprised.lan> <33438a3f3e237279d0807a4241efa495@imap.cosmopool.net> <CACRpkdaj+bgGMjmJvCQhYtUGw2sZ4QG==tZ98sCrNfYfGe6b2A@mail.gmail.com>
Message-ID: <6b362223e8468749e236652b1f602c1b@imap.cosmopool.net>
List-ID: <linux-iio@vger.kernel.org>

On Mon, 6 Jul 2015 01:50:13 +0200, Linus Walleij
<linus.walleij@linaro.org>
wrote:
> On Mon, Jul 6, 2015 at 1:39 AM,  <harald@ccbib.org> wrote:
>> On Sun, 5 Jul 2015 22:00:02 +0100, Jonathan Bell
>> <jonathan@raspberrypi.org>
>> wrote:
> 
>>> - Cater for GPIO chips that can raise interrupts when I/O pins
>>>    are set as output by expanding the maximum number of edges
recorded.
>>> - Start decoding the bitstream right-justified to make the driver
>> agnostic
>>>    towards whether the start bits generate IRQs.
>>
>> That was the original behaviour, but is actively prohibited by some
GPIO
>> chip drivers. We asked Linus Walleij about it in
>> https://lkml.org/lkml/2014/12/1/171 who replied:
>> "IRQs on pins set to output *does* *not* *make* *sense*." I still
>> disagree,
> 
> I just don't understand this usecase. Can you explain to me
> what you are doing and why exactly so as to soften me up
> a bit?

Sure. The HW setup where this makes most sense is if the GPIO pin has
a fixed drive strength (say 4mA) and is connected to some pullup or
pulldown
resistor - maybe on the client device.

In this case there are two uses for getting interrupts on our own output
edges:
1) We get feedback if we successfully pulled the line up/down. With DHT11
we
can get information about the device status this way, since a device that
is
connected but not powered will pull the line low stronger than 4mA. So we
see
now edges at all in this case, while in the not connected at all case, we
still see our own edges.
2) If we get interrupts on output edges, timestamps of all signal edges
can
be taken via the same codepath and thus be slightly more accurate. This
probably is not important, but it is a nice thing to support.

Also, if we get spurious interrupts before receiving the actual data,
there
is less likelyhood of cache misses during reading the data, which might
improve reliability.

Hope that explains,
Harald
