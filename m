Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D31F17E8
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 12:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022127; cv=pass; b=FfwM+Km12hSvnGw/AANZsM7ySYqZZfz6h4fVOh/eJT3ctwx6kIqa96Dv21LUTvab7pQ75f+BsKCZrn614HBP/LGvD8vzrblX5bAbmRxI2NYmwMq3iYtZQm1u554Cv4X0qkq6E4A3ylZ1TAfacVLCs5dOHoszKRlCszzDzj0ihDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022127; c=relaxed/simple;
	bh=qLj100d+PJahfJxuOv87nP3o4fwMrxRi9rccnNub98Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7s0FZmmFKi81nfwHVmJwvwKz5BTAG10speoV/BX3j7ZONvRN8ZXtfVrQidUr0PMZamHZyhEkF0Mwu1ECP+8ax0pOOYHjP+geuOzeJro/SgStCWvdpl+yxpkWIfP0j/+3kk+6hAced5v9uuJze5lGK7z3tkK/eS46J82SlzCBT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVPL2j1V; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVPL2j1V"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64cb01feedbso47289d50.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 04:22:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772022125; cv=none;
        d=google.com; s=arc-20240605;
        b=URc1rcb2qDRWbZkNTbGj0WcazF+Obi+rVuTmV+m5zmlHIeY0m/3w1dDkUqk+2hTPXj
         hVGnEsF2I+I6uTmDckvKSVDtVmQO2SKl4FHtztgfaRtrz4PYttZFaQnLwMst0DNeWZSO
         3S8KsfqgZ/tg5ORg9bgE8FUuj2TbneFqEulzON9b4ZBzdZK67sBcZ0RUvqd6wItdjYaB
         wQHsMCMgQ5xIuqYe8zYQ+m5q6pqewxRIcWKDOd9sZqZ6sf7YTmHLFMzMkCOTK2thDYhE
         0DXLqL4j0hVAEQJvu99m70ov9SyKR9zavaG6r3ZK1/Ut7HQFvGMcuzjxNXRZe5s0mTOt
         nKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hGlLyZLRyMGXUphBU6F3whP8MiWy7H0gcAcbO5FFSOs=;
        fh=niM1wJWRQF/RhUzAEIIHS5L9VobOKHqi1C33D7WtUfU=;
        b=H1FYBYSopoPT8HVhxvsGAIDWKYzVcDY/AiIZvPyZDV2BOMDaIhUwO65w5WR1Dd4bxM
         R/VlpeQcDWPBsm6ekxXvA4xjZx+NMhL4xx9ihHz/khsN5Zb6PVg16YTau3Yj9vpJTZrP
         5dCTcay04W2CfDFf+0FgOYNCkt3swjZSoiI0Wn+wH+dDZnxSLUhr1yZsdM8keHxh2eNQ
         JHE9auWN50FazFAeS+XFOp0DYksg8DWCBl3WeDbG9tCwbDqDZIYA0STldsf5/3n/N8J+
         tOX+e658NCHxYGGcEoefhyhu4YPTagIGMLr4Ar1Wma/VIeV6IGo0Z5OMygN92LLLgSGE
         yjHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772022125; x=1772626925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGlLyZLRyMGXUphBU6F3whP8MiWy7H0gcAcbO5FFSOs=;
        b=bVPL2j1VGgCYe3eJrCg8qQcqy301RpaED/Q5hMxVrR/TY2dgyg9jY3HezPEHHL+1tX
         McqQ0WK0sgig12qKIkvUkKg7EKfDRcHbihFCt2mcrQ9XqFDAdT6f1lCHdhP1PqgMjE3e
         tRKKJnz3SVSWlrx7SuK8eDBR9I6FWSW5WngWFNcmwPFsAVmjiJ45wp9VW2ozLfKKAMI2
         /yT0xAuefezFYQZuCduwoSk6Cohj3Wqa+P2d2L2sRb8cNQbYdHqvhUAykNztVONd0Q/Q
         zycGI80/TULP3AMMVTsqSIYTzbdIwsa2oYZm026ut0WUpehqj680D5rCvx1Chufdeaps
         wr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022125; x=1772626925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hGlLyZLRyMGXUphBU6F3whP8MiWy7H0gcAcbO5FFSOs=;
        b=MMHQ0pJkjqzcSnkwrzRPh55fqCf75cGsg1b3kclSDAL2Sq2LNyhEFX/7ZWzU4aCLtt
         wD9ZwKH83o5Xs/8jiHUn1EoHX26tpofwDJGWKpjUQQuMbPcXWngpnolXd1ihp+iiGkxO
         i+E+YAdbaWATcW1cyvI+0xq/q+s2l1sAJ9wRuU6PGAOlXeGCqUUtjBYerg5vYeb7D24g
         ED372DRZYUm2qsKO1+qWYih5Ot8oDZA9jIkEFQjdcbtdBzZRzhRlPRpBCVhijRp9eULA
         8uhnm5pA1cIrs1B0Ll7uUwLlAy+EX704AHBmEs2dNDric1yC2TcDUSZPBMUv6zKg3jr8
         tBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZTQTARVVj5gy2t2jkHfQIP6XTQ6fMIzA2Uq3i4p4tVYbeHiiMM0sbisN9r9452K5GE1M/+3P1BFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRaVEKcgl6BWZEOZgiUWOXwPHURgxuu3X+y00yx6khyP5ZkXA
	EbgKUNiAgPrCwJmw4PPuTnsj4oM4vUgX/5Br+Lv/00w59wKzS1l+oGU/UlZWVNAC8fs8qWrwgkz
	bFVUnKsvj/ASEB0RX/k6ghxfJnAOiR4U=
