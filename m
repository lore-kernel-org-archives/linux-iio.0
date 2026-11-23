Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795461883;
	b=eegqIPmCuRKdXS1Bnwefnn6Ua6Lw2HO9MKOmSHP5VxvhkZGKOtmwx57G5Ggitn5VWOeP
	 PpO0ktmLL/kFi0kBsuu1fU9IudGi+ucAACDI8CWkFRFlFMooJcMjdFhHIhkevIyUdnNA+
	 RKNWR+AfUOyo3tEZocOowYuhZD9Eof/lat9fH8SlCTfqUkFrDxy/y5JorU9pqz60yI5Kr
	 8rB2F255/dPq5Q+oziuRrMxZuKZO8vjABtjGKZ++w5XuPe0NbZThHiiHUtT0Rz4kzCmkF
	 TZO+kKtRVbn8duDmk200MCC2yA8AyZKpwS8Sg+oLR0//IagUST7V2vvbSlnjTGWDSTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mu3NpxL0VDL/oCB28gOtk5lf+/OEsMsSKxF2nMbAOns=;
	b=Y9pdnC14QAksOK39+6GDMyrD2FNDOx1sCKH0iFSdEzyeriedU64EqX3o/nRfqHrmtAJc
	 2idiF8zsJaPXZA/mUBE5VmgSP7e++9rJYkoKWGaa+uUsSncqfJ3mjLOGEWRS3/cmleDbq
	 9ixbmKfAVP7rsaaV26tX701SBNHJUAv5G/0EeTh3Imb90Hc2WonMAvtyjQNhPsADYWm0m
	 UX99lf4bY9BChTP57lchiNKUQjlWlWRmq2xq7OYQhhV9IJquLXhh+elcFLRXNH3YxvY2I
	 OmNc1C+JYOAFVHfYOySDLNO/stiARXCAPpyrMwkqZrNhbaUGtoqcIc67aaZzgiy6rsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h7jDIIKH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2879606A326
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 19:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2879606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h7jDIIKH
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-385d8a00598so5126575eec.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 11:24:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795461882; cv=none;
        d=google.com; s=arc-20260327;
        b=C6dlm7SQ+qj5DjNt/bFs8nAjSEzwGzN4AwJvojtg+wixaZrvTLLbspz4EwPxcfdZJc
         zL9gTQ0jBeqWwFkftT3G9UPfxmzOxyonY14difz7TthegmugAc50TnZqN47F8tnvf3U7
         YC+GxRub/8FvHLYvdqckAjSoGj3fDdclwFpgg8EL4oz5XGpofpTzvcgRtSY0TmdLTOOF
         hDyKb53T7XF9uGBoe7ypvLJeo0HIfe0l7iG1B1oZdHV/sR3D5gUZ1IcpxGVHkfyQEdZT
         aE3ZqqMAy1tKw6MNp4amWRPeFhI4kU7blKuFd+/PYuhD/m5F8rCk27fUb61ztl2SO2AE
         MgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mu3NpxL0VDL/oCB28gOtk5lf+/OEsMsSKxF2nMbAOns=;
        fh=I8j98sWEy/20sqxA43TtvIA6MKlDiQZw6H5Z6itjah0=;
        b=bT1Zp5jN9IZIwmDzffxSk34jmpuhF3G66GlTKUZ/7tL4X/Qbn121SpyUyovA9oVwwM
         eebn5xmRwDPXYjPcXT48QXWPP5oAoVes7JUTeWQZd9KOrDeNBl+KLuDpvCVLg7MsNaoS
         7Y42vCkMVEAd1VT5RgJ+HiH8OUdX6Txw+QQ6/kcv84mZaRK+7nMOJEKY6FDS5gvsoZZP
         Wskqpz3cPDteRiDAYFQqipQnrxccOrxReOxSTwdJ1Bi+7ucu5b5+UFOsuB1UQ6Mqqo87
         H30kcBizJ4UJX5BQIR62UNYpE796XdrxyWJC42rKbsc5+WAR4OZsAcbdUKodmyiwtJ1p
         z0Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795461882; x=1796066682; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mu3NpxL0VDL/oCB28gOtk5lf+/OEsMsSKxF2nMbAOns=;
        b=h7jDIIKHDbwAJU/+rLgBlKd7MZbSjgSI1Al9rnYKD7Yk1+Eo/U/PcalKvg0hiCo55L
         P919qWgeYHhUTFV7zKjK3i6tOoZ8PIQ9VnO1VbPPzSM0qUr+4lPoQmpM3OvBKEuj1qSX
         wl+kYIZ4Q+rDehFY0h4XMPUxGhB6McliNkn6T/hcwrbwPXrJ5reTHx68UpF9NheNB5tB
         haVNO1NKTLML/nh8jnfoURMF0PQB1kcIZ3j5aMP562Lm9UCCOXBz3UNcM/3i2HDCffQB
         7Qiq5zBBxmYq7LdrBX4r/aLNaQRclterA05Q6Kmal1JoUOMKFL7bLnApornbOIQG7KpG
         WS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795461882; x=1796066682;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mu3NpxL0VDL/oCB28gOtk5lf+/OEsMsSKxF2nMbAOns=;
        b=LdClQ+n50xATXpQH/JXJ/3miUgGYtdMWUmwezIa7iuHNIG9okRRR4E2FK3kez2vL16
         StUZ1aBJQUk/AfZZ5y4GhDIjuuGpC0vMHcrSifoTxYAASQ5IrnliCoQw3nc3c29IpUZB
         NkwYPeyDemUq4XWGu1uOpSVnDgANaLVmat7SBIJN02Eu7NFVLZdc6t6lY8BmxHuuHzNr
         e/RM1xYVctIi3MzUmYel+FrMU9GIcthMd8FbwslStwK0rmRJkz0Qu5k0cYfAxw1h/oqp
         m4gX0lBIszUF9d513zn/N1ryG3xPrWfm0B+XNb+uSZotqvYekr9eveN3Fm/Qc18yPCVL
         Yo8A==
