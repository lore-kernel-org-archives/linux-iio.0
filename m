Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D836683C
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703391; cv=pass; b=S1Z1fJSOSE2i3PWXaeE46wQccuZIGeW7cVP929ht2+MYfqvxDyYI4k5eGz2ineR9aqp/gV+3HShZ2TJu8rtTDx2x+c6c0Ge1i3BqQczCyKilo9lVJtbEroYz+zhUFnNhHhjJUSMQdD8FygK4Tg3MSNFVq4EZdYZnSayCnUHGo+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703391; c=relaxed/simple;
	bh=ns5fGiC0AYx01alvS2oyann/aCsQD5fUZd39FTFQ1v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1lyF71JY+kpCYQuYAJKCzXXsTxvNei3u0Oq18Vf5wWbijdpFsReUPT3okTMnSeLy2X2+NOXmO7dHVgVQGZ7jARsiWAgimvmIdhwLB7V2ULCiD5mcQW99iSm65vmGi6KzhK/KFoeo83ZnR35aiXMN1Geoc7UFFkJm/st6gtEfqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp3MA3Li; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp3MA3Li"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65f94011dfaso398424a12.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 01:36:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772703388; cv=none;
        d=google.com; s=arc-20240605;
        b=l2V2qss434jv332LER+i4iVX8C6uy7y80emdkavIf66J0dqqdcIaf+1QSkj/WY7UkV
         mR/eQF7ewnZfUam8TuieoOOx7Quj2TgE9ymGTMwTC2HNN9Of0UpJH7miHSj6MtApLlHD
         F00V39xIEJL2ow7nkOZBmCWlgcPfP0rF3SB8k03foinYSHg7ts1BRI77V46RVpzYT4eQ
         lxVdILCZTfFMYJ0GWDN3vVEIWHIgzcUKxJuBAazH/TwxYbmB+nbdTbiWr7yZaFpj4HMF
         Fob4tNPVIiBe2wzsCqW+7LhGfsquKi3scQgLi7gK5KUuYu4+eialgyE+ae+qPaty0nhT
         11+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qF8zSNFpd6CCjIeHA9Ut11aCaJT8LbhyBeaFklmdFmI=;
        fh=nvnwAC0bK54PzprKRK9LNqkfLVHAClGqt3/YzZ+rZAo=;
        b=AJrqREcI1lWWin6fi6gKpPTU+8Z15hT6+iCXfnGFVXlAoHDfCs1AbV/rstR3OwbRpB
         /n9kBHqAEfIuxvMj71rD634hsy6YFW9aUiGZGC1UpqgHXX/Rt4ZhUxc/tMX5Ou8MdoiR
         P/j7+ouyxqj9knhWlNpt6neFMal7xZPIVa99PTaNjMnSdLoR5MzMl5t2rpCv0HpsVQ1G
         NB87taR/zXv8KwwHmUGJtpKb2TCRT3BE+vOT7N/lxPFd17nPt+xSfdXyhFYL1oUczcTI
         +z9MnwN+BsRS5EOI4ibDOI2cSS+Oq21fH8ca8Q7U3t4i+C+bNnXaNZ8In+z8zvkVbR9P
         9HkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772703388; x=1773308188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qF8zSNFpd6CCjIeHA9Ut11aCaJT8LbhyBeaFklmdFmI=;
        b=bp3MA3LiZjt8Qsdx5MBrN6K6ero3JsBvkwQHfs1P2kirPyTVWSUFKFJr7PyNmVcsuL
         Gnt6Ju8nZA23eDuhoZFNQdxLuW6m+NVc4H3HM1qBNZkszdzikKKjFp5lk1JtbCSGqJx6
         Gc8+mpPitntDghwVWqa7cf+1Cs2CAmFwcglrUd05Iu52uHC7llvMe2IZq9CDi+zGqw+I
         a/sbzcbIkKW7ujqje1/WtRSGlRPERv2YrVauzC+yk0hk6b9d/fuG22tLvdG9pDKaVCSh
         x2HpOYu5fok8/m9Yos1aV+hFBJXuTs4o6dSPoaltbUCtPK6D74BeGRhZ7ZSpRHAlFaGT
         8uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772703388; x=1773308188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qF8zSNFpd6CCjIeHA9Ut11aCaJT8LbhyBeaFklmdFmI=;
        b=PxN9X3RAbYkqKftjVrgMB3RVoBfVkQjKHW5jd6LEbQ00WC7hkfTzCprLrG8RNxa65p
         MRy5IKnaqeBUEOHYpWT77zfkd1ol91PszAl3ZhbTAzVK3nvcxRI0O4kPcAQqAE68PnIz
         dpEy1l2VfS3yyYCOuQXWPBtKg+umc2CXirgsIOGwVonRttvsB+lCgjYRDlT2lWgYlSXE
         UGpHtkUCSlkJb6V5nUgrcEKTCSdNz8FjlcwtMW4ru8SN4oxR4pER8sVyeYJi3gZOe15U
         zurfeXmhxQsNLWheFltxwKfNpHUSQGWeHKFrCIrfTaUcqudnq8t5plG+f0g1YWkM0B7k
         e//w==