X-Gm-Gg: ATEYQzzFOW7dVP/ZfOtD+hhiPHFJdkh6WS/wmZw3QdoOBQ+6DAPm9Gp4Zi+ne7B1v4X
	ws6VprtLRKeZ/vg3Ys1L+4p/MUThHKLAdu6MBCplNkdI/x/tZwDFbtBCNaJNedfqcEo05W+d5DJ
	vrc1wlsJ9IvSF59Rpsgx0h4IAxceoRoA/8csrG61ZERVzJhWDN0KzH/cGuzDGPLuNrzo38OmcAP
	95dEf3IdjQ1IOMvMJu+fzyinaR+fcbkv+SjekZVUHtoZ5WD++mTPG2ytCRcz+QmiaOhR7zFvNk4
	wUU5LQpKtvL76wviTeI7TgP3bNLHWYxBxLmEZkbBAuc8CsSiI381IEMO4Op6hQsaam8F1F/97yv
	dRPlsfMtjAE3OUXb7Xswh2Q==
X-Received: by 2002:a05:690e:1448:b0:649:ad8f:913d with SMTP id
 956f58d0204a3-64c787d5b63mr11199134d50.1.1772022124685; Wed, 25 Feb 2026
 04:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225113102.84568-2-giorgitchankvetadze1997@gmail.com> <aZ7iyJ2CdNB3L6ON@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <aZ7iyJ2CdNB3L6ON@debian-BULLSEYE-live-builder-AMD64>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Wed, 25 Feb 2026 16:21:53 +0400
X-Gm-Features: AaiRm535FutG7DN-uqp0g8cVDs-g5gkOZy6tIbg4LK_dfGTlmgMNYxZGKcwpxxA
Message-ID: <CAE7dp2rOa4H5yL9qT5kJj3vF3FkNy_sv87Cma9JkgYXGQ5ERWA@mail.gmail.com>
Subject: Re: [PATCH RFC] iio: adc: ad4030: fix calibscale read/write unit mismatch
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo, Thanks for the pointer to your pending series. As for
keeping NANO precision, the hardware register is 16-bit with a step of
1/0x8000 =E2=89=88 30 =C2=B5, so NANO doesn't provide any additional precis=
ion that
the hardware can actually represent. MICRO is sufficient.

Btw, I checked and found that no driver in the entire IIO tree uses
NANO for calibscale.
Drivers use either IIO_VAL_INT (raw register value) or IIO_VAL_INT_PLUS_MIC=
RO.

That said, if your series is already adding write_raw_get_fmt(), I'm
happy to drop this patch and let yours handle it - as long as the
mismatch gets fixed either way.

Regards, Giorgi

On Wed, Feb 25, 2026 at 3:53=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> On 02/25, Giorgi Tchankvetadze wrote:
> > The read path returns calibscale in IIO_VAL_INT_PLUS_NANO but the write
> > path treats it as MICRO. Since no write_raw_get_fmt is provided, the
> > IIO core defaults to MICRO when parsing userspace input.
> >
> > This means reading calibscale and writing it back results in a ~1000x
> > gain error.
> >
> > Change the read path and available range to use MICRO to match the
> > write path.
>
> The updates to ad4030 driver will add write_raw_get_fmt() [1].
> [1]: https://lore.kernel.org/linux-iio/516cccc47e917bd26be29b016907f50a24=
4a68b9.1771865684.git.marcelo.schmitt@analog.com/
>
> At first glance, I think this could instead add a case to write_raw_get_f=
mt(),
> keeping calibscale nano precision (unless nano precision doesn't make sen=
se
> for ad4030 calibscale (don't recall from top of my mind)).
>
> >
> > Fixes: 0cb8b324852f ("iio: adc: ad4030: add driver for ad4030-24")
> > Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> > ---
> >  drivers/iio/adc/ad4030.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> > index def3e1d01ceb..3d823648371d 100644
> > --- a/drivers/iio/adc/ad4030.c
> > +++ b/drivers/iio/adc/ad4030.c
> > @@ -423,10 +423,10 @@ static int ad4030_get_chan_calibscale(struct iio_=
dev *indio_dev,
> >
> >       /* From datasheet: multiplied output =3D input =D0=B2 gain word/0=
x8000 */
> >       *val =3D gain / AD4030_GAIN_MIDLE_POINT;
> > -     *val2 =3D mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, NANO,
> > +     *val2 =3D mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, MICRO,
> >                               AD4030_GAIN_MIDLE_POINT);
> >
> > -     return IIO_VAL_INT_PLUS_NANO;
> > +     return IIO_VAL_INT_PLUS_MICRO;
> >  }
> >
> >  /* Returns the offset where 1 LSB =3D (VREF/2^precision_bits - 1)/gain=
 */
> > @@ -720,8 +720,8 @@ static irqreturn_t ad4030_trigger_handler(int irq, =
void *p)
> >
> >  static const int ad4030_gain_avail[3][2] =3D {
> >       { 0, 0 },
> > -     { 0, 30518 },
> > -     { 1, 999969482 },
> > +     { 0, 30 },
> > +     { 1, 999969 },
> >  };
> >
> >  static int ad4030_read_avail(struct iio_dev *indio_dev,
> > @@ -739,7 +739,7 @@ static int ad4030_read_avail(struct iio_dev *indio_=
dev,
> >
> >       case IIO_CHAN_INFO_CALIBSCALE:
> >               *vals =3D (void *)ad4030_gain_avail;
> > -             *type =3D IIO_VAL_INT_PLUS_NANO;
> > +             *type =3D IIO_VAL_INT_PLUS_MICRO;
> >               return IIO_AVAIL_RANGE;
> >
> >       case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > --
> > 2.52.0
> >
> >
