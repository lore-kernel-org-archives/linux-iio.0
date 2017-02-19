Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45141 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdBSU5M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 15:57:12 -0500
Date: Sun, 19 Feb 2017 21:57:08 +0100
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
Message-ID: <20170219205708.GA9641@amd>
References: <20170218180811.GB9377@amd>
 <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com>
 <20170218225435.GA4693@amd>
 <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
 <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
 <20170219171518.GA12833@amd>
 <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
 <20170219190547.GA17292@amd>
 <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> But as said I don't think we need float or fixed point for practical syst=
ems
> at all.

So you are going to loose precision. And if userspace decides to
calibrate it slightly differently from kernel, lost precision will
matter.

> >>> and floating point in kernel is hard. Also
> >>> you'd either have to invent new interface, or you'd break touchscreen
> >>> for people that already have their touchscreens calibrated.
> >>=20
> >> No, I don't break calibration for people using a different chip.
> >=20
> > So you propose your touchscreen to behave differently from all other
> > touchscreens in tree?
>=20
> No. I only propose that my touch screen behaves properly and in the
> best way it can. If others are worse, they should also be improved at
> some time.

Different from all other drivers. Read: broken.

No. You have to design interface such that they _can_ be improved, and
what you propose does not work that way.=20

> And note that I am not making things different from others in tree, I
> am making the tsc2007 right (incl. following the touchscreen bindings
> which define the touchscreen size in "Pixels").

Your touch screen is not in any way special, so it has to behave in
the same way others do.

> > That's just no-go.
>=20
> In other words: you want to block any improvements unless your favourite
> touchscreen is giving directions...

Yes. I want to prevent you from pushing crap into the kernel.

If you want to improve it in reasonable way, you know what to do.

> >> You seem to repeat yourself and just say which solution you prefer,
> >> but I am missing the arguments why your solution (Pass calibration data
> >> to userland) is right and the best one.
> >> Which problems does it solve?
> >=20
> > All you described.
>=20
> I think you are missing one problem: providing already properly scaled to=
uch
> values to user space.

I'm not. Userspace has to know how to do the calibration _anyway_ (for
other hardware), so giving scaled values to userspace is useless.

> >> How can you implement it in
> >> a stable and portable way?
> >=20
> > Easily.
>=20
> Please go ahead and show code.

You don't get to tell me what to do, unless you pay me.

You want to break kernel, you do coding. Or pay someone else,
preferably someone who knows how to design kernel code.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliqBqQACgkQMOfwapXb+vI3EgCfTXHQiQCyMcxM4jU5YBg6ysum
UmIAoJQdh3wzIYAvltybgJ9v238pFL8C
=haEX
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
