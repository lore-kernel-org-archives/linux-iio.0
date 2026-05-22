Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC273A1CF3
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453854; cv=pass; b=r4IDiKABIb6oOwbgU44qg0OGHhQI7E41m7AGw6b9koQe2W27G8RMnGT8IaMUCyf1Xem1fvtD12kv26QNeg/wmhNv9HJej13QlxfpGjF6VDRaeXBnzRnL5HjObrlmpBLOc582/dxiA4A7CCo1+ca1lsUm3aop/ixlkfp8ohV+8+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453854; c=relaxed/simple;
	bh=a6cpGwPdIF9W06XPk7YoOWbsZ1qDGh7534VkYw2z4bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIaHelcuovavWtR8Usb/rZa7mqNoUcFnzeqrfXKuJSPFLkVyF2EKEoyKX64Et8xxGjSQer6JaREA+UI32sZYDKqVUrhETnEjm4m5zmDE6B7YOxmTzqMnhHDxcihvm8E01Ri1lnxJs8iHa1wlTFuU0iklCqMAHCXqAap84Ggl0tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7ucts3V; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7ucts3V"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65c396d3b36so7335334d50.0
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779453848; cv=none;
        d=google.com; s=arc-20240605;
        b=PpM/+WvdQzmNEMfQ3eaU8FCGehr0qZNclLgtKAua+WAXf8tNL2sHR3DpgbJsTmV/+S
         xBYTCCbH5xevmA0lHW//BL2L1VyNe+Gc9poekzDgV1UshN68FP9BoT+MfcrNmba+Bqwm
         thfOofsY7q1J3+kvG2kbla78opYB+zNBMiVFxEwzTwNCfuqpsHHgKUgfw1SDmNdM8bkq
         j0OikvqukqBm+VhIFyhJXuh21HBX4cANRCZnUkEbotEnMEugxPJ4KjVZtY3cklgBugD+
         GONBivrZLjbyTpA/ALyfTC1gsUwNvUJLFchyaajqq74xqNArd1hZ3vRf6Jymx3jxpJJH
         fTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vKlaeaf0ePGnoV+yqpizZ0Bn28c8Tm7wb3Gn4OpeGqs=;
        fh=WLnYd+8yksLR0pDPXG7Z73jAJnB2M8eFX2xe7Y3PUvU=;
        b=B2vxaFEUqMPh8aYB0BayV4iivlXOoo9DuF9jizAmPbAejHZvGPDJRqDHTdEDPaVyeg
         IHT1E02nKIGhApHoX9qNsFKaSJAKLgCGvYzpa+YYuQUre2bu2bcm76fl8gsQOnqKzcLx
         nbr6cXtkpKxGcSUutCYBC0exLlRxuFj0/61nsicueXXGcAq8P8tMQbQMCNP1kne1rS+9
         ZyVIgue0K9a5FQIqcOZ0BjXS1Am6wtNQbjZAorHNiZIUrhD9TOZ4AHxakcS7UE+ln+mm
         A2z7UqxLqViT+QMKU4sZu4G88QBTUJ1a8agBDG0TchycUoQH+UqyQoN06MGnwXo0JqP7
         EXcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453848; x=1780058648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKlaeaf0ePGnoV+yqpizZ0Bn28c8Tm7wb3Gn4OpeGqs=;
        b=Z7ucts3VwE+Yne/40OV6G0iVNGYRSgjrrY/0wSCUPB83HZbzU/0L3+Yxc3jG4BQwne
         sTgKWmytGPpqZJPBjaaC2RNLz9ZbcKvXJpUBpA/I2itc5mObJXA5+8pCddLsvqYwxVo0
         BiWQkp8ikwh6s2Dflm3+tLUprItEDwEisLkov8HmMovGR6iukNDeGCl5UX92CFYCx5sg
         mCrN2p1NdAmNYXWi+fLshEL6CU5vXXms5+1IEiZXd1vg4TxXKO/WZMRNAJKOedEFzfIP
         tR9kFcOarZRDMv/gXC/51AfD/tTJQVRJ4M1a3+G/8NKwOuO1iVVDr/EViVQcPnDTh80c
         9sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453848; x=1780058648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vKlaeaf0ePGnoV+yqpizZ0Bn28c8Tm7wb3Gn4OpeGqs=;
        b=Aa1P6qN0p+VsqaCf8jGDenlPshQ8GiAXvoQct8TjjdDoYkm++NnxQd6llIWz2uQrj6
         MKjfaswdJJlOGLRUB/5oWdtq3/FjohOUUa7LKNHiYOiQimt7/w9LUjmo7DV3SwqJNxK+
         zconHLyoQqhElLyw6ga+WLSlh70lhEVebgkCYkq/z17iWI+tdoo/+hLA38MmdcSr6iWB
         Toh/HNC2zd9+LCrpelDWF84T40XBKHheQYNDq6uvjfA2/Ka9SYvsydsvmk7r8Hu5MS3+
         4daXPCbc6Ms895f6fhPJyOBI9mlEP8mfMlMRdaNEWKL1LwxCOpa7TXkZhJrz6TyuhJfe
         vdBA==
