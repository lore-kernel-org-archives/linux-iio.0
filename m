Return-Path: <mpa@pengutronix.de>
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: imx25-gcq: fix do_div
Date: Mon, 07 Mar 2016 10:01:34 +0100
Message-ID: <8010548.jDMIC4yOG6@adelgunde>
In-Reply-To: <56DB28BF.9070508@kernel.org>
References: <1457009513-7069-1-git-send-email-sudipm.mukherjee@gmail.com> <56DB28BF.9070508@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6688230.ptskEYYV1b"; micalg="pgp-sha256"; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>


--nextPart6688230.ptskEYYV1b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

On Saturday 05 March 2016 18:43:11 Jonathan Cameron wrote:
> On 03/03/16 12:51, Sudip Mukherjee wrote:
> > We are getting build failure with tilepro allmodconfig with the err=
or:
> >=20
> > drivers/iio/adc/fsl-imx25-gcq.c:236:4: note: in expansion of macro =
'do_div'
> > do_div(priv->channel_vref_mv[reg], 1000);
> >     ^
> >=20
> > include/asm-generic/div64.h:198:17: note: expected 'uint64_t *
> > =09{aka long long unsigned int *}' but argument is of type 'u32 *
> > =09{aka unsigned int *}'
> >=20
> > Create a temporary variable of type u64 and use that in do_div.
> >=20
> > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> Markus, can you take a quick look at this.=20

Thanks. I think this was already fixed by Arnd.
=09"iio: adc/imx25-gcq: move incorrect do_div"

Best Regards,

Markus

>=20
> > ---
> >=20
> > tilepro allmodconfig build log is at:
> > https://travis-ci.org/sudipm-mukherjee/parport/jobs/113325889
> >=20
> >  drivers/iio/adc/fsl-imx25-gcq.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-=
imx25-gcq.c
> > index 2fd1927..e0636d4 100644
> > --- a/drivers/iio/adc/fsl-imx25-gcq.c
> > +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> > @@ -174,6 +174,7 @@ static int mx25_gcq_setup_cfgs(struct platform_=
device *pdev,
> >  =09struct device *dev =3D &pdev->dev;
> >  =09unsigned int refp_used[4] =3D {};
> >  =09int ret, i;
> > +=09u64 temp;
> > =20
> >  =09/*
> >  =09 * Setup all configurations registers with a default conversion=

> > @@ -233,7 +234,9 @@ static int mx25_gcq_setup_cfgs(struct platform_=
device *pdev,
> >  =09=09=09priv->channel_vref_mv[reg] =3D
> >  =09=09=09=09regulator_get_voltage(priv->vref[refp]);
> >  =09=09=09/* Conversion from uV to mV */
> > -=09=09=09do_div(priv->channel_vref_mv[reg], 1000);
> > +=09=09=09temp =3D priv->channel_vref_mv[reg];
> > +=09=09=09do_div(temp, 1000);
> > +=09=09=09priv->channel_vref_mv[reg] =3D temp;
> >  =09=09=09break;
> >  =09=09case MX25_ADC_REFP_INT:
> >  =09=09=09priv->channel_vref_mv[reg] =3D 2500;
> >=20
>=20
>=20

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart6688230.ptskEYYV1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJW3UNuAAoJEEpcgKtcEGQQ2vsQAK1kgok+x3/iRGNZxCQYHMUN
uLVGbUkLell1kfwoi5ZSbX3mjsX5xe5ZULY7JmvrGYVEX1AIDArmDDuVQ3TEh8Dm
dLtvoTOJlU9eC2UrM354wOw7QdXwgVkqPREoQU+gLppjTD7ttw9vKLgka4VHarzQ
u4NbaRvZbSe6mfbzG9NY+U6puluE+PSNgY1t5RNglnrBqDniaGO8obGA4vMhK2hS
TlCVOq89F59ftZBv+H9C63eYtJnY+JYo4Bpj5OyG9OPkH4Lrzsd7ikly0f0Wrb+7
qLyvkdQvs7JhQQMJpTKpPzSd+mrcdRueR1pprQ+anGO/V34q/ZyG0qQyMx6SX6Ch
k26oDSselMztMB/KMCstNOogovxny328mTHM6CZtB6AhHp+fKw+aXxBVWORoOodu
nT64pCjPawyEugbEeEzVAvT/BDqTBUHteIF6hF5kvwsGABj7c6BKk29tvIzw6sqY
CeTZ/9YS5Q2IKsZwyLYXGRypMUAt8frqy7F6yXOEstYp/X0jH2h4jj/tHzCmY42D
09ogOEhzJYT4NVAYuGdDiAr2aGk2MkUgBslLOYhp/j8VUUlQ9rgwRyzG/hUF/vUQ
+mS6dp2LC03sv8Ixl8dlrcrD7A/K4aEGnwmCM1uo0Wfv54kl8iGidjiYlA4PWtxj
UdemTW8yM9l9pGIpNjjU
=iw0T
-----END PGP SIGNATURE-----

--nextPart6688230.ptskEYYV1b--
