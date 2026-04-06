Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E2C2571DD
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494880; cv=pass; b=TN4RUcqb5lAr+wwWKUL457ZmYTP6zz/QTGT8iWxgt4cbg3PTgiwNUTTIW01sJj8lcaWZf6ywkL+Nsg+rBwxRFmTIvgWSbMMTwBzW1Rose/RS4DZB1I0c+632CVG/98BQAMTI8I8YwB3+uI6yer300XA3Phs/LpCrxXWpK86NLYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494880; c=relaxed/simple;
	bh=KYain5n51WVz+9dmbz8kQsqUoXpYIFXpQAUWD+CtlhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4TY99Q9oFMTQ6+zzyaaKFClk+1Vg22bzbbtKCh/0qkHiA4TWboYMIYIYxrxxij7hgAbvVVbKzJ56zHquQFCAthF0LJMeGx178mbnofEys/lm7cd2dCcvja05C4nlIFP3sBAENRivHM/BPJFgYVUpAaN0MB3yX9lylbS13B3XkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly0zfezS; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly0zfezS"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ee5037d44so54333327b3.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 10:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775494878; cv=none;
        d=google.com; s=arc-20240605;
        b=hB8HNkuYJfYpFhjk1dd4BLZIewqA2x+/Vxv923IrdPzrizAVWJX//uap+/E6Vfzz/5
         yJ55ZrBLNUGkZDpxbQa+sl87sdMR8c5fRRAFM7/nFlolNseQZSPb6K6xxU3WQNB+1/Sw
         2D3jC5XErZSs5vo0u8V3OkvqIdOgT5+1Ka0lt8zBN1jdDYjIBO2gGt1zaw+C8k50M5Gt
         wxqhlBxnzxUrMcjpjpZ80xfW+xA/+y3D/9RzwgNyOsC4Ux4UcefEMun5szll0JAeHmIQ
         TXoNcgZT7vZOfeUzJoHl+CAvdGBwedVW0bCpJ11r5pXMB493TQlgRR/T5K8W92DIpyta
         rvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C8x8zPwwWVSdrqqZcYHZ0g0tOazzrPlGdl2Esxf9Ke0=;
        fh=gR/OPbTGrU3g+eM2xPGny/TUmutYTeFs6g6TGQUneZA=;
        b=WVrgskV2RSl+yLS4Kh0wzfxE62V1NyI3uAF3m9sGIYeGaTZqggZpY1T6LMNJGgEGCM
         /ixcTOPY+/SJatUqXMwAiK3cAaafUIEHDS5j2YIDN3NkTRlg7H1DSyD8SED6b5bvNBMl
         MgqQ1m275KX0cF0xaLf8EHhl5KIuuS9wzKRHoNw2+5jb9UGT1d+7ba72tIefEJSrbk8J
         y35rXvSX22kGSvPttTBFmq2TqPlwW47pWc8aaTCvi3s7OgNOb8jzoCBNXjoOmK9rM4WE
         s16AvTsuUmu9QWBOjfmiGQiRo1UE1LuWXiP3Q6uaGRr8VJ15w94cml4IKFJU5wRYYw1X
         IGzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775494878; x=1776099678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8x8zPwwWVSdrqqZcYHZ0g0tOazzrPlGdl2Esxf9Ke0=;
        b=Ly0zfezSV0V6zRdRan74IyglXo+JjUJjDnqk4srfx1gU6TqxV0MAkUk69qcXlqv/Tw
         U65M2NE9zgpRLMmS083Gesx9udqKDmFMHdfaLSSNMOsJ/huab3IQp1+4TQNcTJLWwtSo
         Izg16UqcrUslaK2IjVAOZbwXU0q7teYhy6Fji7Kt+oh24e0KubUz9J8o8dJ9r33v+nv9
         YPjLuu0eTVxikRQxvTOoNvD7f1/WaF1ZDOtWpfupBFzYhcUVLRLPxOTViS5AKnXryHOm
         N6QR5QkgkqYptuTq9KPhY8YH5cJSgrnNkACokl4h04d4bHZk6D7W3tnLYIx3GwA6/lgq
         q4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775494878; x=1776099678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C8x8zPwwWVSdrqqZcYHZ0g0tOazzrPlGdl2Esxf9Ke0=;
        b=hMgJumKqaYWdncL4hthGzpU5u79MzGO/sfLKrcW4AV8XfUu1wqLXJcXH9lQ4dj1IMW
         ZN5oQmh+xT8b3RFzaFLPdCbd23UnMVM9llH7csnFg3MIJM3UsgaB3pzQiAcHNFUNlfPv
         e2LX5KNCEUog3Z7vacdG3DmOhw3BuRZLnAGvDEV5kA4Lk1DK1Lb28KZtDQ18T1CYRJYI
         IbJbgpRBw8IokIvP96NzRo/kIQGO105IKSJ3/5zt/dW+GJMBOVc6C3B3PuET/nDxTXnD
         yB8B7LjPVDX68ENa090yc+nCIQ/cQYsVSxXn1BgffIoYfsqP8CxQCHL+dAnUzRH9hyWN
         7FcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVheaYnRJTDmML76uDEzjCRM7RWtjUd5ua15TH/t9lBe5yfDkUJTwTWckAdw2aICLfPBx6b8pIdGdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTP12RniYuFKjSezC0TLc+82Jfo/X+BtQt9XyGe+5LCnW2+bpP
	Q9aKdJN9+Cq1EM/rZrDQqbJfb2E7VwVAUdMSJUAP5rVhWuPwlbUZxq8rEw5Lb+LcemCEgxnhHFc
	VlQqIIwfgmiuWlaTA6yypMofqLREbTMQ=
