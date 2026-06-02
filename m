Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07E3F39C8
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410548; cv=pass; b=cEQb+ggI7Tr/jW1fw+KMGummUBVTzt7FbT5TNdrI/J/YhukoHo+V861QqGdFtn/vOmIkAWp/js1l6gacMfneWduEVzcCZHeZRMPsDD0YSGSptrUEJuB210mOmRhcGb1Hhaspbj61hiOmAcoSPNwpdw7jhoYqpSwCRwgamq478cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410548; c=relaxed/simple;
	bh=pCKVJKfsgqUTs8AS/FfeirHvz2C/Fw3t9KjvROqrw3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHJC7Y7TstkHzuJkF4plztBLEEO+Asr09KtY/jXU2TyD3p+yQxwLVsjZ59obl0CSFqfVWfaiKhe8k/JtsL3c0Q2IZwzIqqVQHEdnt0sIVfUBTxLpjg6x8F6UpDT1wOtSOt7H2PHYvUwztNXsQlfHZkLQ0qAW+oDWWzPcD0/4yjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvS7iLe1; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvS7iLe1"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304f0039c02so8049958eec.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 07:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780410546; cv=none;
        d=google.com; s=arc-20240605;
        b=TZRiHuGJ8KIsiKPONLnzSB6MSgUOxXefIzPt5xKs+4llJN2amRhLSD3yGaCw2xCLl8
         LjKF4TXPMtAtalJnvUfC0Pb8AuLXQkDGpoWI8a1QLAjvZeLwE1aQYk7x2Cj6AVW4nfIh
         HEN16atQzzatx0U3X2gIVwiBYkS0yCU05NAzI9hpwMxJ0OTLGeU4V/Wsd5fKjGKTmVAv
         j2avqvREvLRxIjd3LCQ5mbq+pxZHFph1iC43F9426M3rA+OVsIHdWLWxUvhzVOKMq2jY
         XTck4Qp0fYM2c5xvD+hry0RK+tYRXJ/QWatDvfNqLXpux2cK2MsZpQ2MOt0vjV7hktDM
         XRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpwFh2a0/oyZBOiJkQQQ7Xbyt/Uy5rqSD9KPnvxrM2g=;
        fh=2D2Es0VPK0iKMFMhMDAuR92Hjz/by/LPQE0/ERY3jow=;
        b=DB0n9IEZBe0fMK86y+Pl99T2/epMW0l8ziDuhPwEIdD07ejo3Y9tvkoJjtwjQEsgAR
         YuOORgwrQ0NNSdYYGzlnNVxXaVMIqNd/iX9op4yGSn5lRYCPtlKoAU6IArG/jill6xYF
         j/KatJj8KVeAjg5HYwQpnJTXSftMynOSucQ2KsNxr8h6moQh403TpiF1hsm0dwztWUic
         Y5fnr0GJ7F5uXzKym2/Fm3/ELjNOvd8O/YbYYGWFJ/5qbKHJyFyQnIV5urhwap6KbaC9
         2+GAUaxirkSaM5k3kvB5EgxI3OeUFBry/ot0HLArjcmx1YqYgrwua02qtJOr2cf1htDV
         D6+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780410546; x=1781015346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpwFh2a0/oyZBOiJkQQQ7Xbyt/Uy5rqSD9KPnvxrM2g=;
        b=kvS7iLe1ZbSh+crMCh2b6P4PeWiWpsgx0lXJ9O43NgaWrWKS6fDA2DCuzIp87sEdW9
         CPHvFZsR0HDubiu7jNp7l2eOf4yqTd80E2s9MBLklSajPIgseA4uRDM5DIhSCk4U+Yav
         Z/6RHb4UTq+/+fFpQSngOnNm/KywstoAyqIVxFd5HWgQDPhiDtN8RjFLup7+aQpgJ7Re
         9KYHzA3N0FbXVVZjZM6bqmpGKkTacMIIKPAyUQpEVOSZvKgDdq4/YCdjx9RA2hBL+x5b
         5WRIS8cU39OXH5JdzZWu52J9GE57edeqvNEwrL/IxXyywahr/nk2D4LVNRfCTgTxlhxU
         R7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410546; x=1781015346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpwFh2a0/oyZBOiJkQQQ7Xbyt/Uy5rqSD9KPnvxrM2g=;
        b=eIdaiBteVNMNhnKTq+H5dfdJjgzSY842iUg7HOKiREGPWsAPniyDKc1sSH2NWrqkP4
         gMspOMqxb0syn0gUx900Xo6qJukgbt/cT6Zw3lM62MXVOlfH4wRZk970tQb+HNC/H9Zs
         CXZ4qd0X+O+RH7Hl9oGW+q4L8kD52ZQ8J71NGbp+9iscNv9axXWKTjWqiW5tzqNiA9TL
         Z+6qzYj/Z7njw2vxVIhH01LwLb+RCuG+zM4Lzlg34hrPbc5G32GxB4KHJUPW0tXNkfhI
         Gm1PTIgTq5L8d/tZXIKKTDsWeTQkrrR4GWzla0QQAiGVpUxJB9mm6XzdBf4hqJ/XPoaH
         Esyg==
