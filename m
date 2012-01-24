Return-Path: <w.sang@pengutronix.de>
Date: Tue, 24 Jan 2012 14:14:27 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Wolfgang Denk <wd@denx.de>,
	Peter Rusko <rusko.peter@prolan.hu>, Stefano Babic <sbabic@denx.de>,
	Sascha Hauer <kernel@pengutronix.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [RFC] IIO LRADC for mach-mxs
Message-ID: <20120124131427.GE2609@pengutronix.de>
References: <201201241408.08083.marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
In-Reply-To: <201201241408.08083.marek.vasut@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2012 at 02:08:07PM +0100, Marek Vasut wrote:
> Hi guys,
>=20
> I've been playing with a custom mxs board recently and I'd like to tinker=
 with=20
> ADC. Well, apparently there was some effort but it died silently.
>=20
> Now, there are two approaches how to go about the MXS IIO LRADC. Firstly =
though,=20
> here are some hw details:
>=20
> 1) The ADC has 16 channels in total, some dedicated to particular function
> 2) The ADC can sample only up to 8 channels at the same time
> 3) The ADC delay triggers can trigger only up to 4 kinds of sampling for =
those=20
> up to 8 selected channel
>=20
> So how should we go about this:
>=20
> A) Implement functions, to configure and select a channel at probe-time a=
nd then=20
> never allow (at runtime) different channel to be selected.
>=20
> + Channel configuration is static, passed via plat_data
> + The channels don't need to be reconfigured =3D> when data are demanded,=
 the=20
> channel doesn't need to be reconfigured (if it's not configured in one of=
 those=20
> 8 options) and the user doesn't need to wait for data.
> - Only 8 channels can be used
>=20
> B) Allow channel to be configured on-demand -- when it's value is request=
ed, it=20
> is configured (if it's not already) for the particular function.
>=20
> + All 16 channels can be used
> - It's clunky and fragile to breakage
> - It's hard to implement good channel replacement algo (replacement as on=
 the=20
> delay triggers and on those 8 slots)
>=20
> Which way do you consider better ?

CCing Jonathan and the iio-list (as found in MAINTAINERS). They probably
have more experience regardings those scenarios?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk8errMACgkQD27XaX1/VRuj5ACgxga8wEf13X5XJFc39u0okn1R
PNAAoL0YwwaMPs/BoqhYh5EzXCbRiSPj
=Itzz
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--
