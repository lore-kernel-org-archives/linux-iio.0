Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774401F2380
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785566720; cv=none; b=iATyLLA1ofBPeZ2FPn2jfzJ6Cl/CpepoVpstnZwMgf8S/GKrokR8Cw12R5YhC8jfRBXHNrElPX9zYYXhpbjLSVdRISKNrT8FPd3EFC6s5TuVy0rUKxX1V6C9GjzNZOxqrU6Xp9ypXOUvSRuyonf2GH8dNHBIc9vDTZz7/bXDpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785566720; c=relaxed/simple;
	bh=GvdZ662JCMXzbW8+6bNSz/VzMykfM7w2yO2nTWSDYKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goXc4KSoxZyoHFLvv7TrkL8ruo311pCPqIYVzM9I5IE5ZNXSa87UTXKLA7p1xYXZGFlw0GvzXUCjrTpj1jIaX8WGqPN2Hgp2MhkGvz3v9Z2ySGzmc97k4hZQOzthXS6pHjNYCRuKgW/cYrjrAaieFb5wU2GCGA/FRsqbZSxkObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osZ2WNbo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osZ2WNbo"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1126011f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785566717; x=1786171517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=shXI5gTecK3XzXEfQhSt8Ph409l47ex30hjHXtZWBBA=;
        b=osZ2WNboAnUPujABCAYXUjKloEyFWGvTf2Pu9hACHWcNLtS1ki99liP4LVtNfKlacT
         P+QGh1padWva+H6VS8eg9HOR397Ugv+ePGmWYw/M66F4tk6l497E501+anFz9uUb+Lb6
         fnusB74xgbuh0ZfdV6G3ulnfyIa9fvVCbH0o/UHU9SVSvGsyAybfreTDVcvZuXYOSm0l
         wd7vOCo+bhsmE5FX+wT2xv5g1XFhCfPSdNNTyzuCxpWGyIDuqAuPC2O8rQM6p1/2/P9V
         YZ65fdCZ0Z79DmN2R+spQlPoknXmQEEU0YDIOISpwahoB8zHv1ZJVL2mk/tfdLy3Ivk6
         BfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785566717; x=1786171517;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shXI5gTecK3XzXEfQhSt8Ph409l47ex30hjHXtZWBBA=;
        b=jL2hFAb6mHe1jc7KMQ1brpW/JsTJpeAXWMNJYWV14Xiwx7cs+ja8ht0lNuLq0kWqD1
         sgrd4JTfO/MGIz5bQie0DeNQDpnfE+cbFQojKno5I6AwTmzubM+mYYwgV+7FKgTZwGOK
         hU3r8Gc8sGzzgXd95Lo2Hp8vUTlq3VCu7tyUNN0wFA6z9kWz3uzrrxagTbd3qNa3VOfg
         Q5i6YgurXIFh/bLOZAQ0hd0i9G5xfbBaPqe8UchyFjDJPnFCsYY/yLJVRI1H0APLxNXs
         ebsnIImhYXKFXgIBdeHefnRW3ubuk9ZCLjFXeugLmcSVtz9Nw+FKxHDPVS3NPsQsHuwc
         nRIg==
X-Forwarded-Encrypted: i=1; AHgh+RruNJ54pv43T4cBTBA7V8btTSJJ9AJCSxfAtvlNA4MGy9yHtZ/JiegsU2yRxF8x+6RkjhBp2qI4/BA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJifgQIWmX0HtieAz8Hw8RQwU5X3u0EIfIlSl/pCIjI2dXUwy
	rscgrDFuSpARyE0ZFfEv2jaRkvMQzbUgxiBZKXWbtybBJPQdfKGEC8OT
