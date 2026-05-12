Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02AE284690
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568275; cv=pass; b=XxXArwBK9ZviRar4OHGd3LpMXqBLFtCZNonPiHVBlu683HjL9VFCF4EZXJ/TRfWVEOuEk77ez26ay5NLpRnk2NNa1bn1C0Oojku4STTJX9vQ4PLkQaqS/8EiqaOR1XtPUBxxrwhJPlbyPmIiMUcQRsZMWWqJzMgjOoh5/nj2MxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568275; c=relaxed/simple;
	bh=FjgzfIcEzFg1b096kbJ3RIQzKX5tIHlT5F677cNirk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu9eM+TLXL0IzyhyTRbQOWYGsUPkvN9sFX/igVvD/JYMq6P2WW27MkaQwK2AN0vLnb78cnHbFfdDrfKjICVs0cmDyBjdxWvzRmnQwxl71LAPmhUXs3F/lx1075S8HfQK6VCPw0uQ769Jjk//dro2WpB0aohbWG5SdoOfRDNzRgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZ8k1arB; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZ8k1arB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so915830766b.2
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 23:44:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778568256; cv=none;
        d=google.com; s=arc-20240605;
        b=kKcjEB02YHt/rkrGJYCm92+rfycg9bfqcSHQ1S7GCmBbA8Xvr0CIA0vDVyuYFmsyzh
         FmRUKPrNEja/DUUuOkpNvm2sDbvU8j0ZUHve94TXV6I7SaRjkQaCtIU9KDHetayhG0DU
         z7QHNMxUqtg20FSjBO10cYjoYQblMmKhCuqkKIIwEDr79cQHuC8nn7MgT+6Mf8rbIMra
         IxrPyoD7jPewd+ItOewzKINtXiEdgIYbW6gIar/EtfKx2nV55uBt1rl3yn5c0GzWPIKF
         w//9EHqG42HUnHvB5t7LU9kVnazodJsCYRKJQfmiipMcBMFGkiTrRseGRlwm7sUoLNUa
         Docw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s9/juFQ5EkLeK4MRC7rvbjQzQu8ytDf6s79QFENqFt0=;
        fh=k0lSfoY4K4PVr/3JuZ9KTb8efoOrSs76Tua021rSRuE=;
        b=fBbT0a40/qK7/zVBjURWGmpBS5+lrwj+tKKgqPldyKTEJN/bU5PjI5zaTI3mDhvC0e
         TeNOG3Nkz0jPLz9l44z8sY/RVVI+C05Jcgz+gcY1xkH1IoC256Z5LLfVpOKpacRDgJBd
         JGSEiQhfF08DmyBhf8St6TivmlnomsBALVD6d984+p+H1dKwWMGYtTjXr3Vo3NDnNSzZ
         8Qc4XWySUogZtTLlFzCUD95JUdiDCqm6/JvSXSpWRvZBbZZy2x57K/swsMo1IlleFrJd
         9Ebke4nRawP6w0JlKaFZF65HmffWSfJBzi+LnC1WjWhGJiDj4mfVP0uGIVNDjcsXstVH
         HQVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778568256; x=1779173056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9/juFQ5EkLeK4MRC7rvbjQzQu8ytDf6s79QFENqFt0=;
        b=sZ8k1arBo/iltA0Zjf84h/5CURPNlBi/IQ10S32q1NesXxFDyIwF1txkWydnxMi1j1
         JtwnGLPQFB3sBFbZmkQgffqpzZ69/vklgxsF4by7Fu/h3SMsgM/FNkKBJRx2JcXbAyJt
         QcxHjT54H1WIf4CU1DDFVDRTX71KQMo29gOTkJwH0uhBZ2Nkr0StX8fOj7vY018pkNjd
         0LVy+gbJ9vOOZfcP09HIdeXsGxL/++qHn8h0ECVgQvtgroMag2bIzASLM6QJo7KD8n2V
         wd9ZpjCbfT/NXHweROqU0Y1ikwhKBEaq9LRpXZZFN2i5AF9h61R3zgbQCr3rG1yg5TUD
         5gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778568256; x=1779173056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9/juFQ5EkLeK4MRC7rvbjQzQu8ytDf6s79QFENqFt0=;
        b=DkD9ekcFwIZNfN/39jRcBtDyK2iUhhXQbmf9XPSVRh9H7xFtu4Yz9dw/7WeE2MMTCS
         +kAzqlxMsc/QPOKi+AdvwD/gVM4C/qTEnCt8KOqFSovBfqiXNkrw9Re7LP8IVnfOJMHU
         97McCG5A8dU2+BcPE/2q9nZCHXCbKwlEu9+vByjeyoQz0NZRkI58+HDVOLCWPIaEPdrn
         d1ozxJIZ1OPmI+5VNES/DakHOehLVHVnIiGKw0bud7B8Kq7scxyI1qG6/IQn8ZyqM1U6
         +eeuAQLm/cDh33gI8TFVbYi8RExDDWj7LKjEzt7rxI78Dg85Ok/wPmYcF3/wUYPic42s
         mUBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/PxLpxwB3S7s40KxRwR4OLxHcicLBVeMPGCqF4DLbzVXB5gHf9ByGK/wXRiEJCBtGy19+aqq5AGyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1TFt16itubKe12trHvfX9oDhkwSsPzeFFjVhZrYc3r22GnWoq
	xzFhUTE+vttI49BSJnlKGJiNOwvDYyDdRsIZPJd622+JsKWEcrStnoTbLiTz8e3f60FjLvJpKpO
	1o/FNQc0C+j8Z71x5e9a5Gr8KdY8rCFE=
