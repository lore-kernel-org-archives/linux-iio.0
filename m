Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDFD364043
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052809; cv=pass; b=eMMkk/ERWReOlCVA1bwtoZjbyAEygEwn/6S7rj1ZMyS14gdA8tzSNr3vs8NdzFpGhbkXlk7jdPNNdCXx6jf/RVZX1xD81JDtddI5SCaSpAe04dtpKElwxNtoam1cDiwLDyJGUBZB4vlydDURG8thvTsYm5xdkt7YF9Jpj6FKBUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052809; c=relaxed/simple;
	bh=RBtquzZL5rzrFMLe6YTrQtMK6vs2r+FZyGLbgsVlHPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/eGDbME/pF6HBuK1nYFSnDPawiI0LetVw7lDQsj/DkbQKkPyGuOhpKjfJNzPco8OEObWov2VRNWU3OSD6D/+GJduAsB0Ra9YSo+8fYfalJDNGMjlvCx3lbyfD9DFqoYznV2WYkuJHksaosGNl60LcdUEP2XEZPuRAIi2r9bfGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+zedHJx; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+zedHJx"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304c520fe9aso5003783eec.0
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 04:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780052807; cv=none;
        d=google.com; s=arc-20240605;
        b=VKBnSkqajJkWqD4zFuKKTJWnP/tR1qkvI0af58bKR9nUawLqXjZB3JQQQ+wkkvGrC+
         EfOnHzcW6NINOl6BaOdDUe/oskudng0LF5cI3zKWSlfyNlT/eRXC9Q1sOzH7XWK8mr5Q
         ZJiBfJ37ysso0/taBcJPIgLXkCz+Eka9ntvm2eM8MotZ8qX9jYLGaUHMwvz/Xe79Wk9L
         Gq4ZrL/7qQOES9tsNR9XKCRYYbnnlg5qaeq+eOK/dWiioCP0JWDcBSQ912LLdR5C7a/S
         FFHRsUp4cOE+Nby44oNE1Vj0Cn5QkUgO6M26T6bmfw2B2NP+JKqcBpCU1y7xVsi5MDTL
         FpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LmadBKdB4Tf6OOuj36z3zIm/LqobfnTJZ4j9RKZPk70=;
        fh=unTxoJJIk0eq2Nap1rm179B3BaN0g7xA3vzwFlVQfA8=;
        b=DKacDRfarDR+xPXr7kGWXE1LijUIKwNwkaSfhnYhkshBEC2SvclcSSfRZ2vF8g5K8X
         SMy8f6NqPIDY8Rk8RU41lgityrDA5ERWvwRs/f5fiOcq6YM38rLPGZmBPA3OnxcEtRdF
         xEjriaF6aW5vcDRr8OjeArIpEjxEgNJkdOHlsYhPMtCwIN4mh45UxTBBjUpqMohiQphl
         sPOn34kIa515NXg1wy7K9pGZgVXeMEvJVp71qWK23jlqR6Jh3eIKbVVZxt9R/3Nph3jW
         Eo0JSs++fXm+hBmQ9avMzxBPVgebEtlXXNerHf/+dhJ0koEmHw78sN32YMoAjLzkeT5f
         u4zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780052807; x=1780657607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmadBKdB4Tf6OOuj36z3zIm/LqobfnTJZ4j9RKZPk70=;
        b=k+zedHJxq/NiiL9G3gRXk9NZnIXIGulYd+YjajIahy5H2J5CWj1FRPPFe0f67pg5BJ
         NccfuGJpYlEOAQiCJ1UoX1hibZNAouQd1z5+nlDCSJRkrppSqDPE2LxIlSTpLIk1ti87
         LlJBeaJ0ebnO2QoewUhHTyE2MKO+fXPDhI++rjpRUHmZyQLtnFKzUUCJm+oBvu1Y636K
         80M1RdaIyr4nlwlZHkigcl6FfSmxUW64YAIxnub0ijDSEvVw6h86Dwv29Sfv1Bgz6y0c
         GClnfCJ96Iw4EIU7JaLIh88naUbRXEzLLcWPNdhbgQ8Rb8JR76T60xSFcdNfbJLkz1Ks
         rVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780052807; x=1780657607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LmadBKdB4Tf6OOuj36z3zIm/LqobfnTJZ4j9RKZPk70=;
        b=VREuFITuGY2Jt24MO+Tyw60Avaflb4pRI7ioe8wCvg+teF3EM55hVmyin8NTqfr0kx
         0aMmAvqzFRs3hn8gT2zz+A8N0+xJ+IbBi2SBlQu7XhcdxLyypVciLyEG6E7G1R0VBw3H
         00ubA/yZlhVjhhSyaRA18zaBF2mlK6j6r0JZL4ac1Th2yreQL/kI4LocCv1C2xwyYDDK
         tQQMK6Prsm5l5phHiqzLmZ+EhwxmUnGtc7QQl7MDoKTEunOuvamXuhbJgoavIyB7rWOZ
         Yx2JKRPwcbhaqsKeU4xczjx8kevTcYsPA6tGXpYjzJKP6A1usefXNNzRwrUrdmshoDYj
         yU3g==
