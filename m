Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B43E1201
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140557; cv=pass; b=ChuwzSXlASGhST/IGsZDvp1zQaqLZ2U1OpQnJFAVFtGgM/CVRsNykEXIxRXfU7BlZM/AxJ6x8dwcUSni2LxwZXtRmnGVysZh84YkJqOVuCyVLzSY5kktGcxLd7fY/7tODRhv59+7tIzeiybPau4/lSD+OCFYrRXgYt7+zg6u74Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140557; c=relaxed/simple;
	bh=mw92Hf/dQnuOO4mzXGCnNoSoSNZ4XLCDu5vbV5GvF2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbIv9mT0cK0BdVtu7dSoPBZ9AxayDuJYr8NG2vOG8jvu3xWMzB2VvyWHRz41WxN/qqmrVpGcHZ6q/7npdy2O8/mTUy7GFgJQWkRcIDvIQsFvtF7R1VyzE/VSDewq8Bwvis0hiFkafJWMvPeNyEUD+xiGbzZ3e2DPt6bpd0vPADs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WACiFu7z; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WACiFu7z"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1892625a12.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 01:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785140556; cv=none;
        d=google.com; s=arc-20260327;
        b=D+U74LEbN2xhnr12W/VzqxA+ozKcRkSMaDUKLCJY0fGKy5nGO1k6yLhN/EoiFKCgV9
         LoZ6zed4VVQD4qccq4pv73LvC0tdA+g55Fg3JuANQffYS146JzTnGwmkSHo6R8OXIZib
         3mCgdFdcEp4nFV2OcMhmeYaScJWfShxaZNPsF13O1lLI6kQs6NIPNT64ubki5Uq1lyee
         qQh8eFjev3MWmbmmsQQ97LzmmjX5afoOpwlrwxkzV54QHXniNW4nW8JoZmJfL+nRssml
         JJfMmwujRPOT707EreYlQp3kpEanWTy7X6CwpK9UtY7t9C/gOyvVIXJRbkDAeD9DUr0T
         xwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jiiyofhSvlGJbOk+zjioYY1U+uBRekjwWzmE0lyF8KY=;
        fh=c2x43a7F+jRZdXSXvYqwm1XvZ6rHqmYD8mzks6EAtUY=;
        b=rFwjFOZMuQ3+qwRar+a1FJSxSnrZKTGVeBi7xVuGpRm2zs6HWC3QqvVDLAJfvDI6Li
         VlTDRxMruVNZcDGx4RywtyyQvNXgCncyDAnGWIie9IIKuTEVa/QhlP3J/ik+xvUpUB6o
         rEVjxgFiA4cvQd02K6kqinsSLPF329lEoaTTUaKF795Uk2LRaTtjI5+4O7VENWMAahEM
         eDOqv6jUmBPJBjtgUVEKIJ1F9naIll/6yEnVKFTkbwT5/ufJixeh3eaEedK+qPurCOmu
         JF/yyVUMwPFHTy6ZROf1+GMEKmm3q2eZIk1Pgsh6k4GEmPfAwPXJCB5RZHB0GbML2p00
         3j5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785140556; x=1785745356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jiiyofhSvlGJbOk+zjioYY1U+uBRekjwWzmE0lyF8KY=;
        b=WACiFu7zKLA7BiL2tpISJ0tGgW8Q7+/skiRVtyUHYBi1b43cDK4VZyHLREaMb22n+C
         qCJwpIvJFwIzFatu6RchWr++GLOFdvA6og0DgwtoCQ7TbK00pC/o9wlQRLf2vAHipe9L
         x5NQTLcPenfEXWOVPE/CXXmATcyuxKKLpBrwSlDMnQBZvr+MiSxbN7EFGsowUyn02eUz
         8fAenl2u1hS88bHRfmejE7cVjj58XkT6yLs/xSilKEvTVrbBkK1AUqdX+WPUpsg9+CDF
         WgNWQeMvk8GC7lsJbMiZdXV+KZUEIuTk8Zhfdom+YA44W2fT3A9ip4Y0hTlzBT8IeR5v
         IewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785140556; x=1785745356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiiyofhSvlGJbOk+zjioYY1U+uBRekjwWzmE0lyF8KY=;
        b=krw4ZNSew10lmr2O6Ebh7bklVeJe2Fj1fYasra1Ob0ZzRUa2jOnHclVyEp8JBcGHy1
         2BSUo7pHjoOobgVwQ2NrlYzjsCcm1qpCeThxBU2P1dDrItynrgIR4bgY/hlggY1/heXM
         gGGuQ/oIYoq4Guo1I5AMbP3RvACdFWF3xfFe8h0dFqC7f0pabkuvvJrpu9z3K7wRj3HT
         G/j8SD8qja5xaku1HMDUmppa8+AlU9CC/Cu2dWSMK3oNDSyD5Euzvw7XwREZA4zbBwIP
         SjVLvRlvDCKckFKHFF8vLdmjTkgV/1RqO94F5Egcc4DIuq9w71V0LerUoe2acBfJwmeY
         jMlA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8iOXyHHq1qugglipcer28qe6P2AJqE497o942NI1+lxDgEIeCempyMkJmsw1wB4ZwL82ACGIzk4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCgjbVDuUqBV52dUemUezQ7dCUZOydwnGGrF8a+riW91fiaIH
	jZn0QoyVrUA0r55DyicTin5Drsc9CEwvQhEe4LK+/Pci1UAoO3mc//rz6AJj2y11Hfvk5WFq5Ig
	WeNKRr3QwCBce+BCjdH70ZnfXJkCjvhQ=
