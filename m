Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802FF2BEC2B
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906592; cv=pass; b=g0dV5H0FC+N3o4kUtw1OIEax9BZyPW2UQvfuaCcixGZPY/WpEuaFFmacPYPCzkxF5C/AUgPK9sykzWzo18ajKv30NY8gMltjbO8JvCkrHjVkfrNFt3MVeKqKPTIiJ2bsPgCRZ0rk6HUDNgElpO/oc4X6FOnxyt6KS22Q1iFKh1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906592; c=relaxed/simple;
	bh=qqD55OAFzpvSnsOQ9ayIHaFmMqHNm44fijbByEAEQp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9qXJMRakh/PRKc21/gzd62ycMzeRp6aR5uyQ/pMEqyM06hMGMRCRQbBeJ3gxtd81sbjrXx/OfwtpOmL2v6hjtEeq+vMI27NUWKlUMEVd1t14lz98Fy2chtpTAkxP7896JW2G8aWijIV+jN8RxzX/9oqisY6jB427zYQDq9gX8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvHFQYaC; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvHFQYaC"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81e69a2db34so6116457b3.0
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 08:23:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784906589; cv=none;
        d=google.com; s=arc-20260327;
        b=btH3fvhX7EAxSe4xc/cZL5fzH4cmiP76zv7IF8Mc4ZJjp3C17WscELG101XfBBNlrN
         k1tOiaXY9TwRIBX4xVYBUIE3DHmWda2a0CDZ2g/ezumXEXt0VBldqbPBlHwuG4A4T+7J
         Sj89kZhy/ZzIbBm1uycUNH8C3f/q+Uq3ILLN4qjBjNJEq8tMhxeJV2aS0LisZqFUhySC
         GtrVCls3Q8f1od9Xm2fmrIzJm7nJZzWqs5cm/xH23kBHMA6JMCbyvzGyWy5iHFlymGFK
         XeGUdb1dxOQ6DTwMMB4Ulsxq88KvuWf+qtIHBFt1oRVunkUxE6nOZVnvBFjUDfWq7Ha+
         rLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+1l0UO6IoBtzLodlS8aLRj3wfaO+WA4HpECbIgyuWaU=;
        fh=bIkxCrFGDaP8SXN8KA65URekVA4JuLf87lHIVKkvjfQ=;
        b=GsCrC5oz0HIcD7pOh7VWh3xS5HqhVCujKoomjUkWLFUene1x6mKBf5rU1XWFb+ou0A
         uf9mLoOMjHwOKv18mUl2IxNKAHjcajJ2tBtkZ1QorwuUfLn5zaO8eCtEDFt25UJQ9aY0
         1c9tJ6wI6t4dZ5zjYEivasrsdJpmVdE8lHeVYIrx65k3/6XaRKYfLAezw4HR4Eq0oEYF
         mu8qZjeJXyY226piQ/4ey/CELJkYZFxeXbVzWm0XgedXe9UTjwZU4EOlkA+qzpIMyQeK
         DiqelBaz9lIz97ZRTc4zGdE6vYEr8OdvFTHJpLTwsvtlCFpBMp/mL2naCeQQvqgzEJyF
         vBaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784906589; x=1785511389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+1l0UO6IoBtzLodlS8aLRj3wfaO+WA4HpECbIgyuWaU=;
        b=KvHFQYaCejL/Vp9rMOGc6iJU+h7j86YqYvIjzeikQDrG2nRVIECyl7TktThAP4WZwc
         byi688lUntf8HnkoSbLneYVleirFZ2Qpq7suN28Kifyj8Zgq5Zt/dH8ur6RTdtzi+x7M
         VCi5Kmmo/kDstLKvhIc79juyyYKB+dfWSdLNBJaZr+TyofMw8FWgA1rgTyt0uZPD61Bj
         iHu6CSlrUWaZnAnIzQwjMlsUlyd4+CroolbmltqQKe6kFKmDBxysyZ2PspZlkR+dsSgA
         HSN57YDqEt2FKmdJSccGJpnJHhdMn9oTiEBgGAeda2eSr85QCVLIG0GJniB+bdydVZS/
         rV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784906589; x=1785511389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1l0UO6IoBtzLodlS8aLRj3wfaO+WA4HpECbIgyuWaU=;
        b=DZmV5XjLpbbku8mdkGKMvltqJZfzWG7dXSNZwOw/xYMST+fuCfhVCnaEPC2bOYOxCf
         eMH+8vSx/uZquaeYMmn96RetGsaDl9JaXniPaaNbmLyrW2PvjO+3YvWspgk2Roeis+R9
         NPxbthJfBtNW+lNU5E7fMm7NFQiW1lWZQFT2z5qm/F+TH9N60CQaJc5aKoJBC2+LXcI8
         wgyF+IhzJA+twc7n2l/XJ2PNt0zSyG8xDUEZWwQxawKwf/TJbvVAVCZW3sIhGy8vzX2X
         axqCPoWG2UvgvUNIEoqOuKTygbefHfmBSaNQCGQUDVYWl/dazVkR1AQBvyTHIgM+K/nf
         nXXA==
