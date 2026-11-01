Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793555763;
	b=CX6Sm5AeoN1ydK3hsdWuVMXfuXLJXmeOYeTagEpgIx7qNUJxekOxUKF507y8ax6m5CLC
	 sJx3zrTubad11PKWa9PrS0YpXbtml0wiV69OBnlFDOa0wvf2HQS195xErxCpj3qHNRJQZ
	 ISSCRX4X/ZhU/n5pKdHb0M+68LGynI/4fxKir43AUqgqenwUg+lRBe0v6GgcBwVufi/RU
	 xoywdSw3kB8GPsT10WoTqzl9jf4XJM2Qgxx3ue1+kQkW1prxFQdnc3V8JtU5DWlnzyH3I
	 e5fMO/kqe7N9hXTd48KZAoJl9klHYITgZbxZCNghZHg5kFafgX/xEF//j/PuYMJ0W3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GoX7Xz5wrKL93mBkqFEu2q61WlbNu4zQ74W9jEnyAOI=;
	b=oRx/xbd9zAYuRrF/ktfR65to36zYLTX35jksimNi02l6kBd7oxr8EmCyRHldVg9QEIg2
	 ehEmT4uyZYucDPIMrRaeaVwYfbZHjuByFFBn66KKIZjd6dyKJDFOa2QogoUy9lgCpEkUZ
	 ZdTSJaD6/OICvkEKb8X+CsW5W3tpSNDUZ9Fwsrw3Y1caB21I21kMvMATAVQlMCSwFD/Aq
	 D/ULMXxnztRpS2WKPTKYkazKN3es3YTV+zPxdNTTlhqRgtbp9mdVCdtOFWFpcVdiMDsgz
	 RDkEQqy/ihPPOdfhjyYsVg4UupjzXWEj3o6zUvqwFyZPWRRXyQtyOZL4Kf5bNS+6LKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xI7Eg+iH;
	arc=fail smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E9E606A326
	for <linux-iio@vger.kernel.org>; Sun,  1 Nov 2026 17:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E9E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xI7Eg+iH
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-369f33df08eso4642436eec.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2026 09:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793555762; cv=none;
        d=google.com; s=arc-20260327;
        b=i7PazK5naBubWHLYIzCHAWA1h0PPakX4z1fACFZYHM1AeNcFkDVl1nznfq4884fria
         TgIE7dMP0acI/3kb5auVu4btYOhRoGIHrSqXp++62CxYnHK+MGaOQMl86SGOzb9FQKOR
         xuJAsvPQ8Tj8ziELBnk4FndLKP2nYEM9Sba80fTRjOf2Wv0GiJDYpHf7UmDdFqOeILjX
         oMWeVLNo+amUWjiVy2C5allKxXYGYI+P2pASyc5R40j4JXq7nR4HG4rhB3GpPpRhGVUA
         tl9tvHittEmbRuUX4R6auD2YMQh0+t+P9ZuD/vXjRv1vmRgEVzB6fQ5V31oaoZtxB8lp
         1POw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GoX7Xz5wrKL93mBkqFEu2q61WlbNu4zQ74W9jEnyAOI=;
        fh=I0eb2EFhKz8mIYRuDgjgo4JgwAcdSFsLCGr0+wAE46I=;
        b=ZZr7tQT/rqdPjv/iP8NpYQ8V3YSzd3BFvEaj75AEAtfqqe8FaIcITGd8lszvIvrzR+
         ImZKIWEhN6pPBH/Oyuq+EpVOyHWUIXkHfCDSXJTiOFERALHA9dU76aFvUKPCq9Xh33X5
         p6pYQVvrEe4h8FgmMDjNetYDL933s1lrLDu0nmohfrJhMNDup/2UkM+UrZqrV/4HAvJ7
         pEVEOT/GDnwqvp5ySu34qvAe3Jhb98XGwRV1NrLOI4c3l/taqr4JujX0zSI6xmrKzwu/
         IIf61nqrHHNr34in+6oOOmzQlY26oSxgzcwo0h/PRRO4Ckq50Gheb2/HvpXWN/r0ADxx
         sGaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793555762; x=1794160562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GoX7Xz5wrKL93mBkqFEu2q61WlbNu4zQ74W9jEnyAOI=;
        b=xI7Eg+iHeR8rPP+5vWDtTL5ybfLa9tfSUe6MjVJlKbjP3y8byZoks27U/XyRJiUKeA
         3APi1BVxzVLn0GiDoMIAt1XFUF4HgOrEIHP8Kg3BqkNBFcgy/B24O2Hdx76f7Xg91Wdp
         6J1oMess/iGYBKKfo7CP9+TpIsQdvaQMxq2aBE7QUFXjJlQgIioX8mL9scGZ8YoRFA2p
         Q+AKFFznQ1GAja7JTHDWBbtuN7P88Bt88vQg9PzQkZs6ZKSu40/nqDfrEWpq4RJ+OEcm
         fA8vuG7ZYRxLFQG2BY8cRbk0MofoQtVbSnrwMBGrUNVFhjz9gO2fJ6xSqZ5A6Pwt5sQn
         wC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793555762; x=1794160562;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GoX7Xz5wrKL93mBkqFEu2q61WlbNu4zQ74W9jEnyAOI=;
        b=GxFsiSaByhe3T9QG4NB+HvetewI3YtmGbKwsDkhyZ3Sw0aqqA9iW224L0GBT6Tr8z5
         foN8DhaMI5q0PLrIe2cRN8W/HoD2FqE83rJ87F3XcVeb3YubYJ8YVzYz/wQ0u+CKg2r7
         /3vH/WEp8hrS8/Ez6nOB1VGVD1jnNqFmTyWNwNG0gV1IxybmkmHNMY398SzBwwuAVfKv
         M5b0FNfq7bQJWMoWUOIAZ6ziMUfmfpNX7D8C7Clr5rm+mb2AB3HOKIHGLrbASkJTT44H
         RxYfvVDDkBykm2pigFHh3dC1oSJGubg5ffmbdohvTmYnu8ymNQPxE5wt6zGyMQyhVkta
         qqPA==
