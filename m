Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B9288505
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320852; cv=none; b=M5ZmupYtvKIZ9Jwd//UyoVjLrN+ZTK1sm1Bdd1XbcB5fypV5/255+A/MjfN9uGNEkPQnL6fadHygQy6DkM9F5Vo4KJ1HMU4Nb2yqpO2sTk1PoBOrhLYb5yqWp/a5lIc4agZ6Sm6bPYSJYc5/B52Rn1ecf0af6Cx2sCqRMzoZFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320852; c=relaxed/simple;
	bh=93mvv+BEtzEK5XI8e6sH765oWlLGhXRZAx2a1QZHls0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6xipxYZpTyszgpGVdWnw3k3N4H1ET3SkKhv9PRgKXJhC2RKFBKZ1N5PiZ+Fj1L4ZtjhuRCtH8CqhncqEVFDcr6XyF+DIs+8BVawcKLfIAI+rjubPn5rHAqo4q4fKzfLz0cYsFMfHLKjaRlBm6iQkOlXxGYlcad1qyiaIbWDFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=SzvFZMey; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="SzvFZMey"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-470145d7e07so527807b6e.1
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775320848; x=1775925648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1C/CN9ApWbQgPAlvUmex5/I/mGOFbyitE6O40Oefxs=;
        b=SzvFZMeyctiYPPLKON/C+FY0eiF9oZ9Q3fBPKIN8jgI+lxobrsg4FUU6dEjQugijoX
         0hPeUfU/FWYATNsE/ARA/KYKiYrCJymdscF5DWcvkSkJRb0usIMXzNiIE3qhrxTbJMHT
         0fIsYrgXfRMv1x6MmrKBOBPP9SlCGYtXRlY6KOt7bzhAqW29LK7cIb6cPDpu29EkxczM
         09SoIQqoIHLTVVL9/pqdvsJng4/XW8XcFuVvD6+k+tS1hHOya8dxn+VPrgLrRHELIdGK
         HtgghKc3wQex/OMCkMG1dFbBmElRt43fnFqEN4u0YZYtEx7dwdiV4SZp5M9RDZewBWu3
         vCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775320848; x=1775925648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1C/CN9ApWbQgPAlvUmex5/I/mGOFbyitE6O40Oefxs=;
        b=U92TFcdYikOFZ/psElOqN/Edj8/pkMEbNa8h8Hx5/osjA4xyv4LRlWfYMLob0KN4ZO
         A6uf5Tlm9S9yqIpQ7QeuOOiq7zaamuz8bEGm3WeMjE8aXPeficHwCR+VZ0UYqLNOA2i4
         jvLnDrqPV1Obgc1Y+WbdoPERxe9e1FpuCYo7ETH/x6pDpRQoy2iFuJNwKOftkgb3rd7g
         pezOT0k7Nj1qV6LAMB4hJlzwPoNwq1hWv8E52HwAoXtdeC276rKZaAOXilDJygdgHD86
         WsCEieOWG8Ai/ej6bQCQlMoBdMdA+l9Ty/xTaTixAD88GrsnAfT//jcMQFMk8jV4Niq1
         NpVA==
X-Gm-Message-State: AOJu0YzdwrYd69iGsGlXuQ+obETEkBH7eEJRZKUtpmoZSOyoO3mHeFSG
	O5YNzC07e4SyfG+aQtBZhRPKLIj8bFKdU1cvqiKLX9V8ihjznJPLnO5YXWGWcOiIFSg=
X-Gm-Gg: AeBDieszHeRxIjLeNppy94yVatHQYLaGXaQJWX+SQh5tXIhw2OnMJmRO6uK6gc8oS6I
	MAQy+tbh0UiGhiKm58phjBBtT3wNkMoY3g7zn89qEhGp8NLlmNyPDxdj6IyqUHSzq/x0d/UzTsk
	IUhJJ0wptPYFLaaeqws/DCZgvtkCuh0uK50mqjvrTDLfJT6M+onXslx934JCnQcDkgBUxsYNdDp
	Rk4JlECUZLECFt57i2nqkWKBvvvAG7qJhVkHcKkzfs/BCIvbGN6LRt0SqoKAxUFgZxQAztF0yU+
	d6Biy69UN11OHetrFYLqatr3sIAe+hWACXOAvAzyDNv8Dxn5HwnUzxG5HJJ5tbGI+ueH3aQ85ZG
	fYb6L3G/7g6+nQhwH8rx1S3JQbXGDGbrsYDuwRK2fum3kzQbDArtVO56QhoZ+NYUDCYxphQiliK
	O7z1UEilpxhEmVBvyh7DwsK76XDCUQeO05zMnPoid5Qxr0BE1msioOWsPd8eLk5I1Siuzlrvivq
	g==