X-Forwarded-Encrypted: i=1; AHgh+Rqv3Hcd70ZRVDGCKCQiHTPtIOFCKKavQau9xb8nxeCyJcJsDYzD+g4xm6/zqEcBHTxEhaR1COqwP6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJcJXDJbT5pewYkyGXxtJKstvgOaZkbblcD+060uNBIERECTid
	oPLrHZrKpQE2F6suwvaPq3WpuX6uhfZurwln9ZpEIxo/qQhOvKoqMrMp8QihlRViRms5FZslCuz
	HG2WpBAeOB+uN2qWJKaSUFcomYouB2e/oePc/TXU=
X-Gm-Gg: AR+sD10HrFSAt4+cPEOtkQ6BYHEEB5noP6kawbAHmNKnbPiS9RMKCGU9poIqRPIlrEM
	WxWlTmIuBPcwEsLLrv2IdsB3FHEyzRBeS9/ObT22U0+7h9fZxBr+akoNBO2v8345CwuDcEBthYJ
	90WaizhLpeNEMIiCjcg5n5I00pBDx0C+sQPCWsy7sknztC54k8Gacn3KyaMHKKJKfXwJbEim2jB
	kMr3508DgS/l3N9tA35zSOyc1GQzygcLT5BaPfrWAziwMFPAssBDCpiNQ4=
X-Received: by 2002:a05:690c:6712:b0:809:86c6:ee18 with SMTP id
 00721157ae682-81f4c3224c9mr27486987b3.37.1784906589296; Fri, 24 Jul 2026
 08:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-16-ekffu200098@gmail.com> <20260724013827.612dd9ab@jic23-huawei>