X-Gm-Gg: AR+sD13z4cDa9tEDXbIrtEEDrA6iPHnWQLPXBTqssWrv7JFGmSRWHglTTCMt5L3NXUm
	Zzufp2Uw7crMDSa83VcC6u7342qBVyiUl5pcqeD6jOdWiTfW09VYS1oSPY8hLGmsQ7qGhViU2K0
	fOHyz30nbZsnGAWjRSVunqjyc0nZrVy2Z5nTELTRe160yyZ14qM8bdcB9/znmKyTqEI7sjDWKWr
	PRoEmnlVBKRcSPAOVVwpd3+EoOn34ItN0XJ56rUZk0thqSjh/963z7v0rda1xfJcvSwPhkbaL2z
	2e1D3nU85Mu+v/sRJlw=
X-Received: by 2002:a05:6a20:7291:b0:3c3:a9ad:a747 with SMTP id
 adf61e73a8af0-3c67da6cbabmr7867709637.26.1785140555737; Mon, 27 Jul 2026
 01:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-7-clamor95@gmail.com>
 <20260722022519.3b1e4fd3@jic23-huawei>
In-Reply-To: <20260722022519.3b1e4fd3@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 27 Jul 2026 11:22:22 +0300
X-Gm-Features: AUfX_myZ-uH2FsBg2M-NpEbqqEjSB6AkjRrQi_JMKQ0vOPgoMTtIwPKkN8lpkdE
Message-ID: <CAPVz0n2JBNRW3EP+b8Nk1C2MbJnszLiC3hSwEsV7r1ga8obX3g@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
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

=D1=81=D1=80, 22 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 04:25 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 17 Jun 2026 11:00:23 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are us=
ed
> > only in lm3533_device_setup(), which in turn is only called by
> > lm3533_device_init(). Incorporate their code directly into
> > lm3533_device_init() to simplify driver readability.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
> >  static int lm3533_device_init(struct lm3533 *lm3533)
> >  {
> >       struct lm3533_platform_data *pdata =3D dev_get_platdata(lm3533->d=
ev);
> > @@ -437,9 +396,21 @@ static int lm3533_device_init(struct lm3533 *lm353=
3)
> >
> >       lm3533_enable(lm3533);
> >
> > -     ret =3D lm3533_device_setup(lm3533, pdata);
> > -     if (ret)
> > +     ret =3D regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> > +                              LM3533_BOOST_FREQ_MASK,
> > +                              pdata->boost_freq << LM3533_BOOST_FREQ_S=
HIFT);
>
> As you are touching this maybe get rid of the shifts and have one source
> of info on where the field lies in the register.
>
>                                  FIELD_PREP(LM3533_BOOST_FREQ_MASK, pdata=
->boost_freq));
>

Very decent suggestion, thanks!

> > +     if (ret) {
> > +             dev_err(lm3533->dev, "failed to set boost frequency\n");
> >               goto err_disable;
> > +     }
> > +
> > +     ret =3D regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> > +                              LM3533_BOOST_OVP_MASK,
> > +                              pdata->boost_ovp << LM3533_BOOST_OVP_SHI=
FT);
> > +     if (ret) {
> > +             dev_err(lm3533->dev, "failed to set boost ovp\n");
> > +             goto err_disable;
> > +     }
> >
> >       lm3533_device_als_init(lm3533);
> >       lm3533_device_bl_init(lm3533);
>