X-Forwarded-Encrypted: i=1; AFNElJ8su5iCedED2kMkJK7rWHINOJb9TRSGmoBhefbn/PSFeS99l4ovGs49MsZ1Kk+i052eo0wZmABacS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/Ngpsc3EHulHD7fIkkdMr3Xaf0MOoiY5n1nyEjd1i9iP6o+8
	uqfENe0qYCreDkGXzTuXcAWBWUqslbdtrd5bG6zWsaaSIV2jFayqc0bIMuH6rKPoPUvRltoOjqj
	IeW9QwtOutBDqOYgWGJbkCs10o6bxOis=
X-Gm-Gg: Acq92OEAwrFEK7AWWRPYXxPRKAFhnEQkMjSNkOtuoXecqgisr3gckhmFJa3C68uuxyi
	IxKcU2iWK+SC/r9zhojDP2NYZUZd8G7iVMykivFMA3jeelmlCFAKjWsNb9FEiYKGkQmKg2OBuDv
	WYlwKYqCAdWvFtoAqDTujb7cuNSYXX8CEkgTqmTQAjhtwAuRWc1xzvmcH6vynAtfv3gPGts/wZg
	nMOVeKB5HQBNyQVrv541jkakbjmDiuIcyUYx/8lkPVNssjRSmbAHMR0C0uhpaduOpig4pCba3rA
	eoDk
X-Received: by 2002:a53:acd0:0:10b0:65e:b074:c6f5 with SMTP id
 956f58d0204a3-65ec981e217mr2905896d50.29.1779453848389; Fri, 22 May 2026
 05:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-iio-humidity-ens210-remove-hack-v1-1-9528ac1b384b@baylibre.com>
 <CAKqfh0Gwon4X2aCoDSNNBg7wXnKfbh69kj1R2HopKv=jHwfL-g@mail.gmail.com> <20260522133717.32772423@jic23-huawei>
In-Reply-To: <20260522133717.32772423@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 22 May 2026 07:43:57 -0500
X-Gm-Features: AVHnY4IZgODUQsxVDB3M7QfYpm3k0KjcSIAjHwMHGEns64eVoz2yw_vYQEMUsvs
Message-ID: <CAKqfh0HKoKDsn26TVC45U5EMkyZVO75a1SYmUDa3z5Uyv+cpbw@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: ens210: remove compiler warning workaround
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 7:37=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 22 May 2026 00:25:08 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > Hi David,
> >
> > On Thu, May 21, 2026 at 8:26=E2=80=AFPM David Lechner <dlechner@baylibr=
e.com> wrote:
> > >
> > > Rewrite IIO_CHAN_INFO_RAW case to avoid needing to add unreachable co=
de
> > > to work around a compiler warning.
> > >
> > > When scoped_guard() was first introduced, compilers could not see whe=
n
> > > it returned unconditionally from inside the hidden for loop. This has
> > > since been fixed in the macro definition. So removing the `return
> > > -EINVAL` should be enough. Still, we can improve readability, decreas=
e
> > > indentation and avoid the hidden for loop by rewriting the case witho=
ut
> > > scoped_guard().
> > >
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >  drivers/iio/humidity/ens210.c | 19 ++++++++++---------
> > >  1 file changed, 10 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens=
210.c
> > > index 22ad208e6aa6..49543fc389bf 100644
> > > --- a/drivers/iio/humidity/ens210.c
> > > +++ b/drivers/iio/humidity/ens210.c
> > > @@ -149,15 +149,16 @@ static int ens210_read_raw(struct iio_dev *indi=
o_dev,
> > >         int ret;
> > >
> > >         switch (mask) {
> > > -       case IIO_CHAN_INFO_RAW:
> > > -               scoped_guard(mutex, &data->lock) {
> > > -                       ret =3D ens210_get_measurement(
> > > -                               indio_dev, channel->type =3D=3D IIO_T=
EMP, val);
> > > -                       if (ret)
> > > -                               return ret;
> > > -                       return IIO_VAL_INT;
> > > -               }
> > > -               return -EINVAL; /* compiler warning workaround */
> > > +       case IIO_CHAN_INFO_RAW: {
> > > +               guard(mutex)(&data->lock);
> > > +
> > > +               ret =3D ens210_get_measurement(indio_dev, channel->ty=
pe =3D=3D IIO_TEMP,
> > > +                                            val);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               return IIO_VAL_INT;
> > > +       }
> > >         case IIO_CHAN_INFO_SCALE:
> > >                 if (channel->type =3D=3D IIO_TEMP) {
> > >                         *val =3D 15;
> > >
> >
> > I'm questioning how that initial commit got merged at all, they
> > could've just used guard()() with {} (the kind of thing to make me
> > want to take a look at this file even further!). Visually looks good
> > to me but will follow-up later with rb if it all checks out.
>
> The guard stuff was fairly new at the time so we were still working out w=
hat
> patterns make sense. Took a little while for consensus to emerge!
>

Thanks for the insight, I wouldn't have been around here for that
early period of guard()() but still pretty interesting.

>
> Anyhow patch is obviously correct and a cleanup so applied to the testing
> branch of iio.git.  Happy to add tags etc for next few days
> (or drop it if I'm missing something!)
>

Yeah if you want to add my rb you can but don't feel like you have to!

best regards,
max




> Jonathan
>
> >
> > best regards,
> > max
> >
> >
> > > ---
> > > base-commit: e1a29334a9c043defe7a9363fa76d399d3fdfbec
> > > change-id: 20260521-iio-humidity-ens210-remove-hack-7c5a6496547c
> > >
> > > Best regards,
> > > --
> > > David Lechner <dlechner@baylibre.com>
> > >
> > >
> >
>
