Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6681A680C
	for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2026 01:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785288105; cv=pass; b=ea5oAW+N2U7SGsN9iYKCKrctvwIfAgwNNN2ru0L4/4sL7NVZOpbG38DNbWsDIczdJZOcLkiv0xB2EMuHIIh2F2hSIm0SQS8/Zr5EwRgj3wBFU/u+mlZAw+m7be1n/Qyd8Y7CSiA72//r63E4fG/lwMMlQj1fY3P1zH9L3T8j+9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785288105; c=relaxed/simple;
	bh=QAWcP+VBH0+vyCxvrAr8FdGTeexiTUFST6hV5JQpnso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2+LHg2K8PtGOsghuKL4OiZB4aeW8/0JTQXE8jtnIRE9kyPhBV4CWlgiVMmqkA+bz3/NemEpQZfQDsPMxEHptfJUZYVsDIu67MiuhW9rBmHe7hF5/LLzTnSCILkjFKHKylnZUjeAucykiOw+GwczZhF5TlinMjHoK/9HB6eQ56U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP+BOJGm; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP+BOJGm"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c83acb86eso3136151fa.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 18:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785288101; cv=none;
        d=google.com; s=arc-20260327;
        b=kSoL5CJg74xvupb+8imb6kGy2+xVLx7mfNA8BNLQpjgEes9q4/ixMSJj28CsSSzemm
         nmdUMSMo+NdGvTnZQ7c0ODJZI0g9iO/lJwfiqxXGk5lYXtdnPf8pWDLPMkgXkekMAO//
         KNyah2TxSx4iUIQScfqYOUAZ1nwypk57HwyBUP+QRDtZOeDJVrJ1rc9JCJNUdQ0Uw/jo
         ncIsizTUcBARcSHzYCMccFiyhvpQSrsu4Vm0oixAltONrVD7pEwttkyZl9gEPxTr9LLa
         pyXCu7c6mSARQIdvolKtOQGCIsoOyYGIvOqpHylKR6XbQXqNym5Vb1jvlXEeay3/7eyu
         fFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AnRdLsh923Pk5BBlDr27FcT7vp2fr2DhBy6XMLZMvCY=;
        fh=6GdcjV6yYEc0EarOFpQaJN31RrIP0zK7fZyEspsnaSE=;
        b=hOM6oL7kIvCPAx6GmzxFFWe9FdeOVUC9jBv3xzU9YPrt4drLm/YtaZUdXIRGtF/R9V
         Uyn4z9xnKKYqE1e1YIODwqz+g2fRs30409pB9C7FVWhSSB0lP9R9pPfB+jLy5GEc1OwH
         OZcSUcYIJI05JoC9alnNkN3Ig/CvHDShrH+Jzptm7xCE0nFF9KEHS6PSYoLXh/3x10HB
         eRe/1nAg3PjdorsgyV8E212QwKFLTmO16F2RKnuhn1cpGdg2kysP9W+zzhfxo9P1CVrr
         TmhTF56VtwAz9xxKXO3aDivmIXgm5anJWZvItzbkPWrQlX6ex/La1baxnN9dAN50djPf
         yyeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785288101; x=1785892901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AnRdLsh923Pk5BBlDr27FcT7vp2fr2DhBy6XMLZMvCY=;
        b=TP+BOJGmnsXMBvxtylnwW/S/qzjrRvdPMx4rXTuDTFvluYxb81r7k2goDEVA2PL3w3
         BhhBFHhfVI7wTfhJQSTFLiIjIHJREfYna9rzz+wlS8IPxz8+9pDZOeaBf2L9ScjD3ShF
         FJgFoDyAl3ESHRNC+PMJVTk9xIz2rI55oDTRHEoLZdJdvEjTn94RO5HI64aNVPQzugl6
         U34ilSv5is4ttGy2PG6bvr4K2Sws73XIFGzMJHtuvP0i47o7D6wZk6faulfl71OgWfAb
         uQ6dKV01G8Kdz3BxADaVocylLhQPZ/hnxQE3eMXWJRIrygkPOvIZ71QYZggRKW66OMFs
         2IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785288101; x=1785892901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AnRdLsh923Pk5BBlDr27FcT7vp2fr2DhBy6XMLZMvCY=;
        b=YgUhp/bS9NHWQ9GwpI4akNKH3r7b6JyWw7Mj+YqgvHfvYNlv1MXSCv066Qj3pCIz9p
         RD/UdQTAYC5uRZTeidkt+WArdfn+yASLZJrryTkOgIhWzk6Dy8dyJ5674jIL0FK8AGku
         PdeMaw2O8AB/HHRLaBJvnx+dESrarPHNtcpZVkc0/pzYe3NUFTql0kl3TzwnFhTSAODT
         pXER3RUEhDuOGkpWH8++rYoLb+ooFZkDoLXFglYNR1kw1z1O4mGsMFaHQUg5TFkpoJQR
         LAn6xMt8jYT0yt9BlhfXiHHJTtKCNYFr67NYRRdW+SY8Abxb+SNj7tbXEz5/eVvTutJ0
         uncg==