X-Received: by 2002:a05:6808:470c:b0:460:fce5:2fbd with SMTP id 5614622812f47-46ef6a0c0f4mr3712162b6e.23.1775320847945;
        Sat, 04 Apr 2026 09:40:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb3c6abesm7063011fac.14.2026.04.04.09.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 09:40:46 -0700 (PDT)
Message-ID: <e79e7c5f-0887-4204-aca1-5c040f1b00f4@baylibre.com>
Date: Sat, 4 Apr 2026 11:40:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ad4695: Fix call ordering in offload buffer
 postenable
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260401-ad4696-fix-v2-1-2480b9a30749@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260401-ad4696-fix-v2-1-2480b9a30749@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/1/26 5:56 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> ad4695_enter_advanced_sequencer_mode() was called after
> spi_offload_trigger_enable(). That is wrong because
> ad4695_enter_advanced_sequencer_mode() issues regular SPI transfers to
> put the ADC into advanced sequencer mode, and spi_offload_trigger_enable()
> enables the PWM trigger that drives CNV. Once the PWM is running, CNV
> pulses start arriving and the offload engine owns the SPI bus; any
> concurrent regular SPI transfer produces undefined behaviour.

I think it would be more accurate to say that not all SPI offload
capable controllers may support regular SPI xfer when offloading is
enabled.

> 
> Fix this by calling ad4695_enter_advanced_sequencer_mode() before
> spi_offload_trigger_enable(), so the ADC is fully configured before the
> first CNV pulse can occur. This is consistent with the same constraint
> that already applies to the BUSY_GP_EN write above it.
> 
> Update the error unwind labels accordingly: add err_exit_conversion_mode
> so that a failure of spi_offload_trigger_enable() correctly exits
> conversion mode before clearing BUSY_GP_EN.
> 
> Fixes: f09f140e3ea8 ("iio: adc: ad4695: Add support for SPI offload")
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
> ad4695_enter_advanced_sequencer_mode() issues regular SPI transfers to
> configure the ADC. These must complete before spi_offload_trigger_enable()
> enables the PWM/CNV trigger, because once CNV pulses are live the offload
> engine owns the SPI bus.
> 
> This fixes the call ordering and updates the error unwind path accordingly.
> ---
> Changes in v2:
> - Reword commit message to explain the correct bus-ownership
>   invariant directly, without reference to the HDL bug that
>   exposed it.
> - Remove unnecessary comment since the error path changed.
> - Link to v1: https://lore.kernel.org/r/20260330-ad4696-fix-v1-1-e841e96451b2@analog.com
> ---
>  drivers/iio/adc/ad4695.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index cda419638d9a..4471acd6fd5f 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -876,14 +876,14 @@ static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
>  	if (ret)
>  		goto err_unoptimize_message;
>  
> -	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> -					 &config);
> +	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
>  	if (ret)
>  		goto err_disable_busy_output;
>  
> -	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &config);
>  	if (ret)
> -		goto err_offload_trigger_disable;
> +		goto err_exit_conversion_mode;
>  
>  	mutex_lock(&st->cnv_pwm_lock);
>  	pwm_get_state(st->cnv_pwm, &state);
> @@ -895,22 +895,15 @@ static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
>  	ret = pwm_apply_might_sleep(st->cnv_pwm, &state);
>  	mutex_unlock(&st->cnv_pwm_lock);
>  	if (ret)
> -		goto err_offload_exit_conversion_mode;
> +		goto err_trigger_disable;
>  
>  	return 0;
>  
> -err_offload_exit_conversion_mode:
> -	/*
> -	 * We have to unwind in a different order to avoid triggering offload.
> -	 * ad4695_exit_conversion_mode() triggers a conversion, so it has to be
> -	 * done after spi_offload_trigger_disable().
> -	 */
> +err_trigger_disable:

I would have left this as err_offload_trigger_disable to reduce the
diff and avoid having to explain why it was renamed. But not a big
deal.

>  	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> -	ad4695_exit_conversion_mode(st);
> -	goto err_disable_busy_output;
>  
> -err_offload_trigger_disable:
> -	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +err_exit_conversion_mode:
> +	ad4695_exit_conversion_mode(st);
>  
>  err_disable_busy_output:
>  	regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
> 
> ---
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> change-id: 20260330-ad4696-fix-186955a8c511
> 
> Best regards,

Reviewed-by: David Lechner <dlechner@baylibre.com>


