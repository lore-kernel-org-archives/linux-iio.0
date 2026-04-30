Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5051DA0E1
	for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535592; cv=pass; b=XWXHEJrrMo3050ylkukD4PQ4v+DlkW/1SvBQM9IJ/UnOVlMBPp/orTWWXhOKndXakFXvU7zdGvexgzQnZUuzPTVWq5YMzN3JFXpzgIxBr/m1B2Dp5ZAV8T4CbV/Ypl461eINTRzt7Nbr3VJHSMjvZ6hSs+ojwqPc1/lwMIQ6NgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535592; c=relaxed/simple;
	bh=5D/eXnjWTRdHzpP1Y4jCGQqkOiAfHjZ+MY3u+A5+lVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eu9yy0BvHzINSkfA7RlRaGWvGIkYPXl3XSfc6XjOyZPV16Fkc0LetURpgwaOudmChKE/Q0XgwOVUsLTP2v7O7MY0IvpN+holX9FVLxdOzANrwy6X3zmbFmLviMFIsQg0brobO96/rFwxVWtJDgXvPUvSfGTSsiLH6DB3NYCgaes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inR+k0P9; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inR+k0P9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso6962505e9.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Apr 2026 00:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777535590; cv=none;
        d=google.com; s=arc-20240605;
        b=h5dOgwQzsmuiKdk64tSMBIEECsdpMqAJm7aI8HZeMVPx8kaJItMx+77t7ST+nHvxa1
         4zNlrKtkcEpZ81EW9h8KPtE7y9q6nm42p3kpZtoAV/KEraliOTLNSXgsJN8OoCLCZIvV
         pFNsZbr7z9z2QdZSYXfL0jiYFjppviA6+PikZfLUxb+f9qGITSbbWvOmv0cIdQDmV7hs
         /mPfwASOiWpMXY4i9XIFgRA36b505UOhf1FdPl+X4eC9eumeRxiCT1kgJcbOGSl1b76D
         wNqokT1qYAFIFLhj9E6w6a2EObOlsabukPIjOM+TwuXBtJLIT0XZTrTN5aFyvzCTCjPy
         Ia5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5D/eXnjWTRdHzpP1Y4jCGQqkOiAfHjZ+MY3u+A5+lVw=;
        fh=gGq+6NKd3V8HA+lygIYrgkibGOfssde/pGh5IbWcAqI=;
        b=U9CC1UcX+bs1Pz0ys9cG9LChp5bkbwFcpg9HudoocHhMs0jYLhC8wDCDn8ZScZV2J3
         Z5jNcsTFtulu3sJallCi8BniurxFcu6jKsOnqcdeyNnr7z1pJ/kHS4/rbOST4iW0+FfN
         uFBHZCTWshJ/Es8KCTc/SGPwBLXuk54H1kzvY0lS5C92q/NW7k4Ed75psMjlbEphi3QF
         BgVPoYlshkUKPQWqFGBFAQV4uP1VXWCJDQUVuFu0jl30MJgDe+s/zf+cF1qXwz5OLbQT
         OrgAK9gK7m0LtZwmkdr5b34QtB90tkyhTA5mC3ZaXHO3cKS+bptcntmwsxIhCKqtcuFs
         OJfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777535590; x=1778140390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D/eXnjWTRdHzpP1Y4jCGQqkOiAfHjZ+MY3u+A5+lVw=;
        b=inR+k0P9OJRhNz9jSUcL8aWAT/X/+Gsh2FZ+8TBogIEfYq0aK3jpl5lxHn9eaAx1wu
         NB+Xdv8DESnRgMHdQZilkQpjad4IeRicT5pVzgemTJ6mDNMvpQWIDIfXOvWp7o6/GhdG
         UTK1xTrWlkiN4bUKjqkpMAuBTpsOyhZohs7yKbqps8w77swFWcclzh7kkkNZRj6cnjng
         qGSQd/4Zl/Jb2cONqsBLHiV7CpvBItUxyko3HtyYZz8qLOtmwu7qQp/Yjg5XJRIbxOsc
         0lnVnPoK8gEeoe8SsLQ9mmqOu86SJzjGNUxcXS3IQn1LTt+9GTexUHDdc+vS/l+k8F8Y
         41XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777535590; x=1778140390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5D/eXnjWTRdHzpP1Y4jCGQqkOiAfHjZ+MY3u+A5+lVw=;
        b=KGCSjH+I8sVE9PxWJ2jwwUYhvIQSbXvDgdv+vzByiTJq4/nJF+FOVOu6SsPFXRySD3
         +JeQxF1ELougsZ+1Gf+KE0j4GnlFLVh7YwG0TFc27irR5BuMBB4g19e2PMyhgeNaGtM9
         IB7S0Avl4W4zagUgMr7J0geW75LIlDucSt5QG/0qUpKTpksjdySetqo4TuUsVr/mBp6j
         CW7NyHcKfA1K94jjyTH2Hc1nuSoPvPabDymja8kIAERre9eJEEJJti3vA1e0hOxmVjRt
         pjxJoiCNuDCCfOjZiBeGp5JQl33by3Hf3O8ia/9j3TBEL8ADCxV1Ncl9ih0YTSuytgUL
         7Wyw==
