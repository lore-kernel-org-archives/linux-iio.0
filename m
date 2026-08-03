Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A438F629
	for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2026 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741866; cv=pass; b=OqIIMcGUOEz2evnmugbgDPtkYPxnUmQI4UikAoDuNgSif2njdidiVvzbaNhM/zFJabDiqQ8YHlsM2/budG5ZjdjDRxm2hmeh7794+Y+j4Bdj845Y9by9pkkkiesQfEePaisZ4VL8prTjlD17TQlmAf//w+jZnS1yxTYIFPj7Orw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741866; c=relaxed/simple;
	bh=jPHH7xOmjtWd8a6C1EH6AEin8q8SzZ/3jFHrJCUt/9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyJ66n4nYm4B93OT2UCRQ5Scfs5Ura2tnRAb4OAC6J4ncpINT3SBUe618KbIrXuDAbJGmaT2ZPXYDi/cEjBRPq8SFNEWf9WS5Z8Jn3lvXlS2Cz2Rr+5cXViBYsnKp8FETnCvXjmk9IstI8W/tt6jY4On2+NxrxxJEy/rKCu+tOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQk8l3x7; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQk8l3x7"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so2892004e87.1
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2026 00:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785741860; cv=none;
        d=google.com; s=arc-20260327;
        b=noBzlwwiQmhDiEl3jlJwOWX5e/G6KNmTLIjdePQzNBPqCexEAPVk1tgKQrIAK0C0s2
         z13wqamZkNw499k+7kWWGBebGeiiPMRjKqh0If2gnCVSrpQSzHD3OVIFXXfRtCX7wA+2
         aTjnzVRXj345CtfEos7gER9pw0S2VpjAZl3Ujk4cFQdzhu7LHmysa4Nh7+sqn10lU6C7
         8h8/Iw43KcWCdSNSLCWyQ29fpnRx8sMYwqghqhZqUKKMspwDxoZbQJcFvjrZ0IuT52wB
         zj7vVx3hZwBlrqPCClV2jtgvEvtrENjFrLI1dsj78q7KzJxPV1IjtLAdonvE38MqEK14
         iw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hIW1kMhYaK55GKnWmaSHqAIkFtwql8tfsg3KtR1r2H0=;
        fh=t9cnMlvpfgdK4p2jNcrFLeyEf89pL4NubwpU2BVvEpc=;
        b=kK40vL3eO2BAPzRHC6Vov9T4MQ9iTvxR8BJNa73VZD55QbDvKNoHwIo6MG0EbFZApz
         4jbr0LjYrSM9Oo+jH1vkshjndi4kFszG3I4dfScr0ppFXDn/Wv60/IKyRNFbwlc+CmM8
         92x41S4Lujn4dG+j26q8hadwSNe/zoQVAtRksrsB6ffpISNMXdzHIVhIncCb7U6FJ8oE
         lFFCUa5jK+WZcvljdh613GoOXQyy132ejnz+3zdykg7DEPx/HRMyozBq+tmscph0ONvK
         3vK0WmOENxd6tKrMOZfAAwIJyL2jlBlrsav/VCFvPADWmxF/+LjfWwYA9yZv0oIcqQAQ
         mEUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785741860; x=1786346660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hIW1kMhYaK55GKnWmaSHqAIkFtwql8tfsg3KtR1r2H0=;
        b=RQk8l3x7sA5CZxGfFVHboyo0lFa0RJoYIR+y+hSQM0K6Fe1El3pRjxxteZ2ZfduMQJ
         /Cfm4s7LPVPGkZ+yLLyb51WRLwimpwzoNAIm3W3EepAIzBGlpdI57eXgfTA+GIXWk8ZB
         KtXGGa9AsavOYyfbWKhm0SJgHtei/IHfAAxY8CMoE9kcGCKVbffSINnIuLaNaY/e6Ytl
         GrPoXFGXNI2rPX0m3LWNu2MoYqGvTDT86x3n/EDSnzrrJFCufh71PRObtNWY5rYP6jzO
         KPjX9ZQvYHCZMvWvgzhrdw+6+S1CdO6J+4CR6cxHxmoSp75P7iTl3tuTKmMuePjA4OJT
         obWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785741860; x=1786346660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hIW1kMhYaK55GKnWmaSHqAIkFtwql8tfsg3KtR1r2H0=;
        b=OPm8kxzldL3BjKiVtMJMw9Hx1O50yzG5OLgdscok7mjtGWCCvLeIynUWhlFO//LGz+
         o7m3eFQzQgw9k0qBOxZ7F7y1KtCsDgN/qYUGbt+JgJinDa9/qoWSmGQM442bLwF8cpjQ
         9ZzgXFyhawEU77enI5leUH/FFyl/ffjp/IpbG+UdfdKZZQgRf3z42HmOIGHRRiMxpqAy
         2SsKC3VgLB6YVYfqGBg0Syf4QHSj5/D15/IO1Z8+8+AnVsbHPtk0IvQ1sVKSmLIUcycU
         +mBF9MucRhqQGQP9MaFsiMsZs4rSLFbso5VyVXIF2oEvl+lpsTVYBE+1WKKUCn52LGwz
         yMsA==