X-Forwarded-Encrypted: i=1; AJvYcCUBrNWiIgq3dxcT7QW+lgA8WgAJLSwbPgA+rW1eAWJxPL4/xHsUP011dWKEGnDaTd+TZm1do6PBSLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nPqV9RdS5M2Dz5ixOAmUx9WDyA5nVy5Uk5NPROYeMMl1DHJp
	UjL5hmWKT4Y8sjHTjiD9noudsnHcxDrwusmXPSa7aXclKretoRrJTf91NGSWzooF4y1uKUq4aRa
	8I5ui7+SQpxMKW1WzhAqFsA3MWajSCyk=
X-Gm-Gg: ATEYQzzMjAEPUC1i4Hn3o+Whi5StlZLu/ePGZAaIJ9L6rVdAf2QIWLofYOVlKadnMbt
	4wD61HDhL4ViDIM8z9pJm1S41Xun2c2NL8FVovFLT3C50qTKe2lMwu3spLBfU/m8FgOxQbRg2gh
	8YjeawA4zoM3F2q2aKONmTmv4Ho9ORHnf0nt0GLhU0W8Dy8RD8appA9LqsADgnVnDHqNhrCrwap
	FBhkDeb6kQ3TffSqT6KS/PVzwb04C1Q6yP2A8qCW/b6m5TzyQSGRKsJtOVairua7/72htDhufhY
	IBsMFj04qUVSIeqU4AHSoTCrjYZ2qeNftV2fZ0q6Sa6rQKHbkDMnFcoAAAp/ajxGMWAb6UIaUqK
	scFhx1n4=
X-Received: by 2002:a17:906:f58d:b0:b93:5c81:5e16 with SMTP id
 a640c23a62f3a-b93f152c076mr316792066b.43.1772703387679; Thu, 05 Mar 2026
 01:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305091448.32052-1-antoniu.miclaus@analog.com>
In-Reply-To: <20260305091448.32052-1-antoniu.miclaus@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Mar 2026 11:35:50 +0200
X-Gm-Features: AaiRm53NzrUIPFWl0RRZ2DL96mMHvSdBy5mDLjymcJpea0Yk00mapYYelkhuSAc
Message-ID: <CAHp75VdHz4SSyA78VYRvHrgUxGFAC6HeMmAuoxjS1twsTNTHkw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: frequency: admv1013: fix NULL pointer dereference
 on str
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 11:15=E2=80=AFAM Antoniu Miclaus
<antoniu.miclaus@analog.com> wrote:
>
> When device_property_read_string() fails, str is left uninitialized
> but the code falls through to strcmp(str, ...), dereferencing a garbage
> pointer. Replace manual read/strcmp with
> device_property_match_property_string() and consolidate the SE mode
> enums into a single sequential enum, mapping to hardware register
> values via a switch consistent with other bitfields in the driver.

...

> static int admv1013_init(struct admv1013_state *st, int vcm_uv)

> -       data =3D FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, st->quad_se_mode);
> +       switch (st->quad_se_mode) {
> +       case ADMV1013_SE_MODE_POS:
> +               data =3D 6;
> +               break;
> +       case ADMV1013_SE_MODE_NEG:
> +               data =3D 9;
> +               break;
> +       case ADMV1013_SE_MODE_DIFF:
> +               data =3D 12;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }

Oh, I haven't realised that it can be done like this. I have in mind
just to have a switch in the probe, so we don't need to do that again
and again. Otherwise looks good to me.

--=20
With Best Regards,
Andy Shevchenko