X-Forwarded-Encrypted: i=1; AL+hErHGbTuUxo45GQVb3EF2V/bJXQXXQuH8H5vvtTfCyyPnDodaPrYApddtePBpjmk/U/GUJwejiGL/v/I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8eLcZp7JGlkZ0AukZ1E6kPoN6Vm0j3ZumKrrmKw1zXGtwS9GnH
	KZoZMpXbncCmDfYB368Q7z1My9CvV3JO7JzkzndUR+4xALvEPBR5Wez++QUS1L/yCgBHpyZghGt
	Cq5Qy8BLZa/8s4e9yLhQvksCUAlNSrns=
X-Gm-Gg: AZFdTZf/8UuLWUSfexMEKg5JXOrrEbrHQVmvTqOGfDJJCOz55+9fqNExYIfcRT2omop
	OzS5pik84rRkzwZkDSBSeOsa6Xgfcvbnh1NmdCYtKrXEpnhggOjXX1oAgc1zjQb2dekFYdnHfeX
	ZlCJiyy+wzlRC1uaiqFseF8FLyvjhR3wfiTujxVfMr3+PtFSEOeQhYbqJ90hHpZxXJ6el+0UM3W
	4SI0S+iOifAQ4UYPIyrW1/K7PzI7C8XI68CKQs4Yhss/ENmrF735SxO+RtQOHbN/z5gI0SgbzJq
	WcOP+M5DT6nfN4lR3DSppCkR3lqDi71gRbI9CU0z4H0TgBGqtd2KwB33yV5s/UUJakKweEhXcCu
	nSJcaDIEIMwNL5D8PTfyvusSvSgQZR9zpbyi8CvAiiRWSNhImNNj4NtMDLHH1S6dbaGLGSFeGo6
	Gl4dTtpglkzHl5qOhWpaCVQcocrFNjIg==
X-Received: by 2002:a05:693c:8641:20b0:383:50b7:1d78 with SMTP id
 5a478bee46e88-38571223ee7mr14067601eec.40.1795461881820; Mon, 23 Nov 2026
 11:24:41 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123150725.212836-1-clamor95@gmail.com> <20261123150725.212836-4-clamor95@gmail.com>
 <awSNc2piI26LgyAU@ashevche-desk.local>
In-Reply-To: <awSNc2piI26LgyAU@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 23 Nov 2026 21:24:30 +0200
X-Gm-Features: Aa3M54p9p3fpa_qpWITuz1CQVJO7lvIEsLxGf_QiAXXT24x-6L6prR2LGWA5Z2I
Message-ID: <CAPVz0n2yBtFh-TJ13cH8WXtiyzR3tOrbhACyq8MThi_6+7DOYg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: adc: Add support for MAX8907 ADC cell
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, mfd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 23 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 21:0=
1 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Nov 23, 2026 at 05:07:24PM +0200, Svyatoslav Ryhel wrote:
> > The MAX8907 PMIC has a dedicated ADC cell, which provides 8 ADC channel=
s
> > with information about different parts of the power system, including t=
he
> > battery, charger/plug, jack and thermal readings.
>
> ...
>
> > +#define MAX8907_CHAN(_type, _idname, _datasheet_name) {              \
> > +     .type =3D (_type),                                        \
> > +     .address =3D MAX8907_REG_##_idname##_MSB |                \
> > +                MAX8907_REG_##_idname##_MEASURE << 8,        \
> > +     .indexed =3D 1,                                           \
> > +     .channel =3D (_idname),                                   \
> > +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |          \
> > +                           BIT(IIO_CHAN_INFO_SCALE),         \
> > +     .scan_index =3D (_idname),                                \
>
> Using () means that you expect an expression as a possible input. In such
> a case the macro is buggy as it will evaluate it twice for _idname. The
> simple solution is to drop these parentheses and expect that this macro
> won't ever be used with the expressions in the parameters.
>

