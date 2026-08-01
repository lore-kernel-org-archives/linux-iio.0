Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1D2C11E8
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785595900; cv=none; b=hAoLtpMa/PJujEfpwByBKd77yubh8U2C8FJOh+0zkPAoAqJ+C/XGvY3V8bmxjGWxjdfODJeZGVCuUqijNK0NdQALC/EDwh26m+pt/ovF8Ur0YYfMdNTx9LQuMKg9qgvVkZjeN1/fe7CIcFSoytJS0/LWuIperKfGFWK1gECzAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785595900; c=relaxed/simple;
	bh=8P+MLcg11rQC4vMX7sSebrnUADYIE5rfOaK2TFG976Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ao8nh/fNdIndi2dvDTxrVOKqyDoRPMW7HdVTIgWlu2intIYGOJor4kTndRdkXJ3DaA1kk1nk2816Y9iLv/RMPVNfgn4jijxe55Qc4rDoNB5y5SSWzI+4y2MFsw7ziDF3ksgq+5/vghAOXLBqGhK4zjlR7KLdvZeuKnVO3GivrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=C5WmbCGR; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="C5WmbCGR"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6aca0f482e5so1251620eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785595898; x=1786200698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=biNkA50kN2GCvNIWKTTRsuGKERA58n0pu0i9eBii5iE=;
        b=C5WmbCGRqbo2EDx7oVKs0bim/21LeCuVa4kO3cnQB1aNg3+98ZB+krnp1wsXUS13Y0
         1cMrjCTsvwMdd+U/k0Ni5fqGX1SZZyCiRMyoGMC3ZfTf1/QaIWnhWv8Jvnk0UatHiOvd
         DmucVtQXmg9gE8SqStOCLgAOC8A0tpQ+asFawINHC04Ivm+Sv3obIkkdK58oM1CHu/f8
         Qc4dAC2BRneGpcTfxDqH6m8HDktwyN/syQK8hXPINhEmKJRygyrxXmRaHGcd71gsK9v6
         GAMABe4kViJF7YRaKjg7ubcjd6fRd1xnLfWdqOHRGf/7rasCLWThhRogR6c0OAZyrLks
         xr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785595898; x=1786200698;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=biNkA50kN2GCvNIWKTTRsuGKERA58n0pu0i9eBii5iE=;
        b=jXR5mwhhv4Y1nQjYXisLByGTAXokGNAQ6tqn6Lt51opHuNe3K1LKH4Jd9RnOTyhuX2
         IVcC1Mvdki1WJYGDYaLJyIPStwTmlBQYmOAeaLcUJMcBjIj6BQLSdpU/9Y9Yqa0yQu6B
         nxLQxdh8MwGcUj3JYGNfgkNlMKQD1DGs4EF8qGbnWAhzDHek9iIPP6WrPxnEnJSv509w
         c7p4hGDFsxJdYjz/YwoTxX4s8V+i+YS3JqTliH92f0Ql9x7zemly51B3tsZFEW4L1PO9
         zd5MNUGHnNm5Spr5KTY9mlvOS0gcu2jsv0FQ6r8cmwQCSUb2NjP5YvsoLRqI7+aidQeG
         8HTg==
X-Forwarded-Encrypted: i=1; AHgh+RqHkSYSrKdZqrZJ2Yhi/CAxt4uD4CvxS+EzcEScwfruaVsmOgMg3slMjw43GcSq20soPEcPJzdHncI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfvtJxaj+1AtoDlbYyDjhTI778ljIbWHf5GPNoq7nakEqsWXGz
	zYlg+oWH5p7JjMUsuxgKrpZEzl7mte2j49T3ELB9EVZJmscmlFaBU+qM+1xV5UG0lQA=
X-Gm-Gg: AR+sD10LLp2syLPAFeHcxgOhS5z8fLTU4jTpzCrBdjM0nTF6nF5aL5TJKfzQDO8sJur
	kJjqx/9K9dhUCHGecDwlyK8xbv+J02GIFt5RL3b9Qkg2wCcHkFDrlNORhAuccHTzVMX0Gh6wClB
	NYXBm1KwAjEgcvKElHhZIQQPsEoK+xgTpru+n3/Fp9mvl5aSxUOZT4MYQf+RlXHJqss/iDar4Qe
	78/aKC+j9/BLyOtg0E5f+C3xgydOhXUFlsyuPjwG+UqrrNag/xLoZIRiNaY7zleLXQ5Opty+oRG
	6WQpOZuPnO8BpTvpuErqV37AgKPssxxYvUu4XDChyhPNteNz0bELHl+a39l5YitIzfUE8GF70cj
	TE3BO6W/BgFEMNRXleFBgMgamTqhEONN72ncrEYt1THos1SjhQopTwEnaBU9x9d+lYVHymNyGJt
	ZEUQA3+0b2jkaAEmIs/HYZhTszHoi13pELPX2T6ekqxodgWPD6sAlQa6nEFOLe/swkXTzzXNAH1
	z5IwtGuykeGNS9r3Zc09Fy9C1a/OTI2soXZiM4=
X-Received: by 2002:a05:6820:4b02:b0:6ac:c531:2ef4 with SMTP id 006d021491bc7-6ae43336570mr7319764eaf.26.1785595898078;
        Sat, 01 Aug 2026 07:51:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f66c1d89sm3908964fac.13.2026.08.01.07.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 07:51:36 -0700 (PDT)
Message-ID: <8be00e0f-08ca-4744-9f24-eb41a63a858e@baylibre.com>
Date: Sat, 1 Aug 2026 09:51:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] iio: adc: bcm_iproc_adc: Convert probe error
 handling to dev_err_probe()
To: mdshahid03@gmail.com, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts@broadcom.com>,
 Broadcom internal kernel list <bcm-kernel-feedback-list@broadcom.com>,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
References: <20260801090953.61603-1-mdshahid03@gmail.com>
 <20260801090953.61603-4-mdshahid03@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260801090953.61603-4-mdshahid03@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 4:09 AM, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> This simplifies the probe error handling by replacing open-coded
> dev_err() and return sequences while preserving the existing
> messages.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 39 +++++++++++++++------------------
>  1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 4acd9c3f089b..5fcd528eb88a 100644
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

Probably fine to put this on the same line as dev since it won't
be any longer than the text below.

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

same

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

dev and ret should be on the same line.

> +				     "failed to write IPROC_REGCTL2\n");
>  
>  	ret = devm_request_threaded_irq(dev, adc_priv->irqno,
>  				iproc_adc_interrupt_handler,
> @@ -556,11 +553,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
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

same

> +				     "failed to enable clock\n");
>  
>  	ret = iproc_adc_enable(indio_dev);
>  	if (ret)
> @@ -574,7 +570,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
> -		dev_err(dev, "iio_device_register failed:err %d\n", ret);
> +		dev_err_probe(dev, ret,
> +			      "failed to register IIO device\n");
>  		goto err_clk;
>  	}
>  

