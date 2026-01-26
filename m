Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C732E72B
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422484; cv=pass; b=erwEincuiAGnze0MoY97hRHXljSy/BATMoulMfOQbpXQJOSD0l2mS8fndJ2Z8AsrP2TdfQrYkBzAEiBjqHT2twL0DmaxX8wNjvYhtyeA/cQqIC7zkdbFoHehHQmmiB+EXFgjbD+v8UYI7RFmFpuF/4cyNVSeegLg96rAWXMHKww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422484; c=relaxed/simple;
	bh=592arfCzKGEEI9SsaoPXnjPAToUssVCz65hbUHolUeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdJWo80EeSdqmxtqQMFmrQMzaQEhmeA2uUNrgcszJW6E+LdOaRZFsko0ydWJLFViOEOJXyRsl5Wnniwqb+z793eEn1fZtJlvRkbmvIRabHJ2wCn4JF+MQY2r/hN8oqIjwXNl25kxbKbfEY5VEDvVUgc/s56d7zFe45GO6IvhpW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSQ0iVFX; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSQ0iVFX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso43089695e9.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 02:14:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769422481; cv=none;
        d=google.com; s=arc-20240605;
        b=OCERBN/ruuDam39jok4goGrCYKFBtyCG5OWxZsA0mxBl7UjdqZ4QvmpuSnDxo7Gjc5
         8QnXd1gTYUSE/gpifXXui95vJ1T/8N6cJA5U9jo1pxoSsa/Gi31r2Mb0/GN8TqtSPd8a
         Kt4GzyUe5Bk+J/r9eXodJMP/vT7ETXsfuHbfGFnejCl1Qgb6sYNK6okNYFb7WPKLYtQp
         2irsm2tcjIbEFrI+1AVzQIxay5M4dYvl5vkC/KfMphyiWO4H9sm/ZTC87nKJ7ZmOMKGk
         X6tnNi597G3yGngwNPd+bNOMmMu3NdNDLWRGflbu1wW+Sjj3EM8QjCCQ69BK5DStF5v0
         E/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5fg+wculjolsM/YfIrc/6Q4VkgefoBAjkv+6Ml7KMXI=;
        fh=0E+/no4PvaEOqPCqFzDYYMqcs7MQzzfjNgXJOsQ3pB0=;
        b=ekCIFYBu0OId+kWrUQ1RNvoRTajNKuHVMGvkkBKtc8oKGkZi/Swshfvqa2og/lmaR/
         sYpjIj1h0N70Sdeq0ucir78sQTOBT6V3FffLtt0LXQ3YSaycbU7d44uM9rSVdA97dEbg
         1o4xKShCiQO3Zj+5ouQYuQw5xPSQSoKfVmLIpJe6IoIvftVeJ19PHkqpmUOPvObelesC
         EqHs47+mw8s4RVNsU1xG2VgXfMS6ekItXry7LJ9BdarEJmr6G4IKPr4lkEuFwGEleGrZ
         HVvyIs/C/wsfAM8RyT9xISOx+Ip1iT9HdJ8Dpk3iiF7sM2FyCgdGwpBnZNnYZjLr8FmZ
         34Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769422481; x=1770027281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fg+wculjolsM/YfIrc/6Q4VkgefoBAjkv+6Ml7KMXI=;
        b=ZSQ0iVFXMmjK/kc/36PWwYn4SIrOzwzn64dBLWxLogB/IELrzncsWDA2xmecOprrql
         XB02nP+PMTjnLm9+7uQWvkVWfFQuFyJHqwnyyOLewAUvPrxlZ35sX6hdzEHSJJ35tfhy
         GToGY9njBZgbwQmlJnAysa7a9cKAExGnzIgRHVFDt7HTPd8aye5R3dKMj6SoCP9h4nKR
         KjG4ouvwKNB/XLuganokKzr4Sks2DKsa1Wdtyj+5BCGndEPt521lm3uJR1lEjqVWvIQP
         AMUC3K66yaytIOkv7DztJ5qn46kpw5Y220aiMyHvs5louFTljILfK6LpFWjcyNfRmcvM
         Hxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422481; x=1770027281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5fg+wculjolsM/YfIrc/6Q4VkgefoBAjkv+6Ml7KMXI=;
        b=OuVOaE92qwys4mkud7VLf4pcLlwCB9DSQ+8aPJknnEHg3CjAWJ6aSz36WyvXzgIaDy
         N6HLpsLU3AfXs/p8JLl+Oqs3katl+9TeQbEmEB32zjXNBClKLEebo3XLQarDKyzGkGo/
         LK7Dr9AJgxcbjNKpc5h1cCj2ttBbOVgXG2flazpBAjBzTb9sSm8XQXSUSWrq2rlwzwVb
         FmR10ujhK7VGzNO+4QGxrZdmYtuEKvV9o66fdr1S6aAt/0Npb69cfurfp/L26t+cILnK
         XZbzpT3pyLSRyO4UJddzGKy2+be8u6wV71CupNv8zo/5Uk2CwuAWtSoh8yA9hvgXG8hV
         yrqg==
