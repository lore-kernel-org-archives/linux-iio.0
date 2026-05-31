Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D13839AA
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780226162; cv=pass; b=P5erI7/SCswQd75Ei051MbjhX0Oj5QmbjFju9eCbtogozwZ2HWuTP6HuyvL/1WLzEirSU8nWI8EcoSur0trp5mwTL0NfFtW6jyK9r/TJjbprhvPC4rV/dkugN/0VhWg31QBoz4LhXp4+2hiusX0ncHUZpm/gVO8IX/jDMEJtRzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780226162; c=relaxed/simple;
	bh=faHcfbpClcU4o+L38iaJU1ZD8GaunZRXjtU6wI0XuXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVA++ouuxgR39sFmlYbL6dhcBoQnWflMu6CHEUxmgz8y35G1w1BIwHygeXHBXGL9QknSe1HfhJRX1+SyH2pc00RcUuVCrGawTiVnDOwktk8ULkIBKwyCTi/Wm3jSPSInIYltzluIdUbvfDD/8mUu0pFYabkEIyQc0Tl8Wuu+ucQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVRsoIvy; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVRsoIvy"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6b55bf04eso445317a34.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 04:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780226159; cv=none;
        d=google.com; s=arc-20240605;
        b=LJWTvn6CdtrJpi8jWRB5YV9MnVyJoho8Ciiyo5GcxrLXDIB4333bUcmj+Hjp5leX1s
         cc5M42qBpwGm9y1MQBqtCy+DhkgC8kwG4PfWQm88/mPU+bAAneKAe6RlLhJV2hIvhwtv
         7S9X1SjK8OuJLgALSKqOXP/Imdcvbh88rOqGGO3iyAA31rlCusyO8ycdNal+lOiE3ZrN
         ZOWoEZD9oUaIDUncejkfXdVV680k5t/yNP7zNF4sTAsDFThB9xIIQl4dEYqR9HfliyiY
         y6mHyWxxQQgLEVRPEV+3dlbApBW50f6xuHPjAjULmllEVeDrVRM53DPY7FbNwu/Soyqg
         MOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bd2Xvn82ajx4EmMFtsNWklXrswUhyjI8fLCmJWocdxw=;
        fh=xs2IsSDtbe9AwRg9QedLZm/6w4R/H1WHMDPVjwLTQik=;
        b=g9V3jC3Uv3LPDC2g8dULtQkQHL14Rff5qG9hBwDC2av6dUU0Arg1OlUP39msZM/Kxc
         IcTFk2R7PoG0+lK4k9YLs1bXMDxa1RF9ZXy+WcecKq4R3JlRfQujB6SWiu9Y8Li+3Kfl
         /732O0RaoqjVu7WqB7S0cV+U4MrJ1ZUWCt2VIludpD/7fe7jCjfHD4XZXb3LqmEidXl7
         1TdRjK5ZeRECniPhbRCOBy2zRio+67pgC8bwuXdktQZE/jie1Br8yMHPu1ilm9SoemsD
         ymAdpS/fz4EyWjM9rHbtvGnQfIy6kl5eVe1Zk8rCiO4SUw9sYazz3DrkdX5xOqaURTKh
         uynw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780226159; x=1780830959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd2Xvn82ajx4EmMFtsNWklXrswUhyjI8fLCmJWocdxw=;
        b=oVRsoIvylOS40o5q3koqjIfmkB8d24Qu5u1Pe99s+dK+8dtidSzX7VRMR/o73yrn6U
         241ratabiZWFypppYWpff5mqerxjR+kzVlv/0CKJ1JWi9BOPpl1NyiZvdczMm/ux5ec0
         Y6WGhqdSLu6XT4xSVB5RcmxbmttDJ0i/n80kzz77m2g7GcWi2GK9A4CQcoY+cdvrqmXd
         nDazHUputPCV86Y5kdeqAQZtOeiC6y0lpmqTmdQ5658rVvMDlLKymKEjb8lLVtQ+GN/b
         pJSjm14CaSxC6+rl3ACcXXJc4BgDDvwhgwIwL9sNVrtPxSIwrT+roy4LKeWUSR09Wgo5
         QoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780226159; x=1780830959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bd2Xvn82ajx4EmMFtsNWklXrswUhyjI8fLCmJWocdxw=;
        b=odISBlOPjPjdKuenJw8RcSLcF6HDFFMjkEAXLNNqk8u3bsmA1Zb0zjpIQr7FzdiosE
         Mt6J4dRpM5t1A+t10ToTPlXB85YBjCLlZohRIjBlb6MGAc2dPdinE7nHFMScJ9arvYTb
         ysHoHnL8e7Nu20GyAJOHh/2Y/ZMM9vBv4bf8TgOmutg81mMTLc283GeeyceZRn/rBoq3
         EOuotpx5RPjmQcYkm8zme6cF0yFJnswxffqLz+Fnf154GOcJbzpW+KO0OhntYdgZLQQS
         g6kyycvbh9Wkp3i7XLhDF9JjF1yg6qk8vmi51plvxpBzSLw3cT0D5Q1GXXxv7Zl+wYAL
         d24Q==
