Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8773A1A5D
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880251; cv=none; b=Vu8jjEjsjsuWEmXEVXazqXtYGtxZeQcJuDI6+YeVG/1hDBD79m2ulcjD4uy1Zc9dLeXoIhGHg0L9U721iwbs3ywdTQoam5rgZoH7415MxdCPOJx/2zjXIbz0cPD6HUPl++CGcBRX4WC56cJ5qHN6L5KOYQtNA61aRdRVe+NfeYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880251; c=relaxed/simple;
	bh=jWvphccgBs+CBissFExWcsmt9A6xx59JSpOT4BwXbso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHQlHgTFVHVxuloLHF/l283M/dt3DCuklADSq3GWLTQbzjmsibF6Y/T8tao32j5H+g5IAYKEi4HkUiAQCqyedk70pOzechu5bdYITpTmKBQS0Nabhai/EqB0xFeBrJ+Gk6x4mydK1un6z5NPDscb9BIiCaz6BqhwWI/Jutlu9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PELOvD6H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PELOvD6H"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso39414455e9.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774880248; x=1775485048; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QXTFV6k0jK20NuLbc5kRmXLlkPvSMTXhcz7AgsD36j4=;
        b=PELOvD6HHZ+3o20jk4vU7tJ0dlb+0ItUkwG7+KZhXtN+MeStPdLQVP9++lPZkRbL7Z
         Vl/XOI1OgJBeK1cVwEz7/EitiBckcBGEKlYy2tNEL8jv5xSVatCCM7r8e304A/I5rrj1
         UvKlDOM+q/5d74TAgbBz5cp4/YaGvOdSfZRUIEvRMN3tlqbpi+5HMyQcVN1t9eA8WBD6
         XBEJLR+CkoXU+YuchCSmyOb7+BBMCWiw2BwjwGVtyBPg/molOyoj5wythWrMa4889lKJ
         3wj2wc05yl1vCDdw1rjuFVrkn9xCbr0MHiJtKOwbOot01weB4afMaFWkuiyBVd6VXaCm
         HfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774880248; x=1775485048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXTFV6k0jK20NuLbc5kRmXLlkPvSMTXhcz7AgsD36j4=;
        b=Qo7Ww8AevMpOc1geyR+N8OG23uKFQWsMw0cIb7TpmOW+gsiu8r1lWYwMiuSRE9RmiI
         MTHjFGLbIqRk+VkuP5hAKfsWKATJM1DoXp4LirJ9z/PbGdTo1h4rtr3pDJLMT5ZqcH2w
         MhK0F9v11rD9WqCaEcwKpyPrcLAM8oI6RMiGbLaTxDZ7zispAxW8PNcDEAgqgNR68hSi
         KniDP36rLpDVBisHTaaJzFoXaw8144OdSfd5m9cXXtss/RHBKhRmxo/lDytmbwEIBYNm
         xY3NwgM+QJfddrJXRUdqCDCNQ7Bu9dM/XkClB0wLZKsP5Tkv+Cm7G2B8I+hUqBKcMxOY
         C3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPD4RY4qraiRCq1ztSPeuf7S7rUN5iQYUCP4UHGY/eRsRQlvYqXhF6hjwd/K/N9qryatNDPPmv8Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzReL/sP6AecdH4eb8PkSjcDHXjXug+aqHomw7P/LZvptfyygLU
	136Sa0CyeXu2YZBA8xcJ57q4goet7yVdSgdqYJg2LRyAjTKM5m6arXWu
X-Gm-Gg: ATEYQzztuFeKPJvicHoYGtmtaux8stfIsCAhG2C+LHCH1Uf6gY/P6ikoYf1Jmxrp26l
	6d28uNFG9kXbinJCcmyNqfo1rFbdCECq/MvrL4YpFcuxAfCQN//MUeGeFXSKR4tlr7c6vNAE9jx
	xL9XrBtMEvRN5N94zpDjInKHtBeusAtf2IQaXyuTuyNSAazMBpoNVqG5QH9NS/mHcuhR1jdEoM5
	1OiGZ6H2ycE95uUGzpX5pWhkI3I1hdNYmmZfUPWq9TryG/UuCxj61wo0UXeY9WcoYZXWZKbYFYL
	EyvLZOJPhHVgU7YOly4iLQ4CwrdH0qdDZ8w6Dg9SFnMSw/ljbfe27/O80vYhH60Yov3BqM5YcdP
	UlJd2MUP0Z9/64ZFHAY+uP4y5jjmHYh1X6q2QVn85O0Hw3HygiitYKr94wmLrfJ8N1AoQpQLy8u
	PNXBBHeEzbeC5S
X-Received: by 2002:a05:600c:81c5:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-48727e90ec7mr192177925e9.15.1774880247693;
        Mon, 30 Mar 2026 07:17:27 -0700 (PDT)
Received: from nsa ([45.94.208.97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270dd790sm172813455e9.5.2026.03.30.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:17:27 -0700 (PDT)
Date: Mon, 30 Mar 2026 15:18:13 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4695: Fix call ordering in offload buffer
 postenable
Message-ID: <acqEopM83muiuzJ9@nsa>
References: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>

On Mon, Mar 30, 2026 at 04:34:39PM +0300, Radu Sabau wrote:
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

LGTM,

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

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
> -- 
> Radu Sabau <radu.sabau@analog.com>
> 
