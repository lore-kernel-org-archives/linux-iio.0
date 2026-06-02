Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FDE3E5EC4
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407914; cv=pass; b=M6UlPnGY4ioKTgzmZno5amgedKikZbQLVkIpHxzkn/yMl1n0xmtnu8IgatsWtjOMLcTjNleZ4//4KDDuTMvanm0keytvMfhL7hPW28XCvjia/Taa++k2nKxBC96gvPCMbQSpvhklT922NHRIrAank4CdUOo1xuIDj+N/2zZUifo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407914; c=relaxed/simple;
	bh=mfRQt6zofjyY6ZTAQWLKGrBLLlNAa1/TidY6jbdB1k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EN7kn/r7AqPFTE0ziqAXnR8aO5/cOEaLgu14lTw4JesSggCg1lZRYfFVwRRREMJ9xStMrk/4CZVQhEp1GUH+gcaiIvcAth5m/52SSCKce4dwQiOzN0AmWDSIywu+uYcrZidj3GduKXriHtj3DqJ+UlKrvRn3aK3B90x2m6oBXHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e929EOfx; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e929EOfx"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304f0039c02so7956613eec.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 06:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780407912; cv=none;
        d=google.com; s=arc-20240605;
        b=kiPvCrt2c5YmuOmVQbom5cuYP2CdfQZhSMAwtb/ZBKBxQeheTur44MA5V4ku/Ieivd
         P7d9jzRfcWI8EoBAgpYm/Bt62y4ovlDWta2l2RA1nQri1vacnVJy12YBV+6g4exavpQd
         YFgzTFyeRJJvUxhy02WcwYJT0vMl2NPDrEby0WgAWkDqBivjn5GpSRrX9ZCkUVGwFGIc
         LfOv1sPGdFp945Hzxb5wQp9ABJX5qnloLIR/I9MH4kYosTSRu6vomAOpqgABjM/tu6pm
         wQhVupJmbenRUw5UaJoUqls7Mb9C98m8optsmA4hBXwQR8cf/3IfJMmDs0LAqVpenPLX
         49iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zT4hcJaJAxpNku3U6+68TAPB6S0TflnId/dwWCFEDQY=;
        fh=Ek704Scd1u9UbtiR4b+9zxP+ID0Vl7UsYuoTiln2VBQ=;
        b=W48I4odKPP91z1vgGYDBPpS4nqdEW+zBpyHMDxvmJ+Vo3fltyh4v8CSCyDNDZOjZFx
         YE74+idfdnqVBHAkFu4mekfEN0Cy/Zf5J/ysgYIM+qWrilr9ZHPw9jQKbHxXRjktabiw
         A2OP63WQRwFKI2jotGhd15Wjai1GrBPTQFFktntcrUQSlZoo2U8aa9IITJirfzvLy2tV
         YbpQjY1ZbM/L3xMTcHQEvnMRQMQ7wNdjYaCQ4lcSmTcOOEtkTPM5RlU25386V2gMfQKD
         iwDeEWzdOP9fIoIQFWoP+EbJtoVETQVyooICzJvseJ0+q9E0NmDGUQ1X3MiRbcbkWgFS
         25wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780407912; x=1781012712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zT4hcJaJAxpNku3U6+68TAPB6S0TflnId/dwWCFEDQY=;
        b=e929EOfxmFLsq4hUlkHzE+NE/58yILxGFpn3fOd1gvdeurK8o0AzwY8aRvFicbE+ke
         fZp7+dZqrWslwv6YzhIu7Wytt1eLhXz02mTz9XvnCYGLW7Df5QjXvgBbqfDsvDE+X4OY
         5gUD7yR4J6ikvTwaJxWeQ1oqTAIWWEzw4IvmokTpxi3XjVWsnUGYek583gN5FJieF0oH
         6zkQleJmtJAP091wg/euGBxNKHNGl3FvczfyNLOux+xJwCER0y6aaRzorubzp7iHuIjK
         wlnHb3d2gtsYVsc1pienT4XNF1eCN3rRiLFSQhH3Q3WvBk3oRFhgjjuWwKK5Z278Bu0M
         m37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780407912; x=1781012712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zT4hcJaJAxpNku3U6+68TAPB6S0TflnId/dwWCFEDQY=;
        b=i9JsDPWaotnP2FNchGMPKNOsyjlm5cABr2/FqfqZmjjjGkoteCu19siWt10EysU07E
         qndEvgcgjwleN0E2/wQFkpc4v1vkUpAwPO26vaJcWchbGVfqhVdWVplvPCX4fCzNSpeJ
         dQwR48xJKmjFLiQqmsn2f10JlcphfGHCOZ569ME9A47mkYHiBtJYM9zz62DA6585Gw9G
         hSznYEspqa66R75vP3BJFcS2TLxRYbzkxBNwB6F6fVs+WFQfLDwocRe0Nes6mnj6VRhy
         /1j4Q7SC4Iqyq4uvsBQihJVda67Cgvhu57w7UyrZE8T1k9frXqW7RM7Djqk9DSsJdpmx
         fsbw==
