Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E237C3546C2
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147983; cv=pass; b=WxtZiIg/Thb6DO2qHd4gWi+Pi8OObj+VV/RCPKOauBsLDfdfIpfAR5fOJhOsXM5SUBZe30Q3mhIWxzDecPjHQrT4X/Nu++Lt195+9ZjdvIU2eP67pJCMPOSiWvCXRdZPaMBaL+sMJx5F6yXnv0ejS0w6CG8BQHYeftk1l8GGMnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147983; c=relaxed/simple;
	bh=L/Zna6URqXyzVfJdb3caqyH2x3byxNdGLxMMgpga9w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDn2UWrQG7ljgfUZRgrgakrN97+bBducGhagKIIuDChhCe9p899TJLmtF6e4JG+ssBInZduCwF+7/huMVmJ9BMaLlxtY5tjmziY1d+/gNfUI/maWluTtR0pwnk7eYpGNdkHcsMVz682OdgsuyNHfqrpAW5qmS+oQl9eyoxrdxdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFy2sEDx; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFy2sEDx"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68ad1e513d3so4379197a12.0
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 06:33:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780147980; cv=none;
        d=google.com; s=arc-20240605;
        b=cIcS9vuGEncAr93STwtyrsXkBgh407ySVYTb1PBQD+Kx9I7Vo0c9fa/zC6Tt2/PT7L
         YJX6b7K1jexhLe4svHoXfVSFI4QUarvSdJGSsz074mEGtz8KdY0fs97VLM1SgW7WUbDB
         L1xpTldzQCBKR1q9rbby4vdxqfitvDKKYi2GtHJTBowWqajLARA1a1AYD2lnLffWgAf3
         p0pkumYX6C1FutXQEgmfWj0A6cFzTlk4/4j/zJnvqIwZ9ZnJfA/ChixrjXbvxKwMRWxq
         3Yr9svcJ6Bdy8rZXFjIQ9AmyqDn+WNsymxWYvkyrzeIPlAgYHRZYYu4dGJN81ylk7z10
         djbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4VWEUBWF7KBd1rVzFSzp+Xk2pu4Cot8nnx4EEqEDLwU=;
        fh=QQ5CJAmVEtLcyg86pg4oUUolKCDGCP3aiw+8wg8EV0w=;
        b=U7VPKEju8LP9MxOkGo5Wp+4nnWko55XFsqXjiKUSU8eBbSRRlrjF/XlZK6MB3KkIpd
         cA0yyzN5Yh1r9cOL0zoBTD/FFUpEI2Uvn8kLbXgQAcbx299jxsXAnxXSwuaEjLdOhfeF
         Cdn2wUSbwhi1CIOXJvsK8jo8YxAafhjBUhEBuDQdz7xNpUMiPsZ+aM7VcWHHiiWcrYa2
         6x5ED7dR789mRBvB8KET7QL4YSMDt96r4u5rVb2xWX380y5OG7ntcZ7BdHu+WzqymduF
         oNO668i/K6QMjmA0HPXke2oKQ7ZErLU0gDSS+GpCmTmNAbZT83EIrOP3Qra6TNmBkn8o
         EbdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780147980; x=1780752780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4VWEUBWF7KBd1rVzFSzp+Xk2pu4Cot8nnx4EEqEDLwU=;
        b=SFy2sEDxmmglPZkqRtR9+KHq1D/RxbWKsHhozUifIRbupSNKPr+Lz21Eo6XtNGyFmk
         77Hi98XRaJkVKRjLFlf18pocACKJdmQXmhPIW6Y3LrmnrTZ3dXugKgmmzr26SCIRfNm1
         ipm6/FKPGAjHKJy1Px6cFAvp35mqQkZHsteVNWtB0pUT6e62cDjoufaA/UHh4rJMOO9W
         FJo92P5IeFw5ZHvW3XUdcch9ztmqy9In+H4VtiA8W1/BKYN5BFrfx/CQsrAu9h1cKNir
         7GU1Aph8UK1PZrBI2HtjQtDu0gIsa2Coj2Afh01TMIBjO+1P2X3MtPTE+F/39Q1inCZ2
         iH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780147980; x=1780752780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4VWEUBWF7KBd1rVzFSzp+Xk2pu4Cot8nnx4EEqEDLwU=;
        b=HBPwo7JT6tfwVcLIIdlo41dFpJbFUvboTDH+kircA84WPRSzTguTyzb0KWV5L5+22r
         SuRslYhILzbLEAALyrp1oVm9RaCyUnzVNlUQFs93j/sUWP3HeVt3y1Gl/QyrRX2Bslc8
         TRsc5uNlmNl5wfXWvCqc4CH4PXHBVckeuKZ6cwGS9z5L+jrdn/d7kmhlbQtLbHeBFsZE
         iw/xDJBXjfqlW+Chb3XSOY3uUWnL8F6YpNWPHOP8yv6S3CGC/jx9M+yVJEkQKI+0n4eU
         r0GMQC+pUEFhPXVJ9Kcp3IkRlaVBCUxdvT/rYO8VGwLfTT9K5kS7n8HHZB6iVbPhted+
         cu4w==
