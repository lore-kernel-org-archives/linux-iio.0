Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35285 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdAUOmY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:42:24 -0500
Subject: Re: [PATCH v2 07/15] staging: iio: isl29028: move failure logging
 into isl29028_set_als_scale()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-8-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <47f922dc-671a-d68b-f465-ba10dd363696@kernel.org>
Date: Sat, 21 Jan 2017 14:42:12 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-8-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:24, Brian Masney wrote:
> When isl29028_set_als_scale() fails, it was up to both callers to log
> the failure message. This patch moves the logging into
> isl29028_set_als_scale() to reduce the overall amount of code in the
> driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied
> ---
>  drivers/staging/iio/light/isl29028.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index bd85ccb..8e7b3db 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -123,11 +123,22 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip, bool enable)
>  
>  static int isl29028_set_als_scale(struct isl29028_chip *chip, int lux_scale)
>  {
> +	struct device *dev = regmap_get_device(chip->regmap);
>  	int val = (lux_scale == 2000) ? ISL29028_CONF_ALS_RANGE_HIGH_LUX :
>  					ISL29028_CONF_ALS_RANGE_LOW_LUX;
> +	int ret;
> +
> +	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
> +				 ISL29028_CONF_ALS_RANGE_MASK, val);
> +	if (ret < 0) {
> +		dev_err(dev, "%s(): Error %d setting the ALS scale\n", __func__,
> +			ret);
> +		return ret;
> +	}
>  
> -	return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
> -				  ISL29028_CONF_ALS_RANGE_MASK, val);
> +	chip->lux_scale = lux_scale;
> +
> +	return ret;
>  }
>  
>  static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
> @@ -318,13 +329,6 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  		}
>  
>  		ret = isl29028_set_als_scale(chip, val);
> -		if (ret < 0) {
> -			dev_err(dev,
> -				"Setting lux scale fail with error %d\n", ret);
> -			break;
> -		}
> -
> -		chip->lux_scale = val;
>  		break;
>  	default:
>  		dev_err(dev, "Unsupported channel type\n");
> @@ -443,10 +447,7 @@ static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = isl29028_set_als_scale(chip, chip->lux_scale);
> -	if (ret < 0)
> -		dev_err(dev, "setting als scale failed, err = %d\n", ret);
> -	return ret;
> +	return isl29028_set_als_scale(chip, chip->lux_scale);
>  }
>  
>  static bool isl29028_is_volatile_reg(struct device *dev, unsigned int reg)
> 

