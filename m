Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35195 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdAUOaK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:30:10 -0500
Subject: Re: [PATCH v2 02/15] staging: iio: isl29028: fix alignment of
 function arguments
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-3-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <476948d5-6988-d649-1a77-e0caa1cffb4e@kernel.org>
Date: Sat, 21 Jan 2017 14:30:08 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-3-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:24, Brian Masney wrote:
> Two separate calls to regmap_update_bits() in isl29028_set_als_scale()
> and isl29028_set_als_ir_mode() did not have their function arguments
> on the next line aligned correctly to the open parenthesis. This patch
> corrects the alignment.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/isl29028.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 4cce663..74eb736 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -116,7 +116,7 @@ static int isl29028_set_als_scale(struct isl29028_chip *chip, int lux_scale)
>  					ISL29028_CONF_ALS_RANGE_LOW_LUX;
>  
>  	return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
> -		ISL29028_CONF_ALS_RANGE_MASK, val);
> +				  ISL29028_CONF_ALS_RANGE_MASK, val);
>  }
>  
>  static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
> @@ -148,7 +148,8 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
>  
>  	case ISL29028_MODE_NONE:
>  		return regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
> -			ISL29028_CONF_ALS_EN_MASK, ISL29028_CONF_ALS_DIS);
> +					  ISL29028_CONF_ALS_EN_MASK,
> +					  ISL29028_CONF_ALS_DIS);
>  	}
>  
>  	if (ret < 0)
> 

