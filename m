Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76E146D5A
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771778352; cv=pass; b=i/8k5G2yNXi4rP6MCdgECkTDaJvbb2d96+2Xf3ZoA8Up8azSGCH6bCQcK/V/qw4YI4YmI7/9gjzeHujsWfmZMMQ5wpQfPG460EJIMqWPF8lvYR1pghCoz5ioDDfVglalwMjtJiB7qn82G4n+w2opng2oqkketRr2qhS5QTz5WCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771778352; c=relaxed/simple;
	bh=UeMOebiK4vIzIH6sr5LrUxM0IQtL2VpgGBjNa93On4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRl3HDyseq0EQJ6m8iW9zUk+ivuHjqdCuqVN1quN+P20ib/WYB/N/B0Sd6IfA1z1mzkHe9TcePkkw9yTO88sm3uPqiVjig6akEwRN+3sepbmEUc1jRpGpOMa2GviwKOxwcYPzoz7EMyq9dkN29XU1LvbtnmzaqZ8KywDV3+67Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlZeUtlA; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlZeUtlA"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3543b9f60e3so1560347a91.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 08:39:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771778350; cv=none;
        d=google.com; s=arc-20240605;
        b=Zl+jlvc5ecvSy0Bxb2+am1YNx07UN4AAT8GtutYy1LbBWxJj/JhsixxN2qcjoiALly
         7c78ivTzJROLIoaCm9lTfPY5yCo5bveyyg6BUDVpcnFnQ8/Yhyn10CWPACJX7mlKUMvn
         NgA6PpOTNkwizxsmB5sCidU6u3AJ/pRVh3Wle3AvEgu+qTdnd14ojPgigm5qOtBo1sMR
         iisPlDB6OKu8yo0Y4MzsOHurcyu/xx6hPCS9hrgTKPaWtYLE/oYga1yzi21Q3xyCyaBX
         w3MUE2jRv6BJwScV4AaSCaBI1K39IBqTjB9c7UVPKXWmBzZMnYXNuGfAHQGZC8kTB5gw
         YUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C16GUVSHt9nUQiD4PUkOwn6PbPwM22JJLcoRTZicU1I=;
        fh=nEwZcQHE7TmXt7l+LNDK1fJBaMEbshiEhTcSFQlHsms=;
        b=kBMoBVhcSGX8VIbEP8LNWTt57eU+WRYoWsjs6ePOzhPYmj6Hc95LouVMmJEy73bHV1
         JgnfK37Y+wou9CFaDj21XN/nTDGO+ull6uFYk+0mbo8u9kkfMVKnktviG95D0WSpQjwV
         aZz680ZDObc4AMnPRd0A7x9PHLXOz9Cq5vrN73X0I9HVx83P53Ld+rnam2NHUvLWNiFr
         bbgu1Oibkltit7vad4WTBA9fTnJI9mb2jO8s2sE5wMmf9T/uDbBb+0dacf4Q9OP0aArD
         ezE8YtRxcReGTJsZOLYVGSOAyUEBX3+cxe+UUJg5/U6MZhzueIDWxXW61G86lw/jcyoJ
         zCOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771778350; x=1772383150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C16GUVSHt9nUQiD4PUkOwn6PbPwM22JJLcoRTZicU1I=;
        b=RlZeUtlA1F8EBWlC31GvcWCg9t7TpweqB6YPnd85pu5OA8C/10Qq2Z3VCR7yrhadfq
         tG9NlLgz9JR23OlX60v2/gKrOOndfs7fw+KFHEqdbeYjWxkZccuy3QooW1mazVUiAGIt
         KlK3yveEtrxdq05TiouP4puahmoGcqUTYOVrDRCy8T2xVXItuJX/CD2VoB8s4b+VtygB
         Sr7e044BJajquDgna4+kVxV4CPulgo+MhnrduqTgA6y5iuCM/IN80flp36qpiz/0HT7W
         H+ET/4LRFPu15f07cKuBDSK0eIJw3nq2ndAxuyC46sSKcB5tDHKdGTPozr7bhmG/awMJ
         6umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771778350; x=1772383150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C16GUVSHt9nUQiD4PUkOwn6PbPwM22JJLcoRTZicU1I=;
        b=HEfzmu0LUkbymDSoWO7aCnQWbqM6hs7TBDE7lnZtis178Yi7NCSMqzoIvsJ9lbGurf
         PyFXEcSKQOaNkUOn382ItDUDNTUR0Lv/Kyw6B6RwCk75eIPbu0+r4eWBPA4HKbebTsbZ
         onS9GXOKtloZjwt0+PLp48OGXsoNia86LnGX1SjnCJOfDxA7xRjb7yuMRsxT1TvHOxW0
         92SpSw3FyBuUcRcAxA4D+R7h//PbewxnfMdAAOwFZYvUzhXOOrlHaSzsTpJawSxhmBhk
         RllqxdxPRnww2dqPCZ1j1cfQ1YHbOiTU/vZh3TkuXkgpzoyaJbbmHiLwVo9mOyxD0E7+
         477A==
