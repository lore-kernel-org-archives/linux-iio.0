Return-Path: <SRS0=NOzP=OD=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Fri, 23 Nov 2018 22:35:18 -0200
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad5933: finalized device-tree support
Message-ID: <20181124003518.6heacjyxuwh6l32y@smtp.gmail.com>
References: <20181123235159.hh43xnvvwsil4on2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a37eh5f7bmtphsys"
In-Reply-To: <20181123235159.hh43xnvvwsil4on2@smtp.gmail.com>
List-ID: <linux-iio@vger.kernel.org>


--a37eh5f7bmtphsys
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

I believe that a proper commit message for this patch could be something
like "Add device tree support".

On 11/23, Marcelo Schmitt wrote:
> Added a of_device_id struct variable and subsequent call to
> MODULE_DEVICE_TABLE macro to complete device-tree support for this
> driver.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/st=
aging/iio/impedance-analyzer/ad5933.c
> index edb8b540bbf1..19e8b6d2865c 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -771,9 +771,18 @@ static const struct i2c_device_id ad5933_id[] =3D {
> =20
>  MODULE_DEVICE_TABLE(i2c, ad5933_id);
> =20
> +static const struct of_device_id ad5933_of_match[] =3D {
> +	{ .compatible =3D "analog-devices,ad5933" },
> +	{ .compatible =3D "analog-devices,ad5934" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, ad5933_of_match);
> +
>  static struct i2c_driver ad5933_driver =3D {
>  	.driver =3D {
>  		.name =3D "ad5933",
> +		.of_match_table =3D ad5933_of_match,
>  	},
>  	.probe =3D ad5933_probe,
>  	.remove =3D ad5933_remove,
> --=20
> 2.17.1
>=20
> --=20
> You received this message because you are subscribed to the Google Groups=
 "Kernel USP" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-usp+unsubscribe@googlegroups.com.
> To post to this group, send email to kernel-usp@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kernel-usp/20181123235159.hh43xnvvwsil4on2%40smtp.gmail.com.
> For more options, visit https://groups.google.com/d/optout.

--=20
Rodrigo Siqueira
https://siqueira.tech
https://twitter.com/siqueirajordao
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--a37eh5f7bmtphsys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlv4nMUACgkQWJzP/com
vP8KCg//auRaWyCY+ySHog5NMcujjY9e19krbXNQ0vj0mLQ3spLEtZrRxvMA6p/p
6mEkK0MPvOUn2gpnQeoFgIWwnVM6XTYqG4quYKrbux/eHlfPa+udtwYNSl0nBGsU
PvUjZWCS0BGe+mZObVi49EXRBfw6lTdPZ4E8SMygueq26G4oAvcYRKxtoX3BDtZE
m3zWz50TIVcTmG/SpCsELWzfBNqmU9RGHm5wDBM6cIErHvnIUqJQvUMoFIRFCg8t
EngBomPyTsDwuteLm7hJy3pmGbtalJOWqfeFVaCpNKL4cAJw0DpEUJqCmbIj8Oy1
aisKyM/Dby5hyrB6fD2QwYib7FYGPcNpjpHl+net5dz+lyjFHKWU+Y1nodQpD9EU
RQ3nVrg6ciPQsjCI97uqop72K6bDYPnYcJQls+6BPfhCW7QUCVDsGOwMiiY8eF0w
a3bDyAeF1AhJz6UPtEJgYbSIP/0iMmLMFqbx09TCJckQaO+E5rpuNzDWcMQrmWLn
cWb7fdHvVPt/gUtnPRzdSh1XT3PKh2MgDeYrV7+7o+7P0SDvu3VOomKRKPCSwjCF
0n4dRM4iZSRvApB6wTJUdlw7GReARe9FiB7NLnWGlGk1Lrr2yDexdXSlhcbipLTk
tT+vPMK235PI3S0uO636ms5VqqoGlemt3JFlSIaNzpAcBKnb1LE=
=xl0V
-----END PGP SIGNATURE-----

--a37eh5f7bmtphsys--