In-Reply-To: <20260724013827.612dd9ab@jic23-huawei>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 25 Jul 2026 00:22:57 +0900
X-Gm-Features: AUfX_mzX9ECIP2A7hSt2nQZv-eQ3QZfZjoIfj4c4mOlqdwyuUp2aBUYDEVG7syo
Message-ID: <CABFDxMFzZEqk+60O1+x6O0gGCdOwJuCXNnsWRxedcZ2hpkUtSQ@mail.gmail.com>
Subject: Re: [PATCH 15/36] iio: remove conditional return with no effect
To: Jonathan Cameron <jic23@kernel.org>
Cc: Julia.Lawall@inria.fr, Linus Walleij <linusw@kernel.org>, cocci@inria.fr, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 24, 2026 at 9:38=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 24 Jul 2026 03:45:17 +0900
> Sang-Heon Jeon <ekffu200098@gmail.com> wrote:
>
> > Both branches of the check return the same value, so the check has
> > no effect. Remove it and return the value directly.
> >
> > This is the result of running the Coccinelle script from
> > scripts/coccinelle/misc/cond_return_no_effect.cocci.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  drivers/iio/light/isl29028.c      |  6 +-----
> >  drivers/iio/light/tsl2583.c       | 14 +++-----------
> >  drivers/iio/magnetometer/ak8974.c |  6 +-----
> >  3 files changed, 5 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.=
c
> > index b88e7c4eae3e..ea38d797082b 100644
> > --- a/drivers/iio/light/isl29028.c
> > +++ b/drivers/iio/light/isl29028.c
> > @@ -405,11 +405,7 @@ static int isl29028_write_raw(struct iio_dev *indi=
o_dev,
> >       if (ret < 0)
> >               return ret;
> >
> > -     ret =3D isl29028_set_pm_runtime_busy(chip, false);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     return ret;
> > +     return isl29028_set_pm_runtime_busy(chip, false);
>
> That should have been a return 0.  The call to pm_runtime_put_auto_suspen=
d()
> can return positive (in theory anyway).  The intent here was probably to =
eat
> that positive and ensure we return 0 or negative only from this function
>
> Please split up a fix for this as a separate patch.
>
> Even better if you have time would be to do that and then a second patch =
to
> get rid of this helper that adds no obvious value.  Smells like code
> that evolved into a slightly silly form!
>

I looked into it briefly and I agree with your analysis. Not eating
positive looks like a mistake to me too. Removing unnecessary helper
this time also sounds like a good idea.

> >  }
> >
> >  static int isl29028_read_raw(struct iio_dev *indio_dev,
> > diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
> > index a0dd122af2cf..a38a0130d854 100644
> > --- a/drivers/iio/light/tsl2583.c
> > +++ b/drivers/iio/light/tsl2583.c
> > @@ -456,12 +456,8 @@ static int tsl2583_chip_init_and_power_on(struct i=
io_dev *indio_dev)
> >
> >       usleep_range(3000, 3500);
> >
> > -     ret =3D tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_ON |
> > -                                         TSL2583_CNTL_ADC_ENBL);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     return ret;
> > +     return tsl2583_set_power_state(chip,
> > +                                    TSL2583_CNTL_PWR_ON | TSL2583_CNTL=
_ADC_ENBL);
> >  }
> >
> >  /* Sysfs Interface Functions */
> > @@ -790,11 +786,7 @@ static int tsl2583_write_raw(struct iio_dev *indio=
_dev,
> >               return ret;
> >       }
> >
> > -     ret =3D tsl2583_set_pm_runtime_busy(chip, false);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     return ret;
> > +     return tsl2583_set_pm_runtime_busy(chip, false);
> Similar to case above.   It should have been eating the positive return
> by return 0;  Also the same suggested follow up cleanup applies in this d=
river.

Ditto. Nice catch :)

> >  }
> >
> >  static const struct iio_info tsl2583_info =3D {
> > diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetomet=
er/ak8974.c
> > index c7fdb7c2f543..c988d0e40cea 100644
> > --- a/drivers/iio/magnetometer/ak8974.c
> > +++ b/drivers/iio/magnetometer/ak8974.c
> > @@ -379,11 +379,7 @@ static int ak8974_getresult(struct ak8974 *ak8974,=
 __le16 *result)
> >               return -ERANGE;
> >       }
> >
> > -     ret =3D regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
> > -     if (ret)
> > -             return ret;
> > -
> > -     return ret;
> > +     return regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
> This one I agree with.
>
> Thanks for looking at these.  I suspect you may want to take a closer
> look at any other changes you've scripted that are similarl
>
> When code is doing something silly it might just be that, or it might
> be intended to do something not so silly!

I agree. This patch was generated by the script, and I only checked
whether it is a false positive or breaks the existing logic. Fixing
mistakes and improving code itself is always a good thing. I'll drop
this patch from the series and send it separately to IIO, including
the fixes and cleanups discussed here.

Thanks for your detailed review.

> Jonathan
>
> >  }
> >
> >  static irqreturn_t ak8974_drdy_irq(int irq, void *d)
>

Best Regards,
Sang-Heon Jeon.
