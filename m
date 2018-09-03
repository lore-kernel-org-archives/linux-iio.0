Return-Path: <SRS0=GuC/=LR=bootlin.com=maxime.ripard@kernel.org>
Date: Mon, 3 Sep 2018 11:44:04 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
	wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	eugen.hristev@microchip.com, rdunlap@infradead.org,
	vilhelm.gray@gmail.com, clabbe.montjoie@gmail.com,
	quentin.schulz@bootlin.com, geert+renesas@glider.be,
	lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de, broonie@kernel.org,
	arnaud.pouliquen@st.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 20/30] iio: adc: sun4i-gpadc-iio: rework: device
 specific suspend & resume
Message-ID: <20180903094404.ih2fsqsetz6oo7ie@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-21-embed3d@gmail.com>
 <20180831090915.agbldint76ngj5jf@flea>
 <ddd06c43-026e-2801-dc36-053d469e43f3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2x2tyzi3ftzmnojb"
In-Reply-To: <ddd06c43-026e-2801-dc36-053d469e43f3@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--2x2tyzi3ftzmnojb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 31, 2018 at 02:05:59PM +0200, Philipp Rossak wrote:
>=20
>=20
> On 31.08.2018 11:09, Maxime Ripard wrote:
> > > +static int sun4i_ths_suspend(struct sun4i_gpadc_iio *info)
> > suspend is already a hook in the kernel, which hasn't the same meaning
> > than runtime_suspend (and the same applies to resume), so we'd rather
> > pick a better name. And all the functions (and the driver) use gpadc,
> > please continue to use that prefix.
>=20
> I agree.
> For the newer sensors (from H3) the Sensor is referenced in the datasheets
> as Thermal Sensor short THS. So I would like to use for the newer sensors
> that prefix. Is that ok?

Not really. The consistency within the driver is more important.

Maxiem

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2x2tyzi3ftzmnojb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluNAmMACgkQ0rTAlCFN
r3RRLA/9EE4CSeZZeZEXf2yhIuVgyf9RPtvrT5mLAH5AtQPbtf1NnGQrnvxv040X
yo7t6CxcybjaSH0HI8X0yDt1gLdXw6EKNEiAnc3HLNNJGMh5YDdo83BuxjSItm0q
wQZfYNJ9BRyeRHzGp8KTgsxtvSOrSj8Jd6UVKSQNlxcctLEcOb/PmUqIgcXLv74p
yTLbjlCwOn8sv+jDed/pkvFgFcMVTB6qfWUs67euMbP3Bx5HUd+p+UjQxs+U8t+N
XO+W5CC6GW21bBvpsCbBjxX4QCFMcCqZTEcAhpSPEODwRklJ8Dfhbp3cRxJkRceX
9uZ5p2HfM3kZVLSDEyThS0amaPpXZJMrYymX8LIu8B6ouWk/oTzL4WmuguOpydFJ
TR239Q0ESp1xxC2DkuM+FiC9xchnLOcVoclKjQpeuUWpK1yd9SBmIvb/SI0448My
+0h1GtavU3qFWAyKW7dm/LA77HTWBWXP/cwOnZPJAkm4t0YfULAu5b7bOsHl0IlP
e4K4aLBXoNTVBGnbJvTpDkvuqCvWR4nyuWxOslmUh+FpTAoQ+xS4TdbTIZOnedXd
P8ibLgPsk+GpQw2I44DL6XwNd9DHNBfW7bJneNy64ruHChClOeNHMMaxphlc1+rm
Tl3A9xivzwLF9h8sPEfNpyykeYQnY1Ad4QbMFKUiy6wyeTL0ha4=
=uLub
-----END PGP SIGNATURE-----

--2x2tyzi3ftzmnojb--
