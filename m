Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51708 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab2JSFaJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 01:30:09 -0400
Message-ID: <507FC6BB.4090202@kernel.org>
Date: Thu, 18 Oct 2012 10:07:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 03/11] staging:iio: Fix adis16203 channel offsets and
 scales
References: <1350293734-21951-1-git-send-email-lars@metafoo.de> <1350293734-21951-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1350293734-21951-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/15/2012 10:35 AM, Lars-Peter Clausen wrote:
> Most of the channel offsets and scales in the adis16203 are incorrect:
> 	* Temperature scale is off by a factor of 1000
> 	* Voltage scale is off by a factor of 1000
> 	* Temperature offset is completely wrong
> 
> This patch fixes these issues.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to fixes branch of iio.git

> ---
>  drivers/staging/iio/accel/adis16203_core.c |   20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
> index 002fa9d..e7b3441 100644
> --- a/drivers/staging/iio/accel/adis16203_core.c
> +++ b/drivers/staging/iio/accel/adis16203_core.c
> @@ -316,25 +316,27 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
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
> +			*val = -470; /* -0.47 C */
> +			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_INCLI:
>  			*val = 0;
> -			*val2 = 25000;
> +			*val2 = 25000; /* 0.025 degree */
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25;
> +		*val = 25000 / -470 - 1278; /* 25 C = 1278 */
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		bits = 14;
> 