X-Forwarded-Encrypted: i=1; AFNElJ+fuObl4mS9QG9doPjJDhk6Uq4rZo426x2WjRtpgLdscPuq4LGYiYZu0NWMwvQ319G/f21bpFMtYkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBafzSMA0hom73cOzf7j+le/uoY4tbE8UKoV4Ph24DgvyhFb+
	cLdhuD6ufg6n9wTwT6DK7hZ8itTZJK/JweI/a8doXRrQA7puSzEBYlam9eCZq2ZsG8UuJEFWXW+
	n1FfgIJdVKCSqPukIMkQ3sSCBRLTgLA4=
X-Gm-Gg: Acq92OHvI86Hf4AQE2OF87Ho14g3Asa9MgDlBBZG/wSxxru078HCoULqVQnmF06kPMQ
	pIRfynYsadTIiysUu3SF6RqdDiB8LARlEQmcabn1hMcn2GAKPVFART8AINtzEbwE8dsq6z9uPgP
	hf+NkmEBbTCh7SCHofQhlbKg3n/2axvVumIx5BtTSb+Yi5860rYaSzktxmrFfhKLXU/edrwDxxw
	sPK43hL+zspV0nZ9XQxCSlx92T4+9/FDWI/SXuZjYsHzI8oR48R2lGZk7X/RNI114QHFgxFK3Y9
	8u9G9pKHGz1q8x3tFUo=
X-Received: by 2002:a05:7301:1f0d:b0:304:e20e:f5c9 with SMTP id
 5a478bee46e88-304fa6ab9d9mr8316247eec.31.1780410546079; Tue, 02 Jun 2026
 07:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-6-clamor95@gmail.com>
 <20260602144640.433b4d35@jic23-huawei> <CAPVz0n1r97d8-uzhPGBx0LFSp75A3_2mMXDQQ30utT-6NtpHNA@mail.gmail.com>
 <20260602152019.078cc40e@jic23-huawei>
