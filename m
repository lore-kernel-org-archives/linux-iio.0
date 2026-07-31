Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E903D3310
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491607; cv=none; b=j2fk0bsa2+16Ewo6Ily/VCQ17OBPkWW5cBqCLWpqiI4tEn6RU8p9xpSMY5DamStWeWmi8a0o5wofVtu1PjchD3Ow866o8R5ldIH515yTV4oF9AGAk/PjKAJjQkWuCdpGp3sjkeMWAGV8ABdNvzg9Sadek62KE0IBdbd6nGX7lgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491607; c=relaxed/simple;
	bh=O2hr3mgkWv9ZH0QPbcAjngEx9k1/2RVfWmF8S8xTYno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZfWUBTz+iI729s0YMDL0L/tZDzC8lfkk3IwlIXsfONHh5uRzLACknx9/lCQ8utuWRtMaN6dAmlrNSvYmkfogRSnngJnAtH1Gyq1Pm2Egwe3W+af5XspDeg9MlqGy/GRE5E/5wZvqxwGnUvDqmPVZbiuA/yw2Dq4pmR/Tqytdog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peRiO/aj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peRiO/aj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f84023916so801778f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785491591; x=1786096391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fwbZejQtpnuo86QdZNkvfiwPzfIoi9keDu3oZjpOvc0=;
        b=peRiO/ajL9HZlJB4kLNz2iyYZ5sS/d9c7VptVlBfxGBBWLKcTx9jlm1G0AdNrz+/Da
         U6L6LXKeohO81z+I4ZtbsoYg4q0b0nUgqfiWEqYLmsQN9dEWvV1Uqg4qKlNEVCVZJkbt
         u7TEL/bw0OwJyVU1jA5E37FZIKEnNTQGOmex+KdgUHPyPK8MWt/sbMDuE4siuEMeQxKJ
         pZXMJw2+E57XmDZv+9fbHh3c1TwD5jR1kscw8aFwIK7wXRETlrUVFc47mLWk5ZAP7A90
         QPYUEe9/ATNo/502NgCyke64jg/Zkud6JS9JfLWjQs6iwjsOtim6sYYoh0TgQZ8ssZKY
         8Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785491591; x=1786096391;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwbZejQtpnuo86QdZNkvfiwPzfIoi9keDu3oZjpOvc0=;
        b=oAqkfZJw6ZlYf8g1EfCLyB+VW22xydI08B1/LMSQ6ERH+I2mSRHmrJ1HqxIBY6P7O2
         zYOjBV0BTAi7M+K4U4gBcmaeOD9wdJjPEx+K4SSOweqd6TGKC+2YU1qEi8woX21vEqDY
         ZlqepfW8oxz2W89IXK5bb/EizVP04FRmql30SDgRup9KQgc6tRPA/FT1VuK0VKayVJRl
         NpQcjChCc6LeVrM+VJd0hOr9M7gwe1CVXGeXFiWhNO4KrXvzasWWeZ87B4a4RmQu7lu7
         Qo4zOd5CTeJAW1dodwc++Xf1EUglYpPhsUOt0O3oegbGyI7JYlxwPZBtGJjHWDJ7t4Rv
         KoNw==
X-Forwarded-Encrypted: i=1; AHgh+RrCyEjROVg5viJNYTrdR6Mb2Ylx5YcMHOuEoiFpY07bN5ehkbBv5Pf0M+S/GoRgUfKRCRxeX3iFFb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvmmGJZmXlgcxZ3IkfXEj/l+fm/l++KneqQy+5LiBqA4KNVvlQ
	5u+XT+SKiB8rZsD4vqEoBKT0DYblU+MKcn6l0fri20fJ92dGNl3nbuYa
X-Gm-Gg: AR+sD117J4RIMVyMSnrSBT32GdGiD72MC35rm5kvABtkjaqFi02SApDE2HVIw9BwVlm
	Qqv4qfWdcP3XnwQ5s5Zye59ShSK8P9NPdnm58LsBoZ8FnOfBC81pEErJ1HkBiD3fRGY+ppb4Ia3
	BWH9V8+ETk1eI+c4wBritx7pzf+hM3C1WXYHmqV4gUW5if6etNCZvLrv2I7vpzUg8ZHhL82SYJ9
	J98mCoxLhVRPBgLTolgtQ/k2tDuQQNSAG56ucwgYoWIWk/5/jo/jI7Mgg72BOQa2ykp6N8ta4RK
	Ts1Sq9sUIKs6SDGkltcsBzPMsEfGQQwwW8Tw8zJiDy+VdfT9EggdBex+/qkrGYCr43XqPs93GPc
	xUyO7G0JG4+K/K+aV4Nk6qm9F+blCDjyTWDchrWIDLwOmSMFXNj5VvVodI6oZcelaPmA274h2pE
	KkxypEfuJ5aCYJyp9G5gW81jPVuxyFBVJqr2QiUZ+S3SJVomIzZrWqzGpI5ZVUSuGmuL9VcVtFf
	FQE97PAdJBff8baf0aHmby6JYPlloAcrJqq40dFdMVXY8KQBP8jgu8kbC8AJ7MpSp5m95eDpbca
	t8NjUZz84jqThAIosjnO81zFW3p6SkLYn3X6gRq3PUX6WwjpSuWxTR42R+7x4EXFMmfBkOxCIeY
	+7TOVOF5d2n8tjLs00u+4npXcJjzAzhU5mYt2G1l0YMLAO+arpj6yBMzYRf0i4cWGrFkgYGI=
