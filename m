Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498066;
	b=p/cQIUvZXOk/bEmdn08HKABuQPY+USy8haFFqHOdiIWREN1Q0Tz3kcJACHV8MF6vvYpj
	 P9aU5r5RqwGcKbTBBfET4zUeT7URYrhk5Ec9FlBDpW2gLyv2OPIpkwo1sde//kUQe4xPQ
	 afnwOxSXLRyexz76gMfHbjqcumYylGaKA2jWOBv65VNL/bROsfdMo1DJdatBrZILKn0tP
	 PaZRHeNUtITky8zRGKqMFEBIUAVuHwXNKME6Dok7cZzW8FBugWzElZx3ocWbwMN1qbKYB
	 UaOmfVkVasilRgTxm6uFZk4nfinNo3JFYhJ7cKB2ySPIBze8rY0InmTB9SMRzJwCinA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498066;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=v3ObFcPZJbeRiKkRyrxGK09fSNusHiNAUgb/BvLOJQg=;
	b=Qk+KWtaO8yqM9+/DOAbgp+alHvvt4H/Lzl87+I5rLqtuE4iW4N0td2Vphsn8gqloA0mZ
	 MSZiSiLoad5xYiesm4ockHnErF64jhFh/tEs+e8Uf49clzMWjopvA2iWBMvX0PFSpNMGy
	 aG9DT3rcfWXxd6uhu1JTnJ/0a6zlpOnqSrfcK9ehhIwHy75TwtYHCw/O9KhN1tXKcxxZL
	 vykszXukIKdpzBsjBZWXeO+/87tWEy1l6p/hP0EbL4ITqcj8rylB8L3MQtnhiIbCTNM9t
	 4fOQfDsGCs0huwCiWA0RhaELBOTQwlnr+rZQkqCJ1baycyHwVpxQ5Memla3QnqWV9yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FurM66+j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7702606A324;
	Sun,  1 Nov 2026 01:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FurM66+j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4791F000C1;
	Sun,  1 Nov 2026 01:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793498065;
	bh=v3ObFcPZJbeRiKkRyrxGK09fSNusHiNAUgb/BvLOJQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FurM66+jC+VY1wEq07yWqSc5R7ghKYCDEvyM53uyk6CJFxhT3Xb8gEsY7OUEMiEWR
	 7iC5Ax31jSTcxPQGvaa6p2JfeZxnaBOzM2njqdj05lWZPY3UwKNCt1IkqnuAc1BPwR
	 NERuYrub6sLjfUnFQS0PdC8Pe4AnDNB06/B6uVGVNGZHnZ3Nni5DkIc5E8kBgwqU15
	 AfgjSluiP7PMQv4T5ZPIcKmLsCKAXbTYbZUc6sFNIhi1HlRXDKP1AZ2+2dy4BcXMow
	 mzyoNBFlA/mk070M3gdyrardf958pz0XqFb070yuq8f1hNsH3t/MzEETqpIjW6Mqbf
	 O3kPhKoSszHMA==
Date: Sun, 1 Nov 2026 01:54:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: proximity: sx9310: keep the IRQ balanced
 across suspend and resume
Message-ID: <20261101015416.4b477c91@jic23-hlaptop>
In-Reply-To: <20261028220444.70121-2-kapoorarnav43@gmail.com>
References: <20261028220444.70121-1-kapoorarnav43@gmail.com>
	<20261028220444.70121-2-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 03:34:37 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> sx9310_suspend() disables the interrupt first and returns with it still
> disabled if a register access fails. Resume isn't called after a failed
> suspend, so the interrupt is never enabled again. sx9310_resume() also
> returns without enabling it on error. Without an interrupt line,
> client->irq is 0 and both callbacks act on IRQ 0, which the driver
> doesn't own.

irq 0 doesn't exist any more on any architectures I think..
It did once, long ago. Today it means no interrupt.

> 
> Disable the interrupt only once the device is asleep, always enable it
> in resume, and skip both when there is no interrupt.
> 
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>

I'm not keen on suspend and resume not being mirror images of each
other with respect to ordering.

> ---
>  drivers/iio/proximity/sx9310.c | 42 ++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 79ba46d8a0aa..f824d00f1174 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -943,8 +943,6 @@ static int sx9310_suspend(struct device *dev)
>  	u8 ctrl0;
>  	int ret;
>  
> -	disable_irq_nosync(data->client->irq);
> -
>  	guard(mutex)(&data->mutex);
>  	ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
>  			  &data->suspend_ctrl);
> @@ -956,7 +954,29 @@ static int sx9310_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	return regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
> +	ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Only once nothing can fail, as resume isn't called on failure. */
> +	if (data->client->irq)
> +		disable_irq_nosync(data->client->irq);
> +
> +	return 0;
> +}
> +
> +static int sx9310_wake_up(struct sx_common_data *data)
> +{
> +	struct regmap *map = data->regmap;
> +	int ret;
> +
> +	guard(mutex)(&data->mutex);
> +
> +	ret = regmap_write(map, SX9310_REG_PAUSE, 1);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(map, SX9310_REG_PROX_CTRL0, data->suspend_ctrl);
>  }
>  
>  static int sx9310_resume(struct device *dev)
> @@ -964,19 +984,13 @@ static int sx9310_resume(struct device *dev)
>  	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
>  	int ret;
>  
> -	scoped_guard(mutex, &data->mutex) {
> -		ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
> -		if (ret)
> -			return ret;
> +	ret = sx9310_wake_up(data);
>  
> -		ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
> -				   data->suspend_ctrl);
> -		if (ret)
> -			return ret;
> -	}
> +	/* Balance the suspend even if the device couldn't be woken up. */
> +	if (data->client->irq)
> +		enable_irq(data->client->irq);
If we are going to reorder suspend, I'd expect this to also move
and be done before the wake up. I think that should be safe enough?
>  
> -	enable_irq(data->client->irq);
> -	return 0;
> +	return ret;
>  }
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);

