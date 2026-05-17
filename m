Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062DD34B669
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016263; cv=pass; b=niiCnp09cIhxL+4zmwiJGvJkwQBAxGD7UuGS+bCyFbsWVI1UHghgtDOtZdIwA1WV+YFVAbN7oaIGKYAe4rtnzUA5LuOZMpFzz3Dx2c1gaa3Vmzez3rGKUG1wBzFsH6wxvZV8kvTMUs7en/t2SWHs/9Dmn5DkQzFNndGrEoHEKqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016263; c=relaxed/simple;
	bh=ShMaLCNr/VgKdxCHek+xVse9qU89hZyQZyzhFT/Ezbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNIExwV0/dKhLuFonZtyPP1H84HPnuq0Q9KzojLA9r1rfmuDg1AIpSBPCchnExKI3I1gdn9RhZG+wXq3HXl+UDySlkLKv7mmO6KaQeaGQzQb6eHSwwi1c8KYherRSfzGigrpuPyjvAl9J05llZX0CGxmrC5Re/90XrJ/JfX57U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMMJjAlh; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMMJjAlh"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso1028915eec.0
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 04:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779016260; cv=none;
        d=google.com; s=arc-20240605;
        b=aRa0mXkwO4bclJxBNUSD6uZmRArp7TFUawpe5srOShQVnyowb8tUnoJSp+Rtioe/sz
         2L+oDPIWKoTcj2HnT9+wZHqbI47X5enUnu2Ukgto0NOnvFZcdhPB/X9oNk+Sb+K+R/2h
         ULa/WtKVsGiss2qZXy3CHl6lon95lyflJtaewoRg5ui7xvO41AamBS27buftcrhmKstP
         Xa2v6O8SOiNyTh/Q0hMmhrHF8ugKTVhG95qjbWyvXoErwaf52msp2WDhC9X1zngFLLeb
         Sp29zOxFNB6Z6M2EgyK0jFjF1/KOBBoueS5zx2HUK6SLC/kb1zk5L+8kWkfseqPy4biX
         xwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=snzrrR3wVwJkBKvMHHxNRboz65c4mKmB9NEEOGiXb9Q=;
        fh=Q01m60KcXuA4I7g3KACwb0akfRIO7A0mpN5cJW60QE0=;
        b=FBWAsEQl5Ugs1etht+FCW8lLOlRLKQxjqpQhsJmyaPXm2O7kaPSALrlmZjRXudQ5KB
         tTS5mI6ur7W4Lifb1uCPE9QRDLBJhRbfY1/Llr06nrcy1+1LFGc0ss6XYbgmBkmdvTXZ
         D+72kzANngt+cMpbPvZ22kO/oFXSME/YSDUfBLDAbnNcWea4wlPs1LKw6btTJvHj59DY
         aLuOkDj3KRC9i2C9jDHKETG9JnD5PUx8rECB/QTP4equzIXFCComa38Meb7pbxl3SeNx
         4fDsP+Lzt7+mpF8v7+EEjyHfEotlbXiWZaboeAfEwHHOIeHM1tMvASXRcJhD9MtZafXw
         m4/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779016260; x=1779621060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snzrrR3wVwJkBKvMHHxNRboz65c4mKmB9NEEOGiXb9Q=;
        b=eMMJjAlhI1B5qeC0vjxHXg+S6JdxKKupk8XRom7Ul0tTEm8eYEjj+pDy1jbs+1JQ45
         6pJ6yKDUmw3nxnv+/MnOcaduupf3gZg96ueh/FVIPlh5yQ2pp/mTA4BlDkUoMgMtwdte
         lCEnZm+8ksmGnIeMDkbCU55+YlgNT0CHqEKLP4+lJ19AxXuwZR9eSlZqmqf5Vf/C7zDK
         HYh4c/wNoErYzUuKw/vUmPnlNW6IN5y5h9Fs4TQu8LBYhgP07fns/oM8+TS7j8+VvcmJ
         UWTmQMJgGM4QiMekkqX53xFFDvUqlgXzTAz87Cyyo4cWkqZ1p7CZRdA+S81AaOxfJrTR
         mO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779016260; x=1779621060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snzrrR3wVwJkBKvMHHxNRboz65c4mKmB9NEEOGiXb9Q=;
        b=i3G39ygyVM68F0IO2rExOHO038T8xjjQxUUbGeVMzt8sP8c6Iypy5ud852fJ/+dukz
         KNyaoUNkHSS+O4iAGYujQqwXlBpzwIFHKszzqXG15p4GxbBp/x/65GQhpbwGChuEz48f
         IX4EXddoLpNIdgSp3maxzJShs6PwITLF82B1lvWaeFGpEZ8jIavzMZ0z60LNqy19QOgn
         JPurpS5dKZuUB/J2loLQcHSO0CLj/IhkBmc854BdBPmG8froiP7SBz3P0JCRCdz5Yh/L
         RdxXxnWrtFz8jAp5E0AdnEK2S5+zAOK2GwPQX8n0yNC0cGnREPUao46kXiiiN+58ScoE
         nosQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QgCwzOcc0xMS3ZVNOYqDexgq/HT7KSgcX43xUv+sQW1GcPSjwW1xv+D5t8K9lZms4tOVE0/yjDbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIN/MzHN+x5OX5RnW+7am9lDzeuQMlF59hvw+eNK9EG2qYSKQ
	7lYseRq3pQT+IULoM7TITSKiBWtyZyGnkYi2ICFwoIjWfpBVvfEgKdoR/EyJThuxjYoASrtcv7r
	9mhgxXBZnPlGDTlJm4KPc2zR/plzE5i0=
