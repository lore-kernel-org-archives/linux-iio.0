Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A12BEC55
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 05:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776836996; cv=pass; b=KtPrBxZB9zqTNT+M8Wpw/rA6NJ9dxBpPLQELPKTAwvX+wI2qs/dp2dZBbIn41D1Tyx8YPpcGPSzlnUp9DqhwlApCllsCXmcaARj2AwFDKiwUW1bqV7lfEp5TG3Eoc6Q64MGWqsQkM8p7jEloRbEKwhAOZ0YZcR8/24fBo3+IGvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776836996; c=relaxed/simple;
	bh=XQR89QkQXLBM+jd3aIBp1XsFOxLsLCocfKrUOR8zAiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9010kdQtCe89GG/TS3MyisoXt/Zk0AwsSymp8Ps70Kok3Ygl81axTUEi6uIqri66h9XyeTSxezMhd+BOcjRV0fpA/ppdHQG7lQ+Pudnedg7HHYi1IO45dXWPw/Xb6e5zrh9kJxSf7BTedTWSjpEyA0hV0j6Yh/wKkG5OQPvS+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgtnquEP; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgtnquEP"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so6910947e87.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 22:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776836992; cv=none;
        d=google.com; s=arc-20240605;
        b=VwiUOgJyuhpdD0nEJTmhP07d0NMA5YHeXXwYDeXwZ++bLiKXry1A8cWxSzt02BCkLI
         9AEPfd5Lm4gkDYOyLIbH5Mf2yGxV389amfMjwS6GW7sA49qMa+jfZrCpkt606HlvBjAt
         Ws3/ByCPWHA+F79N1FGpkOduMKWn6/n51UAcZ6//GDGoWJYyR9zmT1PMHR8mWb1ab/eX
         1FdToKH7K0OrF1M9xeCAMRTk7al6sXG/I0ahEiszO4s8tvZyMMDbTpZxIt3LcYQuuhda
         NDgEeELwzx/ZYtoiKxDKavF3zMyPuFzRdipaoatwy/5W9I+dZf+SuWv2hF1fQFmaFstp
         OIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XsjzWl9oGYNJVBtc380089snmdHxvs1SAXZ+J7OsdRc=;
        fh=vMcPX+YSNWBI48dABKamjIbavpC/jiHwZqx3i6DVOa4=;
        b=CwahK/U+sBl369t2jH0FGQ6zqCzvWO8q5geCmV8IIjFL3F5+GrZ0G/gLAqZ+YgPmRf
         qam8Is3ll4JrPH4+ceygMmAjsWsXvtpkBhgdrXDprf2SYec8g/yxjBrjvH4YTelbqK3e
         xeBF/0TInvUpNLzxg16dDxHUNRL99n18xEdtVPOaKQS0Z2otVqJWyLKbdEc7GmtR+MRv
         T+gO0RQMISgoAwYRk1VQ+jk0RNBnjuecJkHcrXZHbeBZzdd4WfIWf0O1bcwK7j/HJNne
         eRz1MKfI9fQPW8K7d0CqDMqx07FxfTd9aWl5MlrEhncEj240E3RePSVcTB9ZaR2uIHzf
         d9Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776836992; x=1777441792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsjzWl9oGYNJVBtc380089snmdHxvs1SAXZ+J7OsdRc=;
        b=jgtnquEPolnhtX0zBJbZ83B80o5ic1AAVIvku/vPCdjtjFYL0RaTN5x/eVHzzEBAXX
         rB8p/Ldb7ScOGXIIF4J4VIEcuoaQSZoH5YUT6DCzWweQYSY6N3hqhQGmjOrru8Be+rO7
         BcJAj/ZEVyIxtosgyY8UO9P9EMWQXcUcGgyu4+EMQGgRimhjw0lIQ1OInBud3kOrPACe
         rPioFdDYmaZYUKNKrhROrpK8hwLKfCJFAJBGouVrbYZAO+AqHFDwJcFXmMl/+YQ3AQP9
         M6TAsr7N61atvPpzKplCOHIgpQuKwiZDtg+CWHzSGxIv0yq/h9AmH1zLesgKTQ7wW2UA
         iX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776836992; x=1777441792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XsjzWl9oGYNJVBtc380089snmdHxvs1SAXZ+J7OsdRc=;
        b=rUFvqqzOe3WNZ46CfrkzsxEEQBK9A7wmW4N2irQ8XBUquC9lEzTmS2dwnY0PDviDYw
         Q6vlhYyhdFiY2SpjG1nEdxeBgcsNQEXnR0No0+Nfjm+w6YACFcnh0ZGi9Tgl1cOdeIG6
         0TCboiI37tX1cSZ1eWKP/X9b/5FHGzdmqV3AA7MhvhrUleBc7wtIThJ++9bqN1yfeQ59
         c562hpl3LR9x7G8l+1gHB8c79C0+sqEXlj1RSlPEHFsUQsgXlex9owyuHwoJYpzYWIIM
         PxFdDUs9PVA4z6JwpJizK7ZW2XYxA7+eCW6l51pc4WQ1VXuoYFsipYQikOCD/8q/zzOM
         xeiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9IAhnrKTOgSwXgLiTErcF3JFm0wgMu2c+jfKHj8KLXbLiET+mCK3VgjKqp20MxwD7fbofgw7Yv1yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPACTA8u3McMBoA7WiIqQbkl8UJnXkxgaH9RCbfZ3EAhNTvh7Y
	FB5edVhU+BFFVDkyH/a22aRUD6F8neggvCDMW5YQAiOyQ3MSiywjzQYWFzORVFhrTqWZmxS+7mn
	l5O+0uINz+fUpSoOJ5tTHopGbXiAeCo0=
