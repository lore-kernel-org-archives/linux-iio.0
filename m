Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38511 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeGAEhf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Jul 2018 00:37:35 -0400
Received: from mail-pl0-f72.google.com ([209.85.160.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <shrirang.bagul@canonical.com>)
        id 1fZU7C-0002iZ-4Z
        for linux-iio@vger.kernel.org; Sun, 01 Jul 2018 04:37:34 +0000
Received: by mail-pl0-f72.google.com with SMTP id q19-v6so7602960plr.22
        for <linux-iio@vger.kernel.org>; Sat, 30 Jun 2018 21:37:34 -0700 (PDT)
Message-ID: <c40514afedc946d812c0e562690fd6008e926b64.camel@canonical.com>
Subject: Re: [PATCH v2] iio: humidity: hts221: Fix sensor reads after resume
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.tesi@st.com, marco.bianco@st.com, armando.visconti@st.com
Date: Sun, 01 Jul 2018 12:37:24 +0800
In-Reply-To: <20180628090525.GA2540@localhost.localdomain>
References: <20180628082215.12023-1-shrirang.bagul@canonical.com>
         <20180628090525.GA2540@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-WTopwzHbvRMfViG7NwGy"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--=-WTopwzHbvRMfViG7NwGy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-06-28 at 11:05 +0200, Lorenzo Bianconi wrote:
> > AV_CONF register (RH & TEMP. oversampling ratio's) and CTRL1 register
> > (ODR & BDU settings) values are lost after suspend.
> >=20
> > While the change in AV_CONF updates the sensor resolution modes
> > (overriding the user configuration before the device went to suspend);
> > loss of the contents of the CTRL1 register leads to failure in reading
> > sensor output.
> >=20
> > This patch restores the AV_CONF & CTRL1 registers after resume.
> >=20
>=20
> Hi Shrirang,
>=20
> I still suspect we have some hw issue (IoT Gateway) here (cc ST folks
> to get more info) and anyway I guess the proposed patch will fix the issu=
e
> completely since OD and HL configuration is not restored properly.
> Could you please double check HL/OD regs are properly preserved after res=
ume
> phase?
Yes, certainly. Will include the i2c register dumps before and after the re=
sume to support
the patch.

Regards,
Shrirang
>=20
> Regards,
> Lorenzo
>=20
> > Changes from v1:
> > - Don't drop enabling the sensor during resume
> > - Restore AV_CONF register along with CTRL1
> >   (As demonstrated with i2c register dumps of hts221 captured on Dell
> >   IoT Gateways 300x before suspend & after resume [1])
> >=20
> > Fixes: ffebe74b7c95 (iio: humidity: hts221: avoid useless ODR reconfigu=
ration)
> > Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
> >=20
> > [v1] https://marc.info/?l=3Dlinux-iio&m=3D152506543000442&w=3D2
> > [1] https://marc.info/?l=3Dlinux-iio&m=3D152534455701742&w=3D2
> >=20
> > This patch is based on:
> > git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git -b testing
> > ---
> >  drivers/iio/humidity/hts221_core.c | 31 +++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/=
hts221_core.c
> > index 166946d4978d..fc5599497f55 100644
> > --- a/drivers/iio/humidity/hts221_core.c
> > +++ b/drivers/iio/humidity/hts221_core.c
> > @@ -656,14 +656,43 @@ static int __maybe_unused hts221_resume(struct de=
vice *dev)
> >  {
> >  	struct iio_dev *iio_dev =3D dev_get_drvdata(dev);
> >  	struct hts221_hw *hw =3D iio_priv(iio_dev);
> > +	const struct hts221_avg *avg;
> > +	u8 data, idx;
> >  	int err =3D 0;
> > =20
> > +	/* Restore contents of AV_CONF (RH & TEMP. oversampling ratio's) */
> > +	avg =3D &hts221_avg_list[HTS221_SENSOR_H];
> > +	idx =3D hw->sensors[HTS221_SENSOR_H].cur_avg_idx;
> > +	data =3D avg->avg_avl[idx];
> > +	err =3D hts221_update_avg(hw, HTS221_SENSOR_H, data);
> > +	if (err < 0)
> > +		goto fail_err;
> > +
> > +	avg =3D &hts221_avg_list[HTS221_SENSOR_T];
> > +	idx =3D hw->sensors[HTS221_SENSOR_T].cur_avg_idx;
> > +	data =3D avg->avg_avl[idx];
> > +	err =3D hts221_update_avg(hw, HTS221_SENSOR_T, data);
> > +	if (err < 0)
> > +		goto fail_err;
>=20
> just return err, no need for goto statement
Okay.
>=20
> > +
> > +	/* Restore contents of CTRL1 (BDU & ODR) */
> > +	err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> > +				 HTS221_BDU_MASK,
> > +				 FIELD_PREP(HTS221_BDU_MASK, 1));
> > +	if (err < 0)
> > +		goto fail_err;
> > +
> > +	err =3D hts221_update_odr(hw, hw->odr);
> > +	if (err < 0)
> > +		goto fail_err;
> > +
>=20
> just return err, no need for goto statement
Okay.
>=20
> >  	if (hw->enabled)
> >  		err =3D regmap_update_bits(hw->regmap, HTS221_REG_CNTRL1_ADDR,
> >  					 HTS221_ENABLE_MASK,
> >  					 FIELD_PREP(HTS221_ENABLE_MASK,
> >  						    true));
> > -	return err;
> > +fail_err:
> > +	return err < 0 ? err : 0;
> >  }
> > =20
> >  const struct dev_pm_ops hts221_pm_ops =3D {
> > --=20
> > 2.17.1
> >=20
--=-WTopwzHbvRMfViG7NwGy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4dy8MKREQ2noAlYwuWPdv/676GQFAls4WoQACgkQuWPdv/67
6GSa2w//TPaOHq5rAQ1VbchrMxI85BcSYW/tXNErqR+catFFJB79p60+StUjxysL
vOatiK8DapxGAWbeETqcvPxjsrEo6K83JqhCbfx98495nOtpdPxI7BvKurXqzWsP
PIbiywyYLfWvLuVaRw/IokpPBpqZX7YNHviSLDS9/W+mOwxFqYFhsKxGOPUjOrR9
XUL+FMKMRgk+aeq0jeFxYXP9NyfEoTSGm6nw2HQQghfth5RURRK+CJAs8re5OFET
JOvfiNsCQDsrOwRvhRQTqIG2nybBhNttmoSEb2HueXBUD3xmf/M7AUZ48srVYFdx
hGO6Q6vQ0WUFqUihKBb8E7mgv9lhoJLdMSHnCWiiD6xUjOvZmpBlc7WDnrH2I6E0
gJKGjnJbLxyTbC2V0mkzBnKl+tFhfdkMSgZywXZuBHva7Kk1H3Jjprk++06WNh5u
8i72phTAwOld/LgBhK2T50ZEgUp623HqPbuWK+sXvA2Adxs9I3sR32zrTBjPpcne
cxN8WOYxs5tXse+Cm+TDVEB9r0Tz25/mXZR0wv1A+HobOnb8tB5VPkeFLs9NvT/8
qaACNnzmKUY1+Fl0LwdErigU50QfhNOpQuOYbPYvmHSVnQAPvpWtU4nus2tVfalY
kstjpIiTDiog9waXvziG+4osK9c5L5M8cVbaCZqD2fi1CXUui9w=
=XTyJ
-----END PGP SIGNATURE-----

--=-WTopwzHbvRMfViG7NwGy--

