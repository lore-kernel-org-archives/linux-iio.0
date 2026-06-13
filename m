Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8623B9610;
	Sat, 13 Jun 2026 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781345453; cv=none; b=ctbiY3R/ysw49Sk0ATQjzZYnW6TPoP5gpnwrUrAvNzXtiVBz99stwVPqU3IO/dLGNvqF2j8Pr5QTnTq6SnQ1m/kOX/pBaiPM3y1t8i/WzA7eRE2fJByma6snIlnmvXoZw9NTXsYF8YcxPNNR1p+P6s0IP0JDKtamx8JIuQ1n5Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781345453; c=relaxed/simple;
	bh=3gSgCjGDyTONWM6UlfUTvK+FThXio/Ud8bdvqljEYhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyAenYFRHmAYJhjPlGJqKk+Omz/uETMtE8wXndgl7Q/w2gR44WNGAe8j615o1U9tb+iMNClWtcQ1Mg1dnuiwbgZtkwKAu9/UmVzK8cBPoiVd3KCIusWNDlCAnu1IZ8f/sd7bXe8yp6rXxCjKzQBI08aabtVrew7OlLCm/MLOsTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOVO8/m0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOVO8/m0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635D01F000E9;
	Sat, 13 Jun 2026 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781345450;
	bh=56MO/PWG6Ib9yUFU34ThnLS9zPVnZVEboAJqbyCYvEA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hOVO8/m0hHnWg8qAspMgvmR4pQMkWX/m9xr62Nfgk48m/5xvnislE17EhHGh8K6Jh
	 1zt/RXuS5APwl8xBw5WTTgoli/a8FR17H8urDmsBVbc/tZ47LbdU3WYdO7MR1qFGsc
	 tpreSli1keARbtaD3/MW7BWEQw7HGdDfhbNVdD6DrdbdJsnW1driRnpUK8YSUB8TPO
	 S9p6o6KaV054JhdWC1RcLeK+uKCfNHvDTxcZbeEmZTLA/haSFo1vwxLap2dppAIPzD
	 1R66nk2TsIXDHPJO3PjrJWZPbxzM0/e/jj4AHSt4Ipp1Rt5N2fLb3DDJkGkQ/dstEZ
	 y5obb0p+8BpYg==
Message-ID: <d94f5548-9621-4e9b-afba-1835d95799d2@kernel.org>
Date: Sat, 13 Jun 2026 13:10:46 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: spear: Initialize completion before
 requesting IRQ
To: Maxwell Doose <m32285159@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Hartmut Knaack <knaack.h@gmx.de>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 "moderated list:ARM/LPC32XX SOC SUPPORT"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Sangyun Kim <sangyun.kim@snu.ac.kr>,
 Kyungwook Boo <bookyungwook@gmail.com>, Jaeyoung Chung <jjy600901@snu.ac.kr>
References: <20260613005812.160572-1-m32285159@gmail.com>
 <20260613005812.160572-3-m32285159@gmail.com>
From: Vladimir Zapolskiy <vz@kernel.org>
In-Reply-To: <20260613005812.160572-3-m32285159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/26 03:58, Maxwell Doose wrote:
> In the report from Jaeyoung Chung:
> 
> "spear_adc_probe() in drivers/iio/adc/spear_adc.c registers its
> interrupt handler with devm_request_irq() before it initializes
> st->completion with init_completion(). If an interrupt arrives after
> devm_request_irq() and before init_completion(), the handler calls
> complete() on an uninitialized completion, causing a kernel panic.
> 
> The probe path, in spear_adc_probe():
> 
>      iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
>      ...
>      retval = devm_request_irq(&pdev->dev, irq, spear_adc_isr, 0,
>                                LPC32XXAD_NAME, st);           /* register handler */
>      ...
>      init_completion(&st->completion);                       /* initialize completion */
> 
> spear_adc_isr() calls complete():
> 
>      complete(&st->completion);
> 
> If the device raises an interrupt before init_completion() runs,
> complete() acquires the uninitialized wait.lock and walks the zeroed
> task_list in swake_up_locked(). The zeroed task_list makes list_empty()
> return false, so swake_up_locked() dereferences a NULL list entry,
> triggering a KASAN wild-memory-access."
> 
> Fix the chance of a spurious IRQ causing an uninitialized pointer
> dereference by moving init_completion() above devm_request_irq().
> 
> Fixes: b586e5d9eee0 ("staging:iio:adc:spear rename device specific state structure to _state")
> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> Closes: https://lore.kernel.org/linux-iio/20260610115700.774689-1-jjy600901@snu.ac.kr/
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>   drivers/iio/adc/spear_adc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index 4be722406bb5..ab02a14682ed 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -283,6 +283,7 @@ static int spear_adc_probe(struct platform_device *pdev)
>   	st = iio_priv(indio_dev);
>   	st->dev = dev;
>   
> +	init_completion(&st->completion);
>   	mutex_init(&st->lock);
>   
>   	/*
> @@ -329,8 +330,6 @@ static int spear_adc_probe(struct platform_device *pdev)
>   
>   	spear_adc_configure(st);
>   
> -	init_completion(&st->completion);
> -
>   	indio_dev->name = SPEAR_ADC_MOD_NAME;
>   	indio_dev->info = &spear_adc_info;
>   	indio_dev->modes = INDIO_DIRECT_MODE;

Reviewed-by: Vladimir Zapolskiy <vz@kernel.org>

-- 
Best wishes,
Vladimir
