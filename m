Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35283 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeD3ItU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Apr 2018 04:49:20 -0400
Received: from mail-pf0-f197.google.com ([209.85.192.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <shrirang.bagul@canonical.com>)
        id 1fD4Up-0007lr-6S
        for linux-iio@vger.kernel.org; Mon, 30 Apr 2018 08:49:19 +0000
Received: by mail-pf0-f197.google.com with SMTP id r63so5535717pfl.12
        for <linux-iio@vger.kernel.org>; Mon, 30 Apr 2018 01:49:19 -0700 (PDT)
Message-ID: <1525078153.10678.9.camel@canonical.com>
Subject: Re: [PATCH][for iio-for-4.17b] iio: humidity: hts221: Fix sensor
 reads after resume
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Date: Mon, 30 Apr 2018 16:49:13 +0800
In-Reply-To: <CAA2SeNKTjVO7JBVV3qJMJhdM-j=r+igd_nADe+NH3Rux0oW1qA@mail.gmail.com>
References: <20180430051658.9856-1-shrirang.bagul@canonical.com>
         <CAA2SeNKTjVO7JBVV3qJMJhdM-j=r+igd_nADe+NH3Rux0oW1qA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-r/uOq9txqxHGhbjFlkti"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-r/uOq9txqxHGhbjFlkti
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-04-30 at 09:48 +0200, Lorenzo Bianconi wrote:
> > CTRL1 register (ODR & BDU settings) gets reset after system comes back
> > from suspend, causing subsequent reads from the sensor to fail.
> >=20
> > This patch restores the CTRL1 register after resume.
> >=20
>=20
> Hi Shrirang,
>=20
> is just CTRL1 reset after suspend/resume or also other registers? are
> IIO triggers enabled before the suspend or
> are you reading data from sysfs?
>=20
> > Based on:
> > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-for-4.1=
7b
> >=20
> > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfigu=
ration)
> > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> > ---
> >  drivers/iio/humidity/hts221_core.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/=
hts221_core.c
> > index 166946d4978d..5d7a652aa6d9 100644
> > --- a/drivers/iio/humidity/hts221_core.c
> > +++ b/drivers/iio/humidity/hts221_core.c
> > @@ -658,12 +658,13 @@ static int __maybe_unused hts221_resume(struct de=
vice *dev)
> >         struct hts221_hw *hw =3D iio_priv(iio_dev);
> >         int err =3D 0;
> >=20
> > -       if (hw->enabled)
> > -               err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNTRL=
1_ADDR,
> > -                                        HTS221_ENABLE_MASK,
> > -                                        FIELD_PREP(HTS221_ENABLE_MASK,
> > -                                                   true));
> > -       return err;
> > +       err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> > +                                HTS221_BDU_MASK,
> > +                                FIELD_PREP(HTS221_BDU_MASK, 1));
> > +       if (err < 0)
> > +               return err;
> > +
> > +       return hts221_update_odr(hw, hw->odr);
> >  }
> >=20
No need to re-enable the sensor here. hts221_read_oneshot() [called from ht=
s221_read_raw()] does that every time before read:

static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
{
	__le16 data;
	int err;

	err =3D hts221_set_enable(hw, true);
	if (err < 0)
		return err;

	msleep(50);

	err =3D regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
	if (err < 0)
		return err;

	hts221_set_enable(hw, false);

Regards,
Shrirang
>=20
> Here you need to re-enable the sensor if it was running before the
> suspend operation.
> Regards,
>=20
> Lorenzo
>=20
> >  const struct dev_pm_ops hts221_pm_ops =3D {
> > --
> > 2.14.1
> >=20
>=20
>=20
>=20
--=-r/uOq9txqxHGhbjFlkti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJa5tiJAAoJELlj3b/+u+hki+oQAKzlQfYuqsQvLaBR6Xp6Rq7w
XAsVdX3xXDpPY1ZZw8gbnvDMGEixLHZj1ZVe4FB+SMHhCqZnlJxIoAFhAGcAH+sn
u8zL7nt2PB/7bvnrsOODRIgndUgS6CzIt0WwlzL3F94vS9iPbZg0KQCKTaCZEuo0
k+e9jXrtReZcTXNcA5i8Q76M/QSm7ANBNKAvmfBXAUC51a/0RQhtD6HDaTsInpnq
QO11DwaIWTVI/OumUZdmnt+qp2saCL56jW1iKFNam4ax5jAUmsHiWfYO/MayQEK0
Y+9goGaUggNUWsHJXwEPhBHkMy7sc3PniUZXtv/0qZdY6054GUBPiGUth57JDgci
CeS5Tdy2gsVCU4TDyhX3DmXcACmFaxScMW5Ty5z12pXGJyrNI18RKwCLDFZzeEjA
brWY+HiO3EybGUfKeJhQ7EuJjH8L50y5tqN1OcIiSwVxLts9vMlkndA87NI/8Oz3
/7YBHlLA3ul0+xh6Si7BY4OPupWIKQfZ3Aw2dzeoCh303HvQ3TSjP5YTiWu3RdmM
SoSQzMCsFLbL5IP/OgaiPQhBnCfebqKKNbzyZDV4r4Tl1ZwJQPbSMWOLXy6BCVvB
b3LLW9SMBbvCQZsMoCeJ3vADVbqckKn9DIF1akyoadxz2ZFWxho0Ez68NWXZ/wBP
VgMUUvdoEkKTRpCpXVTn
=ycdp
-----END PGP SIGNATURE-----

--=-r/uOq9txqxHGhbjFlkti--