X-Forwarded-Encrypted: i=1; AFNElJ9DtweK8f2ZBk56YooCbPHdZrp+EFn54dECdl9fCIOCBXVVhe3VuzSHq4edipIYFcgM28q9LVTNhqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHg8P6NJ/QEcNOqhPae0S0wreToa0TsK9xysFDVyFYXjA5+wSN
	FvUW92Esyw6kbYaY4Ddx/rB5LUO0OzTqdOL8RMFvrcBXs6Puy8UiUWMpiWmuAtxaZONYBFDceo8
	0EsdwHmEiE1YQOE18nMPFGJ4QU3r0eEY=
X-Gm-Gg: AeBDievw1XGwEandMdN1BhqyP5QhU8jgtX8BQ9s1gwv49izUbu8pBpS5iGGzRceKYIr
	eTpRlr8Q/GDOKO+ChE8aM8TYjutssjTV9N2aqYYzRspoF8BI2xT23UaVRta9mawj7wk1ONnsb6d
	Ooey/UYDeoJcT5JaTd8VS1vqBOO0Y1zaJCFRQY/08CgBDOfeqhp/ppse3NMFHDteRWYqQZMKWY5
	UvpEB8PLFAzoNC579QCHM5xDOkKeqgQ8ScD4FbkIwVjg4Aais/rgtAiKdygrcv0joYu38mEwguq
	WbR+H1nMyqrC8Z8q3IEcvpCsKwGfg98Q77gZ7jYqyar0wzkv8r5MK8uUdlByIVEYZh0DSp44LI8
	TK/+TNB87+wjX021f6wQ1khVJxXytrCJBycEY9ILl2Jp2cyY4ck3lNcRUymPlXu4Py6p1WOarkJ
	LoiMnnuMXBCD4nPHxv
X-Received: by 2002:a05:6000:2903:b0:448:f812:a2a9 with SMTP id
 ffacd0b85a97d-4493d5febaemr2917845f8f.19.1777535590082; Thu, 30 Apr 2026
 00:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-3-469f21d960eb@gmail.com> <afJZIO34pvxeKp_d@ashevche-desk.local>
In-Reply-To: <afJZIO34pvxeKp_d@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 30 Apr 2026 09:52:58 +0200
X-Gm-Features: AVHnY4LheLFTqw3M9wAzSzlS5xxkXwHGyPrmnUesm_BLoLj5yX0EB_-Xldn8Sfo
Message-ID: <CALoEA-w+q3cU32yK1GeYzbTPjdA4ocNNvtW+qMd60PQk063uVw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] iio: light: si1133: add missing include headers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Apr 2026 at 21:16, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > +#include <linux/irqreturn.h>
>
> Assumed by interrupt.h

Will do.

> Also mod_devicetable.h
> *Yes, most of the SPI/I=E6=B6=8E drivers do not do that, I know.

How did I miss mod_devicetable.h after adding it in several IWYU
patches?

--=20
Kind regards

CJD
