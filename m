Return-Path: <SRS0=Psgw=X4=free-electrons.com=maxime.ripard@kernel.org>
Date: Tue, 13 Dec 2016 16:41:37 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: linux@armlinux.org.uk, wens@csie.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, antoine.tenart@free-electrons.com,
	thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH v9 2/3] mfd: Kconfig: MFD_SUN4I_GPADC depends on
 !TOUCHSCREN_SUN4I_GPADC
Message-ID: <20161213154137.spsu3rnmy3xi3toq@lukather>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
 <20161213143332.24988-3-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ptembrjezy2nfome"
In-Reply-To: <20161213143332.24988-3-quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>


--ptembrjezy2nfome
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 03:33:31PM +0100, Quentin Schulz wrote:
> MFD_SUN4I_GPADC and TOUCHSCREEN_SUN4I are incompatible (both are drivers
> for Allwinner SoCs' ADC). This makes sure TOUCHSCREEN_SUN4I isn't
> enabled while MFD_SUN4I_GPADC is enabled.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ptembrjezy2nfome
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYUBaxAAoJEBx+YmzsjxAgCDIP/3sfUN8LDbNxK/fcoUqXCcoy
tPQCPnWmg5hmPrNOcFpRpr7Rsr9UW/fsp6MV0wOiv4Gahb+s+GjBmgUEWPruGRrD
OUiwcKtZANvxUu7irpeja2DttmVagxA2sBMwck7/pOJynAUf6nCp4r81fp9DFX5w
IyP5+f0Oo2Heb+bksGg8TD4ZO+62s1aY4VWQyBPWSHmm1nlSZvUqOmzM3JbW3+rI
WGrIT0UHLQ0shgKNKB17fe2OzQ/xbEVZqeqxAiczAJMub+Ir+YruUwA6mLLEsVB4
Ym7p6KQDtSVpYnpY/hYJiAvOocQGTyrIcXQRwnLOBeUUl7Hl+Fu+1HSB3qN91z/N
8ZlCreHzhWmvoCK1INGGJOwfINskFSr7B+YVUznuwnA1nBZ8p5voBJoo2UnYQYnp
njxknQHhZq6bxXB+d9Nt6NuVQtlfy/5VoICtB9Z6a9XidgMhBfUcRy1am5+TPs+J
hYPlpLTkYnGyC/Z2eIjuO0V+9eUhPY/tP7SMmS+M3IFpJtoD85O/JiXgjGvv2HUV
XGhuY0Fmq97aso1l9zeeEm7gy9OPf/eZj7SKRoupJDbbosqkb/lCx4AhdvAWUMz/
t2Yk3IbCtvwqAF1IYHn7xnGRNmnIO2wbq+LOt3AvWdXZzO3OICQ4Qpo5/oLz10w2
y/yaf1ZIEbxqCUl+jpTB
=QvVe
-----END PGP SIGNATURE-----

--ptembrjezy2nfome--
