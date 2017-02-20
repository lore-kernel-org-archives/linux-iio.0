Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36211 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdBTVyj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 16:54:39 -0500
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 22:54:34 +0100
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Mika =?utf-8?q?Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
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
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com, Aaro Koskinen <aaro.koskinen@nokia.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Haibo Chen <haibo.chen@freescale.com>
References: <cover.1482936802.git.hns@goldelico.com> <201702202207.38582@pali> <A77657DA-BFF3-4A4E-9302-047B77072F3A@goldelico.com>
In-Reply-To: <A77657DA-BFF3-4A4E-9302-047B77072F3A@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2736165.6KBpHysfgv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201702202254.35023@pali>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--nextPart2736165.6KBpHysfgv
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 20 February 2017 22:24:31 H. Nikolaus Schaller wrote:
> Hi Pali,
>=20
> > Am 20.02.2017 um 22:07 schrieb Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> >=20
> > On Monday 20 February 2017 21:35:18 H. Nikolaus Schaller wrote:
> >> Hi Pali,
> >>=20
> >>> Am 20.02.2017 um 20:42 schrieb Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> >>>=20
> >>> Hi Nikolaus!
> >>>=20
> >>> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
> >>>> Hi Dmitry,
> >>>>=20
> >>>>> Input driver may set resolution for given axis in units per mm
> >>>>> (or units per radian for rotational axis ABS_RX, ABS_RY,
> >>>>> ABS_RZ), and if you check the binding, you can use
> >>>>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size
> >>>>> of entire touch surface and set resolution from it so that
> >>>>> userspace can calculate the proper scaling factor.
> >>>>=20
> >>>> How is this information exposed by the kernel to user-space? By
> >>>> scanning the DT file or tree?
> >>>=20
> >>> Set input_abs_set_res() from kernel. And in userspace call
> >>> EVIOCGABS ioctl() on input device. Look at struct input_absinfo,
> >>> you should have all needed information here. This is generic
> >>> input interface, no DT is needed.
> >>=20
> >> This assumes that I can and want to write a graphics system
> >> myself.
> >=20
> > Not only. There are already existing graphics systems. And you need
> > to provide needed information from kernel, so they can start using
> > it.
> >=20
> > So input_abs_set_res() is needed to use in your kernel driver.
>=20
> I didn't know about this feature and obviously nobody else has
> implemented it in the tsc2007 driver.

So... before doing other things, can you deeply look at it and check if=20
it really fixes this problem? Because I think that yes.

You can probably set it from DT and in your DT file you can have stored=20
screen size (or resolution factor).

Also for testing, you can set it even via userspace (ioctl which I wrote=20
in previous email).

> >> And if it does, it does it in a
> >> plethora of different implementation states. That is the reason
> >> why we want to solve it once for all userlands in the kernel and
> >> not rely on user-space help.
> >=20
> > For me this looks like "we are going to fix userspace bugs in
> > kernel".
>=20
> Such things are system bugs and it is neither necessarily a userspace
> or kernel bug.

In case kernel defines stable API/ABI and correctly provides information=20
via that API/ABI and application does not work correctly, then I would=20
say it is bug in application. Not in kernel.

We can say that some kernel API/ABI is wrong too. And in this case it=20
could be bug in kernel.

So is current stable kernel API/ABI for input device wrong? I do not=20
thing. But if you think that yes, please show us what exactly and we can=20
start discussing how to fix such problem which you see/have. I know that=20
no application is without bugs, but in my opinion problem which you are=20
describing is already solved and defined by current stable kernel ABI.

> > Really! Not a good idea. Plus I still see this as abusing kernel
> > API/ABI as resolution should be handled differently as you are
> > proposing.
>=20
> I don't understand what you say here. Where are we abusing kernel
> API/ABI?

I mean that we already have stable API/ABI how to export size of input=20
screen from kernel to userspace. And you want to rescale event data=20
directly in kernel to workaround problem of screen size. So I think this=20
is abusing API/ABI as kernel already have API for it.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2736165.6KBpHysfgv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlirZZsACgkQi/DJPQPkQ1IpMQCfdVs5iJfWQav82K8wnTY35C2q
ct0AoLcYkf/AJq3lru72Ona+4FSSM/M5
=ZX2/
-----END PGP SIGNATURE-----

--nextPart2736165.6KBpHysfgv--
