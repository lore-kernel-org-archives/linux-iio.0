Return-Path: <SRS0=Hs7h=EN=ucw.cz=pavel@kernel.org>
Date: Thu, 18 Jan 2018 23:40:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFP] iio: Support of gesture sensor as a standard IIO sensor
Message-ID: <20180118224026.GE17196@amd>
References: <1515197240.26317.65.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
In-Reply-To: <1515197240.26317.65.camel@intel.com>
List-ID: <linux-iio@vger.kernel.org>


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From an IIO sensor point of view A Gesture sensor:
> Outputs
> 	A pre defined activity type
> 		WAKE
> 		TILT
> 		GLANCE
> 		PICK_UP
> 		=A0&
> 		=A0more
>=20
> 	A user defined activity type as "string"

Pre-defined activities are easy.

But what about user-defined activities? We'd really like common
interface across different hardware...=20

> Inputs
> 	A raw binary cdev interface to download templates/patterns

=2E...and "raw binary" will not work across different hardware :-(.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlphIloACgkQMOfwapXb+vISjgCeMpuWTiIJ1DnhQ1jlOBc5YJsy
IJ8AoLkEFFsIssbASQUVgJQ1hr/c745H
=Cmp7
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
