Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82867242D62;
	Wed,  5 Aug 2026 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785891867; cv=none; b=LvkQ7sQoyHjyV4KhLlw8O7gAPu0pA82jhgWQ7anL5c12AuOXitGiWkeNR/F7quAE53yd39Njbd86Qlb0FWwnCaayaSQtC7nn8/n4RXubKTAh0ixtn03EL0nbTyEgjh1LyMaPnFq2tgHNzePdhFyT/XDdZhx/sMHO+EQDiG4vRPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785891867; c=relaxed/simple;
	bh=xjnI3i0dFlTx6jEJMks0HJKIJiphqXbOiNZ04LnV91U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYgd1tB13o2DXaPJopc2CcDuwSHbg3LvOqA34tlV6SSJgMKaKSWOaApBupwU8CCGxICZ1TNoJ6x+8ms6mh4/mwcVlxOqoNWnnbPoo3SQjavrwO+D7o4jq4oMggkM76gZnOUkVDcBPMOKNtuy5nfKJch9cWP+5dmcssNRzhbDO0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHafTZQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHafTZQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D8F1F000E9;
	Wed,  5 Aug 2026 01:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785891866;
	bh=2JJ/OYnhVOBZIKikRwKUt+wRaQnZOVg4lBXuhaSvKoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JHafTZQavESbS2/XBdfrpgromrnT1h5o53F8BQiNEDQ/AsN0czSakVtFwYgSHaNV7
	 t4xRBrLCPqC8RNz0svN8vo39+qBbkKwM/XD1KF21nIzK0pfBI8Ijy0MMJjO/lEEF0W
	 QItGuwpWNDQCZP49McuVqSHl/cTYiGFrcmGFwHlPX/3BZypMypXSA+T911esHeDrFz
	 oqiboMwew/6djnZ3H7ETJIYHu/bB/l/7oORFF7qwOzf0pMH7YRTUagAJeJsyiero5a
	 UjctBJnQWaTnC13+B2cgeP70+H5XrUjOpuKF+ZTdKbXZPNn80lxgxfQZhIsnXRIaMv
	 7KPCT1EO6/qmA==
Date: Wed, 5 Aug 2026 02:04:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: mdshahid03@gmail.com
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Ray
 Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Markus
 Elfring <Markus.Elfring@web.de>, Joshua Crofts <joshua.crofts1@gmail.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio: adc: bcm_iproc_adc: Introduce local device
 pointer
Message-ID: <20260805020420.783839fb@jic23-huawei>
In-Reply-To: <20260804170521.196393-3-mdshahid03@gmail.com>
References: <20260804170521.196393-1-mdshahid03@gmail.com>
	<20260804170521.196393-3-mdshahid03@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 22:35:20 +0530
mdshahid03@gmail.com wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Introduce a local 'struct device *dev' variable in iproc_adc_probe()
> and use it for device-managed helper calls instead of repeatedly
> referencing '&pdev->dev'.
> 
> No functional change intended.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/iio/adc/bcm_iproc_adc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 7c2e2770cd61..312be7c12e58 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -506,10 +506,10 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  {
>  	struct iproc_adc_priv *adc_priv;
>  	struct iio_dev *indio_dev = NULL;
> +	struct device *dev = &pdev->dev;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev,
> -					sizeof(*adc_priv));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_priv));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -528,10 +528,9 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	adc_priv->adc_clk = devm_clk_get(&pdev->dev, "tsc_clk");
> +	adc_priv->adc_clk = devm_clk_get(dev, "tsc_clk");
>  	if (IS_ERR(adc_priv->adc_clk)) {
> -		dev_err(&pdev->dev,
> -			"failed getting clock tsc_clk\n");
> +		dev_err(&pdev->dev, "failed getting clock tsc_clk\n");

Don't do the line rewrap here. It is adding noise we don't want
given you are about to replace this line in the next patch.

>  		ret = PTR_ERR(adc_priv->adc_clk);
>  		return ret;
>  	}
> @@ -547,7 +546,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = devm_request_threaded_irq(&pdev->dev, adc_priv->irqno,
> +	ret = devm_request_threaded_irq(dev, adc_priv->irqno,
>  				iproc_adc_interrupt_handler,
>  				iproc_adc_interrupt_thread,
>  				IRQF_SHARED, "iproc-adc", indio_dev);

