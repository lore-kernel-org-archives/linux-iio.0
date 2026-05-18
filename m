Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805CC38E5C4
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139628; cv=pass; b=pCzjV81+eYa5hyuZ+3xPJxscGVbNXr/i61rX2tO8vbwt/KW253xajT5ENuLMqPxJR6dYpzxxrVmowtlhfpt9420pFSEzvr5PUqysY6R+RNoQYZBb2A8ac/jLoqe2ccg9MIbwcXehemLgfcPM87qoquNhrqe7mJV1O/Hbdw7nlvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139628; c=relaxed/simple;
	bh=nxPytq5XAr6ypQMasFz4amNrG1i4LJ9r02D9OyHCQSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwsnpBdd4zqWVSIaZrbPFMKJ8AmKMN7RBKUhA9g2Rz7sag/EBAyQm+DnKB0o/UXOLM0EGx5V/fI55BbmnRtJ/uUVcdQfTNjw2TZIArtGCYnaoKKu2dgbBvMeouQ2icrXZscsWlq3tA58lCx0h50nqiKrAVP7ZdZhgLp6CSxPoCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfL+FRVJ; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfL+FRVJ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a982409563so3641383e87.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 14:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779139625; cv=none;
        d=google.com; s=arc-20240605;
        b=PMuxKtrXcbVC+peVubeykiMp7DgTxJ+k6qLlXOY4A6+NViJj1PY19HOXYRTNKZmpX/
         TS70g3D3I2YhVvruqnnru5mfc7n+oOeZY73aC6lhwCOg/D+xJM/HaZoUCuaFpvtJ4ee5
         ziqUzdKbxoaX8sV+D0Gzimi6xV+osuLS/mkyy7eJIfgwW4c/G5NQk3MEK5MlVd4vgPcs
         NX3Xr8m86c1naghnGEzcxsts2bUwcdpxovwy9auIHqQTVG514tL7cHKiyJ3wdstZAwTQ
         1Wf2aqCcCJsg00Np0s+Pc4ouFed4eK9X4R/bJSYUqrlrq6OScRk5CJd9atPeMa14nVFs
         oMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NXcI82h8LzUQR1Vm7aPakkDi0vBXkkrNR+KatJkgbcA=;
        fh=9dpjNrQHYalBk/Meshyos9qNFP9eL/XeIfXmwpE1f1E=;
        b=E8SEwIOaAJPZak2Xdx0JU/+cHRdBqGA4s4z10j+7M654+FeYr+7Km1OW4lvEwqPSia
         YpZm+G4ZDADn3gSpilrooVTwjKh9apszqnrb/M8svq8Y7OoLjSFGRWfo7nxOmJEGYcLa
         Am8in/LK5YJRjARwSq+vO9tkRtUWXEpvQJSGfIctHQ1GdhVgUk0k2HBQpylx1ErpMfSx
         NWN/nt5jy7A//S7Nk6idUMscE1ZwEYS4Hv5FC1LZ5jrNObuxIf1OyPYejAx/uT/ucF3b
         2hcRrAGYUbDvWfa4Jr4F0f5XYR8fBxhHldO7jfN/4nTEIyIi0KcLKY2Sc9iRFvDN118R
         zXkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779139625; x=1779744425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXcI82h8LzUQR1Vm7aPakkDi0vBXkkrNR+KatJkgbcA=;
        b=ZfL+FRVJyOBzUDhFzi762eoA3qj2x/5nXLfhPuNtcDoMsr9LF0BWKS12p/Kd4wYGuk
         QK6W/3402uVVb3pdg0qJqoWwvjk+tLYW5vAfBBXsUu3Lqz0Q5fBVaxI+nCFNfSogm3+k
         t+ZegKBG6c1aXMVkDO5mh4F0yCyLe5QEA670L9dtdGAeN8fvZhAmjyrxtWjG2EwFT3ZQ
         oSgHudtV6lp770Zbm3QpzxDdYHQpg9RiRmsO+qQpe9EQ2IUiL/FDnkPKVVWeIM2RyPD7
         w6K9EWZVFuA0HWNY4WRHkpv0rYQPJNk/iAdGWe0tBXUb7cefGYSxoJAIqycEzgWaVTIx
         j8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139625; x=1779744425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NXcI82h8LzUQR1Vm7aPakkDi0vBXkkrNR+KatJkgbcA=;
        b=piAaBBtOtq/i7vobkdrdyBFskefKBXCIBC1BRTnHTpxB6lePK5riWogbW9iHE5uE2i
         +H4qj5yzNu9lOqEFdScO0DZM7cU+zWshYW/YVdYpicenNAohIfaVim36SGxxNfbskO7O
         wk/cTKXJ2f2PLV7XdY9TfVHNoOqnB/tjdzWWgnaV33JFhXruXdHo1ce+KQIaVLwncobt
         h6HXyiCcBLMPoB5q9OSUsnHI6A2i65OoeOceX945x9mZY+ipHGolSZsnPvS2VwsPUo/K
         rYi2kqA9Oy2ohcYTbRSt7HmzbqE/pcfiPdNErlbCUU4E8CnKisX7tHjf6pFdGINdWTld
         oNew==
