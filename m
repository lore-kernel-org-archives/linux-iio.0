Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90C36402D
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758966; cv=pass; b=H4BQeJprIuKUp1IUeMd9VvlmYQQd9L0G8mE8VgU4PxEctg1sxLyp/rTTYhe+8+F/Yi3iG/7uxZWqh+yQ8liuB3+s/HuP77VdCJArs1CErqO6utFW4HRi+ZCQ4QfzXB9peXT3vY7Z583gdsgDxFhDN8UHBa6zRNuWnDGhUvOFs6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758966; c=relaxed/simple;
	bh=GBh7xuyHZSYcri5erZ0fuibf+63TnyENMGP92EyT63g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAT1pbx7yrjAMxPyc4BrI4/LT9AaWi0YZOb7aAn+13ttP0/j2jsM2tmj2jEuiVBvFSukpbiaIlOpTd3YAmM1ax0ZfG64opNrQGiDAX25R5oGakQVx2rct44AWj03GeNOlnvOIYOjpY/zFC7FoGvSOIj7xEq6SquM76TGJB36hD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVhVzZZW; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVhVzZZW"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-459281bc13bso863026fac.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 05:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785758964; cv=none;
        d=google.com; s=arc-20260327;
        b=eNVxNUD2n9gEZiQTKe7rQMTSCa0W6lcjZWW5S3e3azXIY9+fMEAZsxG7E1nOjYdMm+
         5sr0JWyPyw9euJ2y+aCQjHeoTIjtcoE2RuOwgz6+JK4KyoIVToe/uy40ThlunBa1pgq/
         drq0RSvY9NEBB+8+elxyatf4qbRurmSkGTxHEwoK8qU00sn6EHGlIaHxZB0C8yaG9jyR
         8skokTSSzJFDlE8ds55KKGL6nv0KPzbRn5OIkrXX3ZKyfLZ3UFciPUou2klH9KcnSl34
         GRm+fdqSqrJQleHF7n9LyxuuEg6d+JzydAP6O1q3vro9RU+iUXzC0OCLMHb1yzER+uNd
         42XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l+eiDhEKEJzv/YlOG+Kaa8MtY0pGCEb7E3JQDfcJnSk=;
        fh=4SvfZw0r1EiV2Yrs5GAnZtSifd50+ZcbPG77+zzkZW8=;
        b=ilpURJ5PsNqDOI4wpy3CsHKfkCHh01f6sUzBL53HSTxmTHs+P/WTCW5clE0Q3Z/Z4E
         olTuCrRxBBlsA7LDTHsj2W5LrN/T9SNrJr59aylOPm7+UTB0p4Kx8zlGdUaJkyq1CkuH
         NP0jkksrH8kDu5KVaR+jrvlRGv4TI7Jf26SuzZow6y0cKOpAt8YWNMf5/z+krlayda5X
         Cf8ZrSr5wEtgkPToC4kLs+v5fdH5umS4aOgMh1ZDN1zRXYkOdwhvHz2brPCn/DgGvl/y
         cOG43b5GX5h3EArWGHBDQsHNM1JJPfGy8pcrEsdqgL+9iFwfibOaXE/B7HnJsZvPEkEr
         WCAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785758964; x=1786363764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l+eiDhEKEJzv/YlOG+Kaa8MtY0pGCEb7E3JQDfcJnSk=;
        b=XVhVzZZWhtASrae9eyTw2eTLBwVYs7iNV7+OXPr5hy4S7y7mp2KjlJDvtjrKMra//G
         VB5LIBVUl0asP8z9HDqzWO1rbiWvmE/CjSlH4HzIxUmIFbaRGbnZKJAsvVd5phOq9s14
         1Ud9DRq2uadCQVsF5bp8RLm4/APZCbj+391Od5LckkO9lXwWQTSFlDdyumP8Co3c3l5M
         S+YtepZESe3+D1Ae1Gk6vfCeLFlzUZqptkZEpzxGiuN2AlRAyxzuB3ASg4dBR+NANXDB
         0Qjw8PU2Uuj0FuWrot73DOU8YTPBf87L82vz61TBs++YwNqpMG3UiFG2UlJZDzycp4nO
         ywLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785758964; x=1786363764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l+eiDhEKEJzv/YlOG+Kaa8MtY0pGCEb7E3JQDfcJnSk=;
        b=KHFhQwM4/tKRCd26E6NY+0neUxYRiJpweoecrmeFU8F7s8UlE37TrxccKenzYxdcwm
         kkpgfRQkfMuPrUtggo6OxlW1Ij4W88PPl9jqvJbPiroRx9mWaj1qV+7BPevyn5qSl0Bz
         PKS6V3JUAMHVV0VM20lUsPbQAWKOervVwr1hh3/oDCYM4iMH9/J6cnzVYX0r6p0cJQbA
         QddNdJGopYsS/r+8Wf8wdsy7c8/gxjwdDMpNNGKjVg1cYzClItZGKKqoxNSx6lnmxr0j
         7yN5UGUGjyGUFQDbGXer1oUwpwMY6BtY/lCpGfYGo6tlHrOelxj+xy8G0QrPVB4MkSkR
         oloQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmBYrMgCM8layPIxIzoRW9qn1hTieI+/EqQAHMyvR4+J3Z85ZCRJivVJVVUFr9L3YA48DwkfJOc10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMcOQun/QkeUKKJDI3qCsuPbcF1WMs6GCgRJm55An8QuL/0rm
	4M2oRRHvkKlzcvKpMWOYct17n8A+TDJZKyZcx2H/bYoMQ0uMe7iJ7Rxla13xm0N0+vd6U74omN9
	syPWTKCdMbL+oDwB2ZlqUCoyodkjyqVQ=
