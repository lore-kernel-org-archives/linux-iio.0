Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98082419306
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102133; cv=pass; b=R2w6Qc3wO2Cy7ZgPGF1F5jPUnIZuq3BN6awAyokMUNoe+vb499u9nyCIc+NTRZ6t+ph7nCOejYIOJ0nsap4S6QZGstNxQj3kJue6QQbRzRLcak436UZqt8ELJMHaqk6YAikI7LNnL+x59lQMlxAapTDTOghBpPGLuogsX4pFs9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102133; c=relaxed/simple;
	bh=QQx6HdrZCLg1/bCUL3imDIU0SHjoIZfIndkzDKlCI1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IejwnMWEh3fU/ZfAW9MM/vhr5Igl+FEKOhoWdUWM/NLzf2xwUGGLvOFKsR1yBgN6tztKNrU1bt97WBYZC6tHGB+8wfNhP79M4V04UgLaD7zOK/IiKlglEqov8gdQ8KARlP3pR57nqku2X2H+BIhdbjKKAJgtmS8K6OMmeFdHViw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQm7/gRU; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQm7/gRU"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-307631dbfedso14727751eec.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 07:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102132; cv=none;
        d=google.com; s=arc-20240605;
        b=NA7mJWf5QYvLyVujLgDE9sSuE4kUB94ptBcEMfwCLVK2wLVofmM77HnmJbr1RSmP0P
         cPUr6lcCTVgYfPFUK0xjrRMS6TLF8EZ/QrSxArH4kt4185On0ekR1e7SecZvLFAGoqSf
         ooUjZrAdoI+j/uT0soG2fjed5vODlOvv0H6PJNjxKZgQxvWz0Wr5d9HYTg9XqxEy21XX
         NXx09NvyuVcd7BhtQ3dUsagurn2MWNwHmPSECXQIYYCDbp+YLvbRBXCurNYucyODCDJj
         iyMA7QNGUuBnns/JQ0KeAkq5Q9YViKXYNby91OE27IcjLVXEbrpAgVxL3QHiVFstJ2xK
         toIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5u4rWfzB/dXcaizEq3FSq09DXlW+GebEr04lNWgXuHI=;
        fh=R3DDbWi8G+1DSxanED0fwEvf1oWu+njBnmoBj3qL4zE=;
        b=SEfUKk0g1Eea31QHQpM2KAnPfewOiPgF/ONFW6AChS8B/zgd5UePqOK3VmxCxMh4j2
         y4GOZdhl7bkopEK/D8JaQrl6yFEKhrzT4Vx/MgZ9WCeb0dwpJpAJZGvJYkyK3t2mra+T
         OsvZJcCULH1sV9BHRJOydBdDJf/zxGsZiGP3XCwCJKunk1Qy/ECOHJaiqico9uFzvSBC
         6JR29zdfxUsXWRyir997dgBL6B6p7SfFVkCVaezS2lCJeaaK3Iq23AFIOEGZP5BzCkwi
         vWA/5xspDauOdEqXv3kR2b+/kj3rcYdYUMre0urjuESquJlMyIZO9EA75VKJ5MizczIc
         +p5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102132; x=1781706932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u4rWfzB/dXcaizEq3FSq09DXlW+GebEr04lNWgXuHI=;
        b=KQm7/gRUZfsFKZqtrRX/8Gv0F6bhmSvFCeIsHmKzg4zXiy5wml4L2DCsSYXvR9y6VT
         dakAcxRGvyiyeLEmi/m/zwtHybvTK2vGxqItzgALr+8oc4OGZyYciXirvN9GSOw2RLkK
         49Vn92bndAK2aGF8/CBb1krYV8XgERip/wUWOu/2gqfs+ZtfENmUS6MNzPv1lIc8FRIX
         sC8lAPSWJ2RzX3/CQeIgHwZpONkaUhzMNPtYIc1hOpnirAwqodCd4glpOxDEpUKLRR35
         ws/Yz+J9Dp50xOxLOKTmZ38zDkB6qSGaeeevLFcfTPWN5pVFpAZuUXlPzW8qBX5pAkNk
         eTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102132; x=1781706932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5u4rWfzB/dXcaizEq3FSq09DXlW+GebEr04lNWgXuHI=;
        b=S8jIbPhLXqjCTe6N7tp5uICGYUQJTQzbowb0G4bT4zqzHPeXmZk9eiSMHcU12Pgd19
         WeFXhWGqzj5HRJRyjzA/oIyrZnY9DJ1oUwlHf8KWEg1gYVU9r9Y7A9Co1CWFBBg+NHRl
         LEsLN3XBtvo7mKmsz0klM90APx9eqwLle2VoEk4tBcj1lwoejbzS4BBUNFBDEFAHs4rU
         7tNOYWvEH+LXXww/btYIofx9jN9on+UEPqSijVwoIf0nKHaVTICRwWaze8O7K6rk7vr9
         Rn+ilbE49CDKeoDq2No2yrzxoprUHW4nzSehssbM9tm+WB3wl3wivECms45t4PDk2d0s
         Nf/w==
