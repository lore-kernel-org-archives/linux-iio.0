Return-Path: <SRS0=Xqrh=2C=goldelico.com=hns@kernel.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_DF78ACF7-0D85-4371-8B6E-2844A89825D8"; protocol="application/pgp-signature"; micalg=pgp-sha256
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <201702202042.15878@pali>
Date: Tue, 21 Feb 2017 08:14:09 +0100
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Sebastian Reichel <sre@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
 Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>,
 Michael Welling <mwelling@ieee.org>,
 =?utf-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Igor Grinberg <grinberg@compulab.co.il>,
 "Andrew F. Davis" <afd@ti.com>,
 Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Alexander Stein <alexander.stein@systec-electronic.com>,
 Eric Engestrom <eric@engestrom.ch>,
 Hans de Goede <hdegoede@redhat.com>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Petr Cvek <petr.cvek@tul.cz>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Nick Dyer <nick@shmanahar.org>,
 Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
 Michel Verlaan <michel.verl@gmail.com>,
 linux-input@vger.kernel.org,
 devicetree <devicetree@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
 linux-iio@vger.kernel.org,
 kernel@pyra-handheld.com,
 Aaro Koskinen <aaro.koskinen@nokia.com>,
 Pavel Machek <pavel@ucw.cz>,
 Andrey Gelman <andrey.gelman@compulab.co.il>,
 Haibo Chen <haibo.chen@freescale.com>
Message-Id: <A41872A2-F095-47F8-B122-FFAE430B0D7F@goldelico.com>
References: <cover.1482936802.git.hns@goldelico.com> <20170220010714.GB8358@dtor-ws> <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com> <201702202042.15878@pali>
To: =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--Apple-Mail=_DF78ACF7-0D85-4371-8B6E-2844A89825D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Pali,

> Am 20.02.2017 um 20:42 schrieb Pali Roh=C3=A1r <pali.rohar@gmail.com>:
>=20
> Hi Nikolaus!
>=20
> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
>> Hi Dmitry,
>>=20
>>> Input driver may set resolution for given axis in units per mm (or
>>> units per radian for rotational axis ABS_RX, ABS_RY, ABS_RZ), and
>>> if you check the binding, you can use "touchscreen-x-mm" and
>>> "touchscreen-y-mm" to specify the size of entire touch surface and
>>> set resolution from it so that userspace can calculate the proper
>>> scaling factor.
>>=20
>> How is this information exposed by the kernel to user-space? By
>> scanning the DT file or tree?
>=20
> Set input_abs_set_res() from kernel.

I can't find this function defined anywhere but used in 101 LOC.
LXR doesn't know it either: =
http://lxr.free-electrons.com/ident?i=3Dinput_abs_set_res

What is going on here?

> And in userspace call EVIOCGABS
> ioctl() on input device. Look at struct input_absinfo, you should have
> all needed information here. This is generic input interface, no DT is
> needed.

Ok, if this is not set by a driver it is indeed a driver bug.

But we have to define it's value in DT because the tsc2007 does not know
anything about the panel dimensions.

IMHO something that should be done by generic of_touchscreen.c

If of_touchscreen would simply pass the touchscreen-size parameters
to input_abs_set_res() and the bindings would define it to be units/mm
it might have saved us all a lot of work and discussion.

>=20
> I hope that XServer is already using it for evdev devices...
>=20
> For whole implementation look at evtest program. That should be good
> starting point for your userspace implementation.
>=20
> While I'm watching this discussion... in my opinion kernel should just
> invert input axes (when needed) and should not do any other
> normalization or integer/floating-point re-calibration/re-calculation.
> If it correctly exports minimum value, maximum value and resolution =
then
> userspace can correctly re-scale input events to units which userspace
> needs (e.g. mapping into LCD screen pixels or whatever is needed).

BR and thanks,
Nikolaus


--Apple-Mail=_DF78ACF7-0D85-4371-8B6E-2844A89825D8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq+jCAAoJEIl79TGLgAm6oLEQAIKq8AY89cWAIJrRNy2H+rqG
SHz5Aw7eYmXDbcVp9wubECAJWdIyoZGzGlHScnmgyK8R4RJXG6wa1UVMR0mAIqk3
zE9cBxnEkEVFyL+d+50Bt5WaolFiyGBJKWn/IeLz1Bxv5gEknqoH5J/A9pjroW0U
JlZi3uHhG1pUioLEs7SfuDrl3rHrXP5GewJhzk3jSoSq0xtBPtr9ArlwVYNVpC03
WAqpFdQdIRd99nEEf2fZ/DMKsXiFELQvf+rbmJcDQmH4WE39Iaq9iwLJLGkjwb+t
v4H5cNKCmKKrKpLjDrYSIrw6M9gApOavICP3kfBKzztALxdFWnp8rY0+89gYumVc
wqYfFJJsf1hAnMeYLln/zxVP3DGk5UQnaOeu10bLB0gHU11nSc+9cH0rAGy1fcq5
OaG9FiaSXg5t9nV8lB8hUpAQnlhEp0GeMsMuaVx2kydjvwUfq62Udr/6RkfT5B10
E5PLCj5dhbtl0HSPnOZ7/OPQcGqSKz/4DWfp+Nxfq8lgTCUuCAELeln5T5JGqbYU
+vL3irsXjUFMKopKosLeqM0FBc4QNvK+TUKdV7heFO6fiADCX/OZMKzxd1K2J9dk
q6tSpGtB+K8HYEIEk9LThTYRgWsRjIzgv8NKGADr+6IU7JMKqE9Z3Rh2oi5Wd2Bt
gyDZ+paoXp37jRla9+1o
=AdSb
-----END PGP SIGNATURE-----

--Apple-Mail=_DF78ACF7-0D85-4371-8B6E-2844A89825D8--
