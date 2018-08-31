Return-Path: <SRS0=ftCP=LO=bootlin.com=maxime.ripard@kernel.org>
Date: Fri, 31 Aug 2018 10:32:31 +0200
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
Subject: Re: [PATCH v3 04/30] iio: adc: Kconfig: Update Kconfig to new build
 options
Message-ID: <20180831083231.gnxoxadfy4fwubyy@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-5-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xj25ukd2kjijrnts"
In-Reply-To: <20180830154518.29507-5-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--xj25ukd2kjijrnts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 30, 2018 at 05:44:52PM +0200, Philipp Rossak wrote:
> Since we are merging the mfd driver into the iio adc driver we need to
> update the Kconfig build options.

Most of your commit logs a pretty short, and this is an issue for
people lacking context. This would be the reviewers, but also users
bisecting to see where there's a bug, or you in a couple of years from
now :)

Every commit log should be as complete as possible. In this case, you
are saying what you are doing, but this is actually redundant with the
patch, I can already tell what you are doing by reading the rest of
the mail. However, what is really important is *why* you are doing it.

> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  drivers/iio/adc/Kconfig | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9da79070357c..5d0cffd6d2e4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -713,13 +713,16 @@ config STX104
>  	  array module parameter.
> =20
>  config SUN4I_GPADC
> -	tristate "Support for the Allwinner SoCs GPADC"
> +	tristate "Allwinner sunxi platforms' GPADC/Thermal driver"

I'm really not sure this is worth updating

> +	select REGMAP_MMIO
> +	select REGMAP_IRQ
>  	depends on IIO
> -	depends on MFD_SUN4I_GPADC || MACH_SUN8I
> -	depends on THERMAL || !THERMAL_OF
> +	depends on ARCH_SUNXI || MACH_SUN8I
> +	depends on THERMAL && THERMAL_OF

For example, why you are changing the thermal dependency is not really
obvious to anyone.

>  	help
>  	  Say yes here to build support for Allwinner (A10, A13 and A31) SoCs
> -	  GPADC. This ADC provides 4 channels which can be used as an ADC or as
> +	  GPADC or newer SOCs (A33, H3, A83T, ...) Thermal sensor driver.
> +	  This ADC provides 4 channels which can be used as an ADC or as

I'm not sure this is worth updating either, especially when there's
information that has been dropped.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xj25ukd2kjijrnts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluI/R4ACgkQ0rTAlCFN
r3S5Yw/9HYy9SqaCvH+n/dLVpZPTUN9pqVrxp+v3v1CG/LHBxTOQvhwwKq9XMr4l
4yFSZ3cBLsNjCVki9NFpfIOzoc4VSuFT0VD/6lRmGe81ujbRk+3pUkRZWszEPQbp
6Xk2qilKDKEMH+e2tx9e8hTW8rTLgfKnMUMsbIECBVUE1EWCf7o6KN+Rndhm5oU1
rRvqQpVXR+IOdYCVOJXGS7s8ppru1ePVEMCxNspXMNkVyiIaNp8cxIL/G1jKn14R
rokw1Np580DTLJMaNdgxOQShaWCnIsPaVGNuNoxt60uGDYpKZUdQowPMy8FUVEel
um6sTAkyKFkwnToPQGTf7kzE0jx3BYrhwafpnplMO1P8UfEn4B1tikc45X2n4WN7
KQkJQQgfjo5H3FRVUtIJGWKKx3+9w8Yh1975xzka9hTgyXiKIzlvZY6hSSCSbIIs
hQ2lANHUEa2grmxuIo4/ut5j/qe+E5ShgcB9UuFpMEvvHKQT8gsoFQKwdadGM7bI
zGE5jwCF9DVD0AJSKWFf1dMJxqX1NZgMIRCg5EPkg0ORgDKT11rCylxg1IhPEofR
TMmBr1exT9h+iZ6UsAx1tCHuRGK6LT0Os5Kt6eYZLt2zV6kEqmfVgkhxbqxn6Y7k
Rl3cV17IilsKqvCBmo8BK3AP+nrnnNpR0sSLbKlGJflra7rBEn0=
=4uei
-----END PGP SIGNATURE-----

--xj25ukd2kjijrnts--