X-Forwarded-Encrypted: i=1; AHgh+RpJdaGY/DbwjUaYfxCEVHLOMEWQUfPfI0IZzHVoFrClZ8nQOv0ATH+3rRRWEXJhgJr3KX4W2kXeCus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6mTTRnqb2UyWePqaYL9n1qb/UKdFjc3IccEx0XizcW+elb+81
	qcMrPWfZ9M3soS1UoFj3yUG4nPyvzH0E3kPPbGTAAH8cDr45LaeieOX1xZtamweuPmMEgeav7wv
	qfVdCXPqxrNFPSg7JcBW+DuTsWEyXETU=
X-Gm-Gg: AR+sD10Un3l1ZNelhvohNI/urE+Gg/l4BIZht6AojrFGYHlaPC2sGnyNwMEdwKqwPdR
	WRmhxo6Iy1eBb+w2vZA602XcVw5qRTjXt3tir9GICESOPfX3XjRC4bY0M/1iLi0DtuXnwexJGwm
	+jkTocjJ9Au/bBd3pMdxMucSKHTxuu7oGtO92jnEqcVDNAno0yVTt4OHDED/NAEhxoJphTet1xQ
	HCszch90YA0qIaoHubMZ5BjsR38Pl5NrwV55B9BV5NPcHgs1B0+Brc8U5JqB5qSQzlTaW6yAgdq
	A8mFv0z3XYmg2UN3wzceqMf1s+nkeejDiCozW4Ku+t5ZAw==
X-Received: by 2002:a05:651c:211d:b0:39c:9e1c:7cd with SMTP id
 38308e7fff4ca-39f51e5887emr8422161fa.39.1785288100701; Tue, 28 Jul 2026
 18:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728-ti-ads112c04-driver-v1-0-475efe4e2b78@gmail.com>
 <20260728-ti-ads112c04-driver-v1-2-475efe4e2b78@gmail.com> <2f2d7ae4-1923-4a57-9939-63361f2ff5ca@baylibre.com>
In-Reply-To: <2f2d7ae4-1923-4a57-9939-63361f2ff5ca@baylibre.com>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 29 Jul 2026 09:23:29 +0800
X-Gm-Features: AUfX_myh7WBiwO5itXKuiSkiHU9EbPtIt3nLaUifDHWyr9O4SqmM2iwLloeOCo8
Message-ID: <CAF7HswNFg2DkD2Wif=9Hv3cyak5UVdBOUKhkH-iYBJ0NMaTxGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ti-ads112c04: Add support for TI ADS112C04
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thank you for the detailed review and for pointing out the modern kernel AP=
Is.

