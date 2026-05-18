Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B7322B7D
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097885; cv=pass; b=aLTy2vzQhwFbeeW00U8GWn3zdPPtIX8xZ8zVo3GhbCfVgs73B4QwIMjH47JlF4v3MBTrnbL8jDOnhyFK+k8i0q2A6OLJxVphsIXMlqFfEZZZREzYS0AIPRFT3/+GbPfibhnkTEs+zUDpaEa7xPOA7teXxHmRAW113DEn42HidMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097885; c=relaxed/simple;
	bh=JOqNYOpYniKiLryaD7Q8FBNSmyt01Ujzp39DKCKBG8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vo8ci7eD3frLtyeYACGGylmFcslfUVzYQ9WJ2qpTe5qONEP6aneTZFA44ohMmBZGOLE32wZRAzk//15CRC7TyOnqmnsGhwihtYIyGijetXCzXsW4K2FCDMcUB0XyymbFx1o79p6nfnvV6Dx1/zV6UabJBoN4lJazXFriVFjYVew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhE3wCQ0; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhE3wCQ0"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f33ae12f97so7672556eec.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 02:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779097882; cv=none;
        d=google.com; s=arc-20240605;
        b=JhHd1j3tqFhKQAsixhArIh7gka1uxa5q6tVzpgDHUp6C2vVJOMYMZ2yPpSZ/+R6FSL
         fvXiPyyhN4PBObCrfg+VYh8Rrx8SEXQoNUfSkSabTfgPv6uxx7SD0snzYbXxgxsVoCWF
         +F6P2p5u43VTC5AgDNYk5vLFOl/6uc9G0mSukyKJuHVeoUxdjqIMvnRrbbK40vhGFOVx
         iy/5mqms+jmmnJ83m5SyFHpXJBQLfh0FQJQFdBldEbiR6DPLdG+AweHedpGmA7SWlucc
         rXVUYPLiGz1I+khOWpr3TRIfYjXBKCInbKUld/A3/27v4XFoSFXK0pUZrowJr3GILeKh
         DpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FePX2WL11b5dRW+WYbo5NswoFP4g/thJvtgtY1wXay8=;
        fh=aFLn8l4ThzHhxRUwuAUKBtpSH7tMsCxuaPyhqY5bdWU=;
        b=SLbTq8k5dsvscW59zK16QZEKXI3VlYkLwn2mS1FTHWgW2VMfAh7XZhXOdR/Dt2S1Os
         c6fdglCa1rx+70yMK7cGhZH7CsiyfuNo1dwUC0z8FJ+IO/o4nQmCf8Guz32fwOKZRYpF
         8yADsOwnGN/oywMCadEJ7BXwtZtb5tK6F1sDc90uw4sDG8abiOPn89IcW5gMnHihxUZB
         4d/TetZCnAVPjPwB5qCWb6OeqFcH5yj2W3nsRv6e8ZDb24nt5/BOscPbkbIO4LVgs1zM
         83cXBAMFXDbNVVWBUWQHlAG1VMagY8sRrKim8O4JsLk/GcLrrFdT21R1mrQgZsapEega
         klCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779097882; x=1779702682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FePX2WL11b5dRW+WYbo5NswoFP4g/thJvtgtY1wXay8=;
        b=RhE3wCQ0oOeMN7MfcDrswyUcIWD9pJ8hEEqNNEgJej/v03XZnbisRVNEy21JsCAuD0
         O8CxKVFumIUtF+3uQ42UOVYIEi9wcMc90cwHYSLxyl0xRa744xAIoEE5Y2woX468sbfQ
         joafHnsz88TeQiWFZphoG2hZe1jTfZ2M2c/EvAomXv5hGvDNOrTAm9a9cUQ5F0UyXc+4
         Y9e2nHtcfkeOc2QgqvUwDB0EjbUFovCSm0koR2rNlmWrWoAVCBDGmOf7mrt1TYTRNJ8f
         TKCMRz0QYzqBYw8vKS9d42QrF3+gYazrH5JsmMPeUdzsrOfVqCvrLwdAx9rwkkBXd3Uo
         Aqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097882; x=1779702682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FePX2WL11b5dRW+WYbo5NswoFP4g/thJvtgtY1wXay8=;
        b=CKdXtDwEiB0jIMhRXc2i6ydhBzzQC9ZgKlD+aNxGYfnteS8KUG8f+HsBxSAzhr5niw
         mGtnO3nyvIdR7ln/o0hUrk+vgvR5CL5aT6Eaz8CtyLkBoeh/nP5I0/G5sPBXtWcBmw2u
         PuZ6xYubuexr8C68mR1XjjVCzw3MhJDxS8fLl9gknUBYOczutjPUjZSRL2xbU+jaPrNc
         bbB8qUCo2qWVdXc0wrBre0bwiKXr5oALMfnDIcnQK6EC/r30IC97CGiZbLUoPYkdQz+v
         Eu5oO5U0hTgKJ43x0cYEwIFE1vX9A9Gxy9xUIzk+s0in0QP+W5wZVA40C7RPEfAwxQUQ
         sjHg==
