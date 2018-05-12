Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750879AbeELLXj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 May 2018 07:23:39 -0400
Date: Sat, 12 May 2018 12:23:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v3 7/9] staging: iio: tsl2x7x: add range checking to
 tsl2x7x_write_raw
Message-ID: <20180512122334.79c1bd66@archlinux>
In-Reply-To: <20180511001223.12378-8-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
        <20180511001223.12378-8-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 10 May 2018 20:12:21 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The CALIBBIAS and INT_TIME masks in tsl2x7x_write_raw did not have any
> range checking in place so this patch adds the appropriate range
> checking. The defines TSL2X7X_ALS_GAIN_TRIM_{MIN,MAX} are also
> introduced by this patch.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 0218eabcd6d7..f9500afab30c 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -103,6 +103,9 @@
>  #define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
>  #define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
>  
> +#define TSL2X7X_ALS_GAIN_TRIM_MIN	250
> +#define TSL2X7X_ALS_GAIN_TRIM_MAX	4000
> +
>  /* TAOS txx2x7x Device family members */
>  enum {
>  	tsl2571,
> @@ -581,7 +584,7 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  
>  	ret = (chip->settings.als_cal_target * chip->settings.als_gain_trim) /
>  			lux_val;
> -	if (ret < 250 || ret > 4000)
> +	if (ret < TSL2X7X_ALS_GAIN_TRIM_MIN || ret > TSL2X7X_ALS_GAIN_TRIM_MAX)
>  		return -ERANGE;
>  
>  	chip->settings.als_gain_trim = ret;
> @@ -1209,9 +1212,17 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val < TSL2X7X_ALS_GAIN_TRIM_MIN ||
> +		    val > TSL2X7X_ALS_GAIN_TRIM_MAX)
> +			return -EINVAL;
> +
>  		chip->settings.als_gain_trim = val;
>  		break;
>  	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0 || val2 < tsl2x7x_int_time_avail[chip->id][1] ||
> +		    val2 > tsl2x7x_int_time_avail[chip->id][5])
> +			return -EINVAL;
> +
>  		chip->settings.als_time = 256 -
>  			(val2 / tsl2x7x_int_time_avail[chip->id][3]);
>  		break;