X-Received: by 2002:a05:6000:712:b0:47f:9254:d453 with SMTP id ffacd0b85a97d-47fd2abbdf4mr3203164f8f.8.1785491591146;
        Fri, 31 Jul 2026 02:53:11 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0ae0sm2757970f8f.33.2026.07.31.02.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 02:53:10 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:53:09 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, David Lechner
 <dlechner@baylibre.com>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Subject: Re: [RESEND PATCH v2] iio: adc: bcm_iproc_adc: Convert probe() to
 use dev_err_probe()
Message-ID: <20260731115309.000073a3@gmail.com>
In-Reply-To: <20260730155712.374464-1-mdshahid03@gmail.com>
References: <20260730155712.374464-1-mdshahid03@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 21:27:12 +0530
mdshahid03@gmail.com wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Replace open-coded probe error handling with dev_err_probe() for
> resource acquisition and initialization failures.
> 
> This simplifies the error paths, avoids repetitive error handling,
> and automatically suppresses duplicate messages when -EPROBE_DEFER is
> returned while preserving the existing error messages.
> 
> Also remove the redundant error message after iproc_adc_enable(),
> allowing the error to be propagated without additional logging.

Separate patch for this along with the removal of dev_err() at
devm_request_threaded_irq(), see below.

> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
> v2:
> - Convert remaining probe error paths to use dev_err_probe().
> - Remove redundant error message after iproc_adc_enable()
>  drivers/iio/adc/bcm_iproc_adc.c | 52 +++++++++++++++------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index cf4738b16e62..08e056468d8e 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -522,52 +522,48 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  
>  	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>  			   "adc-syscon");
> -	if (IS_ERR(adc_priv->regmap)) {
> -		dev_err(&pdev->dev, "failed to get handle for tsc syscon\n");
> -		ret = PTR_ERR(adc_priv->regmap);
> -		return ret;
> -	}
> +	if (IS_ERR(adc_priv->regmap))
> +		return dev_err_probe(&pdev->dev,

Given the amount of &pdev->dev calls, it would be a good idea to introduce a
local `struct device *dev = &pdev->dev;` in a separate patch which would go
before the dev_err_probe() patch.

> +				     PTR_ERR(adc_priv->regmap),
> +				     "failed to get handle for tsc syscon\n");
>  
>  	adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
> -	if (IS_ERR(adc_priv->adc_clk)) {
> -		dev_err(&pdev->dev,
> -			"failed getting clock tsc_clk\n");
> -		ret = PTR_ERR(adc_priv->adc_clk);
> -		return ret;
> -	}
> +	if (IS_ERR(adc_priv->adc_clk))
> +		return dev_err_probe(&pdev->dev,
> +				     PTR_ERR(adc_priv->adc_clk),
> +				     "failed getting clock tsc_clk\n");
>  
>  	adc_priv->irqno = platform_get_irq(pdev, 0);
>  	if (adc_priv->irqno < 0)
> -		return adc_priv->irqno;
> +		return dev_err_probe(&pdev->dev,
> +				     adc_priv->irqno,
> +				     "failed to get IRQ\n");

Remove this, platform_get_irq() already prints an error message, keep
the original.

>  
>  	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
>  				IPROC_ADC_AUXIN_SCAN_ENA);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to write IPROC_REGCTL2 %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				     ret,
> +				     "failed to write IPROC_REGCTL2\n");
>  
>  	ret = devm_request_threaded_irq(&pdev->dev, adc_priv->irqno,
>  				iproc_adc_interrupt_handler,
>  				iproc_adc_interrupt_thread,
>  				IRQF_SHARED, "iproc-adc", indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "request_irq error %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				     ret,
> +				     "failed to request IRQ\n");

You only need to return ret here, devm_request_threaded_irq() already
prints an error message on failure. Separate patch for the removal please
(ideally the first patch in your series to reduce churn).

>  
>  	ret = clk_prepare_enable(adc_priv->adc_clk);
> -	if (ret) {
> -		dev_err(&pdev->dev,
> -			"clk_prepare_enable failed %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&pdev->dev,
> +				     ret,
> +				     "failed to enable clock\n");
>  
>  	ret = iproc_adc_enable(indio_dev);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to enable adc %d\n", ret);
> +	if (ret)
>  		goto err_adc_enable;
> -	}
>  
>  	indio_dev->name = "iproc-static-adc";
>  	indio_dev->info = &iproc_adc_iio_info;

Also, you've missed an additional dev_err() in the iio_device_register()
check, you can change that one as well.

-- 
Kind regards,
Joshua Crofts
