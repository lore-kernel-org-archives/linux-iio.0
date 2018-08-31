Return-Path: <SRS0=ftCP=LO=bootlin.com=maxime.ripard@kernel.org>
Date: Fri, 31 Aug 2018 10:35:29 +0200
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
Subject: Re: [PATCH v3 09/30] iio: adc: Threat A33 as thermal sensor and
 remove non thermal sun4i channel
Message-ID: <20180831083529.tdbgwlkchrr3j6py@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-10-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ccfulje7flqq36pl"
In-Reply-To: <20180830154518.29507-10-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--ccfulje7flqq36pl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:44:57PM +0200, Philipp Rossak wrote:
> We want to use this driver mostly as thermal sensor, that still supports
> the adc for the older chips, thus we threat the A33 as thermal sensor.
> We also remove the adc channel without thermal support.

The A33 can definitely be used as an ADC, so we need to keep that support.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ccfulje7flqq36pl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI/dAACgkQ0rTAlCFN
r3Skwg//ag+xkjfZMsrApqvaDw7n1fwYHuyQ3QIu4chiRSwKe1Apw7q9CUQuQZJA
wPhYflvZYEOeciaPiBEaEqVb/LCoDEuBYT3DQQ8d8djRtviwGWFFt0NoAlc7g5UH
dj6m8WL1J5vQ6wU3VBkvydigpPM6fPeH4AAEEpSOaZISjSTEeizq3WnEWYyXZrj5
sDMPPEhHTINAg6oz7NkUc5TF23vEW8oGtAHYMTZ5GhUijYtQHdrJqPG8MExOYcmz
Ef9P4AnuNzumanwJRWjHtixMY2BHbfJevbeXhuI2g7r96/2J7VXGsLalhBiDjtUY
+sdT0HtggohvFfIFWtm0WMt9dDF1s/fQO9qY8FMf8GhYvLsF1z/Dp+YwLUe9d5gY
AA6j3wPnXZH5D+AzRknv0CRoNCgwRk202uSecjejeD465iuT4QVZKfPgWCTIt9tm
o4kRvQCOfaZhuhGntgp3RiUsr2/DRbxmU8eJpkGBiNRzqbKwD/3EpcpQUFRjdiQs
0pqR2WWLC4G/+DGrmZBoTFD9JFROwK577nmYD1v7/6furUD+6fU1m77Q19W1mH7y
LuyG03DYTnjvmCZEgw5G8cXdGy9aXsBay1pSWrQISHztBXgTWGUKsAfRTluxqh0E
CwdzMtEctoAyeFVfrbohszJGDxF9a2JrvCu0aS5/uo6suzyPDYQ=
=wCS4
-----END PGP SIGNATURE-----

--ccfulje7flqq36pl--
