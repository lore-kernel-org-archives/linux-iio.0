Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A06330301
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268559; cv=pass; b=TzkaL7LzQzjtS67wBpQtg59ngw+gneDIxprurQ/5ObY4vbT7wbG8WB9NL10n0Xot5UwDohnW+PIy3GvZ3tQli3JycDLJX+VzIGEySXhNKG4laEQrMdJknvgOiwb2aNYW7/bLQE7g87BA7rPWUY8v+P2s4HWpITt2VjO0b3NT66E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268559; c=relaxed/simple;
	bh=5vEl7rEPdJTFVmLfF07NHC5wR9rgIR84jjWBbsemezk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uq/VFK6FJQ6lFdq5UzrOdWN56QExtPkdvWo8Y+Is/P1wFFhh7O+MftxIwkSiiLd8o6nXKYJ+/UGaNKqtGUNbMeaiPefLpxBk2zMLAkbRiEQHH+hyqrECHWvUCqKrrZYEjh3QudkQXTwXusg9oTC89CTK9XEUVf3jTLpEBd0B47w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWd+WjEX; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWd+WjEX"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a3e2e64f4so626317b3.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 05:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774268557; cv=none;
        d=google.com; s=arc-20240605;
        b=Vj0ObdKH0ceAPG1rrptpAM/ligyup9gkmyGFJ9tedPMnqmZeCz4nncN1sywk7YLboi
         zbmSznCdc/l9Zis8NPItPn9f5cWksRBadYTJNgpg3n2jjzmqSs9rRTqW9xHCV9XS3qS9
         dxkcR3OG1etLT7jexVTmAJbURQtv6ehxyuzplc2tMBiJBcnauwObZ3cPHkELlMH493/Z
         B4NlgT55Y5CdfgIMybry9QsjfILYEv5/5Y2r2pT/yk3evublGg64vQNXJTHtdJYkecOO
         lj1+2EV1UWyZe77QJl5jl3eqW4vI1Ktbcv/342tNZSVfhH6DSFvhHBJ7VYN7h+q91hEs
         g8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I87yG6R3rMiJQKakv77MaKgjNhD1r5kVSJz2kpVoVvA=;
        fh=wIZIDX09y1ntJb/fQSqR9CFtsSXoE3TS2xkmuoRgTws=;
        b=g2q5KdnI8RsM6ePQhUTSUJ7J2zaSaf/REw9v9zdH8t9stzr0c1EYFh8VlTDm4bpN6w
         xnEoc0mT6DRrHoNpbrDDnCitNZaSafAkOAOkTAX5HLdf2mKeiSnMnL0LsiUtXvc/Rrdd
         JVpLiAUdI7VvpiCuS/uLY60s5dp/jIhIZKAnqHVhJ5wqB7W5SFiABNXg+Q0axQ8JS/i6
         MeT7WO+2vvWMzjJJHGizXjkAkkNyJLyID2ZocUNNybi25cHX1cqZ2H+cE0JGNUwiehNg
         380b26HS9q4lcoLP4Go4XeOBCjZ/VIJHuvHqI4Y+Q7+fpQqI2rxQLH0qqjjEGPgdmD1S
         2eZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774268557; x=1774873357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I87yG6R3rMiJQKakv77MaKgjNhD1r5kVSJz2kpVoVvA=;
        b=NWd+WjEXCl1AO96/Xx3n45YUKKOj8e2YEnWULTgR61D9tqnVtnUZJhdlHAnpWjHjy8
         8zhg2g8B1+/z7WWSTduzZPVK4W7ixZbqHhmBsWltsnEQ9eBkveKGo1Z3VHtwtQVA3qQU
         twbAHC8bLG4q4Pfe6d7B2rz/zinPazCQfSBCsvdMN+BCztN9kBdPgQCVVCYpdmaq4jau
         7U6azcWR8xXUdtmVhzJf9Hma75D4TAAbmBGNW0fiR4KyMCzeHehxs32g6HekUN71m4ii
         DdKcabL2EiMjY/WztLYXKRa9NNsxE9xZM5YkCVI0sVDYYwKk6uWa7vrEv0ryNWNdVNpP
         g+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774268557; x=1774873357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I87yG6R3rMiJQKakv77MaKgjNhD1r5kVSJz2kpVoVvA=;
        b=nLvEMLx09Y75Bl/niRqqr4tGxL+lk0vQMFl9jMBdsETi3SFKOU8M+J94w0ZNSRv+xl
         7dGlI3zPJchtD5NqAxkCnr3QvNE/tVcG9YuRhRRIDVuIcnCmPcOr8cuJPoFpOnrRlVMc
         Aurv5vfWcGDtY2u8//Vr79WIMmunUiHAK2JeVwnsZACiDHsZbmNhpOM9Hnowd6Q6PY0H
         j+0/3d+fvaiXOiAgj9ge/AZnJOwmT9n7ZSxzrzPbeWWyuvIG1U93ViQZfBtXJ36wkAEP
         MPsCQ3dak4K6ZPNfL3SMk4WKOMVBCaojc11Cpdvvbmy+6G5jpGVU2ejED0k18jHBjtxO
         YB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnhlxpMq+F/Phuy7Ql0/spbdDFlDxybYDfukd2atmRyiKbwDl042SXCqAF6py6DtWXh2Uvnwa9bRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1G0ysNG7PWYqGsFYzoB7zpJZWZYSSEYf48xYdckwvXcFgGXdC
	VSheyFYEvYQTo0+9VM/ilJH2rBo9CuGQOI9kvplEZOLON7w+D3brun8jueoj3Fie11szQdBjl1f
	d4JgDu67EJo01WIvE31OZj93kYsrKJ9k=
