Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Thu, 20 Oct 2011 09:05:32 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Jonathan Cameron
 <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Patrice Vilchez <patrice.vilchez@atmel.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
Message-ID: <20111020090532.7df7af70@skate>
In-Reply-To: <4E9F15B6.90506@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com>
	<4E9EFE0B.2030205@cam.ac.uk>
	<4E9F15B6.90506@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hello,

Le Wed, 19 Oct 2011 20:23:50 +0200,
Maxime Ripard <maxime.ripard@free-electrons.com> a =C3=A9crit :

> On 19/10/2011 18:42, Jonathan Cameron wrote:
> > Afraid I'm out of time for today, but just thought I'd ask one quick qu=
estion...
> >=20
> > Why isn't this touchscreen ADC in input?
>=20
> Because what I say in the Kconfig is mostly wrong... Sorry about that.
>=20
> Actually, like I was saying, this ADC is present in a lot of AT91 SoC,
> and while it is always an ADC, sometimes (like on the G45), it can be
> used as a touchscreen controller, or even as both, with channels for the
> touchscreen and channels as ADC. On the G20 however, it is just an ADC.
>=20
> For now, the plan is only to support the ADC mode, so I put it in adc.

Just to expand a bit on this: there is already in the kernel an input
driver for the AT91 touchscreen which uses some ADC channels (that have
additional touchscreen-related features: on the G45, you have 8 ADCs
channels, 4 can optionally be used for touchscreen, the 4 other are
just raw ADCs).

The ultimate goal is of course to make it possible to use both the IIO
AT91 ADC driver and the AT91 touchscreen driver work simultaneously
(with of course non-conflicting ADC channels usage). However, as shown
by recent discussions on this list, it is not yet entirely clearly how
this should be done:

 * Should we have some low-level ADC driver in arch/arm/mach-at91/ that
   allows to request/release/access the ADC channels, this driver
   providing an internal kernel API used by the IIO ADC driver and the
   touchscreen driver ?

           sysfs access                  /dev/input/...
           to ADC channels               access to touchscreen
                ||                              ||
                \/                              \/
        +------------------+            +------------------+
        |     AT91 IIO     |            | AT91 touchscreen |
        +------------------+            +------------------+
                 |                               |
                 \_______________________________/
                                 |
                        +---------------------+
                        | Some low-level ADC  |
                        | code to request,    |
                        | release and access  |
                        | ADC channels        |
                        +---------------------+

 * Should IIO provide some internal kernel API (as you suggested some
   time ago) so that kernel drivers can use ADC channels ?


            +-------------------+
            | AT91 touchscreen  | -> /dev/input/... access to touchscreen
            +-------------------+
                     ||
                     \/
            +-------------------+
            |   AT91 IIO        | -> sysfs access to ADC channels
            +-------------------+

Regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
