Return-Path: <SRS0=uf+1=EY=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 29 Jan 2018 10:52:00 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
	wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
	rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
	krzk@kernel.org, quentin.schulz@free-electrons.com, icenowy@aosc.io,
	edu.molinas@gmail.com, singhalsimran0@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 14/16] arm: dts: sun8i: h3: enable H3 sid controller
Message-ID: <20180129095200.attg7cgvpifpchtn@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-15-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ovx36qt4j4w4tgjg"
In-Reply-To: <20180128232919.12639-15-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--ovx36qt4j4w4tgjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 12:29:17AM +0100, Philipp Rossak wrote:
> This patch enables the the sid controller in the H3. It can be used
> for thermal calibration data.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3=
=2Edtsi
> index 3f83f6a27c74..9bb5cc29fec5 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -72,6 +72,13 @@
>  		};
>  	};
> =20
> +	soc {
> +		sid: eeprom@1c14000 {
> +			compatible =3D "allwinner,sun8i-h3-sid";
> +			reg =3D <0x01c14000 0x400>;
> +		};
> +	};
> +

Shouldn't you also use a nvmem-cells property to the THS node?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ovx36qt4j4w4tgjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu7r8ACgkQ0rTAlCFN
r3SjJRAAiAEG6K564RvsKoNGwjmUtq0adntB7Hts0ZNFviZToMty0lbNgQUU7FzN
fmm2r9F0A5tSfKX5eEf+x9FLzEMSFO2HhsinTFgTyERaQA1SpL9m640Em12u76T+
0L0ga2BYAnd+XE7ZSImakgnTOaGnpvm2UHVodHvLeVU9+PqQFu7eqaHnBEsEcMQ/
YzgOmnsqdfC6/Gno8xFiz5Sl7B2nO+PTB/WyfAStXrmtvD7m2NrXs2vYmS1MyB0T
+XE0IUcNAePNELnm8xokxYQDQeik5gQVPPPmPwSgx+mdnhHUqw4T3BrEApC3DpPo
1tMYKSIybTNsuhoKUHeVgxGaOsh//oji3QXTeyvJZlSy3/700uoOhS5qo0IsSXDJ
OZZSg1QFakyAL+WJgJ58SiKbdSh70Zp9UgtIVMLWCkSulkCShp21V0DxLvieTqev
rtIBHbZC2vGRIABUvouycPQG0i9DEexhlUe0FgCinsAOopN08vlItbnm0GA5f4aa
7WAdBRCfJKTrWoe2P7DUuB7lhjgkRaLgTlry5ZdbGpK/IwrU0L6iZSDARAzqsi3C
OK17oTYfv5bmtpJx2sl6DbE/hOJyGGOSdwWXnv2j0pahAl0yYOFI/xg4rQmYhFAs
r6Vu37u/ezcnrTlzgo84tONcdoqDsMrn0jalTNEuQaX35Qfglds=
=IS9d
-----END PGP SIGNATURE-----

--ovx36qt4j4w4tgjg--
