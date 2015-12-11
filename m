Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
References: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
Date: Fri, 11 Dec 2015 13:53:05 +0100
Message-ID: <CACRpkdYN=n=Q+UpLbWjxJHP-FYi_e4cHFE_d1_fR2r7QYcqgYQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/2] Expose the PIO_ISR register on SAMA5D3
From: Linus Walleij <linus.walleij@linaro.org>
To: Peter Rosin <peda@lysator.liu.se>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Quoting extensively since I'm involving the linux-iio mailinglist.

The use case you describe is hand-in-glove with Industrial I/O.
I think you want a trigger interface from IIO and read events from
userspace using the IIO character device.

Look at the userspace examples in tools/iio for how it's used
in userspace, the subsystem is in drivers/iio. I suspect
drivers/iio/adc/polled-gpio.c or something is where you actually
want to go with this. The module should do all the fastpath
work and then expose what you actually want to know to
userspace using the IIO triggers or events.

I have used IIO myself, it is really neat for this kind of usecase,
and designed right from the ground up.

I think you whould think about how to write the right kind of
driver for IIO to do what you want.

Yours,
Linus Walleij

On Tue, Dec 8, 2015 at 4:20 AM, Peter Rosin <peda@lysator.liu.se> wrote:
> From: Peter Rosin <peda@axentia.se>
>
> Hi!
>
> I have a signal connected to a gpio pin which is the output of
> a comparator. By changing the level of one of the inputs to the
> comparator, I can detect the envelope of the other input to
> the comparator by using a series of measurements much in the
> same maner a manual ADC works, but watching for changes on the
> comparator over a period of time instead of only the immediate
> output.
>
> Now, the input signal to the comparator might have a high frequency,
> which will cause the output from the comparator (and thus the GPIO
> input) to change rapidly.
>
> A common(?) idiom for this is to use the interrupt status register
> to catch the glitches, but then not have any interrupt tied to
> the pin as that could possibly generate pointless bursts of
> (expensive) interrupts.
>
> So, these two patches expose an interface to the PIO_ISR register
> of the pio controllers on the platform I'm targetting. The first
> patch adds some infrastructure to the gpio core and the second
> patch hooks up "my" pin controller.
>
> But hey, this seems like an old problem and I was surprised that
> I had to touch the source to do it. Which makes me wonder what I'm
> missing and what others needing to see short pulses on a pin but not
> needing/wanting interrupts are doing?
>
> Yes, there needs to be a way to select the interrupt edge w/o
> actually arming the interrupt, that is missing. And probably
> other things too, but I didn't want to do more work in case this
> is a dead end for some reason...
>
> Cheers,
> Peter
>
> Peter Rosin (2):
>   gpio: Add isr property of gpio pins
>   pinctrl: at91: expose the isr bit
>
>  Documentation/gpio/sysfs.txt   |   12 ++++++++++
>  drivers/gpio/gpiolib-sysfs.c   |   30 ++++++++++++++++++++++++
>  drivers/gpio/gpiolib.c         |   15 ++++++++++++
>  drivers/pinctrl/pinctrl-at91.c |   50 ++++++++++++++++++++++++++++++++++++----
>  include/linux/gpio/consumer.h  |    1 +
>  include/linux/gpio/driver.h    |    2 ++
>  6 files changed, 106 insertions(+), 4 deletions(-)
>
> --
> 1.7.10.4
>
