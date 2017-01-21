Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35378 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAUOwJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:52:09 -0500
Subject: Re: [PATCH v2 14/15] staging: iio: isl29028: only set ALS scale when
 ALS/IR sensing is enabled
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-15-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <eb6c73bf-1c91-33c3-06c0-a6d013278ef9@kernel.org>
Date: Sat, 21 Jan 2017 14:52:07 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-15-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:25, Brian Masney wrote:
> isl29028_chip_init_and_power_on() calls isl29028_set_als_scale() and
> this is not needed until the user actually needs to take a reading from
> the ALS/IR sensor. This patch moves the isl29028_set_als_scale() call
> from isl29028_chip_init_and_power_on() to isl29028_set_als_ir_mode().
> This sets the stage for faster resume times from runtime power
> management if the user is only querying the proximity sensor.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Makes sense.
> ---
>  drivers/staging/iio/light/isl29028.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index fa58d08..598a5a5 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -146,11 +146,15 @@ static int isl29028_set_als_scale(struct isl29028_chip *chip, int lux_scale)
>  static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
>  				    enum isl29028_als_ir_mode mode)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	if (chip->als_ir_mode == mode)
>  		return 0;
>  
> +	ret = isl29028_set_als_scale(chip, chip->lux_scale);
> +	if (ret < 0)
> +		return ret;
> +
>  	switch (mode) {
>  	case ISL29028_MODE_ALS:
>  		ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
> @@ -453,7 +457,7 @@ static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
>  		return ret;
>  	}
>  
> -	return isl29028_set_als_scale(chip, chip->lux_scale);
> +	return ret;
>  }
>  
>  static bool isl29028_is_volatile_reg(struct device *dev, unsigned int reg)
> 