X-Forwarded-Encrypted: i=1; AFNElJ/fSnBJEeH56fu0fMNidO5fpP/Q4yhTr9abkJdSCFi6HrW3iyI9DztEtqGYY8OQRqS2/RpVxslOGHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg0bA6kDSY7gFyccpBVD9JPbYqlXKiW2OVwjuc8YoksfLDu82X
	DJ5NnE8BWGbfgXer6bKzfcUbdLNkju3IvqAzk4dmF8OJGQvXFZOAB3QtMhQdkDSeUwQHSw/8Spo
	+65a8gsDn6rAmn5TwI8rcuzNKONXbcfE=
X-Gm-Gg: Acq92OHUfSTN0DJvcopuuwvflhWCAo2dZs8gy/kg2z7+mb9k53dx0g3D3vGexsKfBjH
	+npDMMOGQmlVeRkJ6FUJaBxnK3r9oproLqqz2zIjMrluJCPZqic1COOVeOcEZjG1GEA/DdMeI/p
	5Kjcq/ye6vNkB7Dtm8P5glfV//Ojzer2yFYeYsu7ceBUsaXxiH9ZHSULrPY63wdlIvkSa9Z4krL
	qO6O8I8nOHTZywt80f8ONL/zQDrSIG8I5csBuk2ZrYN8rHkIpwLycMki7ZAYjJygOtNKLG6b4vR
	yvtztt6weKhGaFGuUkcF/xL/tar/VQ==
X-Received: by 2002:a05:7301:688:b0:2ed:e16:6b4a with SMTP id
 5a478bee46e88-3039869b963mr6436744eec.32.1779097882266; Mon, 18 May 2026
 02:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <20260517074306.30937-3-clamor95@gmail.com>
 <CAPVz0n3gLYXab4H+DihfTkdBkGPqTvmoFVY1Cwuafd70KPtYbA@mail.gmail.com> <20260518092833.GR305027@google.com>
