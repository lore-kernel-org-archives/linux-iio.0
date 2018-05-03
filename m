Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeECHj5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 May 2018 03:39:57 -0400
Received: from mail-pf0-f200.google.com ([209.85.192.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <shrirang.bagul@canonical.com>)
        id 1fE8qK-0005Hq-43
        for linux-iio@vger.kernel.org; Thu, 03 May 2018 07:39:56 +0000
Received: by mail-pf0-f200.google.com with SMTP id c4so14647267pfg.22
        for <linux-iio@vger.kernel.org>; Thu, 03 May 2018 00:39:56 -0700 (PDT)
Message-ID: <1525333190.4358.20.camel@canonical.com>
Subject: Re: [PATCH][for iio-for-4.17b] iio: humidity: hts221: Fix sensor
 reads after resume
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org
Date: Thu, 03 May 2018 15:39:50 +0800
In-Reply-To: <1525079565.10678.10.camel@canonical.com>
References: <20180430051658.9856-1-shrirang.bagul@canonical.com>
         <CAA2SeNKTjVO7JBVV3qJMJhdM-j=r+igd_nADe+NH3Rux0oW1qA@mail.gmail.com>
         <1525078153.10678.9.camel@canonical.com>
         <CAA2SeNKn6mavKBa8=pU5sPLWpLKY=A5GGnwRZcn65Mhzd-8jqQ@mail.gmail.com>
         <1525079565.10678.10.camel@canonical.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-c+Ka7zQT6+sdJf1I9yR/"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-c+Ka7zQT6+sdJf1I9yR/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-04-30 at 17:12 +0800, Shrirang Bagul wrote:
> On Mon, 2018-04-30 at 11:05 +0200, Lorenzo Bianconi wrote:
> > > On Mon, 2018-04-30 at 09:48 +0200, Lorenzo Bianconi wrote:
> > > > > CTRL1 register (ODR & BDU settings) gets reset after system comes=
 back
> > > > > from suspend, causing subsequent reads from the sensor to fail.
> > > > >=20
> > > > > This patch restores the CTRL1 register after resume.
> > > > >=20
> > > >=20
> > > > Hi Shrirang,
> > > >=20
> > > > is just CTRL1 reset after suspend/resume or also other registers? a=
re
> > > > IIO triggers enabled before the suspend or
> > > > are you reading data from sysfs?
> > > >=20
> > > > > Based on:
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git iio-f=
or-4.17b
> > > > >=20
> > > > > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR rec=
onfiguration)
> > > > > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> > > > > ---
> > > > >  drivers/iio/humidity/hts221_core.c | 13 +++++++------
> > > > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/hum=
idity/hts221_core.c
> > > > > index 166946d4978d..5d7a652aa6d9 100644
> > > > > --- a/drivers/iio/humidity/hts221_core.c
> > > > > +++ b/drivers/iio/humidity/hts221_core.c
> > > > > @@ -658,12 +658,13 @@ static int __maybe_unused hts221_resume(str=
uct device *dev)
> > > > >         struct hts221_hw *hw =3D iio_priv(iio_dev);
> > > > >         int err =3D 0;
> > > > >=20
> > > > > -       if (hw->enabled)
> > > > > -               err =3D regmap_update_bits(hw->regmap, HTS221_REG=
_CNTRL1_ADDR,
> > > > > -                                        HTS221_ENABLE_MASK,
> > > > > -                                        FIELD_PREP(HTS221_ENABLE=
_MASK,
> > > > > -                                                   true));
> > > > > -       return err;
> > > > > +       err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_=
ADDR,
> > > > > +                                HTS221_BDU_MASK,
> > > > > +                                FIELD_PREP(HTS221_BDU_MASK, 1));
> > > > > +       if (err < 0)
> > > > > +               return err;
> > > > > +
> > > > > +       return hts221_update_odr(hw, hw->odr);
> > > > >  }
> > > > >=20
> > >=20
> > > No need to re-enable the sensor here. hts221_read_oneshot() [called f=
rom hts221_read_raw()] does that every time before read:
> > >=20
> >=20
> > Could please try to change other registers (e.g. rh or temp gain) and
> > double check values are properly configured resuming the sensor?
Further testing revealed that the contents of AV_CONF register value gets
overwritten (set to 0x3F) every time system comes out of suspend.
> > It is necessary to re-enable the sensor if you use IIO triggers and
> > the sensor was enabled before the suspend operation
Yes, I understand this is required, will handle this and restoring the AV_C=
ONF
register in the next version.

I've tried using sysfs_trig_iio to test reading the sensor output from devf=
s
(using iio_generic_buffer) but looks like this is not supported in the curr=
ent
driver. HW interrupts cannot be used on my system.
Please suggest if there are other alternatives?
>=20
> Sure. I'll do some more testing and share the results.

> >=20
> > > static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *va=
l)
> > > {
> > >         __le16 data;
> > >         int err;
> > >=20
> > >         err =3D hts221_set_enable(hw, true);
> > >         if (err < 0)
> > >                 return err;
> > >=20
> > >         msleep(50);
> > >=20
> > >         err =3D regmap_bulk_read(hw->regmap, addr, &data, sizeof(data=
));
> > >         if (err < 0)
> > >                 return err;
> > >=20
> > >         hts221_set_enable(hw, false);
> > >=20
> > > Regards,
> > > Shrirang
> > > >=20
> > > > Here you need to re-enable the sensor if it was running before the
> > > > suspend operation.
> > > > Regards,
> > > >=20
> > > > Lorenzo
> > > >=20
> > > > >  const struct dev_pm_ops hts221_pm_ops =3D {
> > > > > --
> > > > > 2.14.1
> > > > >=20
> > > >=20
> > > >=20
> > > >=20
> >=20
> >=20
--=-c+Ka7zQT6+sdJf1I9yR/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJa6rzGAAoJELlj3b/+u+hksngP/jQ5msQyt/47n02QlfJxe3jH
gB0asMb9MS4mgra7QIXPCKO/n6xb2lbbH5z0Izlxy0SLd771CjK9jZjo1jrU7MgE
1f59V/2XbXVpDKxxnAmjQgALAA7UjLPazbiLn1hiznFx8ynTFlWFhOgByMrG+7jH
Xvck1TNhO9l/+uSGPoZa8mylix/8GnikxSp4+89lZGlu0Se0o/qVt0YAR1FiLpnv
arrPaVpMfvf/lPZkOcY32UpS1HjoqZPNW6FJgwNpYcNJhC8qdyL69YlSTFSbOjAJ
4q79aWnjJxvb1RgTfeNggVID9et/wU5tCwRX2sbuFoiL7h4nPbeJxwZfcRJqqpEU
UVpDYxp1blGMgaNfnUxsyNSHoJ6XIiMWgPf1n+s3H+ELalnUe3/PJ1u5grqg9jMP
La15vEsPlo/P/D3Bn2xLB5XE7UZEFqUVi6jPEiY9vxYbvhUiqCYWQkNg0VzTAvaB
QksP7HHcdhESL0B8Z7FtVQXoJ/COqtlXwBsjz43l6+VuCsTmJroKwgR8Gnpr926s
rUza4JCyWZTI0/Fb4p02EfxtacAyT+i3oXY/GFxByO92SGoAnYnWCnSSz8b8pVFR
x/dD+JYRzX1BzFNJdMgcCkO2DyT6ACBTHecmLTik9DErXATsF+buhOn21h/ydENt
tb4OHRZrcX6TpniaoKv8
=J+rd
-----END PGP SIGNATURE-----

--=-c+Ka7zQT6+sdJf1I9yR/--

