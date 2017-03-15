Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750819AbdCOW27 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Mar 2017 18:28:59 -0400
Date: Wed, 15 Mar 2017 23:28:52 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: icenowy@aosc.xyz, bonbons@linux-vserver.org, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, liam@networkimprov.net,
        thomas.petazzoni@free-electrons.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 11/18] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Message-ID: <20170315222852.z2qrwoexcsjt7vs6@earth>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-12-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ip6cacbwqtl3gqim"
In-Reply-To: <20170315105537.22349-12-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ip6cacbwqtl3gqim
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 11:55:30AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
>=20
> This patch adds the DT binding documentation for the battery power
> supply which gets various data from the PMIC, such as the battery status
> (charging, discharging, full, dead), current max limit, current current,
> battery capacity (in percentage), voltage max and min limits, current
> voltage and battery capacity (in Ah).
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I suggest to do "s/battery-power-supply/battery-fuel-gauge/g"

> ---
>=20
> v4:
>  - added monitored-battery optional property,
>  - added example with battery,
>=20
> v3:
>  - removed constant charge current property, now should use the WIP
>  battery framework,
>=20
> v2:
>  - changed DT node name from ac_power_supply to ac-power-supply,

ac-power-supply?

-- Sebastian

>  - removed io-channels and io-channel-names from DT (the IIO mapping is
>  done in the IIO ADC driver now),
>  - added x-powers,constant-charge-current property to set the maximal
>  default constant current charge of the battery,
>  .../bindings/power/supply/axp20x_battery.txt       | 30 ++++++++++++++++=
++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x=
_battery.txt
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_batter=
y.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> new file mode 100644
> index 0000000..89cb7a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.txt
> @@ -0,0 +1,30 @@
> +AXP20x and AXP22x battery power supply
> +
> +Required Properties:
> + - compatible, one of:
> +			"x-powers,axp209-battery-power-supply"
> +			"x-powers,axp221-battery-power-supply"
> +
> +Optional properties:
> + - monitored-battery, phandle to a fixed battery
> +
> +This node is a subnode of the axp20x/axp22x PMIC.
> +
> +The AXP20X and AXP22X can read the battery voltage, charge and discharge
> +currents of the battery by reading ADC channels from the AXP20X/AXP22X
> +ADC.
> +
> +Example:
> +
> +battery: battery {
> +	compatible =3D "fixed-battery";
> +	voltage-min-design-microvolt =3D <3200000>;
> +	constant-charge-microamp =3D <300000>;
> +};
> +
> +&axp209 {
> +	battery_power_supply: battery-power-supply {
> +		compatible =3D "x-powers,axp209-battery-power-supply";
> +		monitored-battery =3D <&battery>;
> +	}
> +};
> --=20
> 2.9.3
>=20

--ip6cacbwqtl3gqim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJwCQACgkQ2O7X88g7
+pqMtQ/5ARJlGNz5RSaC+wTkBU3S0acbDo2r28IIJ9OWq2Gtp6Z/ImDTHGfCkSgI
PL6WJ1NYCYt9yKBxMqgw3ny3lbRlFj9RSsUhPFeH3szM/wzynKbfXdyM3gN3VeW8
dXdXc/LbXEWyQJKO2PwSMrvBU23FWc6aJwzYpUfPy//+BNChYnygKrqflchSoBvx
ERdWMLoYGFCDIGkIod5AstjMsNC7XbAWuL7CmDjeDLblaFX1B605zKkJZcIuXM+o
yCRm5rPGor7/MTEL/AHzB5jGyi1Ju41tZBq0AHfZ6Va1dCYutPH1MPCzRwI++y7V
DazVOMVVN4B5eazFjelCujPHNpXDhOIz1R1hPIXwTxX2AcmJto2iL1pOJXNoO9sg
HxifqEoJcFwrsf4C8VLEuOh9IJep5mH3vQeirhyeO7YiBZ07lVVVbmYPEXr+J3y3
1YxgLeUC5EWWCMj9ZTDRclFQr1e4jaPW3RWQkFPGE3CamEGmQjoI4K38Jnev/NuU
bNKZGHophlLO492NoiAflhbqvPl+zKZORcQJEBLMbIw2oN9agUiIof7nTBtO+toM
633PyGlgkElLwffy4c/bFqspDr8C8uBQinMhvUwvzoaa6yAh0QAVzgURu6YTKrI8
5j4x0ntlFpPLK0j1Ltsm1MN/JCtGE1l82nDV5kY2kiIDA9ePaDM=
=mCZx
-----END PGP SIGNATURE-----

--ip6cacbwqtl3gqim--