You have a point but current state should not cause issues as well.

> > +     .scan_type =3D {                                          \
> > +             .format =3D IIO_SCAN_FORMAT_UNSIGNED_INT,         \
> > +             .realbits =3D 12,                                 \
> > +             .storagebits =3D 16,                              \
> > +             .endianness =3D IIO_CPU,                          \
> > +     },                                                      \
> > +     .datasheet_name =3D (_datasheet_name),                    \
> > +}
>
> ...
>
> > +static int max8907_adc_read(struct iio_dev *indio_dev,
> > +                         struct iio_chan_spec const *chan,
> > +                         int *val, int *val2, long mask)
> > +{
> > +     struct regmap **regmap =3D iio_priv(indio_dev);
>
> Then logically better to go further and have
>
>         struct regmap *map =3D *regmap;
>

This is matter of taste, I was inspired by MAX77541 ADC which uses
exactly this approach.

> > +     __be16 data;
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret =3D regmap_write(*regmap, MAX8907_TO_MEASURE(chan->ad=
dress), 0);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             ret =3D regmap_bulk_read(*regmap, MAX8907_TO_REG(chan->ad=
dress), &data, sizeof(data));
>
> This is a bit too long.
>

101 char, yeah 1 char too long, though maybe it is not wort resending
for a single char too long?

>                 ret =3D regmap_bulk_read(map, MAX8907_TO_REG(chan->addres=
s),
>                                        &data, sizeof(data));
>
> > +             if (ret)
> > +                     return ret;
> > +
> > +             *val =3D be16_to_cpu(data) >> 4;
> > +
> > +             return IIO_VAL_INT;
> > +
> > +     case IIO_CHAN_INFO_SCALE:
> > +             *val =3D max8907_default_ref[chan->channel];
> > +             *val2 =3D chan->scan_type.realbits;
> > +
> > +             return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
>
> ...
>
> > +static int max8907_adc_init(struct regmap *regmap)
>
> Why not name it 'map'?
>

Because regmap is more explicit and is used consistently across the driver.

> > +{
> > +     u32 value;
> > +     int ret;
> > +
> > +     /* Enable internal voltage reference. Exact purpose of bits is no=
t known. */
> > +     ret =3D regmap_update_bits(regmap, MAX8907_REG_TSC_CNFG1, GENMASK=
(1, 0), BIT(1));
>
>         ret =3D regmap_update_bits(map, MAX8907_REG_TSC_CNFG1, GENMASK(1,=
 0), BIT(1));
>

which map? bitmap? statemap? or maybe geographical map?

> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Check for internal reference IRQ */
>
> Please, make style of one-line comments consistent ("all or none" are wit=
h or
> without period, same for the first letter =E2=80=94 capital or small).
>

First comment has 2 sentences, that is why it has periods. Second only
one, so it does not need period.  "same for the first letter =E2=80=94 capi=
tal
or small" - have you even checked the patch?


> > +     ret =3D regmap_read_poll_timeout(regmap, MAX8907_REG_TSC_STA_INT,=
 value,
> > +                                    !(value & MAX8907_MASK_NREF_OK), 1=
0, 1000);
>
>         ret =3D regmap_read_poll_timeout(map, MAX8907_REG_TSC_STA_INT, va=
lue,
>                                        !(value & MAX8907_MASK_NREF_OK),
>                                        10, 1 * USEC_PER_MSEC);
>

hmm, replace 1000 (4 chars, pretty readable) with USEC_PER_MSEC (12
chars and twice wrapped line and needs tinkering or looking into
units.h), I don't think so.

> > +     if (ret)
> > +             return ret;
> > +
> > +     return regmap_update_bits(regmap, MAX8907_REG_ADC_SCHED,
> > +                               MAX8907_ADC_SCHED_AUTOSCH_ENABLE |
> > +                               MAX8907_ADC_SCHED_AUTOSCH_TIME,
> > +                               MAX8907_ADC_SCHED_AUTOSCH_ENABLE);
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>

I would like to hear what Jonathan has to say.
