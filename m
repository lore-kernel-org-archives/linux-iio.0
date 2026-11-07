Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794046520;
	b=vO7iSZvVAXaxNeZawtNMU8Bu8jYvU66t7MMF3Ym7Zag21vgSgTa/dljBpCE+w6YeuuNL
	 qJVNX8c57gCiT8S4Bum6l20jg80I1AMRCM5oE9Jy9HOjtSgoB76xQiIKc70veSrTqtgdx
	 TsvSMKNnuzKQuIEhF4FAfVh/mP7rAIwfc1qgFLTqVmbKDBGWnJdLB7zSLfVmB7SqarLRS
	 zdOHVvt4x2rM2Nhm3kCv5byGt0D/ZTyeN3a/gjACAogssU6v2cPSLwI7Ew1vLQdJy+oPY
	 ODbhY42hqybuz+8FdIUBxWp3alU0nQU1JX9FOe3tarphrk++x5nSBt8u+uGUD693/dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SfEg/fc/vfw/G9raoRVqHQ8kPtY/AXMaqrz2jbU8BRs=;
	b=SYqB6S7ZvaBK7AlDt5KM8CM2Jv7hO9wkRIborP7jamAAtYH/BwaB9gZwAo0djbTdYMka
	 O7MDHYHmsWZuRN9Kj+vsTmN30v50wk6kFhvP1m/Zqe4sHbEy9hvnmOHFUZSvoGc7gYBi1
	 2vefYMMIy6Ih9yNov+d6JyTThQmAqLVYWXvy2laxqRwMYV/wVHm/I1rWt/0wM31fsUhCZ
	 1lbNPSMIwcrrAYFOF+J40QKl6i6WLCSq8eObtgUI7d0QLAh5u9Lzrfp3GOkBagCYzjZoB
	 WEbDgjsVujAAr4tEWj0CMyC24i0o5TFKVlSedxyR4mf8ZOtZNWYnnCOcqOKqGObR1Lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BW2SPxge;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D602606A331
	for <linux-iio@vger.kernel.org>; Sat,  7 Nov 2026 10:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D602606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BW2SPxge
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2234372eec.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Nov 2026 02:15:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794046519; cv=none;
        d=google.com; s=arc-20260327;
        b=Pg1xSxy81TaQcqFuuDdKm1ynFRbUH2lrlNSQkYvHF265YVtT8lYIalUGV+GpX8a7jM
         F3pK1wnvVdhSO1ut1WppXDHgargqBWGnQmjgoH6ed1kGRxfO8YLp7yoUk2I61lSGqUk9
         jA85lnOO3Jt8XsCLbSRTNucnqJDJUh3BSAeDITtZ1OYIWQFaYuCL/JfstXwzP+M46BoG
         yH0jqDeMKNx7Cv6KF5iK19DiV9sA4NynvWMqDI77BiphOxx4P2ZUEFwrS78U6HgU2Sae
         IjyoJwCteNX1jRozvNQ/Py95oe6XTjiSbvawiiheBoRGqU4hIt/JSJ1wqIV0T0Xc6e+Q
         TA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SfEg/fc/vfw/G9raoRVqHQ8kPtY/AXMaqrz2jbU8BRs=;
        fh=8KPWxJVT/pSNOY6QvocFLPNtyMwkk218ik3yt40GPtc=;
        b=Zcqbz/Nc3/GOT9FqyhQkkDiXvkJ4ZYyEmOp6ABfpr/7DgsfPTmBxN0ATa7dCGRP4RU
         0cVb1ymYEatEpZdbIf0cYqTk2z/fr1vryJsY38wEKxbTZuTvRQe+BhemcGY5q/NTE1oR
         TbBpQhctMpS7eD6eJdpojylmiTuaQHQewiJmmWclt3SjrYHRMKt1KwbijJ1K6+/mA2k+
         42zpM+XipoNMC0rOuN81yeekv08XeUWJRoahBiKheJ0FUjB6PWWRSZ+KXTfv+/BGida7
         p6dj92pTJ3VErzQm6uVQX7SMjaTY1IafjrZuP1XFR2NO14IbnDd5+cgBm3JUNyUbM/Np
         ZQDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794046519; x=1794651319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SfEg/fc/vfw/G9raoRVqHQ8kPtY/AXMaqrz2jbU8BRs=;
        b=BW2SPxgeH6GNv0llAerKRF1J0sLqceoIo3AJWiCKAq01ctoZFx1dIHkyNR+miSJ1YS
         66Yg3/qBz0XtbZocHj1+EXVJWBJ/tGJ9wIZsxuxflZJRHYmj8wcREpnghANefDuG1eT8
         SCvPnaoIDkZ7m65u+6DORUIN/71ApWO66Fc4BKeyuGurcEsoL6zQfANXeqW9zBRQrJ8p
         GkXL/nDORVdfzlUIMzeImv0HhV3htj1CNgA1KoL3PN99ucyzCNsyv6NLbLRqa84lxKBj
         1ReR8oAlxSgNmukJbD9NGTUPwLFj2zz2N3iW1tsfDQuy72jWlDB/y9N0FVfooY+JR6Na
         QO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794046519; x=1794651319;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfEg/fc/vfw/G9raoRVqHQ8kPtY/AXMaqrz2jbU8BRs=;
        b=AG2a/skIzx86QQXIDZSltEArMXgKdhf9Riln+td510SEI00hMdFbgWiwNuKbO8BAn8
         67z0oVZ7+whwcRhYON/wkL1PH/q4NzRphcBRYiNse0TGQYC/Us2KDvjuVe1MYkgYOnEM
         85Uo43otnIDhiTnqeahg8a8Y8+fdFSGOQOUFxXYREdoHP7Tv6eiEeFXVKhB6er02nnja
         E9m6Tw9OfshAEVH6ZTeiQbnrD2dvjcQuMUotr02tgL/oIC06SZbZWcZD/52XMxq7i0ow
         ZP1+YY8po7JCzNSGWwQucGb+WyKLRCXNxMco+TzUoH+3qhAZp84ITg783yUuQoE3ZqvV
         gQcQ==