X-Forwarded-Encrypted: i=1; AFNElJ8ELlu78U8U8ln5rmQIZNdumgLZn/z58ohbIRezBO/W3qZtQob7gdW0hMaDPJhdmLK/5Fv6I4UbOkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0tEA1IfVk50VytPC9Q0KcBihWVVmSaL9IcEGe7IPZPBG4DmT2
	JvMMNpNmqbQA2alx1KQFItmCCgK4D9cY7mb89SaOKw0CQ+9zF/1KKuYmqzmcVrKXp85AFrWM9Qn
	yQDjZ8R68VFTgK8xsTnTIFY+nf8TvXSI=
X-Gm-Gg: Acq92OFqwbvRrsnMt7cO2Pk5qkmWsu1j5ISYDnPZ6U594ytJ8ksttgCiIsTYDNnTVWh
	NOLatMs6focyOQ3WK6/UZI7bfjj2yuB/n/lMlCvguZ5vxXTg+NR8PLXiLa/LdOcjxPvFkki3tMi
	oRpy2zGG342HqETzpF1DKpo4PWPDS3DM/lJ52PRpeR850ZA3Z1muegFHgUMuPtT2tdyHm3aVVRh
	TWbAG/UuSiTk9Wg8ZmceD8X+PkZ3CjyzIrSErDNQnZz7Y5tNwwt2W3pjQYt/gQ3nPZ1NOEM86n4
	BkZiwmz0iBUT1H6VESw=
X-Received: by 2002:a05:7300:230a:b0:304:c651:bdfe with SMTP id
 5a478bee46e88-304eb0e0873mr1128093eec.17.1780052807341; Fri, 29 May 2026
 04:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528135123.103745-1-clamor95@gmail.com> <20260528135123.103745-3-clamor95@gmail.com>
 <ahlxvGRVFDFrTUN3@aspen.lan>
In-Reply-To: <ahlxvGRVFDFrTUN3@aspen.lan>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 14:06:36 +0300
X-Gm-Features: AVHnY4KaFyk9CM74sBMVnXwM-QNoUHCxCc551JZM8S6RjnbIpb-ePbED6pxRxh8
Message-ID: <CAPVz0n0jXsd2CDhEPkr4bo+n59q3S=bEs5i4Hh4tur60aa2OZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mfd: lm3533: Convert to use OF bindings
To: Daniel Thompson <daniel@riscstar.com>
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

=D0=BF=D1=82, 29 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 14:0=
0 Daniel Thompson <daniel@riscstar.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, May 28, 2026 at 04:51:19PM +0300, Svyatoslav Ryhel wrote:
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> > Additionally, optimize functions used only by platform data.
>
> The last sentence is a little vague and makes us have to hunt for the
> changes in a relatively large patch. If it is referring to the change to
> common up the init and update code then it's would better to say that
> explicitly!
>

If I understood Jonathan properly, the last sentence will get its own patch=
.

> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/iio/light/lm3533-als.c      |  95 ++++------
> >  drivers/leds/leds-lm3533.c          |  51 ++++--
> >  drivers/mfd/lm3533-core.c           | 268 ++++++++++------------------
> >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> >  include/linux/mfd/lm3533.h          |  51 +-----
>
> Just one comment for backlight, below:
>
> > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backli=
ght/lm3533_bl.c
> > index babfd3ceec86..42da652df58d 100644
> > --- a/drivers/video/backlight/lm3533_bl.c
> > +++ b/drivers/video/backlight/lm3533_bl.c
> > @@ -295,13 +293,20 @@ static int lm3533_bl_probe(struct platform_device=
 *pdev)
> >       bl->cb.id =3D lm3533_bl_get_ctrlbank_id(bl);
> >       bl->cb.dev =3D NULL;                      /* until registered */
> >
> > +     name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
> > +                           pdev->name, pdev->id);
> > +     if (!name)
> > +             return -ENOMEM;
> > +
> >       memset(&props, 0, sizeof(props));
> >       props.type =3D BACKLIGHT_RAW;
> >       props.max_brightness =3D LM3533_BL_MAX_BRIGHTNESS;
> > -     props.brightness =3D pdata->default_brightness;
>
> Given the big changes to the driver is there any chance of putting a
> good value in props.scale (BACKLIGHT_SCALE_LINEAR or
> BACKLIGHT_SCALE_NON_LINEAR)?
>
> If the difference between 50% and 100% *looks* like 50% then the scale is
> non-linear (since humn perception of brightness is not linear).
>

Yes! But not in  this patch. This patchset has a dedicated patch
implementing linear and non-linear configuration from tree which may
include this configuration as well. No guarantees though, but I will
keep in mind this request. Thanks!

>
> Daniel.
