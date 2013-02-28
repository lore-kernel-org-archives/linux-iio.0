Return-Path: <thierry.reding@avionic-design.de>
Date: Thu, 28 Feb 2013 07:58:36 +0100
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 14/67] iio:adc:ti-adc081 move to
 info_mask_(shared_by_type/separate)
Message-ID: <20130228065835.GA18144@avionic-0098.mockup.avionic-design.de>
References: <1361997553-31058-1-git-send-email-jic23@kernel.org>
 <1361997553-31058-15-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <1361997553-31058-15-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2013 at 08:38:20PM +0000, Jonathan Cameron wrote:
> The original info_mask is going away in favour of the broken out versions.
>=20
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> cc: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  drivers/iio/adc/ti-adc081c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index f4a46dd..893ba16 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -55,8 +55,8 @@ static int adc081c_read_raw(struct iio_dev *iio,
> =20
>  static const struct iio_chan_spec adc081c_channel =3D {
>  	.type =3D IIO_VOLTAGE,
> -	.info_mask =3D IIO_CHAN_INFO_SCALE_SHARED_BIT |
> -		     IIO_CHAN_INFO_RAW_SEPARATE_BIT,
> +	.info_mask_shared_by_type =3D IIO_CHAN_INFO_SCALE,
> +	.info_mask_separate =3D IIO_CHAN_INFO_RAW,
>  };
> =20
>  static const struct iio_info adc081c_info =3D {

Acked-by: Thierry Reding <thierry.reding@avionic-design.de>

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRLwAbAAoJEN0jrNd/PrOhiSsP/jTqyLP1reZ5iwVmEl2n5TyW
SdHqcDFOGZlhJZymqntsYces0rWK6AF4ersL9RKtgFfBKW5gE6V4NIFGAOKLozG0
y6HpRRyJnTGdsGtvNp6JsrJOZtL/K2ymXwRymID0JZ9sfDm96J2fQTrWkEcHgCRM
5PCBTuVV95dilcev+yZJ3tPS3xz9KTjfRoINdiHneQDu1lXizjqaqgc2YtRAyN11
KMKsILF+jSHbMZNNncK7LUdk/fgwj48ZnfCOq3mGsB2FvISOyHxMUI4hiJhnuHUT
uwo+c50rQnJ/MBOl+Qd5BtR8fwFmZFbzSx+kB0oqW1luPJAUN6R4ykNz6fA7yv44
BnB00qi+MbzY6JfO1r2q1i55KHFLmZIksMozR8VK0XtCus+UW0F2Y6nnXEeHRCf5
Aj+UMULyRKjslcmVWCA0U5RZ5z6ixdYtdMrUF+1iHraWhmwt7oguhut6MRybSomf
uKkVxuCng/P/8Uou3NRQYsvlaYYc9M2bGRt1zZ5VdMFZTi9fShz6eO4Y36/Y4SZG
TWXPNck5vJdOv8E5vyq5sOeZs2XwwLS3XgiDjr6k1G/RHpnMPdUEJDlLYlPyO8tM
MzUlTztQ8UXB1zMBBxNz74hC0EW0dG0YNE0LOLq54sMZWeE3UteswAfokzkRjuNH
a4DiJMi+86BTH5yONsF1
=rWJr
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
