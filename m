Return-Path: <SRS0=NyI3=X3=free-electrons.com=quentin.schulz@kernel.org>
Subject: Re: [PATCH v8 3/3] iio: adc: add support for Allwinner SoCs ADC
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <20161209102236.17655-1-quentin.schulz@free-electrons.com>
 <20161209102236.17655-4-quentin.schulz@free-electrons.com>
 <20161210094429.yp26sfoz54oqy3dz@lukather>
Cc: linux@armlinux.org.uk, wens@csie.org, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, antoine.tenart@free-electrons.com,
 thomas.petazzoni@free-electrons.com
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <2d5bd8b1-b14d-74fa-1ae3-3db3ffa71e5f@free-electrons.com>
Date: Mon, 12 Dec 2016 08:40:39 +0100
MIME-Version: 1.0
In-Reply-To: <20161210094429.yp26sfoz54oqy3dz@lukather>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IMFWQMQRMrhIPBKMTWNvBrMu3l8sht3kv"
List-ID: <linux-iio@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IMFWQMQRMrhIPBKMTWNvBrMu3l8sht3kv
Content-Type: multipart/mixed; boundary="CeFjQSQXVslqH3OrmNxHVmNGsfK2Q1bN2";
 protected-headers="v1"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux@armlinux.org.uk, wens@csie.org, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, antoine.tenart@free-electrons.com,
 thomas.petazzoni@free-electrons.com
Message-ID: <2d5bd8b1-b14d-74fa-1ae3-3db3ffa71e5f@free-electrons.com>
Subject: Re: [PATCH v8 3/3] iio: adc: add support for Allwinner SoCs ADC
References: <20161209102236.17655-1-quentin.schulz@free-electrons.com>
 <20161209102236.17655-4-quentin.schulz@free-electrons.com>
 <20161210094429.yp26sfoz54oqy3dz@lukather>
In-Reply-To: <20161210094429.yp26sfoz54oqy3dz@lukather>

--CeFjQSQXVslqH3OrmNxHVmNGsfK2Q1bN2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On 10/12/2016 10:44, Maxime Ripard wrote:
> Hi,
>=20
> Just some minor comments.
>=20
> On Fri, Dec 09, 2016 at 11:22:36AM +0100, Quentin Schulz wrote:
>> +	/*
>> +	 * Since the thermal sensor needs the IP to be in touchscreen mode a=
nd
>> +	 * there is no register to know if the IP has finished its transitio=
n
>> +	 * between the two modes, a delay is required when switching modes. =
This
>> +	 * slows down ADC readings while the latter are critical data to the=

>=20
> The latter between what and what?
>=20
>> +	 * user. Disabling CONFIG_THERMAL_OF in kernel configuration allows =
the
>> +	 * user to avoid registering the thermal sensor (thus unavailable) a=
nd
>=20
> Isn't it obvious that it's not going to be available if you do not
> register it?
>=20
>> +	 * does not switch between modes thus "quicken" the ADC readings.
>> +	 * The thermal sensor should be enabled by default since the SoC
>> +	 * temperature is usually more critical than ADC readings.
>=20
> This last sentence should be in the Kconfig help. You cannot expect
> that all your users will read all the source code they want to compile
> :)
>=20
> Overall, I think this comment is kind of missing the point, maybe
> something like:
>=20
> /*
>  * Since the controller needs to be in touchscreen mode for its
>  * thermal sensor to operate properly, and that switching between the
>  * two modes needs a delay, always registering in the thermal
>  * framework will significantly slow down the conversion rate of the
>  * ADCs.
>  *
>  * Therefore, instead of depending on THERMAL_OF in Kconfig, we only
>  * register the sensor if that option is enabled, eventually leaving
>  * that choice to the user.
>  */
>=20
> Would be much clearer.
>=20
>> +	 */
>> +
>> +	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
>> +	/*
>> +	 * This driver is a child of an MFD which has a node in the DT but n=
ot
>> +	 * its children. Therefore, the resulting devices of this driver do =
not
>=20
> Wrong indentation for the comment, and saying why the MFD children
> don't have a node in the DT (backward compatibility) would be nice.
>=20

Thanks for the comments, that's indeed much clearer.

>> +	 * have an of_node variable.
>> +	 * However, its parent (the MFD driver) has an of_node variable and
>> +	 * since devm_thermal_zone_of_sensor_register uses its first argumen=
t to
>> +	 * match the phandle defined in the node of the thermal driver with =
the
>> +	 * of_node of the device passed as first argument and the third argu=
ment
>> +	 * to call ops from thermal_zone_of_device_ops, the solution is to u=
se
>> +	 * the parent device as first argument to match the phandle with its=

>> +	 * of_node, and the device from this driver as third argument to ret=
urn
>> +	 * the temperature.
>> +	 */
>> +		tzd =3D devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0,
>> +							   info,
>> +							   &sun4i_ts_tz_ops);
>=20
> I don't think tzd is used anywhere else in your function, it can be
> made local to this block.
>=20

ACK.

Thanks,
Quentin

--=20
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com


--CeFjQSQXVslqH3OrmNxHVmNGsfK2Q1bN2--

--IMFWQMQRMrhIPBKMTWNvBrMu3l8sht3kv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYTlR/AAoJEIS4mnU+4PGjQxUP/0uH3/bFs8HAPNQYDztS4Ppw
82G87zMOTC9xpQa6+N0noe1SWd9P5cP2uUoeAFVFyl4sp6bWVLWsh+rOjuOOemKk
+GX8fxIl4pJzKzsto9vhX8oIbpHoQFXa3M9VzSPPzsnIc56W38QXa8ftaaQwG0BA
QgpOvc2RJ955sbJD9MbjYf52xizVuPRIE1x5JXPLLcbfUHi4IADN1KqE6Mrqr8I/
J+uPIjOLZjsUAJCAJooJaMToiQdNK602UuK1HcuX/4OBsNJZ9Xz1oK3afAKILHfd
DheNItKSTWSF+rNTjzPPFIQlqLrMidAQsiVvNwE3f680Alo+qwZ5W6/mSmPG3Maa
//gf2tLnGKIHwBLMCYcgvmK0+U/qKzfBp8/PNEojMK/5txzy0lQ+f6vjPhRP35rB
jcn76HMI8DwtJcT8GStUtjSC66RSU2fFOE8LbDhovq3wNvpbSkk7XllAujwXpDQe
I8EuZRmmYnOAOdBSD3LwQQpHCdDgSkpm3oZ7wCLAVHxQeuXTDh0x+h37V8Hpk3Jf
uaP09dAqegsHnFDrehLuGcmTRI8F47uzFt0+QRJLearCg6Th63pia68j6TuTIWCO
BmwzcRfM7vUtwkeI1quB5PlEGhHTaDBbmn8ZbPKKOCiX5O0oNqshJnig2M/TTrVL
l9ATk31gh+QGWLsibcsl
=x7vM
-----END PGP SIGNATURE-----

--IMFWQMQRMrhIPBKMTWNvBrMu3l8sht3kv--
