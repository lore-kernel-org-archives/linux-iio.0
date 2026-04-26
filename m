Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0474E40DFD3
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777220237; cv=pass; b=I3FpUDJGJ2Jhhs9OCxeWxC6cF+A3H9ShlT5QSH6VFV3ASVxH4LkIHm5rTBEDeWp9Lg1jczj7BL9flrvm1fzTes/+iQE6TnVgwuduIqwFOudJDoUxA8ow0PiplKeaU9yyRTsWSwvQmxcgd465T8Kiv2rKcJR1dNS+X+BzX3yiMTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777220237; c=relaxed/simple;
	bh=OyZJ8Tmv93WX72mDDLKEav/ysSrPtRaDc8gep6KILc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM+oFOSkFWXibObsnFCu27+p3h0pd4IEo8yrq9V4+rtJYrPo5y/A86YQ65b7nVbRo+sBA90jb1VZh48D+uO03U+zfP11Pp+69DKquwSnNIGSEIjqlmvn4w5AAlapId67VglThLrSJzueW1pkkxAP/S5oRe3CUyTyAocXmKTvrF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=URPJIRpw; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="URPJIRpw"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-605a3cff8d0so5722085137.3
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777220233; cv=none;
        d=google.com; s=arc-20240605;
        b=lol+KaXy6t4GZCeKaJoBvzN2FDFR66bjxtfdD/m2vQk7KdSx4pxsuil3YfNjYIYsFy
         m13yoRZupRUeqSR41rVZBva+D1RvnDFkNLQ8AC4kwWbZqp0TBa6tt1hl2c4LcwCA934W
         X9T8Z+1Ocz28Zou/H8hWOu7YY1YUUFqprNM3F9hc5VoEjTktKCay6m0UwfgSEQzlZN56
         oWTsK56YuDRfmbZrlSYML7hlX4likW/078e/MYxL1o7CiaZw1SQdLzCJXqIQJBnOehae
         2pzRA6ViIpQgOIZoeOk7Jpz4Kxaet4/KgblDyxbPddY3alIc67dl7XwPSFShk6rlJVEX
         62NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E2vrqIct0XaUKLFYqcgkDYJ5NIkRLVSCi3ePxAURqNc=;
        fh=yjgwRepli3nfWaN2L/JuRnb6K7YXrAjEBtginUnOkhw=;
        b=cOjgvFF2sUJh7Wkaw99AlyD5e+HyS6sLvhmepvfgn3mvvrW2ONWpCRu/1w01n40SqQ
         d9qilOSLUsjsXvETXWWMrrkRwlZZBmGMpMjdcjH8QymBNnlZUs9mjlsHhQKMWyeHs2MB
         Mq/1iOP/pN36Dywf277hWk7CE450xQnXd55i42xOTE6osd6SByPkoFIC6IM9SsaPhbf2
         9WBVhVV9Ar3aSMm3HqomvV/2KXLpXjDvxApA7RyN0rwRjjjZl4aMSN8D63SzWdQ8GyrZ
         WQQWM+hoXg5zV9f+fz8PPbQmTrJeZTWIIT6ZtjS0thFputZe1eoh8W8iFwiN4WXLGcvh
         wyXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777220233; x=1777825033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2vrqIct0XaUKLFYqcgkDYJ5NIkRLVSCi3ePxAURqNc=;
        b=URPJIRpwYf0ma/U0TmBnStkuXmX+PFSSs1m/mRLsljRF147YGxFFV/AxWOy6gdLI+X
         Gv3oxp+lYe0NJUVDlUYgp8btRaUKtc3Hn29l1ZXjytx1fAHkj5zcy29Diq8DlJ+nr/5x
         MNADBjCDFMzt+U0SerlhQ0gHnRLkyQeha7VvrA9akjWrqHbJDE5UKEIcvGBCNTfoadS0
         jVIvRlKm5FjSiASLT+HURjnwryAuJT8wnZaqFBQAQLT8FY1L8q38gKpjtsMqNfDGxNhl
         ucs/4zivWqcnYrLFG1yfI0JVcORnbrTzY+aDc1BhXbQ8Xg7dZ6D9W2cEbECdO4ZrwuO+
         4nDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777220233; x=1777825033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E2vrqIct0XaUKLFYqcgkDYJ5NIkRLVSCi3ePxAURqNc=;
        b=pQ00BUEDc0qOnKD2TSbd7oKurFeSX+beeDA3dDBMFTHEZe055UfDzokK+MtoDv7SQu
         12XnLt0dEnBhiiGx4l5JFiZXORT63VYu1LHZ3KMEGjVyN7uUsy9YasuJkTEGhVIkQaji
         Z4MkVuKsR+W9ZokwIPwab3XNVq1hOH4+9H0/NptzgkXhqVYkJ3ZI1rd+BdP/FiNIL273
         Nl9J7EpSdzY8AWxeR8qKkJuDxVeQSKPe6p8r/CD6Zusnw54lWsss3rNOxOczj2l/Sdbg
         1KMADdaIyuHL26DaEih6F3MWbQnWIHazaOfl6ep1zQkXcaIZtsZ1p3D82O7Vz4j3FnbB
         FHpg==