X-Gm-Gg: AR+sD12USxB+18ytrQ2PXjbthdwxmxBYPl59DmDaTVzSUM3tpuGyXswuYNGChDP+GYO
	IBu1pYjnoYmuvAuYJMCayc3tRyFMgjjoSfyRlVtlh/vRv8xmHjmT2N6a4MDcyutaswdxiFPML88
	PnSSIDG3s2KUvY9U9Z0JNAHF5gRiNLHG5x7+YBBgGuBYVnob9EoMmeRysLAGDeaKKcS3XIozoiF
	EO9DjDp1jKME2KgRAua8M0En5wvaJtHLzC2FLDtEwRw5jM5xDi4Jm7tvjXNGDJq5LjfIrBnb/JI
	E1W3OHc2zdnDJVOvqsNxU0AHmJrNjgZT7QRcw/x62mBBTw==
X-Received: by 2002:a05:6870:4686:b0:451:3852:25a9 with SMTP id
 586e51a60fabf-45905dd7fdfmr14512993fac.21.1785758964094; Mon, 03 Aug 2026
 05:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802113840.17730-1-abdelnasserhussein11@gmail.com>
 <0bde2343-8a70-44d4-9b27-8ce42c099309@baylibre.com> <20260802194738.034382ef@jic23-huawei>
In-Reply-To: <20260802194738.034382ef@jic23-huawei>
From: nasser <abdelnasserhussein11@gmail.com>
Date: Mon, 3 Aug 2026 15:09:13 +0300
X-Gm-Features: AUfX_mxkDdPmJMT43CqX3qldlTS1ZnrEhcdMI7mWW1gOwzvpAJi2bPGzYHMtvfc
Message-ID: <CANpqX3bYkz0GT9H9i2LFfxW3VxoPRAxDv+LMzU3cOXVh_UP1cA@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad7816: avoid DMA from stack in spi_read
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, Michael.Hennerich@analog.com, 
	gregkh@linuxfoundation.org, andy@kernel.org, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for the review and suggestions.

> Should also mention fixing the "wrong" sizeof() use in the spi_read() cal=
l.
> Probably deserves a Fixes: tag.
> In IIO, we have a special macro for this instead of `____cacheline_aligne=
d`.
> __aligned(IIO_DMA_MINALIGN);

