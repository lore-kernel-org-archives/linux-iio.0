Return-Path: <SRS0=ji7U=EZ=sirena.org.uk=broonie@kernel.org>
Date: Tue, 30 Jan 2018 15:03:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: STM32_DFSDM_ADC should depend on HAS_DMA
Message-ID: <20180130150337.GC10525@sirena.org.uk>
References: <1517318506-14664-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
In-Reply-To: <1517318506-14664-1-git-send-email-geert@linux-m68k.org>
List-ID: <linux-iio@vger.kernel.org>


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 02:21:46PM +0100, Geert Uytterhoeven wrote:
> If NO_DMA=3Dy:
>=20
>     ERROR: "bad_dma_ops" [drivers/iio/adc/stm32-dfsdm-adc.ko] undefined!
>=20
> Add a dependency on HAS_DMA to fix this.

Once again I have to ask why we're doing this per driver and not having
the few architectures that have this issue set something up.

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpwiUgACgkQJNaLcl1U
h9DLPwf/QzrLNH1BfkugKqyYddmd2cAma8j0yuYG9OOjNzdxsdLrA+MWidgFuExp
L3p5bDY4YPOzWlLyi80+nBp9GX3FdVrtV7YgpTUuUloygNP5AGbbmkaSLPHCbept
7cM7zXoWC1WYqvJMvl5syq4IjWqgbEfvELSybELTQ9ZYuwR2S4bPqZYr9F6GQZZm
AB3n1G9H3ZCGfZzNUwPVe0INQaLY7K+nq+Ic1GSfssocUSzux14dKAlLIkMVEkxO
N2+7Kd4RL79Tj7d+R/zRK/mIFgFwoEExvCLvLrm1hxGsCszzmsxXVpfwfs4jPgUd
7ravvGW9hLNtYrWoFIFWtNOMOPqdZA==
=HoYM
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