X-Gm-Gg: ATEYQzxDPqbbadNc1Qj1c9ndOOLqWehbrCWcaS8215SkLX6K+zWuGcXBdiRFdV3zwpZ
	mujovDzY6W6e7BbhKnoj7C/omr1lPRanYiJOY4TMZJz5Q7hmdsUQDGeA28sylvkNnji6y5JqzHa
	DAiSqkMvXO3FkV2j6H9viXm0PpFzcU3Zc3oFfGdqOWnjvGCzLhJ4bytRk5Hr5BtSx2g6X3icn3E
	aOEL9YSrTtdJ8WfVRAe7I7xt09NsagqLlOy/PzhuyMkSjPBucMjGhECcsbcQNcbSZDJAZ0o0+VC
	rcj9JD4nhi5HSAGRcH2/51V4PV3zTP7wuzJxTwNNfs1W7hYA5e64kFHx4GA2peIHx8Znw43YRA=
	=
X-Received: by 2002:a05:690c:48c1:b0:79a:3edf:a049 with SMTP id
 00721157ae682-79a90aeb03dmr123603607b3.24.1774268557032; Mon, 23 Mar 2026
 05:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318092715.42538-1-architanant5@gmail.com>
 <20260318092715.42538-4-architanant5@gmail.com> <20260321182710.1621d1aa@jic23-huawei>
In-Reply-To: <20260321182710.1621d1aa@jic23-huawei>
From: Archit Anant <architanant5@gmail.com>
Date: Mon, 23 Mar 2026 17:52:25 +0530
X-Gm-Features: AaiRm51Rot4baxif9O-Ehoe91d1_ioEF6O3LhNGXIxm4TboBtdFdoMeAHUSo0ns
Message-ID: <CADJHxWADo9rA8vt6EEVLXSBb9EqXvyBg=L_YmusaMdtRnOr0rQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] iio: adc: ad799x: cache regulator voltages during probe
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 11:57=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Wed, 18 Mar 2026 14:57:14 +0530
> Archit Anant <architanant5@gmail.com> wrote:
>
> > Reading the regulator voltage via regulator_get_voltage() can be a slow
> > operation.
>
> Whilst that might be true, it isn't a reason for this change.
> Sysfs reads that would cause it to be read are never a particularly
> fast path anyway. So drop this first sentence.
>
> > Since the reference voltages for this ADC are not expected to
> > change at runtime, it is inefficient to query the regulator API every
> > time userspace reads the IIO_CHAN_INFO_SCALE attribute.
> >
> > Determine the active reference voltage (either VREF or VCC) during
> > probe() and cache it in the state structure. This improves the
> > performance of ad799x_read_raw() and removes the dependency on the
> > regulator pointers during fast-path reads.
> >
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Suggested-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Archit Anant <architanant5@gmail.com>
>
> A suggested alternative approach inline.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/ad799x.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> > index 7504bcf627da..ae2ad4bd37cc 100644
> > --- a/drivers/iio/adc/ad799x.c
> > +++ b/drivers/iio/adc/ad799x.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/bitops.h>
> > +#include <linux/units.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -135,6 +136,9 @@ struct ad799x_state {
> >       u16                             config;
> >
> >       unsigned int                    transfer_size;
> > +
> > +     int                             vref_uV;
> > +
> >       IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
> >  };
> >
> > @@ -302,14 +306,7 @@ static int ad799x_read_raw(struct iio_dev *indio_d=
ev,
> >                       GENMASK(chan->scan_type.realbits - 1, 0);
> >               return IIO_VAL_INT;
> >       case IIO_CHAN_INFO_SCALE:
> > -             if (st->vref)
> > -                     ret =3D regulator_get_voltage(st->vref);
> > -             else
> > -                     ret =3D regulator_get_voltage(st->reg);
> > -
> > -             if (ret < 0)
> > -                     return ret;
> > -             *val =3D ret / 1000;
> > +             *val =3D st->vref_uV / MILLI;
> >               *val2 =3D chan->scan_type.realbits;
> >               return IIO_VAL_FRACTIONAL_LOG2;
> >       }
> > @@ -828,9 +825,20 @@ static int ad799x_probe(struct i2c_client *client)
> >                       ret =3D regulator_enable(st->vref);
> >                       if (ret)
> >                               goto error_disable_reg;
> > +                     ret =3D regulator_get_voltage(st->vref);
>
> For vref I don't think we need to keep the regulator around, so you shoul=
d
> be able to use devm_regulator_get_enable_read_voltage() with checking
> for -ENODEV to identify it simply isn't there.
>
> It would need a tiny bit of reordering though or a custom
> devm_add_action_or_reset() registered callback to ensure that regulator
> disable for vcc happens in reverse sequence of what happens on setup.
>
> Anyone think there are actually ordering constraints on these regulators?
> Would be fairly unusual for this sort of device, but not impossible.
> If not, cleanest option might be;
...
> Then no need to undo anything by hand in remove() and no need to keep
> a pointer to any regulators around for later.

I completely agree that devm_regulator_get_enable_read_voltage() is
the cleanest approach.

However, as I noted briefly in the v5 changelog (which I should have
highlighted better), the driver currently relies on those regulator
pointers (st->reg and st->vref) in the ad799x_suspend() and
ad799x_resume() callbacks.

If we drop the pointers from the state structure, we lose the ability
to disable the regulators during system sleep.

If keeping power management active during suspend is still desired for
this driver, I believe we are forced to keep the pointers and use the
devm_add_action_or_reset() pattern.

If you prefer, I can drop the manual regulator control from the PM
callbacks entirely (or drop the PM callbacks altogether), which would
allow us to use the cleaner devm_regulator_get_enable_read_voltage()
helper.

Let me know which path you prefer for v6!

--=20
Sincerely,
Archit Anant
