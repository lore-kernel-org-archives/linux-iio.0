Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CD41B357
	for <linux-iio@vger.kernel.org>; Wed,  5 Aug 2026 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924571; cv=pass; b=R8LhZxcfQTl5zsuMFVfsBQSdPO6pBugicN989ABZl3cM08wwg7pvjI2q65ZLx2wSgVGz4e2O9pSpDndeSndZ5pAs+TD9VOmMrvLxdAqCtC1wnUzhNKKTajwn55a+5VlqxMK+cL3wDajuuYmMsp0yNQuEKJK2L0TR+Zn8pimEL/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924571; c=relaxed/simple;
	bh=s2EZGq8avtY+ZczTxmKohK65/+Hn2MJ4OYkx6lf9xsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvczO/xpc9CAQlX/AoLF+dkEV7B0zptMgSCqmxFzdFyeJnilZjrw0grVKOXq2IXu+uT5N+zaDQlcZyN4fefybf1GwAXkPqPJP6xmcb8rKlDRYt6T5TodYHp6F5aHPyX/jYj7YZYPO0XbDbCi38oldM4KiDcjTJQzjQDJUb0JAmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVJVaf5S; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVJVaf5S"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15e592da74so102489066b.1
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 03:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785924567; cv=none;
        d=google.com; s=arc-20260327;
        b=Xb3K0ywSgTNBiQqgxPvYL6bZpunt/AU9OvO136eTLLN9bPfSGb35PrSjYGyQuOorAM
         8bkgxhGcIjv6PRFP9aWWoQQ9FsSw8rdjXALjz0BBpEKw87K8Uu9WB8pyZvzx/wIMRw6V
         Nnopi6nFlL2OSA0TaOoxD+2VAViTQ++W371EASevAEuVeljQpZTqWtbu254LHCzVsSRc
         q/OjjpWw7nXYlGUphTkITdWMeRRPH25GZ3l4PdoiRMbXESoTCL910+B+kThL0fAA2LnT
         yo8LJhRKXMSEC27lFXRlLdbCLmE/SGp90q9S3C5mxZxya7SGBfOQMo4Jvl4RY5aKn/Vo
         L53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nZg5H2XX+nqsFn9nvqPTcpl9c0SWPMoYdf46e77DPqw=;
        fh=41lMUTPWJbmbg5z2Ieqm3eoa2PDPlFLUNR+hN1g/ivE=;
        b=UL+D8E0hge+FCuqaMS9fbDIa1yDFJnKILmr3ZCOkDeoF+uLjL/GWbtWJWtvsl3Fpf+
         AeN471q4PA8ElFdIm6E9Qe3kaKpd3W6vODDy/Omii4pvcSdgLejSoE2tIq61y0mpMdBl
         jOaigQlbym+uR5kiRJIP7BUp3smCwUQBSjuN5ViL9Cs+wUwgQoVHAFjESLynWVrN0Uit
         aGUn7QMrx31j3ALB1iqkQ1Dhc54zsSWU+OI/Utn3RSDDntuPAGQh94wI6mHGuHhLTLNb
         rcUasH6i2+LuALSdzYsJaYqWO1viKzEeqc7iNgkVH6r3D1Imz204mv9yZ6W1T9dTavYJ
         Z+Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785924567; x=1786529367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nZg5H2XX+nqsFn9nvqPTcpl9c0SWPMoYdf46e77DPqw=;
        b=OVJVaf5SM9SqXXAzgdifGkaMKpAhMrQ1WdETD3QQvi0fNnaPE+OjxoZdWgMFSaWApq
         BKcuB1k/YV+JD2O4gkYbljGrJUiLhvdKXAlOdstZYHLfhyZXlOQ21uum5mIkHSlAB2m6
         +oYbEI1wtw9TlNTsJDBLa1iIOfoshgkjZAEnz6ROpfb/Ou6C6Om8JPGRdKSTtTukD3Xm
         HF+Kw8bCv5vPhxHd/wAsRgTy5tWWX6SOJiBBpGnspR00nASpaTRr8yDHqlety4DhISBK
         NGbGx5TZB2ZKEt1wUcGOAO7PNG884O0du2YmXq+hSanPGGr5NjuFI0xM/5swd+8m+X9v
         tqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785924567; x=1786529367;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZg5H2XX+nqsFn9nvqPTcpl9c0SWPMoYdf46e77DPqw=;
        b=lREQMSNOYlN0gfZlnwS5tj8XuWIkzK5dQlapmzWAcSwFu0Snyv0N8YqM8ZTPZ0Wm/3
         aRXvVb2DWblkRy2OkTmilLe48v0V8tw4ZqeAe+kJwYa89Tl6Spnpsv1RREeN8J284nwj
         EzBPA4gTSuTyTUVBXyqe69Tgi4oQMFlxISHaA5/Xev0xFUEixuuNVHK1mmpiVdcbqoeI
         AXld6FiVRvd4GJCekk2wMohXhmLkkmTXlT2XvA/x29AYh61ozkHTTnpalIo17VAR1IIM
         jHwBPeM5K3zgrVhxUwpvZZYeh9rK0YRYzEDtxrzuJLS53abK1FPXIzXZHcL0TSlKgzV6
         3mbg==
