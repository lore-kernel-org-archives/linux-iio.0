Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862D36B046
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506402; cv=pass; b=a2KUJmsD6Fj5i0lJLo/W//bKp+Dr1H56TukYtIAbGjWQc3erNXdyGyLe9C3j7bYIxhuXSLevhLkceALR0gtMjPxlcMD1to3A8wpWohUN/cd582NxAI+zchPpqGk1Q+Bq6ri7PJo6tpSbsvVBY5Tc+lgRVKfrI39WZFic74Rjz6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506402; c=relaxed/simple;
	bh=0dqv6rg6at/n/ydX5KhBQucnr/QZNXAlgAZaZVReFlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnGktVQkrzwaBZvKC4qTBWVQoYGLpUSIpBQqEGKfO3TBptQ5EAIjgy4auH2aZGZQkGBjF/JqE/0ytoBzUU/sj00kbKUTUE92N29eLP3JZZMj0V6WlN/96ThBz14itiIXHhJbMx9gJtR2mb0kbelF1jr3KS8rONdLpUuy8owUJIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBF4PA+u; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBF4PA+u"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso4280961e87.1
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 06:33:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506399; cv=none;
        d=google.com; s=arc-20240605;
        b=O4ojwvYMeb9hPN4jRvTziq1A+PX8OE9/IeKS7oDgNVMacGPK7K2esy5lwoV9de/Or0
         PUx9dueb5Usu/V2IV+0FmBV2EjtQKMRaRX1rU1tt60EOmvKNhmIZ5fIli9hOeKC2y/na
         auKtdUKrqZixgEdUk72l0TI55niJNm3PABw//6szArcNYOAlqaunyvha8O/iVhNyvVA5
         vTg4Pa4kpsdBKf58xnH6h6WHVK6T60DR3cj0Um+Ko0wwnpCI/+TfXroQ4Pi7bxDCZnHI
         wpFyAiZAyeDVndlvcHAYdL+KfpuhEmFrp/J7oWmEfFdcRlKUB0pO15XzOPsschxp5OPV
         k+QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kIWp26Hy9F0H3x43nSWzX2WvHDPBroASUtt08nDdnMw=;
        fh=EDf6Mi7UWhzfXrc7elg+svpFpF9BxJH9uhI9tqXme5c=;
        b=eT4Xi7RbXv8cDpvDChjqbl84Z+yvYdiqYME1NMxXe4pHldRJIbhrfaqDeAYBReCpEG
         HyPSFQZsntUi5yZemHauLQZlTnNzvHMqFrd8LNHvuxSroc6hrjRRbcs8ox6/wuyOpEka
         NK/PhTp1HJqnH1ICPosga1rsabM74KwiBpGv3Y3shnUJbAPvif74BW9GpCMHoR4Esz3P
         nJANAtDlxf/LZ/w7qCoTQaP75jzKOQO0m/wfxruzZxzPm6MRpOHRg05WsQTh/vCIavVl
         pCCMy9vuc+f05AB46Dmq09+1fDsNr5f4oUsa12pksRPv2a9k33iifFQmiFggJ/u125TF
         kL7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778506399; x=1779111199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kIWp26Hy9F0H3x43nSWzX2WvHDPBroASUtt08nDdnMw=;
        b=hBF4PA+u06woOqhDZgt949M+r0B1SNt103e/mUZI33H3Mikq7gmQWq31Wy8eyDBhtJ
         AMcGR//D4JawMbALF+2NwKslR2DAUAqNsSTttz+avYE4WyYwfQ0vFSjQ/Ingqod4WMlF
         ZS93k8ceS8quVKe/tkMYBzyRO1RZOU/fYL2GoE35rmxy9jvO4nT+WauWp9wjOOwOUP8Z
         peh2Q0dytH34q9fXGhaRF6Lly54y4xd9FvtJ21Y50swmUC9aCmUEV6RpVc/qN6wd2x+M
         +I+PSgdxXF25idbVHYtcPYG7n+B1MMs4zhgzYQHutPfbF9VUjzUlpV2fY6QrDMRiTynI
         eF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506399; x=1779111199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIWp26Hy9F0H3x43nSWzX2WvHDPBroASUtt08nDdnMw=;
        b=a7IQFHc81PJjqXl5vz6KRD4NiVUguwUuERwfQKCoaWSf9IhV1QED8/0vpSHb2XrT5Z
         VBzpXBSHNw1RIs34aGDon9WFFuhULUkRVcqAvIuaHnlqhR/bjf5Clq9ce7Cf3rvOnk5J
         IawfV3k0mgEOkepfsmo+iTUdsCrZOtmsfgsJzo+lVt3IbumzGLJFJLtKU+WLhjxaypoi
         +nUOX+45ho6zL9GBNSfu5NU0zYjwX7kSV1Z9Zr8p4QrPoiLl4kWEmJUG33oeYoL1t9eg
         asjeMn/Dj0sdKrkuY1sa33jt+JLNLxOli1WyehGC3KSNSlqZExywo3PfRhKaY0MSLpxR
         F34Q==