X-Forwarded-Encrypted: i=1; AFNElJ8buEjkw8eFOVkAKDbLxdfG3DMS2bTILRgyplz/cpgX6R87CfRLk/6dWuhvmdjBOHfFrkauimn+fME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgKGcpR9EqVppdDsdeheX7/l5POB6Rp1O9yWYKRxxBcOk9fI0l
	QyGZU5TeUorJ5SrBO0oPvGN8PBK+bROZCY9cpHNxtWOOMEPFI1H9WLNWIUCjL0IP87TCKMGqJuR
	+4P+USjkIrBdxG+bmD4hf/JyfV+tkdyM=
X-Gm-Gg: Acq92OGFSKu2mLOMX7tNh+CGTI9jnje03OOysg2zKSWE7iDv/mXP/z4tcMGl3o6spVA
	hQAmMbnO3iLyLF/c1QiKsvLBiqTpFEY+cCs9o5w+seSrbCvD75Kdf9qL1OkNqxYJWc3k3qMy7cp
	r+UtFt5cSe3FTHIcsOFUQsXHdoEaqtMEmUWSS3Fr82rZ/3GhTjuTi+oUFeNeWSjz2+0lcPz2cQk
	z8JbwXF2Tj5AGbZ5uOhtWlU9jb9Ty24S7ABbBziG3vpH1k3HE6bWYFzxH4+0UUkqWZ1ex1q6xMS
	ZyltYS7Fq+HCTS4osV8=
X-Received: by 2002:a05:7300:724d:b0:304:8366:7456 with SMTP id
 5a478bee46e88-304fa4a97f7mr7197710eec.3.1780407912080; Tue, 02 Jun 2026
 06:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-4-clamor95@gmail.com>
 <20260602144222.7a50a041@jic23-huawei>
In-Reply-To: <20260602144222.7a50a041@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 16:45:00 +0300
X-Gm-Features: AVHnY4LTNpiSYmDW8xnqHecCTvTzpdUFD5jDfC_0pqaKrNHhEcy0XqCOTlsLpZ4
Message-ID: <CAPVz0n3x7KaaoZQAmpX-NCz2QNrhWNQaYFvX3pwS8DLb56bFuA@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] iio: light: lm3533-als: Remove redundant pdata helpers
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

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:42=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon,  1 Jun 2026 18:18:23 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
> > used only in lm3533_als_setup. Incorporate their code into
> > lm3533_als_setup directly to simplify driver readability.
> Minor stuff inline.
>
>
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/lm3533-als.c | 61 +++++++++-------------------------
> >  1 file changed, 16 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-=
als.c
> > index fb61904f110f..52136ca1abc9 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
>
> >  static int lm3533_als_setup(struct lm3533_als *als,
> >                           const struct lm3533_als_platform_data *pdata)
> >  {
> > +     struct device *dev =3D &als->pdev->dev;
> >       int ret;
> >
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +     ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
>
> Maybe a local struct regmap pointer given dereferenced in a couple of pla=
ces.
>

sure, why not

> > +                              LM3533_ALS_INPUT_MODE_MASK,
> > +                              pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_=
MASK : 0);
>
> Andy raised this in previous patch but in the interests of being specific
> regmap_assign_bits() is going to be cleaner here.
>

I am currently adjusting accordingly.

> >       if (ret)
> > -             return ret;
> > +             return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > +                                  pdata->pwm_mode);
> > +
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> >       if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > +             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > +                 pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
> > +                     dev_err(&als->pdev->dev, "invalid resistor value\=
n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             ret =3D regmap_write(als->lm3533->regmap, LM3533_REG_ALS_=
RESISTOR_SELECT,
> > +                                pdata->r_select);
> >               if (ret)
> > -                     return ret;
> > +                     return dev_err_probe(dev, ret, "failed to set res=
istor\n");
> >       }
> >
> >       return 0;
>
