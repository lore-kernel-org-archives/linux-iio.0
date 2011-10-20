Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Thu, 20 Oct 2011 10:49:19 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-iio@vger.kernel.org, Patrice Vilchez <patrice.vilchez@atmel.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 linux-arm-kernel@lists.infradead.org, Mark Brown
 <broonie@opensource.wolfsonmicro.com>, Linus Walleij
 <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
Message-ID: <20111020104919.303e3133@skate>
In-Reply-To: <4E9FDCD9.7030202@cam.ac.uk>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com>
	<4E9EFE0B.2030205@cam.ac.uk>
	<4E9F15B6.90506@free-electrons.com>
	<20111020090532.7df7af70@skate>
	<4E9FDCD9.7030202@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Le Thu, 20 Oct 2011 09:33:29 +0100,
Jonathan Cameron <jic23@cam.ac.uk> a =C3=A9crit :

> >  * Should we have some low-level ADC driver in arch/arm/mach-at91/ that
> >    allows to request/release/access the ADC channels, this driver
> >    providing an internal kernel API used by the IIO ADC driver and the
> >    touchscreen driver ?
> That's definitely not going to go down well against moves to move everyth=
ing
> that looks like a driver out of the arch directories. An equivalent somew=
here
> else might work though.

Yes, of course if this needs to be implemented, it should be in some
other location than arch/arm, but not sure where (which is basically
the discussion that was started some time ago).

> Agreed.  This is currently up in the air. The current state of those IIO
> hooks is that they do pull only.  Push based capture is tricky as for IIO
> we want to control the triggering of the push at a far finer scale than
> makes sense for input. I'm not yet clear how these two will play together.

My IIO knowledge is still too limited to understand what's the problem
with exposing an API for push-based capture.

> If we sit something underneath the IIO and input drivers (or use the lower
> portions of IIO to do this) then the intent would be to have a fully gene=
ric
> input touchscreen driver on top.  I'm not sure that's possible.

I am not sure it's possible to make the touchscreen driver generic. On
the G45, the ADC IP has some generic ADC registers, but also some
touchscreen-specific registers. So the touchscreen driver probably
cannot be completely generic and some cooperation between the AT91 ADC
driver and the AT91 touchscreen driver might be needed. I'd have to
look into more details on how the AT91 touchscreen thing works to
provide some more details here.

> For example are the switches on the G45's adc (from datasheet) something =
that
> all/many similar touch screen controllers have?

I have no idea.

However, I have also seen a platform (SuperH 2A) where ADC channels are
used for keypad handling. 4 ADCs channels, each connected to 4 keys,
each having a different resistor. Depending on the voltage measured at
the ADC, you're capable of knowing which key of the 4x4 keypad is
pressed. This is a different situation where the ADC values need to be
used by another in-kernel driver.

Regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