X-Forwarded-Encrypted: i=1; AKwUvBxCxHBAFI6PZjaETuZhkYQrT4TA5GVXSziz0y71iN010sfV2SIE+3/K05zzLgLV0SoJHpGw/df5vhI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Zlpj3TD/a9P7xpVjgTcuO5ZfOj/OXisCm2wh92iSKUpIgB6Lx
	Tp07QvPBdw2+pOUkmA2lu1DhqzTYQS0w+REPW4pQ3eGhu/i8e2+8ig/UUMMX3I+lqeUv1SxAA4L
	Cun5ENNpEN8fKO+hoMjHPUEwIw22FncQ=
X-Gm-Gg: AYBFou0gpBgxqmAzbHbNXRlguHtHzrOSLA8KVdBP/h8h1A05Z89xaEnSMFG7fGEKGwA
	oQsBu3VAf9Z1/R2MU8gM9Lc1sbFUUCr4upyXUFeyeyEg2nEqYm1sTl9LI/QQn/WLaC7Om45Z6Mv
	rn2NNPKtkrC3sIEuj3TM+QOdQXvNm1rN2slkGtkPdhOC0ae0HochVgjxRhimfTVPa87QWCv6BrZ
	p8/tSs9V6VvNRJy9CevJGyw3zJd3D8Rb9LkfDjf4xnM3e/R1EqBOjsKoj/mUhpxULhtOMcf4N2l
	e1lrulbaEadOgw4FWRpVV+g+9CAt+W2tPGCraG/hecso3p14Qp+7dleFazAIaPs8cAcHAExEHdc
	ItUix+jnD5vccBk0skKZP1j6pJ4//8SZuTHTRoPlXiAnsSg4vaA0jWsBLeSFVw1rvG4OBFg==
