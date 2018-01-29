Return-Path: <SRS0=uf+1=EY=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 29 Jan 2018 10:49:18 +0100
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
Subject: Re: [PATCH v2 11/16] arm: dts: sunxi-h3-h5: add support for the
 thermal sensor in H3 and H5
Message-ID: <20180129094918.4fvxpmoftgxxkqg3@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-12-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zram63ggkfbahhak"
In-Reply-To: <20180128232919.12639-12-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--zram63ggkfbahhak
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 29, 2018 at 12:29:14AM +0100, Philipp Rossak wrote:
> As we have gained the support for the thermal sensor in H3 and H5,
> we can now add its device nodes to the device tree. The H3 and H5 share
> most of its compatible. The compatible and the thermal sensor cells
> will be added in an additional patch per device.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi=
-h3-h5.dtsi
> index 7a83b15225c7..413c789b588d 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -426,6 +426,15 @@
>  			};
>  		};
> =20
> +		ths: thermal-sensor@1c25000 {
> +			reg =3D <0x01c25000 0x100>;

The size is 0x400

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--zram63ggkfbahhak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu7h0ACgkQ0rTAlCFN
r3T7sQ/+L4rNSNcOG+zXTvgEk2ZTZjst3MhthNWCBtAMwxp474PgJjiDAsbZShg/
6FxW43ytU08kOKu8V5hmuv/7QF9bpfTW8XHpOVIw5Co9GW4bGsfkeGWDQ34rrFn1
sG9jUWNCqqxiTj5UxMjxpmk3YYJvKXXl9GW6CxINAAKcDY05/Oo43+FXaE67P01v
tAeI1k1MMJEJh4zXfp4BMFp1F8GDGbn9LTX18Qh0HaXwntgZXIrD1UqDDVi5wM//
u/QSFjjQuSV0plaYtNN2rblvMgq+62/juCHHf1JiwDQvQIS9TVbq4tlRuVNvJpwb
we+LuwQMNlEsYGu4cugpX3mgkl+9LxYpGeLV7EK/YlyglNcMyR6x/8cuZ6svl0l+
sj4cgwu3eu2oa28y0GTFrvQhvliD3+su8V6emcp9NhZ0OjjBkzz9+xgygM9ojIoX
QJVFFn+KNl2LuwjJL4zVQNGdloTLdHfbxpOQkNJacL74CbJY5mDnjjsQCvumzBnx
7tdIzgpEowXh4Vx0JeY4yAqLMO7Y4YZdcVIRzCoBOvwNw5d4c1xkQrUPvvHjsUVj
GTQq/yparJ44sVpQmK8Y+aUdAmLlqqHZtE1OCF27RZjAjT7uxAYsf+XoJak25Rpa
2cyFo7Qjh1s70YrWy6hScYveFavtNiharshosBWPbwAItwxq1mQ=
=L5Rl
-----END PGP SIGNATURE-----

--zram63ggkfbahhak--