X-Gm-Gg: AeBDievxDn93HUcZTN09oERxK0aaC9hVrmTTxw/q33BJVKiRqcI957BKqP7F9avLZph
	AJ7uD1U7YHEyMLbkxNR8L+AcPz86SGsAZE+ZN5k90iMkEkUI0cfJ8+Hf25d429+ExFBticlJj87
	EBRtlwagXSO8XlIRGwGEUcS4NJF+hg4tgNMBv6xQRIqTCh5zRjbsNaVCUoQFHu/qsklZyVOSncs
	gwfgqGICSWluSjLG0l0ynapEkFuwOYuAZwLvc1mx2Djou1goXR427DSNS99nnc/BiTAppA1V13r
	T5P0S7Y=
X-Received: by 2002:a05:690c:a05a:b0:79a:d27c:2342 with SMTP id
 00721157ae682-7a4ded20a65mr80042587b3.3.1775494877767; Mon, 06 Apr 2026
 10:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402031506.237467-1-matheusgiarola@usp.br> <ac4qoRcVGilRJ0Z-@ashevche-desk.local>
In-Reply-To: <ac4qoRcVGilRJ0Z-@ashevche-desk.local>
From: Matheus Giarola <matheustpgiarola@gmail.com>
Date: Mon, 6 Apr 2026 14:01:06 -0300
X-Gm-Features: AQROBzDMr7CPfJ3BXYaIdKM4HTrE7ndt3C2OBaxNlPgPXNJJgwkDHw46KBurzPM
Message-ID: <CABGH8=Z4mVi+P0rFSvvmJSQK7CvkBSZOoX_Rck2oTf7kMpZZpQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	matheusgiarola@usp.br, arthurpilone@usp.br, davidbtadokoro@ime.usp.br
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 5:36=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Apr 02, 2026 at 12:15:06AM -0300, Matheus Giarola wrote:
> > Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
> > ensuring the mutex is released automatically when leaving
> > the function scope. The change improves error handling and
> > avoids issues such as missing unlocks. It also simplifies the
> > code by removing 'err_unlock' label and several mutex_unlock()
> > calls.
> >
> > As suggested, in ad7280_read_raw(), wrap the IIO_CHAN_INFO_RAW
> > case in braces, providing a scope for the implicit variable
> > declared by guard(mutex).
>
> ...
>
> > static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,
>
> >       unsigned int msecs;
> >       int ret;
> >
> > -     mutex_lock(&st->lock);
> > +     guard(mutex)(&st->lock);
> >       ret =3D ad7280_read_reg(st, chan->address >> 8,
> >                             (chan->address & 0xFF) + AD7280A_CB1_TIMER_=
REG);
> > -     mutex_unlock(&st->lock);
> >
> >       if (ret < 0)
> >               return ret;
>
> This will include the sysfs_emit() and other things in the critical secti=
on. Why?

Hi Andy,
Thanks for pointing that out. The way I wrote it, guard() will
unnecessarily keep the
mutex locked in sysfs_emit() and other parts.
In a previous review, Jonathan suggested using braces instead of scoped_gua=
rd()
to limit the scope in the IIO_CHAN_INFO_RAW case. So I'll wrap the
critical section in
braces to fix it.
>
> ...
>
> > static int ad7280_read_raw(struct iio_dev *indio_dev,
>
> >       switch (m) {
> > -     case IIO_CHAN_INFO_RAW:
> > -             mutex_lock(&st->lock);
> > +     case IIO_CHAN_INFO_RAW: {
> > +             guard(mutex)(&st->lock);
> >               if (chan->address =3D=3D AD7280A_ALL_CELLS)
> >                       ret =3D ad7280_read_all_channels(st, st->scan_cnt=
, NULL);
> >               else
> >                       ret =3D ad7280_read_channel(st, chan->address >> =
8,
> >                                                 chan->address & 0xFF);
> > -             mutex_unlock(&st->lock);
> >
> >               if (ret < 0)
> >                       return ret;
>
> >               *val =3D ret;
>
> This also will be under the lock, but it's fine.
Ok, that makes sense. I'll keep it that way then.
>
> >               return IIO_VAL_INT;
> > +     }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
Thanks,
Matheus.
