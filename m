Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A555625B0BF;
	Wed,  3 Jun 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507136; cv=none; b=CCXM1YokP7gDjeHCW08UoARW6hylbeIMjadTLWi5cnp4bG2rqOwpiMXAHJPH5SWjRq9n4HzXTQX4y+q8rum5fa08rV2LWOUO1cpqmjQ6WNxzIC/YZ4hEIJ55DwGBWwD/YNEE5ddwwOM7oy5wMEEsKxsPP8f7020tSIdj+uHA9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507136; c=relaxed/simple;
	bh=+PbHsCSBLFBoo6hPIRQ3jbgaaJiXiKwtdR9H9vM+KGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgI7+cPnwRIGqBVy5bOVEQJaquPw9XS/eJbEIhDwpdOSl+hMK3VXNwIm4v7kNRUbYY4CtdYjsZWbxOn5ZU3dwHkjXbV2LuAxvkEWaEDtCIsWbvoVqIgMjywspcns41QFnJZ5JiHtG0T3kfMkbopPkPiUxJxR4chSXLcVO42Mix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtqxAnEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtqxAnEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159F41F00893;
	Wed,  3 Jun 2026 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780507135;
	bh=FUKe0PwGE8tvlkDxheHvwiCo0ta2ANZ0LUf7XfOvUfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JtqxAnEOLk2OvZOvbuIv6l9nT6XZG0zaQ2x2Fv1/V1DRqtqyBl5dQIMfhNd7qKh5a
	 IuRaLI6Ct+x5EXFEsaedqJJ6LqzxVb3nKMDVeWq2vWrcr3Ec93NvFWpkrjkizSDvzl
	 UjnIlUCXT8IwXgWfc3TzMObIuXNihWNppopP7QbMle8AfztgXiQ4ul5eaghYZVwvXl
	 do10E8zUSujz6iIER05zt2NTRvjGqPrFibwvtTeDySE8ziJh1ECJMC4Lpb/zHL9rnR
	 HUEw/bnYJRzL7tdV+bGaXujZr69VJK9gvHAwHOOgJsrH1E1YxfeyUlk5+Zg6fVzNcI
	 pOc7MB2UPMj+g==
Date: Wed, 3 Jun 2026 18:18:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Ethan Tidmore <ethantidmore06@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: avoid double free_irq after trigger
 failure
Message-ID: <20260603181846.7c3a36e8@jic23-huawei>
In-Reply-To: <20260603141633.1398943-1-lgs201920130244@gmail.com>
References: <20260603141633.1398943-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 22:16:33 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

> commit 4216db1043a3b ("iio: gyro: mpu3050: Fix irq resource leak") made
> mpu3050_trigger_probe() release the IRQ when iio_trigger_register() fails
> after request_threaded_irq() succeeds.
> 
> However, that failure is non-fatal to mpu3050_common_probe(). The caller
> only logs the trigger setup failure and continues to register the IIO
> device. Since mpu3050_trigger_probe() leaves mpu3050->irq set after
> freeing the IRQ, later cleanup still believes the driver owns that IRQ.
> 
> If iio_device_register() fails, the probe error path frees the IRQ again.
> If probe succeeds, mpu3050_common_remove() frees it again during unbind.
> 
> Clear mpu3050->irq after releasing the IRQ, and use mpu3050->irq rather
> than the original irq argument to decide whether the probe error path
> still has an IRQ to release.
> 
> Fixes: 4216db1043a3b ("iio: gyro: mpu3050: Fix irq resource leak")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Please check the list for similar fixes.
https://lore.kernel.org/all/20260520152236.2308686-1-xinyuili@126.com/
has a discussion of the right solution here being to just fail the probe
if the trigger registration fails.

The current attempt to paper over that is nasty and not something
we normally do.

Jonathan

> ---
>  drivers/iio/gyro/mpu3050-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b431..0fd881fdd1ad 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1137,6 +1137,7 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
>  
>  err_iio_trigger:
>  	free_irq(mpu3050->irq, mpu3050->trig);
> +	mpu3050->irq = 0;
>  
>  	return ret;
>  }
> @@ -1260,7 +1261,7 @@ int mpu3050_common_probe(struct device *dev,
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> -	if (irq)
> +	if (mpu3050->irq)
>  		free_irq(mpu3050->irq, mpu3050->trig);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  err_power_down:

