Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC68518A6DB
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776590082; cv=pass; b=FB6BvQwGQh7ZZeS+zlsiBOLvrrTyhJbLdK1s1/7Fd3ngillDRYDuLiE1o2JP7UzUJzf1ruPaLAGoARt17zLUEf5QFqdOMLBpIvnQb8e8zgN489PPF+jajR8MaBlpt08qN9lK/sbVys08owD4CHCp1DtXu+oBlu8fa6GfGA8uMZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776590082; c=relaxed/simple;
	bh=UvclO64jRc9w/Q057Cus+8nS9Ex8jCnBvAvfd7NMF8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fw3/6iQ+RMpIAxifp8LQVDFmo1Yk5MaNwjqaIW8lLJ4qbafMoE71ttkEOOX/3HHNppCcg9acTBylqrWEuixQV66OLStOvpp3L57ai795+e7YPtBq3TbuaU8Nyxil3F+1kFsAX2qZJRupd6ydHgZUpm6ny/fGkeenTabQxRsvafE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHial1YN; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHial1YN"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38dd575bca3so30058821fa.1
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 02:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776590079; cv=none;
        d=google.com; s=arc-20240605;
        b=IPJw/mbw6xzUrInlm8vwZfqQC6tHrdHwEfTLUJ5KUvbqd/TM9HO72jX7HzXpJn9CKa
         EAkKYYruuoqj/MRwSwfVUtNqYeAAzBH72m9l1jEpTWANTXWWARG9dmM27cycsYvslvWs
         EFX1VimgLHeUlkplKFEVpKzUoYIedhCThOgx5boZUPo2pSZwS/iYIlikCZd8PrKQxcqf
         zZlAmDy9iEotX5Sq1mPTTSCvJD2Wf0VuyQd7lJO1IrMT2pcPDjNn2Vd8ft6zo7EXBDMv
         DJGNX+RJo7N7xWrums119ltFJ0jashMhn9dehtOJ0Ns+4kDc0N0PPX9m8kG/9+ZiMXQw
         yJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EC4YbXV/Z+P6jzKUiVUeV5CX07H1XyVW5UEExU7LeRc=;
        fh=KVbWdPbS9k4h0ApKLVWRAfaIp1SUVYIgPvTgvo0JgnI=;
        b=bM3WMoQa/FrQJHarNIvVkT51WeuXmx3mYg6+1a9DZmqbqEcbpY4cRf0nGk0Pp1BB53
         SGJUKvZyPt/gsxwepbyQZZEjpcbttcUoALmFg91O3lkZeFl+zAVIKv+na8FzBZYpioPw
         mWF91apwjqeqb2yb8p8TyAJTlN5Yi5lAx+Woo3kSpTyR4MLwDayu+beZNWw4fm0KOSxD
         uppd4SjP6SBQedSTgxCJBZ8FELTVGl2rNr012nSkUcedLd9fO+XFKsZ/3DgG9uUmY1De
         IBZZSZCWbPc4EGhOVqwknKeL6fyyhZuz63c79YDSm52hIuXo97OZM5nl2RydHcd1Mq0m
         XmDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776590079; x=1777194879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC4YbXV/Z+P6jzKUiVUeV5CX07H1XyVW5UEExU7LeRc=;
        b=cHial1YNX2m9cLPO7kowcSFolnwl2+5wEFTGUtZJfrNnUfaFwM0gxrF905f+8dMLKu
         AU3LvjsC9BJ/lRIvGp+DTMOODw+NSHrMCemfSYuNm3KnLaY9xN/dXjUbrtdYLGtfMvny
         Cx1Aran73rECSO8j5ofCSuv1g1tJpk2btQcfWwUbcYJ/cAB9Z/LD49gTBiyUbl/q2b7n
         c/uw1EAZrSc4BwQvtUWfqP67OVaZx4/4CMyGAxNtr4efyPTsz20R1PgD8obQZOgnaO24
         PuXUkYojNQL8gP3PYz3msxUTbueSRtA7/WxAAY8/h04wPrWv00TgGob2iWoHEfRQQrJ3
         QNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776590079; x=1777194879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EC4YbXV/Z+P6jzKUiVUeV5CX07H1XyVW5UEExU7LeRc=;
        b=qt3QLH+pxSWYuWsWqeqlVUAf6WQ9HcJQQq3vOwez5cNRJiP2wQUTUzCDhf3jaEaVoa
         +ASmlik6pHTGoAj2uPlwvFafmxBBsAFmGuNx3T5xsmlUB9saMp6nJpPTkWJxI7/o6V+a
         VBOX4d+cxsO4hkYg4xrN+/TF6ugBaXL/ztXY0g2ikm3nW+F0FiwTdqXUnO0SIEPIPqn3
         XqcD983iEByAoBt10/Ct2FBurpEayzDEcPgc+siejYW5WU6d52kAbl0lkDGwKUH6Ve16
         e9QbZaIR8EyzHykVOnQcAtfZgcmsgoJFS7+FrmIt75e8P1thJwxCSSyQ4yOlMDhJJgzs
         P1hA==
X-Forwarded-Encrypted: i=1; AFNElJ+ScJYv80OsQaR1Ndzoi4VsOFcFiuuEWl1Jne13RyR8AxXk/Vd658GU8ullo6AbL/pE4tzIu0TtyFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYM3ohufEejjL4ces2NombFnLK37c7e1B/1JfRpGzdfXiPCfI/
	RfEqg5tXY9HQaHXvUamCUzPeOBj9Gxgok2NpMarj9v/WB14tnPSe8lnnTdnEUFkFZqkrV3C6edz
	8mzMak4pdzqsFMzhrgHn66wOtlI3hRKNTfwWcdX8Cuw==
X-Gm-Gg: AeBDieu7bL0dQKKMzOhtLeQlgVbdwNiA+ZhXOKdxiGdxuIm4hJoYF16bgA0710f1L3B
	jaMkh+tfu9FMfXQYWW+VXeXEvCf0qEUe61hb8c7+CCrCVnA3QO6r67bvAJK5vo1aPcGKwqWRmT1
	Gs5RYMkau0GGbk1Z6MfSsbzpHPMWhYFslrihmZeG8sRak5YV8TKUTRVZxOvDCDIPMacrc7PTPUw
	nD8zCs3if2y2zPs6niRVj0cei5pbRsDqmwxmpvVMVi6dUxv9KDeEq4Gb0abEZi57+MOIMjFOwR6
	ivv+TBE4pqnbt7KN7YHKUm0ItQ2D0PRWs8g/3+62xhphYlSGXaDQHentTVQjLsaqXcqpiV4X3ye
	LUjjQ
X-Received: by 2002:a05:6512:2313:b0:5a4:1365:5fda with SMTP id
 2adb3069b0e04-5a4172a9cc0mr2683582e87.25.1776590078433; Sun, 19 Apr 2026
 02:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418170610.312523-1-piyushpatle228@gmail.com> <c90e4aa8-528d-4951-9f80-80612d013591@baylibre.com>
In-Reply-To: <c90e4aa8-528d-4951-9f80-80612d013591@baylibre.com>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sun, 19 Apr 2026 14:44:01 +0530
X-Gm-Features: AQROBzBhhhgaNgi1Q1401WGYb-_yBofEtQeT3Lj9c3FgqTn4Qs8mspcz8EK7Ak8
Message-ID: <CAMB+xkbBfaqgAtxE6ePcTOjXPtSWcCbHSabv1p5J-DRz8hRODQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: hx711: add support for HX710B
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, ak@it-klinger.de, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 3:35=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> When there is more than one patch in a series, add a cover letter to
> keep the patches together.
>

A cover letter was included, but it seems it did not reach properly.
I will resend the series with correct threading in v2.

> On 4/18/26 12:06 PM, Piyush Patle wrote:
> > Refactor the driver around per-chip configuration so HX711 and HX710B
> > can share the same core.
> >
> > Add HX710B channel definitions, pulse-count based channel selection, a
>
> Can you explain this difference a bit more? It seems like the two chips
> are quite different in this regard.
>

On HX711, the number of trailing SCK pulses (1=E2=80=933) after a conversio=
n
selects both the channel and gain for the next measurement.

On HX710B, the gain is fixed and the trailing pulses only select the
channel: 1 pulse selects the differential input channel (10 SPS)
& 2 pulses select the DVDD-AVDD measurement channel (40 SPS)

I will make this distinction clearer in the commit message in v2.

> > variant-specific iio_info, and fixed-scale handling at probe. Update th=
e
> > Kconfig text and trim comments so the added support stays focused on th=
e
> > actual driver behavior.
> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > ---
> >  drivers/iio/adc/Kconfig |   9 +-
> >  drivers/iio/adc/hx711.c | 222 ++++++++++++++++++++++++++++++++--------
> >  2 files changed, 184 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 60038ae8dfc4..ddf981fa72a2 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -784,18 +784,21 @@ config HI8435
> >         called hi8435.
> >
> >  config HX711
> > -     tristate "AVIA HX711 ADC for weight cells"
> > +     tristate "AVIA HX711 and HX710B ADC"
> >       depends on GPIOLIB
> >       select IIO_BUFFER
> >       select IIO_TRIGGERED_BUFFER
> >       help
> > -       If you say yes here you get support for AVIA HX711 ADC which is=
 used
> > -       for weigh cells
> > +       If you say yes here you get support for AVIA HX711 and HX710B A=
DCs
> > +       which are used for bridge sensors such as weigh cells.
> >
> >         This driver uses two GPIOs, one acts as the clock and controls =
the
> >         channel selection and gain, the other one is used for the measu=
rement
> >         data
> >
> > +       The HX710B is a variant with fixed gain and a different channel
> > +       selection scheme.
> > +
> >         Currently the raw value is read from the chip and delivered.
> >         To get an actual weight one needs to subtract the
> >         zero offset and multiply by a scale factor.
> > diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> > index 1db8b68a8f64..cd251fa9f6b7 100644
> > --- a/drivers/iio/adc/hx711.c
> > +++ b/drivers/iio/adc/hx711.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> > - * HX711: analog to digital converter for weight sensor module
> > + * HX711/HX710B ADC driver
> >   *
> >   * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
> >   */
> > @@ -76,13 +76,34 @@ static int hx711_get_scale_to_gain(int scale)
> >       return -EINVAL;
> >  }
> >
> > +/**
> > + * struct hx711_chip_info - per-variant static configuration
> > + * @name: IIO device name
> > + * @channels: channel specification
> > + * @num_channels: number of channels
> > + * @chan_pulse_count: trailing pulse count for fixed-gain variants
> > + * @num_chan_pulses: number of pulse-count entries
> > + * @reset_channel: default channel after reset
> > + */
> > +struct hx711_chip_info {
> > +     const char                      *name;
> > +     const struct iio_chan_spec      *channels;
> > +     int                             num_channels;
> > +     const int                       *chan_pulse_count;
> > +     int                             num_chan_pulses;
> > +     int                             reset_channel;
> > +};
> > +
> >  struct hx711_data {
> > -     struct device           *dev;
> > -     struct gpio_desc        *gpiod_pd_sck;
> > -     struct gpio_desc        *gpiod_dout;
> > -     int                     gain_set;       /* gain set on device */
> > -     int                     gain_chan_a;    /* gain for channel A */
> > -     struct mutex            lock;
> > +     struct device                   *dev;
> > +     struct gpio_desc                *gpiod_pd_sck;
> > +     struct gpio_desc                *gpiod_dout;
> > +     int                             gain_set;       /* HX711 */
> > +     int                             gain_chan_a;    /* HX711 channel =
A gain */
> > +     int                             channel_set;    /* HX710B */
> > +     int                             scale;          /* HX710B scale *=
/
> > +     const struct hx711_chip_info    *chip_info;
> > +     struct mutex                    lock;
> >       /*
> >        * triggered buffer
> >        * 2x32-bit channel + 64-bit naturally aligned timestamp
> > @@ -92,13 +113,10 @@ struct hx711_data {
> >               aligned_s64 timestamp;
> >       } buffer;
> >       /*
> > -      * delay after a rising edge on SCK until the data is ready DOUT
> > -      * this is dependent on the hx711 where the datasheet tells a
> > -      * maximum value of 100 ns
> > -      * but also on potential parasitic capacities on the wiring
> > +      * Delay after SCK rising edge before sampling DOUT.
> >        */
> > -     u32                     data_ready_delay_ns;
> > -     u32                     clock_frequency;
> > +     u32                             data_ready_delay_ns;
> > +     u32                             clock_frequency;
> >  };
> >
> >  static int hx711_cycle(struct hx711_data *hx711_data)
> > @@ -139,7 +157,11 @@ static int hx711_cycle(struct hx711_data *hx711_da=
ta)
> >       return gpiod_get_value(hx711_data->gpiod_dout);
> >  }
> >
> > -static int hx711_read(struct hx711_data *hx711_data)
> > +/*
> > + * Clock out 24 data bits and then send trailing pulses to select the
> > + * next channel/gain state.
> > + */
> > +static int hx711_read(struct hx711_data *hx711_data, int trailing_puls=
es)
> >  {
> >       int i, ret;
> >       int value =3D 0;
> > @@ -158,7 +180,7 @@ static int hx711_read(struct hx711_data *hx711_data=
)
> >
> >       value ^=3D 0x800000;
> >
> > -     for (i =3D 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); =
i++)
> > +     for (i =3D 0; i < trailing_pulses; i++)
> >               hx711_cycle(hx711_data);
> >
> >       return value;
> > @@ -188,6 +210,7 @@ static int hx711_wait_for_ready(struct hx711_data *=
hx711_data)
> >
> >  static int hx711_reset(struct hx711_data *hx711_data)
> >  {
> > +     const struct hx711_chip_info *info =3D hx711_data->chip_info;
> >       int val =3D hx711_wait_for_ready(hx711_data);
> >
> >       if (val) {
> > @@ -206,13 +229,17 @@ static int hx711_reset(struct hx711_data *hx711_d=
ata)
> >
> >               val =3D hx711_wait_for_ready(hx711_data);
> >
> > -             /* after a reset the gain is 128 */
> > -             hx711_data->gain_set =3D HX711_RESET_GAIN;
> > +             /* Restore variant default after reset. */
> > +             if (info->chan_pulse_count)
> > +                     hx711_data->channel_set =3D info->reset_channel;
> > +             else
> > +                     hx711_data->gain_set =3D HX711_RESET_GAIN;
> >       }
> >
> >       return val;
> >  }
> >
> > +/* Select HX711 channel/gain for the next conversion. */
> >  static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, i=
nt chan)
> >  {
> >       int ret;
> > @@ -221,7 +248,8 @@ static int hx711_set_gain_for_channel(struct hx711_=
data *hx711_data, int chan)
> >               if (hx711_data->gain_set =3D=3D 32) {
> >                       hx711_data->gain_set =3D hx711_data->gain_chan_a;
> >
> > -                     ret =3D hx711_read(hx711_data);
> > +                     ret =3D hx711_read(hx711_data,
> > +                                      hx711_get_gain_to_pulse(hx711_da=
ta->gain_set));
> >                       if (ret < 0)
> >                               return ret;
> >
> > @@ -233,7 +261,8 @@ static int hx711_set_gain_for_channel(struct hx711_=
data *hx711_data, int chan)
> >               if (hx711_data->gain_set !=3D 32) {
> >                       hx711_data->gain_set =3D 32;
> >
> > -                     ret =3D hx711_read(hx711_data);
> > +                     ret =3D hx711_read(hx711_data,
> > +                                      hx711_get_gain_to_pulse(hx711_da=
ta->gain_set));
> >                       if (ret < 0)
> >                               return ret;
> >
> > @@ -246,27 +275,52 @@ static int hx711_set_gain_for_channel(struct hx71=
1_data *hx711_data, int chan)
> >       return 0;
> >  }
> >
> > +/* Select HX710B channel for the next conversion. */
> > +static int hx710b_set_channel(struct hx711_data *hx711_data, int chan)
> > +{
> > +     const struct hx711_chip_info *info =3D hx711_data->chip_info;
> > +     int ret;
> > +
> > +     if (chan >=3D info->num_chan_pulses)
> > +             return -EINVAL;
> > +
> > +     if (hx711_data->channel_set =3D=3D chan)
> > +             return 0;
> > +
> > +     hx711_data->channel_set =3D chan;
> > +
> > +     ret =3D hx711_read(hx711_data, info->chan_pulse_count[chan]);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return hx711_wait_for_ready(hx711_data);
> > +}
> > +
> >  static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
> >  {
> > +     const struct hx711_chip_info *info =3D hx711_data->chip_info;
> > +     int trailing_pulses;
> >       int ret;
> > -     int val;
> >
> > -     /*
> > -      * hx711_reset() must be called from here
> > -      * because it could be calling hx711_read() by itself
> > -      */
> > +     /* Reset first so the read starts from a known chip state. */
> >       if (hx711_reset(hx711_data)) {
> >               dev_err(hx711_data->dev, "reset failed!");
> >               return -EIO;
> >       }
> >
> > -     ret =3D hx711_set_gain_for_channel(hx711_data, chan);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     val =3D hx711_read(hx711_data);
> > +     if (info->chan_pulse_count) {
> > +             ret =3D hx710b_set_channel(hx711_data, chan);
> > +             if (ret < 0)
> > +                     return ret;
> > +             trailing_pulses =3D info->chan_pulse_count[chan];
> > +     } else {
> > +             ret =3D hx711_set_gain_for_channel(hx711_data, chan);
> > +             if (ret < 0)
> > +                     return ret;
> > +             trailing_pulses =3D hx711_get_gain_to_pulse(hx711_data->g=
ain_set);
> > +     }
> >
> > -     return val;
> > +     return hx711_read(hx711_data, trailing_pulses);
> >  }
> >
> >  static int hx711_read_raw(struct iio_dev *indio_dev,
> > @@ -274,6 +328,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev=
,
> >                               int *val, int *val2, long mask)
> >  {
> >       struct hx711_data *hx711_data =3D iio_priv(indio_dev);
> > +     const struct hx711_chip_info *info =3D hx711_data->chip_info;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_RAW:
> > @@ -290,7 +345,10 @@ static int hx711_read_raw(struct iio_dev *indio_de=
v,
> >               *val =3D 0;
> >               mutex_lock(&hx711_data->lock);
> >
> > -             *val2 =3D hx711_get_gain_to_scale(hx711_data->gain_set);
> > +             if (info->chan_pulse_count)
> > +                     *val2 =3D hx711_data->scale;
> > +             else
> > +                     *val2 =3D hx711_get_gain_to_scale(hx711_data->gai=
n_set);
> >
> >               mutex_unlock(&hx711_data->lock);
> >
> > @@ -332,7 +390,8 @@ static int hx711_write_raw(struct iio_dev *indio_de=
v,
> >                       if (gain !=3D 32)
> >                               hx711_data->gain_chan_a =3D gain;
> >
> > -                     ret =3D hx711_read(hx711_data);
> > +                     ret =3D hx711_read(hx711_data,
> > +                                      hx711_get_gain_to_pulse(hx711_da=
ta->gain_set));
> >                       if (ret < 0) {
> >                               mutex_unlock(&hx711_data->lock);
> >                               return ret;
> > @@ -423,6 +482,10 @@ static const struct iio_info hx711_iio_info =3D {
> >       .attrs                  =3D &hx711_attribute_group,
> >  };
> >
> > +static const struct iio_info hx710b_iio_info =3D {
> > +     .read_raw               =3D hx711_read_raw,
> > +};
> > +
> >  static const struct iio_chan_spec hx711_chan_spec[] =3D {
> >       {
> >               .type =3D IIO_VOLTAGE,
> > @@ -455,10 +518,69 @@ static const struct iio_chan_spec hx711_chan_spec=
[] =3D {
> >       IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> >
> > +/* HX710B channels: differential input and DVDD-AVDD measurement. */
> > +static const struct iio_chan_spec hx710b_chan_spec[] =3D {
> > +     {
> > +             .type =3D IIO_VOLTAGE,
> > +             .channel =3D 0,
> > +             .indexed =3D 1,
>
> If it is differential, shouldn't we have .differential =3D 1 and .channel=
2 =3D 1?
>

Yes, good catch. I will add .differential =3D 1 and .channel2 =3D 1 for
channel 0 in v2.

> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .scan_index =3D 0,
> > +             .scan_type =3D {
> > +                     .sign =3D 'u',
> > +                     .realbits =3D 24,
> > +                     .storagebits =3D 32,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +     },
> > +     {
> > +             .type =3D IIO_VOLTAGE,
> > +             .channel =3D 1,
> > +             .indexed =3D 1,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .scan_index =3D 1,
> > +             .scan_type =3D {
> > +                     .sign =3D 'u',
> > +                     .realbits =3D 24,
> > +                     .storagebits =3D 32,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +     },
> > +     IIO_CHAN_SOFT_TIMESTAMP(2),
> > +};
> > +
> > +/*
> > + * HX710B trailing pulse counts.
> > + * 25 selects differential input, 26 selects DVDD-AVDD.
> > + */
> > +static const int hx710b_pulse_counts[] =3D {
> > +     25,     /* channel 0: differential input, 10 SPS */
> > +     26,     /* channel 1: DVDD-AVDD voltage,   40 SPS */
>
> We could store these numbers in the .address field of the channel
> instead. It is there for driver-specific things like this.
>

Agreed. I will store the trailing pulse counts in chan->address and
remove the separate array in v2.

> > +};
> > +
> > +static const struct hx711_chip_info hx711_chip =3D {
> > +     .name                   =3D "hx711",
> > +     .channels               =3D hx711_chan_spec,
> > +     .num_channels           =3D ARRAY_SIZE(hx711_chan_spec),
> > +     .chan_pulse_count       =3D NULL,
> > +};
> > +
> > +static const struct hx711_chip_info hx710b_chip =3D {
> > +     .name                   =3D "hx710b",
> > +     .channels               =3D hx710b_chan_spec,
> > +     .num_channels           =3D ARRAY_SIZE(hx710b_chan_spec),
> > +     .chan_pulse_count       =3D hx710b_pulse_counts,
> > +     .num_chan_pulses        =3D ARRAY_SIZE(hx710b_pulse_counts),
> > +     .reset_channel          =3D 0,
> > +};
> > +
> >  static int hx711_probe(struct platform_device *pdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> >       struct hx711_data *hx711_data;
> > +     const struct hx711_chip_info *chip_info;
> >       struct iio_dev *indio_dev;
> >       int ret;
> >       int i;
> > @@ -472,6 +594,11 @@ static int hx711_probe(struct platform_device *pde=
v)
> >
> >       mutex_init(&hx711_data->lock);
> >
> > +     chip_info =3D device_get_match_data(dev);
> > +     if (!chip_info)
> > +             return -ENODEV;
>
> We recently decided to standardize on not checking for NULL on this.
>

Got it, I will remove the NULL check in v2.

> > +     hx711_data->chip_info =3D chip_info;
> > +
> >       /*
> >        * PD_SCK stands for power down and serial clock input of HX711
> >        * in the driver it is an output
> > @@ -510,12 +637,20 @@ static int hx711_probe(struct platform_device *pd=
ev)
> >       /* we need 10^-9 mV */
> >       ret *=3D 100;
> >
> > -     for (i =3D 0; i < HX711_GAIN_MAX; i++)
> > -             hx711_gain_to_scale[i].scale =3D
> > -                     ret / hx711_gain_to_scale[i].gain / 1678;
> > +     if (chip_info->chan_pulse_count) {
>
> Why does chan_pulse_count imply fixed gain? If it is not related, we shou=
ld
> add a new flag to the chip info instead.
>

My initial reasoning was that chan_pulse_count is only used for variants
where channel selection is driven entirely by trailing pulses and no
gain configuration is exposed to the driver, so it implicitly indicated
a fixed-gain device.

However, this conflates channel selection and gain handling, which are
independent concerns and may not scale well for future variants.

I will rework this in v2 by introducing a dedicated fixed gain flag in
the chip info.

> We want to avoid assuming any branch of the if statement is a specific ch=
ip
> in case any more are added in the future.
>

Also, while reviewing this, I noticed that the pulse counts were
incorrectly specified as 25/26. Since hx711_read() already clocks out
24 data bits, trailing_pulses should represent only the additional
cycles after data, so the correct values are 1 and 2. This will be
fixed in v2.

> > +             /* HX710B uses a fixed gain, so compute scale once at pro=
be. */
> > +             hx711_data->scale =3D ret / 128 / 1678;
> > +             hx711_data->channel_set =3D chip_info->reset_channel;
> > +             indio_dev->info =3D &hx710b_iio_info;
> > +     } else {
> > +             for (i =3D 0; i < HX711_GAIN_MAX; i++)
> > +                     hx711_gain_to_scale[i].scale =3D
> > +                             ret / hx711_gain_to_scale[i].gain / 1678;
> >
> > -     hx711_data->gain_set =3D 128;
> > -     hx711_data->gain_chan_a =3D 128;
> > +             hx711_data->gain_set =3D 128;
> > +             hx711_data->gain_chan_a =3D 128;
> > +             indio_dev->info =3D &hx711_iio_info;
> > +     }
> >
> >       hx711_data->clock_frequency =3D 400000;
> >       ret =3D device_property_read_u32(&pdev->dev, "clock-frequency",
> > @@ -533,11 +668,10 @@ static int hx711_probe(struct platform_device *pd=
ev)
> >       hx711_data->data_ready_delay_ns =3D
> >                               1000000000 / hx711_data->clock_frequency;
> >
> > -     indio_dev->name =3D "hx711";
> > -     indio_dev->info =3D &hx711_iio_info;
> > +     indio_dev->name =3D chip_info->name;
> >       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > -     indio_dev->channels =3D hx711_chan_spec;
> > -     indio_dev->num_channels =3D ARRAY_SIZE(hx711_chan_spec);
> > +     indio_dev->channels =3D chip_info->channels;
> > +     indio_dev->num_channels =3D chip_info->num_channels;
> >
> >       ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> >                                             iio_pollfunc_store_time,
> > @@ -554,7 +688,8 @@ static int hx711_probe(struct platform_device *pdev=
)
> >  }
> >
> >  static const struct of_device_id of_hx711_match[] =3D {
> > -     { .compatible =3D "avia,hx711", },
> > +     { .compatible =3D "avia,hx711",  .data =3D &hx711_chip  },
> > +     { .compatible =3D "avia,hx710b", .data =3D &hx710b_chip },
> >       { }
> >  };
> >
> > @@ -571,7 +706,6 @@ static struct platform_driver hx711_driver =3D {
> >  module_platform_driver(hx711_driver);
> >
> >  MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> > -MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
> > +MODULE_DESCRIPTION("HX711/HX710B GPIO ADC driver");
> >  MODULE_LICENSE("GPL");
> >  MODULE_ALIAS("platform:hx711-gpio");
> > -
>
