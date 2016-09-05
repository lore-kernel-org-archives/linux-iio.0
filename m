Return-Path: <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
 <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160905070716.GA6322@lukather>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, lee.jones@linaro.org,
 thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <9219f76c-384a-a7c3-5b13-ebaec980ab41@free-electrons.com>
Date: Mon, 5 Sep 2016 09:11:47 +0200
MIME-Version: 1.0
In-Reply-To: <20160905070716.GA6322@lukather>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v6Q5j8UbsUejwnTxwUj7rSSppQrPcb4c2"
List-ID: <linux-iio@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v6Q5j8UbsUejwnTxwUj7rSSppQrPcb4c2
Content-Type: multipart/mixed; boundary="HeNEi8XPIps6l6RFFmJEcWDpLFoGlHVAC";
 protected-headers="v1"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org, lee.jones@linaro.org,
 thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <9219f76c-384a-a7c3-5b13-ebaec980ab41@free-electrons.com>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
 <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160905070716.GA6322@lukather>
In-Reply-To: <20160905070716.GA6322@lukather>

--HeNEi8XPIps6l6RFFmJEcWDpLFoGlHVAC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/09/2016 09:07, Maxime Ripard wrote:
> Hi,
>=20
> Nitpicks ahead.
>=20
> On Thu, Sep 01, 2016 at 04:05:05PM +0200, Quentin Schulz wrote:
>> +	info->soc_specific =3D (struct soc_specific *)platform_get_device_id=
(pdev)->driver_data;
>=20
> This line is still rather long. How about calling the field "data" and
> the structure gpadc_data?
>=20

driver_data is coming from the platform_device_id
(http://lxr.free-electrons.com/source/include/linux/mod_devicetable.h#L49=
8)
so can't really change that.
I could change the structure to gpadc_data, that would save me 2
characters, still 13 characters above the 80 characters limit however.

>> +
>> +	tzd =3D devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0, in=
fo,
>> +						   &sun4i_ts_tz_ops);
>=20
> A comment on why you put the parent device structure and not the
> device itself like you're doing on all the other calls in that probe
> would be nice.
>=20

Indeed.

Thanks,
Quentin

> Thanks!
> Maxime
>=20


--HeNEi8XPIps6l6RFFmJEcWDpLFoGlHVAC--

--v6Q5j8UbsUejwnTxwUj7rSSppQrPcb4c2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXzRq3AAoJEIS4mnU+4PGjiD0P/j/5+oo8bylyYpOnv3CoWT7C
h9xGkvlg1+z+CVQQjcHBhanCHCviqlFNkRA/bfNX5FwtfBCez3vbs4xZbA6FIIgj
BaBU6jtfDcMK+0y8h3sq0ShK6H1hjqlhDebuH4F+CPUY13fYQB1nBaMthlsAUYh7
mXaReTmLRl3Egybqv7tT92/allP4XHGoSOkIT/B7L8G4ACz4PNNBufoYgpN3r5S3
SZHbSVun22FQGIcZ2BYCYql8ddJB1GxbWSB2kfup8it9mKo5UkVbV58tsqjJZrrs
FTIo8N5NcA1GfAfliHkCv3c5bHZa4RA9gHs2FQpI3v+zGHLsymyZv9Hi44Fe8+tm
3tFPbEgnjGgYGq20OoZ8CCoKCE6JbGDzw5o4z4dRCRCGCB2qV9Kso4oczK8cViIN
J1yQeE24dHnRvtWeGcwG2PZB9Fr6BBaV2/OY5o6RrRN57KHh9JXNHBZdRF6NPUmE
ApFa7aWRWVyKw7L4+nJA5GBlis/nfx1/GZfxFMNHn+qbhvXRyup7RMkXuK/IEaC7
FLnYosb5m5mDY6jkaY8UDL7xZ/gfjQ2xNjSb7/G3YOoBw9C7/YjqHtPnw/ogJwOb
p6yqpcLs9x0m7P88muEzJuECpLxW/ufKwTp/fHQ4YLBN02XNYXf+2/n+5SjUTc3d
xrxhOh5hwRPXXWUmQfu5
=3gQg
-----END PGP SIGNATURE-----

--v6Q5j8UbsUejwnTxwUj7rSSppQrPcb4c2--