X-Forwarded-Encrypted: i=1; AJvYcCUF5VRHgmB2yBFzUT0eTKARS6GcyrLQJqkJK/i7pVtgbA3pgqdPerv+y2JkDY61t1/sbjA8/M004Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97Cn5HP66H2OamGyFCKF1yd8VOAXQLd65NiRGXl8Fq34lx7UR
	RPTt3WzjGfFhHZ3lxoBQLvaWFHp3S6/WEqQEERAABK+NlGA6l+to1qqxLbjHBvvnSTsCSzHVBwB
	hRX56b5YShUwfgvDfD11jDK8CF/7mn4u/bzl8FtuLvvCt
X-Gm-Gg: AZuq6aKYAE1RvSk+qOI08t1lCkDyaaqplt0IwFCF+bg2WNEuQJKNBzvi9wnjjmeGPAF
	s3XIaBzZybMzW2/6m11GoWciBgHR9dYnoMuqxU4r7lkl4ADlRZz05YQTPKufx9yrICqur42FgpH
	WdgGA8w4RilBEdAaiyV35qmKvqYfWYPXSh8diUneEzDpg4Ki2BaAfFE02wljhxTGhQskA0L0djT
	FcAhnT+5ACGrSZAVfHAtR6ryn3UK5G7k5yzm70z1QeyR95JG9CZ3t/ubAXcEievlDjOCcmqHVaw
	6JRyBo+x
X-Received: by 2002:a17:90b:3d47:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-358ae8a45f5mr5562629a91.16.1771778350153; Sun, 22 Feb 2026
 08:39:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222-nxp-sar-adc-v1-1-75e4cdb3ffb7@gmail.com> <20260222160325.1e4d1f49@jic23-huawei>
In-Reply-To: <20260222160325.1e4d1f49@jic23-huawei>
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 23 Feb 2026 00:38:58 +0800
X-Gm-Features: AaiRm52ary1C8mt0M9Z8RyfeRL8chY-Alm9gBvJl_PqID-KEtboDY4ioTv1wyCU
Message-ID: <CAN4SLj2a9o_OBe-5AAbYKwaUpJrU17XBRgbJFt7XOOeBw8-UMQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: Remove unnecessary type casting
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 12:03=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Sun, 22 Feb 2026 02:09:08 +0800
> Felix Gu <ustc.gu@gmail.com> wrote:
>
> > The readl_poll_timeout() macro returns a signed integer error code.
> >
> > In nxp_sar_adc_calibration_wait(), the return value is casted to u32
> > before being returned as int, which is unnecessary.
> >
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> Hi Felix,
>
> Make sure to include the author of the code you are touching in the +CC l=
ist.
> Added Daniel.
>
> I think this is simple enough, so I've picked it up now but I'm fine addi=
ng
> tags or indeed dropping it if other reviews come in.  I'll be rebasing
> or rc1 later in the week.
>
> Applied to the testing branch of iio.git
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/adc/nxp-sar-adc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-ad=
c.c
> > index 9efa883c277d..a6e4888a8464 100644
> > --- a/drivers/iio/adc/nxp-sar-adc.c
> > +++ b/drivers/iio/adc/nxp-sar-adc.c
> > @@ -247,7 +247,8 @@ static inline void nxp_sar_adc_calibration_start(vo=
id __iomem *base)
> >
> >  static inline int nxp_sar_adc_calibration_wait(void __iomem *base)
> >  {
> > -     u32 msr, ret;
> > +     u32 msr;
> > +     int ret;
> >
> >       ret =3D readl_poll_timeout(NXP_SAR_ADC_MSR(base), msr,
> >                                !FIELD_GET(NXP_SAR_ADC_MSR_CALBUSY, msr)=
,
> >
> > ---
> > base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
> > change-id: 20260222-nxp-sar-adc-1906a65ce5b6
> >
> > Best regards,
>
Hi Jonathan,

Thank you for the reminder.

I used b4 prep --auto-to-cc and am not sure why Daniel's email was
missed in this patch, as it was correctly included in another patch.

Best regards,
Felix