I have applied all these changes. Following Jonathan's advice, I also
added a mutex to protect the SPI read sequence to prevent race
conditions.

I have split these changes into a two-patch v2 series and will send it
to the list shortly.

Best regards,
Abdelnasser

On Sun, Aug 2, 2026 at 9:47=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sun, 2 Aug 2026 10:31:29 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
> > On 8/2/26 6:38 AM, Abdelnasser Hussein wrote:
> > > The SPI core may use DMA for transfers. Using a stack-allocated
> > > buffer for DMA is unsafe and can trigger faults when VMAP_STACK is
> > > enabled, since the stack is not guaranteed to be DMA-accessible.
> > >
> > > Move the transfer buffer from the stack into the ad7816_chip_info
> > > structure so it has a stable lifetime suitable for DMA transfers.
> > > Mark the buffer with ____cacheline_aligned to ensure proper alignment
> > > for DMA operations.
> >
> > Should also mention fixing the "wrong" sizeof() use in the spi_read()
> > call. It was the correct size, but the wrong variable was referenced.
> >
> > >
> >
> > Probably deserves a Fixes: tag.
> >
> > > Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> > > ---
> > >  drivers/staging/iio/adc/ad7816.c | 8 +++-----
> > >  1 file changed, 3 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/a=
dc/ad7816.c
> > > index 0e32a2295990..fcaadebff0f4 100644
> > > --- a/drivers/staging/iio/adc/ad7816.c
> > > +++ b/drivers/staging/iio/adc/ad7816.c
> > > @@ -50,6 +50,7 @@ struct ad7816_chip_info {
> > >     u8  oti_data[AD7816_CS_MAX + 1];
> > >     u8  channel_id; /* 0 always be temperature */
> > >     u8  mode;
> > > +   __be16 rx_buf ____cacheline_aligned;
> >
> > In IIO, we have a special macro for this instead of `____cacheline_alig=
ned`.
>
> We've had a couple of these recently.  ____cacheline_aligned is simply
> wrong and I'm curious where that is coming from?  That's the performance
> hint cache line size, typically that of l1 and l2. In some systems other
> caches before the incoherent SPI controllers have larger cacheline sizes
> and we have to align to those.
>
> The correct option if not using the IIO one is __aligned(ARCH_DMA_MINALIG=
N)
>
> For historical reasons IIO has it's own version of that which predates
> all architectures providing ARCH_DMA_MINALIGN.
>
> >
> > __aligned(IIO_DMA_MINALIGN);
> >
> > >  };
> > >
> > >  enum ad7816_type {
> > > @@ -65,7 +66,6 @@ static int ad7816_spi_read(struct ad7816_chip_info =
*chip, u16 *data)
> > >  {
> > >     struct spi_device *spi_dev =3D chip->spi_dev;
> > >     int ret;
> > > -   __be16 buf;
> > >
> > >     gpiod_set_value(chip->rdwr_pin, 1);
> > >     gpiod_set_value(chip->rdwr_pin, 0);
> > > @@ -91,14 +91,12 @@ static int ad7816_spi_read(struct ad7816_chip_inf=
o *chip, u16 *data)
> > >
> > >     gpiod_set_value(chip->rdwr_pin, 0);
> > >     gpiod_set_value(chip->rdwr_pin, 1);
> > > -   ret =3D spi_read(spi_dev, &buf, sizeof(*data));
> > > +   ret =3D spi_read(spi_dev, &chip->rx_buf, sizeof(chip->rx_buf));
> > >     if (ret < 0) {
> > >             dev_err(&spi_dev->dev, "SPI data read error\n");
> > >             return ret;
> > >     }
> > > -
> > > -   *data =3D be16_to_cpu(buf);
> > > -
> > > +   *data =3D be16_to_cpu(chip->rx_buf);
> > >     return ret;
> > >  }
> > >
> >
> >
>
