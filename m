Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8433C182
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786497763; cv=pass; b=GhQ6YmDWYBrJAq2HE4Rf8EVs8M9ykRUKUbY/ckbi6G97OdR9rfbyBt41kkJ5JyUNeUNjHAqhsy4mDk72kHjlZH/YYYq1MMxFSY/N6qPSx9a8saj3bZD2P8S8zJ77GKRMisM/nlk7AQv/L9uLjwudL2Li6IQ+dHQ1+5+AahAeQOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786497763; c=relaxed/simple;
	bh=rLbcwarjit+Ka/LngucPc2Jh24xmljp0mdnAAR/LqeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2C9OLS5uvK3gdl0GdkHKfmJM62Whx6qB58dFVL7J1UzIBhRRZYB9Z2YznrZfCfARHGEeVg3p0/qi73v4/5CyacjYtkF4dopSUCpRmhSNDdjjFOA5nK5+tmNgf8HwLkVCcjsKXgAvcEnCu5R62/fMeV/coR5q+2J3d0Ux8WuzNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyEfQlJT; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyEfQlJT"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-969524c1a63so311184241.0
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2026 18:22:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786497759; cv=none;
        d=google.com; s=arc-20260327;
        b=i0Eewn8T317fEQD584I/y7KHkJmBLUdHnWR2blSTKrevLGqGOr292PRikZgI2va/Pk
         0/yRCY44ZVAG30RIX3yGi02IPmtkwlxJ6JG0tnL+CjrF8Bg6OuP2qpjnkGdmXvJT2Sep
         epGH6M+7rXkGpjw3u80LfbMDz793yRHulKERSMsGe1Jmp1FLL8kxgKixQiLnwMyo5tK4
         4Ww4mBxm4AsBzVTYgpstwdB69wvf/53F+3txTGs4/mJRLvhE6a8jLNZpO6tkXmijz6VW
         NhAtzO3F/ly9A7PMM/RzUrY2s4mpUh05MA8p677Gpfn+2TXuKqYODymREUF2o/6Nj/gs
         0JrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wOVBacM5UqeudlDw+F1mps9aET1eP9sF7gMTDuLRQW8=;
        fh=H2HpKaQhUfWvQ3qUxjzZY5K4YjxYnltLv4ZR5vWcEXs=;
        b=RZh7Bl3u7wOYYgjeVWr2vokfaWVIzli5pnIvzvdtdSjBAg68RmTlpiYiTZvipSk/QM
         yzVK501dAoiwUMj6H/mUtj9D+k9YbAZR9tlKsjpQ1OhKB4tniwKq9Z19B413IrgeGw/d
         w1HUMhJJDJjcAbW0hYUcXLiXcJEVqUVgBJsGaxq2Ig+Y9dYq8bHHzVoxuxBinNYEkhOG
         vTDZvXhq+IXtRpxXiUPfamHgbHiwKFNoYl4i++cWXzEKIRo8cAhWpAQm2C6dBiwMR9L/
         b3uMOrhxTlC2XBcgBYiMRyJnes5Dbd40bV+U+EeX2e8A01TruSzTN7Tix8epwCuDcWOk
         WdRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786497759; x=1787102559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wOVBacM5UqeudlDw+F1mps9aET1eP9sF7gMTDuLRQW8=;
        b=EyEfQlJTTbLqr6PNLwqko2QoIkV/lD31wXqEXAWBNGL8txWH0yJDD1zkDnJ8vg7PVa
         siKUv82M1ExxqLCA7tP/hvTzIXLS8YEJfVGKrkfYkkzOzBzjYLvJZGF4n+oqD+aquDjO
         0NfNdd31JGX8+WwG6DtLpXljsJI16izNqwEiBSJ5NoQT6ctEA7DNCAmwPUwuQ4B0CV5Y
         s/763N6vqK1XHrb7R7bFSy74AeKFVf/Rlq11w6MIapWKZnzfWTpru0HYdoZb9rifoPg4
         Z4fqXXA+Gq6msCObKmKvg/VmxEixKtzfN7jX0AQuNtnO5hUQtM0/JQ0vgQx6AxRhX0v9
         O86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786497759; x=1787102559;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wOVBacM5UqeudlDw+F1mps9aET1eP9sF7gMTDuLRQW8=;
        b=ZNkyoXBHyRf9LokpQYmoAo5XUeU15tDxOJ55dUihpNnUvFb2nf6O84wiAtulfb1Bvr
         +qZTX7nNZhAocgoNR0IuRSIuGXEPh9UR4N1eoK4WtAYeQ3CzjKHhsBmQUts3RzIvfaaU
         s7X/8Q7C9dRVTfZ1KtEZp+MkU9zcr170M63SaR35f5X1Akmsb+vpE+V4q4zEXBrkZgIo
         g8V+OFmHoak2+Gpp2TxEw5ON/I/HR2nQ3zkPezUQtM6c+KG6XEHqcONbZbjhoaFXHLF3
         DUKqekywYimo4mlaR55wf3TLDX80Ma9IO9bbEAcQOQq+0qy7HxXUfQEsFBNzC82Mr5jr
         wa+A==