X-Forwarded-Encrypted: i=1; AL+hErGQyIPnGGXUlo2JsZX9+LYtlnxPzEJrY4K0e7UIwrQR66QyeRzfnLxoQnMLksO7EtmF78aUXYilAoU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rbxmjdbRBBBPldHbM6uAfVDcQJ5oKfsabEoZO4+/ir2JbfvcE
	H7Ugcm5mJ/L1gwnOoCov5o6vUoWN/xJaveWqGC5fy8BvPOv4j1EwIBWIFjyGOUCaFjFy7maVuUd
	zm9zUjYYX0Xw383S7mFIU6aCqboBKSwI=
X-Gm-Gg: AYBFou1OdcfZ7MVhqITS/hJzM9PxssNHeigPj/DC/n+PXEp1mCOsg2ShO6yXPZ7PGP7
	upfBxsbVFYRa4YOv5a/1qoEs7H7hiRvvxjxO/HM4a0vDWKMrP04pVYacSXzDVV/Kq988Ni1MHfD
	Bll3+q2bthb5ZqhKuuIbvtIDhCYvxgRifbMjHL+IuQr4VKQTXTnTTYNDpcZuu0epPctzlCAGxVE
	mGyZM6xxCE457wdO2hYRFgdta2dluM3maQEsvz4aT1xHsCE+/PaltEoWK0Xj7JDmwOGjLV4fo7i
	JZBDc2DgHA+QjRA+tlE+fi19PKr1ZstklId8h+Fs4KHb8n+zVhFfGEW+eTnhrPaUMNgBKfzkOQ0
	dX0oxn2mMKZBCWjZDPkspT10xvbgfUn38gYoD+7OLBT3jaFHW+XVZ1P+CKbsi4DPcUvRqpA7f1+
	bYxL2w0sPbqTSquiJwzEo3+pqN1TZQcg==
