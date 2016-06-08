Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38528 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932800AbcFHPdp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2016 11:33:45 -0400
Received: by mail-wm0-f48.google.com with SMTP id m124so22552487wme.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Jun 2016 08:33:45 -0700 (PDT)
Date: Wed, 8 Jun 2016 16:34:14 +0100
From: Lee Jones <lee.jones@linaro.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dave Gerlach <d-gerlach@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] mfd: ti_am335x_tscadc: Unify variable naming when
 refrencing ti_tscadc_dev
Message-ID: <20160608153414.GS14888@dell>
References: <20160531170013.2649-1-afd@ti.com>
 <20160531170013.2649-5-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160531170013.2649-5-afd@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> All functions in this driver reference the same ti_tscadc_dev per device
> but use several different names for this structure pointer, this can
> be confusing when following the code. Use the name 'tscadc' everywhere.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 88 +++++++++++++++++++++---------------------
>  1 file changed, 44 insertions(+), 44 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 613f15d..9b293b1 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -34,89 +34,89 @@ static const struct regmap_config tscadc_regmap_config = {
>  	.val_bits = 32,
>  };
>  
> -void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tsadc, u32 val)
> +void am335x_tsc_se_set_cache(struct ti_tscadc_dev *tscadc, u32 val)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->reg_se_cache |= val;
> -	if (tsadc->adc_waiting)
> -		wake_up(&tsadc->reg_se_wait);
> -	else if (!tsadc->adc_in_use)
> -		regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
> +	spin_lock_irqsave(&tscadc->reg_lock, flags);
> +	tscadc->reg_se_cache |= val;
> +	if (tscadc->adc_waiting)
> +		wake_up(&tscadc->reg_se_wait);
> +	else if (!tscadc->adc_in_use)
> +		regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
>  
> -	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
> +	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_set_cache);
>  
> -static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tsadc)
> +static void am335x_tscadc_need_adc(struct ti_tscadc_dev *tscadc)
>  {
>  	DEFINE_WAIT(wait);
>  	u32 reg;
>  
> -	regmap_read(tsadc->regmap_tscadc, REG_ADCFSM, &reg);
> +	regmap_read(tscadc->regmap_tscadc, REG_ADCFSM, &reg);
>  	if (reg & SEQ_STATUS) {
> -		tsadc->adc_waiting = true;
> -		prepare_to_wait(&tsadc->reg_se_wait, &wait,
> +		tscadc->adc_waiting = true;
> +		prepare_to_wait(&tscadc->reg_se_wait, &wait,
>  				TASK_UNINTERRUPTIBLE);
> -		spin_unlock_irq(&tsadc->reg_lock);
> +		spin_unlock_irq(&tscadc->reg_lock);
>  
>  		schedule();
>  
> -		spin_lock_irq(&tsadc->reg_lock);
> -		finish_wait(&tsadc->reg_se_wait, &wait);
> +		spin_lock_irq(&tscadc->reg_lock);
> +		finish_wait(&tscadc->reg_se_wait, &wait);
>  
>  		/*
>  		 * Sequencer should either be idle or
>  		 * busy applying the charge step.
>  		 */
> -		regmap_read(tsadc->regmap_tscadc, REG_ADCFSM, &reg);
> +		regmap_read(tscadc->regmap_tscadc, REG_ADCFSM, &reg);
>  		WARN_ON((reg & SEQ_STATUS) && !(reg & CHARGE_STEP));
> -		tsadc->adc_waiting = false;
> +		tscadc->adc_waiting = false;
>  	}
> -	tsadc->adc_in_use = true;
> +	tscadc->adc_in_use = true;
>  }
>  
> -void am335x_tsc_se_set_once(struct ti_tscadc_dev *tsadc, u32 val)
> +void am335x_tsc_se_set_once(struct ti_tscadc_dev *tscadc, u32 val)
>  {
> -	spin_lock_irq(&tsadc->reg_lock);
> -	am335x_tscadc_need_adc(tsadc);
> +	spin_lock_irq(&tscadc->reg_lock);
> +	am335x_tscadc_need_adc(tscadc);
>  
> -	regmap_write(tsadc->regmap_tscadc, REG_SE, val);
> -	spin_unlock_irq(&tsadc->reg_lock);
> +	regmap_write(tscadc->regmap_tscadc, REG_SE, val);
> +	spin_unlock_irq(&tscadc->reg_lock);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_set_once);
>  
> -void am335x_tsc_se_adc_done(struct ti_tscadc_dev *tsadc)
> +void am335x_tsc_se_adc_done(struct ti_tscadc_dev *tscadc)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->adc_in_use = false;
> -	regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
> -	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
> +	spin_lock_irqsave(&tscadc->reg_lock, flags);
> +	tscadc->adc_in_use = false;
> +	regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
> +	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_adc_done);
>  
> -void am335x_tsc_se_clr(struct ti_tscadc_dev *tsadc, u32 val)
> +void am335x_tsc_se_clr(struct ti_tscadc_dev *tscadc, u32 val)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&tsadc->reg_lock, flags);
> -	tsadc->reg_se_cache &= ~val;
> -	regmap_write(tsadc->regmap_tscadc, REG_SE, tsadc->reg_se_cache);
> -	spin_unlock_irqrestore(&tsadc->reg_lock, flags);
> +	spin_lock_irqsave(&tscadc->reg_lock, flags);
> +	tscadc->reg_se_cache &= ~val;
> +	regmap_write(tscadc->regmap_tscadc, REG_SE, tscadc->reg_se_cache);
> +	spin_unlock_irqrestore(&tscadc->reg_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(am335x_tsc_se_clr);
>  
> -static void tscadc_idle_config(struct ti_tscadc_dev *config)
> +static void tscadc_idle_config(struct ti_tscadc_dev *tscadc)
>  {
>  	unsigned int idleconfig;
>  
>  	idleconfig = STEPCONFIG_YNN | STEPCONFIG_INM_ADCREFM |
>  			STEPCONFIG_INP_ADCREFM | STEPCONFIG_YPN;
>  
> -	regmap_write(config->regmap_tscadc, REG_IDLECONFIG, idleconfig);
> +	regmap_write(tscadc->regmap_tscadc, REG_IDLECONFIG, idleconfig);
>  }
>  
>  static	int ti_tscadc_probe(struct platform_device *pdev)
> @@ -298,9 +298,9 @@ static int ti_tscadc_remove(struct platform_device *pdev)
>  
>  static int __maybe_unused tscadc_suspend(struct device *dev)
>  {
> -	struct ti_tscadc_dev	*tscadc_dev = dev_get_drvdata(dev);
> +	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
>  
> -	regmap_write(tscadc_dev->regmap_tscadc, REG_SE, 0x00);
> +	regmap_write(tscadc->regmap_tscadc, REG_SE, 0x00);
>  	pm_runtime_put_sync(dev);
>  
>  	return 0;
> @@ -308,26 +308,26 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
>  
>  static int __maybe_unused tscadc_resume(struct device *dev)
>  {
> -	struct ti_tscadc_dev	*tscadc_dev = dev_get_drvdata(dev);
> +	struct ti_tscadc_dev	*tscadc = dev_get_drvdata(dev);
>  	u32 ctrl;
>  
>  	pm_runtime_get_sync(dev);
>  
>  	/* context restore */
>  	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> -	regmap_write(tscadc_dev->regmap_tscadc, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
>  
> -	if (tscadc_dev->tsc_cell != -1) {
> -		if (tscadc_dev->tsc_wires == 5)
> +	if (tscadc->tsc_cell != -1) {
> +		if (tscadc->tsc_wires == 5)
>  			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
>  		else
>  			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
> -		tscadc_idle_config(tscadc_dev);
> +		tscadc_idle_config(tscadc);
>  	}
>  	ctrl |= CNTRLREG_TSCSSENB;
> -	regmap_write(tscadc_dev->regmap_tscadc, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap_tscadc, REG_CTRL, ctrl);
>  
> -	regmap_write(tscadc_dev->regmap_tscadc, REG_CLKDIV, tscadc_dev->clk_div);
> +	regmap_write(tscadc->regmap_tscadc, REG_CLKDIV, tscadc->clk_div);
>  
>  	return 0;
>  }

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
