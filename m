Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932179AbdJURqv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:46:51 -0400
Date: Sat, 21 Oct 2017 18:46:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 13/13] staging: iio: tsl2x7x: add goto for
 TSL2X7X_LUX_CALC_OVER_FLOW
Message-ID: <20171021184646.07ca61b7@archlinux>
In-Reply-To: <20171019200632.25820-14-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
        <20171019200632.25820-14-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 16:06:32 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch adds a return_max label for the two cases that need to set
> the lux to TSL2X7X_LUX_CALC_OVER_FLOW and return.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Sorry - don't like this last one.  I think it hurts readability.  Leave
this as it was.

Thanks

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 42ed9c015aaf..898304d65f64 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -364,10 +364,8 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	chip->als_cur_info.als_ch0 = ch0;
>  	chip->als_cur_info.als_ch1 = ch1;
>  
> -	if (ch0 >= chip->als_saturation || ch1 >= chip->als_saturation) {
> -		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
> +	if (ch0 >= chip->als_saturation || ch1 >= chip->als_saturation)
>  		goto return_max;
> -	}
>  
>  	if (!ch0) {
>  		/* have no data, so return LAST VALUE */
> @@ -418,11 +416,12 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	lux = lux64;
>  	lux = (lux + 500) / 1000;
>  
> -	if (lux > TSL2X7X_LUX_CALC_OVER_FLOW) /* check for overflow */
> +	if (lux > TSL2X7X_LUX_CALC_OVER_FLOW) { /* check for overflow */
> +return_max:
>  		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
> +	}
>  
>  	/* Update the structure with the latest lux. */
> -return_max:
>  	chip->als_cur_info.lux = lux;
>  	ret = lux;
>  

