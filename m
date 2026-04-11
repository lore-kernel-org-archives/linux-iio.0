Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D954774
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775915143; cv=none; b=nI/WLtcRvbKM3AZ5zD4ivBsBFph6R92tH1aVInKgXx7AfTC1KPXScQHnKQC2nmujSvMu0MhOtSO0+n6HatDQVdEIq6jP/GKI/WTCsg26FFkVYw4qh9DWgW7Z2sW8mNiZTHyxAvJNaTidCHnUI2oSoCjz8f2AqyRhga96+QWEU3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775915143; c=relaxed/simple;
	bh=gM03TCl7w7c/RQKi/k8J+JorSAJoRcRuK4jBgMduOZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SvycOM4cswtlqQKOZfsGCU/1q/x8m1+lA4h8L7QzhecmgFPUBw2GHd6zH+6zdswoPCiZ6t0GOQ1bqMmAv6nz/rW3Dzk3NKkDe/M8B07RqBkb0hkwupxk4fpmfQ7MchAAknmm4NzeO7YLWmjZlOwd1k50ufO97nivWvp37FTdvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrsrmOMl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrsrmOMl"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48896199cbaso31725595e9.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775915140; x=1776519940; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0UFwY4repTmIKGT+XQZhuhyN1RmFMzV9M/LAa3y/j0g=;
        b=UrsrmOMlp5yw88gOmClUF8QOUeekFsVmepPBXPaszKMUHojyC0WxhWo89wLz2ib3fm
         fQAdz49onBWX7/vsY1JzysBNnh5b5Rdjk4j6YAkGMZzf+iGfJDDsZlod6u0hgVX95f+5
         hRGkp579kG9KVmvrJL9fD5HGGncQkeLo8nZMgQbFNE0bQHerW/zFgjMh4c1HUZ7kf6S4
         VlayBmxVB5LfC6PiIiqgWtWhGmjvbgAVsnEcb0jbGF527+kicvi90dYiTuuNYNeSdcYM
         pDqmOwai7YC9n4ULpG3a7p51NCW+JbFWSVV8v+WNFpceF0KdfaKbit22OMs70f3NmzC5
         /8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775915140; x=1776519940;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UFwY4repTmIKGT+XQZhuhyN1RmFMzV9M/LAa3y/j0g=;
        b=q4XReF3UVOua+MVK55GAtrfqII6XP68PIwOOXm+n3GakUC1mZ4c7dwpG50tE/pRgV8
         MI9etNchLrjNVjrDgJ+YBRNQ9vjgZ85uSI+y+m6nrANhUDAevHnwsLGrDNKpPHxXwx0d
         WwUHFlTbXcCOvHddmrULwBRPKFyzUosYHOlXyXhrOj9w1yqMnpdiJ926hDP7JNPEK+eH
         HH3ATIbT8012Ec2X6FuFpYa8oQOqlu+K5o+DTb63W7OyJfnb13bBq7LrN1YaPCeT1aNX
         nH+RtfeVicYyeMBs+HtsYfaXU/bpkMAowFp7lSlw5vUMpQoFbE3vHVGaH2+tF1r52fq5
         3hIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6x76YEjvbcVOU1vHuDcD6zYCcKDpgjRc/oTGDeBNG/59hAAm+7RSSt7drVU7jVMzQNIjFXxtfHSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2vpt6mRC9/u9qkrMdB5u+4d9d6L6A83U73F90b7vcohDSKlr
	vP3ZfqMCXW3s+6m2oFyIDhD/IMBJcJ/GmcZIxRP+ywAlbSNWs/h9sEdN
X-Gm-Gg: AeBDieuLdR/J7/jp12Jplb20ef8Ct76jC+Gf78zZrZBWOZEKOI5bkcV17BDH9vDp6S8
	QT4hfMz0B71xt1lz6+mZ2KZticvZ9KrPhNynii7hF1MPYAcW4dUwGqfGcDjqE7EXK8qjlRlG1K9
	rmurL5kxv/a2lGeeUFJ3HDxAhHCrDK3jrWolnr9GHV3HwttZkaRzHc3Gr7AMG56YQ4WPekOUzw1
	jVr/GQrmSHnX8fCrwdtu1wjtRYjQBhLVJ4sC0Vya2VJUWeb4TdVNwiuIIGWiyjBORrrSZMQ1Snl
	3ixTK3Tp7+J7e0aJ7lTm1/TMnbaaTz4mITQK3FomiuvsQbMbi5tq53obzwwC01pinwFqChouxRE
	eb/yZzBdn3MErdEWxjOQhhHn4YsXjHpSt2OA+hbIjhNmtrsu8xnGh8y+zI4AKx7xmpY1Tsl/6Zb
	k1tk1P6qpe7nZC9lyMZUJtMElXbRukQuJg9L/5uLoZoZl5Soc2nqsPmg2Bmo20+ear8wXP2ET9Z
	w==
X-Received: by 2002:a05:600c:4443:b0:488:8577:d9cc with SMTP id 5b1f17b1804b1-488d686be7bmr90636995e9.20.1775915140383;
        Sat, 11 Apr 2026 06:45:40 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d538a296sm148037005e9.12.2026.04.11.06.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 06:45:40 -0700 (PDT)
