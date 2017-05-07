Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57651 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754566AbdEGW0B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:26:01 -0400
Subject: Re: [PATCH v3 3/9] iio: light: rpr0521 on-off sequence change for
 CONFIG_PM
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@intel.com>,
        linux-iio@vger.kernel.org
References: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1493983193-8753-3-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <84241150-8e3d-178f-8f3a-9c717e537409@kernel.org>
Date: Sun, 7 May 2017 12:48:38 +0100
MIME-Version: 1.0
In-Reply-To: <1493983193-8753-3-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 12:19, Mikko Koivunen wrote:
> Refactor _set_power_state(), _resume() and _suspend().
> Enable measurement only when needed, not in _init(). System can suspend
> during measurement and measurement is continued on resume.
> Pm turns off measurement when both ps and als measurements are disabled for
> 2 seconds. During off-time the power save is 20-500mA, typically 180mA.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
This looks good to me if a little convoluted.  I do wonder how many
people are actually building without CONFIG_PM any more... Maybe we
should just make that a dependency in new drivers where this sort
of thing is needed.  Obviously trickier in drivers once they are in
as there may be platforms relying on it working without PM support.

Anyhow, Ack from Daniel ideally!

Jonathan
> ---
> Don't enable measurement on _init() when using CONFIG_PM. Enable only
> when needed, otherwise it messes up the pm suspend-resume. Polling
> enables/disables the measurement anyway.
> 
> Save ALS/PS enabled status on _suspend() when called during measurement,
> so that measurement can be re-enabled on _resume().
> 
> checkpatch.pl OK
> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
> Builds ok with torvalds/linux feb 27.
> 
>  drivers/iio/light/rpr0521.c |   70 ++++++++++++++++++++++++++++---------------
>  1 file changed, 46 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 5d077f4..02ce635 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -9,7 +9,7 @@
>   *
>   * IIO driver for RPR-0521RS (7-bit I2C slave address 0x38).
>   *
> - * TODO: illuminance channel, PM support, buffer
> + * TODO: illuminance channel, buffer
>   */
>  
>  #include <linux/module.h>
> @@ -142,9 +142,11 @@ struct rpr0521_data {
>  	bool als_dev_en;
>  	bool pxs_dev_en;
>  
> -	/* optimize runtime pm ops - enable device only if needed */
> +	/* optimize runtime pm ops - enable/disable device only if needed */
>  	bool als_ps_need_en;
>  	bool pxs_ps_need_en;
> +	bool als_need_dis;
> +	bool pxs_need_dis;
>  
>  	struct regmap *regmap;
>  };
> @@ -230,40 +232,32 @@ static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status)
>   * @on: state to be set for devices in @device_mask
>   * @device_mask: bitmask specifying for which device we need to update @on state
>   *
> - * We rely on rpr0521_runtime_resume to enable our @device_mask devices, but
> - * if (for example) PXS was enabled (pxs_dev_en = true) by a previous call to
> - * rpr0521_runtime_resume and we want to enable ALS we MUST set ALS enable
> - * bit of RPR0521_REG_MODE_CTRL here because rpr0521_runtime_resume will not
> - * be called twice.
> + * Calls for this function must be balanced so that each ON should have matching
> + * OFF. Otherwise pm usage_count gets out of sync.
>   */
>  static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
>  				   u8 device_mask)
>  {
>  #ifdef CONFIG_PM
>  	int ret;
> -	u8 update_mask = 0;
>  
>  	if (device_mask & RPR0521_MODE_ALS_MASK) {
> -		if (on && !data->als_ps_need_en && data->pxs_dev_en)
> -			update_mask |= RPR0521_MODE_ALS_MASK;
> -		else
> -			data->als_ps_need_en = on;
> +		data->als_ps_need_en = on;
> +		data->als_need_dis = !on;
>  	}
>  
>  	if (device_mask & RPR0521_MODE_PXS_MASK) {
> -		if (on && !data->pxs_ps_need_en && data->als_dev_en)
> -			update_mask |= RPR0521_MODE_PXS_MASK;
> -		else
> -			data->pxs_ps_need_en = on;
> -	}
> -
> -	if (update_mask) {
> -		ret = regmap_update_bits(data->regmap, RPR0521_REG_MODE_CTRL,
> -					 update_mask, update_mask);
> -		if (ret < 0)
> -			return ret;
> +		data->pxs_ps_need_en = on;
> +		data->pxs_need_dis = !on;
>  	}
>  
> +	/*
> +	 * On: _resume() is called only when we are suspended
> +	 * Off: _suspend() is called after delay if _resume() is not
> +	 * called before that.
> +	 * Note: If either measurement is re-enabled before _suspend(),
> +	 * both stay enabled until _suspend().
> +	 */
>  	if (on) {
>  		ret = pm_runtime_get_sync(&data->client->dev);
>  	} else {
> @@ -279,6 +273,23 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
>  
>  		return ret;
>  	}
> +
> +	if (on) {
> +		/* If _resume() was not called, enable measurement now. */
> +		if (data->als_ps_need_en) {
> +			ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
> +			if (ret)
> +				return ret;
> +			data->als_ps_need_en = false;
> +		}
> +
> +		if (data->pxs_ps_need_en) {
> +			ret = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
> +			if (ret)
> +				return ret;
> +			data->pxs_ps_need_en = false;
> +		}
> +	}
>  #endif
>  	return 0;
>  }
> @@ -425,12 +436,14 @@ static int rpr0521_init(struct rpr0521_data *data)
>  		return ret;
>  	}
>  
> +#ifndef CONFIG_PM
>  	ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
>  	if (ret < 0)
>  		return ret;
>  	ret = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
>  	if (ret < 0)
>  		return ret;
> +#endif
>  
>  	return 0;
>  }
> @@ -560,9 +573,16 @@ static int rpr0521_runtime_suspend(struct device *dev)
>  	struct rpr0521_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	/* disable channels and sets {als,pxs}_dev_en to false */
>  	mutex_lock(&data->lock);
> +	/* If measurements are enabled, enable them on resume */
> +	if (!data->als_need_dis)
> +		data->als_ps_need_en = data->als_dev_en;
> +	if (!data->pxs_need_dis)
> +		data->pxs_ps_need_en = data->pxs_dev_en;
> +
> +	/* disable channels and sets {als,pxs}_dev_en to false */
>  	ret = rpr0521_poweroff(data);
> +	regcache_mark_dirty(data->regmap);
>  	mutex_unlock(&data->lock);
>  
>  	return ret;
> @@ -574,6 +594,7 @@ static int rpr0521_runtime_resume(struct device *dev)
>  	struct rpr0521_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> +	regcache_sync(data->regmap);
>  	if (data->als_ps_need_en) {
>  		ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
>  		if (ret < 0)
> @@ -587,6 +608,7 @@ static int rpr0521_runtime_resume(struct device *dev)
>  			return ret;
>  		data->pxs_ps_need_en = false;
>  	}
> +	msleep(100);	//wait for first measurement result
This one rather looks like a bug fix. Is it required even without the
pm changes? 
>  
>  	return 0;
>  }
> 

