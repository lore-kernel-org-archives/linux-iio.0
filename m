Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:41104 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756302AbaDKKFf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Apr 2014 06:05:35 -0400
Message-id: <5347BE67.1080209@samsung.com>
Date: Fri, 11 Apr 2014 12:05:27 +0200
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
MIME-version: 1.0
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: jic23@kernel.org, ch.naveen@samsung.com, kgene.kim@samsung.com,
	linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Kyungmin Park <kyungmin.park@samsung.com>,
	devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: exynos_adc: Control special clock of ADC to
 support Exynos3250 ADC
References: <1397181640-18513-1-git-send-email-cw00.choi@samsung.com>
In-reply-to: <1397181640-18513-1-git-send-email-cw00.choi@samsung.com>
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Chanwoo,

On 11/04/14 04:00, Chanwoo Choi wrote:
> This patch control special clock for ADC in Exynos series's FSYS block.
> If special clock of ADC is registerd on clock list of common clk framework,
> Exynos ADC drvier have to control this clock.
> 
> Exynos3250/Exynos4/Exynos5 has 'adc' clock as following:
> - 'adc' clock: bus clock for ADC
> 
> Exynos3250 has additional 'sclk_tsadc' clock as following:
> - 'sclk_tsadc' clock: special clock for ADC which provide clock to internal ADC
> 
> Exynos 4210/4212/4412 and Exynos5250/5420 has not included 'sclk_tsadc' clock
> in FSYS_BLK. But, Exynos3250 based on Cortex-A7 has only included 'sclk_tsadc'
> clock in FSYS_BLK.

I think a new compatible should be added for the ADC device for Exynos3250
and the required clocks should be handled properly, based on compatible
value. This could be handled, e.g. through some flags in driver's data
selected based on the compatible property value.

And the new clocks should be documented in Documentation/devicetree/bindings
/arm/samsung/exynos-adc.txt.

> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/iio/adc/exynos_adc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index d25b262..4cd1975 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -88,6 +88,7 @@ struct exynos_adc {
>  	void __iomem		*regs;
>  	void __iomem		*enable_reg;
>  	struct clk		*clk;
> +	struct clk		*sclk;
>  	unsigned int		irq;
>  	struct regulator	*vdd;
>  
> @@ -308,6 +309,13 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  		goto err_irq;
>  	}
>  
> +	info->sclk = devm_clk_get(&pdev->dev, "sclk_tsadc");
> +	if (IS_ERR(info->sclk)) {
> +		dev_warn(&pdev->dev, "failed getting sclk clock, err = %ld\n",
> +							PTR_ERR(info->sclk));
> +		info->sclk = NULL;
> +	}
> +
>  	info->vdd = devm_regulator_get(&pdev->dev, "vdd");
>  	if (IS_ERR(info->vdd)) {
>  		dev_err(&pdev->dev, "failed getting regulator, err = %ld\n",
> @@ -341,6 +349,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  		goto err_iio_dev;
>  
>  	clk_prepare_enable(info->clk);
> +	clk_prepare_enable(info->sclk);
>  
>  	exynos_adc_hw_init(info);
>  
> @@ -357,6 +366,7 @@ err_of_populate:
>  				exynos_adc_remove_devices);
>  	regulator_disable(info->vdd);
>  	clk_disable_unprepare(info->clk);
> +	clk_disable_unprepare(info->sclk);
>  err_iio_dev:
>  	iio_device_unregister(indio_dev);
>  err_irq:
> @@ -373,6 +383,7 @@ static int exynos_adc_remove(struct platform_device *pdev)
>  				exynos_adc_remove_devices);
>  	regulator_disable(info->vdd);
>  	clk_disable_unprepare(info->clk);
> +	clk_disable_unprepare(info->sclk);
>  	writel(0, info->enable_reg);
>  	iio_device_unregister(indio_dev);
>  	free_irq(info->irq, info);
> @@ -398,6 +409,7 @@ static int exynos_adc_suspend(struct device *dev)
>  	}
>  
>  	clk_disable_unprepare(info->clk);
> +	clk_disable_unprepare(info->sclk);
>  	writel(0, info->enable_reg);
>  	regulator_disable(info->vdd);
>  
> @@ -416,6 +428,7 @@ static int exynos_adc_resume(struct device *dev)
>  
>  	writel(1, info->enable_reg);
>  	clk_prepare_enable(info->clk);
> +	clk_prepare_enable(info->sclk);
>  
>  	exynos_adc_hw_init(info);
>  
> 

Regards,
Sylwester