X-Forwarded-Encrypted: i=1; AHgh+RpAizHxkTOxBEmyH81M2+VabAm554CjaOSIyPUiiyQat/Vr8p7C2LHpkaexA23cUkBVBmyOJ1jLDbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFcvcb7JGZmV4+G7+jhWJhshy+s+9FpUJjSLUk9G4+LNJ/7q5
	Z1/xMdJyXDWO3mPwFK7MTHEGL5R6Kp+MzM8QDmfzFCzqt0ptH5Ux5xTYgCcuBO+3crVtEbNb5st
	GJUEC2ktuVgEzvux3c+4VYArTQ/F7pGQ=
X-Gm-Gg: AR+sD12chgbPdoxLdo+5DQuV9ddniCmMqQPCkl0tVt2q+bM/yRvXctjNHqEWJ429OAO
	H/l7QXwCsMqrT53c9wopak9JiZfxHAv2hWZ7PpEfKAwPSXwjJB8fwDwF7+8kLuemoPxmbdz6/Lj
	HZKWgy02b+1Iafjss82fSrhr7IIQQOkfRBj7wPMhuubqXXPXD3eOwxfIqywoY40pR8pXWB5+xJD
	GVKtHsB50VucXLmOrQEq/jW7wKghyvX7WBWYea2cofmt8fw+hy1Wa86xcX7fm5GFILGYFwXqLZI
	kwN/2SlOhdnxXHAaCznLZACWMCYAH8SIjS8/WgMDRZt6BOc=
X-Received: by 2002:ac2:4a6a:0:b0:5b0:f9d:f7d9 with SMTP id
 2adb3069b0e04-5b2e4f83e1dmr1130159e87.45.1785741860146; Mon, 03 Aug 2026
 00:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-ti-ads112c04-driver-v2-0-aab0168c3c01@gmail.com>
 <20260731-ti-ads112c04-driver-v2-2-aab0168c3c01@gmail.com> <0f092382-416e-43ac-b58f-b915165e29ba@baylibre.com>