X-Forwarded-Encrypted: i=1; AHgh+Rpn1z75uMZFroGa9+6UsXui/RmzKN7hQbCvYdyezXDkP9faqRTdLbUVuvu3eH84uyWrUUHlYe4QTQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6bMCsZje8SBe5yGD/bYIEvM2E2hmWSFGIRFFJiJ0owaI9imA2
	maaXIX+wfIAFiia++YUWUDscxGh3xAh20g9ZeL8YPyNtARgpOuRiwmuR0v7QTlJUR+OinObXwPS
	3S8qgTa5iiXvBAqJg0drAOQwwS/3t4fc=
X-Gm-Gg: AR+sD120PyrJ2N81IGuSVKzUtJVL+4axIWBUtK4JT6QqaMES2Kse+ItBQMgpy/0VnTn
	CUDhZCHu/aQY22xoZa/On4tRP50i7ieJ52mMnJI33yZn+UKKdzKunfoCmJQ6TeyRxe0JoPO787v
	zr4GH8y5mIExDcxKOzfaT3grzqrEHmgH0PGBgwn3mqcnfW2yjOlG1xsp8Kcx0lcEmZs7vMoDxUV
	ETli5mkTw5zq/iouFAFKd5hu78kX21knwi/YgGRTf+6NQj7LwpPtBy0BEkZTn2HVY96kQtlHq1k
	mFNV3+qxCiZZfERh7uvr328UXXVMkuQIiQfHi8XNO3y8Qw==
X-Received: by 2002:a05:6102:4189:b0:650:94b2:b209 with SMTP id
 ada2fe7eead31-76c88463a06mr334823137.4.1786497759207; Tue, 11 Aug 2026
 18:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
 <20260811-ti-ads112c04-driver-v4-2-ae704ac17241@gmail.com> <cd020926-9daf-4493-b0c1-6399a77fcf9c@baylibre.com>