X-Forwarded-Encrypted: i=1; AFNElJ9Nkw6GIFpu2ELZL9K/R1yGAr6dsndeAXSS3hFaTj7v92WvYe+wgoHi7KV1BvO+zlThHPNt+l7moNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKdgVV4UYPfYABQIFNr5MEwvvfqbgZyX1mZUS9hZE9cAw5qydL
	HTQaXJpJXs/LR9Z7ZOJPY5qLYn8UbrLyjJmtjODGhnLPMjkuc+/Dw26Ox1vRu8aOxHi19cRQFxU
	5Mkf9mj23dT/eZjjy59mzQNQ/EJQ8k5Y4LcC/Lgnqsg==
X-Gm-Gg: AeBDiesrqg4+wCF6Ot1UY4a5/7IdKBqN6dF6htnvSSxi/hrex0qt/H57HxaJs17T9iF
	waOW/wm8HWogQxV4kCOAd7PqqUJIlXKlDgn7EBG6PkTsVbqmFD5qtUci2L1s6obAfn8IFRI3m0k
	2US8REG7v+pa47SMVr9CnNWZOTBMqZU289BMh7g5j//CTJRh2ZhozA2USKNp+QZ3M8PlEjnJeFx
	rDDl73HS05CwsUJZ5voaXFWLJHE8bmkZGwsYoNszaC2zsdB4XFRfGtDuK+dO1pWKoSI49xj5l0J
	eAG+WcLPecnh9KMnUGh6TZsJy9UNWUS+dyOHXJA4cKjpJboFVw==
X-Received: by 2002:a05:6102:c47:b0:602:ba51:5235 with SMTP id
 ada2fe7eead31-616f7c4b540mr20092296137.29.1777220232660; Sun, 26 Apr 2026
 09:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421040313.21029-1-pedro.pbg@usp.br> <20260421105834.0d6ebd98@jic23-huawei>
In-Reply-To: <20260421105834.0d6ebd98@jic23-huawei>
From: Pedro Barletta Gennari <pedro.pbg@usp.br>
Date: Sun, 26 Apr 2026 13:17:01 -0300
X-Gm-Features: AVHnY4J4ExpmBeLMMd0oNE1YQEb5mWH98oi7fFAq70Ul9ncA72lm0ma5wKZtGeg
Message-ID: <CAN+tGO-pX-BkZNiSsTjwk4ZWWBoiDSq43G=K1a1ba0nJLUAk2w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: iqs621-als: use lock guards
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 6:58=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 21 Apr 2026 01:00:11 -0300
> Pedro Barletta Gennari <pedro.pbg@usp.br> wrote:
>
> > Use guard(mutex)() for handling mutex lock instead of
> > manually locking and unlocking the mutex. This prevents forgotten
> > locks due to early exits and remove the need of gotos.
> >
> > Signed-off-by: Pedro Barletta Gennari <pedro.pbg@usp.br>
> > ---
> > v2:
> >   - Keep include list ordered
> >   - Remove redundant 'else'
> >   - Remove unnecessary variable 'ret'
> Hi Pedro,
>
> The changes here enable a few additional code improvements that
> I'd like to see made in the same patch.
>
> See below,
>
> Thanks,
>
> Jonathan
>

Hi Jonathan,

Just to be sure, do you want everything to be in the same commit?

