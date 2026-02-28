Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72C1DF980;
	Sat, 28 Feb 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772279314; cv=none; b=u8lG6FFtDWX3Ob81eyj7VizDyC5Ldz9mCMd1Mz2SeI3IBziSCyGLnd8sIYK8kfQJm8rzNEkGPg8yzmd7iwijoLDoQU3km35arS5TcOEBLYzV738UzDuseDP93so8UQdugtNCf1qcnIkNW9DdYYf3FeMsRQmXFtw0YYk82ahbVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772279314; c=relaxed/simple;
	bh=B37Ukv7J3NSxwerfobnuMH6EYc4pdUizc2evnOXtwDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tc6zziv1969oShKu3YfpIO+q8Jp7Im+Lzm1EsvR9EFgDNixEdOLUXbEVsaZ5Tpz33zfnAdRMmcK5b6Wz5yOwaMT9RHm0sdHAxNzqFUlOInSY5D2o95YMFyp+yN2M7/yilBO+63z+NCeXElz1IBif+xN+JpA23+EKWsbxCxBI/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcWT3vAF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcWT3vAF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A51C116D0;
	Sat, 28 Feb 2026 11:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772279314;
	bh=B37Ukv7J3NSxwerfobnuMH6EYc4pdUizc2evnOXtwDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OcWT3vAF3JV1A1pn4bVJcNd/2DCSaoRPLTVDccZKb+EZDLgujz6EDHHKZsStoATBE
	 wUUxtetsXqFzcgcwOhCwygfKtf0QbPCrOCxdc24U6C5FgoFK/z7Y6Odn9ofbieFN6h
	 kqoVl9QrK7dhwolQ/9bcgrRFcUfMLiPldirYoFMoHMQ2+ZE2wgdZxl/7upiOlY6D4S
	 Rkb4hjlwDd9K7CQxAJznAbR8ItaV937y8O2xV/4kvPeQeVDN4GIW1vJRmu+Si7Y4Os
	 Ou4W2kMbpHzH26GMKZHRSTkowxlZtGenLaKcvS54poxcm7M+3LIvfa8vgvkk3Jua1y
	 GlyfmMVRNTUcA==
Date: Sat, 28 Feb 2026 11:48:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: abp2030pa: Remove IRQF_ONESHOT from
 devm_request_irq()
Message-ID: <20260228114823.1411901d@jic23-huawei>
In-Reply-To: <20260227-abp-v2-1-a482c02a5876@gmail.com>
References: <20260227-abp-v2-1-a482c02a5876@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 21:54:29 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
> without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> in IRQ request and gives a warning if there is no threaded handler.
> 
> Remove IRQF_ONESHOT from devm_request_irq().
> 
> Fixes: 47d323ce1e89 ("iio: pressure: add Honeywell ABP2 driver")
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Applied to the fixes-togreg branch of iio.git.  If Petre wants to take
another look and perhaps give a tag that would still be welcom.

Thanks!

Jonathan

> ---
> Changes in v2:
> - Fixes Petre's comment.
> - Link to v1: https://lore.kernel.org/r/20260227-abp-v1-1-b6fed0545852@gmail.com
> ---
>  drivers/iio/pressure/abp2030pa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/abp2030pa.c b/drivers/iio/pressure/abp2030pa.c
> index 4ca056a73cef..b44f1bf4c633 100644
> --- a/drivers/iio/pressure/abp2030pa.c
> +++ b/drivers/iio/pressure/abp2030pa.c
> @@ -520,7 +520,7 @@ int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq)
>  	data->p_offset = div_s64(odelta * data->pmin, pdelta) - data->outmin;
>  
>  	if (data->irq > 0) {
> -		ret = devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_ONESHOT,
> +		ret = devm_request_irq(dev, irq, abp2_eoc_handler, 0,
>  				       dev_name(dev), data);
>  		if (ret)
>  			return ret;
> 
> ---
> base-commit: 7d6661873f6b54c75195780a40d66bad3d482d8f
> change-id: 20260227-abp-016a007ab817
> 
> Best regards,

