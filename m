Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC222E3B15
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776618062; cv=pass; b=SdPl9wzMxh34U3WxfNz0VVkqgmhLE2qXsNkLVMGTp1m/ewf8DF+IXJmaEngR7axF5NP5rrYE3RKFpL4GPcbKu9sHyaDsY+rz0WuXHQ8EhiwB1poOyChoNG8EK7AWIO6eWOQMA9krBqevI7uRU2ahguAcvxseUuBL1gC3yEjWMKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776618062; c=relaxed/simple;
	bh=3IVX3mPadYw7Y8PWdSOPUq5vmc840yeyBUQcAGUehEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqhiCu5R0WvwH22kDY0rXq5pi5zVq8gFG/52rl/0fMrgf8KA+8Lay1LxF7nihDKztDG7bx5NmLFmUYI9qUcpmzYQUstPzWKnSRjvKu+pSp8yfSihzsuzrKhy/hQv1hxLfzxt6IYTH2+RV9r1JYmO9MAGLrA3gk4b2OukNCEg0yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbnkZv1d; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbnkZv1d"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e7d984096so23963171fa.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 10:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776618058; cv=none;
        d=google.com; s=arc-20240605;
        b=K3dCCCBB4M4bH0T4hWyNDUqIM2Xa2YoXzEMcHpPkh0OqrofgiK+HrJfV56QubVsLxp
         0R41wqgVdP4EqG6IzjwwIiup630uJRzQrkmhVVWs0vxzrVrjWhdkJVlMK2UHYcE58qRd
         ORUo5/t3i47fJAmwTT5J+cObqLwcug8krbVpLtai6YOf9ljS093G8J7q7B+jJxcs1B1L
         7cJUdxZTqO4PBRJ3ULEWASK07H6jos0OgPbdeYLPeTafKbhmTMlpcsLoR7kWgq7xlAi2
         mr6O0Co9uCOh8lflDafR8YO6DULX8GE+mlHAeWuaFFN/u5ilQ1rdOJdKIvccYGh6RK4N
         ymFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xkhdltVumitpSmKaTUVJqyxKB6diuW27dEhruYrPI+Q=;
        fh=xN36tG+1ebjYpBhMDgoUtkfnBshhntreTwOZVEQJyHQ=;
        b=AmDlsJBwN2JtYcsQRWgN2g4XOXk6NcVIOSAvT41bICtnDc+cXsn6iuwg4YRuepJ8TS
         S1OufdGgTMg773ZCF9EioLorYxWQP9efevaDY9w0vlrnOacuNvumu07GdmZhfsrqURg2
         vtEzBMCMYE5mXy6DvutDdlIPS0dYrBFrkDYlGdU7pxKGIml+Dg+ok5goBSr9N+3xWYJE
         TPoUGhZEzJKQbnuj7oXkHsuhDNpYRjHmnTY03YkgBdJQQ3Jn6XK9x3SoJrwEt1k9/qkv
         vxXr/a8fL1ntDTe5fzfsmJy8/uv1fKgby9ex9oX4UxiYp9uVjqPGRi+cUqnvm6Yrenys
         UHPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776618058; x=1777222858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkhdltVumitpSmKaTUVJqyxKB6diuW27dEhruYrPI+Q=;
        b=HbnkZv1dYLazgPPkSB6kcJWJAnAOYEEkp+h7Rm1CHAohxUlU2sjDhsRw8kYY6ADgWC
         YY079cVKYs+kXtsXdhNU+oXkeM6KcEZVmvTfzcajn8DXJnUnkD8/HrXcwSqnEtnaQttU
         3GNtL3xRvLzf0Myb0kWReV29UG7INLvIoMMrP/4eRk2vQ00TS2VeSPk2oNYxwkz1T5zi
         D98BneXqMDSrm7NkFld70Yh8nMJ50OVC1q2E1zc7SA1sSlE8H7voMXg4sCZrFkAvE3/z
         cdB+TKPr7YFawJEqdAlsuZohrqDFAfq59ja9a6mewwIgGJ/Kw4gUUzdyyJPkyEyP09yF
         igHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776618058; x=1777222858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkhdltVumitpSmKaTUVJqyxKB6diuW27dEhruYrPI+Q=;
        b=c6ctUgJCOnOrfIboms/hQ474vfKtmQcB+KUUa+VjVumxb/CSFUZcvB6SMAMe3FK/j/
         XU8f84hrJOMsrwoyhMXxrnoHk880ZBzVII6ZWsgfvbJLP9L3YBX0911XpobdqsHWs/XP
         eRlb40WIqF9//3ng01WowhJ6tMpicN6itP8RkLtO6R4aOf9ZApzlQopeyl18+/9jgbM5
         6QOF1oGQbRKzMbKdGpnS5AvJq/fa85Q9lPsY5HSH4B6yCxeEy+YdZhjH+S6DxJymyTvi
         B8VDt8+YHkqukZYD3HpJAFimoO51vOlTrnLOKwHwvjerF5zm57IieMpbJvYTz2sfGOgH
         0n/Q==