X-Gm-Gg: AeBDietl8q+JI4tWtFjutVkNj8wW7EafAoaPpSzZlxVcAmHwjyWPkUmAt8m6XymXVOl
	q4LpLviqs5E8QJlMGKl3zVl+tzKfTSln9HtswON06P3USEEhJwnq05puCjz0hYUfyGQZjD0he1t
	xaSWquLChxO036PEfDfDqVldGAZCAqc70z8U2hm33g+nq8XLjzIC8s4p4UJGaFAAm/sgcUj0Xlc
	uc/356sv4Zk2YXmnXKovYp3ahD1Rp9Fupt55BbQZjbVy3NQ3reZBi50qqo+EQgSq+K2nHDSwIvo
	nJ7Xwz/CCtUn1r6ba+2EMYbHXQmgaW5+9jYoDb2CShuDRFptCA==
X-Received: by 2002:a05:6512:3ca0:b0:5a1:b83:c7cf with SMTP id
 2adb3069b0e04-5a4172f6634mr6634444e87.25.1776836992178; Tue, 21 Apr 2026
 22:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419174654.683692-1-piyushpatle228@gmail.com>
 <20260419174654.683692-3-piyushpatle228@gmail.com> <aeXryRD34RLveqDi@ashevche-desk.local>
In-Reply-To: <aeXryRD34RLveqDi@ashevche-desk.local>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Wed, 22 Apr 2026 11:19:15 +0530
X-Gm-Features: AQROBzC6kLNs31J3aUG5eVnxNe1TPvq9eOsBQoAZBOsPIYgFp4V1BQ3JPUE5PTA
Message-ID: <CAMB+xka2ZXbT-G-RUMAusJm8KsOjpCVwjijG2eUaPxBYahQrgg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: hx711: add support for HX710B
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, ak@it-klinger.de, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 2:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Apr 19, 2026 at 11:16:40PM +0530, Piyush Patle wrote:
> > The HX711 uses trailing SCK pulses after each 24-bit conversion to
> > select the channel and gain for the next measurement: 1 pulse gives
> > channel A at gain 128, 2 pulses give channel B at gain 32, and 3 pulses
> > give channel A at gain 64.
> >
> > The HX710B works differently: gain is fixed at 128 and the trailing
> > pulses select only the channel. One trailing pulse selects the
> > differential input (channel 0, 10 SPS) and two trailing pulses select
> > the DVDD-AVDD supply monitor (channel 1, 40 SPS).
> >
> > Refactor the driver around a per-chip hx711_chip_info structure so both
> > variants can share the same core. Each chip provides its own
> > iio_chan_spec array and iio_info pointer. The HX710B stores per-channel
> > trailing pulse counts in chan->address (1 for channel 0, 2 for
> > channel 1) instead of a separate array. A bool fixed_gain flag and
> > fixed_gain_val field in hx711_chip_info distinguish the fixed-gain path
> > from the HX711's user-selectable gain path without conflating unrelated
> > properties. The HX710B differential input channel is described with
> > .differential=3D1 and .channel2=3D1 as required by the IIO ABI.
> >
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> > ---
> > Changes in v2:
> > - Fix pulse count bug: hx710b values were {25, 26} (total SCK cycles);
> >   corrected to {1, 2} (trailing-only, hx711_read() clocks 24 data bits)
>
> Which questions how it was tested...

Fair point
I will expand the testing details in next version

>
> > - Add .differential =3D 1 and .channel2 =3D 1 to HX710B channel 0
> > - Move trailing pulse counts from a separate array to chan->address
> >   (1 for ch0, 2 for ch1); remove chan_pulse_count / num_chan_pulses
> > - Replace chan_pulse_count !=3D NULL tests with dedicated bool fixed_ga=
in
> >   flag; add fixed_gain_val field to hx711_chip_info
> > - Add const struct iio_info *iio_info to hx711_chip_info; probe sets
> >   indio_dev->info =3D chip_info->iio_info directly
> > - Remove NULL check after device_get_match_data()
> > - Remove reset_channel from hx711_chip_info (always 0; use literal)
> > - Change hx711_reset_read() and hx710b_set_channel() to take
> >   const struct iio_chan_spec * instead of int chan
> > - Revert hx711_data struct member alignment noise
> > - Restore trailing blank line at end of file (unrelated removal reverte=
d)
> > - Sort of_device_id entries alphabetically (hx710b before hx711)
> > - Expand commit message to explain HX711 vs HX710B trailing-pulse model
> > - Restore file header to mention weight sensor modules
>
> ...
>
> >  config HX711
> > -     tristate "AVIA HX711 ADC for weight cells"
> > +     tristate "AVIA HX711 and HX710B ADC"
>
> This won't scale. Better to put something like "and compatible".
> Also use plural "ADCs".