X-Gm-Gg: Acq92OHOxx0SjITB53pfOZoVtdYpdXAgtZCM1wt1PKqGw75dRespcnohtnkfxY237D2
	3ezU7+L+X5tnq67hjN6syJJNDj7Mwimtv5NqLFqDtw30h4CQj9i9lU5ID3v+hZn6mRdqRKo8y0P
	cEz5U7bGc5Pzrp0wJv8N4BSJF7TzuY3GWPFAa1xBAdwRNIywmVhsIhqzx0mF+o55oMFH3g1FDRB
	Z5y3yKe6XqTuOXQf+usU9+nuMpSRdiDcHISnlvjJhyNfdbO30rH1njNtX7TD/60DctTJ3bCbcTA
	X4JVLj30dsLomDiwWbwQSOb0QIxEWj9s9rUlHyy8KoEr1Tfp+JefQQcWEK6Yb4i8w0TZiy6udHH
	2/eoC90g=
X-Received: by 2002:a17:907:728f:b0:bd1:d244:ca24 with SMTP id
 a640c23a62f3a-bd28e412eadmr84527766b.14.1778568255436; Mon, 11 May 2026
 23:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-5-3efcba579e88@protonmail.com>
In-Reply-To: <20260512-mt6323-v2-5-3efcba579e88@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 12 May 2026 09:43:38 +0300
X-Gm-Features: AVHnY4ISc11FAtQmtWdJlGYyo0XawWUZJbHlaYzrkD_vnuBBxzJNK6YMpmrGwVg
Message-ID: <CAHp75VdtORjmCCWy3-oiN-RQd+s7z=2G4s8hemv3xrq47vXu5g@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] iio: adc: mediatek: add mt6323 PMIC AUXADC driver
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 8:21=E2=80=AFAM Roman Vivchar via B4 Relay
<devnull+rva333.protonmail.com@kernel.org> wrote:
>
> The mt6323 AUXADC is a 15-bit ADC used for system monitoring. This driver
> provides support for reading various channels including battery and
> charger voltages, battery and chip temperature, current sensing and
> accessory detection.
>
> Add a driver for the AUXADC found in the MediaTek mt6323 PMIC.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/stringify.h>

+ time.h // USEC_PER_MSEC

> +#include <linux/types.h>

...

> +#define AUXADC_TRIM_CH2                (3 << 10)
> +#define AUXADC_TRIM_CH4                (3 << 8)
> +#define AUXADC_TRIM_CH5                (3 << 4)
> +#define AUXADC_TRIM_CH6                (3 << 2)

Without a comment it's hard to say if these are like masks or actual
values. Can you clarify that in the comment on top of these four?

> +#define VOLTAGE_FULL_RANGE     1800

Are there any units? Are they millivolts or is it just some scale?

...

> +#define MTK_PMIC_IIO_CHAN(_name, _idx, _ch_type)       \
> +{                                                      \
> +       .type =3D _ch_type,                              \
> +       .indexed =3D 1,                                  \
> +       .channel =3D _idx,                               \
> +       .address =3D _idx,                               \
> +       .datasheet_name =3D __stringify(_name),          \
> +       .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +                             BIT(IIO_CHAN_INFO_SCALE) \

Keep the trailing comma as this is not a terminator.

> +}

...

> +/**
> + * struct mt6323_auxadc - Main driver structure
> + * @regmap:        Regmap from PWRAP
> + * @lock:          Mutex to serialize AUXADC reading vs configuration
> + *
> + * The MediaTek MT6323 (as well as lot of other PMICs) have the followin=
g hierarchy:
> + * PMIC AUXADC <- PMIC MFD <- SoC PWRAP (wrapper for PWRAP FSM)
> + *
> + * Therefore, PWRAP regmap should be get using dev->parent->parent.

get --> obtained

> + */

