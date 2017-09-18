Return-Path: <SRS0=YtUh=AT=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 18 Sep 2017 10:25:12 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 5/6] ARM: sun8i: h3: add support for the thermal
 sensor in H3
Message-ID: <20170918082512.ovzwuorvwqjkueqa@flea.lan>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-6-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uppqkaastklkpelm"
In-Reply-To: <20170914145251.21784-6-icenowy@aosc.io>
List-ID: <linux-iio@vger.kernel.org>


--uppqkaastklkpelm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 10:52:50PM +0800, Icenowy Zheng wrote:
> As we have gained the support for the thermal sensor in H3, we can now
> add its device nodes to the device tree.
>=20
> Add them to the H3 device tree.
>=20
> The calibration data of the thermal sensor is still not added, as
> it's currently not used, and the SID node is not added yet.
>=20
> The H5 thermal sensor has some differences, and will be added furtherly.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v4:
> - Mention calibration data in commit message.
> Changes in v3:
> - Clock name changes.
> - Splited out thermal zone addition.
>=20
>  arch/arm/boot/dts/sun8i-h3.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3=
=2Edtsi
> index b36f9f423c39..3220da3ad790 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -72,6 +72,23 @@
>  		};
>  	};
> =20
> +	iio-hwmon {
> +		compatible =3D "iio-hwmon";
> +		io-channels =3D <&ths>;
> +	};
> +
> +	soc {
> +		ths: thermal-sensor@1c25000 {
> +			compatible =3D "allwinner,sun8i-h3-ths";
> +			reg =3D <0x01c25000 0x100>;
> +			clocks =3D <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
> +			clock-names =3D "bus", "mod";
> +			resets =3D <&ccu RST_BUS_THS>;
> +			#thermal-sensor-cells =3D <0>;
> +			#io-channel-cells =3D <0>;

You're missing your interrupt.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--uppqkaastklkpelm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZv4LoAAoJEBx+YmzsjxAgq+4P/0b14DwvxGRvlvd2G0wzSt6C
BV5IhB0/5Gju03/p3Zk/HKGTC9sISo4jNXatD9jDuHeC7+PCZNqjKpSp6XrO8ELq
ZUmerwK5Zl7TJhj/C0mItk6/4OEkQ3zXNX8Z59697eJhO5+qKjh0090ue92Dmv3N
iV7wd527NIPCZ8u272gI4g++4ogcZJ8k0g3FXfJjtwM38MCRME1vtal92lTIAGVG
//E8wjwmK6x4/IXllGj+Rj9S8W3Ms5L10jOiaE/zQ8d4qwIkAguG3ZCb9sNwfHE3
ByNQ9dshh2S73VjY52GTMu9T+b76UxP00vNWJAMfzEzMBKM6UqSOnE9PzsYRg36o
OdiAUB8sSwMsC9K4GEXjNrdwsk90bo+kDbPfDWpleRpXr54HmH35HzRj71ojNByF
1V2kYNXWWGKfpCfQCWQuxdwNOcwAdyo0JqM+hhf/uMjhaKx9JHvKSr6CphVxIO13
4O+QkqHlQoMk5RAPPBwFSt2axQNJIC+vJoFN30bY0465cFzXlbYJt5ZpPLyJe3zN
ZFzJ+GtQMAAP90xh4Xq+F3LzecP2/EBbRc9GiWNXKn0s733pK1pnN9cFI9ELwS8V
7cSbJEJ8ZbmMqyGGQFrM10dMpidjkT+7FTD18HK/kzuAv2hrmEFMth5xrB15ep5S
H2VPUBCxokEtglDRJfL2
=HTWY
-----END PGP SIGNATURE-----

--uppqkaastklkpelm--