In-Reply-To: <20260602152019.078cc40e@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 17:28:54 +0300
X-Gm-Features: AVHnY4IAAmHJnZ7jdhhpGUMZSGLBbZqFDtuCT4UKpkopc5zewTxJykItA13TvMY
Message-ID: <CAPVz0n0D+97TqZD+003z40vGK_gtnNv5v8iGyc8NYekLdHg58A@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 17:20=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 2 Jun 2026 16:50:16 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 1=
6:46 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Mon,  1 Jun 2026 18:18:25 +0300
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > > Since there are no users of this driver via platform data, remove t=
he
> > > > platform data support and switch to using Device Tree bindings.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > >
> > >
> > > > index 52136ca1abc9..55b35467a722 100644
> > > > --- a/drivers/iio/light/lm3533-als.c
> > > > +++ b/drivers/iio/light/lm3533-als.c
> > > > @@ -16,16 +16,19 @@
> > > >  #include <linux/module.h>
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/mfd/core.h>
> > > > +#include <linux/mod_devicetable.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/property.h>
> > > >  #include <linux/regmap.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/uaccess.h>
> > > > +#include <linux/units.h>
> > > >
> > > >  #include <linux/mfd/lm3533.h>
> > > >
> > > >
> > > > -#define LM3533_ALS_RESISTOR_MIN                      1
> > > > -#define LM3533_ALS_RESISTOR_MAX                      127
> > > > +#define LM3533_ALS_RESISTOR_MIN                      1575
> > > > +#define LM3533_ALS_RESISTOR_MAX                      200000
> > > >  #define LM3533_ALS_CHANNEL_CURRENT_MAX               2
> > > >  #define LM3533_ALS_THRESH_MAX                        3
> > > >  #define LM3533_ALS_ZONE_MAX                  4
> > > > @@ -57,6 +60,9 @@ struct lm3533_als {
> > > >
> > > >       atomic_t zone;
> > > >       struct mutex thresh_mutex;
> > > > +
> > > > +     bool pwm_mode;
> > > > +     u32 r_select;
> > > >  };
> > > >
> > > >
> > > > @@ -411,7 +417,7 @@ static ssize_t show_thresh_either_en(struct dev=
ice *dev,
> > > >       int enable;
> > > >       int ret;
> > > >
> > > > -     if (als->irq) {
> > > > +     if (als->irq > 0) {
> > > >               ret =3D lm3533_als_get_int_mode(indio_dev, &enable);
> > > >               if (ret)
> > > >                       return ret;
> > > > @@ -716,30 +722,34 @@ static const struct attribute_group lm3533_al=
s_attribute_group =3D {
> > > >       .attrs =3D lm3533_als_attributes
> > > >  };
> > > >
> > > > -static int lm3533_als_setup(struct lm3533_als *als,
> > > > -                         const struct lm3533_als_platform_data *pd=
ata)
> > > > +static int lm3533_als_setup(struct lm3533_als *als)
> > > >  {
> > > >       struct device *dev =3D &als->pdev->dev;
> > > >       int ret;
> > > >
> > > > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-mode=
");
> > > > +
> > > >       ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_AL=
S_CONF,
> > > >                                LM3533_ALS_INPUT_MODE_MASK,
> > > > -                              pdata->pwm_mode ? LM3533_ALS_INPUT_M=
ODE_MASK : 0);
> > > > +                              als->pwm_mode ? LM3533_ALS_INPUT_MOD=
E_MASK : 0);
> > > >       if (ret)
> > > >               return dev_err_probe(dev, ret, "failed to set input m=
ode %d\n",
> > > > -                                  pdata->pwm_mode);
> > > > -
> > > > +                                  als->pwm_mode);
> > > >
> > > >       /* ALS input is always high impedance in PWM-mode. */
> > > > -     if (!pdata->pwm_mode) {
> > > > -             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > > > -                 pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
> > > > -                     dev_err(&als->pdev->dev, "invalid resistor va=
lue\n");
> > > > -                     return -EINVAL;
> > > > -             }
> > > > +     if (!als->pwm_mode) {
> > > > +             ret =3D device_property_read_u32(dev, "ti,resistor-va=
lue-ohms",
> > > > +                                            &als->r_select);
> > > > +             if (ret)
> > > > +                     return dev_err_probe(dev, ret,
> > > > +                                          "failed to ger resistor =
value\n");
> > > > +
> > > > +             als->r_select =3D clamp(als->r_select, LM3533_ALS_RES=
ISTOR_MIN,
> > > > +                                   LM3533_ALS_RESISTOR_MAX);
> > >
> > > If we are getting garbage from DT I think I'd rather error out that p=
aper over
> > > that problem.  So similar to before, check valid value and if not fai=
l probe
> > > so that hopefully someone goes and fixes it!
> > >
> >
> > sure
> >
> > > > +             als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r=
_select);
> > > Why do we need this when we didn't before?  The range checks are the =
same
> > > so it smells like it shouldn't need transforming. I'd also rather we =
didn't do
> > > rewriting of the meaning of r_select like this.  Just use a local var=
iable for
> > > the intermediate result.
> > >
> >
> > before pdata passed resistor value as actual register value, not we
> > are getting the actual resistance in ohms from the tree and must
> > convert it into register value.
>
> ah. I missed the change of values.  Can you make them explicitly now _OHM=
S or something
> along those lines rather than reusing the macro name for a different thin=
g.
>

Acknowledged.

> >
> > > >
> > > >               ret =3D regmap_write(als->lm3533->regmap, LM3533_REG_=
ALS_RESISTOR_SELECT,
> > > > -                                pdata->r_select);
> > > > +                                als->r_select);
> > > >               if (ret)
> > > >                       return dev_err_probe(dev, ret, "failed to set=
 resistor\n");
>
