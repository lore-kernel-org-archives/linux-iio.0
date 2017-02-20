Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45873 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751889AbdBTT3k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Feb 2017 14:29:40 -0500
Date: Mon, 20 Feb 2017 20:29:33 +0100
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
        linux-input@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, linux-iio@vger.kernel.org,
        kernel@pyra-handheld.com, Aaro Koskinen <aaro.koskinen@nokia.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Andrey Gelman <andrey.gelman@compulab.co.il>,
        Haibo Chen <haibo.chen@freescale.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Message-ID: <20170220192933.GA23745@amd>
References: <20170219141715.GA7159@amd>
 <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
 <20170219171518.GA12833@amd>
 <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
 <20170219190547.GA17292@amd>
 <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
 <20170219205708.GA9641@amd>
 <6DF7B03A-8B63-422C-9561-69A34A7FBF35@goldelico.com>
 <20170219221930.GA1568@amd>
 <6610D852-4717-47A7-BFDE-52C8E9E614BB@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
In-Reply-To: <6610D852-4717-47A7-BFDE-52C8E9E614BB@goldelico.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As long as it is small (I expect <1.01 =3D 1% error in scale) it is
> barely noticeable.
>=20
> Therefore, I asked before: how big in pixels is your finger or stylus?
> Does this effect matter?

If I draw a line in gimp, I don't expect it to have steps because of
"barely noticeable" errors.

> A resistive touch is a man-machine-interface where people press buttons o=
f at
> least 12x12 pixels size (or they are no longer visually recognizable).

Resistive touch is used for drawing, too.
=20
> So the discussion boils down to "what gives the better usability?":
> a) getting rid of the nasty user-space calibration step (and plethora of =
different tools)
> b) getting highest theoretical precision which has a low practical releva=
nce
>=20
> I am in favor of a). Like most users we ask. A minority is in favor of b).
> Since we don't exclude b) users from reconfiguring their system to get it=
 done
> as they like. I think this is the best we can achieve.

Do you even read what I wrote?

Because I presented way to have both a) _and_ b).

> >>> No. You have to design interface such that they _can_ be improved, and
> >>> what you propose does not work that way.
> >>=20
> >> It works. Please do real world tests...
> >=20
> > You do a real world test on N900, and propose upgrade path.
>=20
> I have no N900 running. But since it uses a tsc2004/5 controller which se=
ems
> to be quite similar, you can likely copy&paste some code or add the algor=
ithm:
>=20
> ABS_X =3D (touchscreen-size-x * (adc_x - adc_min_x)) / (adc_max_x - adc_m=
in_x)
>=20
> Thats it.
>=20
> If you set touchscreen-size-x =3D (adc_max_x - adc_min_x) you get maximum=
 precision
> you can achieve with integer arithmetic. And if you set adc_min_x =3D 0 y=
our
> user-space gets what it would have got before adding such a formula and t=
hen you
> can and must do calibration there.
>=20
> Taking this as the defaults if none of the new properties is specified, m=
akes
> the scaling feature completely disappear. And I don't care about 2 additi=
onal
> subtractions, one multiplication and one division per axis.
>=20
> So the upgrade path is:
> 1. introduce new optional properties, parse and store them in the struct
> 2. set defaults for the optional properties as described above
> 3. add the formula to the code (1 line for each axis)
> 4. deploy - nobody will notice

Good so far.

> 5. update the DT and remove user-space calibration - people will be happy
>    that they do not have to calibrate first any more

You can't do this. And this is fatal problem with your proposal.

If I update the DT in the kernel, my users will be very unhappy,
because their screens will now be miscalibrated. New kernel must not
force users to update their userland at the same time.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlirQ50ACgkQMOfwapXb+vIxkgCbBxSCXYcHQU2dmf+rOXH1IXtb
qSEAn1/Mx6g3aCnFQoiupB5xJ/yrCLxP
=uePT
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
