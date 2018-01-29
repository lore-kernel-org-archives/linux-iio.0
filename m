Return-Path: <SRS0=uf+1=EY=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 29 Jan 2018 10:50:34 +0100
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
Subject: Re: [PATCH v2 13/16] arm: dts: sun8i: h3: add thermal zone to H3
Message-ID: <20180129095034.5crx7ydq5k6f7omv@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-14-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lg27farh6a5fhzif"
In-Reply-To: <20180128232919.12639-14-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--lg27farh6a5fhzif
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 12:29:16AM +0100, Philipp Rossak wrote:
> This patch adds the thermal zones to the H3. We have only one sensor and
> that is placed in the cpu.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3=
=2Edtsi
> index fbb007e5798e..3f83f6a27c74 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -72,6 +72,15 @@
>  		};
>  	};
> =20
> +	thermal-zones {
> +		cpu-thermal {
> +			/* milliseconds */
> +			polling-delay-passive =3D <250>;
> +			polling-delay =3D <1000>;
> +			thermal-sensors =3D <&ths 0>;

if the thermal-sensor-cells value is indeed 0, the phandle parsing
will be broken here.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--lg27farh6a5fhzif
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu7mkACgkQ0rTAlCFN
r3QDZA/8CrtqR44aBfoKWeYehohaL9qAUcVRBLM1jGC618gOFGdy6jXjCGo5hZj+
8O3Jx+X3JwSIAciVG2eM8Z5/iWv9NctjUAcU61iSezb2E30PG72Fesd6xqwNjxoR
0bqs/kvVD/VIaTCVftrb2hDYSNWtLTati4ErWPmwi+RYPKiqsNvtWIHckdMxfM7z
iKYVP/ok2G5k7jMe/97yYK0MkZJEXeQLf0ElzRdBTeCaMWlhWXHAN9kt690o1yek
UT4C4XpuTzMKeuZFXSsTbK+ezfsu7Rb/yKncxaS057dv5GWgq4Ni1noAJvdED6Gd
V7J8jqhWUsutAWUXHiZGG9urB1JsF8GHu8fINhgQQBUVeVbOthJxkclzjLZufs1U
SOHkWt+/E8ywSMq7uHdxiicSslBWRXzvD8CAd2z5WSRJ1V5YYoDo83sh97ywm6/y
k6P52VQiN/KpchmwXpwfSbOz+YY2vMhfDGCazrYGkOcNpn+0WvMBerbqAGujWh5P
xVuIiTHIuXaUs1xz4sFr8wY1vZ74pvdo/L5slhnOB74PAU9vMH8oVmH6vGmbGoC5
1w2VZPVl49XzVIN60olwQwtOi61PslUyJcKchr2qyzzBYLzLpMFGoGJ6p1Mm79e5
vkvAzqxzHHEz12vZoK1xwkx1JCKwXAc5ww4loFkKH+BHm4LGj7Y=
=U4ga
-----END PGP SIGNATURE-----

--lg27farh6a5fhzif--
