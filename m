Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36632 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbdBULHh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Feb 2017 06:07:37 -0500
Date: Tue, 21 Feb 2017 12:07:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Welling <mwelling@ieee.org>,
        Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
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
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Haibo Chen <haibo.chen@freescale.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Message-ID: <20170221110734.GG5021@amd>
References: <cover.1482936802.git.hns@goldelico.com>
 <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
 <20170128193342.GB38136@dtor-ws>
 <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
 <20170217204041.GE13050@dtor-ws>
 <558407EE-4884-4CC3-9098-79DC4B222868@goldelico.com>
 <20170220010714.GB8358@dtor-ws>
 <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
In-Reply-To: <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > They are "pixels" or the touch controller, i.e. native unites in which
> > device reports coordinates, as opposed to points per inch, or
> > millimeters, or whatever. These "pixels" do not have to have 1:1
> > relation to the LCD pixels; in fact they rarely do.
>=20
> I wouldn't call this "pixels". Rather "ADC steps" or something.

Submit a patch.

> > Why? Nothing stops you from querying the device and figure out scaling.
>=20
> What stops me is that I have no (and do not want to have) that level of c=
ontrol over
> user-space code.

Umm. Then perhaps you should not be submitting kernel patches.

> > And still, according to DT folks, device tree forms an ABI and thus we
> > are not to change it, even if it is easy.
>=20
> I think this needs a more differentiated view.
>=20
> In my view the names of the binding properties and what they influence fo=
rm indeed
> an ABI. It should be stable and interpreted in the same way.
>=20
> But it allows to load different firmware for different requirements. Like=
 the user
> application ABI is stable but you can still load different software.

No. You can't expect people to konfigure kernel by modifying dts.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlisH3YACgkQMOfwapXb+vIflACfaCUEkSACXYmas7YaWcAwaQfo
cQUAnRDU2/2iFdZbvX6NjlXHTp9id+2G
=78Vh
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--
