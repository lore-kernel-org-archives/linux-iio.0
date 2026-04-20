Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D081AA8;
	Mon, 20 Apr 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688125; cv=none; b=nLxs/jdA4tiu6R0Yi6ivYn/wH368McGIWh5OBc8tw7JuLvDW1N+Tj4zYfbBi9TLw9DZ6AwrJRsfRZLGZ+4Pc1+/q/NGfn6BtG2EuXIwbr91PkuaA1i3dHZUl8z/P5jISpvAYdMIbjWvJvTRDRBKHTcwfM/vchpzjmS4Su8UvqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688125; c=relaxed/simple;
	bh=PWbi3uYEMLYl5AB0E9ZA8pTD7EAbj4oPfcLDQJ5dlTE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBIbDJCFOtuAHWy7xU4w3RiVWUEyQ2BbitUGf6atWKncScQv1EsGWtNyGb3ir1MzKaArUaiYA94uEOiums5Bg5ZpJ4vcKvwotruitRzPhim7FXUJjqa8j8gxzaTRw/F4Ip/GxcqZBLQYXFtZDAktaJ0rKLVIKUqFGxjWyWCTJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b03Nikmd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b03Nikmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA23C2BCB4;
	Mon, 20 Apr 2026 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776688125;
	bh=PWbi3uYEMLYl5AB0E9ZA8pTD7EAbj4oPfcLDQJ5dlTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b03NikmdD9k3sKoZWaBDQQ583FdvvV7wLwVmW259D07WRaPT9GkHTVqeh4t9cA9K7
	 n62DM7AW/HMU2PBzjaE4ds/khF2bwr9zuxVPmyeSPOvqvre41Lo5dD5vQtgffBlYD2
	 1skE86YqGO5RLoOa6pjLk+dPixvXgiVWbrCXnyGRREXEjW3kxr5umi/zzPR24oqjlS
	 PWWpA+YFDD94YYjbWbQw/58AJut6Er0d0T9By/LeM2Efo5+ejHXO41TZRhT4zr43vu
	 Dsylx0uX5mlAvXepUawKNh4U+8KizNECwWkpn62y5Rj7zeyGyir0n42C248YSMNoGo
	 aNvitnb6wk9lA==
Date: Mon, 20 Apr 2026 13:28:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: tmaimon77@gmail.com, avifishman70@gmail.com, tali.perry1@gmail.com,
 andrew@codeconstruct.com.au, venture@google.com, yuenn@google.com,
 benjaminfair@google.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, andriy.shevchenko@intel.com, openbmc@lists.ozlabs.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: npcm: fix unbalanced
 clk_disable_unprepare()
Message-ID: <20260420132838.147d18b6@jic23-huawei>
In-Reply-To: <20260414123006.262152-1-devnexen@gmail.com>
References: <20260414123006.262152-1-devnexen@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 13:30:06 +0100
David Carlier <devnexen@gmail.com> wrote:

> The driver acquired the ADC clock with devm_clk_get() and read its
> rate, but never called clk_prepare_enable(). The probe error path and
> npcm_adc_remove() both called clk_disable_unprepare() unconditionally,
> causing the clk framework's enable/prepare counts to underflow on
> probe failure or module unbind.
> 
> The issue went unnoticed because NPCM BMC firmware leaves the ADC
> clock enabled at boot, so the driver happened to work in practice.
> 
> Switch to devm_clk_get_enabled() so the clock is properly enabled
> during probe and automatically released by the device-managed
> cleanup, and drop the now-redundant clk_disable_unprepare() from
> both the probe error path and remove().
> 
> While at it, drop the duplicate error message on devm_request_irq()
> failure since the IRQ core already logs it.
> 
> Fixes: 9bf85fbc9d8f ("iio: adc: add NPCM ADC driver")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Applied to the fixes-togreg branch of iio.git. Note I'll rebase that on rc1
once available, before sending a pull request.

Thanks,

Jonathan

> ---
> v3: mention the dev_err drop in the commit log and collapse the
>     single-statement -ENODEV branch (Andy Shevchenko).
> v2: drop redundant dev_err() on devm_request_irq() failure since the
>     IRQ core already logs it, and remove the now-single-statement
>     braces (Andy Shevchenko).
> 
>  drivers/iio/adc/npcm_adc.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> index ddabb9600d46..61c8b825bda1 100644
> --- a/drivers/iio/adc/npcm_adc.c
> +++ b/drivers/iio/adc/npcm_adc.c
> @@ -231,7 +231,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(info->reset))
>  		return PTR_ERR(info->reset);
>  
> -	info->adc_clk = devm_clk_get(&pdev->dev, NULL);
> +	info->adc_clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(info->adc_clk)) {
>  		dev_warn(&pdev->dev, "ADC clock failed: can't read clk\n");
>  		return PTR_ERR(info->adc_clk);
> @@ -244,17 +244,13 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  	info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1) * 2);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		ret = irq;
> -		goto err_disable_clk;
> -	}
> +	if (irq < 0)
> +		return irq;
>  
>  	ret = devm_request_irq(&pdev->dev, irq, npcm_adc_isr, 0,
>  			       "NPCM_ADC", indio_dev);
> -	if (ret < 0) {
> -		dev_err(dev, "failed requesting interrupt\n");
> -		goto err_disable_clk;
> -	}
> +	if (ret < 0)
> +		return ret;
>  
>  	reg_con = ioread32(info->regs + NPCM_ADCCON);
>  	info->vref = devm_regulator_get_optional(&pdev->dev, "vref");
> @@ -262,7 +258,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  		ret = regulator_enable(info->vref);
>  		if (ret) {
>  			dev_err(&pdev->dev, "Can't enable ADC reference voltage\n");
> -			goto err_disable_clk;
> +			return ret;
>  		}
>  
>  		iowrite32(reg_con & ~NPCM_ADCCON_REFSEL,
> @@ -272,10 +268,8 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  		 * Any error which is not ENODEV indicates the regulator
>  		 * has been specified and so is a failure case.
>  		 */
> -		if (PTR_ERR(info->vref) != -ENODEV) {
> -			ret = PTR_ERR(info->vref);
> -			goto err_disable_clk;
> -		}
> +		if (PTR_ERR(info->vref) != -ENODEV)
> +			return PTR_ERR(info->vref);
>  
>  		/* Use internal reference */
>  		iowrite32(reg_con | NPCM_ADCCON_REFSEL,
> @@ -314,8 +308,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  	iowrite32(reg_con & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
>  	if (!IS_ERR(info->vref))
>  		regulator_disable(info->vref);
> -err_disable_clk:
> -	clk_disable_unprepare(info->adc_clk);
>  
>  	return ret;
>  }
> @@ -332,7 +324,6 @@ static void npcm_adc_remove(struct platform_device *pdev)
>  	iowrite32(regtemp & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
>  	if (!IS_ERR(info->vref))
>  		regulator_disable(info->vref);
> -	clk_disable_unprepare(info->adc_clk);
>  }
>  
>  static struct platform_driver npcm_adc_driver = {

