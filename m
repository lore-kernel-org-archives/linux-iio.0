Return-Path: <SRS0=ftCP=LO=bootlin.com=maxime.ripard@kernel.org>
Date: Fri, 31 Aug 2018 10:34:00 +0200
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
Subject: Re: [PATCH v3 07/30] iio: adc: remove mfd_probe & sunwi_irq_init
 function
Message-ID: <20180831083400.fobo2c7w22fspyf4@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-8-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zsi43eonrbj3zyck"
In-Reply-To: <20180830154518.29507-8-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--zsi43eonrbj3zyck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:44:55PM +0200, Philipp Rossak wrote:
> In the previous commit we removed the function call, now we remove the
> unused functions.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

This will create a warning between the two commits, it should be
merged in the previous patch.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zsi43eonrbj3zyck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI/XcACgkQ0rTAlCFN
r3SVPg//a3pD3PkwWY8TWNBuE+7EddA092ScP5tA6YB1S+22IeoSs+WEHzMqkwzG
zdykFyZ8mWg6fwfhAg+AEbidSmpdTLtEqJwP4vFu9ZjYoZeaqThrpthUwYqKgOZm
buQswAshejCr06GqzCtnidALZD/Tc+u2MbP5+/3wgtlCkcMCyqQj4VJK0jWGkvTe
xI0EdBTCFN0tSHKDxit3EKz/iw9Ixd3eAy7EJBxm8wCFPPWop+4/ivFGbtmU9Umj
KE8sABW25KErtTi9gYI+YjR8JMQIb6/iApnEUl/ZMm4uwxhzoku/1c0TjIy5hDPV
ft3iTjaEjTfA9DCSVewJFM2PwhsICfZxf7hVo8wChod0QIY8RnAVvz+etjaMTJol
GtaREnREOecbkM23pUrVpHMVu4YXVbdkOAQj62YgCl6YqEH4gJyilt6XJ0jGJ0/d
8970rtfWpfEzqdqLQUFbGzFnW8Lpg+iSmiZCXSIChZ1wy590aKrs64EJMKTJ1Vxk
rohBRXenkDumCxDWP8CH1VpE+wskudfVFclU8xPHiv8QmvtEWxHa6CBPuypxyp2N
HamB0eNXq5lDGL03JUQiOu7fJp7KMWDN9Plo3QaI2kw9g3b8GrN/TRYfKkYdmKvg
ATp0ZE7xLcWyZC2Ahu+HgGAPPvS+6VO+nxc55HbIdbs+38aa/Tw=
=cFLB
-----END PGP SIGNATURE-----

--zsi43eonrbj3zyck--
