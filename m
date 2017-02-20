Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35400 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdBTWE1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 17:04:27 -0500
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 23:04:22 +0100
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
References: <cover.1482936802.git.hns@goldelico.com> <201702202208.50498@pali> <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com>
In-Reply-To: <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2309403.p6LOXCOcbl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201702202304.22964@pali>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--nextPart2309403.p6LOXCOcbl
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 20 February 2017 22:27:39 H. Nikolaus Schaller wrote:
> > Am 20.02.2017 um 22:08 schrieb Pali Roh=C3=A1r <pali.rohar@gmail.com>:
> >=20
> > On Monday 20 February 2017 20:42:15 Pali Roh=C3=A1r wrote:
> >> While I'm watching this discussion... in my opinion kernel should
> >> just invert input axes (when needed)
>=20
> It is questionable why it should do that at all then.
>=20
> User-Space can also easily do it. Either the driver should provide
> raw data only or if it does pre-processing (scaling by +/-1), why
> exclude pre-scaling by other factors?

Via resolution property which is in that EVIOCSABS ioctl() you specify=20
value which represent unit per mm. So you cannot do full rescaling like=20
via affine transformation. Specially you cannot swap axes or invert it.

As such thing is not supported by current kernel <--> userspace API it=20
needs to be done in kernel.

Moreover I see that this is already handled by kernel's of_touchscreen.c=20
code via DT properties: touchscreen-inverted-* touchscreen-swapped-x-y

And... I'm not sure but I think that linux exports absolute input=20
devices with coordinates where point (0,0) is mapped as left upper=20
corner.

> >> and should not do any other
> >> normalization or integer/floating-point
> >> re-calibration/re-calculation. If it correctly exports minimum
> >> value, maximum value and resolution then userspace can correctly
> >> re-scale input events to units which userspace needs (e.g. mapping
> >> into LCD screen pixels or whatever is needed).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2309403.p6LOXCOcbl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlirZ+YACgkQi/DJPQPkQ1Ks2wCgxNMQtw57fTzl/ditMLd0ST0B
r6sAoMJHlrsFqC28oYWnq42ZfV/sJs4K
=dTsW
-----END PGP SIGNATURE-----

--nextPart2309403.p6LOXCOcbl--
