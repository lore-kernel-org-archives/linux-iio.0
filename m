Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C03ACF17;
	Sat, 13 Jun 2026 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781345383; cv=none; b=qv+6sDHVl1EWRXzVhKqQggNR6e0M0Jec+sCAix06cKyqCiYBpCpr81D8uJKxahd93I3lSvLkLsTRvKZnC5IvjnPq0WKFRXCGpASpiN3PZqJsKNRR+SnKHWd5GuXA9F9yN7XQ2fwzH7oIdQUXL7brzIAOqYRjZRMsxkcqy9ALePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781345383; c=relaxed/simple;
	bh=LRCJuzdgcnepvht2bWBT+iKICZzGD3zNXigrl8GmM0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMi2u1SOnClX3zCaQgR15wVrDqKnFw6PNqqmPvQ+qn+L6jdUkDryz5Ukh1KVnI04soAF2rtStEJIF97oCthAzHmXhhu3ZB5OwrP1fvT5pFGMixGMBkvQmEfxBNyDyg/n8gHVPgvyxGJp6UqbpoRVN5ItzbQGcWuvasDLKRWmPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJW6+Ahi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJW6+Ahi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380091F000E9;
	Sat, 13 Jun 2026 10:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781345380;
	bh=P0BXYzjr6w3+jMq0yJXiRdx6FfTaAxNl+69lgFc2F8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XJW6+AhicnUYOl3N/Dzk15xgcsI8aNcbwr49UynaoV3W4bH06gntgEoRkTwEthGe4
	 Hk+koZqHRBoLVDO2W09cbHsrAMAvaNNYdSR5ukgaq07Wd4dEOtI1S4U561eU8fh0Tm
	 fjiTLKFzq6WzOyZEyWwDBFv6Ka6jQS4TO05lfrkhzjm4utpQv3axEosdhkdhPaCJs6
	 Aapbxm2654LCsnHqr1ckZXWYIhhvmgJLVEP+uqnQ2nuKELFMXB4axdLZaM9Ox7V7j8
	 fAGioQtAJVar6lzDdQd2cAKg4aeNkN2IzECOmqKeyIn/wkP/Y9PrcIRNDP2KOmi+os
	 9t1BOraK/eR1w==
Message-ID: <77f52421-42ea-499a-aa57-a834825a8829@kernel.org>
Date: Sat, 13 Jun 2026 13:09:31 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: lpc32xx: Initialize completion before
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
 <20260613005812.160572-2-m32285159@gmail.com>
From: Vladimir Zapolskiy <vz@kernel.org>
In-Reply-To: <20260613005812.160572-2-m32285159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/26 03:58, Maxwell Doose wrote:
> In the report from Jaeyoung Chung:
> 
> "lpc32xx_adc_probe() in drivers/iio/adc/lpc32xx_adc.c registers its
> interrupt handler with devm_request_irq() before it initializes
> st->completion with init_completion(). If an interrupt arrives after
> devm_request_irq() and before init_completion(), the handler calls
> complete() on an uninitialized completion, causing a kernel panic.
> 
> The probe path, in lpc32xx_adc_probe():
> 
>      iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
>      ...
>      retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
>                                LPC32XXAD_NAME, st);           /* register handler */
>      ...
>      init_completion(&st->completion);                       /* initialize completion */
> 
> lpc32xx_adc_isr() calls complete():
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
> Fixes: 7901b2a1453e ("staging:iio:adc:lpc32xx rename local state structure to _state")
> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
> Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
> Closes: https://lore.kernel.org/linux-iio/20260610115700.774689-1-jjy600901@snu.ac.kr/
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>   drivers/iio/adc/lpc32xx_adc.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index 43a7bc8158b5..db3a602327ff 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -179,6 +179,8 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>   	if (irq < 0)
>   		return irq;
>   
> +	init_completion(&st->completion);
> +
>   	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
>   				  LPC32XXAD_NAME, st);
>   	if (retval < 0) {
> @@ -197,8 +199,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, iodev);
>   
> -	init_completion(&st->completion);
> -
>   	iodev->name = LPC32XXAD_NAME;
>   	iodev->info = &lpc32xx_adc_iio_info;
>   	iodev->modes = INDIO_DIRECT_MODE;

Reviewed-by: Vladimir Zapolskiy <vz@kernel.org>

-- 
Best wishes,
Vladimir