X-Gm-Gg: AR+sD13JKfKgHiu8F4oPtBOILOfnZWH8DKjpJrSntW4E/4JJxxNVOhSVTTtLyYFkD9b
	kWo+mvEvPa9cJXTSTsJFQJPylnF1uNxFtxHUcj6wySE7Y6kKLL6v04dk2rI9Rf95L+8Z1W5WAK/
	mQwyHVqc3S9RNcNbRHHj5PZFl7gi0EEV/H0Ee6pX3Rm3F5g77k5Iz1U4FQ46r2fN16KV92FUXc8
	irh4kloSdTu8Z06QJQNm11LqO74YzVwKFN5DcearTtAdIo97/sZGQa7BOaLFu6VhDewg/gcWr9o
	5rgxkztZgK+j/5IUsDiJz9Fhp4I/FVmxPZBSjmXHTjXWmV5ANQhaNXM/4iJIzHilRJmPC4clNgi
	cjJ8fr6Rupmcx7cU+rM0v3rq7B9NcG1YLgDKUAto7tvlvSCyOjsDW3+3qZXa6VKhGcGINGrP35V
	b4BQJ5AuQz9vp7ccbt9A6EwJzF7YTTOQkXNsZjAKJsyx1nuZbJ+o7vh5GTTYtycR0dOB7cz/6M+
	/iXL9LlioUKyOeKvO55mSx93yV7WLDi59z0zG2ptCfZZ8cKMPkj6SfzpCxhJfV9JE1V7jQsBUxw
	0ssd8AZkmTZxjM6zWR9n1alc6A1/zqe+JtbZKB1gumcb9kCNvq0q0gHEnbK+Hsr0syVt1f+8v94
	QD+2XFTbb9plHQ0le/D4uQbawwP1wbJjzf/rEnQP6vtEvXZyRMPYM3TlVvDc=
X-Received: by 2002:a05:6000:186e:b0:47f:aead:f81b with SMTP id ffacd0b85a97d-47fd72c48a0mr4568734f8f.21.1785566716620;
        Fri, 31 Jul 2026 23:45:16 -0700 (PDT)
Received: from systembl0wer (109-81-110-31.rct.o2.cz. [109.81.110.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458ea4asm12408852f8f.31.2026.07.31.23.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:45:16 -0700 (PDT)
Date: Sat, 1 Aug 2026 08:45:11 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Joshua Crofts
 <joshua.crofts@broadcom.com>, Broadcom internal kernel list
 <bcm-kernel-feedback-list@broadcom.com>, David Lechner
 <dlechner@baylibre.com>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v3 3/3] iio: adc: bcm_iproc_adc: Convert probe error
 handling to dev_err_probe()
Message-ID: <20260801084511.795962ac@systembl0wer>
In-Reply-To: <20260731182347.42888-4-mdshahid03@gmail.com>
References: <20260731182347.42888-1-mdshahid03@gmail.com>
	<20260731182347.42888-4-mdshahid03@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 23:53:47 +0530
mdshahid03@gmail.com wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> This simplifies the probe error handling by replacing open-coded
> dev_err() and return sequences. Also remove the redundant
> dev_err() after iproc_adc_enable(), as the helper already reports
> the failure.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 43 +++++++++++++++------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 29ea35972a23..5fcd528eb88a 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -523,19 +523,16 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  
>  	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>  			   "adc-syscon");
> -	if (IS_ERR(adc_priv->regmap)) {
> -		dev_err(dev, "failed to get handle for tsc syscon\n");
> -		ret = PTR_ERR(adc_priv->regmap);
> -		return ret;
> -	}
> +	if (IS_ERR(adc_priv->regmap))
> +		return dev_err_probe(dev,
> +				     PTR_ERR(adc_priv->regmap),
> +				     "failed to get handle for tsc syscon\n");
>  
>  	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
> -	if (IS_ERR(adc_priv->adc_clk)) {
> -		dev_err(dev,
> -			"failed getting clock tsc_clk\n");
> -		ret = PTR_ERR(adc_priv->adc_clk);
> -		return ret;
> -	}
> +	if (IS_ERR(adc_priv->adc_clk))
> +		return dev_err_probe(dev,
> +				     PTR_ERR(adc_priv->adc_clk),
> +				     "failed getting clock tsc_clk\n");
>  
>  	adc_priv->irqno = platform_get_irq(pdev, 0);
>  	if (adc_priv->irqno < 0)
> @@ -543,10 +540,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  
>  	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
>  				IPROC_ADC_AUXIN_SCAN_ENA);
> -	if (ret) {
> -		dev_err(dev, "failed to write IPROC_REGCTL2 %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev,
> +				     ret,
> +				     "failed to write IPROC_REGCTL2\n");
>  
>  	ret = devm_request_threaded_irq(dev, adc_priv->irqno,
>  				iproc_adc_interrupt_handler,
> @@ -556,17 +553,14 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	ret = clk_prepare_enable(adc_priv->adc_clk);
> -	if (ret) {
> -		dev_err(dev,
> -			"clk_prepare_enable failed %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev,
> +				     ret,
> +				     "failed to enable clock\n");
>  
>  	ret = iproc_adc_enable(indio_dev);
> -	if (ret) {
> -		dev_err(dev, "failed to enable adc %d\n", ret);
> +	if (ret)

I'd say it would be better to move this change to the patch where
you remove the dev_err() at devm_request_threaded_irq().

-- 
Kind regards,
Joshua Crofts