On Tue, Jul 28, 2026 at 11:21=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 7/28/26 3:01 AM, Kyle Hsieh wrote:
> > Add IIO driver support for the Texas Instruments ADS112C04 (16-bit)
> > delta-sigma ADCs.
> >
> > The driver implements:
> > - Single-shot conversions using the IIO raw read interface.
> > - MUX configuration for single-ended and differential channels.
> > - Hardware interrupt support via the DRDY pin, falling back to
> >   software polling of the configuration register if no IRQ is provided.
> > - Scale calculation based on the internal 2.048V reference.
> > - Dynamic reference voltage scaling via the regulator subsystem
> >   (vref-supply), falling back to the internal 2.048V reference
> >   if not specified.
>
> Nice to see it starting with a minimal feature set like this. Makes it ea=
sy
> to review.
>
> In the cover letter, it would be nice to know if this is all the features
> you need or if you plan to add more soon.
I will clarify this in the next version cover letter. This minimal set
covers our
current use case now.
>
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > ---
> >  drivers/iio/adc/Kconfig        |  10 ++
> >  drivers/iio/adc/Makefile       |   1 +
> >  drivers/iio/adc/ti-ads112c04.c | 317 +++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 328 insertions(+)
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
> > index 000000000000..0f1d415e3f21
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-ads112c04.c
> > @@ -0,0 +1,317 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> Prefer either GPL-2.0-only or GPL-2.0-or-later (your choice).
>
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
> > +/* Config2 Masks */
> > +#define ADS112C04_DRDY_MASK         BIT(7)
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
> > +     return i2c_master_send(client, &cmd, 1);
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
> > +}
> > +
> > +static int ads112c04_wait_for_data(struct ads112c04_state *st)
> > +{
> > +     int ret, timeout =3D 50;
>
> Why is poll timeout 50x longer than interrupt timeout?
>
> > +     u8 val;
> > +
> > +     /* If IRQ is available, wait for DRDY interrupt completion */
> > +     if (st->client->irq > 0) {
> > +             ret =3D wait_for_completion_timeout(&st->completion, msec=
s_to_jiffies(1000));
> > +             if (!ret)
> > +                     return -ETIMEDOUT;
> > +             return 0;
> > +     }
> > +
> > +     /* Fallback: Poll DRDY bit in CONFIG2 */
>
> Use read_poll_timeout() or if you convert to use regmap, regmap_read_poll=
_timeout().
I will switch to `read_poll_timeout()` and align the timeout duration prope=
rly.
>
> > +     while (timeout--) {
> > +             ret =3D ads112c04_read_reg(st->client, ADS112C04_REG_CONF=
IG2, &val);
> > +             if (ret < 0)
> > +                     return ret;
> > +             if (val & ADS112C04_DRDY_MASK)
> > +                     return 0;
> > +             usleep_range(1000, 2000);
> > +     }
> > +
> > +     return -ETIMEDOUT;
> > +}
> > +
> > +static int ads112c04_read_data(struct ads112c04_state *st, int *val)
> > +{
> > +     u8 cmd =3D ADS112C04_CMD_RDATA;
> > +     u8 buf[2];
>
> Use __be16 buf;
>
> > +     int ret;
> > +
> > +     ret =3D i2c_master_send(st->client, &cmd, 1);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D i2c_master_recv(st->client, buf, 2);
> > +     if (ret < 0)
> > +             return ret;
>
> Can be simplified by using smbus APIs. It would just be one call.
>
> > +
> > +     /* 16-bit 2's complement conversion */
> > +     *val =3D (s16)((buf[0] << 8) | buf[1]);
>
> And here use be16_to_cpu() and sign_extend32(). Then no comments needed.
Thank you for the suggestion. I will update the data reading logic to use
`__be16`, `be16_to_cpu()`, and `sign_extend32()` for a much cleaner
implementation.
>
> > +     return 0;
> > +}
> > +
> > +static int ads112c04_get_adc_result(struct ads112c04_state *st,
> > +                                 struct iio_chan_spec const *chan,
> > +                                 int *val)
> > +{
> > +     int ret;
> > +     u8 mux;
> > +
> > +     mux =3D (chan->address << 4) & 0xF0;
>
> Use FIELD_PREP().
Got it.
>
> > +     if ((st->config0 & 0xF0) !=3D mux) {
>
> Another option would be to use regmap with cache so that we don't
> have to keep track of the current config ourselves.
>
> > +             st->config0 =3D (st->config0 & 0x0F) | mux;
> > +             ads112c04_write_reg(st->client, ADS112C04_REG_CONFIG0, st=
->config0);
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
> > +     int ret, raw;
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
> > +             *val2 =3D 15; /* 2^15 */
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
>
> nit: add blank line here.
Will fix.
>
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +#define ADS112C04_V_CHAN(_chan, _addr) {                     \
> > +     .type =3D IIO_VOLTAGE,                                    \
> > +     .indexed =3D 1,                                           \
> > +     .channel =3D _chan,                                       \
> > +     .address =3D _addr,                                       \
> > +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),           \
> > +     .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),   \
> > +}
> > +
> > +#define ADS112C04_V_DIFF_CHAN(_chan, _chan2, _addr) {                \
> > +     .type =3D IIO_VOLTAGE,                                    \
> > +     .differential =3D 1,                                      \
> > +     .indexed =3D 1,                                           \
> > +     .channel =3D _chan,                                       \
> > +     .channel2 =3D _chan2,                                     \
> > +     .address =3D _addr,                                       \
> > +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),           \
> > +     .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),   \
> > +}
> > +
> > +static const struct iio_chan_spec ads112c04_channels[] =3D {
> > +     ADS112C04_V_DIFF_CHAN(0, 1, 0x00),
> > +     ADS112C04_V_DIFF_CHAN(0, 2, 0x01),
> > +     ADS112C04_V_DIFF_CHAN(0, 3, 0x02),
> > +     ADS112C04_V_DIFF_CHAN(1, 0, 0x03),
> > +     ADS112C04_V_DIFF_CHAN(1, 2, 0x04),
> > +     ADS112C04_V_DIFF_CHAN(1, 3, 0x05),
> > +     ADS112C04_V_DIFF_CHAN(2, 3, 0x06),
> > +     ADS112C04_V_DIFF_CHAN(3, 2, 0x07),
> > +     ADS112C04_V_CHAN(0, 0x08),
> > +     ADS112C04_V_CHAN(1, 0x09),
> > +     ADS112C04_V_CHAN(2, 0x0A),
> > +     ADS112C04_V_CHAN(3, 0x0B),
> > +};
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
> > +static int ads112c04_probe(struct i2c_client *client)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct ads112c04_state *st;
> > +     int ret;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*st));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     st =3D iio_priv(indio_dev);
> > +     st->client =3D client;
> > +     mutex_init(&st->lock);
>
>         ret =3D devm_mutex_init(&st->lock);
>         if (ret)
>                 return ret;
>
> > +     init_completion(&st->completion);
> > +
> > +     indio_dev->name =3D "ads112c04";
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->info =3D &ads112c04_info;
> > +     indio_dev->channels =3D ads112c04_channels;
> > +     indio_dev->num_channels =3D ARRAY_SIZE(ads112c04_channels);
>
> We need more information to know how to configure each channel, so we
> probably won't be able to use fixed channels like this.
I will drop the fixed array and refactor the driver to parse the
channel configurations
dynamically from the devicetree child nodes, matching the dt-bindings updat=
e.
>
> > +
> > +     st->vref_reg =3D devm_regulator_get_optional(&client->dev, "vref"=
);
>
> This is gonig to be more compilicated. See ti-ads112c14 driver.

