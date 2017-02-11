Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44905 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932070AbdBKJlF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 04:41:05 -0500
Subject: Re: [PATCH 2/7] staging: iio: isl29028: fix incorrect sleep time when
 taking initial proximity reading
To: Brian Masney <masneyb@onstation.org>
References: <20170209015431.17380-1-masneyb@onstation.org>
 <20170209015431.17380-3-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <394fe0c6-7b53-3fb9-2507-0d772ee708a5@kernel.org>
Date: Sat, 11 Feb 2017 09:40:50 +0000
MIME-Version: 1.0
In-Reply-To: <20170209015431.17380-3-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/17 01:54, Brian Masney wrote:
> When proximity is enabled in isl29028_enable_proximity(), the function
> msleep() is called with the sampling frequency, which is not correct.
> This patch changes the code to sleep the specified amount of time listed
> in the datasheet instead.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Seems sensible.  Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29028.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 8dc24c94..177dced 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -63,6 +63,9 @@
>  
>  #define ISL29028_POWER_OFF_DELAY_MS		2000
>  
> +static const unsigned int isl29028_prox_sleep_time[] = {800, 400, 200, 100, 75,
> +							50, 12, 0};
> +
>  enum isl29028_als_ir_mode {
>  	ISL29028_MODE_NONE = 0,
>  	ISL29028_MODE_ALS,
> @@ -78,22 +81,29 @@ struct isl29028_chip {
>  	enum isl29028_als_ir_mode	als_ir_mode;
>  };
>  
> -static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
> -					unsigned int sampling)
> +static int isl29028_find_prox_sleep_time_index(int sampling)
>  {
> -	struct device *dev = regmap_get_device(chip->regmap);
> -	static unsigned int prox_period[] = {800, 400, 200, 100, 75, 50, 12, 0};
>  	unsigned int period = DIV_ROUND_UP(1000, sampling);
> -	int sel, ret;
> +	int i;
>  
> -	for (sel = 0; sel < ARRAY_SIZE(prox_period); ++sel) {
> -		if (period >= prox_period[sel])
> +	for (i = 0; i < ARRAY_SIZE(isl29028_prox_sleep_time); ++i) {
> +		if (period >= isl29028_prox_sleep_time[i])
>  			break;
>  	}
>  
> +	return i;
> +}
> +
> +static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
> +					unsigned int sampling)
> +{
> +	struct device *dev = regmap_get_device(chip->regmap);
> +	int sleep_index, ret;
> +
> +	sleep_index = isl29028_find_prox_sleep_time_index(sampling);
>  	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
>  				 ISL29028_CONF_PROX_SLP_MASK,
> -				 sel << ISL29028_CONF_PROX_SLP_SH);
> +				 sleep_index << ISL29028_CONF_PROX_SLP_SH);
>  
>  	if (ret < 0) {
>  		dev_err(dev, "%s(): Error %d setting the proximity sampling\n",
> @@ -108,7 +118,7 @@ static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
>  
>  static int isl29028_enable_proximity(struct isl29028_chip *chip)
>  {
> -	int ret;
> +	int sleep_index, ret;
>  
>  	ret = isl29028_set_proxim_sampling(chip, chip->prox_sampling);
>  	if (ret < 0)
> @@ -121,7 +131,8 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip)
>  		return ret;
>  
>  	/* Wait for conversion to be complete for first sample */
> -	msleep(DIV_ROUND_UP(1000, chip->prox_sampling));
> +	sleep_index = isl29028_find_prox_sleep_time_index(chip->prox_sampling);
> +	msleep(isl29028_prox_sleep_time[sleep_index]);
>  
>  	return 0;
>  }
> 

