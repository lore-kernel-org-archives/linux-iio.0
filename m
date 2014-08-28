Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:51405 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbaH1PsD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Aug 2014 11:48:03 -0400
Received: by mail-qc0-f169.google.com with SMTP id l6so1005746qcy.28
        for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2014 08:48:02 -0700 (PDT)
Date: Thu, 28 Aug 2014 16:47:56 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vignesh R <vigneshr@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jonathan Cameron <jic23@kernel.org>, nsekhar@ti.com,
	Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti_am335x_adc: Fix TSC operation after ADC
 continouous mode
Message-ID: <20140828154756.GX24579@lee--X1>
References: <1409216820-11506-1-git-send-email-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1409216820-11506-1-git-send-email-vigneshr@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 28 Aug 2014, Vignesh R wrote:

> After enabling and disabling ADC continuous mode via sysfs, ts_print_raw
> fails to return any data. This is because when ADC is configured for
> continuous mode, it disables touch screen steps.These steps are not
> re-enabled when ADC continuous mode is disabled. Therefore existing values
> of REG_SE needs to be cached before enabling continuous mode and
> disabling touch screen steps and enabling ADC steps. The cached value
> are to be restored to REG_SE once ADC is disabled.
> 
> Fixes: 7ca6740cd1cd ("The continues-read mode remains unchanged")
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Please re-submit after doing 3 things:
 - Change the $SUBJECT line (this is not an IIO patch)
 - Add Cc: stable@vger.kernel.org
 - Apply my: Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index d4e860413bb5..e3076afe6b3c 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -54,7 +54,7 @@ void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tsadc, u32 val)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->reg_se_cache = val;
> +	tsadc->reg_se_cache |= val;
>  	if (tsadc->adc_waiting)
>  		wake_up(&tsadc->reg_se_wait);
>  	else if (!tsadc->adc_in_use)
> @@ -97,6 +97,7 @@ static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tsadc)
>  void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
>  {
>  	spin_lock_irq(&tsadc->reg_lock);
> +	tsadc->reg_se_cache |= val;
>  	am335x_tscadc_need_adc(tsadc);
>  
>  	tscadc_writel(tsadc, REG_SE, val);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