X-Forwarded-Encrypted: i=1; AFNElJ/g55X5i5TXG6cYVxLem7K713R38Tks5qsrIzDurwvT/Oqskq+VXr/wMVU+k5srp5T9prudwsXSRAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Zt8QQ06iN3dzMFbzK53FuPJqyOagsO7Ajvhb3y4JwfTxnafQ
	yHbeXJRRa+9EC0HEq+cKnocv9XSqsR6ziLpABlOdTzWBHC88+OLgipY5M+tkSiCNAldgax0BMoP
	sLZSs00T2GygPTg6fRyeIvvRsm65ITP4=
X-Gm-Gg: Acq92OGRMJCi34kdzta8d9n6qGdxnlGGnpjlj1tltgzwgET7qhD+5FMCudGQmV5ZKJL
	J+x2MJSIzilOhEvYAAEDoaDa3HsY7p0NDIlaHNj/9AsNBVr3TV67ERzaZ08kNctbfBHdIiwaBrN
	InaDpE5wx/adXgMIy9Rz+iontG62TZTSodGval0tMwjjMNUl0gzXDY2V6HDfqUEvwO7EXZw2ryc
	BlB3s+7YZjaM6wfmgajwG50lpTYFu7z+yQGQHsg0TkHL2CVdNSuNdgbMAYwi/XGb8fnRdOj67N9
	AK3e+UT26HrWmnS3KI1vxihKnsan/ywrvEC6fTHwM0s6Jo2QSR7J3jkq62JOs90VOsFJyfC8HId
	ZuoBPfaMUYlYfLwblT/9mhm6SDOPLl2sTdlcUciJARK4aHXhgnaSt0PRrqcvu18nk1FW0Go13V4
	8tDgmolA==
X-Received: by 2002:a05:6512:ad3:b0:5a8:9c2f:5712 with SMTP id
 2adb3069b0e04-5a8b70926a4mr3313671e87.21.1778506398662; Mon, 11 May 2026
 06:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511060732.7728-1-sozdayvek@gmail.com>
In-Reply-To: <20260511060732.7728-1-sozdayvek@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 15:33:06 +0200
X-Gm-Features: AVHnY4JvYPGQR_LW2nN-EVyDT-22t_gguZpJqI20_yZEF5oURhE1GzClPAmXrgg
Message-ID: <CALoEA-wQ_hYsP8iOhHf6yAzpgA-Bq+78bC=BqZdaPcz9bW1Gww@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 15:23, Stepan Ionichev <sozdayvek@gmail.com> wrote:
>
> Convert to devm_iio_trigger_alloc(), devm_request_irq() and
> devm_iio_trigger_register(). The driver-managed lifecycle removes
> the manual error-cleanup ladder in probe and the entire .remove
> callback.
>
> Drop the now-unused iio_interrupt_trigger_info structure: its
> only purpose was to hold the IRQ number for the manual free_irq()
> call in .remove, which is no longer needed. The matching
> linux/slab.h include is also dropped.
>
> No functional change.

I would say that this is a functional change, you are changing
how resources are managed and how teardown works. (But
maybe I'm wrong).

> @@ -42,61 +36,22 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>
>         irq = irq_res->start;
>
> -       trig = iio_trigger_alloc(NULL, "irqtrig%d", irq);
> -       if (!trig) {
> -               ret = -ENOMEM;
> -               goto error_ret;
> -       }
> +       trig = devm_iio_trigger_alloc(&pdev->dev, "irqtrig%d", irq);

You can deal with this in another patch, but consider introducing
a local struct device variable, so you don't have to use &pdev->dev
constantly. It makes the code easier to read and saves space!

> +       if (!trig)
> +               return -ENOMEM;
>
> -       trig_info = kzalloc_obj(*trig_info);
> -       if (!trig_info) {
> -               ret = -ENOMEM;
> -               goto error_free_trigger;
> -       }
> -       iio_trigger_set_drvdata(trig, trig_info);
> -       trig_info->irq = irq;
> -       ret = request_irq(irq, iio_interrupt_trigger_poll,
> -                         irqflags, trig->name, trig);
> +       ret = devm_request_irq(&pdev->dev, irq, iio_interrupt_trigger_poll,
> +                              irqflags, trig->name, trig);
>         if (ret) {
> -               dev_err(&pdev->dev,
> -                       "request IRQ-%d failed", irq);
> -               goto error_free_trig_info;
> +               dev_err(&pdev->dev, "request IRQ-%d failed", irq);
> +               return ret;

If I'm not mistaken, devm_request_irq automatically throws an error on
failure, so the dev_err() call is redundant, just keep the return.

-- 
Kind regards

CJD