X-Forwarded-Encrypted: i=1; AFNElJ9L/UlmdBXhh3qm0l6yimJwW7lk97p9QLhTp25iqQbszoezgyw++PGpQ6KN+Pmx9/UUPA6uBBOB1Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvO6V0bCRiWn6Janebg/goCAjnlVC7nL2+fbALZ8WNNz7/6Qty
	8F/bF2af/EWRjLRWmaZPcbZkgPfU/TTwKkgoUtGpzsygpZyjlDab8VGjM+8qiG+Z5mF8DqEO3pa
	qL2P43IwlyD3aF51YwVplpZxCUwPO4+M=
X-Gm-Gg: Acq92OGB14I6cYzrcLWHNQxo/LVm4xzlkLCka1+bG3BCOUSJQ5KWqebr8lYiyOF5UAE
	uzNfWNUuMncjJPMQCFBcCStI3P4WtXfkwVx20QHr/T12Xoogb9d+COp0WzZCe7KcllWLEhjDxym
	IL4VBSYPiPvz2C54uP1mDjPnjp5pet316XuqkjzB/cyKZ4twQ8GA0bR5jhXLfODX1VrmXxmp+Km
	tVVm2wlfHsLU5JPaIDRBl+juQmNq/eS0wIWpZQ0q7RZodsOb6WYsG4/8U3801LKnVTCPb3Dd534
	gwhyorqaiBoSTMWPfJg=
X-Received: by 2002:a05:7301:4186:b0:2ef:9961:27fa with SMTP id
 5a478bee46e88-307d62ddc77mr6085557eec.18.1781102131738; Wed, 10 Jun 2026
 07:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-6-clamor95@gmail.com>
 <aihlDGNZRuHI-vMR@ashevche-desk.local>
In-Reply-To: <aihlDGNZRuHI-vMR@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:35:20 +0300
X-Gm-Features: AVVi8CeF2WtE8NAfRo3Ry4_ONFpQ60FlY7Ry_ggOsna45f4Sc2pO4GqWSxBW8Fo
Message-ID: <CAPVz0n17uAvpyuF5_E1L49eoz8LvHULE0-SVjJpHvu4veWWjEQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] iio: light: lm3533-als: Remove redundant pdata helpers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:10=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:29AM +0300, Svyatoslav Ryhel wrote:
> > The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
> > used only in lm3533_als_setup. Incorporate their code into
> > lm3533_als_setup directly to simplify driver readability.
>
> Use func() when referring to a function in the commit message.
>

I must have missed, thanks.

> ...
>
> >  static int lm3533_als_setup(struct lm3533_als *als,
> >                           const struct lm3533_als_platform_data *pdata)
> >  {
> > +     struct device *dev =3D &als->pdev->dev;
> >       int ret;
> >
> > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > +     ret =3D regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
> > +                              LM3533_ALS_INPUT_MODE_MASK, pdata->pwm_m=
ode);
> >       if (ret)
> > -             return ret;
> > +             return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > +                                  pdata->pwm_mode);
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> >       if (!pdata->pwm_mode) {
> > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > +             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > +                 pdata->r_select > LM3533_ALS_RESISTOR_MAX)
> > +                     return dev_err_probe(dev, -EINVAL,
> > +                                          "invalid resistor value\n");
> > +
> > +             ret =3D regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR=
_SELECT,
> > +                                pdata->r_select);
> >               if (ret)
> > -                     return ret;
> > +                     return dev_err_probe(dev, ret, "failed to set res=
istor\n");
> >       }
> >
> >       return 0;
>
> Wondering if it would be better to
>
>         /* Bail out when in PWM-mode */
>         if (pdata->pwm_mode)
>                 return 0;
>
>         /* ALS input is always high impedance in PWM-mode. */
>         ...
>
> as the above changes almost every line in that conditional.
>

This is a decent idea, thank you!

> --
> With Best Regards,
> Andy Shevchenko
>
>
