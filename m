Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <op.x1cc5l17fh00o9@enterprised.lan>
References: <op.x1bjac2cfh00o9@enterprised.lan>
	<33438a3f3e237279d0807a4241efa495@imap.cosmopool.net>
	<op.x1cc5l17fh00o9@enterprised.lan>
Date: Thu, 9 Jul 2015 12:49:26 +0200
Message-ID: <CACRpkdaOdXtOj2T5h_dT+cYkKEKmqVRE-hBq9sRpOdiruvZ4+Q@mail.gmail.com>
Subject: Re: [RFC PATCH] iio: humidity: dht11: Rewrite decode algorithm,
 improve read reliability
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Bell <jonathan@raspberrypi.org>
Cc: Harald Geyer <harald@ccbib.org>, Jonathan Cameron <jic23@kernel.org>,
	Sanjeev Sharma <sanjeev_sharma@mentor.com>, Richard Weinberger <richard@nod.at>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 6, 2015 at 9:45 AM, Jonathan Bell <jonathan@raspberrypi.org> wrote:

>> That was the original behaviour, but is actively prohibited by some GPIO
>> chip drivers. We asked Linus Walleij about it in
>> https://lkml.org/lkml/2014/12/1/171 who replied:
>> "IRQs on pins set to output *does* *not* *make* *sense*." I still
>> disagree,
>> but I don't feel like diving into discussions like this. I'll be happy if
>> you can convince him, because the DHT11 driver lost a nice diagnostic
>> feature with that change, but before that GPIO code is changed, there is
>> no chance this can be added back.
>
> These sensors are prodded by initially driving their data line low for a
> long period (some ms) and then reverting the pin to an input to listen to
> their response. The first bit-edge arrives about 27us after reverting the
> pin to an input.

OK that merely seems to be calls to gpiod_direction_output()
setting the line low, msleep(x), gpiod_direction_input(), then possibly
trigger an IRQ on that input using gpiod_to_irq(). No need for an
output to register an IRQ?

> I moved the request_irq() back to the probe function originally because the
> first edge was going missing - request_irq wasn't completing before the
> first edge arrived in 27uS.

Aha I see. That seems fairly slow, but if it is that quick to initialize
maybe you can just poll for it by reading the input line instead of setting
up an IRQ? Seems like something you may want to do anyways for
stability.

> There is no electrical reason why GPIO outputs cannot also be interrupt
> sources.  The generation of interrupts from edge/level events simply samples
> the state of the pad and acts accordingly - it doesn't care what's driving
> it (or at least shouldn't do). I'd be interested to see if there's any GPIO
> hardware that gates its interrupt generation system with "am I an input?".
> If the GPIO API doesn't support this then OK, there may be reasons why (such
> as the locking referred to in the linked thread).

There is no hardware limitation that I know, most SoC GPIO blocks
use an synchronous or asynchronous interrupt generator with edge
detection and latched status registers and that will usually trigger
also if you drive it by writing the line registers.

What troubles me is the usecase: you want an IRQ because something
happened and you want to know what that was. But if you just
drive the line high or low you are being informed about your own
actions and that just doesn't make sense.

So in this case I assume that for this to make any sense the line
must be open-collector/open-drain or something so it can go to
another value even if we're driving it in some way?

In that case GPIO_OPEN_DRAIN or GPIO_OPEN_SOURCE
should be set in the descriptor table, and we can add logic to allow
IRQs on outputs if and only if it has one of these flags set.

> Rethinking the patch a bit, if we're now right-justifying our decode then we
> shouldn't care if we miss interrupts for the start bit or the first phase of
> the response, so we can work around it.

OK even better.

Yours,
Linus Walleij
