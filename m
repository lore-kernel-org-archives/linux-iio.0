Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45316 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbHBRUO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:20:14 -0400
Subject: Re: [PATCH 2/2] iio: magn: bmc150_magn: do not set power state twice
 when setting trigger state
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org
References: <1437671702-20994-1-git-send-email-irina.tirdea@intel.com>
 <1437671702-20994-3-git-send-email-irina.tirdea@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Vlad Dogaru <vlad.dogaru@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE514C.4070601@kernel.org>
Date: Sun, 2 Aug 2015 18:20:12 +0100
MIME-Version: 1.0
In-Reply-To: <1437671702-20994-3-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/07/15 18:15, Irina Tirdea wrote:
> When setting the trigger state, the device power state is set through
> buffer preenable and postdisable hooks. There is no need
> to also set it in the trigger set state call.
> 
> Remove duplicate set power state from the trigger set
> state call.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index d66f8cf..38c2eb64 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -783,29 +783,23 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	if (state == data->dready_trigger_on)
>  		goto err_unlock;
>  
> -	ret = bmc150_magn_set_power_state(data, state);
> -	if (ret < 0)
> -		goto err_unlock;
> -
>  	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
>  				 BMC150_MAGN_MASK_DRDY_EN,
>  				 state << BMC150_MAGN_SHIFT_DRDY_EN);
>  	if (ret < 0)
> -		goto err_poweroff;
> +		goto err_unlock;
>  
>  	data->dready_trigger_on = state;
>  
>  	if (state) {
>  		ret = bmc150_magn_reset_intr(data);
>  		if (ret < 0)
> -			goto err_poweroff;
> +			goto err_unlock;
>  	}
>  	mutex_unlock(&data->mutex);
>  
>  	return 0;
>  
> -err_poweroff:
> -	bmc150_magn_set_power_state(data, false);
>  err_unlock:
>  	mutex_unlock(&data->mutex);
>  	return ret;
> 

