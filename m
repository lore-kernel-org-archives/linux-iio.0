Return-Path: <balbi@ti.com>
Date: Mon, 11 Aug 2014 09:58:04 -0500
From: Felipe Balbi <balbi@ti.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Felipe Balbi <balbi@ti.com>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [RFC/PATCH v2] iio: light: add support for TI's opt3001 ligth
 sensor
Message-ID: <20140811145804.GG20177@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407341409-30284-1-git-send-email-balbi@ti.com>
 <1407767673-24635-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.01.1408111641170.1145@pmeerw.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
In-Reply-To: <alpine.DEB.2.01.1408111641170.1145@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2014 at 04:46:07PM +0200, Peter Meerwald wrote:
>=20
> > TI's opt3001 light sensor is a simple and yet powerful
> > little device. The device provides 99% IR rejection,
> > Automatic full-scale, very low power consumption and
> > measurements from 0.01 to 83k lux.
> >=20
> > This patch adds support for that device using the IIO
> > framework.
>=20
> moving in the right direction, the driver got simpler :)
>=20
> light is still misspelled in the subject, the Kconfig needs to be fixed,=
=20
> see below

hah! missed that. Fixed.

> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/iio/light/Kconfig   |  12 +
> >  drivers/iio/light/Makefile  |   1 +
> >  drivers/iio/light/opt3001.c | 739 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 752 insertions(+)
> >  create mode 100644 drivers/iio/light/opt3001.c
> >=20
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index bf05ca5..e4582d7 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -128,6 +128,18 @@ config LTR501
> >  	 This driver can also be built as a module.  If so, the module
> >           will be called ltr501.
> > =20
> > +config OPT3001
> > +	tristate "Texas Instruments OPT3001 Light Sensor"
> > +	depends on I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
>=20
> IIO_BUFFER, IIO_TRIGGERED_BUFFER not needed since not supported by driver

fixed.

both pushed to my branch at kernel.org

--=20
balbi

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT6Nn8AAoJEIaOsuA1yqREUNYQAI1ciS2JoUOdISD4hrwQM/ZY
4tPZ9Xgvv2cUECHbdSUiGoK3Gwan+hzD/PkQohgvrOgirdYQPg+/Wa24sSHGaKjc
m153bUNbtsTFkGOEqSmmwZ10GlHg+aBfY4U+Iu4fbGzQu2/w/8mwF15hIAMP/8h4
KgVqpkwSbF6doDmku+bWiB3j6YlGysAvzf3dfnTwa0z1BcKmHNw3m0MSL8+1c5SZ
5t8ilO24zgW3pBoNFMTLfjZzpRtheN++o7UMJgUqye/ItZ9p6Tlz+CRRZKD0Tuwo
qP1b//V3NSYVYy9g9a5XF7DmrBJeAaZSe05M78UHVIGNKn2mprMW+9MtUca8J70/
byWzSl/l2TORuOkd2Df3WVaTxOMw5QeXaQJr6sA1jx9MvEraoHbQRxqFAHLubFxJ
Yr6woAi6y5axlhKYonWUZ8MscZGdzXs//P1P7Tx/ssszV8mFcsIyH4d+YFAH0GDg
yWYan+Wr1nmkLEesa47oGAb9eKLkQo7OUDRU+ElvNueMityg70JD17dNcdBDIKy6
8cE3GrdCqNn74E0+j86kRgCeiPzF1/MVZ5Rk8Q9ahT3iBaf1m5yVax1rE3TMi+iY
xS5gkvfn5QjLXBGu121B2mlefeSO9ZwZj5VM0JFint+9RyHodBmZOTqrMmAQA8SZ
6lCMT0tWLDZD8x2YSw93
=xcFy
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