X-Forwarded-Encrypted: i=1; AFNElJ8zb8Dt5AuYnV5CWOQq8Fxpz/imsSKERzEpOMRNb8XoEanwN3ahG4YbM+d/cMHUu4vMf3fpAhBQuow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2PAhLS9/LDnI0I76KEMHXZ/Tw6y+eZ++dDn30b5b5TMod2Z1r
	8WJ+iv3EryRFNODg+PE0+Ebu6nE1j5+8M+0s9N/313m7AQNYB5LPJJ+hl5goUCKZyXnAfAorXsH
	oftwbIJJLRFwJiiXB3F1mbBCBaPIEJYo=
X-Gm-Gg: Acq92OEjw3cUJ35X6fOO9smJEHTxktN53g+fhktXDVUyIAOcsUgjzzJhzwhrA3x2Q0u
	7e/Bi1Tz0ZlxJfKfxJJ9IrKmpIiXUtl0GsMOWC5wyi6wcdVuTx0d9mvAYbSannNAKyazvB9mrNC
	gPtJntzIQwPpTKWPzffu+QTbmVkOfZbxzEe677wMFOuJuhy0VjPHrspJ7VnBPv8i64fr9Lzl53F
	sgRIghB+WN1fpKto/+NMJT8mGIoQgSqP6T+AkMH6usfpQ8RAaZv4eCDwLLCnFWVp/84wgviQkNG
	rnVZtJ/oHKZhjx3jOUp9ebBm2UbxJBD7JUtjMP4=
X-Received: by 2002:a05:6512:39d0:b0:5a8:9b6a:5749 with SMTP id
 2adb3069b0e04-5aa0e7649eemr5139908e87.28.1779139624308; Mon, 18 May 2026
 14:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
 <20260511174342.123820-7-piyushpatle228@gmail.com> <20260512131905.42c35224@jic23-huawei>
In-Reply-To: <20260512131905.42c35224@jic23-huawei>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Tue, 19 May 2026 02:56:26 +0530
X-Gm-Features: AVHnY4KtXRxseogZwL6x1v83BXS5ovpqyHMus-9P32wYoM0i3oW_u29ke3e90Zk
Message-ID: <CAMB+xkZUeDaca9Pr22DE9P7wJv1b=iBA743YaqxKOXj0Dyb37g@mail.gmail.com>
Subject: Re: [PATCH v8 v8 06/11] iio: adc: hx711: introduce hx711_chip_info structure
To: Jonathan Cameron <jic23@kernel.org>
Cc: ak@it-klinger.de, andriy.shevchenko@linux.intel.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 5:49=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 11 May 2026 23:13:31 +0530
> Piyush Patle <piyushpatle228@gmail.com> wrote:
>
> > Add a per-variant static configuration structure and populate the IIO
> > device fields from it at probe time.
> >
> > This is a preparatory change for adding support for more HX711-compatib=
le
> > hardware variants without duplicating the probe-time setup.
> >
> > No functional change for existing HX711 users.
> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> Mostly for my reference when v8 sashiko comes in - there was feedback on =
this
> in v7 but it was something we don't care about - in a driver that support=
s
> multiple parts - if someone is using the legacy path to force a driver ma=
tch
> we can't do the right thing - guessing it is an hx711 is not appropriate.
>
> Given it is vanishingly unlikely (famous last words) anyone is using that
> path with a device like this one (who isn't a developer who can easily fi=
x
> that) let us merge this and see if anyone screams before trying to
> deal with that case.

