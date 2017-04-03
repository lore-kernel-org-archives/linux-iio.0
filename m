Return-Path: <SRS0=G0Wd=3L=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 3 Apr 2017 08:42:08 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: icenowy@aosc.io, Lee Jones <lee.jones@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH v2 4/4] ARM: sun8i: h3: add support for the thermal
 sensor in H3
Message-ID: <20170403064208.llk6usgtkbg5ejzw@lukather>
References: <20170402133304.56824-1-icenowy@aosc.io>
 <20170402133304.56824-5-icenowy@aosc.io>
 <3f13c07d-be6a-0350-6d86-de1a4d4e33a8@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j5sdxdc32svkkqg5"
In-Reply-To: <3f13c07d-be6a-0350-6d86-de1a4d4e33a8@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>


--j5sdxdc32svkkqg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2017 at 04:34:55PM +0200, Quentin Schulz wrote:
> Hi Icenowy,
>=20
> On 02/04/2017 15:33, Icenowy Zheng wrote:
> > As we have gained the support for the thermal sensor in H3, we can now
> > add its device nodes to the device tree.
> >=20
> > Add them to the H3 device tree.
> >=20
> > The H5 thermal sensor has some differences, and will be added furtherly.
> >=20
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  arch/arm/boot/dts/sun8i-h3.dtsi | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-=
h3.dtsi
> > index b36f9f423c39..552217bb9266 100644
> > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > @@ -72,6 +72,32 @@
> >  		};
> >  	};
> > =20
> > +	iio-hwmon {
> > +		compatible =3D "iio-hwmon";
> > +		io-channels =3D <&ths>;
> > +	};
> > +
> > +	soc {
> > +		ths: ths@01c25000 {
> > +			compatible =3D "allwinner,sun8i-h3-ths";
> > +			reg =3D <0x01c25000 0x100>;
> > +			clocks =3D <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
> > +			clock-names =3D "bus", "ths";
> > +			resets =3D <&ccu RST_BUS_THS>;
> > +			#thermal-sensor-cells =3D <0>;
> > +			#io-channel-cells =3D <0>;
> > +		};
> > +	};
> > +
> > +	thermal-zones {
> > +		cpu_thermal {
> > +			/* milliseconds */
> > +			polling-delay-passive =3D <250>;
> > +			polling-delay =3D <1000>;
> > +			thermal-sensors =3D <&ths>;
> > +		};
>=20
> Would it make sense to add the CPU temp trip points in this patch?

No.

This is a separate, unrelated, change that has nothing to do with what
is described either in the commit title or the commit log.

The thermal zone itself shouldn't even be in this patch.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--j5sdxdc32svkkqg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY4e68AAoJEBx+YmzsjxAgoO4QAJP1HqM4G2JQzd2c7gDybKEF
k00fktQyr/m0CLjntDayL5g7V6ofqhx4ToliHMN87B9L0ETP1X+tlDV/zm5Ej/0o
Ep3m22I3qJHlYPvmT0j+7Q/HtsLxlyxFUGexshZa22T8SKWKLysJ5McVVC9UL+QR
hUjLWMNvbwOKHmXdcETYRc03uBEHN6GpPqW9K9eCg0qHs+wamd3+0benFI1Q0e/2
Nuq7acsl/4/U9D3NR3bc0c9I/3M5pGqRf87HP1mERunpEbY6jpdY9zGtWzpLrWiK
ffe6CoysORKVtB+XTvqGuMzBsk5wnt3+9Hob6QHcVXjkkwfMl9SFL2Ts6HAUU+Xt
q2xUxEVf7odZgv4dWE0sQDayZZB80SM31xgwjnM4lUKapQO/TLIM7AvFLP1qa/y3
2m1r8J9aa2zouQqg3kT4dRi50xebasHUX0Pf/ab8ONMMYbm5z0ZMcaK5Ogt8hjsO
stsNwqWINVK+GTe6VhZhO6Qn0hGtM6ItR/EceWPCrxCs2Q8O0APmn2QEj3ALBJOl
zTWAsaMrYFN9fzRIkz54hBPJf/284LGEciShRzZdFitBJks4BBV1UR06z9cYYHnd
pJWzJE7j+frI3Jn+q/F4DuSbZQywoYXBoEy+uouI6JOTCag8u/seRfWpf15NF1gE
hNdJaaLL5uLMtFtzLgX+
=0FJ3
-----END PGP SIGNATURE-----

--j5sdxdc32svkkqg5--