X-Gm-Message-State: AOJu0YxBhXV9Q7VTKx+pZe+vfyrd5JFx5bN5Zc1VBLpH6dpNG9ZotlDB
	lpGn5WnotDLHBACnFSCg4oRee22UBbbsQvQiiIhAn1U+EInMrsJv+wYwC8V0w4XJ2eOLTlGcGEc
	EPXVFAxWEpoMILLyuqNjV/nq/qxYo+Pk=
X-Gm-Gg: AeBDietjWqCtveC3ttCvk1exNG79KdlhCN+Sn414h93kLLspO2KnM7YV6Vj0+2T1bei
	7vMktVrsB08m+3M5PIqGNnnKSa4GznIo2uYXlNOcMcczVFi7z/HXGPXlBEulW6o7PKicj+Rh4kC
	tT3ztMnPnkVy0igtHNfoD65aw29e/1OTvIM4efIf6RBMIMgwu7NhgK5mJtZXocWqCf0m+4+gy6D
	yCeIk1Qfk3mahrLEvQj6xPfhdRIjIr/QVR2YTPDuB6fNkNTuu5rwOEFpwzsGDan1EuaQbuThRiG
	E7gYOgTXczbjcjJTjUdErPJdOBZ+r9dO3W9oAXUteTJsgZZ2Wvbd+Zjy70S/eB9LGejNf3l58z9
	iy010
X-Received: by 2002:a05:651c:502:b0:38e:9638:d718 with SMTP id
 38308e7fff4ca-38ec7835c1amr30835871fa.13.1776618057453; Sun, 19 Apr 2026
 10:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410214130.188694-1-piyushpatle228@gmail.com> <58af4ec0-f00b-42d9-89a9-542228488980@oss.qualcomm.com>
In-Reply-To: <58af4ec0-f00b-42d9-89a9-542228488980@oss.qualcomm.com>
From: Piyush Patle <piyushpatle228@gmail.com>
Date: Sun, 19 Apr 2026 22:30:19 +0530
X-Gm-Features: AQROBzBC-c2HJAFG_ISABsYhWt8atZa3hT1HQs-i4i7XiRePOovDSknrdSAEbbs
Message-ID: <CAMB+xkb+R2ODUx+dn3W5k5+3-QbH5PSxE1hcET_hLrRk7QQe3Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: nxp-sar-adc: use field_get() for EOC bit check
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>, Felix Gu <ustc.gu@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 7:53=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 4/10/26 23:41, Piyush Patle wrote:
> > Use field_get() here now that runtime-mask support exists, and drop
> > the obsolete TODO. Since NXP_SAR_ADC_EOC_CH(c) is BIT(c), the
> > resulting !-test is semantically identical.
> >
> > No functional change.
> >
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
>
> Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>
> > ---
> >   drivers/iio/adc/nxp-sar-adc.c | 6 +-----
> >   1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-ad=
c.c
> > index 58103bf16aff..d6c2a0d50bb4 100644
> > --- a/drivers/iio/adc/nxp-sar-adc.c
> > +++ b/drivers/iio/adc/nxp-sar-adc.c
> > @@ -316,11 +316,7 @@ static int nxp_sar_adc_read_data(struct nxp_sar_ad=
c *info, unsigned int chan)
> >
> >       ceocfr =3D readl(NXP_SAR_ADC_CEOCFR0(info->regs));
> >
> > -     /*
> > -      * FIELD_GET() can not be used here because EOC_CH is not constan=
t.
> > -      * TODO: Switch to field_get() when it will be available.
> > -      */
> > -     if (!(NXP_SAR_ADC_EOC_CH(chan) & ceocfr))
> > +     if (!field_get(NXP_SAR_ADC_EOC_CH(chan), ceocfr))
> >               return -EIO;
> >
> >       cdr =3D readl(NXP_SAR_ADC_CDR(info->regs, chan));
>

Hi,
Gentle ping on this patch.

I=E2=80=99d appreciate any feedback whenever you get time, or let me know i=
f I
should resend/rework anything.

Regards,
Piyush