Message-ID: <ced8767f3e26e3e4c92f51cdffa3b967ab6eca28.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: npcm: fix unbalanced clk_disable_unprepare()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Carlier <devnexen@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Tomer Maimon <tmaimon77@gmail.com>, Avi Fishman
 <avifishman70@gmail.com>,  Tali Perry <tali.perry1@gmail.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Patrick Venture	
 <venture@google.com>, Nancy Yuen <yuenn@google.com>, Benjamin Fair	
 <benjaminfair@google.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, 	linux-iio@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 11 Apr 2026 13:46:49 +0100
In-Reply-To: <20260411123517.15083-1-devnexen@gmail.com>
References: <20260411123517.15083-1-devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-04-11 at 13:35 +0100, David Carlier wrote:
> The driver acquired the ADC clock with devm_clk_get() and read its
> rate, but never called clk_prepare_enable(). The probe error path and
> npcm_adc_remove() both called clk_disable_unprepare() unconditionally,
> causing the clk framework's enable/prepare counts to underflow on
> probe failure or module unbind.
>=20
> The issue went unnoticed because NPCM BMC firmware leaves the ADC
> clock enabled at boot, so the driver happened to work in practice.
>=20
> Switch to devm_clk_get_enabled() so the clock is properly enabled
> during probe and automatically released by the device-managed
> cleanup, and drop the now-redundant clk_disable_unprepare() from
> both the probe error path and remove().
>=20
> Fixes: 9bf85fbc9d8f ("iio: adc: add NPCM ADC driver")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/npcm_adc.c | 17 ++++++-----------
> =C2=A01 file changed, 6 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> index ddabb9600d46..6acafef3e7c7 100644
> --- a/drivers/iio/adc/npcm_adc.c
> +++ b/drivers/iio/adc/npcm_adc.c
> @@ -231,7 +231,7 @@ static int npcm_adc_probe(struct platform_device *pde=
v)
> =C2=A0	if (IS_ERR(info->reset))
> =C2=A0		return PTR_ERR(info->reset);
> =C2=A0
> -	info->adc_clk =3D devm_clk_get(&pdev->dev, NULL);
> +	info->adc_clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> =C2=A0	if (IS_ERR(info->adc_clk)) {
> =C2=A0		dev_warn(&pdev->dev, "ADC clock failed: can't read clk\n");
> =C2=A0		return PTR_ERR(info->adc_clk);
> @@ -244,16 +244,14 @@ static int npcm_adc_probe(struct platform_device *p=
dev)
> =C2=A0	info->adc_sample_hz =3D clk_get_rate(info->adc_clk) / ((div + 1) *=
 2);
> =C2=A0
> =C2=A0	irq =3D platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		ret =3D irq;
> -		goto err_disable_clk;
> -	}
> +	if (irq < 0)
> +		return irq;
> =C2=A0
> =C2=A0	ret =3D devm_request_irq(&pdev->dev, irq, npcm_adc_isr, 0,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "NPCM_ADC", indio_dev);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(dev, "failed requesting interrupt\n");
> -		goto err_disable_clk;
> +		return ret;
> =C2=A0	}
> =C2=A0
> =C2=A0	reg_con =3D ioread32(info->regs + NPCM_ADCCON);
> @@ -262,7 +260,7 @@ static int npcm_adc_probe(struct platform_device *pde=
v)
> =C2=A0		ret =3D regulator_enable(info->vref);
> =C2=A0		if (ret) {
> =C2=A0			dev_err(&pdev->dev, "Can't enable ADC reference
> voltage\n");
> -			goto err_disable_clk;
> +			return ret;
> =C2=A0		}
> =C2=A0
> =C2=A0		iowrite32(reg_con & ~NPCM_ADCCON_REFSEL,
> @@ -274,7 +272,7 @@ static int npcm_adc_probe(struct platform_device *pde=
v)
> =C2=A0		 */
> =C2=A0		if (PTR_ERR(info->vref) !=3D -ENODEV) {
> =C2=A0			ret =3D PTR_ERR(info->vref);
> -			goto err_disable_clk;
> +			return ret;
> =C2=A0		}
> =C2=A0
> =C2=A0		/* Use internal reference */
> @@ -314,8 +312,6 @@ static int npcm_adc_probe(struct platform_device *pde=
v)
> =C2=A0	iowrite32(reg_con & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON)=
;
> =C2=A0	if (!IS_ERR(info->vref))
> =C2=A0		regulator_disable(info->vref);
> -err_disable_clk:
> -	clk_disable_unprepare(info->adc_clk);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}
> @@ -332,7 +328,6 @@ static void npcm_adc_remove(struct platform_device *p=
dev)
> =C2=A0	iowrite32(regtemp & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON)=
;
> =C2=A0	if (!IS_ERR(info->vref))
> =C2=A0		regulator_disable(info->vref);
> -	clk_disable_unprepare(info->adc_clk);
> =C2=A0}
> =C2=A0
> =C2=A0static struct platform_driver npcm_adc_driver =3D {