> > @@ -107,25 +108,21 @@ static int iqs621_als_notifier(struct notifier_bl=
ock *notifier,
> >       indio_dev =3D iqs621_als->indio_dev;
> >       timestamp =3D iio_get_time_ns(indio_dev);
> >
> > -     mutex_lock(&iqs621_als->lock);
> > +     guard(mutex)(&iqs621_als->lock);
> >
> >       if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> >               ret =3D iqs621_als_init(iqs621_als);
> >               if (ret) {
> >                       dev_err(indio_dev->dev.parent,
> >                               "Failed to re-initialize device: %d\n", r=
et);
> > -                     ret =3D NOTIFY_BAD;
> > -             } else {
> > -                     ret =3D NOTIFY_OK;
> > +                     return NOTIFY_BAD;
> >               }
> > -
> > -             goto err_mutex;
> > +             return NOTIFY_OK;
> >       }
> >
> >       if (!iqs621_als->light_en && !iqs621_als->range_en &&
> >           !iqs621_als->prox_en) {
>         if (!iqs621_als->light_en && !iqs621_als->range_en && !iqs621_als=
->prox_en)
>
> After change noted below, I'd just make this a slightly long single line.
> We have gotten more relaxed on going a little over 80 chars since this
> code was written.
>
> > -             ret =3D NOTIFY_DONE;
> > -             goto err_mutex;
> > +             return NOTIFY_DONE;
> >       }
>
> Single statement so { } not needed
>

Ok!

> > @@ -293,7 +277,7 @@ static int iqs621_als_write_event_config(struct iio=
_dev *indio_dev,
> >                                                                        =
0xFF);
> >               if (!ret)
> >                       iqs621_als->light_en =3D state;
> > -             break;
> > +             return ret;
> Same as two cases below
> >
> >       case IIO_INTENSITY:
> >               ret =3D regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EV=
ENT_MASK,
> > @@ -302,12 +286,12 @@ static int iqs621_als_write_event_config(struct i=
io_dev *indio_dev,
> >                                                                        =
0xFF);
> >               if (!ret)
> >                       iqs621_als->range_en =3D state;
> > -             break;
> > +             return ret;
> As below, flip this to
>                 if (ret)
>                         return ret;
>
>                 iqs621_als->range_en =3D state;
>
>                 return 0;
>
> >
> >       case IIO_PROXIMITY:
> >               ret =3D regmap_read(iqs62x->regmap, IQS622_IR_FLAGS, &val=
);
> >               if (ret)
> > -                     goto err_mutex;
> > +                     return ret;
> >               iqs621_als->ir_flags =3D val;
> >
> >               ret =3D regmap_update_bits(iqs62x->regmap, IQS620_GLBL_EV=
ENT_MASK,
> > @@ -315,16 +299,11 @@ static int iqs621_als_write_event_config(struct i=
io_dev *indio_dev,
> >                                        state ? 0 : 0xFF);
> >               if (!ret)
> >                       iqs621_als->prox_en =3D state;
>
> Please flip this to the more common form. Makes reading the code a little=
 easier
> if errors are handled out of line as early as possible.
>
>                 if (ret)
>                         return ret;
>
>                 iqs621_als->prox_en =3D state;
>
>                 return 0;
>

Ok!

> >  static int iqs621_als_write_event_value(struct iio_dev *indio_dev,
> > @@ -377,7 +351,7 @@ static int iqs621_als_write_event_value(struct iio_=
dev *indio_dev,
> >       u8 ir_flags_mask, *thresh_cache;
> >       int ret =3D -EINVAL;
>
> Drop this initialization and instead return the specific value on error p=
aths.
>

Ok!

> > @@ -426,29 +400,26 @@ static int iqs621_als_write_event_value(struct ii=
o_dev *indio_dev,
> >                       break;
> >
> >               default:
> > -                     goto err_mutex;
> > +                     return ret;
> >               }
> >
> >               thresh_cache =3D &iqs621_als->thresh_prox;
> >               break;
> >
> >       default:
> > -             goto err_mutex;
> > +             return ret;
>
> return -EINVAL;
>
> >       }
> >
> >       if (thresh_val > 0xFF)
> > -             goto err_mutex;
> > +             return ret;
>
> return -EINVAL;
>
> >
> >       ret =3D regmap_write(iqs62x->regmap, thresh_reg, thresh_val);
> >       if (ret)
> > -             goto err_mutex;
> > +             return ret;
> >
> >       *thresh_cache =3D thresh_val;
> >       iqs621_als->ir_flags_mask =3D ir_flags_mask;
> >
> > -err_mutex:
> > -     mutex_unlock(&iqs621_als->lock);
> > -
> >       return ret;
> >  }
> >
>

In this case, should this last return be "return 0;"?

--
Thanks,

Pedro
