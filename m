Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB163F9F30
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965705; cv=none; b=lklE5R2tN/GmW6E4C0gQLeEnOGiHZnGpmatTXIX21A4pxwvEReq29Wirqngp2YXutlMUwIMnxGEjP0gxjheEovLeMRpBBZlDIL92wWPC/9m4ZVuNCm9jrQyHqx2DynvTTeigpO3rskbvpgZBrWIUuGswkEv81j3CF1RsRcewSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965705; c=relaxed/simple;
	bh=skO89rJHcaO5XSPE9jKRVSs9sjdCvPSNpRBmdeNpVK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDb+3g7EAJ+uH0fkEjVkFfmXXR7ck1WJWVOuNI70glA/Bz1x/2/NqACptzukAIQha6XiSmBpMnuJzYmDmguFI91/nvvz+OYd12b3FNuSpspmkHPKVcyhgnKgsJbCu9nIYj47+jwlotPsXhk2TXMppxrvOwV+jX0mxWoYQcMmiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eBLqD/5s; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eBLqD/5s"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67e0d3f288aso2705004eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774965700; x=1775570500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzPeM0VP4qCUYa+Meq1M+afrsRyVkpLZGm3sWtQVtA4=;
        b=eBLqD/5s+ODVzJWwA9WfNt2xxte9Rvb+HTIJGEJBrrmMBVJsbL9OS2etf5piAJA+ty
         whOhtKzSRYiWd3ndgE/fO0kbBcx383ROoxginUEviUNCHD5gds1u6JFWkNuOFlIz9Wzx
         WY4cLQIkhhpUd1Z/fm8P6cqs8J9xhnymCqWZpbYsYc6f55+yNFJRj7dlk9fJoGNOaAjO
         ZPc+/wgYi/DafKWxLTLAsEq5IboPM/yuEpFYtyxO0s5O5Hkxl531naHulB356Gx+jnSA
         LyiK71KwLWABrIYtLpESHqMPwpkZL5XuHC+PhS4ixJbyvYZyMFlu6fIvMrXLta6Ab0C0
         inww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965700; x=1775570500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzPeM0VP4qCUYa+Meq1M+afrsRyVkpLZGm3sWtQVtA4=;
        b=Wtz9alU7cnN3qFjyKBKgPHtpuKXlBkeLV4lP6hKC+/z/6D9xMwG3SWMxdB4IVW4zwy
         GYkgeZyvUQs9imscqYIv9AfVX5HWK3j9YhU2DLcbqt3FaB0X8Zaf69M6vZ9t6of3/WxO
         tmbEDxrX75Vjs15rxgBSXIi7JnWGPuE19v0cvw0Dzbl98WIMaCogsxnYtVcgKiANBFll
         UFb9e2tCMbAUOhcX681DftZoJYIGhyOwFp7jB9/4aPRwxhxy8UvVpyMM4FzSneBuGLZw
         GDeEXOZf4xVHspmeEYnOSWxQGconRMkXRr3CIXHokcfcod0hD6/QDnFo/qi1Mg6F59Nj
         849g==
X-Gm-Message-State: AOJu0Yyz7qiL1AKR3SCJJyIbjsp5o/phrBhrRZjHGc2JmeaPUl6qJD1D
	IC6C6YczvDTibYxDtJSTYLPXSLDjO2jPYIgRGuvzpns8/IrGwlpnUzolRAWic0SeI5Y=
X-Gm-Gg: ATEYQzzubwlFilcsz8GpJnvGaqTgnTL2QcpfhrWtdS2eMxeizeetOienr9vyZF3O8FZ
	hBbW8Lgn58OQ2ECwZeZ6v54qOrw98WgfopIFZGP1N9cNAq3pWBy0joFbRgoBYflzZFodzNbTTw4
	yyRjAfteD0PT4alBAGmWvp+1O3UZJmLdyuDelU6P5vV/IJHpxWoDrK0CkJUioRYZ+lElEDZ0PUV
	ExjX1Cn66tt24e7XYSCUO5baBkl6AqE+2LXYCyBP+hrlaV3XnAEnxhaIQYnhuLNwtnwjSXNx2El
	Hd8bb2CO63aMD/7h7CYCFsRzjtIY9znOMURt5bNvJWpzkxBkXPNXvaen/Jd+Y3J1SNvTMrt2Qy4
	QXrpo/VHH6VcQcjriG+E4Z2p4vT74cE+oeQvn4s7QL9eGQn1GQcbOQpw5wVP9tYPECMpYxttbjW
	iRewyauOvYa+BvCxkOrZ5b9L7y6JDGBlPoXVtlfXWkS7eRX3gbdXc7GDdI1YLOuLlIhumrLmw=
X-Received: by 2002:a05:6820:81c1:b0:67b:c368:1364 with SMTP id 006d021491bc7-67e1862686cmr9296916eaf.25.1774965699835;
        Tue, 31 Mar 2026 07:01:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:732:592e:7567:cf3f? ([2600:8803:e7e4:500:732:592e:7567:cf3f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e2308f212sm6785607eaf.6.2026.03.31.07.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 07:01:39 -0700 (PDT)
Message-ID: <cbd9f136-d10f-4a64-b155-2beb7f1aaefe@baylibre.com>
Date: Tue, 31 Mar 2026 09:01:38 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad4695: Fix call ordering in offload buffer
 postenable
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/30/26 8:34 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> ad4695_enter_advanced_sequencer_mode() was called after
> spi_offload_trigger_enable(), meaning a regular SPI transfer could be in
> flight while the offload was already active. When the offload fires its
> completion interrupt concurrently with the regular transfer, the SPI
> engine interrupt handler is not designed to handle both at once, leading
> to a kernel panic.
> 
> Fix this by calling ad4695_enter_advanced_sequencer_mode() before
> spi_offload_trigger_enable(), ensuring all SPI bus accesses are complete
> before the offload becomes active. This is consistent with the same
> constraint that already applies to the BUSY_GP_EN write above it.
> 
> Update the error unwind labels accordingly: add err_exit_conversion_mode
> so that a failure of spi_offload_trigger_enable() correctly exits
> conversion mode before clearing BUSY_GP_EN.
> 
> Fixes: f09f140e3ea8 ("iio: adc: ad4695: Add support for SPI offload")
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
> When enabling the IIO buffer for SPI offload operation on AD4695/AD4696,
> ad4695_enter_advanced_sequencer_mode() was called after
> spi_offload_trigger_enable(), resulting in a regular SPI transfer being
> in flight while the offload was already active. This caused a kernel
> panic in the SPI engine interrupt handler.
> 
> This series fixes the call ordering so all SPI bus accesses complete
> before the offload becomes active, consistent with the constraint that
> was already documented for the BUSY_GP_EN write in the same function.
> ---
>  drivers/iio/adc/ad4695.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> index cda419638d9a..c6721f5ac8af 100644
> --- a/drivers/iio/adc/ad4695.c
> +++ b/drivers/iio/adc/ad4695.c
> @@ -866,24 +866,24 @@ static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
>  		return ret;
>  
>  	/*
> -	 * NB: technically, this is part the SPI offload trigger enable, but it
> -	 * doesn't work to call it from the offload trigger enable callback
> -	 * because it requires accessing the SPI bus. Calling it from the
> -	 * trigger enable callback could cause a deadlock.
> +	 * NB: these are technically part of the SPI offload trigger enable, but
> +	 * they can't be called from the offload trigger enable callback because
> +	 * they require accessing the SPI bus. Calling them from the trigger
> +	 * enable callback could cause a deadlock.

I didn't see a explanation for changing the comment here. I think "this" is
still correct instead of "these" because only the BUSY pin is the trigger,
so only the one regmap_set_bits() below would be in the trigger callback
if it was possible.

If we want to improve the comment to make it more clear, I would save that
for a separate patch and specifically mention the BUSY output.

>  	 */
>  	ret = regmap_set_bits(st->regmap, AD4695_REG_GP_MODE,
>  			      AD4695_REG_GP_MODE_BUSY_GP_EN);
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
> @@ -895,22 +895,19 @@ static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
>  	ret = pwm_apply_might_sleep(st->cnv_pwm, &state);
>  	mutex_unlock(&st->cnv_pwm_lock);
>  	if (ret)
> -		goto err_offload_exit_conversion_mode;
> +		goto err_trigger_disable;
>  
>  	return 0;
>  
> -err_offload_exit_conversion_mode:
> +err_trigger_disable:
>  	/*
> -	 * We have to unwind in a different order to avoid triggering offload.
> -	 * ad4695_exit_conversion_mode() triggers a conversion, so it has to be
> -	 * done after spi_offload_trigger_disable().
> +	 * ad4695_exit_conversion_mode() triggers a conversion, so the offload
> +	 * must be disabled first to avoid capturing a spurious sample.

Since this becomes the natural unwinding order, I don't think we need
the comment at all any more.

There is still a similar comment in ad4695_offload_buffer_predisable()
so we aren't losing this information if we remove it here.

>  	 */
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

