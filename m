Return-Path: <SRS0=ySyy=HT=canonical.com=shrirang.bagul@kernel.org>
Message-ID: <1525079565.10678.10.camel@canonical.com>
Subject: Re: [PATCH][for iio-for-4.17b] iio: humidity: hts221: Fix sensor
 reads after resume
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Date: Mon, 30 Apr 2018 17:12:45 +0800
In-Reply-To: <CAA2SeNKn6mavKBa8=pU5sPLWpLKY=A5GGnwRZcn65Mhzd-8jqQ@mail.gmail.com>
References: <20180430051658.9856-1-shrirang.bagul@canonical.com>
	 <CAA2SeNKTjVO7JBVV3qJMJhdM-j=r+igd_nADe+NH3Rux0oW1qA@mail.gmail.com>
	 <1525078153.10678.9.camel@canonical.com>
	 <CAA2SeNKn6mavKBa8=pU5sPLWpLKY=A5GGnwRZcn65Mhzd-8jqQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-kfSKndke77wBTTD/GqTC"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


--=-kfSKndke77wBTTD/GqTC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-04-30 at 11:05 +0200, Lorenzo Bianconi wrote:
> > On Mon, 2018-04-30 at 09:48 +0200, Lorenzo Bianconi wrote:
> > > > CTRL1 register (ODR & BDU settings) gets reset after system comes b=
ack
> > > > from suspend, causing subsequent reads from the sensor to fail.
> > > >=20
> > > > This patch restores the CTRL1 register after resume.
> > > >=20
> > >=20
> > > Hi Shrirang,
> > >=20
> > > is just CTRL1 reset after suspend/resume or also other registers? are
> > > IIO triggers enabled before the suspend or
> > > are you reading data from sysfs?
> > >=20
> > > > Based on:
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-for=
-4.17b
> > > >=20
> > > > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR recon=
figuration)
> > > > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> > > > ---
> > > >  drivers/iio/humidity/hts221_core.c | 13 +++++++------
> > > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humid=
ity/hts221_core.c
> > > > index 166946d4978d..5d7a652aa6d9 100644
> > > > --- a/drivers/iio/humidity/hts221_core.c
> > > > +++ b/drivers/iio/humidity/hts221_core.c
> > > > @@ -658,12 +658,13 @@ static int __maybe_unused hts221_resume(struc=
t device *dev)
> > > >         struct hts221_hw *hw =3D iio_priv(iio_dev);
> > > >         int err =3D 0;
> > > >=20
> > > > -       if (hw->enabled)
> > > > -               err =3D regmap_update_bits(hw->regmap, HTS221_REG_C=
NTRL1_ADDR,
> > > > -                                        HTS221_ENABLE_MASK,
> > > > -                                        FIELD_PREP(HTS221_ENABLE_M=
ASK,
> > > > -                                                   true));
> > > > -       return err;
> > > > +       err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_AD=
DR,
> > > > +                                HTS221_BDU_MASK,
> > > > +                                FIELD_PREP(HTS221_BDU_MASK, 1));
> > > > +       if (err < 0)
> > > > +               return err;
> > > > +
> > > > +       return hts221_update_odr(hw, hw->odr);
> > > >  }
> > > >=20
> >=20
> > No need to re-enable the sensor here. hts221_read_oneshot() [called fro=
m hts221_read_raw()] does that every time before read:
> >=20
>=20
> Could please try to change other registers (e.g. rh or temp gain) and
> double check values are properly configured resuming the sensor?
> It is necessary to re-enable the sensor if you use IIO triggers and
> the sensor was enabled before the suspend operation
Sure. I'll do some more testing and share the results.
>=20
> > static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
> > {
> >         __le16 data;
> >         int err;
> >=20
> >         err =3D hts221_set_enable(hw, true);
> >         if (err < 0)
> >                 return err;
> >=20
> >         msleep(50);
> >=20
> >         err =3D regmap_bulk_read(hw->regmap, addr, &data, sizeof(data))=
;
> >         if (err < 0)
> >                 return err;
> >=20
> >         hts221_set_enable(hw, false);
> >=20
> > Regards,
> > Shrirang
> > >=20
> > > Here you need to re-enable the sensor if it was running before the
> > > suspend operation.
> > > Regards,
> > >=20
> > > Lorenzo
> > >=20
> > > >  const struct dev_pm_ops hts221_pm_ops =3D {
> > > > --
> > > > 2.14.1
> > > >=20
> > >=20
> > >=20
> > >=20
>=20
>=20
>=20
--=-kfSKndke77wBTTD/GqTC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJa5t4NAAoJELlj3b/+u+hkYIIQAIkLaOuF4ct8vR+N0/cp4+C4
1+DSbTLCmPt+UH+bBDL8XNgqfAu+9wroenYMZilZSB6qQPgXHWqktpCpAaVQA8I8
BH3g5EhR20d5LKxO0bBwZmCYVN0tBzT5XCHJZ+RwjIaMgO8ssHYA7JO49PmQisSg
Gyvf/F5Y1f0FqBwHk8xzcvpgTWTbUY0CiNUDDX2SLwGeyQmbuxbvqy808f1MoOdC
3lmReRAMMrT3Tb9TcyB16hAgSJxC9Vnn+iPjmwDnbNYnNG7DaU9xLzfDPTRX0oOW
M/mL6c9ZzeNQVHDx34/5DX6Hob0fMT989rwiyQI5oy+X+JnG9ONGhGj2XDt1My7f
M25HH28QQjYW1TnJJfML1KqpQ7XkNrs8BgJneen05Iss9J7OnhBc3p152dNIXFrm
7+kgwUEOzvD1CCifyRfQB5AHqSmNQ7tMtpYuE9gRC8tJLZw+kKp/i715DLkEuCOt
1pHXYcKbTPQJoERd56yJJI5DLnR69yoFQhj+rFnJrByRpjlH/JcDxAm/PDAFCxr3
CJBCnwVAeOeZMMYREextHfBO+3NZB7NtXTuGm/4B776CC7HKVkmtRUb2a04sSGqT
AacsZpmG0VuQEybLfsBibJoQOPFdSl3Si+9VJgtoTiq1tt/6+E0oIW34p6pRS4kz
gZV3dY3L/S5UO9GQayJi
=RNJu
-----END PGP SIGNATURE-----

--=-kfSKndke77wBTTD/GqTC--
