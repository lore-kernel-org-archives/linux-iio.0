Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162491B4156;
	Mon, 27 Jul 2026 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785120016; cv=none; b=JJy/rGIhxFExQoB5RP6ldYWCHpd6K1wQpOT0iOZjI6I6Hs2CeMfzZ3kqOZh16T/Ibsa49kpNeWipc7YWNsDvv1AifQj/sBjov6X71YWSBqYgDzNuKtue3vcqB68/HUGdlLIHzP/5FFLt35oFsnucn0kX28WjQGSEd6ErPKnMXsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785120016; c=relaxed/simple;
	bh=mFX0YhIuGf8N+4EXFTjdxhJS4A0x862yU3QMCesLquc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQtFnBJJU9vK/QP0T2Ob3NnItzL/Ekm6Tn2HhsG677B0gDUSQ48rSVre4K5fCuPOZ5gzGUSHWQ8FyhOpa0q6wgoJ9rEzJ1Ie73j7JraZwb7bo4HHREtiVGE8NEozcgilCGG6zEhpeh8jgMUJ3GTuGktHm2wVjCR/PeOxFxTC/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmnPZ8r1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmnPZ8r1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494D21F000E9;
	Mon, 27 Jul 2026 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785120014;
	bh=8gGVaqhMM6oty27Z2QyYNDyN7nHEV0g8AXLNh84UazY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MmnPZ8r1N2DP2awT0imlw1xCiMZ3q6s3T6UawUAJTbEX1lxJwEzgONztghtNMiY2Q
	 BX2rYcSue1uMEXiP6NY+yvPGMtzYBDDhjKxC3uDM/PO+s1FsM+DLmhx8Vhs7unB2wH
	 zCOE3dj/mz1S27dF81y6fU+xH/IC7ITunGG7/wCeHw65Lvpw5NEU9KGcJaEpcJlq2q
	 5ad1/uBHL9i+la2IdwGjHcxaVG4hRkw1xHTl8lt4NlzoanVRVEr8EcuwxPpVhlJBBg
	 P5L49x/wD84uxCPmD7EH7jt0F9vhn7toehX5hiKEXk0Y6xRIOZKSnTZ3oj3vIuYFGu
	 b4OzHGrbbphzA==
Date: Mon, 27 Jul 2026 03:40:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: mdshahid03@gmail.com
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: bcm_iproc_adc: Use dev_err_probe() for
 resource acquisition failures
Message-ID: <20260727034009.5c6b0be9@jic23-huawei>
In-Reply-To: <20260726180319.315016-1-mdshahid03@gmail.com>
References: <20260726180319.315016-1-mdshahid03@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 23:33:19 +0530
mdshahid03@gmail.com wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Replace open-coded dev_err() and error returns with dev_err_probe()
> for failures from syscon_regmap_lookup_by_phandle() and devm_clk_get()
> in the probe path.
> 
> This simplifies error handling and properly handles deferred probing.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index cf4738b16e62..62f12eecc8b2 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -522,19 +522,16 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  
>  	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>  			   "adc-syscon");
> -	if (IS_ERR(adc_priv->regmap)) {
> -		dev_err(&pdev->dev, "failed to get handle for tsc syscon\n");
> -		ret = PTR_ERR(adc_priv->regmap);
> -		return ret;
> -	}
> +	if (IS_ERR(adc_priv->regmap))
> +		return dev_err_probe(&pdev->dev,
> +				     PTR_ERR(adc_priv->regmap),
> +				     "failed to get handle for tsc syscon\n");
>  
>  	adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
> -	if (IS_ERR(adc_priv->adc_clk)) {
> -		dev_err(&pdev->dev,
> -			"failed getting clock tsc_clk\n");
> -		ret = PTR_ERR(adc_priv->adc_clk);
> -		return ret;
> -	}
> +	if (IS_ERR(adc_priv->adc_clk))
> +		return dev_err_probe(&pdev->dev,
> +				     PTR_ERR(adc_priv->adc_clk),
> +				     "failed getting clock tsc_clk\n");

Why stop here?  There seem to be a number of other prints that follow
that would benefit from dev_err_probe() at least in terms of simplifying
the code if not due to the handling of potential deferred probes.

Please look at them all but also consider if the print is necessary.
Beware there are some mass removal patches dropping some specific
prints so you may cross with those.

Jonathan
>  
>  	adc_priv->irqno = platform_get_irq(pdev, 0);
>  	if (adc_priv->irqno < 0)

