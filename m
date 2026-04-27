Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784F3B27E9
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283471; cv=none; b=uqC5DIdFaVqISGLtzxfhx2vhvzJnePyNQfBSZQqSCikrXkJYAnhTPVOGXMVIrVpHbBCOEQY9MR1euD7ZxWE/0rJn4cFieNonJOcq1BZuBRn+bM4SqCrL8NyDfLFC9w6lqINaN2dCXSRzuz2500ie+LKwIHBp5Cg9QZTbvaiCi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283471; c=relaxed/simple;
	bh=OJSPsV0dvuyft6uHfDxob6ahl7TQD8wuI/d0qAXaFMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9bebXVOeW8pC15Pejdfo9A9l6RXeifNNyhTBjZM9Oo6l7hkPEjmMUFusnt4warXN1rWNDm5848xQFZwHVLx5TbH1dT5b1RJLE9uXCJy7bQ+nwjQ3UdByZXm9/tP0JFaXZkQq3bl1aVcFiqycAUVbUFXgTI9UENtCDCahy30dIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0Ml86AL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0Ml86AL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BC5C19425;
	Mon, 27 Apr 2026 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777283471;
	bh=OJSPsV0dvuyft6uHfDxob6ahl7TQD8wuI/d0qAXaFMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P0Ml86ALNAgwV/gR337XxVPl168m9vnXAYyFWVfooLeGMKxjdnl7buN/IZ5ZiLBhk
	 Z+hZCBhiBYtbsoeug4TbHmGTnsnBnynNBUup6PE/2imPsZ03iNHgmE6V/iDRxvcEkr
	 G4dJT1suvqbKrSp7zEJJCGDN3zjz0L0JSaqxv0UCIWyB52MitImU7COtm1xRTcvuR+
	 BkCKoF5Vp954jD6QDwsylQFEH0rPWoyXeHsWVIXo7wPTMfljw/AnU32vR9+ZTVGo44
	 NsX4VCB35hRHzz2KT2ox0kGPrpobpBfXXA6FvQ3zIruHT1MzQIOy9hwBezhWJWPm72
	 jvhJkJiosJKxA==
Date: Mon, 27 Apr 2026 10:51:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pedro Barletta Gennari <pedro.pbg@usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: iqs621-als: use lock guards
Message-ID: <20260427105102.6e5a92a9@jic23-huawei>
In-Reply-To: <CAN+tGO-pX-BkZNiSsTjwk4ZWWBoiDSq43G=K1a1ba0nJLUAk2w@mail.gmail.com>
References: <20260421040313.21029-1-pedro.pbg@usp.br>
	<20260421105834.0d6ebd98@jic23-huawei>
	<CAN+tGO-pX-BkZNiSsTjwk4ZWWBoiDSq43G=K1a1ba0nJLUAk2w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Apr 2026 13:17:01 -0300
Pedro Barletta Gennari <pedro.pbg@usp.br> wrote:

> On Tue, Apr 21, 2026 at 6:58=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Tue, 21 Apr 2026 01:00:11 -0300
> > Pedro Barletta Gennari <pedro.pbg@usp.br> wrote:
> > =20
> > > Use guard(mutex)() for handling mutex lock instead of
> > > manually locking and unlocking the mutex. This prevents forgotten
> > > locks due to early exits and remove the need of gotos.
> > >
> > > Signed-off-by: Pedro Barletta Gennari <pedro.pbg@usp.br>
> > > ---
> > > v2:
> > >   - Keep include list ordered
> > >   - Remove redundant 'else'
> > >   - Remove unnecessary variable 'ret' =20
> > Hi Pedro,
> >
> > The changes here enable a few additional code improvements that
> > I'd like to see made in the same patch.
> >
> > See below,
> >
> > Thanks,
> >
> > Jonathan
> > =20
>=20
> Hi Jonathan,
>=20
> Just to be sure, do you want everything to be in the same commit?

The places where I'm asking you to flip if (!ret) to if (ret)
logic should be a second patch.  Do them in which ever order
makes for cleanest series.

I've commented more on individual changes below.


