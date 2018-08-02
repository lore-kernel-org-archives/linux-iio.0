Return-Path: <SRS0=Mhmi=KR=sirena.org.uk=broonie@kernel.org>
Date: Thu, 2 Aug 2018 11:14:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH v2 3/6] regmap: Add regmap_pipe_read API
Message-ID: <20180802101437.GE9117@sirena.org.uk>
References: <1533136667-31828-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
In-Reply-To: <1533136667-31828-1-git-send-email-stefan.popa@analog.com>
List-ID: <linux-iio@vger.kernel.org>


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 06:17:47PM +0300, Stefan Popa wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>=20
> The regmap API usually assumes that bulk read operations will read a
> range of registers but some I2C/SPI devices have certain registers for
> which a such a read operation will return data from an internal FIFO
> instead. Add an explicit API to support bulk read with pipe rather than
> range semantics.

If we're going to do this it's probably best to explicitly mark the
registers where it will work otherwise we'll end up confusing ourselves
and corrupting data at some point, provide another op like readable and
so on. =20

I'd also suggest calling it something like _noinc (for non-incrementing)
instead of _pipe as I was a bit confused about what a pipe read was.  We
could also have a software implementation for things like ADC outputs
where the register doesn't have the convenient nonincrementing behaviour
but we want to do repeated reads.

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlti2YwACgkQJNaLcl1U
h9AviQf/U61lFuMPKacSSxRzqCrcwQ/U8WiIbPEeHuDyeCcg5sG4CH5Srh7ibDNU
o325C83BXWWHmt77KuiDZp+vnooX7SOauLlVjS6YgZ8CoQ/jeeDJuI8a+LGMW8Y2
Hary1PbC4Br4ETuRxBUbVg0ZL4gZ0FYzmephHSdE+KTBYnawl7vexSenN+NPc+iz
Fn3bRc9oMHm6vYTjDiUG0o1z6ymxaaWdAdOOpEuXp6LpBrPtPWPIs3Dijy2yLUDk
/RO/JgrNhcha8pqWhmO1wT50Z67ofhKyNA3cZminOlnEmq8Tpuv2YufB/mI0C6WC
7HuGQebfxWQRxJkjB/5pXRl8WmyuVA==
=mnD0
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
