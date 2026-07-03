Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E558C1FECCD;
	Fri,  3 Jul 2026 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783119864; cv=none; b=q4RZGj+krq+qHE55nZ1AprWHNoINWlEPy5ozVRHWkoxNnoBwXaIytOK/gumCGdhRSg53GsiXQesH9z8XW2xcNTErdAQnZnx9bjPto9N+cJl5QOG0GSQmL+4CzgtgsM92vYvYv4ZOTVnSo2NOVcnkv6gv5VC4tnWSxU8iCDTYq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783119864; c=relaxed/simple;
	bh=zQFfgLnKSkWXpCokLzDdPA40A/RbpP7PXd9xlAuwn7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDNyoR/Y5+jRDibU67zkV79hvm9YGSh95P809dhxX+C2VvXU5PdsCPTQmXGh4oX1IkaiRw5ITdZgf2J0RVSc7ghzLxJbJWTWHxQ/sfPqDZ0zruuWHLv/SESHa7TKDuaHMD0a/mgraKayF2wdmdd5+yLGNsIE2iVqEryQlb++nmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8q7ncfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8q7ncfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F381F000E9;
	Fri,  3 Jul 2026 23:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783119862;
	bh=olNz6+nAW+5xnjW18enaUnEgTjoEBQsIDW68RPSTSic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l8q7ncfS+YM7xgM4BIQ/mXfBmgk6+UdMMWaFNXOyr9KcKz75E6y+jGmmMRsogCuId
	 4DICAPGNSVY8Xk7Ek8HAduexKZ49xoDwvK3ylW3Po8NEQpZ4sXHlJlp+hJey8VBquf
	 V5xL7eQUCUTsNq516HYT6zdNWgFoTgb5TmZpdWQioBiASXR/B3q5zcseI7pSY7Hznp
	 W07SDvyVejTcWQ2Dy9jG7YXGXCbB66FataVx66mpzfdBYN9+OjI2tNdu7oT220ND+S
	 tJf2/lRHMvtGVUSrX2IvduwvQEFzqhktVmoB3gmHTeRTGGyYjFkFCbT48tpohrLZzt
	 fDaweZD1ulvzg==
Date: Sat, 4 Jul 2026 00:04:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 hcazarim@yahoo.com, linux-iio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org
Subject: Re: [PATCH v3] iio: adc: qcom-spmi-iadc: balance enable_irq_wake()
 on driver unbind
Message-ID: <20260704000415.2446940f@jic23-huawei>
In-Reply-To: <20260529095649.2452-1-sozdayvek@gmail.com>
References: <20260529095649.2452-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 14:56:48 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> iadc_probe() calls enable_irq_wake() after a successful
> devm_request_irq(), but the driver has no remove callback or
> matching disable_irq_wake(), so the wake reference count on the
> IRQ is leaked on module unload or driver unbind.
> 
> Check the IRQ request error first, then register a devm action
> that calls disable_irq_wake() so the wake reference is released
> in the same scope as the enable. While here, drop the inverted
> "if (!ret) ... else return ret" in favour of the standard
> "if (ret) return ret;" pattern.
> 
> Fixes: ce0694841ea6 ("iio: iadc: Qualcomm SPMI PMIC current ADC driver")
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>

+CC Bjorn and Konrad as we don't seem to have a more specific
maintainer for this driver.

Seems low risk, but nice to run it past them.

Thanks,

Jonathan

> ---
> v3:
> - Add Fixes tag (Jonathan)
> 
> v2: https://lore.kernel.org/all/20260523134613.4930-1-sozdayvek@gmail.com/
> v1: https://lore.kernel.org/all/20260520190924.12774-1-sozdayvek@gmail.com/
> 
>  drivers/iio/adc/qcom-spmi-iadc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
> index b64a8a407168..88f6be2108e7 100644
> --- a/drivers/iio/adc/qcom-spmi-iadc.c
> +++ b/drivers/iio/adc/qcom-spmi-iadc.c
> @@ -481,6 +481,11 @@ static const struct iio_chan_spec iadc_channels[] = {
>  	},
>  };
>  
> +static void iadc_disable_irq_wake(void *data)
> +{
> +	disable_irq_wake((long)data);
> +}
> +
>  static int iadc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *node = pdev->dev.of_node;
> @@ -538,9 +543,16 @@ static int iadc_probe(struct platform_device *pdev)
>  	if (!iadc->poll_eoc) {
>  		ret = devm_request_irq(dev, irq_eoc, iadc_isr, 0,
>  					"spmi-iadc", iadc);
> -		if (!ret)
> -			enable_irq_wake(irq_eoc);
> -		else
> +		if (ret)
> +			return ret;
> +
> +		ret = enable_irq_wake(irq_eoc);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(dev, iadc_disable_irq_wake,
> +					       (void *)(long)irq_eoc);
> +		if (ret)
>  			return ret;
>  	} else {
>  		ret = devm_device_init_wakeup(iadc->dev);

