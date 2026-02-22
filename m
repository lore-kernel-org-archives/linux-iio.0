Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2453EBF17;
	Sun, 22 Feb 2026 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771776213; cv=none; b=nv5lRO/o0Q14LCR7V5P14JKWDckls+/tza0lz2o+Tg58tAqbwPoet3eaODrA3/vljk+AlpligBn67WLYm4HbyUyZZ7QWjYUM4QQb0Gpro/6ZgtZjqMKVUePmyoWtCTDE+biC53SmnjU9Eoz/7G0CbaX9ra43lDc/eWitPqqZdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771776213; c=relaxed/simple;
	bh=+IgpTjECc13FjaSobMmGOE984uaTEmXItdEyEE09khU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2710/G6+nkjBSLMgciAsp/wv3CIs6e25vGid8btpk0bxGfmRSDpJPc/E2S9RSTEhDgeJBznk+EqTHwybXJL39PfnxxPcZ5y5Y4hOD1ZRtxRq4r3DDfKUuLtXgY0WcXL2lPTUBUAAV5z0i8ww0qWT8sSJBIa9jY5sdRydOXAuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXdE7krq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXdE7krq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774A5C116D0;
	Sun, 22 Feb 2026 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771776212;
	bh=+IgpTjECc13FjaSobMmGOE984uaTEmXItdEyEE09khU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YXdE7krqtogy3O5iGPlu1MQLcIZbPCeYSigyno2rrnaVdWYS0ve3BajIjw5ZNP7j2
	 G3wbreCOpXC5YjQ7HsOB70RpICkXhiG7t+MAl1Z9DSKP6cWeUnSCqqU9E2LkdRZ6Yu
	 bEkdF8RSHA2n1CjB0K683mHqyuOU/toBeWfIWQxmWbP7E0lxlurs6zKeB1MKhJGkdX
	 n7SX0LQ052iLP5Dvh70krtmlBi0yVIav7KL8e1dbd5sMrYkdGjFruTfFbAEemb93Vt
	 HXnGRbKtAubDFziL8RG5hLfOaNNz5hZGqpn320Tqv/+r90rbEUuNhV1uD2ErLzjqZQ
	 bT8m0P7axfRKg==
Date: Sun, 22 Feb 2026 16:03:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] iio: adc: nxp-sar-adc: Remove unnecessary type casting
Message-ID: <20260222160325.1e4d1f49@jic23-huawei>
In-Reply-To: <20260222-nxp-sar-adc-v1-1-75e4cdb3ffb7@gmail.com>
References: <20260222-nxp-sar-adc-v1-1-75e4cdb3ffb7@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Feb 2026 02:09:08 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> The readl_poll_timeout() macro returns a signed integer error code.
> 
> In nxp_sar_adc_calibration_wait(), the return value is casted to u32
> before being returned as int, which is unnecessary.
> 
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Hi Felix,

Make sure to include the author of the code you are touching in the +CC list.
Added Daniel.

I think this is simple enough, so I've picked it up now but I'm fine adding
tags or indeed dropping it if other reviews come in.  I'll be rebasing
or rc1 later in the week.

Applied to the testing branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/adc/nxp-sar-adc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> index 9efa883c277d..a6e4888a8464 100644
> --- a/drivers/iio/adc/nxp-sar-adc.c
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -247,7 +247,8 @@ static inline void nxp_sar_adc_calibration_start(void __iomem *base)
>  
>  static inline int nxp_sar_adc_calibration_wait(void __iomem *base)
>  {
> -	u32 msr, ret;
> +	u32 msr;
> +	int ret;
>  
>  	ret = readl_poll_timeout(NXP_SAR_ADC_MSR(base), msr,
>  				 !FIELD_GET(NXP_SAR_ADC_MSR_CALBUSY, msr),
> 
> ---
> base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
> change-id: 20260222-nxp-sar-adc-1906a65ce5b6
> 
> Best regards,

