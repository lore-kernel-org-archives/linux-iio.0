Return-Path: <SRS0=/XQe=M4=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Colin King <colin.king@canonical.com>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2] iio: adc: ina2xx: add in early -EINVAL returns in case statements
Date: Tue, 16 Oct 2018 20:26:57 +0200
Message-ID: <3078823.PklSZE2rHu@pebbles>
In-Reply-To: <20181016161418.29213-1-colin.king@canonical.com>
References: <20181016161418.29213-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2946009.hxjI0KkqV5";
	micalg=pgp-sha1; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>

--nextPart2946009.hxjI0KkqV5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 16. Oktober 2018 18:14:18 CEST Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Static analysis with CoverityScan is throwing warnings that specific
> case statements are missing breaks.  Rather than adding breaks, add
> return -EINVAL to the specific case statements to clarify the
> error return paths. Fix also saves 50 bytes.
>=20
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   21418	   4936	    128	  26482	   6772	drivers/iio/adc/ina2xx-adc.o
>=20
> After:
>   dec	    hex	filename
>   21370	   4936	    128	  26434	   6742	drivers/iio/adc/ina2xx-adc.o
>=20
> (gcc 8.2, x86-64)
>=20
> Detected by CoverityScan, CID#1462408 ("Missing break in switch")
>=20
> ---
>=20
> V2: use returns instead of break statements to keep with the
> current style used in the switch statement.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>

> ---
>  drivers/iio/adc/ina2xx-adc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index d1239624187d..bdd7cba6f6b0 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -250,6 +250,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  			*val2 =3D chip->shunt_resistor_uohm;
>  			return IIO_VAL_FRACTIONAL;
>  		}
> +		return -EINVAL;
>=20
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
>  		switch (chan->address) {
> @@ -262,6 +263,7 @@ static int ina2xx_read_raw(struct iio_dev *indio_dev,
>  			*val =3D chip->range_vbus =3D=3D 32 ? 1 : 2;
>  			return IIO_VAL_INT;
>  		}
> +		return -EINVAL;
>  	}
>=20
>  	return -EINVAL;


=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart2946009.hxjI0KkqV5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCW8YtcQAKCRBvf0o9jP6q
U3v9AJ44Qty9cHY5G9OUBkpyD/51jKQ4xgCeLeC0V5AxngnaVSBE21yehWchN/8=
=cW1Q
-----END PGP SIGNATURE-----

--nextPart2946009.hxjI0KkqV5--
