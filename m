Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:44896 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab1JTJTN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2011 05:19:13 -0400
Message-ID: <4E9FE793.3050208@cam.ac.uk>
Date: Thu, 20 Oct 2011 10:19:15 +0100
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
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com> <4E9EFE0B.2030205@cam.ac.uk> <4E9F15B6.90506@free-electrons.com> <20111020090532.7df7af70@skate> <4E9FDCD9.7030202@cam.ac.uk> <20111020104919.303e3133@skate>
In-Reply-To: <20111020104919.303e3133@skate>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/20/11 09:49, Thomas Petazzoni wrote:
> Le Thu, 20 Oct 2011 09:33:29 +0100,
> Jonathan Cameron <jic23@cam.ac.uk> a =C3=A9crit :
>=20
>>>  * Should we have some low-level ADC driver in arch/arm/mach-at91/ =
that
>>>    allows to request/release/access the ADC channels, this driver
>>>    providing an internal kernel API used by the IIO ADC driver and =
the
>>>    touchscreen driver ?
>> That's definitely not going to go down well against moves to move ev=
erything
>> that looks like a driver out of the arch directories. An equivalent =
somewhere
>> else might work though.
>=20
> Yes, of course if this needs to be implemented, it should be in some
> other location than arch/arm, but not sure where (which is basically
> the discussion that was started some time ago).
>=20
>> Agreed.  This is currently up in the air. The current state of those=
 IIO
>> hooks is that they do pull only.  Push based capture is tricky as fo=
r IIO
>> we want to control the triggering of the push at a far finer scale t=
han
>> makes sense for input. I'm not yet clear how these two will play tog=
ether.
>=20
> My IIO knowledge is still too limited to understand what's the proble=
m
> with exposing an API for push-based capture.
I'll give a quick summary:

Push in IIO is done from a trigger (imagine an oscilloscope).  Those tr=
iggers
may be supplied by a dataready signal or from somewhere entirely differ=
ent.
Also multiple devices can be triggered by the same signal.  Thus the da=
taready
from one chip can trigger a whole load of others.

Right now filtering functions prevent some devices from using anything =
other than
their own trigger.  Setting defaults is also possible. If anything is t=
hen registered
to receive the data the trigger cannot be changed anyway so that will w=
ork here.

The other bit that makes it complex is the data flow.
This is done in the form of scans of a set of channels. The description=
 of these
are more or less available to the core.  Note the scan you get may well=
 have
more channels in it than you explicitly requested.

These scans are then pushed into one of a set of different buffers.  No=
te
All of the scan is currently pushed.  That makes sense if you only have=
 one
user of the data.  Right now the pushing is done by the individual driv=
ers
but this could pass through the core.

So things that stand in the way of more general use:

1) Userspace controlled triggers (apply to whole ADC) - can lock these =
down if
say a touchscreen driver is using the device.
2) Single output stream of data.
3) Note there is deliberately no metadata in the stream. It is all out =
of band.

Push to one driver is easy.  Anything else needs a demux that is aware =
of the
stream contents.  This bit doesn't exist and looks non trivial.  The re=
al
trick is going to be keeping it light and fast (or entirely out of the
way when not needed.)

At some point I'll have a play with rerouting the data so such a demux
can sit in the current flow (can use it to kill off unwanted channels).

>=20
>> If we sit something underneath the IIO and input drivers (or use the=
 lower
>> portions of IIO to do this) then the intent would be to have a fully=
 generic
>> input touchscreen driver on top.  I'm not sure that's possible.
>=20
> I am not sure it's possible to make the touchscreen driver generic. O=
n
> the G45, the ADC IP has some generic ADC registers, but also some
> touchscreen-specific registers. So the touchscreen driver probably
> cannot be completely generic and some cooperation between the AT91 AD=
C
> driver and the AT91 touchscreen driver might be needed. I'd have to
> look into more details on how the AT91 touchscreen thing works to
> provide some more details here.
>=20
>> For example are the switches on the G45's adc (from datasheet) somet=
hing that
>> all/many similar touch screen controllers have?
>=20
> I have no idea.
>=20
> However, I have also seen a platform (SuperH 2A) where ADC channels a=
re
> used for keypad handling. 4 ADCs channels, each connected to 4 keys,
> each having a different resistor. Depending on the voltage measured a=
t
> the ADC, you're capable of knowing which key of the 4x4 keypad is
> pressed. This is a different situation where the ADC values need to b=
e
> used by another in-kernel driver.
That one is much easier to handle and indeed not that uncommon a hack.
It really is just using the ADCs to get a value.  Hence with suitable
descriptive map it's easy to write a generic driver for it.
Even easier if it's simply polled ;)
>=20
> Regards,
>=20
> Thomas

