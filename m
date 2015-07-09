Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <6b362223e8468749e236652b1f602c1b@imap.cosmopool.net>
References: <op.x1bjac2cfh00o9@enterprised.lan>
	<33438a3f3e237279d0807a4241efa495@imap.cosmopool.net>
	<CACRpkdaj+bgGMjmJvCQhYtUGw2sZ4QG==tZ98sCrNfYfGe6b2A@mail.gmail.com>
	<6b362223e8468749e236652b1f602c1b@imap.cosmopool.net>
Date: Thu, 9 Jul 2015 12:59:16 +0200
Message-ID: <CACRpkdYPT2pKRjPLVcoYXiGGeoZ+kwTaBJoA03Mn+5gKj0HVzg@mail.gmail.com>
Subject: Re: [RFC PATCH] iio: humidity: dht11: Rewrite decode algorithm,
 improve read reliability
From: Linus Walleij <linus.walleij@linaro.org>
To: Harald Geyer <harald@ccbib.org>
Cc: Jonathan Bell <jonathan@raspberrypi.org>, Jonathan Cameron <jic23@kernel.org>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>, Richard Weinberger <richard@nod.at>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 6, 2015 at 10:02 AM,  <harald@ccbib.org> wrote:

>> I just don't understand this usecase. Can you explain to me
>> what you are doing and why exactly so as to soften me up
>> a bit?
>
> Sure. The HW setup where this makes most sense is if the GPIO pin has
> a fixed drive strength (say 4mA) and is connected to some pullup or
> pulldown
> resistor - maybe on the client device.

Pull-up or not doesn't matter I think. That is only there to stabilize
the line if the output is set to something like high impedance.
You must certainly do not want an IRQ because a pull-up/down
is dragging your line past a trigger point, you still know what
is going on.

As in my other response, what could possibly make sense is
open drain/collector or open emitter/source.
https://en.wikipedia.org/wiki/Open_collector

I am open to patches handling IRQ events on GPIO descriptors flagged
as open [drain/collector/emitter/source].

But then make sure this line is flagged as such in the machine
descriptor / device tree.

> In this case there are two uses for getting interrupts on our own output
> edges:
> 1) We get feedback if we successfully pulled the line up/down.

Seems more apropriate to check by polling the line, possibly
using a timer. IRQ seems highly inapropriate since it is an expected
event and it must have a timeout anyways.

> 2) If we get interrupts on output edges, timestamps of all signal edges
> can
> be taken via the same codepath and thus be slightly more accurate. This
> probably is not important, but it is a nice thing to support.

This seems more like a debug aid than something that should be done
in drivers. I would think it is possibly something then that the driver
can set up and handle internally using debugfs rather than exporting it
to the gpiolib API.

> Also, if we get spurious interrupts before receiving the actual data,
> there
> is less likelyhood of cache misses during reading the data, which might
> improve reliability.

Isn't this usecase analogous to debouncing?

For example drivers/input/keyboard/gpio_keys.c has software
debouncing and I have toyed with the idea of simply moving this
to the GPIO library so clients can request debouncing for any
GPIO line if they need.

Yours,
Linus Walleij