...

> +static int mt6323_auxadc_prepare_channel(struct mt6323_auxadc *auxadc)
> +{
> +       struct regmap *map =3D auxadc->regmap;
> +       u32 val;
> +       int ret;
> +
> +       ret =3D regmap_read(map, MT6323_AUXADC_CON19, &val);
> +       if (ret)
> +               return ret;
> +
> +       /* The ADC is idle */
> +       if (!(val & AUXADC_DECI_GDLY_MASK))
> +               return 0;
> +
> +       ret =3D regmap_read_poll_timeout(map, MT6323_AUXADC_ADC19, val,
> +                                      !(val & AUXADC_ADC19_BUSY_MASK), 1=
0, 500);

It's better to have a logical split

       ret =3D regmap_read_poll_timeout(map, MT6323_AUXADC_ADC19,
                                      val, !(val & AUXADC_ADC19_BUSY_MASK),
                                      10, 500);

> +       if (ret)
> +               return ret;
> +
> +       return regmap_clear_bits(map, MT6323_AUXADC_CON19,
> +                                AUXADC_DECI_GDLY_MASK);
> +}

...

> +static int mt6323_auxadc_read(struct mt6323_auxadc *auxadc,
> +                             const struct iio_chan_spec *chan, int *out)
> +{
> +       struct regmap *map =3D auxadc->regmap;
> +       u32 val, reg =3D mt6323_auxadc_channel_to_reg(chan->address);
> +       int ret;
> +
> +       ret =3D regmap_read_poll_timeout(map, reg, val, (val & AUXADC_RDY=
_MASK),

Parentheses are not needed in this case. But I'm fine with it here as
it probably makes it easier to get the idea.

> +                                      1 * USEC_PER_MSEC, 100 * USEC_PER_=
MSEC);
> +       if (ret)
> +               return ret;
> +
> +       *out =3D FIELD_GET(AUXADC_DATA_MASK, val);
> +
> +       return 0;
> +}
> +
> +static int mt6323_auxadc_read_raw(struct iio_dev *indio_dev,
> +                                 const struct iio_chan_spec *chan, int *=
val,
> +                                 int *val2, long mask)

Logical split

static int mt6323_auxadc_read_raw(struct iio_dev *indio_dev,
                                 const struct iio_chan_spec *chan,
                                 int *val, int *val2, long mask)

> +{
> +       struct mt6323_auxadc *auxadc =3D iio_priv(indio_dev);
> +       int ret, mult =3D 1;

Decouple assignment and definition. These types of assignments are
hard to maintain and might lead to subtle mistakes in the future.

> +       if (mask =3D=3D IIO_CHAN_INFO_RAW) {
> +               guard(mutex)(&auxadc->lock);
> +               ret =3D mt6323_auxadc_prepare_channel(auxadc);
> +               if (ret)
> +                       return ret;
> +
> +               ret =3D mt6323_auxadc_request(auxadc, chan->address);
> +               if (ret)
> +                       return ret;

Please, add a comment with the reference to a datasheet (ideally)
explaining this sleep.

> +               fsleep(300);
> +
> +               ret =3D mt6323_auxadc_read(auxadc, chan, val);
> +               if (ret)
> +                       return ret;
> +               return IIO_VAL_INT;
> +       } else if (mask =3D=3D IIO_CHAN_INFO_SCALE) {

Redundant 'else'

> +               if (chan->channel =3D=3D MT6323_AUXADC_ISENSE ||
> +                   chan->channel =3D=3D MT6323_AUXADC_BATSNS)
> +                       mult =3D 4;
> +
> +               *val =3D mult * VOLTAGE_FULL_RANGE;
> +               *val2 =3D AUXADC_PRECISE;
> +
> +               return IIO_VAL_FRACTIONAL;

> +       } else

Ditto, and it's the wrong style. Read the Coding Style documentation
to clarify this.

> +               return -EINVAL;
> +}

...

> +       ret =3D devm_mutex_init(dev, &auxadc->lock);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to initialize mute=
x\n");

Unneeded error message. Most likely it's -ENOMEM, which will be
ignored by dev_err_probe() anyway.

...

> +       ret =3D devm_iio_device_register(dev, iio);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to register iio de=
vice\n");

If you don't see the device, it's failed to register, do we need this messa=
ge?

--=20
With Best Regards,
Andy Shevchenko