Agreed, "AVIA HX711 and compatible ADCs" avoids needing updates when
new variants are added. Will fix in v3.

>
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
>
> Usually for the less churn in the future we list them one per line. This
> will give easier understanding of what is supported (keep them also sorte=
d).
>
>           If you say Y here you get support for the following AVIA ADCs:
>             - HX710B
>             - HX711
>           which are used for bridge sensors such as weigh cells.
>
Will restructure accordingly.

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
>
> ...
>
> > - * HX711: analog to digital converter for weight sensor module
> > + * HX711/HX710B: ADC driver for weight sensor modules
>
> Use same as in Kconfig:
>
>  * HX711 and compatible ADCs driver for weight sensor modules
>
Yes, Will align the file header and module description with the Kconfig
wording.

>  ...
>
> > +/**
> > + * struct hx711_chip_info - per-variant static configuration
> > + * @name: IIO device name
> > + * @channels: channel specification
> > + * @num_channels: number of channels
> > + * @iio_info: IIO info ops for this variant
> > + * @fixed_gain: true if the variant has a fixed ADC gain (e.g. HX710B)
> > + * @fixed_gain_val: the fixed gain value used to compute scale (when f=
ixed_gain)
> > + */
> > +struct hx711_chip_info {
> > +     const char                      *name;
> > +     const struct iio_chan_spec      *channels;
> > +     int                             num_channels;
>
> Why signed?

num_channels cannot be negative, so unsigned int is
more appropriate. The same applies to fixed_gain_val. Will fix both.

>
> > +     const struct iio_info           *iio_info;
> > +     bool                            fixed_gain;
> > +     int                             fixed_gain_val;
> > +};
>
> ...
>
> >  struct hx711_data {
> >       struct device           *dev;
> >       struct gpio_desc        *gpiod_pd_sck;
> >       struct gpio_desc        *gpiod_dout;
> >       int                     gain_set;       /* gain set on device */
> >       int                     gain_chan_a;    /* gain for channel A */
>
> > +     int                     channel_set;    /* HX710B current channel=
 */
> > +     int                     scale;          /* HX710B fixed scale */
>
> Check if those need to be signed.
Will revisit and check but i think channel_set stores a
channel index (0 or 1) and scale is derived
from AVDD, so neither should be negative so converting both to
unsigned int makes more sense. I'll also update trailing_pulses to
unsigned int for consistency.

>
> > +     const struct hx711_chip_info *chip_info;
> >       struct mutex            lock;
>
> >  }
>
> ...
>
> > -     for (i =3D 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); =
i++)
> > +     for (i =3D 0; i < trailing_pulses; i++)
>
> If 'i' is used only once here, it can be converted to
>
>         for (unsigned int i =3D 0; i < trailing_pulses; i++)
>
Will update.

> >               hx711_cycle(hx711_data);
> >
> >       return value;
>
> ...
>
> > +     .num_channels   =3D ARRAY_SIZE(hx711_chan_spec),
>
> You also probably want to revisit inclusion block. At least follow IWYU i=
n the
> code you added here, exempli gratia include array_size.h and types.h if n=
ot yet
> included.
>
> ...
>
> >       hx711_data->clock_frequency =3D 400000;
>
> Sounds like I2C or SD standard speed :-)
>
> Not sure, but can be also converted to use 400 * HZ_PER_KHZ (from units.h=
)
> in a separate change.
>
> ...
>
> >       hx711_data->data_ready_delay_ns =3D
> >                               1000000000 / hx711_data->clock_frequency;
>
> Side note, in a separate change you can use constants from time.h, id est
> NSEC_PER_SEC.
>
> ...
>
> >  static const struct of_device_id of_hx711_match[] =3D {
> > -     { .compatible =3D "avia,hx711", },
> > +     { .compatible =3D "avia,hx710b", .data =3D &hx710b_chip },
>
> Please, split this to a separate change. So, first introduce the chip_inf=
o,
> then add your device support using given infrastructure.
>
> That said, you also can convert the driver to use guard()() from cleanup.=
h
> in a separate change.
Agreed. In v3 I will split the driver changes into 2 patch.
>
>
> > +     { .compatible =3D "avia,hx711",  .data =3D &hx711_chip  },
> >       { }
> >  };
>
> ...
>
> > -MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
>
> Ah, this removes crucial information. So, this driver probably just needs=
 to
> use i2c_gpio?
>
> > +MODULE_DESCRIPTION("HX711/HX710B GPIO ADC driver");
>
> Use what is written in Kconfig.
>

You're right, "bitbanging" is important context. I'll align the module
description with the Kconfig wording and retain that qualifier.

> --
> With Best Regards,
> Andy Shevchenko
>
>

Thanks for this detailed review
Regards
Piyush Patle