X-Received: by 2002:a05:693c:895c:20b0:359:ef9:9be3 with SMTP id
 5a478bee46e88-36a4236a466mr11835005eec.11.1793555761519; Sun, 01 Nov 2026
 09:56:01 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101141507.119186-1-clamor95@gmail.com> <20261101141507.119186-3-clamor95@gmail.com>
 <20261101174140.4d11fdfc@jic23-hlaptop>
In-Reply-To: <20261101174140.4d11fdfc@jic23-hlaptop>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 1 Nov 2026 19:55:49 +0200
X-Gm-Features: AclHuK8EZUIy45_qfYG3a3MB3Ax9bYhjt0WTcJl5ffWhhE8QVM-VmOuMMgRylVc
Message-ID: <CAPVz0n25RR-ayBHuvP8KkrYc22AzHT67=nSEZn=hzRufUJw0zg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: light: ltr501: Add support for the
 LTR-659PS-01 proximity sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Pan Chuang <panchuang@vivo.com>, Hemanth Selam <hemanth.selam@gmail.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 1 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:41=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun,  1 Nov 2026 16:15:07 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Add support for the Lite-On LTR-659PS-01 proximity sensor. This device =
is
> > nearly identical to the LTR-559ALS-01, but omits all elements related t=
o
> > ambient light sensing (Even the regmap is identical, but ALS registers =
are
> > marked as reserved and interactions with them are discouraged).
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Hi Svyatoslav,
>
> Various more general comments on the driver in here. Only real request
> is to not copy the rather ugly existing indentation for new code.
>
> If nothing else comes up in review, I can just tidy that up whilst applyi=
ng.
> For now I'm going to leave this on list to give others time to take a
> look.
>

I can address some of your suggestions in this series. I would like to
send v2 anyway since Sashiko found a few legit places needing a fix.

> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/light/ltr501.c | 58 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> > index 302be2fc314c5..5cc1141322ad5 100644
> > --- a/drivers/iio/light/ltr501.c
> > +++ b/drivers/iio/light/ltr501.c
> > @@ -96,6 +96,7 @@ enum {
> >       ltr329,
> >       ltr501,
> >       ltr559,
> > +     ltr659,
> >  };
> >
> >  struct ltr501_gain {
> > @@ -649,6 +650,26 @@ static const struct iio_chan_spec ltr301_channels[=
] =3D {
> >       IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> >
> > +static const struct iio_chan_spec ltr659_channels[] =3D {
> > +     {
> > +             .type =3D IIO_PROXIMITY,
> > +             .address =3D LTR501_PS_DATA,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE),
> > +             .scan_index =3D 0,
> > +             .scan_type =3D {
> > +                     .sign =3D 'u',
> > +                     .realbits =3D 11,
> > +                     .storagebits =3D 16,
> > +                     .endianness =3D IIO_CPU,
> > +             },
> > +             .event_spec =3D ltr501_pxs_event_spec,
> > +             .num_event_specs =3D ARRAY_SIZE(ltr501_pxs_event_spec),
> > +             .ext_info =3D ltr501_ext_info,
> > +     },
> > +     IIO_CHAN_SOFT_TIMESTAMP(1),
> > +};
> > +
> >  static int ltr501_read_info_raw(struct ltr501_data *data,
> >                               struct iio_chan_spec const *chan,
> >                               int *val)
> > @@ -1178,6 +1199,12 @@ static struct attribute *ltr301_attributes[] =3D=
 {
> >       NULL
> >  };
> >
> > +static struct attribute *ltr659_attributes[] =3D {
> > +     &iio_dev_attr_in_proximity_scale_available.dev_attr.attr,
> > +     &iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +     NULL
> > +};
> Not something I'm going to ask for as part of this series, but
> if anyone working with this driver has time it would be good to
> move the available handling over to the read_avail() callback
> and masks.  This is an old driver and so far not been converted
> to that newer infrastructure.
>

This I don't promise, I will see what I can do. Maybe you have a good examp=
le?

> > +
> >  static const struct attribute_group ltr501_attribute_group =3D {
> >       .attrs =3D ltr501_attributes,
> >  };
> > @@ -1186,6 +1213,10 @@ static const struct attribute_group ltr301_attri=
bute_group =3D {
> >       .attrs =3D ltr301_attributes,
> >  };
> >
> > +static const struct attribute_group ltr659_attribute_group =3D {
> > +     .attrs =3D ltr659_attributes,
> > +};
> > +
> >  static const struct iio_info ltr501_info_no_irq =3D {
> >       .read_raw =3D ltr501_read_raw,
> >       .write_raw =3D ltr501_write_raw,
> > @@ -1218,6 +1249,22 @@ static const struct iio_info ltr301_info =3D {
> >       .write_event_config     =3D &ltr501_write_event_config,
> >  };
> >
> > +static const struct iio_info ltr659_info_no_irq =3D {
> > +     .read_raw =3D ltr501_read_raw,
> > +     .write_raw =3D ltr501_write_raw,
> > +     .attrs =3D &ltr659_attribute_group,
> > +};
> > +
> > +static const struct iio_info ltr659_info =3D {
> > +     .read_raw =3D ltr501_read_raw,
> > +     .write_raw =3D ltr501_write_raw,
> > +     .attrs =3D &ltr659_attribute_group,
> > +     .read_event_value       =3D &ltr501_read_event,
> > +     .write_event_value      =3D &ltr501_write_event,
> > +     .read_event_config      =3D &ltr501_read_event_config,
> > +     .write_event_config     =3D &ltr501_write_event_config,
>
> The indenting of the existing structure is weird and could do with a tidy=
 up.
> I'd suggest just dropping any attempt to force alignment.  As is shown
> here, doing that tends to lead to inconsistency over time as a driver
> evolves.
>

This I will address as a separate commit before adding ltr659

> > +};
> > +
> >  static const struct ltr501_chip_info ltr501_chip_info_tbl[] =3D {
> >       [ltr301] =3D {
> >               .partid =3D 0x08,
> > @@ -1283,6 +1330,15 @@ static const struct ltr501_chip_info ltr501_chip=
_info_tbl[] =3D {
> >               .channels =3D ltr501_channels,
> >               .no_channels =3D ARRAY_SIZE(ltr501_channels),
> >       },
>
> Another nice to have but not a request for this series.
> Would be good to move away from handling these as an array with the enum
> value in the firmware tables. That scales badly and runs into NULL check
> problems when we use the generic firmware accessors (which we should real=
ly
> be using here). i2c_get_match_data().  The standard way to do this
> today is to use separate named structures and put pointers to those in th=
e
> tables.
>

This I will address as well.

> > +     [ltr659] =3D {
> > +             .partid =3D 0x09,
> > +             .ps_gain =3D ltr559_ps_gain_tbl,
> > +             .ps_gain_tbl_size =3D ARRAY_SIZE(ltr559_ps_gain_tbl),
> > +             .info =3D &ltr659_info,
> > +             .info_no_irq =3D &ltr659_info_no_irq,
> > +             .channels =3D ltr659_channels,
> > +             .no_channels =3D ARRAY_SIZE(ltr659_channels),
> > +     },
> >  };
> >
> >  static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8=
 ps_val)
> > @@ -1635,6 +1691,7 @@ static const struct i2c_device_id ltr501_id[] =3D=
 {
> >       { .name =3D "ltr329", .driver_data =3D ltr329 },
> >       { .name =3D "ltr501", .driver_data =3D ltr501 },
> >       { .name =3D "ltr559", .driver_data =3D ltr559 },
> > +     { .name =3D "ltr659", .driver_data =3D ltr659 },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(i2c, ltr501_id);
> > @@ -1645,6 +1702,7 @@ static const struct of_device_id ltr501_of_match[=
] =3D {
> >       { .compatible =3D "liteon,ltr329", },
> >       { .compatible =3D "liteon,ltr501", },
> >       { .compatible =3D "liteon,ltr559", },
> > +     { .compatible =3D "liteon,ltr659", },
> >       { }
> >  };
> >  MODULE_DEVICE_TABLE(of, ltr501_of_match);
>
