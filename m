Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35357 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbdAUOtj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:49:39 -0500
Subject: Re: [PATCH v2 13/15] staging: iio: isl29028: only set proximity
 sampling rate when proximity is enabled
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-14-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <3208f92f-b350-b0ec-74bc-7edbeca36a0e@kernel.org>
Date: Sat, 21 Jan 2017 14:49:36 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-14-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:25, Brian Masney wrote:
> isl29028_chip_init_and_power_on() calls isl29028_set_proxim_sampling()
> and this is not needed until the user actually needs to take a proximity
> reading. This patch moves the isl29028_set_proxim_sampling() call from
> isl29028_chip_init_and_power_on() to isl29028_enable_proximity().
> This sets the stage for faster resume times from the runtime power
> management if the user is only querying the ALS/IR sensor.
> 
Logical.  Applied.
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/isl29028.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index f1b3651..fa58d08 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -107,6 +107,10 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip)
>  {
>  	int ret;
>  
> +	ret = isl29028_set_proxim_sampling(chip, chip->prox_sampling);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
>  				 ISL29028_CONF_PROX_EN_MASK,
>  				 ISL29028_CONF_PROX_EN);
> @@ -449,10 +453,6 @@ static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
>  		return ret;
>  	}
>  
> -	ret = isl29028_set_proxim_sampling(chip, chip->prox_sampling);
> -	if (ret < 0)
> -		return ret;
> -
>  	return isl29028_set_als_scale(chip, chip->lux_scale);
>  }
>  
> 

