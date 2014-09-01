Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:56542 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbaIAHf1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Sep 2014 03:35:27 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so4897856qgf.14
        for <linux-iio@vger.kernel.org>; Mon, 01 Sep 2014 00:35:26 -0700 (PDT)
Date: Mon, 1 Sep 2014 08:35:20 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vignesh R <vigneshr@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	nsekhar@ti.com
Subject: Re: [PATCH v2] mfd: ti_am335x_tscadc: Fix TSC operation after ADC
 continouous mode
Message-ID: <20140901073520.GA6226@lee--X1>
References: <1409553066-25000-1-git-send-email-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1409553066-25000-1-git-send-email-vigneshr@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 01 Sep 2014, Vignesh R wrote:

> After enabling and disabling ADC continuous mode via sysfs, ts_print_raw
> fails to return any data. This is because when ADC is configured for
> continuous mode, it disables touch screen steps.These steps are not
> re-enabled when ADC continuous mode is disabled. Therefore existing values
> of REG_SE needs to be cached before enabling continuous mode and
> disabling touch screen steps and enabling ADC steps. The cached value
> are to be restored to REG_SE once ADC is disabled.
> 
> Fixes: 7ca6740cd1cd ("mfd: input: iio: ti_amm335x: Rework TSC/ADC synchronization")
> 
> Cc: stable@vger.kernel.org # v3.13+
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> fixed $SUBJECT, added stable and ack from Lee Jones.
> No code change.
> 
>  drivers/mfd/ti_am335x_tscadc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.

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
