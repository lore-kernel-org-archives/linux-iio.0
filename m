Return-Path: <SRS0=sL3g=BW=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 23 Oct 2017 12:06:43 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        lars@metafoo.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com, pmeerw@pmeerw.net,
        knaack.h@gmx.de
Subject: Re: [PATCH 13/13] staging: iio: tsl2x7x: add goto for
 TSL2X7X_LUX_CALC_OVER_FLOW
Message-ID: <20171023090642.26cp22adk6olktr6@mwanda>
References: <20171019200632.25820-1-masneyb@onstation.org>
 <20171019200632.25820-14-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019200632.25820-14-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Oct 19, 2017 at 04:06:32PM -0400, Brian Masney wrote:
> This patch adds a return_max label for the two cases that need to set
> the lux to TSL2X7X_LUX_CALC_OVER_FLOW and return.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
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

Ugh...  Wow.  No.  This terrible anti-pattern is spreading.  Don't do
this.

regards,
dan carpenter