X-Forwarded-Encrypted: i=1; AJvYcCWXSoRfZUwXPRG9LxdTJkTLJodujX07scRR3V0pkXOV9cpdKP2e2dIu7+6AL5qhQxhjYDEW2LoXiN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf0Jbi8Ib3VPsWw0AfcK4u9FB7UFORXG45ODWNJXRdr+dMWohO
	N6+ZKM1OBXgXzbvn8PzzQ768M2Tcd2gAlCrW/AUta8jmo9K7Vt2vEJ2D6ZEwwKqKN6I2814neAf
	3svO7Wl4TkYT6Gp3cP0B4Xt6eLIPK5UM=
X-Gm-Gg: AZuq6aLng7B/vDVYcJkRAfQpXqTtxp05P4e1UvL0Z5hGJtktggy7eCKO4E3X3HoZww5
	8q4pfUfIa0AoUKGXo5Amoas4XmD9CgFjAslF20h/cX9Cjl/tjk5wag6knZ13ra0cgiG2n2PYG5R
	LoSovWewDTT8p9KcDwZxMGJPvPNsVV0YY9QtoVFJYvIoFoGVMXP9jW0srxXMjgrSxLCgzAnbVsu
	iOaoR4dilj0MExFrZ88jJA2AEcK9yHUO6IDqJ+rTcL0CrJ+0q0eUuHbqpizs/wuSuSdTgLn
X-Received: by 2002:a05:600c:5494:b0:47e:e78a:c833 with SMTP id
 5b1f17b1804b1-4805d064297mr63059575e9.32.1769422481165; Mon, 26 Jan 2026
 02:14:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125134302.45958-1-clamor95@gmail.com> <20260125134302.45958-10-clamor95@gmail.com>
 <aXc-Sklb6QTWLvcE@smile.fi.intel.com>
In-Reply-To: <aXc-Sklb6QTWLvcE@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 26 Jan 2026 12:14:29 +0200
X-Gm-Features: AZwV_QihBi0RBeQR-keWUCWb4tTVxVMg1HeR7j7c13MGT36B2hq70uBMvm9ETsA
Message-ID: <CAPVz0n3QBhi4qmyT2y7J8i_3kXDW3tXtC6D4XQnhz2H2W4-XRA@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] mfd: motorola-cpcap: diverge configuration per-board
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dixit Parmar <dixitparmar19@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 26 =D1=81=D1=96=D1=87. 2026=E2=80=AF=D1=80. =D0=BE 12:13 Andy=
 Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, Jan 25, 2026 at 03:43:01PM +0200, Svyatoslav Ryhel wrote:
> > MFD have rigid subdevice structure which does not allow flexible dynami=
c
> > subdevice linking. Address this by diverging CPCAP subdevice compositio=
n
> > to take into account board specific configuration.
> >
> > Create a common default subdevice composition, rename existing subdevic=
e
> > composition into cpcap_mapphone_mfd_devices since it targets mainly
> > Mapphone board.
>
> ...
>
> > +#include <linux/of.h>
>
> Why?
>
>
> ...
>
> > +     cpcap->cdata =3D of_device_get_match_data(&spi->dev);
>
> device_get_match_data() from property.h.
>

noted

> > +     if (!cpcap->cdata)
> > +             return -ENODEV;
> > +
>
> ...
>
> > +static const struct of_device_id cpcap_of_match[] =3D {
> > +     { .compatible =3D "motorola,cpcap", .data =3D &cpcap_default_data=
 },
> > +     { .compatible =3D "st,6556002", .data =3D &cpcap_default_data },
> > +     { .compatible =3D "motorola,mapphone-cpcap", .data =3D &cpcap_map=
phone_data },
>
> > +     { /* sentinel */ },
>
> No trailing comma for sentinel.
>

noted

> > +};
> > +MODULE_DEVICE_TABLE(of, cpcap_of_match);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
