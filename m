Return-Path: <SRS0=uf+1=EY=free-electrons.com=maxime.ripard@kernel.org>
Date: Mon, 29 Jan 2018 10:19:37 +0100
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
Subject: Re: [PATCH v2 01/16] dt-bindings: update the Allwinner GPADC device
 tree binding for H3 & A83T
Message-ID: <20180129091937.w3c3btvva5yaqlf6@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-2-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zjddjsktcivnjn4h"
In-Reply-To: <20180128232919.12639-2-embed3d@gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--zjddjsktcivnjn4h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

On Mon, Jan 29, 2018 at 12:29:04AM +0100, Philipp Rossak wrote:
> Allwinner H3 features a thermal sensor like the one in A33, but has its
> register re-arranged, the clock divider moved to CCU (originally the
> clock divider is in ADC) and added a pair of bus clock and reset.
>=20
> Allwinner A83T features a thermal sensor similar to the H3, the ths clock,
> the bus clock and the reset was removed from the CCU. The THS in A83T
> has a clock that is directly connected and runs with 24 MHz.
>=20
> Update the binding document to cover H3 and A83T.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>

Thanks a lot for tackling this.

> ---
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 50 ++++++++++++++++=
++++--
>  1 file changed, 47 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Docu=
mentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> index 86dd8191b04c..22df0c5c23d4 100644
> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -4,12 +4,35 @@ The Allwinner SoCs all have an ADC that can also act as=
 a thermal sensor
>  and sometimes as a touchscreen controller.
> =20
>  Required properties:
> -  - compatible: "allwinner,sun8i-a33-ths",
> +  - compatible: must contain one of the following compatibles:
> +		- "allwinner,sun8i-a33-ths"
> +		- "allwinner,sun8i-h3-ths"
> +		- "allwinner,sun8i-a83t-ths"
>    - reg: mmio address range of the chip,
> -  - #thermal-sensor-cells: shall be 0,
> +  - #thermal-sensor-cells: shall be 0 or 1,
>    - #io-channel-cells: shall be 0,
> =20
> -Example:
> +Required properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +		- "allwinner,sun8i-a83t-ths"
> +  - interrupts: the sampling interrupt of the ADC,
> +
> +Required properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +  - clocks: the bus clock and the input clock of the ADC,
> +  - clock-names: should be "bus" and "mod",
> +  - resets: the bus reset of the ADC,
> +
> +Optional properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +  - nvmem-cells: A phandle to the calibration data provided by a nvmem d=
evice.
> +		If unspecified default values shall be used. The size should
> +		be 0x2 * sensorcount.
> +  - nvmem-cell-names: Should be "calibration".
> +
> +Details see: bindings/nvmem/nvmem.txt
> +
> +Example for A33:
>  	ths: ths@1c25000 {
>  		compatible =3D "allwinner,sun8i-a33-ths";
>  		reg =3D <0x01c25000 0x100>;
> @@ -17,6 +40,27 @@ Example:
>  		#io-channel-cells =3D <0>;
>  	};
> =20
> +Example for H3:
> +	ths: thermal-sensor@1c25000 {
> +		compatible =3D "allwinner,sun8i-h3-ths";
> +		reg =3D <0x01c25000 0x400>;
> +		clocks =3D <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
> +		clock-names =3D "bus", "mod";
> +		resets =3D <&ccu RST_BUS_THS>;
> +		interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +		#thermal-sensor-cells =3D <0>;
> +		#io-channel-cells =3D <0>;
> +	};
> +
> +Example for A83T:
> +	ths: thermal-sensor@1f04000 {
> +		compatible =3D "allwinner,sun8i-a83t-ths";
> +		reg =3D <0x01f04000 0x100>;
> +		interrupts =3D <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +		#thermal-sensor-cells =3D <1>;
> +		#io-channel-cells =3D <0>;
> +	};
> +

I'm wondering if this is actually needed. We've used this convoluted
constructs to be compatible with the old driver, but I'm not sure this
is actually worth it now, and this is causing several issues, among
which:
  - We need to have a bunch of quirks to handle all the DT cases.
  - We need to have an MFD, which isn't really optimal

So I'd rather introduce a new compatible for the old SoCs, keep the
old driver around, and simplify a lot that driver code that will ease
further developments. And we can also get rid of the MFD in the
process. I discussed it with Quentin, and he was ok with it, what do
you think?

(and that would involve creating a new file for the bindings you
introduce here).

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--zjddjsktcivnjn4h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu5ygACgkQ0rTAlCFN
r3Sz6xAAlWMuf1ghBfwH9cNbuz1yQXvxPgknGkILP5rpSa2jE+9q5Ri0JmCX7gVo
d5GaRkP/kOxZyPLns7eSPPbUvMgqnoZx+XQsLLxaagJIlT1y0ZS4Mb1UJMBLuTpO
yEjrRCcDvRNeMBPKLiDnrhAXwmY58yUUMQjPrVqzpjkhqV6V2TOBYgthsaZEOEJU
p4ZVwJ6AvU7w9Q7cPp/klFI6JYI+NBtRw+HicpIK4IUFrTluSh37/Kp5go7CpaPM
b5XT8mk5bPHrLMES9P8TWgt+3glDhRDXNpO5QiWHWe/Cwn7Q7azQSI+ax6RROLSv
VyE7KfI5jMD8s0AhoauHChqdIc9pRitMlRRXqkwyBxoDc8VLXV8fQJ77fTteP+cF
zPsrVDNld2ApEKLe4o6EdiRu2rG2pkDl97vrNuOxtZrVZk+jzefcFbJyTR2VFg2N
G2Hmf/IsHf4RcAkgntFc05Bwbfl1Dj+TlTm3+Ec+yngrY/XV/lhBIMhV68H9iQ8T
lsSGyny6yONQdUFLakdfczwNoOErAv9nbfrPfM/JVg0rLyWwJ2HoI/KYOf3DTW0N
6tM4OtGfMSw7gwH8JpQcCSDKEhbWHElBdHs24Hk3Tt3/sQ8mHL5bgjj2BwGFQmLs
pML6cNmibn9NjojgyfLMF60sW6gtWOf0e9TDDBDK0w7KC9qiLQ8=
=pObp
-----END PGP SIGNATURE-----

--zjddjsktcivnjn4h--
