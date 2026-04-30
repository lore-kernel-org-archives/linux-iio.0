Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9836E467
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584202; cv=pass; b=Oif0TIJHbAHW60qARKqmRn4QZTVjYJMq75gokfl+FKax6+Y3BItfHt2KDf34ADGj0pLHeZ0yYjXP4TGl9rpBaDu6dUxKHHo+mnIJlECOaWSu15PrfkEI5Nwmn/2n10IrkVb+YFxOLNiRA4IszNgujEVdlTuXUkxmntTo+iICHoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584202; c=relaxed/simple;
	bh=pydgNNLVu5pCBPKbFktkcMtKZFX2eRYpJg79Q56rV18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpzY/ISkbhUdjbai3EYsgkXRQagZNgA7Mq6fgOwxSjMuPQlpbRru47sWnTICLaD4VcijVop3Qos7ksEgMWpwoDMBQqqNSBlOY8KIDcSbsGktbeRqvV5EOJ2OC43RcJKf3ni43N37fxXmaErq7fLqu7IIEZyu0OFaoAw+JKOAVVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7cdFsnv; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7cdFsnv"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44a786a9a35so83228f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 14:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777584199; cv=none;
        d=google.com; s=arc-20240605;
        b=Lm0ZdqAfx2+90BEITNRO2Omq9ebjNj0T/yGgyoZInBnK4uLdWsS7t3Zb4OSXGMiH2V
         OK7CCv8sGXawM+8/hBuGhec5AotI4ArDZN5iLnxPgDPl0cNvGLfsAly3gAUD8doB7f5m
         KA600yE2rRkuKeVSWfrrFYLAsohe2+aAcffm1H6gah3NmZxkKDoK23grFbfyrqDRDc/m
         t50zpj/uTWCbyubS6E21BADeD6MwNgro2/Bjm0UmyuUhVQKz+p6ffm0bS8ftMf7Idd4F
         AUDfEbD9Cgl2HFuZ69G3Ka3EHfoF6ba0WyOHmSCD/9TpJY3we50oaXO6eHyU7mEVAh1C
         MC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0VvhraUVzbnplcVR1wuKsGi4nmZ3CX5o3SA9r88mmRI=;
        fh=semxW6P0jlPQn7YkXURYMwwz1tN/bKE/nD380KNEMNk=;
        b=gvnvw1i19lLV3SUMpXF/+EjC3D9IxJqtnhl8t/3DqgK1TEa8K6AoOgwCeF4x6iLuQk
         PYRKIvQFOC9h9lLf0GKE/Mtb5Vkv8XPZdf/82NUuy0b9Xe3Fl+NPC+a7CCTsdoX8LbuM
         FUJQtPOs7KCwPapjc+h8KawWB4yBGviOy9+2Nu6QU/8SOK112eYN7TaIqZixPkkkVeks
         sSF0nVeJ591ShfGJqMe/z/bRmsiask6HJk90lumYLwB65xcxEbixt0FEn1tLAMU5fLah
         FZAmktlldyCXVE4GQQn5JfEZYdz8OLtuVEbAtHFip1eqsAR6sqSERhjoFay78/vZMCJ9
         wdTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777584199; x=1778188999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VvhraUVzbnplcVR1wuKsGi4nmZ3CX5o3SA9r88mmRI=;
        b=b7cdFsnve2f2iFtr1LQJ66lEUw0jWcxw7qrzpSI7qGbYEPfSAb4l97aH2EUycxwKDf
         iJiWO2jpmqneVcV5B57i2DhUgaJCqbv9Ygpoz+aNEjl68BZuc9I/m5EFV3kf9Jvi5KeN
         4CUO1JqDhS4tGbdi/p/VJQtZY5iulBtQv7n3t4It2P0c6wUGSoGPTaYBO3Gya67mvmFP
         dugkv0Lr0rrPdc17axhOZRmeBmpnZ+bvmMGxHRJii5JqafEvjn2nQc1fruSwixYDw9NI
         DidCn0j96f+Lme1jYe0o1lCZAoMq0zTUvKlSfID317OKDU38PDroGwq8xLMwKj3AhoHP
         xXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584199; x=1778188999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0VvhraUVzbnplcVR1wuKsGi4nmZ3CX5o3SA9r88mmRI=;
        b=DGw8f3h9hUesaG9t88sfJSw6BBOtCRMqJY+mQ7WgiJoH/9kVIfBBtRcK+Ps4Cq7clw
         Qw76kLBq7kuYLwHLzsvKjxPe8OQ/BM2RQU3RPNUsE0etcmaL/0w4Ed444iFgVcCGzMr6
         Y+33wzncQ+XVYK0FMHANcLAU0DEpLEbe+kl+mSYWoRm4L0MvdoP9GyPel26yzFoHLvxM
         6fmHv3zkChLxTL9w78enq9vQDfgVXilMbShoApjPfa2bZkpWqDnMLNSESn6jxlv3Qu9B
         MMPm2u9VfZMAKMhBLKawbvByekev2jNJpQYuZ0cuZgczyneoGMDE/UHt4JPhEVyay7to
         B9mw==
