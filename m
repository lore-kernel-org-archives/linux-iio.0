Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.andi.de1.cc ([85.214.239.24]:51688 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbdBURKO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2017 12:10:14 -0500
Date: Tue, 21 Feb 2017 18:07:55 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Michel Verlaan <michel.verl@gmail.com>,
        Nick Dyer <nick@shmanahar.org>,
        Tony Lindgren <tony@atomide.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Engestrom <eric@engestrom.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mika =?UTF-8?B?UGVudHRpbMOk?= <mika.penttila@nextfour.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Petr Cvek <petr.cvek@tul.cz>,
        Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>,
        Haibo Chen <haibo.chen@freescale.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
        kernel@pyra-handheld.com, Michael Welling <mwelling@ieee.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
Message-ID: <20170221180755.48946fc5@aktux>
In-Reply-To: <20170221090940.GD9795@pali>
References: <cover.1482936802.git.hns@goldelico.com>
        <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
        <201702202042.15878@pali>
        <201702202208.50498@pali>
        <C2E7AC24-75AB-442F-94A2-84904723EE41@goldelico.com>
        <CAKdAkRRZa-fpv_TKRdY=hFV3GdKxQ3muQORquvV_bTrDzQAhCw@mail.gmail.com>
        <0A33CCEA-448C-4C1D-9563-FDA54743BD01@goldelico.com>
        <20170221090940.GD9795@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QBvnUSHLCRUNlOXqJdFJkXU"; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--Sig_/QBvnUSHLCRUNlOXqJdFJkXU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

[...]
> > Hm. Why not touching pixel (0,0) on the touch is always pixel (0,0)
> > on the screen and touching pixel (639,479) is always (639,479)?
>=20
> Important is that there is no 1:1 mapping between input evdev device
> and drm/fb output device. These are two independent devices. There is
> no connection between screen and touch. So such presumption should
> not be done in kernel. You can do that in userspace.
>=20
But at least it can be told to userspace that these two devices are
connected. That information should be specified in devicetree because
it is not auto-detectable.

> Lets take e.g. touchpad. It acts similarly as touchscreen input device
> (both reports absolute positioned touch events), but touchpad is not
> connected with screen. And from kernel point of view these devices are
> both input and absolute positioned.
>=20
> It looks like the whole problem is there that you wanted to do this
> mapping for your hardware in kernel. And this is not what is kernel
> doing or should do. Moreover I know people who are using integrated
> touchscreen on laptop as (touch) input device for external monitor.
> And in this configuration it does not make any sense to map
> touchscreen input to pixels of integrated LCD touchscreen (as
> external monitor could have different resolution as integrated LCD
> touchcreen).
>  =20
Interesting example. But then you also do not need flipping/rotation
because the angle between your screen and your absolute position device
is not fixed.

Regards,
Andreas

>

--Sig_/QBvnUSHLCRUNlOXqJdFJkXU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJYrHQKAAoJEInxNTv1CwY0vlUP9ArqFcdZQ5ZzJURV5SSdM0j3
c13vY/QJvdBZKmMSKlWaL2ino87ITpbemmrFzknLL5o2FEDBa2jcylOesVyTTZwy
AoFgU6mg+oxjB2xzjgoqFmvlAFxnVdhUlepkPyvZoqyWUnVAY26VGWwq5Hy5pwZG
SS8O05ZTztKMc3PS+teXM3q82lpxMDxoxXH/f1faQpo1f5o90MDj4hiDO68gS9fW
15usLoj+cdoBGxKwCsAc5EJ7HcavBhUW3uodwASZG0CwZtvEpPCkfpCcZgqrJel1
xc96A2Yh75HnBs4z4S5UGVDHbzUBPq94VGKAd9MzFC43T19vXz3kHEseLmYZDgmZ
PexyDxoaVOswMH3tthDnchTOCdKTY0MqmR+xvuycp6njkckU+coyH9UJfN9B9QgT
0a2xSzUmOjRikr4B7dpgFqOSl2cS3KCqG4SGpUUajtyty8b/rwF7oU300tfTPZwU
BqOKgdBPitKhZfVq/WWlnDCtmcJifiHtU0N8krn+ZW08gSOzNdUpvOzq/MosXRTV
xSLkiA+WagMFeAWeu4nzZ4WojeovydME1RLVAYFz7Ayru3oVr4MFbbS7zEK8TiEt
Pamdxz/0mBVXWOMhFXHC5ym66w7BUgHwemvb4L5DntL+JvPhoRUOD22q0HtSR0aG
2gbFTegr0KpYYExRCf0=
=osTl
-----END PGP SIGNATURE-----

--Sig_/QBvnUSHLCRUNlOXqJdFJkXU--
