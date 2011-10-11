Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Tue, 11 Oct 2011 15:40:05 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zoltan Devai <zdevai@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Message-ID: <20111011144005.GI3471@opensource.wolfsonmicro.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
 <CAGVye5Nc9vhaF=7Y+hvGo4g-GOFb9fHeni+g=+hTj-8WCSqY+Q@mail.gmail.com>
 <20111010114407.GD3607@opensource.wolfsonmicro.com>
 <201110111617.52061.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201110111617.52061.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 11, 2011 at 04:17:51PM +0200, Arnd Bergmann wrote:
> On Monday 10 October 2011, Mark Brown wrote:

> > At the minute it seems to me that arch/arm is as good a place as any
> > really - currently this code is getting dumped wherever the main device
> > is.

> My feeling is that there is a general class of drivers involving
> the gpio, pinmux, pwm, led, adc and dac: these are basically all
> things you do with a single pin. Right now we have subsystems for
> some of them, adding some others and don't have anything for adc
> basides iio (which only partially fits here).

We've been round this loop repeatedly before, trying to push all this
stuff into pins really doesn't map terribly well.  For example, SoCs
will frequently have PWM controllers which are isolated IP blocks within
the device and may each have multiple mappings out of the device onto
pins.  In the case of DACs, ADCs and PWM you definitely don't have a one
to one mapping with a single pin - they can be differential inputs and
outputs, or entirely internal to a device.  Trying to push everything
into a single namespace just makes things confusing.

What we *do* have a pattern of is clk API type lookups based on a
device/name pair.

> Since there is no externally visible interface for this kind of
> adc driver, we can always fix it later, which helps a lot. How
> about putting it into drivers/adc or drivers/misc/adc for now
> and waiting for others to join it? We can then later make it a
> proper subsystem along the lines of gpio and pwm and move
> interfaces for input, hwmon and iio into the subsystem.

I'm not sure that IIO isn't the kernel subsystem we're looking for here
- as I keep saying when this comes up it's just representing bare DACs
and ADCs pretty directly which looks like a generic subsystem to me.
