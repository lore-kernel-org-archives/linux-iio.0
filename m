Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34828 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbdBTVIz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 16:08:55 -0500
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 22:08:50 +0100
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
References: <cover.1482936802.git.hns@goldelico.com> <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com> <201702202042.15878@pali>
In-Reply-To: <201702202042.15878@pali>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1744452.UVGmpsnQfS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201702202208.50498@pali>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--nextPart1744452.UVGmpsnQfS
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 20 February 2017 20:42:15 Pali Roh=C3=A1r wrote:
> Hi Nikolaus!
>=20
> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
> > Hi Dmitry,
> >=20
> > > Input driver may set resolution for given axis in units per mm
> > > (or units per radian for rotational axis ABS_RX, ABS_RY,
> > > ABS_RZ), and if you check the binding, you can use
> > > "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size of
> > > entire touch surface and set resolution from it so that
> > > userspace can calculate the proper scaling factor.
> >=20
> > How is this information exposed by the kernel to user-space? By
> > scanning the DT file or tree?
>=20
> Set input_abs_set_res() from kernel. And in userspace call EVIOCGABS
> ioctl() on input device. Look at struct input_absinfo, you should
> have all needed information here. This is generic input interface,
> no DT is needed.

Looking at kernel code... via EVIOCSABS ioctl() you can even set=20
resolution from userspace for specified input device.

So this could be potentially used for calibrating input device from=20
userspace? (In case DT data will not fully match current HW)

> I hope that XServer is already using it for evdev devices...
>=20
> For whole implementation look at evtest program. That should be good
> starting point for your userspace implementation.
>=20
> While I'm watching this discussion... in my opinion kernel should
> just invert input axes (when needed) and should not do any other
> normalization or integer/floating-point
> re-calibration/re-calculation. If it correctly exports minimum
> value, maximum value and resolution then userspace can correctly
> re-scale input events to units which userspace needs (e.g. mapping
> into LCD screen pixels or whatever is needed).

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1744452.UVGmpsnQfS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlirWuIACgkQi/DJPQPkQ1LF6ACbBrF6PHJA3rBGfSzDBZ7i0gYp
ugYAn16sy9AkgXOzJBfvTjJGEI0Q6AUc
=dm6m
-----END PGP SIGNATURE-----

--nextPart1744452.UVGmpsnQfS--
