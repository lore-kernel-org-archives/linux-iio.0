Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52781 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751955AbcILLIt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2016 07:08:49 -0400
Subject: Re: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
To: Lee Jones <lee.jones@linaro.org>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160912091829.GB1873@dell>
 <93bd339b-85ab-d0fc-5e80-e2aca290c0d7@free-electrons.com>
 <20160912095923.GD1873@dell>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        maxime.ripard@free-electrons.com, wens@csie.org,
        thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <5dec118f-45ae-4fb6-dd1e-2028947add53@free-electrons.com>
Date: Mon, 12 Sep 2016 13:08:42 +0200
MIME-Version: 1.0
In-Reply-To: <20160912095923.GD1873@dell>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="em5fifscGG4pExVElJK1lfsT7jU7gNEGw"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--em5fifscGG4pExVElJK1lfsT7jU7gNEGw
Content-Type: multipart/mixed; boundary="Cl0hwJveQjPhgqFDDQMRW5WR3JvvNMe52";
 protected-headers="v1"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, maxime.ripard@free-electrons.com,
 wens@csie.org, thomas.petazzoni@free-electrons.com,
 antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Message-ID: <5dec118f-45ae-4fb6-dd1e-2028947add53@free-electrons.com>
Subject: Re: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160912091829.GB1873@dell>
 <93bd339b-85ab-d0fc-5e80-e2aca290c0d7@free-electrons.com>
 <20160912095923.GD1873@dell>
In-Reply-To: <20160912095923.GD1873@dell>

