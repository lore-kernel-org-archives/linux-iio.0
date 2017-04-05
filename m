Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42604 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752875AbdDEMMb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2017 08:12:31 -0400
Date: Wed, 5 Apr 2017 14:12:28 +0200
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
Subject: Re: [PATCH v4 5/8] ARM: sun8i: a33: add thermal sensor
Message-ID: <20170405121228.vhl3lien6t4s7omm@lukather>
References: <20170405090634.4649-1-quentin.schulz@free-electrons.com>
 <20170405090634.4649-6-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5td2szmdpnrtclw7"
In-Reply-To: <20170405090634.4649-6-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--5td2szmdpnrtclw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 05, 2017 at 11:06:31AM +0200, Quentin Schulz wrote:
> This adds the DT node for the thermal sensor present in the Allwinner
> A33 GPADC.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>=20
> v3:
>   - switched compatible to allwinner,sun8i-a33-ths,
>   - renamed DT node name and label to ths to better match datasheet's nam=
e,
>=20
>  arch/arm/boot/dts/sun8i-a33.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a=
33.dtsi
> index 077db22..9734e63 100644
> --- a/arch/arm/boot/dts/sun8i-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a33.dtsi
> @@ -266,6 +266,13 @@
>  			status =3D "disabled";
>  		};
> =20
> +		ths: ths@01c25000 {
> +			compatible =3D "allwinner,sun8i-a33-ths";
> +			reg =3D <0x01c25000 0x100>;
> +			#thermal-sensor-cells =3D <0>;
> +			#io-channel-cells =3D <0>;
> +		};
> +
>  		fe0: display-frontend@01e00000 {
>  			compatible =3D "allwinner,sun8i-a33-display-frontend";
>  			reg =3D <0x01e00000 0x20000>;
> @@ -376,6 +383,11 @@
>  			};
>  		};
>  	};
> +
> +	iio-hwmon {
> +		compatible =3D "iio-hwmon";
> +		io-channels =3D <&ths>;
> +	};

This wasn't sorted properly (iio is before soc in the alphabetical order).
Fixed it and applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5td2szmdpnrtclw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY5N8oAAoJEBx+YmzsjxAgygQP/Rs0TEFy0ybYlejOU43Ugixf
AwWiL464SG/Uz5BAQzdxcz+15ZZEUNDHaWZ6IX9+Dj6y4EZPyuXqmB/cr922oUNf
TDFIAWYQYQI3U++gK2+mpNsfZZu0oRgmrbG0mPgEU0eBt2dyfpddkUkrqcuVc2Oy
zYvE/yi7/VwliV7PmOmoPuAmbGhKYzfKEepfc7ZKO7HGhFSJmTmO9hdx6Tn40j30
EmhdKHrHRvRD3SJ2CtJwFxqi1+v2kz9liySy527FSwNyQA7bAqOXm+iyHySC7L1D
2tU5kDROWGxSV8Q2H08GFNkGksGdERX/QEfinByayY01PWqsoGsWg1mzDOkuVWS3
lhu5rrrA/WkweBp5DQQgBcp+iwltWB90e6n5WttNTYCLq81ivtWTB3gTpoZDb5Yc
vkmsyrS8unmYEsGaJVa1aT+Az/6bnpuZ9VHj3X293NuNgFka6oa/SU0XwfNbrNo8
US6r0bWgl/Z+rs36ZBEO0H6Gsf7S4cSxswi5VDCKTQybNr9JU5Jtd0XsADvoBc5s
6JavruyDJCwgo2IQtEgE3ARv3mRpjLvLpe0DBipgldW9X58L/vsBxwu1i2gdCdoh
4q8unLhtZPfhJPr4ZP2FPFfqiJJBRanVDzd2VpvCe6I5JjBnvUpHeF1oxqgFMsrA
zo7F2bfGO8KsyyG7J0BZ
=ozcy
-----END PGP SIGNATURE-----

--5td2szmdpnrtclw7--
