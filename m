Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbeKDDby (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Nov 2018 23:31:54 -0400
Date: Sat, 3 Nov 2018 18:19:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        Jack Andersen <jackoalan@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH][RFC] iio: Move attach/detach of the poll func to the
 core
Message-ID: <20181103181948.0da58f81@archlinux>
In-Reply-To: <20180622135322.3459-1-alexandru.ardelean@analog.com>
References: <20180622135322.3459-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 22 Jun 2018 16:53:22 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> All devices using a triggered buffer need to attach and detach the trigger
> to the device in order to properly work. Instead of doing this in each and
> every driver by hand move this into the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

> ---
> 
> Note: `Signed-off-by` is also Lars-Peter Clausen because he is the
> original author of this patch [on an older kernel].
> The patch has been updated since the original patch from Lars.
> 
> There has been a (small) discussion about whether such a patch makes
> sense to implement (for reducing code duplication), or whether it's too
> risky to do it.
> 
> The reason for the risky-ness is that there is no consistent way in which
> drivers attach/detach the poll function.
> i.e.
>    1. some drivers call `iio_triggered_buffer_postenable()` before doing HW
>       stuff, some after (for attaching the poll func)
>    2. similarly, for `iio_triggered_buffer_predisable()` some drivers do it
>       before HW stuff, some after (for detaching the poll func)
> 
> Common sense would dictate that (in the case of
> `iio_triggered_buffer_postenable()`) there would normally be HW setup first
> and then attach the poll func.
> And the reverse done for `iio_triggered_buffer_predisable()`.
I'm sure I once had the flow around this all well laid out, but I really
can't recall what it was and it was all tied around trying to do the
buffer enable as lockless as possible. Years ago Lars pointed out that
was impossible so a lot of the logic has been messed up since then.

Anyhow, I've put this off long enough (sorry about that - just new it
was going to involve some head scratching!)  Crucially I have another
plan.  Figure out which drivers this actually makes a difference to
and thankfully in most cases the author is still active :)


> 
> However, it's unclear whether this reasoning is completely sound for all
> drivers.
> 
> Hence this RFC.

I've culled the cases that are obvious.  Either just the defaults or
where we do the calls at the end of enable and start of disable.

In those there is no ordering change.

There are some odd ones
gp2ap020a00f does it under a lock. Which makes no difference.
isl29125 totally missbalanced so the preenable does things undone in the
   predisable.  I wonder if anyone has one to allow us to test cleaning
   that up. No flow change due to this patch though so fine.
tcs3414 is much the same as the isl29125.
lmp91000?? Is about all I can say on that.  It detaches a poll function that
was never attached.

Anyhow, so what's left (hopefully we haven't had any crazies since
you posted this patch. I'll check at somepoint)

>  drivers/iio/adc/ad_sigma_delta.c              |  5 ----
I'll assume you are fine with that one ;)

>  drivers/iio/adc/dln2-adc.c                    |  4 +--
+ CC Jack Anderson (worst comes to the worst I have one of these and can
     run basic tests).

>  drivers/iio/adc/stm32-adc.c                   | 11 --------
+ CC Fabrice

>  drivers/iio/adc/vf610_adc.c                   |  6 +----
+ CC Sanchayan who might still have access to one of these
+ Bhuvanchanda who fixed a bug not so long ago...

>  drivers/iio/chemical/atlas-ph-sensor.c        |  8 ------
+ CC Matt who is definitely still contactable as I met him last week ;)

>  drivers/iio/potentiostat/lmp91000.c           |  1 -
Another of Matt's.  On this one, I'm not sure who it attaches
the pollfunc in the first place.  I may be going crazy however, so
over to Matt to point out what I'm missing.

So the actual change that matters is:

> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index cd5bfe39591b..d8eb534a9544 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -24,6 +24,7 @@
>  
>  #include <linux/iio/iio.h>
>  #include "iio_core.h"
> +#include "iio_core_trigger.h"
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/buffer_impl.h>
> @@ -961,6 +962,13 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
>  		}
>  	}
>  
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +		ret = iio_trigger_attach_poll_func(indio_dev->trig,
> +						   indio_dev->pollfunc);
> +		if (ret)
> +			goto err_disable_buffers;
> +	}
> +
This is immediately after the postenable call.

>  	return 0;
>  
>  err_disable_buffers:
> @@ -987,6 +995,11 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
>  	if (list_empty(&indio_dev->buffer_list))
>  		return 0;
>  

This is immediately before the predisable call.

> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +		iio_trigger_detach_poll_func(indio_dev->trig,
> +					     indio_dev->pollfunc);
> +	}
> +
>  	/*
>  	 * If things go wrong at some step in disable we still need to continue
>  	 * to perform the other steps, otherwise we leave the device in a
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index ce66699c7fcc..a4dacb638a72 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -242,8 +242,8 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
>   * the relevant function is in there may be the best option.
>   */
>  /* Worth protecting against double additions? */
> -static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> -					struct iio_poll_func *pf)
> +int iio_trigger_attach_poll_func(struct iio_trigger *trig,
> +				 struct iio_poll_func *pf)
>  {
>  	int ret = 0;
>  	bool notinuse
> @@ -290,8 +290,8 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  	return ret;
>  }
>  
> -static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> -					 struct iio_poll_func *pf)
> +int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> +				 struct iio_poll_func *pf)
>  {
>  	int ret = 0;
>  	bool no_other_users
> @@ -758,17 +758,3 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
>  	if (indio_dev->trig)
>  		iio_trigger_put(indio_dev->trig);
>  }
> -
> -int iio_triggered_buffer_postenable(struct iio_dev *indio_dev)
> -{
> -	return iio_trigger_attach_poll_func(indio_dev->trig,
> -					    indio_dev->pollfunc);
> -}
> -EXPORT_SYMBOL(iio_triggered_buffer_postenable);
> -
> -int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
> -{
> -	return iio_trigger_detach_poll_func(indio_dev->trig,
> -					     indio_dev->pollfunc);
> -}
> -EXPORT_SYMBOL(iio_triggered_buffer_predisable);




> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index cf1b048b0665..ef046277bf7b 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -338,10 +338,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  	unsigned int channel;
>  	int ret;
>  
> -	ret = iio_triggered_buffer_postenable(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
Here is one where the ordering actually changes. I'm going to hope you concluded
this one was fine ;)

>  	channel = find_first_bit(indio_dev->active_scan_mask,
>  				 indio_dev->masklength);
>  	ret = ad_sigma_delta_set_channel(sigma_delta,
> @@ -426,7 +422,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  
>  static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
>  	.postenable = &ad_sd_buffer_postenable,
> -	.predisable = &iio_triggered_buffer_predisable,
>  	.postdisable = &ad_sd_buffer_postdisable,
>  	.validate_scan_mask = &iio_validate_scan_mask_onehot,
>  };
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index c64c6675cae6..51135e7c0d4f 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -560,7 +560,7 @@ static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
>  		mutex_unlock(&dln2->mutex);
>  	}
>  
> -	return iio_triggered_buffer_postenable(indio_dev);
> +	return 0;
>  }
>  
>  static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
> @@ -585,7 +585,7 @@ static int dln2_adc_triggered_buffer_predisable(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> -	return iio_triggered_buffer_predisable(indio_dev);

An unbalanced one.  Postenable is fine but presdisable.  Who knows..

> +	return 0;
>  }
>  
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 378411853d75..ce0d17c03d7e 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1482,10 +1482,6 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  		goto err_clr_trig;
>  	}
>  
> -	ret = iio_triggered_buffer_postenable(indio_dev);
> -	if (ret < 0)
> -		goto err_stop_dma;
> -
>  	/* Reset adc buffer index */
>  	adc->bufi = 0;
>  
> @@ -1496,9 +1492,6 @@ static int stm32_adc_buffer_postenable(struct iio_dev *indio_dev)
>  
>  	return 0;
>  
> -err_stop_dma:
> -	if (adc->dma_chan)
> -		dmaengine_terminate_all(adc->dma_chan);
>  err_clr_trig:
>  	stm32_adc_set_trig(indio_dev, NULL);
>  err_unprepare:
> @@ -1517,10 +1510,6 @@ static int stm32_adc_buffer_predisable(struct iio_dev *indio_dev)
>  	if (!adc->dma_chan)
>  		stm32_adc_conv_irq_disable(adc);
>  
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret < 0)
> -		dev_err(&indio_dev->dev, "predisable failed\n");
> -
>  	if (adc->dma_chan)
>  		dmaengine_terminate_all(adc->dma_chan);
>  

> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index bbcb7a4d7edf..3a15b98cfd39 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -740,10 +740,6 @@ static int vf610_adc_buffer_postenable(struct iio_dev *indio_dev)
>  	int ret;
>  	int val;
>  
> -	ret = iio_triggered_buffer_postenable(indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	val = readl(info->regs + VF610_REG_ADC_GC);
>  	val |= VF610_ADC_ADCON;
>  	writel(val, info->regs + VF610_REG_ADC_GC);
> @@ -774,7 +770,7 @@ static int vf610_adc_buffer_predisable(struct iio_dev *indio_dev)
>  
>  	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
>  
> -	return iio_triggered_buffer_predisable(indio_dev);
> +	return 0;
>  }
>  
>  static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {


> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index a406ad31b096..8fed75f9e95d 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -305,10 +305,6 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
>  	struct atlas_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = iio_triggered_buffer_postenable(indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	ret = pm_runtime_get_sync(&data->client->dev);
>  	if (ret < 0) {
>  		pm_runtime_put_noidle(&data->client->dev);
> @@ -323,10 +319,6 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
>  	struct atlas_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	ret = atlas_set_interrupt(data, false);
>  	if (ret)
>  		return ret;

> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 85714055cc74..84f9105cbb37 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -295,7 +295,6 @@ static int lmp91000_buffer_predisable(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops lmp91000_buffer_setup_ops = {
>  	.preenable = lmp91000_buffer_preenable,
> -	.postenable = iio_triggered_buffer_postenable,
A resounding ??? 
>  	.predisable = lmp91000_buffer_predisable,
>  };
>  
