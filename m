Return-Path: <SRS0=pnoz=DD=free-electrons.com=quentin.schulz@kernel.org>
Subject: Re: [PATCH 3/8] mfd: axp20x: probe axp20x_adc driver for AXP813
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
 linux@armlinux.org.uk, jic23@kernel.org, lee.jones@linaro.org,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, icenowy@aosc.io, linux-sunxi@googlegroups.com,
 thomas.petazzoni@free-electrons.com
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <302c93023d8c4a54cafe321d912df484e39727b7.1512396054.git-series.quentin.schulz@free-electrons.com>
 <20171205080855.arr7vlgnxoxmyedd@flea.lan>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <2021a653-d01e-f46f-2438-0760f579e0dc@free-electrons.com>
Date: Thu, 7 Dec 2017 09:51:29 +0100
MIME-Version: 1.0
In-Reply-To: <20171205080855.arr7vlgnxoxmyedd@flea.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CKe7BMNQHPDOaBDUGGk5sXG7SusBOD6rT"
List-ID: <linux-iio@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CKe7BMNQHPDOaBDUGGk5sXG7SusBOD6rT
Content-Type: multipart/mixed; boundary="L8Vm8d4SIciBN1MfClM1D85tcCuLeDfav";
 protected-headers="v1"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
 linux@armlinux.org.uk, jic23@kernel.org, lee.jones@linaro.org,
 knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, icenowy@aosc.io, linux-sunxi@googlegroups.com,
 thomas.petazzoni@free-electrons.com
Message-ID: <2021a653-d01e-f46f-2438-0760f579e0dc@free-electrons.com>
Subject: Re: [PATCH 3/8] mfd: axp20x: probe axp20x_adc driver for AXP813
References: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
 <302c93023d8c4a54cafe321d912df484e39727b7.1512396054.git-series.quentin.schulz@free-electrons.com>
 <20171205080855.arr7vlgnxoxmyedd@flea.lan>
In-Reply-To: <20171205080855.arr7vlgnxoxmyedd@flea.lan>

--L8Vm8d4SIciBN1MfClM1D85tcCuLeDfav
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On 05/12/2017 09:08, Maxime Ripard wrote:
> On Mon, Dec 04, 2017 at 03:12:49PM +0100, Quentin Schulz wrote:
>> This makes the axp20x_adc driver probe with platform device id
>> "axp813-adc".
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  drivers/mfd/axp20x.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index 2468b43..42e54d1 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -878,7 +878,9 @@ static struct mfd_cell axp813_cells[] =3D {
>>  		.resources		=3D axp803_pek_resources,
>>  	}, {
>>  		.name			=3D "axp20x-regulator",
>> -	}
>> +	}, {
>> +		.name			=3D "axp813-adc",
>> +	},
>=20
> Any particular reason you're not adding it to the DT?
>=20

No, no particular reason. It's just the way it is currently for AXP209
and AXP22x so did the same for AXP813.

I'll add DT "support" in next version for all AXPs supported by this
driver. Or is it worthy of a small separate patch series?

Thanks,
Quentin
--=20
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com


--L8Vm8d4SIciBN1MfClM1D85tcCuLeDfav--

--CKe7BMNQHPDOaBDUGGk5sXG7SusBOD6rT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJaKQEfAAoJEIS4mnU+4PGjl7wQAKV051f4Ogq8VT/6GjoD0HTq
6BVWQ6noHHW+mGZJBdQ8bSsa+oLjA/UbOPraZUdUn6tiiNWVsuGji3N0LpJPnlQC
8pIGLrC3A4arFGlHEgZCPTdvvwnKcE2lu9RxWbY38GHAvWIcZyOK7G5s2KUOlmpC
6TecdVq6JjSIETVch5syOYA9/x5WfS1tiquOGDbCOJs3+SlUe/WVLnm7QZ6zJVcs
8OFl2cjJFOaArVCwRih2sECMRGbn9Y7h/wdXkTcW4obmtkzV84xjx5pKrWcoof2l
X+Uv0jVgZhlto1FhrUfajwE/Xj90r4vchfJJFjUF/FWVIJ09REqlkIxLhnjlf7iI
otyPRi3RGtR3CO0A1LwKmR8+IlIgq214c/foBhMcLOyDAneHdW7DdWyWOfba7aqt
vUXOvETU9isCdCV6d8FvydqHpdJqpXnJhjX9YeYU8f+2hYginFdd7maN1UVZb03K
eaiFbYD3zbvguSCVVlHbvhfy84Uvo0qyVN/fDwH8vGNXjhFYwDKw0AA4BqJWiWOM
OE3req92nrSeEZYUakoW0kwdVjbRd2UdC7BEiPH4SOw4ZhZiUv6lxdT6nNoO+xWA
Z8T4WtrSPnK74tAEIZoTzhGncK3kAMESyouh/lpPkCpghPu9HHGx8351zLmynkNc
6WYdwKKAF5oLo6OZEhd1
=bEdh
-----END PGP SIGNATURE-----

--CKe7BMNQHPDOaBDUGGk5sXG7SusBOD6rT--