X-Forwarded-Encrypted: i=1; AFNElJ9tpAY5De8uUds//0/DaHRSqMDplkYtwkwJxsxUzF23ysIaaxuffVztBWkqdDzZC59wJvInE6BZC0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtUmwzH1AZaPssq1cDkvOgTP3y63PTg6ZFbYhwqUkSLd0zpO1
	r+wPeZrYTdFAjs4tiG+KknYtXZo7msP0QJcO91w+/A6sKHQk5ZGD99/722uC4/j2iMxxOB4bM7b
	MR/NnCK7S4cEX9vZxxOlrNs0sU+VOsTM=
X-Gm-Gg: Acq92OH6OXjcPTqumrr1/+kydsMuPK7bJXXq5Uf2ItOm35r8VZ+V+GrxYhrI1pWJEcr
	ksc04KwZssDLfakO5V0nPk7gxhyM7bGL4JlKSdjTz3eyc2nISJHQLtm+gan4B96MNxz/JLNDXyh
	PjNv3WFRox0ay1oUWyXjMaAr5s/aJfOcvVN0obMZSBiPMbkWSYGShw+wHWo+Sl/D6/H9/p1UVuY
	ycpSB67KspoNNczHHVWKlaEAVzC2W4z22pNShqRmLasHtJzNwEXBoWftK3o1t8WjSIEEVxw7lXm
	Fz1nhRHtB3KFiC8men9/bRH8p5ESKKmMG/U/G8HUgaXjof4rsA==
X-Received: by 2002:a05:6820:3086:b0:69d:8b4d:53ba with SMTP id
 006d021491bc7-69e1053fa68mr2944911eaf.37.1780226158613; Sun, 31 May 2026
 04:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530113938.171540-1-suunj1331@gmail.com> <20260530113938.171540-5-suunj1331@gmail.com>
 <CAHp75VcN7B5BdKZGBiw5cbhYesGsO_tStcN3cKgggiHiuSnJ7w@mail.gmail.com>
In-Reply-To: <CAHp75VcN7B5BdKZGBiw5cbhYesGsO_tStcN3cKgggiHiuSnJ7w@mail.gmail.com>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Sun, 31 May 2026 20:15:45 +0900
X-Gm-Features: AVHnY4KPx0NSXU0gdfDXhQcY-GvsCUuHBJZCeL_LefC6__-IMJHMbSenQwFjoxQ
Message-ID: <CAGwK=3pJFnif5GToHOS_Y5uo6meGYNAZPp8qECjiDLUgcPdcrg@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: pressure: mpl3115: add hardware FIFO support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, apokusinski01@gmail.com, 
	me@brighamcampbell.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Sat, May 30, 2026 at 10:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> > +       u8 fifo_buf[MPL3115_FIFO_SIZE * MPL3115_FIFO_SAMPLE_SIZE]
