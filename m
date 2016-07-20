Return-Path: <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2 2/4] iio: adc: add support for Allwinner SoCs ADC
To: Jonathan Cameron <jic23@kernel.org>, jdelvare@suse.com,
 linux@roeck-us.net, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-3-git-send-email-quentin.schulz@free-electrons.com>
 <e24c8b63-7774-66d2-3317-43fd5598ecc9@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <f6e32bf0-f043-0d34-5190-18b89920bbfd@free-electrons.com>
Date: Wed, 20 Jul 2016 14:37:40 +0200
MIME-Version: 1.0
In-Reply-To: <e24c8b63-7774-66d2-3317-43fd5598ecc9@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HxvCJFVC1lFkB5N14LlMuB48XOs5RrX30"
List-ID: <linux-iio@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HxvCJFVC1lFkB5N14LlMuB48XOs5RrX30
Content-Type: multipart/mixed; boundary="W3iWRIIwRsC8XoFXaMLMpQG941CHVkdkX"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>, jdelvare@suse.com,
 linux@roeck-us.net, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com
Message-ID: <f6e32bf0-f043-0d34-5190-18b89920bbfd@free-electrons.com>
Subject: Re: [PATCH v2 2/4] iio: adc: add support for Allwinner SoCs ADC
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-3-git-send-email-quentin.schulz@free-electrons.com>
 <e24c8b63-7774-66d2-3317-43fd5598ecc9@kernel.org>
In-Reply-To: <e24c8b63-7774-66d2-3317-43fd5598ecc9@kernel.org>

--W3iWRIIwRsC8XoFXaMLMpQG941CHVkdkX
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 18/07/2016 15:18, Jonathan Cameron wrote:
[...]
>> +
>> +	if (!wait_for_completion_timeout(&info->completion,
>> +					 msecs_to_jiffies(100))) {
>> +		ret =3D -ETIMEDOUT;
>> +		goto out;
>> +	}
>> +
>> +	if (info->flags & SUNXI_GPADC_ARCH_SUN4I)
>> +		*val =3D info->temp_data * 133 - 257000;
> Why report as processed?  I'd just report them as raw with the scale
> and offset provided.  It's not a big thing, but if we can leave it so
> that the conversion only occurs when desired, why not?
>=20
> For in kernel users, this all happen 'automagically' anyway ;)
>=20

Mmmmh, in the code above we apply the scale on the raw value and then
the offset. While in iio_convert_raw_to_processed
(http://lxr.free-electrons.com/source/drivers/iio/inkern.c#L507), the
offset is applied before the scale.

The way would be to factorize the computation by scale:
Now: *val =3D raw * scale + offset
Then: *val =3D (raw + offset/scale) * scale

But the offset is an integer and offset/scale is therefore rounded.
Currently, we have the following values:
sun4i: -257000/133 =3D -1932.3308270676691
sun5i: -144700/100 =3D -1447
sun6i: -271000/167 =3D -1622.754491017964

Do we accept such rounding?

If not, we either stay with the processed value in read_raw or patch
inkern to add an offset to apply after having applied the scale to the
raw value (val2 from iio_channel_read is yet unused with
IIO_CHAN_INFO_OFFSET for example, we could use that to specify an
offset2 to apply after the switch(scale_type)-case).

[...]
Quentin


--W3iWRIIwRsC8XoFXaMLMpQG941CHVkdkX--

--HxvCJFVC1lFkB5N14LlMuB48XOs5RrX30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXj3CYAAoJEIS4mnU+4PGjKpQP/3KtP3hQllHM2DIcqj3zVf4H
r2Fx+VMp0fvkVyhE6l5ffu0zikSSQXP9F3ytwqdbxbDgvjBdU5+uufjb0CDAzvvG
5TgqklBgnVnO0wGw9eGwLy8FRYxB3ioq1l8Y6zr7cjn9Dr4hcRC+co09Fanfuqci
mGGZts81U0NFtUl76KrFgmEEct9Hh95Rj3+jJXxUHzatRRK+8vI0m9Hk/jv1ouGJ
uqTcGpjlWGAMrVEmGWsCKGhhE5XP7/fjBnDoNxTetoPPMLynpPRSQy+UpbYCtPcQ
37Bn21vbxB2Mrl2HSV985E8/+AtJlSF5Npl9DBg7Mk3nporNrtojnMJ7+GoL1nVA
Of0LXuF+TJjusZOLnJDszKL+EU6vhgWm3QcJWFBchdvtoA4txh6OH4EpAlsqrENx
SZbg2aTlMYGjM6UWkACnSaLzzpOV8b9qspTIlMlQsFhMqKdh60xF+Mqq52TnbEOH
SaEm9aK8qUz/eZ+MMicEG+1v0iU77Fk/KZ8RbZqNMh5AJNmRxIUVPTir+4lCuE3O
fwrLS810VIZYYUY1Lsh3wlJfGgYFPs/BdelpXMaRNao4JvZE4I+MmDSm8dy/sHlj
gQvgliSYROL78wZQ8FBrq+xQWfuSGU2wY69kQxnfHhFvXnbEeSJdU+2OlQEBe0uf
n+p9vBcZPSZyTGRYIHJH
=qqjn
-----END PGP SIGNATURE-----

--HxvCJFVC1lFkB5N14LlMuB48XOs5RrX30--