X-Forwarded-Encrypted: i=1; AHgh+RqvLf17t2RAhVpg0r9zRRdBQeiNgdX/2RZI2Gqat8VOfE1IiN+0Nm6p8MlACE0hiLmCC+MfTnYcQQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCimbgEnAJroXNgc8Lg1tsYKn6J/Afxy7GB/PFto+hAMAj9JV3
	AKSzpUMG4XDOBzVoNBvxUi28vbON7GzwA76nAQ3oOd7k62BNMibeqnabOE7tI2cyIWtsCJcYEMc
	jscANgYmpTo9whYL9XFwp4HaCiRemAOY=
X-Gm-Gg: AR+sD10wNbDUWeHjuG7MCRJ/XYC+AFsx3UAlTAxK7gT3Xei8rQws0JX/k5y0jmnPtrv
	C8aP0tdmY5fulzcfnWCdTky/4jqhLcdbkNVfwsPXf42qye8+smhyt+qVpkiZDYGn38BFp7Z6WKZ
	YnmpL7NqHQMhRbkeEpCE3h1H7mi9ugJzJk3HPAIG7HJFakRv1as3jquPgGbqSZPvEyP25C2LLQW
	2Z/d3b6bHR244/TZSNl+LsYZvbAz92ZMNi8miNL8a9npXAUhD8ZxswmCtckbNAiyabjG5c5ktDv
	entqrsusJRQR5oUFJs/iXu83FKuSb7nizQ1vGNDakhre8ZAzVD5S1F5pXvv3nWBz3Z4DvyvO49q
	czV9pibXhqDP8acV2lsuDtZQ1RPS+MD3crwboPGWKvB+Ig4br0wzmSk1Zg2yM3krgCZTymBUakG
	/p9oWzFVeL9a35KnwE4HNS25OmE34Ly27Jo32yL6pjlbx0pvs/fWWVUvJhV0OfYSPWmt0Mpx01o
	Q==
X-Received: by 2002:a17:907:1c8e:b0:c16:13d4:8165 with SMTP id
 a640c23a62f3a-c2039ec3e55mr233465366b.22.1785924566629; Wed, 05 Aug 2026
 03:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805094135.11762-1-andrei.stancovici@analog.com> <20260805094135.11762-4-andrei.stancovici@analog.com>
In-Reply-To: <20260805094135.11762-4-andrei.stancovici@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Aug 2026 13:08:50 +0300
X-Gm-Features: AUfX_mxeQ9DsICXq-Cq3Ww3vOFE8a4_KfRhxrKtEhMeTmOjBrfiU1bDozFoNXxI
Message-ID: <CAHp75VeNFTPwujkLWG-NbSdbJU-r-xThroOiOJrhz_R8+vMikA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ltc2497: add 2x conversion speed mode
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 12:44=E2=80=AFPM Andrei Stancovici
<andrei.stancovici@analog.com> wrote:
>
> The LTC2499 supports a 2x output rate (SPD bit in the second
> configuration byte).  In 2x mode the offset auto-calibration is
> disabled, roughly doubling the conversion rate (~13.6Hz vs ~6.8Hz in
> simultaneous 50/60Hz rejection) while leaving linearity and full-scale
> errors unchanged (datasheet).  During a temperature measurement the part
> always converts at 1x regardless of SPD.
>
> Expose the rate through the standard sampling_frequency /
> sampling_frequency_available ABI on the voltage channels only: SPD is
> ignored for temperature conversions, so the temperature channel
> deliberately carries no SAMP_FREQ attribute.  A new has_speed_mode
> capability flag gates the feature (LTC2499); the two-byte command path
> is now taken for has_temp || has_speed_mode, since both features need the
> second config byte.
>
> The conversion-time wait becomes mode dependent: 150ms at 1x, 76ms at 2x
> (datasheet t_CONV max, simultaneous rejection, rounded up).  The wait is
> keyed on the conversion currently in flight, whose duration is fixed by
> the mode that was active when it started - not by the newly selected
> mode.  This matters on a 1x->2x switch: a 1x conversion may still be
> running when the first 2x read arrives, and reprogramming the device
> before it finishes would be NACKed with -EIO.  Timing is centralized in
> ltc2497core_conv_time_ms() so a future FA/FB rejection-mode selection
> can extend it into a [rejection][speed] lookup without touching callers.
>
> LTC2496/LTC2497 (no speed mode) keep the single-byte path and the
> unchanged 150ms wait.
>
> Validated on a live LTC2499: 20 reads take ~3.1s at 1x and ~1.6s at 2x
> (~0.5x, no -EIO), voltage and temperature readings stay sane in both
> modes, and the temperature/voltage interleave (sticky-PTAT) regression
> still passes at 1x and 2x.

