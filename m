Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <3CDC61F5-716E-4400-82FF-CC9E89358088@jic23.retrosnub.co.uk>
References: <1462805775-7723-1-git-send-email-linus.walleij@linaro.org>
	<1462805775-7723-2-git-send-email-linus.walleij@linaro.org>
	<d76ecc9c-a6a9-59c9-afd9-8f0ae9eb0dff@intel.com>
	<3CDC61F5-716E-4400-82FF-CC9E89358088@jic23.retrosnub.co.uk>
Date: Tue, 10 May 2016 10:24:39 +0200
Message-ID: <CACRpkdbj7wRuiK8TojO0FBA8ZqNxJsUpQmUApNRQ3eqfHO5nFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: st_sensors: read surplus samples in trigger
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, May 9, 2016 at 11:26 PM, Jonathan Cameron
<jic23@jic23.retrosnub.co.uk> wrote:

>>An infinite loop in the threaded interrupt handler looks odd. Are you
>>sure this is allowed? I do my tests in qemu with an usb adapter and if
>>I
>>run with -smp 1 it seems to be impossible to stop the irq thread.
>
> Definitely not allowed....
>
> Long term we need a way to throttle or fault out after first few loops.
>
> Right now this improves situation even if we just let it happen say 10 times to ride
> our slight delays...

OK I'm putting in a hard limit to 10 loops.

> I ideally want to fire up my board and hammer this as well, plus read it very
> carefully to see if this really closes all potential races...

I'm doing my best, as far as I can tell this is how threaded
interrupts solve thing, normally.

As long as no hardirqs get masked, it should work. That
would only happen if a new IRQ happens while we're inside
the hard IRQ handler, so as long as this is fast enough (which
I guess is the assumption we make on all top halves) we
should be safe.

As the driver currently has a limitation and does not allow
to connect the sensor to an interrupt controller which itself
is threaded (such as a GPIO expander on an I2C bus) we
should be safe for the time being.

If we want to support the latter usecase at some point, we
may have problems: the I2C traffic to the expander itself
will maybe lead us to miss IRQs. But then it is really the
latency of the whole system causing things to break, not this
driver: the components used simply aren't fast enough.

I think in such cases the only safe way to read values is
to give up due to bad system architecture and to fall back to
using an HRTimer to poll the sensor.

Yours,
Linus Walleij
