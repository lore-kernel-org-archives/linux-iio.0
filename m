Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57685 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbbBXCVh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 23 Feb 2015 21:21:37 -0500
Date: Tue, 24 Feb 2015 13:21:25 +1100
From: NeilBrown <neilb@suse.de>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	GTA04 owners <gta04-owner@goldelico.com>
Subject: Re: [PATCH] iio: gyro: itg3200: add suspend/resume support.
Message-ID: <20150224132125.31118411@notabene.brown>
In-Reply-To: <546D1BB5.8010308@gmx.de>
References: <20141108111833.3829480c@notabene.brown>
	<546D1BB5.8010308@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/s6z2LZlKo.fKFm_vbJmqqRx"; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

--Sig_/s6z2LZlKo.fKFm_vbJmqqRx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Nov 2014 23:37:41 +0100 Hartmut Knaack <knaack.h@gmx.de> wrote:

> NeilBrown schrieb am 08.11.2014 01:18:
> >=20
> >=20
> > Unless we put the device to sleep when not it use, it wastes
> > 6mA.
> >=20
> > If the device is asleep on probe, the 'id' register
> > sometimes mis-reads - so reset first.  If the device responds
> > at all a command sent to the address, it is almost certainly
> > the correct device already.
> >=20
> Hi Neil,
> I still have some question and issues, see inline.
> > Signed-off-by: NeilBrown <neil@brown.name>
> >=20
> > diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200=
_core.c
> > index 6a8020d48140..394667fb23f9 100644
> > --- a/drivers/iio/gyro/itg3200_core.c
> > +++ b/drivers/iio/gyro/itg3200_core.c
> > @@ -223,6 +223,7 @@ static int itg3200_initial_setup(struct iio_dev *in=
dio_dev)
> >  	int ret;
> >  	u8 val;
> > =20
> > +	ret =3D itg3200_reset(indio_dev);
> You should check possible error codes here. Also, there is still another =
reset issued some lines further down, although in between, there is only th=
e register-read performed, which we see right below here - I would assume t=
his wouldn't change anything in the device to require another reset. So, in=
 conclusion, wouldn't it be sufficient to just move the reset part from fur=
ther down up here?
> >  	ret =3D itg3200_read_reg_8(indio_dev, ITG3200_REG_ADDRESS, &val);
> >  	if (ret)
> >  		goto err_ret;
> > @@ -351,6 +352,35 @@ static int itg3200_remove(struct i2c_client *clien=
t)
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_PM_SLEEP
> > +static int itg3200_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > +	struct itg3200 *st =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	dev_dbg(&st->i2c->dev, "suspend device");
> > +
> > +	ret =3D itg3200_write_reg_8(indio_dev,
> > +			ITG3200_REG_POWER_MANAGEMENT,
> > +			ITG3200_SLEEP);
> > +	return ret;
> No need for ret, if you do it like this (fixing also some indentation iss=
ue):
> 	return itg3200_write_reg_8(indio_dev, ITG3200_REG_POWER_MANAGEMENT,
> 				   ITG3200_SLEEP);


hi Hartmut,
 thanks for these suggestions.  I made the changes you suggested to my code,
 but it appears that I never replied or reposted.  Sorry about that.

 I'll resubmit in a moment...

Thanks,
NeilBrown

--Sig_/s6z2LZlKo.fKFm_vbJmqqRx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVOvgJTnsnt1WYoG5AQKJeA//ZDcLNkB3ODAZ1hiFXCvPisanP1F5Pzu9
Sw9MDYMTfGi8zyCO3BYrfgTqDzSPiF8d9GgW1FcGWYi/f/B0aFdZRsx3cFqbVrV6
b4RPECspyv9wy40ErnqP2ifLwwWK6rd0ovF/MbmwO328iABKZUllGelDfrwAWekh
Jh2HuAPTp9bY6NslBX6QPq1kAynMQG2U1SC3S/6oOzKpExAYkXV18YeO6Cuhn81e
c99LOfxsNs3Ii4oyhL9CDjk+ooFgIKoHW96vVRn9f6CsBl2f0QkcJHlDziGf5tug
5LAWoegWbQ26X0CHHgoJUOLq0JFhQrbZ8gSdxpOWcy59n3j7Rat6CYq02yp7FQ08
TwW4HZSnkX08F4gwXPbfOpWdaoapBuwbXDJEudgKSLBB2titWLuWecDzJOlToaL3
aOLlXmP14YjAuJe6BqosyegTc2umeA85DY5oiCRnkT6VybdFiAGLGm1nvlxWjLDI
txhiIvQ460Wnr2Wn+IzriRZlIdTV/C6P+1f0K35gvrrEXNd9SVQmkywhc7RezA9O
iVvW0rBGO6x7VwasUMtzostRJEK/2rd79NZkhzbxUgEOeeQxGVviOGsctgrlVjEe
FSJGa8DETwTJrDzXuFXwzalqEfY3ksgH4IWuXn+Qb+hGN8fZRscbSn4/rDj1IFsD
L5vnkANHeOg=
=bqL1
-----END PGP SIGNATURE-----

--Sig_/s6z2LZlKo.fKFm_vbJmqqRx--
