Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42699 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755072AbdDEMNM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2017 08:13:12 -0400
Date: Wed, 5 Apr 2017 14:13:10 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        thomas.petazzoni@free-electrons.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.xyz
Subject: Re: [PATCH v4 6/8] ARM: sun8i: a33: add CPU thermal throttling
Message-ID: <20170405121310.4lgf5st5oqc52szb@lukather>
References: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
 <20170405090634.4649-7-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ibh5oquzapmnjvd"
In-Reply-To: <20170405090634.4649-7-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--6ibh5oquzapmnjvd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 11:06:32AM +0200, Quentin Schulz wrote:
> This adds CPU thermal throttling for the Allwinner A33. It uses the
> thermal sensor present in the SoC's GPADC.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>=20
> v3:
>   - switched to new phandle because of modified DT node name for the GPADC
>   (named THS),
>   - got rid of cooling-min-level and cooling-max-level as it's not used i=
n any
>   code in the kernel,
>=20
> v2:
>   - updated cooling-max-level to reflect newly added OPPs,
>=20
>  arch/arm/boot/dts/sun8i-a33.dtsi | 45 ++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a=
33.dtsi
> index 9734e63..b88c107 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -43,6 +43,7 @@
>   */
> =20
>  #include "sun8i-a23-a33.dtsi"
> +#include <dt-bindings/thermal/thermal.h>
> =20
>  / {
>  	cpu0_opp_table: opp_table0 {
> @@ -127,6 +128,7 @@
>  			clocks =3D <&ccu CLK_CPUX>;
>  			clock-names =3D "cpu";
>  			operating-points-v2 =3D <&cpu0_opp_table>;
> +			#cooling-cells =3D <2>;
>  		};
> =20
>  		cpu@1 {
> @@ -170,6 +172,49 @@
>  		};
>  	};
> =20
> +	thermal-zones {
> +		cpu_thermal {
> +			/* milliseconds */
> +			polling-delay-passive =3D <250>;
> +			polling-delay =3D <1000>;
> +			thermal-sensors =3D <&ths>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cpu_alert0>;
> +					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +				map1 {
> +					trip =3D <&cpu_alert1>;
> +					cooling-device =3D <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +
> +			trips {
> +				cpu_alert0: cpu_alert0 {
> +					/* milliCelsius */
> +					temperature =3D <75000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +
> +				cpu_alert1: cpu_alert1 {
> +					/* milliCelsius */
> +					temperature =3D <90000>;
> +					hysteresis =3D <2000>;
> +					type =3D "hot";
> +				};
> +
> +				cpu_crit: cpu_crit {
> +					/* milliCelsius */
> +					temperature =3D <110000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +		};
> +	};
> +

This wasn't sorted properly (thermal is not between mali- and memory
in the alphabetical order). Fixed and applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--6ibh5oquzapmnjvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY5N9WAAoJEBx+YmzsjxAgmRIP/RDQB4l+a1YcBP+X24XoUrbk
cS09KOGw55S2rdjWh5VUQ62QcvC2D9l9CDk3MWy/8ak4jEmJCtWPp2yCcax9yRgt
Z4QOPMpDKbxOwfavCavVS0qNuYTbeKGVNVO5w25biDbRzEJjfodW5QBAZf93qkUs
szvI97MYUoaqCJS6Qk9owQIHwLBtUnCK1ah8G9B3YEGoCgo0fZYEiBK/luosV+FP
8YYzUgUXHwaKvTMkpYQK+GI3KS3MNY//hJE7/H8DSKmG06ndrUGEZHHjBHUJT3zS
47NTadvprMh+hlNUBltkxQXcUgGqPzR8KwSSq3y5mPYXe0LfeVaMcg0urRn51995
ucRcbWu5hSLbDeZMFCyaetb4mTgmygBZRTwGHoPc3EFauCLjf65o9zyBNOMFH0Tm
48gKuNCm7E1KD2iSv+tLRhFU3x/+RaJxXqx57G3YCJQXB55dH5PX4W9fcxrFBitC
2Kb8Ba5XdyOmid72Q7XKDUD/o2R0zhXCnLPmq++Xnbj2ZtrFWGyrmqhYCQoaFX+k
taiZTYOV2bN9am5VHiNrk5MG+csgeTMjOnh1gOxEpY6EOrK5pOwvBtCPimzDDanL
2yiZ3Rb9Sn/595Pgd5B6dR5zgRZIKtFloxz3NrjtiQGWeld/weHH8QHx9XBhJtW9
MfZxKXCn2e5Npg7E55l5
=4Vxs
-----END PGP SIGNATURE-----

--6ibh5oquzapmnjvd--