>=20
> > > @@ -107,25 +108,21 @@ static int iqs621_als_notifier(struct notifier_=
block *notifier,
> > >       indio_dev =3D iqs621_als->indio_dev;
> > >       timestamp =3D iio_get_time_ns(indio_dev);
> > >
> > > -     mutex_lock(&iqs621_als->lock);
> > > +     guard(mutex)(&iqs621_als->lock);
> > >
> > >       if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> > >               ret =3D iqs621_als_init(iqs621_als);
> > >               if (ret) {
> > >                       dev_err(indio_dev->dev.parent,
> > >                               "Failed to re-initialize device: %d\n",=
 ret);
> > > -                     ret =3D NOTIFY_BAD;
> > > -             } else {
> > > -                     ret =3D NOTIFY_OK;
> > > +                     return NOTIFY_BAD;
> > >               }
> > > -
> > > -             goto err_mutex;
> > > +             return NOTIFY_OK;
> > >       }
> > >
> > >       if (!iqs621_als->light_en && !iqs621_als->range_en &&
> > >           !iqs621_als->prox_en) { =20
> >         if (!iqs621_als->light_en && !iqs621_als->range_en && !iqs621_a=
ls->prox_en)
> >
> > After change noted below, I'd just make this a slightly long single lin=
e.
> > We have gotten more relaxed on going a little over 80 chars since this
> > code was written.

This one is fine rolled into the guard() patch as you'll be changing it any=
way
to drop the {

> > =20
> > > -             ret =3D NOTIFY_DONE;
> > > -             goto err_mutex;
> > > +             return NOTIFY_DONE;
> > >       } =20
> >
> > Single statement so { } not needed
> > =20
>=20
> Ok!
>=20
> > > @@ -293,7 +277,7 @@ static int iqs621_als_write_event_config(struct i=
io_dev *indio_dev,
> > >                                                                      =
  0xFF);
> > >               if (!ret)
> > >                       iqs621_als->light_en =3D state;
> > > -             break;
> > > +             return ret; =20
> > Same as two cases below =20
> > >
> > >       case IIO_INTENSITY:
> > >               ret =3D regmap_update_bits(iqs62x->regmap, IQS620_GLBL_=
EVENT_MASK,
> > > @@ -302,12 +286,12 @@ static int iqs621_als_write_event_config(struct=
 iio_dev *indio_dev,
> > >                                                                      =
  0xFF);
> > >               if (!ret)
> > >                       iqs621_als->range_en =3D state;
> > > -             break;
> > > +             return ret; =20
> > As below, flip this to
> >                 if (ret)
> >                         return ret;
> >
> >                 iqs621_als->range_en =3D state;

This ideally in a different patch.

> >
> >                 return 0;
> > =20
> > >
> > >       case IIO_PROXIMITY:
> > >               ret =3D regmap_read(iqs62x->regmap, IQS622_IR_FLAGS, &v=
al);
> > >               if (ret)
> > > -                     goto err_mutex;
> > > +                     return ret;
> > >               iqs621_als->ir_flags =3D val;
> > >
> > >               ret =3D regmap_update_bits(iqs62x->regmap, IQS620_GLBL_=
EVENT_MASK,
> > > @@ -315,16 +299,11 @@ static int iqs621_als_write_event_config(struct=
 iio_dev *indio_dev,
> > >                                        state ? 0 : 0xFF);
> > >               if (!ret)
> > >                       iqs621_als->prox_en =3D state; =20
> >
> > Please flip this to the more common form. Makes reading the code a litt=
le easier
> > if errors are handled out of line as early as possible.
> >
> >                 if (ret)
> >                         return ret;
> >
> >                 iqs621_als->prox_en =3D state;
> >
> >                 return 0;
> > =20
>=20
> Ok!
>=20
> > >  static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
> > > @@ -377,7 +351,7 @@ static int iqs621_als_write_event_value(struct ii=
o_dev *indio_dev,
> > >       u8 ir_flags_mask, *thresh_cache;
> > >       int ret =3D -EINVAL; =20
> >
> > Drop this initialization and instead return the specific value on error=
 paths.
> > =20
>=20
> Ok!
>=20
> > > @@ -426,29 +400,26 @@ static int iqs621_als_write_event_value(struct =
iio_dev *indio_dev,
> > >                       break;
> > >
> > >               default:
> > > -                     goto err_mutex;
> > > +                     return ret;
> > >               }
> > >
> > >               thresh_cache =3D &iqs621_als->thresh_prox;
> > >               break;
> > >
> > >       default:
> > > -             goto err_mutex;
> > > +             return ret; =20
> >
> > return -EINVAL;
> > =20
> > >       }
> > >
> > >       if (thresh_val > 0xFF)
> > > -             goto err_mutex;
> > > +             return ret; =20
> >
> > return -EINVAL;
> > =20
> > >
> > >       ret =3D regmap_write(iqs62x->regmap, thresh_reg, thresh_val);
> > >       if (ret)
> > > -             goto err_mutex;
> > > +             return ret;
> > >
> > >       *thresh_cache =3D thresh_val;
> > >       iqs621_als->ir_flags_mask =3D ir_flags_mask;
> > >
> > > -err_mutex:
> > > -     mutex_unlock(&iqs621_als->lock);
> > > -
> > >       return ret;
> > >  }
> > > =20
> > =20
>=20
> In this case, should this last return be "return 0;"?

Yes.

>=20
> --
> Thanks,
>=20
> Pedro

