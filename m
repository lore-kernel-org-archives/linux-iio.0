Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbeELLQH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 May 2018 07:16:07 -0400
Date: Sat, 12 May 2018 12:16:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v3 2/9] staging: iio: tsl2x7x: use direct returns
Message-ID: <20180512121601.4e849815@archlinux>
In-Reply-To: <20180511001223.12378-3-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
        <20180511001223.12378-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 10 May 2018 20:12:16 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch changes the functions tsl2x7x_read_event_value() and
> tsl2x7x_read_raw() to use direct returns to simplify the code.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied, thanks

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 49 ++++++++++++-------------------------
>  1 file changed, 16 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 3ae2fd19ae9c..c1e726fc87b7 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1014,7 +1014,7 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  				    int *val, int *val2)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = -EINVAL, filter_delay, mult;
> +	int filter_delay, mult;
>  	u8 time;
>  
>  	switch (info) {
> @@ -1023,27 +1023,23 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  			switch (dir) {
>  			case IIO_EV_DIR_RISING:
>  				*val = chip->settings.als_thresh_high;
> -				ret = IIO_VAL_INT;
> -				break;
> +				return IIO_VAL_INT;
>  			case IIO_EV_DIR_FALLING:
>  				*val = chip->settings.als_thresh_low;
> -				ret = IIO_VAL_INT;
> -				break;
> +				return IIO_VAL_INT;
>  			default:
> -				break;
> +				return -EINVAL;
>  			}
>  		} else {
>  			switch (dir) {
>  			case IIO_EV_DIR_RISING:
>  				*val = chip->settings.prox_thres_high;
> -				ret = IIO_VAL_INT;
> -				break;
> +				return IIO_VAL_INT;
>  			case IIO_EV_DIR_FALLING:
>  				*val = chip->settings.prox_thres_low;
> -				ret = IIO_VAL_INT;
> -				break;
> +				return IIO_VAL_INT;
>  			default:
> -				break;
> +				return -EINVAL;
>  			}
>  		}
>  		break;
> @@ -1062,13 +1058,10 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  		filter_delay = *val2 * mult;
>  		*val = filter_delay / 1000;
>  		*val2 = filter_delay % 1000;
> -		ret = IIO_VAL_INT_PLUS_MICRO;
> -		break;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
> -		break;
> +		return -EINVAL;
>  	}
> -
> -	return ret;
>  }
>  
>  static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
> @@ -1078,7 +1071,6 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> @@ -1086,12 +1078,10 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  		case IIO_LIGHT:
>  			tsl2x7x_get_lux(indio_dev);
>  			*val = chip->als_cur_info.lux;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
>  		}
> -		break;
>  	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
>  		case IIO_INTENSITY:
> @@ -1100,13 +1090,11 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  				*val = chip->als_cur_info.als_ch0;
>  			else
>  				*val = chip->als_cur_info.als_ch1;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		case IIO_PROXIMITY:
>  			tsl2x7x_get_prox(indio_dev);
>  			*val = chip->prox_data;
> -			ret = IIO_VAL_INT;
> -			break;
> +			return IIO_VAL_INT;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -1116,22 +1104,17 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  			*val = tsl2x7x_als_gain[chip->settings.als_gain];
>  		else
>  			*val = tsl2x7x_prox_gain[chip->settings.prox_gain];
> -		ret = IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		*val = chip->settings.als_gain_trim;
> -		ret = IIO_VAL_INT;
> -		break;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
>  		*val = 0;
>  		*val2 = (256 - chip->settings.als_time) * 2720;
> -		ret = IIO_VAL_INT_PLUS_MICRO;
> -		break;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}
> -
> -	return ret;
>  }
>  
>  static int tsl2x7x_write_raw(struct iio_dev *indio_dev,