In-Reply-To: <20260518092833.GR305027@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 18 May 2026 12:51:11 +0300
X-Gm-Features: AVHnY4IgFlUyRpln1URXZyQyooZBVQu7rOOaMkPI7Cfdheurgkdm_oeKquAVOyE
Message-ID: <CAPVz0n3QAGk_iebCQdEnv_fG2nnGdM1xm__=wG+4KqVJzs-T_g@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] mfd: lm3533: Convert to use OF bindings
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Rob Herring <robh@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 18 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12:2=
8 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 17 May 2026, Svyatoslav Ryhel wrote:
>
> > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
10:43 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Since there are no users of this driver via platform data, remove the
> > > platform data support and switch to using Device Tree bindings.
> > > Additionally, optimize functions used only by platform data.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/iio/light/lm3533-als.c      | 123 +++++--------
> > >  drivers/leds/leds-lm3533.c          |  60 ++++---
> > >  drivers/mfd/lm3533-core.c           | 257 +++++++++-----------------=
--
> > >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> > >  include/linux/mfd/lm3533.h          |  51 +-----
> > >  5 files changed, 202 insertions(+), 341 deletions(-)
>
> Please snip replies.
>
> [...]
>
> > > -static int lm3533_device_led_init(struct lm3533 *lm3533)
> > > -{
> > > -       struct lm3533_platform_data *pdata =3D dev_get_platdata(lm353=
3->dev);
> > > -       int i;
> > > -       int ret;
> > > -
> > > -       if (!pdata->leds || pdata->num_leds =3D=3D 0)
> > > -               return 0;
> > > -
> > > -       if (pdata->num_leds > ARRAY_SIZE(lm3533_led_devs))
> > > -               pdata->num_leds =3D ARRAY_SIZE(lm3533_led_devs);
> > > -
> > > -       for (i =3D 0; i < pdata->num_leds; ++i) {
> > > -               lm3533_led_devs[i].platform_data =3D &pdata->leds[i];
> > > -               lm3533_led_devs[i].pdata_size =3D sizeof(pdata->leds[=
i]);
> > > +               dev_err(dev, "failed to set boost ovp\n");
> > > +               goto err_disable;
> > >         }
> > >
> > > -       ret =3D mfd_add_devices(lm3533->dev, 0, lm3533_led_devs,
> > > -                             pdata->num_leds, NULL, 0, NULL);
> > > +       ret =3D devm_mfd_add_devices(dev, 0, lm3533_child_devices,
> > > +                                  ARRAY_SIZE(lm3533_child_devices),
> > > +                                  NULL, 0, NULL);
> >
> > Question to Lee Jones. Would you find acceptable if the driver will
> > build cell list dynamically based on the nodes in the device tree?
> > This is LED controller after all, not all leds can be populated and
> > same LED control bank can be linked to all LVLEDs for example.
> >
> > If you are ok, would this implementation satisfy you?
>
> Generally not.  Create the non-dynamical information statically
> (obviously not 'const'), then you can add dynamic data as you go.
>

Hm, code I have proposed below creates mfd_cell structure with 7 cells
(max amount of children), and fills each slot with devices described
in the device tree. This seems to fit your expectation. LM3533 is
basically a LED controller but it is set as mfd and IMHO would be
undesirable to create dummy devices.

> >         struct mfd_cell lm3533_cells[LM3533_CELLS_MAX];
> >         u32 count =3D 0, reg;
> >         int ret;
> >
> >         device_for_each_child_node_scoped(lm3533->dev, child) {
> >                 if (!fwnode_device_is_available(child))
> >                         continue;
> >
> >                 if (count >=3D LM3533_CELLS_MAX)
> >                         break;
> >
> >                 if (fwnode_device_is_compatible(child, "ti,lm3533-als")=
) {
> >                         lm3533_cells[count].name =3D "lm3533-als";
> >                         lm3533_cells[count].id =3D PLATFORM_DEVID_NONE;
> >                         lm3533_cells[count].of_compatible =3D "ti,lm353=
3-als";
> >
> >                         lm3533->have_als =3D true;
> >                 }
> >
> >                 if (fwnode_device_is_compatible(child, "ti,lm3533-backl=
ight")) {
> >                         ret =3D fwnode_property_read_u32(child, "reg", =
&reg);
> >                         if (ret || reg > LM3533_HVLED_ID_MAX) {
> >                                 dev_err(dev, "invalid backlight reg %d\=
n", reg);
> >                                 continue;
> >                         }
> >
> >                         lm3533_cells[count].name =3D "lm3533-backlight"=
;
> >                         lm3533_cells[count].id =3D reg;
> >                         lm3533_cells[count].of_compatible =3D
> > "ti,lm3533-backlight";
> >
> >                         lm3533->have_backlights =3D true;
> >                 }
> >
> >                 if (fwnode_device_is_compatible(child, "ti,lm3533-leds"=
)) {
> >                         ret =3D fwnode_property_read_u32(child, "reg", =
&reg);
> >                         if (ret || reg < LM3533_HVLED_ID_MAX ||
> >                             reg > LM3533_LVLED_ID_MAX) {
> >                                 dev_err(dev, "invalid LED reg %d\n", re=
g);
> >                                 continue;
> >                         }
> >
> >                         lm3533_cells[count].name =3D "lm3533-leds";
> >                         lm3533_cells[count].id =3D reg - LM3533_HVLED_I=
D_MAX;
> >                         lm3533_cells[count].of_compatible =3D "ti,lm353=
3-leds";
> >
> >                         lm3533->have_leds =3D true;
> >                 }
> >
> >                 count++;
> >         }
> >
> > >         if (ret) {
> > > -               dev_err(lm3533->dev, "failed to add LED devices\n");
> > > -               return ret;
> > > -       }
> > > -
> > > -       lm3533->have_leds =3D 1;
> > > -
> > > -       return 0;
> > > -}
>
> [...]
>
> --
> Lee Jones
