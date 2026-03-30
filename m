Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B43A1A23
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879891; cv=none; b=nf6oOkWJB3vXMOhCxN3fA82EKPIzzcK/fzrengIM0ZCllbKDINAY1cJMUFod2jqYCJuPA/TTU44gZQMZ/2Bx4nquoKBbDSBBN8iEGqFfJERpMmpXEH+CgoVbCjclc875Rxmhw0CWecnpMShjte7rtQlwVkEDBVOT7Qw1FVsg61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879891; c=relaxed/simple;
	bh=9oKZgbFiZnKWngTE97vSPFXgerXhlxal2Pep/E1M+80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNs3V0Yhp64kGQ3nThtvGpfj8Pk2oIJDGuHcnbZVUQ+3zgQghpMk24RmYCstGSoM+PUXH7+oitGh5rd7D0imazw9Vf9tHPK4DG5+yNq2pD/QTbRhpD347KDaMyB+uF2iZ0393GrUzeIHLTw4GKXi6oKY3ubLLnhSaE8o5HqQZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EuYgGpNO; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EuYgGpNO"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4670bcc40d7so1472664b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774879886; x=1775484686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZnNU9xrISIqifOS3N0gZbMK4N8nF1kNmN47jKO7s+A=;
        b=EuYgGpNOmT2z8sGkoJNFbpJencBEVoCTvpH1nHU58ljibnSgGxYOY4d7qcegjApz9I
         jgbi3oezBeDgPcFeRaH6j3DdHRTmUYBlibdgn3UcPGE9401tedlnL6PW3Sob1xhzgKbu
         G70Of2vxwbBCP5RsbYgn5ruXLqfCkmXosPmzs2uTuFQYZxigaWhx0XawCFIKyxV3JXhW
         hDY2lB/8iQDUEgl2QzVoUkSrfhm72PicHv2btx6Jm+q/8Rbtw0GYO7Ntc2flMxoTVXTV
         +oP0qIG2Q9hTPbYlNnylX4/e0cadNZ+1mrjfKWCs/c9wQ0utMhs8el0YNeumdY7hgGHW
         tajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774879886; x=1775484686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZnNU9xrISIqifOS3N0gZbMK4N8nF1kNmN47jKO7s+A=;
        b=BvCIghXOCxuW93qGL5ZnhjumRky5243+J95vhtBE+fBcXS44jWXUO9L0nQ8IZGISPB
         x9BJ9xqxnM9+oaLTIqfBjfW5PsUbFvWE+BmVEiIWEfNLo0pORfQCG8wEjMjhlFvDBO4z
         AuEGnhPFDR4CZBgsbNjCFsLtmZmHqavgY+xSXoQt8NTV4rUyddoDzq9lMBRaL5PDsYBL
         9G1EGpn4drH11hUWFx/hbPIC4XhSGF5I93ARCLqofo/qwKmjCJrcqeH7PnYsK5i0qpp+
         SzSRO2eSGjBPk7bkiPKPbmSHj3IEGy7sAzn9/ZoFb17Ir4hMIzbipTEVMM04fn0+mgxX
         VdRw==
X-Gm-Message-State: AOJu0YyLvJkVv0JfGPgaagD2/MakNXzt3tS5vRHtujyyc19Uk2EzhkyC
	oFs214Q4kQoK9lW8yVXDSL29FmW0M/dUC4keQMtQIcOJO6t/4f5ea1viLkfD0HUQiHY=
X-Gm-Gg: ATEYQzyoNmMmzRk+QmarxS+lVxuXbyvaZHYgKu/XM9yF/P6mDYo302ORI5dMrabIrsa
	sa074oOzG7YDGQh8t7Ov4PQ48NmiPMMxop0uU6OXxp6d0a4h+zEAGSTievI4sHosNuoQSsdKxaM
	o8nJ/TxkaKA/JliqXlIfIulQHFxfMR0WUhqANnnQg4YAeQL1j6tKLUjJZDHyf+54nu75NQ7V9Dh
	bW66C0X8Ti57F4gmyYE637m7FRN1wKcYbvj5nYxoKLBnhwsALznHJqsx3RP4jwMVwSns//M6ggg
	GK5fGqU1sN/6CmDMqK5uAGtDnMJ1F4bTNKGNuHPTBJQm0/S396ulX97N7xIIMfUf691xngkI9rL
	Y4St+YA/sg/ZYRwm1PTALHFlJYBuSR35cmrn9iKlMNgXTeS8M4ypfloeab6huoWn2dzNHmTBsxx
	A/mAR04C7uL+KXLWy7LTnyQ84VED2xmXTcomS+kP4eli7h5p/Tzf8mOYZD2Blbg94reGddeM15P
	A==
X-Received: by 2002:a05:6808:4f21:b0:464:2570:8805 with SMTP id 5614622812f47-46a8a399ef2mr5639388b6e.3.1774879886563;
        Mon, 30 Mar 2026 07:11:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a67f:a092:38d7:379e? ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46aa03a9179sm4321165b6e.14.2026.03.30.07.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 07:11:25 -0700 (PDT)
Message-ID: <cfe07818-e040-4ce8-9407-d951df637af1@baylibre.com>
Date: Mon, 30 Mar 2026 09:11:23 -0500
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

This used to work (I spend many hours testing it to arrive at the current
state). Are we sure there hasn't been a bug introduced in the AXI SPI Engine
instead?

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

Swapping the order here introduces a race condition. 

ad4695_enter_advanced_sequencer_mode() starts sampling (triggered from the
internal clock in the ADC) and the first sample could be completed before
the SPI offload is enabled. If the first sample is missed, then all of the
data will be off by one index on the buffer.


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