In-Reply-To: <0f092382-416e-43ac-b58f-b915165e29ba@baylibre.com>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 3 Aug 2026 15:26:09 +0800
X-Gm-Features: AUfX_mwA7Obd2Or6NcydrXofMezRZXH_J6U_utSBv8XRvsw8uSOD5wUu_gXFBIE
Message-ID: <CAF7HswPb1=a1b-oBMV1hpxf8TNKJqUeBd4=PGtOrywiZ2VMeng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c04: Add support for TI ADS112C04
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:54=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 7/30/26 9:58 PM, Kyle Hsieh wrote:
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
> > - Dynamic reference voltage scaling via the regulator subsystem
> >   (refp-supply/refn-supply), falling back to the internal 2.048V
> >   reference if not specified.
> > - Hardware reset fallback using GPIO.
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > ---
> >  drivers/iio/adc/Kconfig        |  10 ++
> >  drivers/iio/adc/Makefile       |   1 +
> >  drivers/iio/adc/ti-ads112c04.c | 378 +++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 389 insertions(+)
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 3755a81c1efd..402e841bc083 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -1789,6 +1789,16 @@ config TI_ADS1119
> >           This driver can also be built as a module. If so, the module =
will be
> >           called ti-ads1119.
> >
> > +config TI_ADS112C04
> > +     tristate "Texas Instruments ADS112C04 ADC"
> > +     depends on I2C
> > +     help
> > +       If you say yes here you get support for Texas Instruments
> > +       ADS112C04 (16-bit) I2C analog to digital converters.
> > +
> > +       This driver can also be built as a module. If so, the module wi=
ll be
> > +       called ti-ads112c04.
> > +
> >  config TI_ADS124S08
> >       tristate "Texas Instruments ADS124S08"
> >       depends on SPI
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 707dd708912f..ebf9d4047a5a 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -153,6 +153,7 @@ obj-$(CONFIG_TI_ADS1015) +=3D ti-ads1015.o
> >  obj-$(CONFIG_TI_ADS1018) +=3D ti-ads1018.o
> >  obj-$(CONFIG_TI_ADS1100) +=3D ti-ads1100.o
> >  obj-$(CONFIG_TI_ADS1119) +=3D ti-ads1119.o
> > +obj-$(CONFIG_TI_ADS112C04)   +=3D ti-ads112c04.o
> >  obj-$(CONFIG_TI_ADS124S08) +=3D ti-ads124s08.o
> >  obj-$(CONFIG_TI_ADS1298) +=3D ti-ads1298.o
> >  obj-$(CONFIG_TI_ADS131E08) +=3D ti-ads131e08.o
> > diff --git a/drivers/iio/adc/ti-ads112c04.c b/drivers/iio/adc/ti-ads112=
c04.c
> > new file mode 100644
> > index 000000000000..28d3be81934f
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-ads112c04.c
> > @@ -0,0 +1,378 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Texas Instruments ADS112C04 16-bit I2C ADC driver
> > + * Based on TI Reference Code and standard Linux IIO framework.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mutex.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/property.h>
> > +#include <linux/gpio/consumer.h>
> > +
> > +/* ADS112C04 Commands */
> > +#define ADS112C04_CMD_RESET         0x06
> > +#define ADS112C04_CMD_START_SYNC    0x08
> > +#define ADS112C04_CMD_POWERDOWN     0x02
> > +#define ADS112C04_CMD_RDATA         0x10
> > +#define ADS112C04_CMD_RREG(reg)     (0x20 | ((reg) << 2))
> > +#define ADS112C04_CMD_WREG(reg)     (0x40 | ((reg) << 2))
> > +
> > +/* Registers */
> > +#define ADS112C04_REG_CONFIG0       0x00
> > +#define ADS112C04_REG_CONFIG1       0x01
> > +#define ADS112C04_REG_CONFIG2       0x02
> > +#define ADS112C04_REG_CONFIG3       0x03
> > +
> > +#define ADS112C04_DRDY_MASK         BIT(7)
> > +#define ADS112C04_MUX_MASK          GENMASK(7, 4)
>
> We like to include the name of the register in the mask names
> (and usually don't bother with _MASK to keep it shorter) and
> organize the fields under the registers with a bit of indent.
>
> Something like:
>
> #define ADS112C04_REG_CONFIG0       0x00
> #define   ADS112C04_CONFIG0_MUX       GENMASK(7, 4)
> #define ADS112C04_REG_CONFIG1       0x01
> #define ADS112C04_REG_CONFIG2       0x02
> #define   ADS112C04_CONFIG2_DRDY      BIT(7)
> #define ADS112C04_REG_CONFIG3       0x03
>
Thanks guiding, I will updated to use this naming convention with
proper indentation.
> > +
> > +struct ads112c04_state {
> > +     struct i2c_client *client;
> > +     /* Protects concurrent ADC reads and device configuration */
> > +     struct mutex lock;
> > +     struct completion completion;
> > +     struct regulator *vref_reg;
> > +     int vref_mv;
> > +     u8 config0;
> > +     u8 config1;
> > +};
> > +
> > +static int ads112c04_write_cmd(struct i2c_client *client, u8 cmd)
> > +{
> > +     int ret =3D i2c_master_send(client, &cmd, 1);
> > +
> > +     return ret < 0 ? ret : 0;
> > +}
> > +
> > +static int ads112c04_read_reg(struct i2c_client *client, u8 reg, u8 *v=
al)
> > +{
> > +     u8 cmd =3D ADS112C04_CMD_RREG(reg);
> > +     int ret;
> > +
> > +     ret =3D i2c_master_send(client, &cmd, 1);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D i2c_master_recv(client, val, 1);
> > +     return ret < 0 ? ret : 0;
>
> This can be done in one I2C call.
>
>         ret =3D i2c_smbus_read_byte_data(client, cmd);
>         if (ret < 0)
>                 reutrn ret;
>
>         *val =3D ret;
>
>         return 0;
>
>
> > +}
> > +
> > +static int ads112c04_write_reg(struct i2c_client *client, u8 reg, u8 v=
al)
> > +{
> > +     u8 buf[2] =3D { ADS112C04_CMD_WREG(reg), val };
> > +     int ret;
> > +
> > +     ret =3D i2c_master_send(client, buf, 2);
> > +     return ret < 0 ? ret : 0;
>
> And here it can be:
>
>         u8 cmd =3D ADS112C04_CMD_WREG(reg);
>
>         return i2c_smbus_write_byte_data(client, cmd, val);
>
Transitioning to the SMBus APIs has significantly cleaned up ads112c04_read=
_reg,
ads112c04_write_reg, and ads112c04_read_data. It also handles the I2C
error checking beautifully.
> > +}
> > +
> > +static int ads112c04_wait_for_data(struct ads112c04_state *st)
> > +{
> > +     int ret;
> > +     u8 val;
>
> The slowest data rate is 20 SPS, so wouldn't 100 ms timeout be more than
> enough? 1 second seems a bit long.
I will reduce the timeout to 100ms.
>
>
> > +
> > +     if (st->client->irq > 0) {
> > +             ret =3D wait_for_completion_timeout(&st->completion, msec=
s_to_jiffies(1000));
> > +             if (!ret)
> > +                     return -ETIMEDOUT;
> > +             return 0;
> > +     }
> > +
> > +     return read_poll_timeout(ads112c04_read_reg, ret,
> > +                              (ret < 0 || (val & ADS112C04_DRDY_MASK))=
,
> > +                              1000, 1000000, false,
>
> When there is more than 3 or 4 zeros, it is helpful to use macros, like
> 1 * MICRO.
Replaced the hardcoded 1000000 with 100 * USEC_PER_MSEC.
>
> > +                              st->client, ADS112C04_REG_CONFIG2, &val)=
;
> > +}
> > +
> > +static int ads112c04_read_data(struct ads112c04_state *st, int *val)
> > +{
> > +     u8 cmd =3D ADS112C04_CMD_RDATA;
> > +     __be16 buf;
>
> I would call this data instead of buf.
>
> > +     int ret;
> > +
> > +     ret =3D i2c_master_send(st->client, &cmd, 1);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D i2c_master_recv(st->client, (u8 *)&buf, 2);
>
> sizeof(buf) instead of 2.
>
> > +     if (ret < 0)
> > +             return ret;
>
>
> Or more simply ...
>
>         ret =3D i2c_smbus_read_word_data(client, cmd);
>         if (ret < 0)
>                 return ret;
>
>         *val =3D sign_extend32(be16_to_cpu(ret), 15);
>
This is much cleaner than manually managing the buffer and i2c_master_recv.
> > +
> > +     *val =3D sign_extend32(be16_to_cpu(buf), 15);
> > +     return 0;
> > +}
> > +
> > +static int ads112c04_get_adc_result(struct ads112c04_state *st,
> > +                                 struct iio_chan_spec const *chan,
> > +                                 int *val)
> > +{
> > +     int ret;
> > +     u8 mux, new_config0;
> > +
> > +     mux =3D FIELD_PREP(ADS112C04_MUX_MASK, chan->address);
> > +     new_config0 =3D (st->config0 & 0x0F) | mux;
>
> ~ADS112C04_MUX_MASK instead of 0x0F.
>
> Or:
>
>         new_config0 =3D st->config0;
>         FIELD_MODIFY(ADS112C04_MUX_MASK, &new_config0, chan->address);
>
I am going to use st->config0 & ~ADS112C04_CONFIG0_MUX combined with
`FIELD_PREP().
> > +
> > +     if (st->config0 !=3D new_config0) {
> > +             ret =3D ads112c04_write_reg(st->client, ADS112C04_REG_CON=
FIG0, new_config0);
> > +             if (ret < 0)
> > +                     return ret;
> > +             st->config0 =3D new_config0;
> > +     }
> > +
> > +     reinit_completion(&st->completion);
> > +
> > +     ret =3D ads112c04_write_cmd(st->client, ADS112C04_CMD_START_SYNC)=
;
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D ads112c04_wait_for_data(st);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return ads112c04_read_data(st, val);
> > +}
> > +
> > +static int ads112c04_read_raw(struct iio_dev *indio_dev,
> > +                           struct iio_chan_spec const *chan,
> > +                           int *val, int *val2, long mask)
> > +{
> > +     struct ads112c04_state *st =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             mutex_lock(&st->lock);
> > +             ret =3D ads112c04_get_adc_result(st, chan, val);
> > +             mutex_unlock(&st->lock);
> > +
> > +             if (ret < 0)
> > +                     return ret;
> > +             return IIO_VAL_INT;
> > +
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val =3D st->vref_mv;
> > +             *val2 =3D 15;
> > +             return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static irqreturn_t ads112c04_irq_handler(int irq, void *private)
> > +{
> > +     struct iio_dev *indio_dev =3D private;
> > +     struct ads112c04_state *st =3D iio_priv(indio_dev);
> > +
> > +     complete(&st->completion);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static const struct iio_info ads112c04_info =3D {
> > +     .read_raw =3D ads112c04_read_raw,
> > +};
> > +
> > +static void ads112c04_regulator_disable(void *data)
> > +{
> > +     regulator_disable(data);
> > +}
> > +
> > +static int ads112c04_parse_channels(struct iio_dev *indio_dev)
> > +{
> > +     struct device *dev =3D indio_dev->dev.parent;
> > +     struct iio_chan_spec *channels;
> > +     u32 num_channels, i =3D 0, pair[2];
> > +
> > +     num_channels =3D device_get_named_child_node_count(dev, "channel"=
);
> > +     if (!num_channels)
> > +             return -EINVAL;
> > +
> > +     channels =3D devm_kcalloc(dev, num_channels, sizeof(*channels), G=
FP_KERNEL);
> > +     if (!channels)
> > +             return -ENOMEM;
> > +
> > +     device_for_each_named_child_node_scoped(dev, child, "channel") {
> > +             struct iio_chan_spec *spec =3D &channels[i];
> > +
> > +             spec->type =3D IIO_VOLTAGE;
> > +             spec->indexed =3D 1;
> > +             spec->info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | BIT=
(IIO_CHAN_INFO_SCALE);
> > +             spec->scan_index =3D i;
>
> scan_index isn't currently used, so we could leave that out for now.
Removed.
>
> > +
> > +             if (fwnode_property_present(child, "single-channel")) {
> > +                     fwnode_property_read_u32(child, "single-channel",=
 &pair[0]);
> > +                     spec->channel =3D pair[0];
> > +                     spec->differential =3D 0;
>
> differential is already 0, so don't need to set it here.
>
> > +                     spec->address =3D 0x08 + pair[0];
> > +             } else if (fwnode_property_present(child, "diff-channels"=
)) {
> > +                     fwnode_property_read_u32_array(child, "diff-chann=
els", pair, 2);
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
> > +                             return -EINVAL;
>
> Could be useful to use dev_err_probe() to print a message in this case. H=
elps
> when you make a typo in the devicetree.
Remove the redundant `differential =3D 0` assignment.
I will also add `dev_err_probe()` to provide clear error messages for inval=
id
or missing channel properties.
>
> > +             } else {
> > +                     return -EINVAL;
> > +             }
>
> I would also check if the other properties mentioned in the DT binding re=
view
> exist here and return error if they do since they aren't implemented. See
> similar example below with refp-refn properties.
 have added checks in both ads112c04_parse_channels and ads112c04_probe.
If properties like excitation-channels, refn-supply, or
ti,refp-refn-resistor-ohms are
present in the DT, the driver now returns -EOPNOTSUPP via dev_err_probe().
>
> > +             i++;
> > +     }
> > +
> > +     indio_dev->channels =3D channels;
> > +     indio_dev->num_channels =3D num_channels;
>
> This should be i. num_channels could actually be > i if any node has stat=
us =3D "disabled";.
Fixed. indio_dev->num_channels is now assigned the value of i.
>
> > +
> > +     return 0;
> > +}
> > +
> > +static int ads112c04_probe(struct i2c_client *client)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct ads112c04_state *st;
> > +     struct gpio_desc *reset_gpio;
> > +     int ret;
> > +
>
> Would be nice to make a local dev variable so we don't have to
> write &clinet->dev so much.
Add struct device *dev =3D &client->dev; and updated the function according=
ly.
>
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*st));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     st =3D iio_priv(indio_dev);
> > +     st->client =3D client;
> > +
> > +     ret =3D devm_mutex_init(&client->dev, &st->lock);
> > +     if (ret)
> > +             return ret;
> > +
> > +     init_completion(&st->completion);
> > +
> > +     indio_dev->name =3D "ads112c04";
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->info =3D &ads112c04_info;
> > +
> > +     ret =3D ads112c04_parse_channels(indio_dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D devm_regulator_get_enable(&client->dev, "avdd");
> > +     if (ret)
> > +             return dev_err_probe(&client->dev, ret, "failed to get av=
dd regulator\n");
> > +
> > +     ret =3D devm_regulator_get_enable(&client->dev, "dvdd");
> > +     if (ret)
> > +             return dev_err_probe(&client->dev, ret, "failed to get dv=
dd regulator\n");
> > +
>
> We've been tending towards writing below like:
>
>         if (device_property_present(dev, "refp-supply") {
>                 ret =3D devm_regulator_get_enable_read_voltage(dev, "refp=
");
>                 if (ret < 0)
>                         return dev_err_probe(dev, ret, "failed to read RE=
FP voltage\n");
>
>                 ...
>         }
>
> And I would check the other ref properties too even if we don't implement=
 them.
>
>         if (device_property_present(dev, "refn-supply")
>                 return dev_err_probe(dev, -EOPNOTSUPP, "refn-supply is no=
t implemented\n");
>
>         if (device_property_present(dev, "ti,refp-refn-resistor-ohms")
>                 return dev_err_probe(dev, -EOPNOTSUPP, "ti,refp-refn-resi=
stor-ohms is not implemented\n");
>
> > +     st->vref_reg =3D devm_regulator_get_optional(&client->dev, "refp"=
);
> > +     if (IS_ERR(st->vref_reg)) {
> > +             ret =3D PTR_ERR(st->vref_reg);
> > +             if (ret =3D=3D -ENODEV) {
> > +                     st->vref_mv =3D 2048;
> > +                     st->config1 =3D 0x00;
> > +             } else {
> > +                     return ret;
> > +             }
> > +     } else {
> > +             ret =3D regulator_enable(st->vref_reg);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D devm_add_action_or_reset(&client->dev, ads112c04_=
regulator_disable,
> > +                                            st->vref_reg);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D regulator_get_voltage(st->vref_reg);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> > +             st->vref_mv =3D ret / 1000;
>
> We've been writing this like:
>
>                 st->vref_mv =3D ret / (MICRO / MILLI);
>
> > +             st->config1 =3D 0x02;
>
> Add a macro and use FIELD_PREP().
>
> > +     }
>
> And as in the DT bindings reply, we should go ahead and make the referenc=
e
> voltage per channel. Even if we don't need it now, it would be hard to ch=
ange
> it in the future without breaking existing users.
>
> > +
> > +     reset_gpio =3D devm_gpiod_get_optional(&client->dev, "reset", GPI=
OD_OUT_LOW);
>
> If we make this GPIOD_OUT_HIGH, then we save a line later.
I will change to GPIOD_OUT_HIGH and removed the explicit set-to-1 line.
>
> > +     if (IS_ERR(reset_gpio))
> > +             return PTR_ERR(reset_gpio);
> > +
> > +     if (reset_gpio) {
> > +             gpiod_set_value_cansleep(reset_gpio, 1);
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
> > +     st->config0 =3D 0x01;
>
> Needs a macro and FIELD_PREP().
>
> Also, since we are parsing channels now, can/should we leave PGA enabled
> for diff-channels? Otherwise add a comment explaining current choice.
For this minimal initial submission, I've opted to keep the PGA
bypassed (disabled)
by default for all channels.
This ensures users can safely measure up to VDD without hitting the PGA's
absolute input voltage limits.
>
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
> > +             ret =3D devm_request_irq(&client->dev, client->irq,
> > +                                    ads112c04_irq_handler,
> > +                                    0,
>
> Can put 0 on the previous line.
Formatting fixed.
>
> > +                                    indio_dev->name, indio_dev);
> > +             if (ret) {
> > +                     dev_err(&client->dev, "Failed to request DRDY IRQ=
\n");
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return devm_iio_device_register(&client->dev, indio_dev);
> > +}
> > +
> > +static const struct i2c_device_id ads112c04_id[] =3D {
> > +     { .name =3D "ads112c04", .driver_data =3D 0 },
>
> No need for .driver_data since it is 0.
Removed. Thanks again for your time and the detailed guidance!
Best regards,
Kyle Hsieh
>
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, ads112c04_id);
> > +
> > +static const struct of_device_id ads112c04_of_match[] =3D {
> > +     { .compatible =3D "ti,ads112c04" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ads112c04_of_match);
> > +
> > +static struct i2c_driver ads112c04_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "ads112c04",
> > +             .of_match_table =3D ads112c04_of_match,
> > +     },
> > +     .probe =3D ads112c04_probe,
> > +     .id_table =3D ads112c04_id,
> > +};
> > +module_i2c_driver(ads112c04_driver);
> > +
> > +MODULE_AUTHOR("Kyle Hsieh <kylehsieh1995@gmail.com>");
> > +MODULE_DESCRIPTION("Texas Instruments ADS112C04 ADC driver");
> > +MODULE_LICENSE("GPL");
> >
>