> > +               __aligned(IIO_DMA_MINALIGN);
>
> We have a macro for this,
...
> > +       u8 buffer[MPL3115_BUF_SIZE] __aligned(sizeof(s64)) =3D { };
>
> Don't we have a macro for this?

I'll rework the per-sample buffer as a struct with explicit fields
(__be32 pressure, __be16 temp, aligned_s64 ts), as Jonathan suggested,
which removes the manual offsets and alignment here.

> > +       ts =3D iio_get_time_ns(indio_dev);
> > +       for (i =3D 0; i < sample_count; i++) {
>
>   for (unsigned int i =3D 0; ...) {

Will declare i in the loop.

> > +               memcpy(&buffer[MPL3115_BUF_PRESS_OFFSET], &sample[0], 3=
);
> > +               memcpy(&buffer[MPL3115_BUF_TEMP_OFFSET], &sample[3], 2)=
;
>
> These two sound to me like something which might require endianness
> handling, but if you put this as CPU native one and leave user space
> to take care of, it may be okay.

These are big-endian channels (scan_type.endianness =3D IIO_BE), pushed
as-is for user space to decode. The struct rework will make that
explicit with __be32/__be16 fields.

> > +       value =3D clamp_val(value, 1, MPL3115_FIFO_SIZE - 1);
>
> Why not clamp()?

Will use clamp().

> > +               mpl3115_set_active(data, true);
>
> Instead of having an argument, just make two helpers: set_active() /
> set_inactive().

Will split into mpl3115_set_active() / mpl3115_set_inactive().

> > +       return mpl3115_config_interrupt(data,
> > +               data->ctrl_reg1 | MPL3115_CTRL1_ACTIVE, ctrl_reg4);
>
> In some cases the FIELD_PREP()/FIELD_GET() is used, why not use FIELD_MOD=
IFY()?

I'll review the FIELD_MODIFY() usage and apply it where appropriate.

> > +static const unsigned long mpl3115_scan_masks[] =3D {
> > +       BIT(0) | BIT(1),
> > +       0,
>
> No comma in terminator entry.

Will fix.

> > -       ret =3D devm_iio_triggered_buffer_setup(&client->dev,
> > [...]
>
> Before modifying this, it might make sense to split necessary bits to
> the helper function and then simply reuse it as needed.

Makes sense. I'll look into factoring the common setup into a helper
so the FIFO and triggered-buffer paths can reuse it.

Thanks for the review.

On Sat, May 30, 2026 at 10:33=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, May 30, 2026 at 1:40=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.co=
m> wrote:
> >
> > Add support for the MPL3115A2 hardware FIFO.
> >
> > The device provides a 32-sample FIFO with configurable
> > watermark interrupts, allowing buffered data acquisition
> > with reduced interrupt and CPU overhead.
> >
> > Use a kfifo-backed IIO buffer when a DRDY interrupt and
> > SMBus block reads are available, falling back to the
> > existing triggered buffer implementation otherwise.
> >
> > When enabled, the driver configures the FIFO in circular
> > mode and drains accumulated samples on watermark
> > interrupts.
> >
> > Overflow conditions are handled by flushing available
> > samples before resetting the FIFO, avoiding unnecessary
> > data loss.
> >
> > The hardware always captures pressure and temperature
> > samples together, so FIFO operation requires both channels
> > to be enabled.
> >
> > Register cache updates are performed only after successful
> > I2C writes to keep cached and hardware state consistent.
> >
> > No functional change for non-buffered operation.
>
> ...
>
> > +       u8 fifo_buf[MPL3115_FIFO_SIZE * MPL3115_FIFO_SAMPLE_SIZE]
> > +               __aligned(IIO_DMA_MINALIGN);
>
> We have a macro for this,
>
> ...
>
> > +static int mpl3115_fifo_flush(struct iio_dev *indio_dev)
> > +{
> > +       struct mpl3115_data *data =3D iio_priv(indio_dev);
> > +       u8 buffer[MPL3115_BUF_SIZE] __aligned(sizeof(s64)) =3D { };
>
> Don't we have a macro for this?
>
> > +       unsigned int sample_count, i;
> > +       int ret;
> > +       bool overflow;
> > +       s64 ts;
> > +
> > +       ret =3D i2c_smbus_read_byte_data(data->client, MPL3115_F_STATUS=
);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       overflow =3D FIELD_GET(MPL3115_F_STATUS_F_OVF, ret);
> > +       sample_count =3D FIELD_GET(MPL3115_F_STATUS_F_CNT, ret);
> > +       if (sample_count =3D=3D 0)
> > +               return overflow ? mpl3115_fifo_reset(data) : 0;
> > +
> > +       ret =3D mpl3115_fifo_transfer(data, sample_count);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ts =3D iio_get_time_ns(indio_dev);
> > +       for (i =3D 0; i < sample_count; i++) {
>
>   for (unsigned int i =3D 0; ...) {
>
> > +               u8 *sample =3D &data->fifo_buf[i * MPL3115_FIFO_SAMPLE_=
SIZE];
>
> > +               memcpy(&buffer[MPL3115_BUF_PRESS_OFFSET], &sample[0], 3=
);
> > +               memcpy(&buffer[MPL3115_BUF_TEMP_OFFSET], &sample[3], 2)=
;
>
> These two sound to me like something which might require endianness
> handling, but if you put this as CPU native one and leave user space
> to take care of, it may be okay.
>
> > +
> > +               iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(b=
uffer), ts);
> > +       }
> > +
> > +       if (overflow) {
>
> > +               dev_warn_ratelimited(&data->client->dev,
> > +                                    "FIFO overflow, samples may be los=
t\n");
> > +               return mpl3115_fifo_reset(data);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int mpl3115_set_watermark(struct iio_dev *indio_dev, unsigned i=
nt value)
> > +{
> > +       struct mpl3115_data *data =3D iio_priv(indio_dev);
>
> > +       value =3D clamp_val(value, 1, MPL3115_FIFO_SIZE - 1);
>
> Why not clamp()?
>
> > +       guard(mutex)(&data->lock);
> > +       data->watermark =3D value;
> > +
> > +       return 0;
> > +}
>
> ...
>
> > +static int mpl3115_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +       struct mpl3115_data *data =3D iio_priv(indio_dev);
> > +       u8 ctrl_reg4;
> > +       int ret;
> > +
> > +       guard(mutex)(&data->lock);
> > +
> > +       ret =3D mpl3115_set_active(data, false);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D mpl3115_set_fifo(data, MPL3115_F_MODE_CIRCULAR);
> > +       if (ret) {
> > +               mpl3115_set_active(data, true);
>
> Instead of having an argument, just make two helpers: set_active() /
> set_inactive().
>
> > +               return ret;
> > +       }
>
> > +       ctrl_reg4 =3D data->ctrl_reg4;
> > +       ctrl_reg4 |=3D MPL3115_CTRL4_INT_EN_FIFO;
> > +       ctrl_reg4 &=3D ~MPL3115_CTRL4_INT_EN_DRDY;
> > +
> > +       return mpl3115_config_interrupt(data,
> > +               data->ctrl_reg1 | MPL3115_CTRL1_ACTIVE, ctrl_reg4);
>
> In some cases the FIELD_PREP()/FIELD_GET() is used, why not use FIELD_MOD=
IFY()?
>
> > +}
>
> ...
>
> > +static const unsigned long mpl3115_scan_masks[] =3D {
> > +       BIT(0) | BIT(1),
> > +       0,
>
> No comma in terminator entry.
>
> > +};
>
> ...
>
> > -       ret =3D devm_iio_triggered_buffer_setup(&client->dev,
> > -                                     indio_dev,
> > -                                     NULL,
> > -                                     mpl3115_trigger_handler,
> > -                                     NULL);
> > -       if (ret)
> > -               return ret;
>
> Before modifying this, it might make sense to split necessary bits to
> the helper function and then simply reuse it as needed.
>
> --
> With Best Regards,
> Andy Shevchenko
