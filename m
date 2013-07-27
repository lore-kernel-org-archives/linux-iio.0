Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53425 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab3G0K3m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:29:42 -0400
Message-ID: <51F3AF28.6080706@kernel.org>
Date: Sat, 27 Jul 2013 12:29:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk, patches@linaro.org,
	Stefan Roese <sr@denx.de>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/8] staging: iio: spear_adc: Use devm_iio_device_alloc
References: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org> <1374490981-24373-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374490981-24373-7-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/22/13 12:02, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
Applied to the togreg branch of iio.git.

Thanks
> ---
>  drivers/staging/iio/adc/spear_adc.c |   30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
> index 736219c..20f2d55 100644
> --- a/drivers/staging/iio/adc/spear_adc.c
> +++ b/drivers/staging/iio/adc/spear_adc.c
> @@ -300,11 +300,10 @@ static int spear_adc_probe(struct platform_device *pdev)
>  	int ret = -ENODEV;
>  	int irq;
>  
> -	iodev = iio_device_alloc(sizeof(struct spear_adc_info));
> +	iodev = devm_iio_device_alloc(dev, sizeof(struct spear_adc_info));
>  	if (!iodev) {
>  		dev_err(dev, "failed allocating iio device\n");
> -		ret = -ENOMEM;
> -		goto errout1;
> +		return -ENOMEM;
>  	}
>  
>  	info = iio_priv(iodev);
> @@ -318,8 +317,7 @@ static int spear_adc_probe(struct platform_device *pdev)
>  	info->adc_base_spear6xx = of_iomap(np, 0);
>  	if (!info->adc_base_spear6xx) {
>  		dev_err(dev, "failed mapping memory\n");
> -		ret = -ENOMEM;
> -		goto errout2;
> +		return -ENOMEM;
>  	}
>  	info->adc_base_spear3xx =
>  		(struct adc_regs_spear3xx *)info->adc_base_spear6xx;
> @@ -327,33 +325,33 @@ static int spear_adc_probe(struct platform_device *pdev)
>  	info->clk = clk_get(dev, NULL);
>  	if (IS_ERR(info->clk)) {
>  		dev_err(dev, "failed getting clock\n");
> -		goto errout3;
> +		goto errout1;
>  	}
>  
>  	ret = clk_prepare_enable(info->clk);
>  	if (ret) {
>  		dev_err(dev, "failed enabling clock\n");
> -		goto errout4;
> +		goto errout2;
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if ((irq < 0) || (irq >= NR_IRQS)) {
>  		dev_err(dev, "failed getting interrupt resource\n");
>  		ret = -EINVAL;
> -		goto errout5;
> +		goto errout3;
>  	}
>  
>  	ret = devm_request_irq(dev, irq, spear_adc_isr, 0, MOD_NAME, info);
>  	if (ret < 0) {
>  		dev_err(dev, "failed requesting interrupt\n");
> -		goto errout5;
> +		goto errout3;
>  	}
>  
>  	if (of_property_read_u32(np, "sampling-frequency",
>  				 &info->sampling_freq)) {
>  		dev_err(dev, "sampling-frequency missing in DT\n");
>  		ret = -EINVAL;
> -		goto errout5;
> +		goto errout3;
>  	}
>  
>  	/*
> @@ -383,21 +381,18 @@ static int spear_adc_probe(struct platform_device *pdev)
>  
>  	ret = iio_device_register(iodev);
>  	if (ret)
> -		goto errout5;
> +		goto errout3;
>  
>  	dev_info(dev, "SPEAR ADC driver loaded, IRQ %d\n", irq);
>  
>  	return 0;
>  
> -errout5:
> -	clk_disable_unprepare(info->clk);
> -errout4:
> -	clk_put(info->clk);
>  errout3:
> -	iounmap(info->adc_base_spear6xx);
> +	clk_disable_unprepare(info->clk);
>  errout2:
> -	iio_device_free(iodev);
> +	clk_put(info->clk);
>  errout1:
> +	iounmap(info->adc_base_spear6xx);
>  	return ret;
>  }
>  
> @@ -410,7 +405,6 @@ static int spear_adc_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(info->clk);
>  	clk_put(info->clk);
>  	iounmap(info->adc_base_spear6xx);
> -	iio_device_free(iodev);
>  
>  	return 0;
>  }
> 
