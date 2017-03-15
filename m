Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:50718 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbdCOWla (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 18:41:30 -0400
Subject: Re: [PATCH v4 11/18] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
To: Sebastian Reichel <sre@kernel.org>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-12-quentin.schulz@free-electrons.com>
 <20170315222852.z2qrwoexcsjt7vs6@earth>
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com,
        devicetree@vger.kernel.org, lars@metafoo.de,
        linux-pm@vger.kernel.org, liam@networkimprov.net,
        linux-sunxi@googlegroups.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        bonbons@linux-vserver.org, robh+dt@kernel.org, icenowy@aosc.xyz,
        pmeerw@pmeerw.net, knaack.h@gmx.de,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <761e35fc-932a-953c-cfad-7e967ea3d126@free-electrons.com>
Date: Wed, 15 Mar 2017 23:41:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170315222852.z2qrwoexcsjt7vs6@earth>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H3os4bRIrK53VTemfr3cVwqJmWoK8aCHk"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H3os4bRIrK53VTemfr3cVwqJmWoK8aCHk
Content-Type: multipart/mixed; boundary="0Sst19kenI6FG2oi1qAkJvwGB29PVAlgF";
 protected-headers="v1"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com,
 devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org,
 liam@networkimprov.net, linux-sunxi@googlegroups.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 bonbons@linux-vserver.org, robh+dt@kernel.org, icenowy@aosc.xyz,
 pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com,
 wens@csie.org, lee.jones@linaro.org, jic23@kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-ID: <761e35fc-932a-953c-cfad-7e967ea3d126@free-electrons.com>
Subject: Re: [PATCH v4 11/18] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-12-quentin.schulz@free-electrons.com>
 <20170315222852.z2qrwoexcsjt7vs6@earth>
In-Reply-To: <20170315222852.z2qrwoexcsjt7vs6@earth>

--0Sst19kenI6FG2oi1qAkJvwGB29PVAlgF
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 15/03/2017 23:28, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Mar 15, 2017 at 11:55:30AM +0100, Quentin Schulz wrote:
>> The X-Powers AXP20X and AXP22X PMICs can have a battery as power suppl=
y.
>>
>> This patch adds the DT binding documentation for the battery power
>> supply which gets various data from the PMIC, such as the battery stat=
us
>> (charging, discharging, full, dead), current max limit, current curren=
t,
>> battery capacity (in percentage), voltage max and min limits, current
>> voltage and battery capacity (in Ah).
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> I suggest to do "s/battery-power-supply/battery-fuel-gauge/g"
>=20

The IP is way more than a simple fuel gauge, you have info about the
voltage, current, you can set different things, even though you have the
percentage of the battery returned by the PMIC.

Does it really make sense to rename it that way?

Thanks,
Quentin

>> ---
>>
>> v4:
>>  - added monitored-battery optional property,
>>  - added example with battery,
>>
>> v3:
>>  - removed constant charge current property, now should use the WIP
>>  battery framework,
>>
>> v2:
>>  - changed DT node name from ac_power_supply to ac-power-supply,
>=20
> ac-power-supply?
>=20
> -- Sebastian
>=20
>>  - removed io-channels and io-channel-names from DT (the IIO mapping i=
s
>>  done in the IIO ADC driver now),
>>  - added x-powers,constant-charge-current property to set the maximal
>>  default constant current charge of the battery,
>>  .../bindings/power/supply/axp20x_battery.txt       | 30 +++++++++++++=
+++++++++
>>  1 file changed, 30 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp=
20x_battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_bat=
tery.txt b/Documentation/devicetree/bindings/power/supply/axp20x_battery.=
txt
>> new file mode 100644
>> index 0000000..89cb7a2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/axp20x_battery.tx=
t
>> @@ -0,0 +1,30 @@
>> +AXP20x and AXP22x battery power supply
>> +
>> +Required Properties:
>> + - compatible, one of:
>> +			"x-powers,axp209-battery-power-supply"
>> +			"x-powers,axp221-battery-power-supply"
>> +
>> +Optional properties:
>> + - monitored-battery, phandle to a fixed battery
>> +
>> +This node is a subnode of the axp20x/axp22x PMIC.
>> +
>> +The AXP20X and AXP22X can read the battery voltage, charge and discha=
rge
>> +currents of the battery by reading ADC channels from the AXP20X/AXP22=
X
>> +ADC.
>> +
>> +Example:
>> +
>> +battery: battery {
>> +	compatible =3D "fixed-battery";
>> +	voltage-min-design-microvolt =3D <3200000>;
>> +	constant-charge-microamp =3D <300000>;
>> +};
>> +
>> +&axp209 {
>> +	battery_power_supply: battery-power-supply {
>> +		compatible =3D "x-powers,axp209-battery-power-supply";
>> +		monitored-battery =3D <&battery>;
>> +	}
>> +};
>> --=20
>> 2.9.3
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com


--0Sst19kenI6FG2oi1qAkJvwGB29PVAlgF--

--H3os4bRIrK53VTemfr3cVwqJmWoK8aCHk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYycMMAAoJEIS4mnU+4PGjzcsQAJRtlufCHWMn03WGB9V9Ibwi
pwnl82TYBSztc64+4Y2QqqvM5NwE9o8UxMuqh15bgk7SDsUDq0n46fgWCBnmj+7l
5P+xngQt3CyGE1SejU1TGejoqKjfIuUbFblbsSDq1U3UrjXKa29LQqORx6xeaA4N
nt101TfIReAN/rKqkcFRb01ZP4JzvV3sIfwopehQbl2j0qF/PxR/j9231P8z+Rzy
UOu3LPxdNVzKe6pSpT80nqexnsp3KUUONgtB1NIhVknlQF1CqtR7E2TpXDm76HG1
jsl7hGPln6jBblJr8eOKOu9KX1aBoy/6YeGT6haURgyEIZ8NoCMtBFgAs2NWamTf
VKqjwOoFcg1DejJebBD3gjokf+5ok9komYLaQfEPy8WzHtoGQZ1MDcL3IbjwtSvH
dz4Ok3060yDjpyrZTrrDwZioxC39oG2fJarbDTItw3jBv4yABMYDfD2GskLg7Q1C
Ka3J3Bj2FSGYecNsWNq631CFOWP9uPus6juABIc/X9vhZZHXsQ1LXM8aFOneRWcM
Pcm+Du+ITcAz1+BkaMR/IYTe5hNqOsRSvryPrlWj+91GsOqNKQxmpdPHtiI0cUU9
khkhxeVt5Rth9UICSkbhM7nOZSIw7vpBc1TQlS6zisigMDaKu3a50c2UL5Zl8S33
gLxEM7p/H8ToHuZVeVQx
=fuBW
-----END PGP SIGNATURE-----

--H3os4bRIrK53VTemfr3cVwqJmWoK8aCHk--
