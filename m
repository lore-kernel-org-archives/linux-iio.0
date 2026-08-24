Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B14381AF1
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600206; cv=pass; b=UoMWsQBMd0p0dIqXc6WvWRRjcwcc11GsUaJ3ZM6dgy0mOtTnLxp8Ig1iDoq080/4NlfsBBSID9znDHk0uV4ZACLVXBqVpGmSZpJZZHtXZKjRn3RIZLoxc8CHm0WsYs1hiUrWZqghOhymIOiHpvsKZfpdCJNxl/ZniKzzyctU3OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600206; c=relaxed/simple;
	bh=u3ToHwPWBvuomSNlxQRMUwLQlm+S/ydY5UHfPvxrvaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki7HHDWIjSsgC6dqP94dip9WNhOPzH9oc0f07NHf8aN7haFLXhV56BbH3etc892wEXkIQ9XvIc2EUXvookJKOCCEczUCXlhlA14FLhGoFPuj1zI5JcIoG8TbkQhG7BGCnmX4lu1efYPiEMNd4tAS3TVIlif3zh36oOOA2X+KhTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3611lqG; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3611lqG"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80cebd41372so59539557b3.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 12:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787600202; cv=none;
        d=google.com; s=arc-20260327;
        b=qlYVrmXsnShXTe9qLhS+vomEjWL1W8Wze9WH4gialKjLTAiaD3Wnw/vFEVqFT7lhQP
         kSxS78BaF2NkhskxybWeM6+GizCyo+PsXqUJ5zPk9JLzjcfW4U5y/2nsS1qDS1+2X9XM
         DsbSEjbl8UYoVpo/Hnf+ZOFFzGEjtsrPYMblIqvGyTdn1FUAj1KCA5s7Ph+J+hAX9obA
         YxELADm6YSZhr1Lm2WsVwCB2W1Cyr1QDkw3pBRSX/d1gtqNFYhOPAQ2PCENzfaTsgsbF
         4AC46CotfBwyZBsDnrDXQMj704LWdwAp6QgncFEUsNM9fF4ifbTHQIToLAh6hYScb7p4
         v7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8C7Jm4CPot+1Ibsp82E0vdGrALYuJs4dU2/4YHhJjs=;
        fh=aTOBVWVftcrt6fVPU/VCbH5EqUIsBieEkfpY1XUFMso=;
        b=K9SB/RG7R30BipdZxXjudgBr2HaB7SOTFJTypPUZ2EYNPvUzqqLjnekt8LP7ujZPgq
         aZiND2erYvjWxJQvGDy/HjiM+xFe2tDl98dKvG/MFzphb2in3t84WyhQUt3FZ/zRMV1r
         2yEVVUL+ahHNAojBL44C/00KOuiq7tejB3Zyh/+VM74u+Bs5DvcPvUmt7IzYfIjUpz6m
         4kxP7k0soBAzLfQ0aH5LCDXDVR2SC4BE7cp3DPiXJOR1p8uCGig0+jnRYkVnXWtkl5dQ
         MylZ/z4j4sWO6RPtJtaah7BQm0X+tiewZnTNkNnXx5WJqalsmB/IPr3iGWr96vOO9fjy
         dQtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787600202; x=1788205002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N8C7Jm4CPot+1Ibsp82E0vdGrALYuJs4dU2/4YHhJjs=;
        b=g3611lqGPW2vBcvYkZuQLxxTk+YuaeBDTqmfI+xZFMWM5+0yE1X/DOfuNPacP3dzTO
         btc55NEmfLhWqUOOVSyFgW49pb982J2+OWxPjwb+Ee2385F7lp8Wq/yBK5XOamZw332K
         VjcEEeGoXRMYKqIMw4XzvAFvk7lysIiNHE16escPce7Pg0BSF7x6wkkD49Bl8prhastn
         jw16wbnJkWeM1IwYG218ZW1cVaX3O6K5fkxOlZ3Js11CbXopFAeRebPsXVwvM3d2NGZP
         R+rO6xzU3+Gk7OpIll9dIORwvxfz7F19XQljgM5Q2DlizH0h8B50Vtd3Vf2ZDFyZug+2
         3otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787600202; x=1788205002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N8C7Jm4CPot+1Ibsp82E0vdGrALYuJs4dU2/4YHhJjs=;
        b=HO06Taa1zzhc53/cmrtonDRzoT9bGbqOF/WV1ppk773ZSnvo8bjXPlYaEq7l9j3A4K
         LD0l/tXxq98IcWUkgGGc4c5VYBgxpCOI528SXWCNO0h83UAKasR5HRZJoeU1tT74fGPq
         0rhV7bUHReN6M3Mvnfpx94zvXlP+Zu4gXYr74hd6z0Satr3MzUt0cYv1XXjPC4X2X0Dy
         a2J9L8He8zGTbHURoehyabdimgEOCgkES3o67DapytwpxxBVhF3BqOwvdkH8tnaEJss2
         B4Qt7ZYPEYY3ztirKHnjT7rwWOFIxeCcSdfP+0A6Kyd2Fd7iTvUNbkz7QNjCy9U/96J2
         I7Lg==
