Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
Date: Tue, 11 Oct 2011 17:24:47 +0200
Cc: Zoltan Devai <zdevai@gmail.com>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org
References: <1318178172-7965-1-git-send-email-zoss@devai.org> <201110111617.52061.arnd@arndb.de> <20111011144005.GI3471@opensource.wolfsonmicro.com>
In-Reply-To: <20111011144005.GI3471@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201110111724.48069.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Tuesday 11 October 2011, Mark Brown wrote:
> On Tue, Oct 11, 2011 at 04:17:51PM +0200, Arnd Bergmann wrote:
> > On Monday 10 October 2011, Mark Brown wrote:
> 
> > > At the minute it seems to me that arch/arm is as good a place as any
> > > really - currently this code is getting dumped wherever the main device
> > > is.
> 
> > My feeling is that there is a general class of drivers involving
> > the gpio, pinmux, pwm, led, adc and dac: these are basically all
> > things you do with a single pin. Right now we have subsystems for
> > some of them, adding some others and don't have anything for adc
> > basides iio (which only partially fits here).
> 
> We've been round this loop repeatedly before, trying to push all this
> stuff into pins really doesn't map terribly well.  For example, SoCs
> will frequently have PWM controllers which are isolated IP blocks within
> the device and may each have multiple mappings out of the device onto
> pins.  In the case of DACs, ADCs and PWM you definitely don't have a one
> to one mapping with a single pin - they can be differential inputs and
> outputs, or entirely internal to a device.  Trying to push everything
> into a single namespace just makes things confusing.

I didn't mean to suggest that they should be the same subsystem, but
it would be nice to use similar in-kernel interfaces so that a driver
author doesn't have to learn about six different interfaces for
a new soc. If we add an adc subsystem, I would definitely recommend
looking at how the others work.

> > Since there is no externally visible interface for this kind of
> > adc driver, we can always fix it later, which helps a lot. How
> > about putting it into drivers/adc or drivers/misc/adc for now
> > and waiting for others to join it? We can then later make it a
> > proper subsystem along the lines of gpio and pwm and move
> > interfaces for input, hwmon and iio into the subsystem.
> 
> I'm not sure that IIO isn't the kernel subsystem we're looking for here
> - as I keep saying when this comes up it's just representing bare DACs
> and ADCs pretty directly which looks like a generic subsystem to me.

Possible, yes. Until now, IIO is a subsystem for user-level access
not for kernel access though, so it's not the right place yet.
If we decide to let IIO handle all ADC input, do you think it would
also be the right place to do PWM output, rather than having a
separate subsystem for that?

	Arnd
