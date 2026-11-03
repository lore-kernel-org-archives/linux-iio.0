Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793689542;
	b=ezSgYOnoec2xgYLl7wHetQXzadamavgMZftTb8TsXpzAQxtBLh8/Y5t9d9oDsQndHoXD
	 CGu2QMMMXR4K6NCDKKschE4+IlLjYYwoaFMe45gLYXH9UjdT5ZzItIoVBb5P8VfZAFGP5
	 dlVxQt0+99vtrADI0ZA2zzzFGBrmiN+fFMxUKDKgMxKEsO/+2GGDTH07TiWvDB8BiP6VL
	 bPJsUI5r8273KLCQmxTicXP6kBp2RbwYS6vg7wEbp27eSLE2H/X+75OZztKKwkmACWlNh
	 guuKVl6pahASC547fdtmbVhJQ8/Zb+X6D31DWiIwjgNrih/3hA1AEN0oNjPHL8h2g7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793689542;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=m69S8GAWIcolCD174TtHbNXT0/7WGT8M9Xze/Z33az0=;
	b=etdBU1PDvpvEUDakVrxFK/4HO+3X9+vg0HqNfYHoEjgaVEZGzszuoLc8kxeVDqwRI5Cm
	 xnFxBSvYYkuai1AIxioCEvbu8eUBj8BhNUMYxdPE2g/yIQyd69R9QLZHFKcNGNktVxO1B
	 dZNSJbH9NzMxrBfOi/NBQcy7VR3+1NplHzCoOePKmcEMe8CqDA65I7H5sODT1WIa+dSO0
	 xx++J9LdniUmxcrOhKg0bp5XkG1pJAGGgY12s9WxdWzY53YC1xLeKX1IMi0BpcrSDmDWE
	 7xcdYUquOiqPwFWQ/vx17HDwYS36hizR/W4b//AiEUHk71ztkR0mSHo8Kp33uuhTgWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=VxCSHYV8;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70473606A32E;
	Tue,  3 Nov 2026 07:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70473606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=VxCSHYV8
Received: from [192.168.1.10] (unknown [52.172.102.187])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8270820B7166;
	Mon,  2 Nov 2026 23:05:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8270820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793689527;
	bh=m69S8GAWIcolCD174TtHbNXT0/7WGT8M9Xze/Z33az0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VxCSHYV8nnK+RVLEmx1wYoQ0JQRZ7nt6eUUV/sT+JrBhNIu8xGoz49bXXGtOAzb1T
	 8Alkg+E/z33YXdffv+a7t2ZAZ4/bwL980Usv5j9mcAs4YZckkFdy/E9ohKhKbyBO13
	 XI7mI6i/ZfvTnsX5+ZknoCZeh7zU1n9qc5IVNKe4=
Message-ID: <561328cc-0c0f-43b7-ad7e-a362e183f295@linux.microsoft.com>
Date: Tue, 3 Nov 2026 12:35:35 +0530
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] iio: adc: versal-sysmon: fix race in interrupt
 teardown
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 amitrkcian2002@gmail.com
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
 <20261102122112.1723130-2-amit.kumar-mahapatra@amd.com>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20261102122112.1723130-2-amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Amit,

On 02-11-2026 17:51, Amit Kumar Mahapatra wrote:
> sysmon_disable_interrupts() masks all interrupts, clears masked_temp and
> cancels the unmask worker, but leaves the interrupt handler live. A
> worker that is already running can re-enable an alarm through IER after
> the mask write. If that alarm fires, the handler queues the worker again
> after cancel_delayed_work_sync() has returned. On unbind this action runs
> before devm releases the IRQ, so the queued work can run after the
> devm-allocated iio_dev that embeds it has been freed.
> 
> Disable the IRQ first so that no handler is running or can start, then
> clear masked_temp and cancel the worker, and mask all interrupts last,
> once nothing is left that can unmask them. Record the IRQ number for
> this.
> 
> Fixes: c7f7eb10638f ("iio: adc: versal-sysmon: add threshold event support")
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>   drivers/iio/adc/versal-sysmon-core.c | 5 ++++-
>   drivers/iio/adc/versal-sysmon.h      | 2 ++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index 1b55d343982e..6b9a58e19831 100644
> --- a/drivers/iio/adc/versal-sysmon-core.c
> +++ b/drivers/iio/adc/versal-sysmon-core.c
> @@ -781,12 +781,14 @@ static void sysmon_disable_interrupts(void *data)
>   {
>   	struct sysmon *sysmon = data;
>   
> -	regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
> +	disable_irq(sysmon->irq);
>   
>   	scoped_guard(spinlock_irq, &sysmon->irq_lock)
>   		sysmon->masked_temp = 0;
>   
>   	cancel_delayed_work_sync(&sysmon->sysmon_unmask_work);
> +
> +	regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
>   }
>   
>   static int sysmon_init_interrupt(struct sysmon *sysmon,
> @@ -807,6 +809,7 @@ static int sysmon_init_interrupt(struct sysmon *sysmon,
>   	if (ret)
>   		return ret;
>   	sysmon->temp_mask = imr & SYSMON_TEMP_INTR_MASK;
> +	sysmon->irq = irq;
>   
>   	ret = devm_request_irq(dev, irq, sysmon_iio_irq, 0, "sysmon-irq", indio_dev);
>   	if (ret)
> diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
> index bb9a75bf71c0..701ef9b56263 100644
> --- a/drivers/iio/adc/versal-sysmon.h
> +++ b/drivers/iio/adc/versal-sysmon.h
> @@ -85,6 +85,7 @@ struct regmap;
>    * @regmap: register map for hardware access
>    * @lock: protects read-modify-write sequences on threshold registers
>    *        and cached state that spans multiple regmap calls
> + * @irq: interrupt number, 0 when events are not supported
>    * @irq_lock: protects interrupt mask register updates (MMIO path only)
>    * @masked_temp: currently masked temperature alarm bits
>    * @temp_mask: temperature interrupt configuration mask
> @@ -101,6 +102,7 @@ struct sysmon {
>   	 * that spans multiple regmap calls.
>   	 */
>   	struct mutex lock;
> +	int irq;
>   	/*
>   	 * Protects interrupt mask register updates.  Only used on the
>   	 * MMIO path (fast_io regmap); I2C has no IRQ and never reaches

Change looks good to me.

Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

Regards,
Prasanna Kumar