Ack. I will keep the code as-is and add a short note below the --- line for
the Sashiko reports.
For __counted_by_ptr(), this looks like a false positive. The annotation
was added based on your v7 feedback and builds fine on the current
mainline and for the legacy probe concern, I will note that this was discus=
sed
and accepted as very unlikely to affect real users, so I am not adding a
fallback path.
>
> I'm going to hold off for now though as waiting on v8 sashiko review of t=
he
> rest of the series.
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/hx711.c | 41 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 36 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> > index 86d2a70dd3de..10ccc69f209b 100644
> > --- a/drivers/iio/adc/hx711.c
> > +++ b/drivers/iio/adc/hx711.c
> > @@ -4,6 +4,8 @@
> >   *
> >   * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
> >   */
> > +#include <linux/array_size.h>
> > +#include <linux/dev_printk.h>
> >  #include <linux/err.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > @@ -74,6 +76,20 @@ static int hx711_get_scale_to_gain(const int *gain_s=
cale, int scale)
> >       return -EINVAL;
> >  }
> >
> > +/**
> > + * struct hx711_chip_info - per-variant static configuration
> > + * @name: IIO device name
> > + * @channels: channel specification array
> > + * @num_channels: number of entries in @channels
> > + * @iio_info: IIO info ops for this variant
> > + */
> > +struct hx711_chip_info {
> > +     const char                      *name;
> > +     const struct iio_chan_spec      *channels __counted_by_ptr(num_ch=
annels);
> > +     unsigned int                    num_channels;
> > +     const struct iio_info           *iio_info;
> > +};
> > +
> >  struct hx711_data {
> >       struct device           *dev;
> >       struct gpio_desc        *gpiod_pd_sck;
> > @@ -81,6 +97,7 @@ struct hx711_data {
> >       int                     gain_set;       /* gain set on device */
> >       int                     gain_chan_a;    /* gain for channel A */
> >       int                     gain_scale[HX711_GAIN_MAX];
> > +     const struct hx711_chip_info    *chip_info;
> >       struct mutex            lock;
> >       /*
> >        * triggered buffer
> > @@ -456,8 +473,16 @@ static const struct iio_chan_spec hx711_chan_spec[=
] =3D {
> >       IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> >
> > +static const struct hx711_chip_info hx711_chip =3D {
> > +     .name           =3D "hx711",
> > +     .channels       =3D hx711_chan_spec,
> > +     .iio_info       =3D &hx711_iio_info,
> > +     .num_channels   =3D ARRAY_SIZE(hx711_chan_spec),
> > +};
> > +
> >  static int hx711_probe(struct platform_device *pdev)
> >  {
> > +     const struct hx711_chip_info *chip_info;
> >       struct device *dev =3D &pdev->dev;
> >       struct hx711_data *hx711_data;
> >       struct iio_dev *indio_dev;
> > @@ -473,6 +498,12 @@ static int hx711_probe(struct platform_device *pde=
v)
> >
> >       mutex_init(&hx711_data->lock);
> >
> > +     chip_info =3D device_get_match_data(dev);
> > +     if (!chip_info)
> > +             return dev_err_probe(dev, -ENODEV, "missing driver data\n=
");
> > +
> > +     hx711_data->chip_info =3D chip_info;
> > +
> >       /*
> >        * PD_SCK stands for power down and serial clock input of HX711
> >        * in the driver it is an output
> > @@ -534,11 +565,11 @@ static int hx711_probe(struct platform_device *pd=
ev)
> >       hx711_data->data_ready_delay_ns =3D
> >                               1000000000 / hx711_data->clock_frequency;
> >
> > -     indio_dev->name =3D "hx711";
> > -     indio_dev->info =3D &hx711_iio_info;
> > +     indio_dev->name =3D chip_info->name;
> > +     indio_dev->info =3D chip_info->iio_info;
> >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > -     indio_dev->channels =3D hx711_chan_spec;
> > -     indio_dev->num_channels =3D ARRAY_SIZE(hx711_chan_spec);
> > +     indio_dev->channels =3D chip_info->channels;
> > +     indio_dev->num_channels =3D chip_info->num_channels;
> >
> >       ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> >                                             iio_pollfunc_store_time,
> > @@ -555,7 +586,7 @@ static int hx711_probe(struct platform_device *pdev=
)
> >  }
> >
> >  static const struct of_device_id of_hx711_match[] =3D {
> > -     { .compatible =3D "avia,hx711", },
> > +     { .compatible =3D "avia,hx711", .data =3D &hx711_chip },
> >       { }
> >  };
> >
>