X-Received: by 2002:a05:7301:19c:b0:36a:1427:3933 with SMTP id
 5a478bee46e88-36f76118d3cmr6774338eec.16.1794046519121; Sat, 07 Nov 2026
 02:15:19 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106091943.35783-1-clamor95@gmail.com> <20261106091943.35783-5-clamor95@gmail.com>
 <20261107033340.64062192@jic23-hlaptop>
In-Reply-To: <20261107033340.64062192@jic23-hlaptop>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 7 Nov 2026 12:15:07 +0200
X-Gm-Features: AclHuK-zTWTUAmCD08h0tHSPAfGIz6D9Rp3d1t8XRONo6MH1Z8w31tM46bHSFks
Message-ID: <CAPVz0n10N6PvBC5AL=nT+fUGsONtuzTZvzSYqAXP_eWWb86nuQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: light: ltr501: Add support for the
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

=D1=81=D0=B1, 7 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 05:33=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri,  6 Nov 2026 11:19:43 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Add support for the Lite-On LTR-659PS-01 proximity sensor. This device =
is
> > nearly identical to the LTR-559ALS-01, but omits all elements related t=
o
> > ambient light sensing.
> >
> > Add a no_als_support flag, similar to how no_irq_support is used, to
> > isolate ALS register access for the LTR-659PS-01, since ALS registers a=
re
> > marked as reserved and interactions with them are discouraged.
> >
> > The ltr501_trigger_handler relied on the scan index to identify channel=
s.
> > This approach is fragile regarding channel status flags and can break i=
f
> > the index is not strictly set. Switch to checking the channel type
> > instead.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/ltr501.c | 73 +++++++++++++++++++++++++++++++-------
> >  1 file changed, 61 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> > index d5ce6468a229b..e7762115df913 100644
> > --- a/drivers/iio/light/ltr501.c
> > +++ b/drivers/iio/light/ltr501.c
> > @@ -151,6 +151,7 @@ struct ltr501_chip_info {
> >       u8 als_gain_mask;
> >       u8 als_gain_shift;
> >       bool no_irq_support;
> > +     bool no_als_support;
> >       struct iio_chan_spec const *channels;
> >       const int no_channels;
> >  };
> > @@ -192,6 +193,11 @@ static bool ltr501_has_irq_support(const struct lt=
r501_chip_info *info)
> >       return !info->no_irq_support;
> >  }
> >
> > +static bool ltr501_has_als_support(const struct ltr501_chip_info *info=
)
>
> Is the helper bring enough value?  The !info->no_als_support
> where this is used seems clear enough to me.
>

Noted, if you are fine with !info->no_als_support I have no objections.

> > +{
> > +     return !info->no_als_support;
> > +}
> > +
> >  static int ltr501_match_samp_freq(const struct ltr501_samp_table *tab,
> >                                          int len, int val, int val2)
> >  {
> > @@ -656,6 +662,29 @@ static const struct iio_chan_spec ltr301_channels[=
] =3D {
> >       IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> >
> > +static const struct iio_chan_spec ltr659_channels[] =3D {
> > +     {
> > +             .type =3D IIO_PROXIMITY,
> > +             .address =3D LTR501_PS_DATA,
> > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                   BIT(IIO_CHAN_INFO_SCALE) |
> > +                                   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +             .info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE=
) |
> > +                                             BIT(IIO_CHAN_INFO_SAMP_FR=
EQ),
>
> The sampling frequency applies to both channels here. I'd just make that
> info_mask_shared_by_all
>

so IIO_CHAN_INFO_SCALE is separate
and IIO_CHAN_INFO_SAMP_FREQ is shared_by_all

Noted.


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
>
