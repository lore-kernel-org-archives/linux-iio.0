Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42857 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938771AbdAHJnj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:43:39 -0500
Subject: Re: [PATCH 14/19] staging: iio: isl29028: move failure logging into
 isl29028_set_als_scale()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-15-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <35ff9718-8666-d350-975c-4cb963524805@kernel.org>
Date: Sun, 4 Dec 2016 11:51:51 +0000
MIME-Version: 1.0
In-Reply-To: <1480817983-32359-15-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/16 02:19, Brian Masney wrote:
> When isl29028_set_als_scale() fails, it was up to both callers to log
> the failure message. This patch moves the logging into
> isl29028_set_als_scale() to reduce the overall amount of code in the
> driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/isl29028.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 0c8a878..11e1673 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -121,11 +121,21 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip)
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
> +	if (ret < 0)
> +		dev_err(dev,
> +			"%s(): Error %d setting the ALS scale\n", __func__,
> +			ret);
Again, I would prefer a direct return here and drop the else.
Where possible it's always nice to have the 'good' path be the inline one and
indent the error cases.
> +	else
> +		chip->lux_scale = lux_scale;
>  
> -	return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
> -				  ISL29028_CONF_ALS_RANGE_MASK, val);
> +	return ret;
>  }
>  
>  static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
> @@ -322,13 +332,6 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
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
> @@ -459,7 +462,7 @@ static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
>  
>  	ret = isl29028_set_als_scale(chip, chip->lux_scale);
>  	if (ret < 0)
> -		dev_err(dev, "setting als scale failed, err = %d\n", ret);
> +		return ret;
>  
>  	chip->suspended = false;
>  
> 

