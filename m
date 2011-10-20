Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:40522 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab1JTIdY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2011 04:33:24 -0400
Message-ID: <4E9FDCD9.7030202@cam.ac.uk>
Date: Thu, 20 Oct 2011 09:33:29 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-arm-kernel@lists.infradead.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com> <4E9EFE0B.2030205@cam.ac.uk> <4E9F15B6.90506@free-electrons.com> <20111020090532.7df7af70@skate>
In-Reply-To: <20111020090532.7df7af70@skate>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Bringing in Mark and Linus as others who have been active in talking ab=
out
similar issues.
> Hello,
>=20
> Le Wed, 19 Oct 2011 20:23:50 +0200,
> Maxime Ripard <maxime.ripard@free-electrons.com> a =C3=A9crit :
>=20
>> On 19/10/2011 18:42, Jonathan Cameron wrote:
>>> Afraid I'm out of time for today, but just thought I'd ask one quic=
k question...
>>>
>>> Why isn't this touchscreen ADC in input?
>>
>> Because what I say in the Kconfig is mostly wrong... Sorry about tha=
t.
>>
>> Actually, like I was saying, this ADC is present in a lot of AT91 So=
C,
>> and while it is always an ADC, sometimes (like on the G45), it can b=
e
>> used as a touchscreen controller, or even as both, with channels for=
 the
>> touchscreen and channels as ADC. On the G20 however, it is just an A=
DC.
>>
>> For now, the plan is only to support the ADC mode, so I put it in ad=
c.
>=20
> Just to expand a bit on this: there is already in the kernel an input
> driver for the AT91 touchscreen which uses some ADC channels (that ha=
ve
> additional touchscreen-related features: on the G45, you have 8 ADCs
> channels, 4 can optionally be used for touchscreen, the 4 other are
> just raw ADCs).
>=20
> The ultimate goal is of course to make it possible to use both the II=
O
> AT91 ADC driver and the AT91 touchscreen driver work simultaneously
> (with of course non-conflicting ADC channels usage). However, as show=
n
> by recent discussions on this list, it is not yet entirely clearly ho=
w
> this should be done:
>=20
>  * Should we have some low-level ADC driver in arch/arm/mach-at91/ th=
at
>    allows to request/release/access the ADC channels, this driver
>    providing an internal kernel API used by the IIO ADC driver and th=
e
>    touchscreen driver ?
That's definitely not going to go down well against moves to move every=
thing
that looks like a driver out of the arch directories. An equivalent som=
ewhere
else might work though.
>=20
>            sysfs access                  /dev/input/...
>            to ADC channels               access to touchscreen
>                 ||                              ||
>                 \/                              \/
>         +------------------+            +------------------+
>         |     AT91 IIO     |            | AT91 touchscreen |
>         +------------------+            +------------------+
>                  |                               |
>                  \_______________________________/
>                                  |
>                         +---------------------+
>                         | Some low-level ADC  |
>                         | code to request,    |
>                         | release and access  |
>                         | ADC channels        |
>                         +---------------------+
>=20
>  * Should IIO provide some internal kernel API (as you suggested some
>    time ago) so that kernel drivers can use ADC channels ?
>=20
>=20
>             +-------------------+
>             | AT91 touchscreen  | -> /dev/input/... access to touchsc=
reen
>             +-------------------+
>                      ||
>                      \/
>             +-------------------+
>             |   AT91 IIO        | -> sysfs access to ADC channels
>             +-------------------+
>=20
> Regards,
>=20
> Thomas
Agreed.  This is currently up in the air. The current state of those II=
O
hooks is that they do pull only.  Push based capture is tricky as for I=
IO
we want to control the triggering of the push at a far finer scale than
makes sense for input. I'm not yet clear how these two will play togeth=
er.

If we sit something underneath the IIO and input drivers (or use the lo=
wer
portions of IIO to do this) then the intent would be to have a fully ge=
neric
input touchscreen driver on top.  I'm not sure that's possible. For
example are the switches on the G45's adc (from datasheet) something th=
at
all/many similar touch screen controllers have?
I suppose we could support these in the chan_spec but only if it helps
us to write a generic touch screen driver on top.  I have no real
feeling for whether this would be possible...
(all my boards are headless ;)

Jonathan