X-Forwarded-Encrypted: i=1; AFNElJ9ei8/EnGgmHrXer/up3dKVx2aAxNM0G3dIyGZAvrE7WYm8jNNN3e9aLuCVIwQjzekeT7pl2zR9Nl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+84ky/QYLJuHjGuAIhF7v1y3KX0qngCf6LNxf6zxMNQzvFVX
	mRVAbd283b91i1VpaM47i4rwAAO64IiyFeDNrZ71Y0qcXknGJ9jLF0zWmxsYHj1H8UVDPs+VhgM
	Me5QkY1vB3CfJwFSF5QQ9vhRi0QZMp74=
X-Gm-Gg: AeBDietUPg/65ejxRrtnUaePnguBfu9Bs8chjOJmdTutyH0cePu1WMZendqKEyqRe5/
	zDsXoewr+SPMs6UvksI6j1Pf0NrYUFl6F0f3U30I0yWxqoeIL2F02/E+RH9TPNTv7GK97fzhycL
	9lmRqzZnAi1EL/Ba5lePRA3J99gdqYLaeTYqCYXCNze1JhdMqqlV6faf/3BmJ6AGql4WB3r7erz
	pKakNyqhPjiKUSusJp1qDM0giQ+jE2v7rjXOZ5d/hVWabPPInSQnAZEJg1Wp+Q8yZ4rHEawmdLC
	grYcyqWZlrnKFEMPT9CRF45rdjrrTU3N4H4CT4UtmlVA71aIl398NDX2DVdwlgHnGTN2faxz0Xr
	YRCD9jsOlNQF/SE4404OSCrer1VS5FmiWN98GW42zm+RU+nM40RCjMA8u6efaQGt0yedD4DvpH/
	lrswVQ1FCks86WqHXNhqaJZoisLbp9QHGX/vdhPYMmAmckJ9tD6Q==
X-Received: by 2002:a05:6000:2088:b0:43c:fde6:212d with SMTP id
 ffacd0b85a97d-44a87c7a761mr522981f8f.33.1777584199254; Thu, 30 Apr 2026
 14:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200515.7915-1-guilhermeabreu200105@usp.br>
In-Reply-To: <20260430200515.7915-1-guilhermeabreu200105@usp.br>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 30 Apr 2026 23:23:07 +0200
X-Gm-Features: AVHnY4IsiOy30VRyLZieFzj7f0cL8IkJi0AXNppG7uPIMW0ZrbX9Hkjmh4Vgi8I
Message-ID: <CALoEA-woSsD3+oEo-4xWLY+pQt5B=SaaUX4xPFoB46WPnFbwrA@mail.gmail.com>
Subject: Re: [PATCH v4] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
To: Guilherme Dias <guilhermeabreu200105@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nish.malpani25@gmail.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Menezes_Linaris?= <jplinaris@usp.br>, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Apr 2026 at 22:05, Guilherme Dias
<guilhermeabreu200105@usp.br> wrote:
>
> Use guard(mutex) to automatically release the lock on scope exit,
> simplifying the error handling path and removing the need for
> explicit unlock and goto-based cleanup.
>
> Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
> Co-developed-by: Jo=C3=A3o Paulo Menezes Linaris <jplinaris@usp.br>
> Signed-off-by: Jo=C3=A3o Paulo Menezes Linaris <jplinaris@usp.br>
> ---
> v3 -> v4:
>  - fix indentation
>
>  drivers/iio/gyro/adxrs290.c | 74 +++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
> index 3efe385ebedc..f7344ab4e6bc 100644
> --- a/drivers/iio/gyro/adxrs290.c
> +++ b/drivers/iio/gyro/adxrs290.c

You're missing a <linux/cleanup.h> include at the top. I'm not sure if
you tried compiling the module, but if it passed then it's because of a
transient dependency, which is what you should avoid by explicitly
including the header.

>         /* extract lower 12 bits temperature reading */

Make sure that comments follow English grammar and punctuation.
(Capital letters at beginning, dots at end etc.)

>
> @@ -506,19 +491,20 @@ static irqreturn_t adxrs290_trigger_handler(int irq=
, void *p)
>         u8 tx =3D ADXRS290_READ_REG(ADXRS290_REG_DATAX0);
>         int ret;
>
> -       mutex_lock(&st->lock);
> +       do {
> +               guard(mutex)(&st->lock);
>
> -       /* exercise a bulk data capture starting from reg DATAX0... */
> -       ret =3D spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.=
channels,
> -                                 sizeof(st->buffer.channels));
> -       if (ret < 0)
> -               goto out_unlock_notify;
> +               /* exercise a bulk data capture starting from reg DATAX0.=
.. */
> +               ret =3D spi_write_then_read(st->spi, &tx, sizeof(tx),
> +                                         st->buffer.channels,
> +                                         sizeof(st->buffer.channels));
> +               if (ret < 0)
> +                       break;
>
> -       iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> -                                          pf->timestamp);
> +               iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer=
,
> +                                                  pf->timestamp);
> +       } while (0);

Why is there a do-while loop with (0) as its condition? Are you
trying to use the break statement as a pseudo-goto? You could
still keep the goto even when using a guard(mutex)(). This can
be implemented with a standard if statement, no?

--=20
Kind regards

CJD
