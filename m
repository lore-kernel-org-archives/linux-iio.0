Return-Path: <SRS0=ftCP=LO=bootlin.com=maxime.ripard@kernel.org>
Date: Fri, 31 Aug 2018 10:34:36 +0200
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
Subject: Re: [PATCH v3 08/30] iio: adc: remove hwmon structure
Message-ID: <20180831083436.prcidrdli7gdtb45@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-9-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hrgudpzhyfwmlswe"
In-Reply-To: <20180830154518.29507-9-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--hrgudpzhyfwmlswe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:44:56PM +0200, Philipp Rossak wrote:
> We remove the hwmon structure that was requiered for the mfd driver.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

Same thing here, you should merge that in the commit that removes the
probe_mfd call.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hrgudpzhyfwmlswe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI/ZsACgkQ0rTAlCFN
r3S6fA//WRoHHbAOcFw/N4sr4iBf4kynFp2QolCL56V3J03Q+OLkTw0ZPBhkbJDq
7Hk6BtuykSHc+YGcYKO38TuqGYarWj4EuhN1H8sae0LdeUsg7OG8nsKfhy5LCzTA
kDm66DCq0WhZNM9SEd3/FRXmskVjzvZ9M62GNJyYKkOVsggeh8SCps7K34abvnTp
SEnU73uDS0x/nIlqh/JM8RfLftvBHTax2Fo88XPlRzSIk963tMfI8lnIrZZDl4Tw
mQKY8dNHJ6WFVytQ+7FgbUQy3hhkixMMLa/mv8mZpNK86bnJZkF6H2QtcvPx8dhj
Im1obmLnvrWcP0rDYjdTsj1e6JAVQxbj8TEUrZpcxdDF+y1IFdU5rhlv9ZxPwevi
EQrIzZZMilRDrwf3H7OI5jGaJpm2lOZUXjV6+qPn1Ksu5F7ZaNActbfxqB5HM+aN
UL8+0baBPZJT1C/6eezfaBedtpGwNouiiC4KcG23a7TT2/4MbDBSFs09Xjdd6EYB
+V3AadheHMbo8bLRBvxMfsnXp7zAqjA8XAKuFTkMEqTNTJA9pKEcA3c0uZflnMsr
OpOYC2W8IP6ZC4RdRbtiIvLHpYT4qpTbh5W0pZKRiNIkI+gr7Se5EuaZGCs3UoC+
L8MeeV/FLUrh1KgWXVE4wUgn7dsB/KAUYfsEpPmRj/vQa9xD5yA=
=ty7p
-----END PGP SIGNATURE-----

--hrgudpzhyfwmlswe--