...

>  #include <linux/delay.h>
> +#include <linux/device.h>

Why? On a brief look I haven't noticed the use of this header.

>  #include <linux/iio/iio.h>
>  #include <linux/iio/driver.h>
>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/slab.h>

Neither is this.

Perhaps you wanted the device/devres.h?

...

> +static int ltc2497core_write_raw(struct iio_dev *indio_dev,
> +                                struct iio_chan_spec const *chan,
> +                                int val, int val2, long mask)
> +{
> +       struct ltc2497core_driverdata *ddata =3D iio_priv(indio_dev);
> +       bool sped_2x;
> +       int i;

Why signed?

> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               /* Match the (val, val2) pair against the advertised rate=
s. */
> +               for (i =3D 0; i < ARRAY_SIZE(ltc2497core_samp_freq_avail)=
; i +=3D 2) {
> +                       if (val =3D=3D ltc2497core_samp_freq_avail[i] &&
> +                           val2 =3D=3D ltc2497core_samp_freq_avail[i + 1=
])
> +                               break;
> +               }
> +               if (i >=3D ARRAY_SIZE(ltc2497core_samp_freq_avail))

'=3D=3D' should suffice.

> +                       return -EINVAL;
> +
> +               sped_2x =3D i / 2;
> +
> +               mutex_lock(&ddata->lock);
> +               ddata->sped_2x =3D sped_2x;
> +               /*
> +                * The new speed only takes effect once the second comman=
d byte
> +                * is reprogrammed, so force the next read to reprogram r=
ather
> +                * than reuse the value already latched for this address.
> +                * LTC2497_CONFIG_DEFAULT is not a valid channel/temperat=
ure
> +                * address, so it is a safe re-arm sentinel (as used at p=
robe).
> +                *
> +                * A conversion started under the old speed may still be =
in
> +                * flight; its own duration (conv_time_prev), not the new=
 mode's,
> +                * still gates the next reprogram, so the timing state is=
 left
> +                * untouched here.
> +                */
> +               ddata->addr_prev =3D LTC2497_CONFIG_DEFAULT;
> +               mutex_unlock(&ddata->lock);
> +
> +               return 0;

...

> +       if (ddata->chip_info->has_speed_mode) {
> +               struct iio_chan_spec *channels;
> +               unsigned int i;
> +
> +               channels =3D devm_kmemdup(dev, ltc2497core_channel,
> +                                       sizeof(ltc2497core_channel), GFP_=
KERNEL);
> +               if (!channels)
> +                       return -ENOMEM;

> +               for (i =3D 0; i < indio_dev->num_channels; i++) {

Iterrator is not used outside, so can be

  for (unsigned int i...)

> +                       if (channels[i].type !=3D IIO_VOLTAGE)
> +                               continue;
> +                       channels[i].info_mask_shared_by_type |=3D
> +                               BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +                       channels[i].info_mask_shared_by_type_available |=
=3D
> +                               BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +               }
> +
> +               indio_dev->channels =3D channels;
> +       }

...

> +#define LTC2497_CONV_TIME_1X_MS                150ULL  /* t_CONV_1 simul=
t. max 149.9 */
> +#define LTC2499_CONV_TIME_2X_MS                76ULL   /* t_CONV_2 simul=
t. max  75.1 */

I didn't get the rounding rules. Is it just a ceiling for all cases?
Can we use more precise (10x) values instead?

--=20
With Best Regards,
Andy Shevchenko