>
> > +     if (IS_ERR(st->vref_reg)) {
> > +             ret =3D PTR_ERR(st->vref_reg);
> > +             if (ret =3D=3D -ENODEV) {
> > +                     st->vref_mv =3D 2048;
> > +                     st->config1 =3D 0x00; /* VREF[1:0] =3D 00 */
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
> > +             st->config1 =3D 0x02;
> > +     }
> > +
> > +     /* Reset device to defaults */
>
> There is a hardware reset, so the way we usually do that is to use
> devm_reset_control_get_optional_exclusive() to see if the gpio is
> wired up. If it is, use that to do the reset, otherwise fall back
> to the software reset.
I will implement the hardware reset fallback logic using
`devm_gpiod_get_optional()` as you suggested.
>
> > +     ads112c04_write_cmd(client, ADS112C04_CMD_RESET);
> > +     usleep_range(1000, 2000);
>
>         fsleep(1000);
>
> > +
> > +     /* Set defaults: PGA Disabled (For single-ended safety), Gain=3D1=
 */
> > +     st->config0 =3D 0x01;
> > +
> > +     ads112c04_write_reg(client, ADS112C04_REG_CONFIG1, st->config1);
>
> Check return value.
Will fix.
>
> > +
> > +     if (client->irq > 0) {
> > +             ret =3D devm_request_irq(&client->dev, client->irq,
> > +                                    ads112c04_irq_handler,
> > +                                    IRQF_TRIGGER_FALLING,
>
> This flag already comes from the devicetree and should not be hard-coded
> here.
I will change this to `0` to inherit the trigger type from the devicetree.
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
> > +     { "ads112c04", 0 },
>
>         { .name =3D "ads112c04" },
>
Will update to use the named initializer.
Thanks again for your time and the fantastic guidance!
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
