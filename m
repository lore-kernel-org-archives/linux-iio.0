Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872FA213E89;
	Tue, 12 May 2026 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586678; cv=none; b=VL4zIJZMhuOng5cpGVsAMB/DANJ5/WdZu0W3hqA0m6HVuO/0yjGUV5/zDHIoRD3RncFtHF8MheWix1CUk67AJm+dIejr2ACUxcBIFT5TzKuFxd02+LsIaRAaEMYOkkixrKIfLG7eXRpM/5WW81nocQ2cNZOx2sLgUsnc6NktyjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586678; c=relaxed/simple;
	bh=WwtAEaqrbtuEVAX/vXP89IUrWEza728BCI7n+J1nGLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMHRLlEUiB6WGK6BDhXYkEnZNRN6KL669TnvVHF08ZNfzbAlkdXxZuxpNcHklJ5wJl0KIxE07OiAmpAqhFyPJhv3nG8Krtj+uHipeeMEncj5d0EbY4fUQZCffzDgc2PfdjbJA/B2oxKCbFE9/Sa03xohSLW76IqTyxl1PjoR5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMQZJaJL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMQZJaJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B77C2BCF5;
	Tue, 12 May 2026 11:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778586678;
	bh=WwtAEaqrbtuEVAX/vXP89IUrWEza728BCI7n+J1nGLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mMQZJaJLv45V6KsaO3pklTKlKQhPyIF11vtRvSavicYEwqAvBXa3tsFr7d1ioRk2H
	 lAtjgai6EQQznJp4zj9Vqt6nI27MNmRyD+lwlA3wDus8TgdfGRWaRqdb0F9mWEjd6s
	 KkPxGUcHTGwCsWtu78pc4XDIjmzuZ4svCZjpyuHyDtm2sYzuNYTrXWAlhJe+yiu7V5
	 A9wY4seQs0kv3daJ7hzNOswDVlld81RowGlbTTfzeH9PUx45a5CZNkzyvwtJUgIhqU
	 gJpHpOFm2o9JyfoLOjyvA5GGoiaL0syM9dvfU/RJooD+Pt1+fjS2J7iVtugQgItIEL
	 8PcJtJG17a+Fg==
Date: Tue, 12 May 2026 12:51:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michal Piekos <michal.piekos@mmpsystems.pl>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Maksim
 Kiselev <bigunclemax@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: sun20i-gpadc: add A523 gpadc support
Message-ID: <20260512125106.718d48d9@jic23-huawei>
In-Reply-To: <20260510-sunxi-a523-gpadc-v1-2-4f6b0f4000fb@mmpsystems.pl>
References: <20260510-sunxi-a523-gpadc-v1-0-4f6b0f4000fb@mmpsystems.pl>
	<20260510-sunxi-a523-gpadc-v1-2-4f6b0f4000fb@mmpsystems.pl>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 May 2026 14:57:23 +0200
Michal Piekos <michal.piekos@mmpsystems.pl> wrote:

> A523 differs from existing sun20i-gpadc-iio by having two clocks; bus
> clock and module clock.
> 
> Change driver to enable all clocks.
> 
> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
I'm expecting this to change given comment on not being quite compatible so
I'll wait for v2 before reviewing.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/sun20i-gpadc-iio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
> index 861c14da75ad..dd4c7e6e3d76 100644
> --- a/drivers/iio/adc/sun20i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun20i-gpadc-iio.c
> @@ -180,7 +180,7 @@ static int sun20i_gpadc_probe(struct platform_device *pdev)
>  	struct iio_dev *indio_dev;
>  	struct sun20i_gpadc_iio *info;
>  	struct reset_control *rst;
> -	struct clk *clk;
> +	struct clk_bulk_data *clks;
>  	int irq;
>  	int ret;
>  
> @@ -205,9 +205,9 @@ static int sun20i_gpadc_probe(struct platform_device *pdev)
>  	if (IS_ERR(info->regs))
>  		return PTR_ERR(info->regs);
>  
> -	clk = devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR(clk))
> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable bus clock\n");
> +	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to enable clocks\n");
>  
>  	rst = devm_reset_control_get_exclusive(dev, NULL);
>  	if (IS_ERR(rst))
> 

