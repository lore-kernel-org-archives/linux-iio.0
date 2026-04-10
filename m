Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539BB3A63F7
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854004; cv=none; b=SZjX06E2a4dxq3Qw/AkLW2b7CTnzIAdUpZr5Kl0zWlBAVSBLaCO/XaIvXLIBoqSliDRJoxZo87QaubNP81VxesoaxbDPACDv6lVHppkLnZcZPEQ1Ja/Mv4xSyTCBBBGwafpKMzQ6ot5Zskqzo89smcSAbhG1zwZZz2NVuhjbsbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854004; c=relaxed/simple;
	bh=HgJlDciSQOJkjPYMFiEeV5PqKaSjuxwAnLaENFbkQ2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQsy6MjiFdIbboQbe5l72LviKI3VzHv0PyX1CGktEnJGRxG/FPBDKAQfDZA+aaj69cZPPkdsIQdNIaWiMTEjtWslgqq0r00qlcPyoZBL+Rq7e7OUZqtS+Oa9ReLa0GqeRuC9PGsEWEtxh9wArY5fsTVdH9+FW4ST2R++HsLB/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=SSXXPTeU; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="SSXXPTeU"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dbff06e4a6so2361272a34.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775854000; x=1776458800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBpd+T8YvVMEln4nst2HllR/pz5g067Ap3lkXU/baHU=;
        b=SSXXPTeUQiGcPrLOlslscjIjBqIb/CoeAjzlc8XFGUpaWLHeXIAqj7EjK0KzK+04eh
         NRF9vZxeO79fiozCFkpmFQ+dmv+EQimJ+YWUoHnCiHHhYKssCUFdLccV0F1wCbeWPqdr
         B0+/oYek4duFyafbrOY7PyJocwpKCr2nHXtntjZhoFYH61fhQnAp6RMfPUaL+dMYMwxu
         sDO+hYxUINlRDbGmovVFcKtLPzydclkrIAhw9hZWieKnkzy+fVbO+OsfM+RMVwQS4izp
         tWdITiArNxuW9QChVdfkLpVHiIPAv8InLrhyDYCijkcNf1+Bmkf1nEFl5BUqfYOaG8WU
         HcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775854000; x=1776458800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBpd+T8YvVMEln4nst2HllR/pz5g067Ap3lkXU/baHU=;
        b=Qi0h1cOOiJ/T6qbHjujFKjhiy4IjoC8aHGfgqME79OXSno4zkoEZgBq3oNYZCFHkst
         wWaEGaTnsBvRQa0wCjW+aHv3qTeB6zCgp5PcVwrx+XceGKUkCP3x0tmyt13UQKkEGBJi
         jTiijzG6H3rl0t9r6fYKHzK7g3z2UXITDv/0zN3e9LTFCFzcAmNSOy4lcZ+BMEjansOm
         U0j7C/3LokKTSP6VEZ/rg1uH3zdLaXkrYgRLp0hi7DU27hz/YuuWx5Lfwws1k7Dz6whY
         6e6Scfcu4Kwos/FebYCmqh65J/Ycmiyg2g8k58oVqLZaYHPIIrORq7jb1WnbYQuHT+DH
         ijFA==
X-Gm-Message-State: AOJu0YzIvGAiFrbZl0PJzCiAtdgvow5HqDscjKUpLLLne2WMEVr8kjaV
	mIiDJnbSoUBEDpvsHAis+BuTeM1bU4k2GG/fc3XJHaqSytkB25+04Wx2vGh/b8v7zgs=
X-Gm-Gg: AeBDiesSVpPkYiFz0M8kUcdrgSPPW2rS+3aX4wsuFDOQ9PgUc7yBt/2XV3NpRDd/jsl
	wFcr0wzio4P1IhcRGBMCL8QOtVMyc2Mhb1ZHXKZB0bGbfA4+rZshk3kImYqqm9QU5cAP/PRnpiD
	Jj6KPNbPuE99VtTdAlaEIjlgnySL5azBtpJrTTD7E8vAcvsWesBm2t2tFO7kKbN9Vc/yePP55Mo
	kFWfC29/4Qzemu93wxdk0FIPiQcDHFgzejKOa3ubGTAmHkfUU+/CmZR3I25zDkigw2zsEwr1U3Y
	Lb5gQq9qi5dSHUw8YMeUNhiLZPOyFkALm84VqbCC0xPvPDpBHCtbcWZt49qv/4lU7kIzLFK2h6f
	cPOcWGj4zxJVm22Qcn/iNVKW3ZA9Fw1ZOWYANZ006rHkhlFkJWIM7YVnFSj6XAu3g1xJOUPRSPf
	aEoo+rHpSv+v2roq/gIYfFDnLCKXj2l1CRa51pKK6/uyPjEX6S5pqxsDh3t8vU+6KQYzl/EDtkq
	MbMpl0dc7HP
X-Received: by 2002:a05:6830:6684:b0:7d7:faa4:6c2b with SMTP id 46e09a7af769-7dc27cc0028mr3047317a34.9.1775854000316;
        Fri, 10 Apr 2026 13:46:40 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc269402b9sm2527358a34.20.2026.04.10.13.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 13:46:38 -0700 (PDT)
Message-ID: <0f05add7-96c0-4eee-b396-d6e1be904c09@baylibre.com>
Date: Fri, 10 Apr 2026 15:46:36 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] iio: adc: ad4691: add triggered buffer support
To: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-3-be375d4df2c5@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409-ad4692-multichannel-sar-adc-driver-v7-3-be375d4df2c5@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add buffered capture support using the IIO triggered buffer framework.
> 

...

> @@ -201,8 +245,45 @@ struct ad4691_state {
>  	 * atomicity of consecutive SPI operations.
>  	 */
>  	struct mutex lock;
> +	/*
> +	 * Per-buffer-enable lifetime resources:
> +	 * Manual Mode - a pre-built SPI message that clocks out N+1
> +	 *		 transfers in one go.
> +	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
> +	 *		    transfers in one go.
> +	 */
> +	struct spi_message scan_msg;
> +	/* max 16 + 1 NOOP (manual) or 2*16 + 2 (CNV burst). */
> +	struct spi_transfer scan_xfers[34];
> +	/*
> +	 * CNV burst: 16 AVG_IN addresses + state-reset address + state-reset
> +	 * value = 18.  Manual: 16 channel cmds + 1 NOOP = 17.
> +	 */
> +	__be16 scan_tx[18];

Needs __aligned(IIO_DMA_MINALIGN) since it is used with SPI.

> +	/* Scan buffer: one BE16 slot per channel (rx'd directly), plus timestamp */
> +	struct {
> +		__be16 vals[16];
> +		aligned_s64 ts;
> +	} scan;

Unless it is required that all channels are always enabled:

	IIO_DECLARE_BUFFER_WITH_TS(__be16, scan_rx, 16);

In any case, needs to be DMA-safe for SPI.

>  };
>  



> +static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int n_active;
> +	unsigned int k, i;
> +	int ret;
> +
> +	n_active = bitmap_weight(indio_dev->active_scan_mask, iio_get_masklength(indio_dev));
> +
> +	memset(st->scan_xfers, 0, (2 * n_active + 2) * sizeof(st->scan_xfers[0]));
> +	memset(st->scan_tx, 0, (n_active + 2) * sizeof(st->scan_tx[0]));

Maybe simpler to just clear the whole thing? (same with other preenable)

> +
> +	spi_message_init(&st->scan_msg);
> +