--Cl0hwJveQjPhgqFDDQMRW5WR3JvvNMe52
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/09/2016 11:59, Lee Jones wrote:
> On Mon, 12 Sep 2016, Quentin Schulz wrote:
>=20
>> On 12/09/2016 11:18, Lee Jones wrote:
>>> On Thu, 08 Sep 2016, Quentin Schulz wrote:
>>>
>> [...]
>=20
> [...]
>=20
>>>> +++ b/drivers/mfd/sun4i-gpadc-mfd.c
>=20
> [...]
>=20
>>>> +static struct mfd_cell sun4i_gpadc_mfd_cells[] =3D {
>>>> +	{
>>>> +		.name	=3D "sun4i-a10-gpadc-iio",
>>>> +		.resources =3D adc_resources,
>>>> +		.num_resources =3D ARRAY_SIZE(adc_resources),
>>>> +	}, {
>>>> +		.name =3D "iio_hwmon",
>>>> +	}
>>>
>>> Single line please
>>>
>>> { .name =3D "iio_hwmon" }
>>>
>>
>> +	{
>> +		.name	=3D "sun4i-a10-gpadc-iio",
>> +		.resources =3D adc_resources,
>> +		.num_resources =3D ARRAY_SIZE(adc_resources),
>> +	}, { .name =3D "iio_hwmon" }
>>
>> or
>>
>> +	{
>> +		.name	=3D "sun4i-a10-gpadc-iio",
>> +		.resources =3D adc_resources,
>> +		.num_resources =3D ARRAY_SIZE(adc_resources),
>> +	},
>> +	{ .name =3D "iio_hwmon" }
>>
>> ?
>=20
> The latter.
>=20
> [...]
>=20
>>>> +static const struct of_device_id sun4i_gpadc_mfd_of_match[] =3D {
>>>> +	{
>>>> +		.compatible =3D "allwinner,sun4i-a10-ts",
>>>> +		.data =3D &sun4i_gpadc_mfd_cells,
>>>> +	}, {
>>>> +		.compatible =3D "allwinner,sun5i-a13-ts",
>>>> +		.data =3D &sun5i_gpadc_mfd_cells,
>>>> +	}, {
>>>> +		.compatible =3D "allwinner,sun6i-a31-ts",
>>>> +		.data =3D &sun6i_gpadc_mfd_cells,
>>>> +	}, { /* sentinel */ }
>>>> +};
>>>
>>> Don't mix OF and MFD functionality.
>>>
>>> Why don't you create a node for "iio_hwmon" and have
>>> platform_of_populate() do your bidding?
>>>
>>
>> We are using a stable binding which we cannot modify. This means, the =
DT
>> in its current state can only be modified to add features, which is no=
t
>> the case of this driver (it is a rewriting of an existing driver which=

>> uses the rtp node).
>=20
> Then use .data =3D <defined model ID> and set up a switch() in .probe()=
=2E
>=20
>>>> +static int sun4i_gpadc_mfd_probe(struct platform_device *pdev)
>>>
>>> Remove all mention of "mfd" from this file.
>>>
>>> (Accept the calls to the MFD API of course).
>>>
>> [...]
>>>> +
>>>> +MODULE_DEVICE_TABLE(of, sun4i_gpadc_mfd_of_match);
>>>
>>> Place this directly under the table.
>>>
>>>> +static struct platform_driver sun4i_gpadc_mfd_driver =3D {
>>>> +	.driver =3D {
>>>> +		.name =3D "sun4i-adc-mfd",
>>>> +		.of_match_table =3D of_match_ptr(sun4i_gpadc_mfd_of_match),
>>>> +	},
>>>> +	.probe =3D sun4i_gpadc_mfd_probe,
>>>
>>> No .remove?
>>>
>>
>> No, everything in probe is handled with devm functions.
>=20
> Don't you need to undo the register write you did?
>=20

The regmap_write I use is there to disable all interrupts on hardware
side before the irq_chip handles all interrupts by itself. The
interrupts are not used in the MFD driver.

Thus, I chose to disable the hardware interrupts in the remove function
of drivers using the interrupts (only the IIO yet but the touchscreen
driver later also which will be using a third interrupt). When the MFD
driver is removed, the MFD cells will all be removed, thus calling their
own remove functions, thus disabling hardware interrupts used in each
driver. So the hardware interrupts disabling would be called twice.

Quentin


--Cl0hwJveQjPhgqFDDQMRW5WR3JvvNMe52--

--em5fifscGG4pExVElJK1lfsT7jU7gNEGw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX1oy+AAoJEIS4mnU+4PGjLXIP/21Xuj+A/pBfe4kyXv7HONkT
F4vqkGk+JolpKH7bKguq4G0tJPJr92CxYeveBhyJ0JHzquYTdXpHzMdD2PhaUW+s
2ILECsUO3BDy02KhFKq6EWB3frJ+DHjWp6bqdeURh+ZQ2EkXpyF5kwsPMmmD0Z3K
5poFwsUQHa0y/Ms5JxkApMDs9YaUZiufBP8ly84jq394h20VVxeTxHshmfrgg8eZ
4cr4cOfITArmt0f5QQ+nOJbaGM2DdYcNO7BJS0fwJYR+7SDnbVcG4wmm2Dp7jO4S
+DFgmC4Fpwg9Utj0jsUzQ/hO8IjDFw7NYINzvgB6ZoIpF3OH71fFx98sLQTx4aEJ
WpJDEvCekJal+TdZUUAToJUzkBD/jdW+m+9Jgo+e2TXYHM+oqDml/wEPX/sk63W9
7LQqMh55yXTKzJ/4+C339oX6Oy9pLQkT+1peHurWH8T09vJETdny3Hw7aPDtKqap
A9RNhSMiyAwYJI+EXibSZF4G2GS5GIOKnnQ29EmVKsFx2S1Eg9g0xKDr6xEJkRng
kv0N3GvSxoeFP3H4H7K/SpT0jWAeDj+fSTDREzKeqHFDA0p0dBCbFinzMyWCZzI0
+YfsYZgQwJnFNO9Dr2bRu9FZSK8WPqFBYMzZ7aswwuZ96GnxkErtkNAlrkX/SoJn
0BKt13tpwqurUvMrCP5U
=/TZ8
-----END PGP SIGNATURE-----

--em5fifscGG4pExVElJK1lfsT7jU7gNEGw--
