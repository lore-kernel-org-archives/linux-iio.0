Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E923EAB0;
	Sun,  2 Aug 2026 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635934; cv=none; b=MesWPoOF7vpH9NWZuNJZKLfDh64K3jgxhQS7ZunZXHQdL8UtDbBUXW8y56LbwXRntAsglFIElW4qS0Xs9gtSlbtk6WdTion219zmo9ulGRNDJrq6vr0cFa25xtZpr4sxSqezHuyZW7EE44x00dJPrBTm/Ww8YicNRM/wAxo6vYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635934; c=relaxed/simple;
	bh=9Ni8HLGb121Ncvp8G7uCNHi/IFTis+SX6CguPyCNkrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+iDrpWz9NxbXJD3Izv2js/CFSxYWKdF/b0IDwGPPP4pOOIKtn7E7N9TxD7TRDm7A1+6K8CzH7WEMO9mgE4qf8DprFgiHKkjLzz4rTqrQjWMXuaVMRloorgggSWPfIb2E93R9G32+vY6/M27CZxxKXIxJUTH5jAMnohPgRO/eIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXEcyX/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXEcyX/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EC01F00AC4;
	Sun,  2 Aug 2026 01:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635932;
	bh=IMDkAxGJ7v6butpvK/e/zpY2uB39Qiw/5WZgRWn7aMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WXEcyX/tVOkg2UaK5pyxi7cgWnrudYBSzymSi8U9Q/hjFdwgepir0q7eaNgRiBSab
	 9jjhlBVeUQR1dGsCQKJoi7apBNSgt3DrivBK2YZwrgMgFaQnDL3zNBHiwM3W55aAv6
	 BTUCoEGFmalP2Ku6X/aUgIK4ySD6+3fLj67SCOzLPqF9uplICY81XyKcfU5cgICgts
	 OpAb7b7Xx5rNxVUIlmu9yYNi5lvbARJzNqoRuQhcw5L/7yvXAysngxXR7TYofFkizy
	 PwOKdC/f5S/Y5BYpi/sSINvt9PNyl0YyGjEEs8UXlhpmCrpmf+tNaZD1qREaECsyb6
	 1E27EBLEggpcg==
Date: Sun, 2 Aug 2026 02:58:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: mdshahid03@gmail.com
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joshua Crofts
 <joshua.crofts@broadcom.com>, Broadcom internal kernel list
 <bcm-kernel-feedback-list@broadcom.com>, David Lechner
 <dlechner@baylibre.com>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v3 2/3] iio: adc: bcm_iproc_adc: Introduce local device
 pointer
Message-ID: <20260802025847.08aed96b@jic23-huawei>
In-Reply-To: <20260731182347.42888-3-mdshahid03@gmail.com>
References: <20260731182347.42888-1-mdshahid03@gmail.com>
	<20260731182347.42888-3-mdshahid03@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 23:53:46 +0530
mdshahid03@gmail.com wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Introduce a local 'struct device *dev' variable in iproc_adc_probe()
> and use it instead of repeatedly referencing '&pdev->dev'.
> 
> This simplifies the code and makes subsequent error handling changes
> less verbose.
> 
> No functional change intended.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 1b0dd654402f..29ea35972a23 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -506,9 +506,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  {
>  	struct iproc_adc_priv *adc_priv;
>  	struct iio_dev *indio_dev = NULL;
> +	struct device *dev = &pdev->dev;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev,
> +	indio_dev = devm_iio_device_alloc(dev,
>  					sizeof(*adc_priv));

	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_priv));

It fit on one line under 80 chars even before the change but it is even
shorter now so let us tidy this up whilst we are here.



>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -523,14 +524,14 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	adc_priv->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
>  			   "adc-syscon");
>  	if (IS_ERR(adc_priv->regmap)) {
> -		dev_err(&pdev->dev, "failed to get handle for tsc syscon\n");
> +		dev_err(dev, "failed to get handle for tsc syscon\n");
This is creating churn we don't need.

Generally I'd suggest only applying the newly available dev where you
aren't going to refactor the line later in the series.  Then just
add a note there to say that alongside using dev_err_probe() you are taking
advantage of the now available dev local variable.

>  		ret = PTR_ERR(adc_priv->regmap);
>  		return ret;
>  	}
>  
> -	adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
> +	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
>  	if (IS_ERR(adc_priv->adc_clk)) {
> -		dev_err(&pdev->dev,
> +		dev_err(dev,
>  			"failed getting clock tsc_clk\n");

Similar on this one.

>  		ret = PTR_ERR(adc_priv->adc_clk);
>  		return ret;
> @@ -543,11 +544,11 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	ret = regmap_clear_bits(adc_priv->regmap, IPROC_REGCTL2,
>  				IPROC_ADC_AUXIN_SCAN_ENA);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to write IPROC_REGCTL2 %d\n", ret);
> +		dev_err(dev, "failed to write IPROC_REGCTL2 %d\n", ret);
and this one.
>  		return ret;
>  	}
>  
> -	ret = devm_request_threaded_irq(&pdev->dev, adc_priv->irqno,
> +	ret = devm_request_threaded_irq(dev, adc_priv->irqno,
>  				iproc_adc_interrupt_handler,
>  				iproc_adc_interrupt_thread,
>  				IRQF_SHARED, "iproc-adc", indio_dev);
> @@ -556,14 +557,14 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  
>  	ret = clk_prepare_enable(adc_priv->adc_clk);
>  	if (ret) {
> -		dev_err(&pdev->dev,
> +		dev_err(dev,
>  			"clk_prepare_enable failed %d\n", ret);
And here.

>  		return ret;
>  	}
>  
>  	ret = iproc_adc_enable(indio_dev);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to enable adc %d\n", ret);
> +		dev_err(dev, "failed to enable adc %d\n", ret);
you probably get the idea by this point!

>  		goto err_adc_enable;
>  	}
>  
> @@ -575,7 +576,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
> -		dev_err(&pdev->dev, "iio_device_register failed:err %d\n", ret);
> +		dev_err(dev, "iio_device_register failed:err %d\n", ret);
>  		goto err_clk;
>  	}
>  