X-Forwarded-Encrypted: i=1; AFNElJ/XfwgQ1dhlRWLru8VCX1f9LQHl2UXVXHVvs74C5VkuQ60w1quuDP4C8/mr3E8VMi5M4sCtbMssPpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DbChxg1vLhRWgqgJ+al7WvDVtvOViYNj6b4M6BOoEnZWFwbP
	abWhjUpFmPAwpZiQicmehwwWK8g17KNVNvRmol6rabZ0kXumnJUqIYm/hnlBZo8tSX4GB9Gli11
	FkpPfB1TuXJvg9yI3Pbmu6M2ZTc92DnZhSR9fTc6pJg==
X-Gm-Gg: Acq92OHpdm7hE+jjBDuS92DPnao+nzq6ROc5/wFiDLPoN2zQe4d82k/yTQT+xeDLKSe
	fhFOaXqAVQIZ4Q81aJwsy2jXVfrYcgJv4ee1kEgyiEM40JArOjgAjPP+tihfl6RF6ev5AEDik1x
	I38+BP2brdO+tfCjYr+Z1H8qLWdjTFFR+9PKgwekaFcUs3QMLw51+DHSOrUnKwm2uTpmxvvMVzU
	/Igzbl2qVnT1PGgQbgESXBh6e1bzalpUTHAyPoFlhSCk1Usjy3u/04zDnLxL0260VRnodjGFBVE
	Zt8gkbpxR2oUv5XufpYQ8ZQVaPwp42qJhNszJqb8kT9WkfA8CTrpmqJ+VKU7V1armmuYYBZiSMY
	OZ4zBBnIzaagdsq8xAQ52kwoEZkbjMfLBfdyTh9Gj3Crjr62AZz2AS80ft6HFj7f0HQIBlh0U1f
	dbq7b5
X-Received: by 2002:a17:907:1dc4:b0:bab:ba5a:fcb8 with SMTP id
 a640c23a62f3a-beab78b54edmr128024966b.32.1780147980188; Sat, 30 May 2026
 06:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530113938.171540-1-suunj1331@gmail.com> <20260530113938.171540-5-suunj1331@gmail.com>
In-Reply-To: <20260530113938.171540-5-suunj1331@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 May 2026 15:32:23 +0200
X-Gm-Features: AVHnY4JGtN-bFKVfNa_oaVFPXwDdfk9n2OhCT6NCdPj5SfXTexBuP7-erJSeYz0
Message-ID: <CAHp75VcN7B5BdKZGBiw5cbhYesGsO_tStcN3cKgggiHiuSnJ7w@mail.gmail.com>
Subject: Re: [PATCH 4/4] iio: pressure: mpl3115: add hardware FIFO support
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, apokusinski01@gmail.com, 
	me@brighamcampbell.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 1:40=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> Add support for the MPL3115A2 hardware FIFO.
>
> The device provides a 32-sample FIFO with configurable
> watermark interrupts, allowing buffered data acquisition
> with reduced interrupt and CPU overhead.
>
> Use a kfifo-backed IIO buffer when a DRDY interrupt and
> SMBus block reads are available, falling back to the
> existing triggered buffer implementation otherwise.
>
> When enabled, the driver configures the FIFO in circular
> mode and drains accumulated samples on watermark
> interrupts.
>
> Overflow conditions are handled by flushing available
> samples before resetting the FIFO, avoiding unnecessary
> data loss.
>
> The hardware always captures pressure and temperature
> samples together, so FIFO operation requires both channels
> to be enabled.
>
> Register cache updates are performed only after successful
> I2C writes to keep cached and hardware state consistent.
>
> No functional change for non-buffered operation.

...

> +       u8 fifo_buf[MPL3115_FIFO_SIZE * MPL3115_FIFO_SAMPLE_SIZE]
> +               __aligned(IIO_DMA_MINALIGN);

We have a macro for this,

...

> +static int mpl3115_fifo_flush(struct iio_dev *indio_dev)
> +{
> +       struct mpl3115_data *data =3D iio_priv(indio_dev);
> +       u8 buffer[MPL3115_BUF_SIZE] __aligned(sizeof(s64)) =3D { };

Don't we have a macro for this?

> +       unsigned int sample_count, i;
> +       int ret;
> +       bool overflow;
> +       s64 ts;
> +
> +       ret =3D i2c_smbus_read_byte_data(data->client, MPL3115_F_STATUS);
> +       if (ret < 0)
> +               return ret;
> +
> +       overflow =3D FIELD_GET(MPL3115_F_STATUS_F_OVF, ret);
> +       sample_count =3D FIELD_GET(MPL3115_F_STATUS_F_CNT, ret);
> +       if (sample_count =3D=3D 0)
> +               return overflow ? mpl3115_fifo_reset(data) : 0;
> +
> +       ret =3D mpl3115_fifo_transfer(data, sample_count);
> +       if (ret)
> +               return ret;
> +
> +       ts =3D iio_get_time_ns(indio_dev);
> +       for (i =3D 0; i < sample_count; i++) {

  for (unsigned int i =3D 0; ...) {

> +               u8 *sample =3D &data->fifo_buf[i * MPL3115_FIFO_SAMPLE_SI=
ZE];

> +               memcpy(&buffer[MPL3115_BUF_PRESS_OFFSET], &sample[0], 3);
> +               memcpy(&buffer[MPL3115_BUF_TEMP_OFFSET], &sample[3], 2);

These two sound to me like something which might require endianness
handling, but if you put this as CPU native one and leave user space
to take care of, it may be okay.

> +
> +               iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buf=
fer), ts);
> +       }
> +
> +       if (overflow) {

> +               dev_warn_ratelimited(&data->client->dev,
> +                                    "FIFO overflow, samples may be lost\=
n");
> +               return mpl3115_fifo_reset(data);
> +       }
> +
> +       return 0;
> +}
> +
> +static int mpl3115_set_watermark(struct iio_dev *indio_dev, unsigned int=
 value)
> +{
> +       struct mpl3115_data *data =3D iio_priv(indio_dev);

> +       value =3D clamp_val(value, 1, MPL3115_FIFO_SIZE - 1);

Why not clamp()?

> +       guard(mutex)(&data->lock);
> +       data->watermark =3D value;
> +
> +       return 0;
> +}

...

> +static int mpl3115_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +       struct mpl3115_data *data =3D iio_priv(indio_dev);
> +       u8 ctrl_reg4;
> +       int ret;
> +
> +       guard(mutex)(&data->lock);
> +
> +       ret =3D mpl3115_set_active(data, false);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D mpl3115_set_fifo(data, MPL3115_F_MODE_CIRCULAR);
> +       if (ret) {
> +               mpl3115_set_active(data, true);

Instead of having an argument, just make two helpers: set_active() /
set_inactive().

> +               return ret;
> +       }

> +       ctrl_reg4 =3D data->ctrl_reg4;
> +       ctrl_reg4 |=3D MPL3115_CTRL4_INT_EN_FIFO;
> +       ctrl_reg4 &=3D ~MPL3115_CTRL4_INT_EN_DRDY;
> +
> +       return mpl3115_config_interrupt(data,
> +               data->ctrl_reg1 | MPL3115_CTRL1_ACTIVE, ctrl_reg4);

In some cases the FIELD_PREP()/FIELD_GET() is used, why not use FIELD_MODIF=
Y()?

> +}

...

> +static const unsigned long mpl3115_scan_masks[] =3D {
> +       BIT(0) | BIT(1),
> +       0,

No comma in terminator entry.

> +};

...

> -       ret =3D devm_iio_triggered_buffer_setup(&client->dev,
> -                                     indio_dev,
> -                                     NULL,
> -                                     mpl3115_trigger_handler,
> -                                     NULL);
> -       if (ret)
> -               return ret;

Before modifying this, it might make sense to split necessary bits to
the helper function and then simply reuse it as needed.

--=20
With Best Regards,
Andy Shevchenko
