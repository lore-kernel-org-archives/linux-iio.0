Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35351 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdAUOsr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:48:47 -0500
Subject: Re: [PATCH v2 12/15] staging: iio: isl29028: remove enable flag from
 isl29028_enable_proximity()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-13-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <668f8f07-4adf-73df-fa79-83c5542603a4@kernel.org>
Date: Sat, 21 Jan 2017 14:48:43 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-13-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:24, Brian Masney wrote:
> isl29028_enable_proximity() has a boolean argument named enable. This
> function is only called once and the enable flag is set to true in that
> call. This patch removes the enable parameter from that function.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
> The device gets runtime power management support in the next patch in
> this set and autosuspends after two seconds of inactivity. Once the
> device suspends, the pin that drives the external LED for proximity
> sensing will only go high the next time that the user asks for a
> reading from the proximity sensor.
> 
> This patch also sets the stage for additional cleanups prior to the
> introduction of runtime power management support.
> 
>  drivers/staging/iio/light/isl29028.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index bc9c01d..f1b3651 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -103,15 +103,13 @@ static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
>  	return ret;
>  }
>  
> -static int isl29028_enable_proximity(struct isl29028_chip *chip, bool enable)
> +static int isl29028_enable_proximity(struct isl29028_chip *chip)
>  {
>  	int ret;
> -	int val = 0;
>  
> -	if (enable)
> -		val = ISL29028_CONF_PROX_EN;
>  	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
> -				 ISL29028_CONF_PROX_EN_MASK, val);
> +				 ISL29028_CONF_PROX_EN_MASK,
> +				 ISL29028_CONF_PROX_EN);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -225,7 +223,7 @@ static int isl29028_read_proxim(struct isl29028_chip *chip, int *prox)
>  	int ret;
>  
>  	if (!chip->enable_prox) {
> -		ret = isl29028_enable_proximity(chip, true);
> +		ret = isl29028_enable_proximity(chip);
>  		if (ret < 0)
>  			return ret;
>  
> 

