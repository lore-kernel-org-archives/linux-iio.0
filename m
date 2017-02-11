Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44910 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbdBKJll (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 04:41:41 -0500
Subject: Re: [PATCH 1/7] staging: iio: isl29028: change mdelay() to msleep()
To: Brian Masney <masneyb@onstation.org>
References: <20170209015431.17380-1-masneyb@onstation.org>
 <20170209015431.17380-2-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fee0c0b5-c6fa-196a-94ff-6d9cc62a2779@kernel.org>
Date: Sat, 11 Feb 2017 09:41:39 +0000
MIME-Version: 1.0
In-Reply-To: <20170209015431.17380-2-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/02/17 01:54, Brian Masney wrote:
> This driver in some cases can busy wait for upwards of 100 ms. Since the
> kernel at this point is not running in atomic context, and is running in
> process context, we can safely use msleep() instead. This patch changes
> the two occurrences of mdelay() to msleep().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29028.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 6bb6d37..8dc24c94 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -121,7 +121,7 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip)
>  		return ret;
>  
>  	/* Wait for conversion to be complete for first sample */
> -	mdelay(DIV_ROUND_UP(1000, chip->prox_sampling));
> +	msleep(DIV_ROUND_UP(1000, chip->prox_sampling));
>  
>  	return 0;
>  }
> @@ -192,7 +192,7 @@ static int isl29028_set_als_ir_mode(struct isl29028_chip *chip,
>  		return ret;
>  
>  	/* Need to wait for conversion time if ALS/IR mode enabled */
> -	mdelay(ISL29028_CONV_TIME_MS);
> +	msleep(ISL29028_CONV_TIME_MS);
>  
>  	chip->als_ir_mode = mode;
>  
> 