X-Forwarded-Encrypted: i=1; AHgh+RoNigo1iV+IwYA2cS+MGv0GzhcxzBUoOQXFoW+DtXEiYE+lzaUc8Bvb7aXHpg1Q6dagOSgo/m4GlPY=@vger.kernel.org
X-Gm-Message-State: AFuF++nD3Qe9eDYRHyzp2LHcUkUyGW8CTbRnQ1ZOR2StHrmk+6ff5oWK
	PhE7KBm7R+wLhD5vK10t9CECAQQ9P+7rD3YttLhXEZmHGNB5T+m+ny1tJGIEwHOyYsIJ+biJLyY
	hS8BXgUHM5+kqwdrfxso5tesEd+qPz7o=
X-Gm-Gg: AR+sD101ELDH1Nx4MI6AV3CAeECiO9DnFiZKi7wvVfy///XuyvLla/jMyfZPby0av31
	jRNrB7NRq4IebVGXINHlnyWqVfd11wT5RxzICOs4xxETOHZLiGyILwjMKQZAeZWSuv9rpkfJ00X
	J2zPs6safWrMkgIH5crW3ohZ7e2BtT4Q1Xa4EJYDO+QtKY36jn/9+alv8O2K5zAPXq3cKYELBkr
	FDjnGhltIgKPOrtkDgd18oLHy7V7yxi46fKw3Ya+x9rpmQzFrizLvRKhd9auhrDW2bdVKbaDuxm
	ctTtZNpnmwoyGr92DTK9OLhGJLQ5wGnDWuT0/lYIs0fX
X-Received: by 2002:a05:690c:389:b0:81e:d792:a019 with SMTP id
 00721157ae682-84c93848f54mr71592167b3.6.1787600202365; Mon, 24 Aug 2026
 12:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815175728.99541-1-yashsuthar983@gmail.com>
 <20260815175728.99541-3-yashsuthar983@gmail.com> <20260822230643.2b7e1dc0@jic23-huawei>
In-Reply-To: <20260822230643.2b7e1dc0@jic23-huawei>
From: Yash Suthar <yashsuthar983@gmail.com>
Date: Tue, 25 Aug 2026 01:06:31 +0530
X-Gm-Features: AcwNN1Xn8c_hmDbcP4th8anFaz6_t1HOYpwRbq5Z0bdUGapLnyVIM56jFv0LTvk
Message-ID: <CAPfzD4nw=NoVU-Th6XBAwjbGkAMyG3UKJ4Rfh8_bcE2ZSaK+fg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: accel: bmc150: use DMA-safe buffers for
 regmap bulk reads
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	andriy.shevchenko@intel.com, grondon@gmail.com, linusw@kernel.org, 
	hexlabsecurity@proton.me, sakari.ailus@linux.intel.com, 
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan
thanks for review
i agreed with you, earlier i did same as you mentioned see:
https://lore.kernel.org/all/20260814101845.301769-2-yashsuthar983@gmail.com=
/
but after review from Andy Shevchenko:
https://lore.kernel.org/all/aoApEqsbXp9Pd7Mf@ashevche-desk.local/#t
I agreed and revert the flow for v2, but in doing so I moved
mutex_unlock() before
push.

In v3 will hold mutex for both read and push, single IIO_DMA_MINALIGN on sc=
an
is sufficient, so fifo_buff and regval no longer need separate
__aligned(IIO_DMA_MINALIGN)
Will also replace AXIS_MAX*2 with sizeof(data->scan.channels) and drop
the unused AXIS_MAX.

Sincerely,
Yash Suthar