In-Reply-To: <cd020926-9daf-4493-b0c1-6399a77fcf9c@baylibre.com>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 12 Aug 2026 09:25:27 +0800
X-Gm-Features: AUfX_mwR4vaVPdynwFJhYE3dIKsj4awx1nXnyRw5JO9tOO3_Ai4decKV4IykxqI
Message-ID: <CAF7HswO653pdEukE==ZRbXyuDvNdrbZ7iPDKndHXiE77Bg3tCQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ti-ads112c04: Add support for TI ADS112C04
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:18=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 8/10/26 9:48 PM, Kyle Hsieh wrote:
> > Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> > delta-sigma ADCs.
> >
> > The driver implements:
> > - Single-shot conversions using the IIO raw read interface.
> > - Dynamic parsing of single-ended and differential channels from
> >   device tree child nodes.
> > - Hardware interrupt support via the DRDY pin, falling back to
> >   software polling if no IRQ is provided.
> > - Scale calculation based on the internal 2.048V reference.
> > - Reference voltage scaling via the regulator subsystem (refp-supply),
> >   falling back to the internal 2.048V reference if not specified.
> >   refn-supply is not yet supported.
> > - Hardware reset fallback using GPIO.
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > ---
> >  MAINTAINERS                    |   1 +
> >  drivers/iio/adc/Kconfig        |  10 +
> >  drivers/iio/adc/Makefile       |   1 +
> >  drivers/iio/adc/ti-ads112c04.c | 425 +++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 437 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 417d74b6d6cc..f51fbda9d4b9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26992,6 +26992,7 @@ M:    Kyle Hsieh <kylehsieh1995@gmail.com>
> >  L:   linux-iio@vger.kernel.org
> >  S:   Maintained
> >  F:   Documentation/devicetree/bindings/iio/adc/ti,ads112c04.yaml
> > +F:   drivers/iio/adc/ti-ads112c04.c
> >
> >  TI ADS112C14 ADC DRIVER
> >  M:   David Lechner <dlechner@baylibre.com>
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 990e7b3e7212..0ee50828f9e4 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -1817,6 +1817,16 @@ config TI_ADS1119
> >           This driver can also be built as a module. If so, the module =
will be
> >           called ti-ads1119.
> >
> > +config TI_ADS112C04
> > +    tristate "Texas Instruments ADS112C04 ADC"
> > +    depends on I2C
> > +    help
> > +      If you say yes here you get support for Texas Instruments
> > +      ADS112C04 (16-bit) I2C analog to digital converters.
> > +
> > +      This driver can also be built as a module. If so, the module wil=
l be
> > +      called ti-ads112c04.
> > +
> >  config TI_ADS112C14
> >       tristate "Texas Instruments ADS112C14/ADS122C14"
> >       depends on I2C
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index dcec0abb03b7..d8acf2831fd2 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -155,6 +155,7 @@ obj-$(CONFIG_TI_ADS1015) +=3D ti-ads1015.o
> >  obj-$(CONFIG_TI_ADS1018) +=3D ti-ads1018.o
> >  obj-$(CONFIG_TI_ADS1100) +=3D ti-ads1100.o
> >  obj-$(CONFIG_TI_ADS1119) +=3D ti-ads1119.o
> > +obj-$(CONFIG_TI_ADS112C04) +=3D ti-ads112c04.o
> >  obj-$(CONFIG_TI_ADS112C14) +=3D ti-ads112c14.o
> >  obj-$(CONFIG_TI_ADS124S08) +=3D ti-ads124s08.o
> >  obj-$(CONFIG_TI_ADS1298) +=3D ti-ads1298.o
> > diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads112=
c04.c
> > new file mode 100644
> > index 000000000000..3a775da2ae23
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-ads112c04.c
> > @@ -0,0 +1,425 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Texas Instruments ADS112C04 16-bit I2C ADC driver
> > + *
> > + * Copyright (c) 2026 Kyle Hsieh <kylehsieh1995@gmail.com>
> > + *
> > + * Datasheet: https://www.ti.com/lit/ds/symlink/ads112c04.pdf
> > + * Based on TI Reference Code and standard Linux IIO framework.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/property.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <linux/units.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +
> > +#define ADS112C04_CMD_RESET         0x06
> > +#define ADS112C04_CMD_START_SYNC    0x08
> > +#define ADS112C04_CMD_POWERDOWN     0x02
> > +#define ADS112C04_CMD_RDATA         0x10
> > +#define ADS112C04_CMD_RREG(reg)     (0x20 | ((reg) << 2))
> > +#define ADS112C04_CMD_WREG(reg)     (0x40 | ((reg) << 2))
> > +
> > +#define ADS112C04_REG_CONFIG0       0x00
> > +#define ADS112C04_REG_CONFIG1       0x01
> > +#define ADS112C04_REG_CONFIG2       0x02
> > +#define ADS112C04_REG_CONFIG3       0x03
> > +
> > +#define ADS112C04_CONFIG0_MUX         GENMASK(7, 4)
> > +#define ADS112C04_CONFIG0_PGA_BYPASS  BIT(0)
> > +#define ADS112C04_CONFIG2_DRDY        BIT(7)
> > +
>
> I think I mentioned before the preferred way to orgainze the fields
> under the corresponding register. And as below, there are more
> fields we are using that need macros here.
>
> > +struct ads112c04_state {
> > +     struct i2c_client *client;
> > +     /* Protects concurrent ADC reads and device configuration */
> > +     struct mutex lock;
> > +     struct completion completion;
> > +     int vref_mV;
> > +     u8 config0;
> > +     u8 config1;
> > +     bool has_refp;
>
> This isn't used outside of probe. Can just be passed as a function argume=
nt.
>
> > +};
> > +
>
> ...
>
> > +static irqreturn_t ads112c04_irq_handler(int irq, void *private)
> > +{
> > +     struct iio_dev *indio_dev =3D private;
> > +     struct ads112c04_state *st =3D iio_priv(indio_dev);
> > +
> > +     disable_irq_nosync(irq);
>
> As mentioned in this recent discussion [1], we should not be disabling th=
e IRQ.
> If there is a true need for it, we need lots of comments explaining why. =
Since
> we aren't doing buffered reads though, I can't see a reason why we would =
need
> it right now. Unless we are worried about spurious interrupts, in which c=
ase
> we should read the DRDY status bit before setting the completion here as =
that
> would be more robust.
>
> [1]: https://lore.kernel.org/linux-iio/20260802184126.04738251@jic23-huaw=
ei/
>
> Also, this ia a bug because we can't call syncronous code in an IRQ handl=
er.
> We would need to change it to a threaded IRQ handler.
>
> > +     complete(&st->completion);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static const struct iio_info ads112c04_info =3D {
> > +     .read_raw =3D ads112c04_read_raw,
> > +};
> > +
> > +static int ads112c04_parse_channels(struct iio_dev *indio_dev)
> > +{
> > +     struct device *dev =3D indio_dev->dev.parent;
> > +     struct ads112c04_state *st =3D iio_priv(indio_dev);
> > +     struct iio_chan_spec *channels;
> > +     u32 num_channels, pair[2];
> > +     int ret, i =3D 0;
> > +
> > +     num_channels =3D device_get_named_child_node_count(dev, "channel"=
);
> > +     if (!num_channels)
> > +             return dev_err_probe(dev, -EINVAL, "no channel subnodes f=
ound\n");
> > +
> > +     if (num_channels > 12)
> > +             return dev_err_probe(dev, -EINVAL,
> > +                                  "num of channel nodes exceeds 12\n")=
;
> > +
> > +     channels =3D devm_kcalloc(dev, num_channels, sizeof(*channels), G=
FP_KERNEL);
> > +     if (!channels)
> > +             return -ENOMEM;
> > +
> > +     device_for_each_named_child_node_scoped(dev, child, "channel") {
> > +             struct iio_chan_spec *spec =3D &channels[i];
> > +
> > +             if (fwnode_property_present(child, "excitation-channels")=
)
> > +                     return dev_err_probe(dev, -EOPNOTSUPP,
> > +                                          "excitation-channels is not =
supported yet\n");
> > +
> > +             if (fwnode_property_present(child, "reference-sources")) =
{
> > +                     const char *ref;
> > +
> > +                     ret =3D fwnode_property_read_string(child, "refer=
ence-sources", &ref);
> > +                     if (ret)
> > +                             return dev_err_probe(dev, ret,
> > +                                                  "failed to read refe=
rence-sources\n");
> > +
> > +                     if ((!strcmp(ref, "external") && !st->has_refp) |=
|
> > +                         (!strcmp(ref, "internal") && st->has_refp))
> > +                             return dev_err_probe(dev, -EINVAL,
> > +                                                  "reference-sources d=
oes not match refp-supply\n");
>
> As explained more below, this part needs comments to explain why it is
> the way it is since it is not implementing fully what is allowed by the
> devicetree bindings. And would return EOPNOTSUPP to be consistent that
> this is just something that is not implemented yet.
>
> > +             }
> > +
> > +             spec->type =3D IIO_VOLTAGE;
>
> I would add a REVISIT comment here to explain that when ti,refp-refn-resi=
stor-ohms is implemented,
> then we have the possibility of the channel being resistance instead of v=
otlage.
>
> > +             spec->indexed =3D 1;
> > +             spec->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT=
(IIO_CHAN_INFO_SCALE);
> > +
> > +             if (fwnode_property_present(child, "single-channel")) {
> > +                     ret =3D fwnode_property_read_u32(child, "single-c=
hannel", &pair[0]);
> > +                     if (ret)
> > +                             return dev_err_probe(dev, ret,
> > +                                                  "failed to read sing=
le-channel property\n");
> > +
> > +                     if (pair[0] > 3)
> > +                             return dev_err_probe(dev, -EINVAL,
> > +                                                  "single-channel must=
 be 0-3\n");
> > +
> > +                     spec->channel =3D pair[0];
> > +                     spec->address =3D 0x08 + pair[0];
> > +             } else if (fwnode_property_present(child, "diff-channels"=
)) {
> > +                     ret =3D fwnode_property_read_u32_array(child, "di=
ff-channels", pair, 2);
> > +                     if (ret)
> > +                             return dev_err_probe(dev, ret,
> > +                                                  "failed to read diff=
-channels property\n");
> > +
> > +                     if (pair[0] > 3 || pair[1] > 3)
> > +                             return dev_err_probe(dev, -EINVAL,
> > +                                                  "diff-channels must =
be 0-3\n");
> > +
> > +                     spec->channel =3D pair[0];
> > +                     spec->channel2 =3D pair[1];
> > +                     spec->differential =3D 1;
> > +
> > +                     if (pair[0] =3D=3D 0 && pair[1] =3D=3D 1)
> > +                             spec->address =3D 0x00;
> > +                     else if (pair[0] =3D=3D 0 && pair[1] =3D=3D 2)
> > +                             spec->address =3D 0x01;
> > +                     else if (pair[0] =3D=3D 0 && pair[1] =3D=3D 3)
> > +                             spec->address =3D 0x02;
> > +                     else if (pair[0] =3D=3D 1 && pair[1] =3D=3D 0)
> > +                             spec->address =3D 0x03;
> > +                     else if (pair[0] =3D=3D 1 && pair[1] =3D=3D 2)
> > +                             spec->address =3D 0x04;
> > +                     else if (pair[0] =3D=3D 1 && pair[1] =3D=3D 3)
> > +                             spec->address =3D 0x05;
> > +                     else if (pair[0] =3D=3D 2 && pair[1] =3D=3D 3)
> > +                             spec->address =3D 0x06;
> > +                     else if (pair[0] =3D=3D 3 && pair[1] =3D=3D 2)
> > +                             spec->address =3D 0x07;
> > +                     else
> > +                             return dev_err_probe(dev, -EINVAL,
> > +                                                  "invalid diff-channe=
ls combination\n");
> > +             } else {
> > +                     return dev_err_probe(dev, -EINVAL,
> > +                                          "channel node must have sing=
le-channel or diff-channels\n");
> > +             }
> > +
> > +             i++;
> > +     }
> > +
> > +     indio_dev->channels =3D channels;
> > +     indio_dev->num_channels =3D i;
> > +
> > +     return 0;
> > +}
> > +
> > +#define ADS112C04_VREF_INTERNAL_MV   2048
>
> Usually we put this at the top with other macro definitions.
>
> > +
> > +static int ads112c04_probe(struct i2c_client *client)
> > +{
> > +     struct device *dev =3D &client->dev;
> > +     struct iio_dev *indio_dev;
> > +     struct ads112c04_state *st;
> > +     struct gpio_desc *reset_gpio;
> > +     int ret;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     st =3D iio_priv(indio_dev);
> > +     st->client =3D client;
> > +
> > +     ret =3D devm_mutex_init(dev, &st->lock);
> > +     if (ret)
> > +             return ret;
> > +
> > +     init_completion(&st->completion);
> > +
> > +     indio_dev->name =3D "ads112c04";
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->info =3D &ads112c04_info;
> > +
> > +     /* Forward compatibility checks for unimplemented DT properties *=
/
> > +     if (device_property_present(dev, "refn-supply") ||
> > +         device_property_present(dev, "ti,refp-refn-resistor-ohms"))
> > +             return dev_err_probe(dev, -EOPNOTSUPP,
> > +                                  "refn-supply and external resistors =
are not supported yet\n");
> > +
> > +     st->has_refp =3D device_property_present(dev, "refp-supply");
> > +
> > +     ret =3D ads112c04_parse_channels(indio_dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D devm_regulator_get_enable(dev, "avdd");
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to get avdd regula=
tor\n");
> > +
> > +     ret =3D devm_regulator_get_enable(dev, "dvdd");
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "failed to get dvdd regula=
tor\n");
> > +
> > +     if (device_property_present(dev, "refp-supply")) {
>
> This can just be st->has_refp now.
>
> > +             ret =3D devm_regulator_get_enable_read_voltage(dev, "refp=
");
> > +             if (ret < 0)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "failed to get refp voltage\=
n");
> > +
> > +             st->vref_mV =3D ret / (MICRO / MILLI);
> > +             st->config1 =3D 0x02;
>
> I've asked before... these values should have macros to explain what
> they are and be using FIELD_PREP().
>
> > +     } else {
> > +             st->vref_mV =3D ADS112C04_VREF_INTERNAL_MV;
> > +             st->config1 =3D 0x00;
> > +     }
>
> I still don't think storing vref like this is a good idea since it should
> be per-channel. If you really are against implementing it in a more
> future-proof way, then it needs lots of comments explaining why it is
> implemented this way instead and how one would go about doing it the "rig=
ht
> way" in the future.
>
> > +
> > +     /* Power-On Reset (POR) delay */
> > +     fsleep(50 * USEC_PER_MSEC);
> > +
> > +     /* Requesting OUT_HIGH asserts the active-low reset pin immediate=
ly */
> > +     reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HI=
GH);
> > +     if (IS_ERR(reset_gpio))
> > +             return PTR_ERR(reset_gpio);
> > +
> > +     if (reset_gpio) {
> > +             fsleep(1000);
> > +             gpiod_set_value_cansleep(reset_gpio, 0);
> > +     } else {
> > +             ret =3D ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> > +     fsleep(1000);
> > +
> > +     /* Bypass PGA for now to allow full-scale single-ended measuremen=
ts */
> > +     st->config0 =3D ADS112C04_CONFIG0_PGA_BYPASS;
> > +     ret =3D ads112c04_write_reg(client, ADS112C04_REG_CONFIG0, st->co=
nfig0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->co=
nfig1);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (client->irq > 0) {
> > +             ret =3D devm_request_irq(dev, client->irq,
> > +                                    ads112c04_irq_handler,
> > +                                    0,
>
> I think I've asked twice now to move this 0 on the previous line.
> If you don't agree with that, it is fine, but we just ask that you
> reply to the suggestion with an explanation to state your reasoning.
> Otherwise, it comes across as carelessness that you continue to
> ignore suggestions. This is not the only suggestoin that has been
> silently ignored. You might want to go back to the previous revisions
> and see if you missed anything else.
Hi David,

Thank you for the review, and I'm sorry for the repeated oversights.

You're right, and I have no good excuse. I went back through the v1-v4
threads as you suggested and found several suggestions I silently
dropped:

- Moving the `0` in devm_request_irq() to the previous line
- Organizing register field macros indented under their register
- I even replied at the time saying I would do this, and then
  did not. Apologies.
- Using a macro and FIELD_PREP() for the CONFIG1 VREF value
- Making the reference voltage per-channel
- Using devm_reset_control_get_optional_exclusive() for the hardware
  reset (v1, and Andy raised the same point on v4)
- Your v1 suggestion to consider regmap with a register cache

All of these will be addressed in v5. For the per-channel reference
voltage, I will implement it properly following the ADS112C14 driver
rather than keeping the single stored value.

I'll also fix the IRQ handling - you're right that disabling the IRQ
was wrong, and that the handler needs to be threaded since it can't
call synchronous code. I'll drop disable_irq_nosync() and read the
DRDY status bit before completing instead.

Thanks for your patience with this series.

Best regards,
Kyle Hsieh
>
> > +                                    indio_dev->name, indio_dev);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