X-Gm-Gg: Acq92OFJgQhPSQosVL+pW2VI0WjXBFSSEzY33pyKXj8xJGvQ+BxQGnq1QqcjAXqYWPs
	ufq8qt/OPvMUQrh3/7ZxoNc70CwR4/OPBMgSR78U/psSUTpVc+hzflY49zzoC0rwWxDGj+sgTx6
	WiYTOA3MeWTYL5o+GNkbiHugPa4KKXmKl//TVNrLTd46JDO7fOpgrBwR8MH62eWv3xksJ46yyy3
	KTzpygSrZLBgKLG87h/PtnTPvAu7BW3rOg0UkpgEKD7kKTeibw8JD0ih4rP5wStkk+KaiJ6CcYT
	1rDCdNvnUm185fmxueo=
X-Received: by 2002:a05:7300:a907:b0:2ed:e12:3769 with SMTP id
 5a478bee46e88-303986a143cmr4316860eec.31.1779016259935; Sun, 17 May 2026
 04:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <20260517074306.30937-3-clamor95@gmail.com>
In-Reply-To: <20260517074306.30937-3-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 17 May 2026 14:10:47 +0300
X-Gm-Features: AVHnY4LV-IvB6QPKjGEilEWyHZbNuKbo9cLQlJnnGSYCBhQn20NVpyVjWfqnnxA
Message-ID: <CAPVz0n3gLYXab4H+DihfTkdBkGPqTvmoFVY1Cwuafd70KPtYbA@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] mfd: lm3533: Convert to use OF bindings
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Rob Herring <robh@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	Svyatoslav Ryhel <clamor95@gmail.com>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 10:4=
3 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Since there are no users of this driver via platform data, remove the
> platform data support and switch to using Device Tree bindings.
> Additionally, optimize functions used only by platform data.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/iio/light/lm3533-als.c      | 123 +++++--------
>  drivers/leds/leds-lm3533.c          |  60 ++++---
>  drivers/mfd/lm3533-core.c           | 257 +++++++++-------------------
>  drivers/video/backlight/lm3533_bl.c |  52 ++++--
>  include/linux/mfd/lm3533.h          |  51 +-----
>  5 files changed, 202 insertions(+), 341 deletions(-)
>
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-al=
s.c
> index 99f0b903018c..853abb96e13f 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -16,15 +16,18 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/mfd/core.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/units.h>
>
>  #include <linux/mfd/lm3533.h>
>
>
> -#define LM3533_ALS_RESISTOR_MIN                        1
> -#define LM3533_ALS_RESISTOR_MAX                        127
> +#define LM3533_ALS_RESISTOR_MIN                        1575
> +#define LM3533_ALS_RESISTOR_MAX                        200000
>  #define LM3533_ALS_CHANNEL_CURRENT_MAX         2
>  #define LM3533_ALS_THRESH_MAX                  3
>  #define LM3533_ALS_ZONE_MAX                    4
> @@ -56,6 +59,9 @@ struct lm3533_als {
>
>         atomic_t zone;
>         struct mutex thresh_mutex;
> +
> +       bool pwm_mode;
> +       u32 r_select;
>  };
>
>
> @@ -714,64 +720,6 @@ static const struct attribute_group lm3533_als_attri=
bute_group =3D {
>         .attrs =3D lm3533_als_attributes
>  };
>
> -static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mo=
de)
> -{
> -       u8 mask =3D LM3533_ALS_INPUT_MODE_MASK;
> -       u8 val;
> -       int ret;
> -
> -       if (pwm_mode)
> -               val =3D mask;     /* pwm input */
> -       else
> -               val =3D 0;        /* analog input */
> -
> -       ret =3D lm3533_update(als->lm3533, LM3533_REG_ALS_CONF, val, mask=
);
> -       if (ret) {
> -               dev_err(&als->pdev->dev, "failed to set input mode %d\n",
> -                                                               pwm_mode)=
;
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -
> -static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
> -{
> -       int ret;
> -
> -       if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MA=
X) {
> -               dev_err(&als->pdev->dev, "invalid resistor value\n");
> -               return -EINVAL;
> -       }
> -
> -       ret =3D lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT,=
 val);
> -       if (ret) {
> -               dev_err(&als->pdev->dev, "failed to set resistor\n");
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -
> -static int lm3533_als_setup(struct lm3533_als *als,
> -                           const struct lm3533_als_platform_data *pdata)
> -{
> -       int ret;
> -
> -       ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> -       if (ret)
> -               return ret;
> -
> -       /* ALS input is always high impedance in PWM-mode. */
> -       if (!pdata->pwm_mode) {
> -               ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> -               if (ret)
> -                       return ret;
> -       }
> -
> -       return 0;
> -}
> -
>  static int lm3533_als_setup_irq(struct lm3533_als *als, void *dev)
>  {
>         u8 mask =3D LM3533_ALS_INT_ENABLE_MASK;
> @@ -784,7 +732,8 @@ static int lm3533_als_setup_irq(struct lm3533_als *al=
s, void *dev)
>                 return ret;
>         }
>
> -       ret =3D request_threaded_irq(als->irq, NULL, lm3533_als_isr,
> +       ret =3D devm_request_threaded_irq(&als->pdev->dev, als->irq, NULL=
,
> +                                       lm3533_als_isr,
>                                         IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>                                         dev_name(&als->pdev->dev), dev);
>         if (ret) {
> @@ -828,7 +777,6 @@ static const struct iio_info lm3533_als_info =3D {
>
>  static int lm3533_als_probe(struct platform_device *pdev)
>  {
> -       const struct lm3533_als_platform_data *pdata;
>         struct lm3533 *lm3533;
>         struct lm3533_als *als;
>         struct iio_dev *indio_dev;
> @@ -838,12 +786,6 @@ static int lm3533_als_probe(struct platform_device *=
pdev)
>         if (!lm3533)
>                 return -EINVAL;
>
> -       pdata =3D dev_get_platdata(&pdev->dev);
> -       if (!pdata) {
> -               dev_err(&pdev->dev, "no platform data\n");
> -               return -EINVAL;
> -       }
> -
>         indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*als));
>         if (!indio_dev)
>                 return -ENOMEM;
> @@ -852,31 +794,52 @@ static int lm3533_als_probe(struct platform_device =
*pdev)
>         indio_dev->channels =3D lm3533_als_channels;
>         indio_dev->num_channels =3D ARRAY_SIZE(lm3533_als_channels);
>         indio_dev->name =3D dev_name(&pdev->dev);
> -       iio_device_set_parent(indio_dev, pdev->dev.parent);
>         indio_dev->modes =3D INDIO_DIRECT_MODE;
>
>         als =3D iio_priv(indio_dev);
>         als->lm3533 =3D lm3533;
>         als->pdev =3D pdev;
> -       als->irq =3D lm3533->irq;
> +       als->irq =3D platform_get_irq_optional(pdev, 0);
>         atomic_set(&als->zone, 0);
>         mutex_init(&als->thresh_mutex);
>
>         platform_set_drvdata(pdev, indio_dev);
>
> -       if (als->irq) {
> +       if (als->irq > 0) {
>                 ret =3D lm3533_als_setup_irq(als, indio_dev);
>                 if (ret)
>                         return ret;
>         }
>
> -       ret =3D lm3533_als_setup(als, pdata);
> +       device_property_read_u32(&pdev->dev, "ti,resistor-value-ohm",
> +                                &als->r_select);
> +
> +       als->r_select =3D clamp(als->r_select, LM3533_ALS_RESISTOR_MIN,
> +                             LM3533_ALS_RESISTOR_MAX);
> +       als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r_select);
> +
> +       als->pwm_mode =3D device_property_read_bool(&pdev->dev, "ti,pwm-m=
ode");
> +
> +       ret =3D lm3533_update(lm3533, LM3533_REG_ALS_CONF, als->pwm_mode =
?
> +                           LM3533_ALS_INPUT_MODE_MASK : 0,
> +                           LM3533_ALS_INPUT_MODE_MASK);
>         if (ret)
> -               goto err_free_irq;
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "failed to set input mode %d\n",
> +                                    als->pwm_mode);
> +
> +       /* ALS input is always high impedance in PWM-mode. */
> +       if (!als->pwm_mode) {
> +               ret =3D lm3533_write(lm3533, LM3533_REG_ALS_RESISTOR_SELE=
CT,
> +                                  (u8)als->r_select);
> +               if (ret)
> +                       return dev_err_probe(&pdev->dev, ret,
> +                                            "failed to set resistor\n");
> +       }
>
>         ret =3D lm3533_als_enable(als);
>         if (ret)
> -               goto err_free_irq;
> +               return ret;
>
>         ret =3D iio_device_register(indio_dev);
>         if (ret) {
> @@ -888,9 +851,6 @@ static int lm3533_als_probe(struct platform_device *p=
dev)
>
>  err_disable:
>         lm3533_als_disable(als);
> -err_free_irq:
> -       if (als->irq)
> -               free_irq(als->irq, indio_dev);
>
>         return ret;
>  }
> @@ -903,13 +863,18 @@ static void lm3533_als_remove(struct platform_devic=
e *pdev)
>         lm3533_als_set_int_mode(indio_dev, false);
>         iio_device_unregister(indio_dev);
>         lm3533_als_disable(als);
> -       if (als->irq)
> -               free_irq(als->irq, indio_dev);
>  }
>
> +static const struct of_device_id lm3533_als_match_table[] =3D {
> +       { .compatible =3D "ti,lm3533-als" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, lm3533_als_match_table);
> +
>  static struct platform_driver lm3533_als_driver =3D {
>         .driver =3D {
>                 .name   =3D "lm3533-als",
> +               .of_match_table =3D lm3533_als_match_table,
>         },
>         .probe          =3D lm3533_als_probe,
>         .remove         =3D lm3533_als_remove,
> diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> index 45795f2a1042..f6345bc1f443 100644
> --- a/drivers/leds/leds-lm3533.c
> +++ b/drivers/leds/leds-lm3533.c
> @@ -10,8 +10,10 @@
>  #include <linux/module.h>
>  #include <linux/leds.h>
>  #include <linux/mfd/core.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>
>  #include <linux/mfd/lm3533.h>
> @@ -48,6 +50,9 @@ struct lm3533_led {
>
>         struct mutex mutex;
>         unsigned long flags;
> +
> +       u32 max_current;
> +       u32 pwm;
>  };
>
>
> @@ -632,22 +637,20 @@ static const struct attribute_group *lm3533_led_att=
ribute_groups[] =3D {
>         NULL
>  };
>
> -static int lm3533_led_setup(struct lm3533_led *led,
> -                                       struct lm3533_led_platform_data *=
pdata)
> +static int lm3533_led_setup(struct lm3533_led *led)
>  {
>         int ret;
>
> -       ret =3D lm3533_ctrlbank_set_max_current(&led->cb, pdata->max_curr=
ent);
> +       ret =3D lm3533_ctrlbank_set_max_current(&led->cb, led->max_curren=
t);
>         if (ret)
>                 return ret;
>
> -       return lm3533_ctrlbank_set_pwm(&led->cb, pdata->pwm);
> +       return lm3533_ctrlbank_set_pwm(&led->cb, led->pwm);
>  }
>
>  static int lm3533_led_probe(struct platform_device *pdev)
>  {
>         struct lm3533 *lm3533;
> -       struct lm3533_led_platform_data *pdata;
>         struct lm3533_led *led;
>         int ret;
>
> @@ -657,30 +660,30 @@ static int lm3533_led_probe(struct platform_device =
*pdev)
>         if (!lm3533)
>                 return -EINVAL;
>
> -       pdata =3D dev_get_platdata(&pdev->dev);
> -       if (!pdata) {
> -               dev_err(&pdev->dev, "no platform data\n");
> -               return -EINVAL;
> -       }
> -
> -       if (pdev->id < 0 || pdev->id >=3D LM3533_LVCTRLBANK_COUNT) {
> -               dev_err(&pdev->dev, "illegal LED id %d\n", pdev->id);
> -               return -EINVAL;
> -       }
> +       if (pdev->id < LM3533_LVCTRLBANK_MIN || pdev->id > LM3533_LVCTRLB=
ANK_MAX)
> +               return dev_err_probe(&pdev->dev, -EINVAL,
> +                                    "illegal LED id %d\n", pdev->id);
>
>         led =3D devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
>         if (!led)
>                 return -ENOMEM;
>
>         led->lm3533 =3D lm3533;
> -       led->cdev.name =3D pdata->name;
> -       led->cdev.default_trigger =3D pdata->default_trigger;
>         led->cdev.brightness_set_blocking =3D lm3533_led_set;
>         led->cdev.brightness_get =3D lm3533_led_get;
>         led->cdev.blink_set =3D lm3533_led_blink_set;
>         led->cdev.brightness =3D LED_OFF;
>         led->cdev.groups =3D lm3533_led_attribute_groups;
> -       led->id =3D pdev->id;
> +       led->id =3D pdev->id - LM3533_LVCTRLBANK_MIN;
> +
> +       led->cdev.name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d"=
,
> +                                       pdev->name, led->id);
> +       if (!led->cdev.name)
> +               return -ENOMEM;
> +
> +       led->cdev.default_trigger =3D "none";
> +       device_property_read_string(&pdev->dev, "linux,default-trigger",
> +                                   &led->cdev.default_trigger);
>
>         mutex_init(&led->mutex);
>
> @@ -694,15 +697,23 @@ static int lm3533_led_probe(struct platform_device =
*pdev)
>
>         platform_set_drvdata(pdev, led);
>
> -       ret =3D led_classdev_register(pdev->dev.parent, &led->cdev);
> +       ret =3D led_classdev_register(&pdev->dev, &led->cdev);
>         if (ret) {
> -               dev_err(&pdev->dev, "failed to register LED %d\n", pdev->=
id);
> +               dev_err(&pdev->dev, "failed to register LED %d\n", led->i=
d);
>                 return ret;
>         }
>
>         led->cb.dev =3D led->cdev.dev;
>
> -       ret =3D lm3533_led_setup(led, pdata);
> +       device_property_read_u32(&pdev->dev, "led-max-microamp",
> +                                &led->max_current);
> +       led->max_current =3D clamp(led->max_current, LM3533_LED_MAX_CURRE=
NT_MIN,
> +                                LM3533_LED_MAX_CURRENT_MAX);
> +
> +       led->pwm =3D 0;
> +       device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->=
pwm);
> +
> +       ret =3D lm3533_led_setup(led);
>         if (ret)
>                 goto err_deregister;
>
> @@ -739,9 +750,16 @@ static void lm3533_led_shutdown(struct platform_devi=
ce *pdev)
>         lm3533_led_set(&led->cdev, LED_OFF);            /* disable blink =
*/
>  }
>
> +static const struct of_device_id lm3533_led_match_table[] =3D {
> +       { .compatible =3D "ti,lm3533-leds" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, lm3533_led_match_table);
> +
>  static struct platform_driver lm3533_led_driver =3D {
>         .driver =3D {
>                 .name =3D "lm3533-leds",
> +               .of_match_table =3D lm3533_led_match_table,
>         },
>         .probe          =3D lm3533_led_probe,
>         .remove         =3D lm3533_led_remove,
> diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
> index 0a2409d00b2e..83ebd780f39d 100644
> --- a/drivers/mfd/lm3533-core.c
> +++ b/drivers/mfd/lm3533-core.c
> @@ -14,19 +14,26 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/mfd/core.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/units.h>
>
>  #include <linux/mfd/lm3533.h>
>
>
>  #define LM3533_BOOST_OVP_MASK          0x06
>  #define LM3533_BOOST_OVP_SHIFT         1
> +#define LM3533_BOOST_OVP_MIN           16000000
> +#define LM3533_BOOST_OVP_MAX           40000000
>
>  #define LM3533_BOOST_FREQ_MASK         0x01
>  #define LM3533_BOOST_FREQ_SHIFT                0
> +#define LM3533_BOOST_FREQ_MIN          500000
> +#define LM3533_BOOST_FREQ_MAX          1000000
>
>  #define LM3533_BL_ID_MASK              1
>  #define LM3533_LED_ID_MASK             3
> @@ -42,42 +49,14 @@
>
>  #define LM3533_REG_MAX                 0xb2
>
> -
> -static struct mfd_cell lm3533_als_devs[] =3D {
> -       {
> -               .name   =3D "lm3533-als",
> -               .id     =3D -1,
> -       },
> -};
> -
> -static struct mfd_cell lm3533_bl_devs[] =3D {
> -       {
> -               .name   =3D "lm3533-backlight",
> -               .id     =3D 0,
> -       },
> -       {
> -               .name   =3D "lm3533-backlight",
> -               .id     =3D 1,
> -       },
> -};
> -
> -static struct mfd_cell lm3533_led_devs[] =3D {
> -       {
> -               .name   =3D "lm3533-leds",
> -               .id     =3D 0,
> -       },
> -       {
> -               .name   =3D "lm3533-leds",
> -               .id     =3D 1,
> -       },
> -       {
> -               .name   =3D "lm3533-leds",
> -               .id     =3D 2,
> -       },
> -       {
> -               .name   =3D "lm3533-leds",
> -               .id     =3D 3,
> -       },
> +static struct mfd_cell lm3533_child_devices[] =3D {
> +       MFD_CELL_OF("lm3533-als", NULL, NULL, 0, 0, "ti,lm3533-als"),
> +       MFD_CELL_OF_REG("lm3533-backlight", NULL, NULL, 0, 0, "ti,lm3533-=
backlight", 0),
> +       MFD_CELL_OF_REG("lm3533-backlight", NULL, NULL, 0, 1, "ti,lm3533-=
backlight", 1),
> +       MFD_CELL_OF_REG("lm3533-leds", NULL, NULL, 0, 0, "ti,lm3533-leds"=
, 2),
> +       MFD_CELL_OF_REG("lm3533-leds", NULL, NULL, 0, 1, "ti,lm3533-leds"=
, 3),
> +       MFD_CELL_OF_REG("lm3533-leds", NULL, NULL, 0, 2, "ti,lm3533-leds"=
, 4),
> +       MFD_CELL_OF_REG("lm3533-leds", NULL, NULL, 0, 3, "ti,lm3533-leds"=
, 5),
>  };
>
>  int lm3533_read(struct lm3533 *lm3533, u8 reg, u8 *val)
> @@ -132,35 +111,6 @@ int lm3533_update(struct lm3533 *lm3533, u8 reg, u8 =
val, u8 mask)
>  }
>  EXPORT_SYMBOL_GPL(lm3533_update);
>
> -static int lm3533_set_boost_freq(struct lm3533 *lm3533,
> -                                               enum lm3533_boost_freq fr=
eq)
> -{
> -       int ret;
> -
> -       ret =3D lm3533_update(lm3533, LM3533_REG_BOOST_PWM,
> -                                       freq << LM3533_BOOST_FREQ_SHIFT,
> -                                       LM3533_BOOST_FREQ_MASK);
> -       if (ret)
> -               dev_err(lm3533->dev, "failed to set boost frequency\n");
> -
> -       return ret;
> -}
> -
> -
> -static int lm3533_set_boost_ovp(struct lm3533 *lm3533,
> -                                               enum lm3533_boost_ovp ovp=
)
> -{
> -       int ret;
> -
> -       ret =3D lm3533_update(lm3533, LM3533_REG_BOOST_PWM,
> -                                       ovp << LM3533_BOOST_OVP_SHIFT,
> -                                       LM3533_BOOST_OVP_MASK);
> -       if (ret)
> -               dev_err(lm3533->dev, "failed to set boost ovp\n");
> -
> -       return ret;
> -}
> -
>  /*
>   * HVLED output config -- output hvled controlled by backlight bl
>   */
> @@ -376,136 +326,45 @@ static struct attribute_group lm3533_attribute_gro=
up =3D {
>         .attrs          =3D lm3533_attributes
>  };
>
> -static int lm3533_device_als_init(struct lm3533 *lm3533)
> +static int lm3533_device_init(struct lm3533 *lm3533)
>  {
> -       struct lm3533_platform_data *pdata =3D dev_get_platdata(lm3533->d=
ev);
> +       struct device *dev =3D lm3533->dev;
>         int ret;
>
> -       if (!pdata->als)
> -               return 0;
> -
> -       lm3533_als_devs[0].platform_data =3D pdata->als;
> -       lm3533_als_devs[0].pdata_size =3D sizeof(*pdata->als);
> +       lm3533_enable(lm3533);
>
> -       ret =3D mfd_add_devices(lm3533->dev, 0, lm3533_als_devs, 1, NULL,
> -                             0, NULL);
> +       ret =3D lm3533_update(lm3533, LM3533_REG_BOOST_PWM,
> +                           lm3533->boost_freq << LM3533_BOOST_FREQ_SHIFT=
,
> +                           LM3533_BOOST_FREQ_MASK);
>         if (ret) {
> -               dev_err(lm3533->dev, "failed to add ALS device\n");
> -               return ret;
> -       }
> -
> -       lm3533->have_als =3D 1;
> -
> -       return 0;
> -}
> -
> -static int lm3533_device_bl_init(struct lm3533 *lm3533)
> -{
> -       struct lm3533_platform_data *pdata =3D dev_get_platdata(lm3533->d=
ev);
> -       int i;
> -       int ret;
> -
> -       if (!pdata->backlights || pdata->num_backlights =3D=3D 0)
> -               return 0;
> -
> -       if (pdata->num_backlights > ARRAY_SIZE(lm3533_bl_devs))
> -               pdata->num_backlights =3D ARRAY_SIZE(lm3533_bl_devs);
> -
> -       for (i =3D 0; i < pdata->num_backlights; ++i) {
> -               lm3533_bl_devs[i].platform_data =3D &pdata->backlights[i]=
;
> -               lm3533_bl_devs[i].pdata_size =3D sizeof(pdata->backlights=
[i]);
> +               dev_err(dev, "failed to set boost frequency\n");
> +               goto err_disable;
>         }
>
> -       ret =3D mfd_add_devices(lm3533->dev, 0, lm3533_bl_devs,
> -                             pdata->num_backlights, NULL, 0, NULL);
> +       ret =3D lm3533_update(lm3533, LM3533_REG_BOOST_PWM,
> +                           lm3533->boost_ovp << LM3533_BOOST_OVP_SHIFT,
> +                           LM3533_BOOST_OVP_MASK);
>         if (ret) {
> -               dev_err(lm3533->dev, "failed to add backlight devices\n")=
;
> -               return ret;
> -       }
> -
> -       lm3533->have_backlights =3D 1;
> -
> -       return 0;
> -}
> -
> -static int lm3533_device_led_init(struct lm3533 *lm3533)
> -{
> -       struct lm3533_platform_data *pdata =3D dev_get_platdata(lm3533->d=
ev);
> -       int i;
> -       int ret;
> -
> -       if (!pdata->leds || pdata->num_leds =3D=3D 0)
> -               return 0;
> -
> -       if (pdata->num_leds > ARRAY_SIZE(lm3533_led_devs))
> -               pdata->num_leds =3D ARRAY_SIZE(lm3533_led_devs);
> -
> -       for (i =3D 0; i < pdata->num_leds; ++i) {
> -               lm3533_led_devs[i].platform_data =3D &pdata->leds[i];
> -               lm3533_led_devs[i].pdata_size =3D sizeof(pdata->leds[i]);
> +               dev_err(dev, "failed to set boost ovp\n");
> +               goto err_disable;
>         }
>
> -       ret =3D mfd_add_devices(lm3533->dev, 0, lm3533_led_devs,
> -                             pdata->num_leds, NULL, 0, NULL);
> +       ret =3D devm_mfd_add_devices(dev, 0, lm3533_child_devices,
> +                                  ARRAY_SIZE(lm3533_child_devices),
> +                                  NULL, 0, NULL);

Question to Lee Jones. Would you find acceptable if the driver will
build cell list dynamically based on the nodes in the device tree?
This is LED controller after all, not all leds can be populated and
same LED control bank can be linked to all LVLEDs for example.

If you are ok, would this implementation satisfy you?

        struct mfd_cell lm3533_cells[LM3533_CELLS_MAX];
        u32 count =3D 0, reg;
        int ret;

        device_for_each_child_node_scoped(lm3533->dev, child) {
                if (!fwnode_device_is_available(child))
                        continue;

                if (count >=3D LM3533_CELLS_MAX)
                        break;

                if (fwnode_device_is_compatible(child, "ti,lm3533-als")) {
                        lm3533_cells[count].name =3D "lm3533-als";
                        lm3533_cells[count].id =3D PLATFORM_DEVID_NONE;
                        lm3533_cells[count].of_compatible =3D "ti,lm3533-al=
s";

                        lm3533->have_als =3D true;
                }

                if (fwnode_device_is_compatible(child, "ti,lm3533-backlight=
")) {
                        ret =3D fwnode_property_read_u32(child, "reg", &reg=
);
                        if (ret || reg > LM3533_HVLED_ID_MAX) {
                                dev_err(dev, "invalid backlight reg %d\n", =
reg);
                                continue;
                        }

                        lm3533_cells[count].name =3D "lm3533-backlight";
                        lm3533_cells[count].id =3D reg;
                        lm3533_cells[count].of_compatible =3D
"ti,lm3533-backlight";

                        lm3533->have_backlights =3D true;
                }

                if (fwnode_device_is_compatible(child, "ti,lm3533-leds")) {
                        ret =3D fwnode_property_read_u32(child, "reg", &reg=
);
                        if (ret || reg < LM3533_HVLED_ID_MAX ||
                            reg > LM3533_LVLED_ID_MAX) {
                                dev_err(dev, "invalid LED reg %d\n", reg);
                                continue;
                        }

                        lm3533_cells[count].name =3D "lm3533-leds";
                        lm3533_cells[count].id =3D reg - LM3533_HVLED_ID_MA=
X;
                        lm3533_cells[count].of_compatible =3D "ti,lm3533-le=
ds";

                        lm3533->have_leds =3D true;
                }

                count++;
        }

>         if (ret) {
> -               dev_err(lm3533->dev, "failed to add LED devices\n");
> -               return ret;
> -       }
> -
> -       lm3533->have_leds =3D 1;
> -
> -       return 0;
> -}
> -
> -static int lm3533_device_setup(struct lm3533 *lm3533,
> -                                       struct lm3533_platform_data *pdat=
a)
> -{
> -       int ret;
> -
> -       ret =3D lm3533_set_boost_freq(lm3533, pdata->boost_freq);
> -       if (ret)
> -               return ret;
> -
> -       return lm3533_set_boost_ovp(lm3533, pdata->boost_ovp);
> -}
> -
> -static int lm3533_device_init(struct lm3533 *lm3533)
> -{
> -       struct lm3533_platform_data *pdata =3D dev_get_platdata(lm3533->d=
ev);
> -       int ret;
> -
> -       dev_dbg(lm3533->dev, "%s\n", __func__);
> -
> -       if (!pdata) {
> -               dev_err(lm3533->dev, "no platform data\n");
> -               return -EINVAL;
> +               dev_err(dev, "failed to add MFD devices: %d\n", ret);
> +               goto err_disable;
>         }
>
> -       lm3533->hwen =3D devm_gpiod_get(lm3533->dev, NULL, GPIOD_OUT_LOW)=
;
> -       if (IS_ERR(lm3533->hwen))
> -               return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen), =
"failed to request HWEN GPIO\n");
> -       gpiod_set_consumer_name(lm3533->hwen, "lm3533-hwen");
> -
> -       lm3533_enable(lm3533);
> -
> -       ret =3D lm3533_device_setup(lm3533, pdata);
> -       if (ret)
> +       ret =3D sysfs_create_group(&dev->kobj, &lm3533_attribute_group);
> +       if (ret) {
> +               dev_err(dev, "failed to create sysfs attributes\n");
>                 goto err_disable;
> -
> -       lm3533_device_als_init(lm3533);
> -       lm3533_device_bl_init(lm3533);
> -       lm3533_device_led_init(lm3533);
> -
> -       ret =3D sysfs_create_group(&lm3533->dev->kobj, &lm3533_attribute_=
group);
> -       if (ret < 0) {
> -               dev_err(lm3533->dev, "failed to create sysfs attributes\n=
");
> -               goto err_unregister;
>         }
>
>         return 0;
>
> -err_unregister:
> -       mfd_remove_devices(lm3533->dev);
>  err_disable:
>         lm3533_disable(lm3533);
>
> @@ -517,8 +376,6 @@ static void lm3533_device_exit(struct lm3533 *lm3533)
>         dev_dbg(lm3533->dev, "%s\n", __func__);
>
>         sysfs_remove_group(&lm3533->dev->kobj, &lm3533_attribute_group);
> -
> -       mfd_remove_devices(lm3533->dev);
>         lm3533_disable(lm3533);
>  }
>
> @@ -589,7 +446,40 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
>                 return PTR_ERR(lm3533->regmap);
>
>         lm3533->dev =3D &i2c->dev;
> -       lm3533->irq =3D i2c->irq;
> +
> +       lm3533->hwen =3D devm_gpiod_get_optional(lm3533->dev, "enable",
> +                                              GPIOD_OUT_LOW);
> +       if (IS_ERR(lm3533->hwen))
> +               return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen),
> +                                    "failed to get HWEN GPIO\n");
> +
> +       device_property_read_u32(lm3533->dev, "ti,boost-ovp-microvolt",
> +                                &lm3533->boost_ovp);
> +
> +       lm3533->boost_ovp =3D clamp(lm3533->boost_ovp, LM3533_BOOST_OVP_M=
IN,
> +                                 LM3533_BOOST_OVP_MAX);
> +       lm3533->boost_ovp =3D lm3533->boost_ovp / (8 * MICRO) - 2;
> +
> +       device_property_read_u32(lm3533->dev, "ti,boost-freq-hz",
> +                                &lm3533->boost_freq);
> +
> +       lm3533->boost_freq =3D clamp(lm3533->boost_freq, LM3533_BOOST_FRE=
Q_MIN,
> +                                  LM3533_BOOST_FREQ_MAX);
> +       lm3533->boost_freq =3D lm3533->boost_freq / (500 * KILO) - 1;
> +
> +       device_for_each_child_node_scoped(lm3533->dev, child) {
> +               if (!fwnode_device_is_available(child))
> +                       continue;
> +
> +               if (fwnode_device_is_compatible(child, "ti,lm3533-als"))
> +                       lm3533->have_als =3D true;
> +
> +               if (fwnode_device_is_compatible(child, "ti,lm3533-backlig=
ht"))
> +                       lm3533->have_backlights =3D true;
> +
> +               if (fwnode_device_is_compatible(child, "ti,lm3533-leds"))
> +                       lm3533->have_leds =3D true;
> +       }
>
>         return lm3533_device_init(lm3533);
>  }
> @@ -603,6 +493,12 @@ static void lm3533_i2c_remove(struct i2c_client *i2c=
)
>         lm3533_device_exit(lm3533);
>  }
>
> +static const struct of_device_id lm3533_match_table[] =3D {
> +       { .compatible =3D "ti,lm3533" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, lm3533_match_table);
> +
>  static const struct i2c_device_id lm3533_i2c_ids[] =3D {
>         { "lm3533" },
>         { }
> @@ -612,6 +508,7 @@ MODULE_DEVICE_TABLE(i2c, lm3533_i2c_ids);
>  static struct i2c_driver lm3533_i2c_driver =3D {
>         .driver =3D {
>                    .name =3D "lm3533",
> +                  .of_match_table =3D lm3533_match_table,
>         },
>         .id_table       =3D lm3533_i2c_ids,
>         .probe          =3D lm3533_i2c_probe,
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backligh=
t/lm3533_bl.c
> index babfd3ceec86..42da652df58d 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -9,7 +9,9 @@
>
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/backlight.h>
>  #include <linux/slab.h>
>
> @@ -27,6 +29,9 @@ struct lm3533_bl {
>         struct lm3533_ctrlbank cb;
>         struct backlight_device *bd;
>         int id;
> +
> +       u32 max_current;
> +       u32 pwm;
>  };
>
>
> @@ -246,25 +251,24 @@ static struct attribute_group lm3533_bl_attribute_g=
roup =3D {
>         .attrs          =3D lm3533_bl_attributes
>  };
>
> -static int lm3533_bl_setup(struct lm3533_bl *bl,
> -                                       struct lm3533_bl_platform_data *p=
data)
> +static int lm3533_bl_setup(struct lm3533_bl *bl)
>  {
>         int ret;
>
> -       ret =3D lm3533_ctrlbank_set_max_current(&bl->cb, pdata->max_curre=
nt);
> +       ret =3D lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current)=
;
>         if (ret)
>                 return ret;
>
> -       return lm3533_ctrlbank_set_pwm(&bl->cb, pdata->pwm);
> +       return lm3533_ctrlbank_set_pwm(&bl->cb, bl->pwm);
>  }
>
>  static int lm3533_bl_probe(struct platform_device *pdev)
>  {
>         struct lm3533 *lm3533;
> -       struct lm3533_bl_platform_data *pdata;
>         struct lm3533_bl *bl;
>         struct backlight_device *bd;
>         struct backlight_properties props;
> +       char *name =3D NULL;
>         int ret;
>
>         dev_dbg(&pdev->dev, "%s\n", __func__);
> @@ -273,12 +277,6 @@ static int lm3533_bl_probe(struct platform_device *p=
dev)
>         if (!lm3533)
>                 return -EINVAL;
>
> -       pdata =3D dev_get_platdata(&pdev->dev);
> -       if (!pdata) {
> -               dev_err(&pdev->dev, "no platform data\n");
> -               return -EINVAL;
> -       }
> -
>         if (pdev->id < 0 || pdev->id >=3D LM3533_HVCTRLBANK_COUNT) {
>                 dev_err(&pdev->dev, "illegal backlight id %d\n", pdev->id=
);
>                 return -EINVAL;
> @@ -295,13 +293,20 @@ static int lm3533_bl_probe(struct platform_device *=
pdev)
>         bl->cb.id =3D lm3533_bl_get_ctrlbank_id(bl);
>         bl->cb.dev =3D NULL;                      /* until registered */
>
> +       name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
> +                             pdev->name, pdev->id);
> +       if (!name)
> +               return -ENOMEM;
> +
>         memset(&props, 0, sizeof(props));
>         props.type =3D BACKLIGHT_RAW;
>         props.max_brightness =3D LM3533_BL_MAX_BRIGHTNESS;
> -       props.brightness =3D pdata->default_brightness;
> -       bd =3D devm_backlight_device_register(&pdev->dev, pdata->name,
> -                                       pdev->dev.parent, bl, &lm3533_bl_=
ops,
> -                                       &props);
> +       props.brightness =3D LM3533_BL_MAX_BRIGHTNESS;
> +       device_property_read_u32(&pdev->dev, "default-brightness",
> +                                &props.brightness);
> +
> +       bd =3D devm_backlight_device_register(&pdev->dev, name, &pdev->de=
v,
> +                                           bl, &lm3533_bl_ops, &props);
>         if (IS_ERR(bd)) {
>                 dev_err(&pdev->dev, "failed to register backlight device\=
n");
>                 return PTR_ERR(bd);
> @@ -320,7 +325,15 @@ static int lm3533_bl_probe(struct platform_device *p=
dev)
>
>         backlight_update_status(bd);
>
> -       ret =3D lm3533_bl_setup(bl, pdata);
> +       device_property_read_u32(&pdev->dev, "led-max-microamp",
> +                                &bl->max_current);
> +       bl->max_current =3D clamp(bl->max_current, LM3533_LED_MAX_CURRENT=
_MIN,
> +                               LM3533_LED_MAX_CURRENT_MAX);
> +
> +       bl->pwm =3D 0;
> +       device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->p=
wm);
> +
> +       ret =3D lm3533_bl_setup(bl);
>         if (ret)
>                 goto err_sysfs_remove;
>
> @@ -381,10 +394,17 @@ static void lm3533_bl_shutdown(struct platform_devi=
ce *pdev)
>         lm3533_ctrlbank_disable(&bl->cb);
>  }
>
> +static const struct of_device_id lm3533_bl_match_table[] =3D {
> +       { .compatible =3D "ti,lm3533-backlight" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, lm3533_bl_match_table);
> +
>  static struct platform_driver lm3533_bl_driver =3D {
>         .driver =3D {
>                 .name   =3D "lm3533-backlight",
>                 .pm     =3D &lm3533_bl_pm_ops,
> +               .of_match_table =3D lm3533_bl_match_table,
>         },
>         .probe          =3D lm3533_bl_probe,
>         .remove         =3D lm3533_bl_remove,
> diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
> index 69059a7a2ce5..3aa962d4c747 100644
> --- a/include/linux/mfd/lm3533.h
> +++ b/include/linux/mfd/lm3533.h
> @@ -15,6 +15,9 @@
>  #define LM3533_ATTR_RW(_name) \
>         DEVICE_ATTR(_name, S_IRUGO | S_IWUSR , show_##_name, store_##_nam=
e)
>
> +#define LM3533_LED_MAX_CURRENT_MIN     5000
> +#define LM3533_LED_MAX_CURRENT_MAX     29800
> +
>  struct device;
>  struct gpio_desc;
>  struct regmap;
> @@ -25,7 +28,9 @@ struct lm3533 {
>         struct regmap *regmap;
>
>         struct gpio_desc *hwen;
> -       int irq;
> +
> +       u32 boost_ovp;
> +       u32 boost_freq;
>
>         unsigned have_als:1;
>         unsigned have_backlights:1;
> @@ -38,50 +43,6 @@ struct lm3533_ctrlbank {
>         int id;
>  };
>
> -struct lm3533_als_platform_data {
> -       unsigned pwm_mode:1;            /* PWM input mode (default analog=
) */
> -       u8 r_select;                    /* 1 - 127 (ignored in PWM-mode) =
*/
> -};
> -
> -struct lm3533_bl_platform_data {
> -       char *name;
> -       u16 max_current;                /* 5000 - 29800 uA (800 uA step) =
*/
> -       u8 default_brightness;          /* 0 - 255 */
> -       u8 pwm;                         /* 0 - 0x3f */
> -};
> -
> -struct lm3533_led_platform_data {
> -       char *name;
> -       const char *default_trigger;
> -       u16 max_current;                /* 5000 - 29800 uA (800 uA step) =
*/
> -       u8 pwm;                         /* 0 - 0x3f */
> -};
> -
> -enum lm3533_boost_freq {
> -       LM3533_BOOST_FREQ_500KHZ,
> -       LM3533_BOOST_FREQ_1000KHZ,
> -};
> -
> -enum lm3533_boost_ovp {
> -       LM3533_BOOST_OVP_16V,
> -       LM3533_BOOST_OVP_24V,
> -       LM3533_BOOST_OVP_32V,
> -       LM3533_BOOST_OVP_40V,
> -};
> -
> -struct lm3533_platform_data {
> -       enum lm3533_boost_ovp boost_ovp;
> -       enum lm3533_boost_freq boost_freq;
> -
> -       struct lm3533_als_platform_data *als;
> -
> -       struct lm3533_bl_platform_data *backlights;
> -       int num_backlights;
> -
> -       struct lm3533_led_platform_data *leds;
> -       int num_leds;
> -};
> -
>  extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
>  extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
>
> --
> 2.51.0
>
