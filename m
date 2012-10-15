Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-100.synserver.de ([212.40.185.100]:1168 "EHLO
	smtp-out-100.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752Ab2JOJkp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Oct 2012 05:40:45 -0400
Message-ID: <507BDA68.40905@metafoo.de>
Date: Mon, 15 Oct 2012 11:42:00 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 04/11] staging:iio: Fix adis16203 channel offsets and
 scales
References: <1350293734-21951-1-git-send-email-lars@metafoo.de> <1350293734-21951-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1350293734-21951-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

s/adis16203/adis16204/

On 10/15/2012 11:35 AM, Lars-Peter Clausen wrote:
> Most of the channel offsets and scales in the adis16203 are incorrect:
> 	* Temperature scale is off by a factor of 1000
> 	* Voltage scale is off by a factor of 1000
> 	* Acceleration is scale is in g instead of m/(s**2)
> 	* Temperature offset is completely wrong
> 
> This patch fixes these issues.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/accel/adis16204_core.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
> index 05bdb7c..c6234c2 100644
> --- a/drivers/staging/iio/accel/adis16204_core.c
> +++ b/drivers/staging/iio/accel/adis16204_core.c
> @@ -317,26 +317,28 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			*val = 0;
> -			if (chan->channel == 0)
> -				*val2 = 1220;
> -			else
> -				*val2 = 610;
> +			if (chan->channel == 0) {
> +				*val = 1;
> +				*val2 = 220000; /* 1.22 mV */
> +			} else {
> +				*val = 0;
> +				*val2 = 610000; /* 0.61 mV */
> +			}
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = 0;
> -			*val2 = -470000;
> +			*val = -470; /* 0.47 C */
> +			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
>  			*val = 0;
>  			switch (chan->channel2) {
>  			case IIO_MOD_X:
>  			case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
> -				*val2 = 17125;
> +				*val2 = IIO_G_TO_M_S_2(17125); /* 17.125 mg */
>  				break;
>  			case IIO_MOD_Y:
>  			case IIO_MOD_Z:
> -				*val2 = 8407;
> +				*val2 = IIO_G_TO_M_S_2(8407); /* 8.407 mg */
>  				break;
>  			}
>  			return IIO_VAL_INT_PLUS_MICRO;
> @@ -345,7 +347,7 @@ static int adis16204_read_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25;
> +		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  	case IIO_CHAN_INFO_PEAK:

