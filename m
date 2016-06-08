Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36101 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161796AbcFHPf3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2016 11:35:29 -0400
Received: by mail-wm0-f46.google.com with SMTP id n184so187419965wmn.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jun 2016 08:35:29 -0700 (PDT)
Date: Wed, 8 Jun 2016 16:35:59 +0100
From: Lee Jones <lee.jones@linaro.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mfd: ti_am335x_tscadc: Use SIMPLE_DEV_PM_OPS helper
 macro
Message-ID: <20160608153559.GV14888@dell>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160531170013.2649-2-afd@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> Replace ifdefs with SIMPLE_DEV_PM_OPS helper macro.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index e4e4b22..644128b 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -310,8 +310,7 @@ static int ti_tscadc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
> -static int tscadc_suspend(struct device *dev)
> +static int __maybe_unused tscadc_suspend(struct device *dev)
>  {
>  	struct ti_tscadc_dev	*tscadc_dev = dev_get_drvdata(dev);
>  
> @@ -321,7 +320,7 @@ static int tscadc_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int tscadc_resume(struct device *dev)
> +static int __maybe_unused tscadc_resume(struct device *dev)
>  {
>  	struct ti_tscadc_dev	*tscadc_dev = dev_get_drvdata(dev);
>  	u32 ctrl;
> @@ -347,14 +346,7 @@ static int tscadc_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static const struct dev_pm_ops tscadc_pm_ops = {
> -	.suspend = tscadc_suspend,
> -	.resume = tscadc_resume,
> -};
> -#define TSCADC_PM_OPS (&tscadc_pm_ops)
> -#else
> -#define TSCADC_PM_OPS NULL
> -#endif
> +static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
>  
>  static const struct of_device_id ti_tscadc_dt_ids[] = {
>  	{ .compatible = "ti,am3359-tscadc", },
> @@ -365,7 +357,7 @@ MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
>  static struct platform_driver ti_tscadc_driver = {
>  	.driver = {
>  		.name   = "ti_am3359-tscadc",
> -		.pm	= TSCADC_PM_OPS,
> +		.pm	= &tscadc_pm_ops,
>  		.of_match_table = ti_tscadc_dt_ids,
>  	},
>  	.probe	= ti_tscadc_probe,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