On Sun, Aug 23, 2026 at 3:36=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sat, 15 Aug 2026 23:27:27 +0530
> Yash Suthar <yashsuthar983@gmail.com> wrote:
>
> > The FIFO and read_raw buffers are passed to regmap bulk/raw reads
> > ,which is not DMA-safe.Moved them into struct bmc150_accel_data
>
> Move the comma up a line.
>
> > after scan, each aligned to IIO_DMA_MINALIGN.
> >
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
>
> My main question here is around locking and whether we need
> to space all 3 buffers out in a cache line each. That is painful
> on some architectures.  If we ensure that DMA to one of these
> never overlaps with the CPU accessing a different one, then we can
> just mark the first one as IIO_DMA_MINALIGN.
>
> Jonathan
>
> > ---
> >  drivers/iio/accel/bmc150-accel-core.c | 14 ++++++--------
> >  drivers/iio/accel/bmc150-accel.h      |  5 +++++
> >  2 files changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/=
bmc150-accel-core.c
> > index 89a475ef9a9b..e8d27fd1be3f 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -125,7 +125,6 @@
> >  #define BMC150_ACCEL_REG_FIFO_CONFIG0                0x30
> >  #define BMC150_ACCEL_REG_FIFO_CONFIG1                0x3E
> >  #define BMC150_ACCEL_REG_FIFO_DATA           0x3F
> > -#define BMC150_ACCEL_FIFO_LENGTH             32
> >
> >  enum bmc150_accel_axis {
> >       AXIS_X,
> > @@ -622,7 +621,6 @@ static int bmc150_accel_get_axis(struct bmc150_acce=
l_data *data,
> >       struct device *dev =3D regmap_get_device(data->regmap);
> >       int ret;
> >       int axis =3D chan->scan_index;
> > -     __le16 raw_val;
> >
> >       mutex_lock(&data->mutex);
> >       ret =3D bmc150_accel_set_power_state(data, true);
> > @@ -632,14 +630,14 @@ static int bmc150_accel_get_axis(struct bmc150_ac=
cel_data *data,
> >       }
> >
> >       ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(a=
xis),
> > -                            &raw_val, sizeof(raw_val));
> > +                            &data->regval, sizeof(data->regval));
> >       if (ret < 0) {
> >               dev_err(dev, "Error reading axis %d\n", axis);
> >               bmc150_accel_set_power_state(data, false);
> >               mutex_unlock(&data->mutex);
> >               return ret;
> >       }
> > -     *val =3D sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.sh=
ift,
> > +     *val =3D sign_extend32(le16_to_cpu(data->regval) >> chan->scan_ty=
pe.shift,
> >                            chan->scan_type.realbits - 1);
> >       ret =3D bmc150_accel_set_power_state(data, false);
> >       mutex_unlock(&data->mutex);
> > @@ -918,7 +916,7 @@ static int bmc150_accel_set_watermark(struct iio_de=
v *indio_dev, unsigned val)
> >   * frame data is discarded.
> >   */
> >  static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
> > -                                   char *buffer, int samples)
> > +                                   void *buffer, int samples)
> >  {
> >       struct device *dev =3D regmap_get_device(data->regmap);
> >       int sample_length =3D 3 * 2;
> > @@ -941,7 +939,6 @@ static int __bmc150_accel_fifo_flush(struct iio_dev=
 *indio_dev,
> >       struct device *dev =3D regmap_get_device(data->regmap);
> >       int ret, i;
> >       u8 count;
> > -     u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
> >       int64_t tstamp;
> >       uint64_t sample_period;
> >       unsigned int val;
> > @@ -993,7 +990,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev=
 *indio_dev,
> >
> >       count =3D min_t(u8, count, BMC150_ACCEL_FIFO_LENGTH);
> >
> > -     ret =3D bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
> > +     ret =3D bmc150_accel_fifo_transfer(data, data->fifo_buff, count);
> >       if (ret)
> >               return ret;
> >
> > @@ -1008,7 +1005,8 @@ static int __bmc150_accel_fifo_flush(struct iio_d=
ev *indio_dev,
> >
> >               j =3D 0;
> >               iio_for_each_active_channel(indio_dev, bit)
> > -                     memcpy(&data->scan.channels[j++], &buffer[i * 3 +=
 bit],
> > +                     memcpy(&data->scan.channels[j++],
> > +                            &data->fifo_buff[i * 3 + bit],
> >                              sizeof(data->scan.channels[0]));
> >
> >               iio_push_to_buffers_with_timestamp(indio_dev, &data->scan=
,
> > diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc15=
0-accel.h
> > index 9deff256aed5..8f64b24339e4 100644
> > --- a/drivers/iio/accel/bmc150-accel.h
> > +++ b/drivers/iio/accel/bmc150-accel.h
> > @@ -56,6 +56,8 @@ enum bmc150_accel_trigger_id {
> >       BMC150_ACCEL_TRIGGERS,
> >  };
> >
> > +#define BMC150_ACCEL_FIFO_LENGTH             32
> > +
> >  struct bmc150_accel_data {
> >       struct regmap *regmap;
> >       int irq;
> > @@ -81,6 +83,9 @@ struct bmc150_accel_data {
> >               __le16 channels[3];
> >               aligned_s64 ts;
> >       } scan __aligned(IIO_DMA_MINALIGN);
> > +     /* DMA-safe buffers for bulk/raw reads */
> > +     __le16 fifo_buff[BMC150_ACCEL_FIFO_LENGTH * 3] __aligned(IIO_DMA_=
MINALIGN);
> > +     __le16 regval __aligned(IIO_DMA_MINALIGN);
>
> This is potentially a lot of padding that might not be necessary.
> What locking protects these?  I'd kind of expect all 3 to be used
> under a single lock.  If that's the case and locks are held for all
> such usage, then we can just force alignment of the first one.
>
>
> >  };
> >
> >  int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap,=
 int irq,
>
