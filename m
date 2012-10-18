Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51718 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab2JSFaN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 19 Oct 2012 01:30:13 -0400
Message-ID: <507FC763.4020709@kernel.org>
Date: Thu, 18 Oct 2012 10:09:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 05/11] staging:iio: Fix adis16209 channel offsets and
 scales
References: <1350293734-21951-1-git-send-email-lars@metafoo.de> <1350293734-21951-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1350293734-21951-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/15/2012 10:35 AM, Lars-Peter Clausen wrote:
> Most of the channel offsets and scales in the adis16209 are incorrect:
> 	* Temperature scale is of by a factor of 1000
> 	* Voltage scale is of by a factor of 1000
> 	* Temperature offset is completely wrong
> 	* Rotational position scale is missing
> 
> This patch fixes these issues. Also use the IIO_G_TO_M_S_2 macro for the
> acceleration scale since this makes it much easier to compare it with the value
> given in the datasheet.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to fixes-togreg branch of iio.git
> ---
>  drivers/staging/iio/accel/adis16209_core.c |   18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index b7333bf..7ee974b 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -343,28 +343,29 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  		case IIO_VOLTAGE:
>  			*val = 0;
>  			if (chan->channel == 0)
> -				*val2 = 305180;
> +				*val2 = 305180; /* 0.30518 mV */
>  			else
> -				*val2 = 610500;
> +				*val2 = 610500; /* 0.6105 mV */
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = 0;
> -			*val2 = -470000;
> +			*val = -470; /* -0.47 C */
> +			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
>  			*val = 0;
> -			*val2 = 2394;
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			*val2 = IIO_G_TO_M_S_2(244140); /* 0.244140 mg */
> +			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_INCLI:
> +		case IIO_ROT:
>  			*val = 0;
> -			*val2 = 436;
> +			*val2 = 25000; /* 0.025 degree */
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		default:
>  			return -EINVAL;
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> -		*val = 25;
> +		*val = 25000 / -470 - 0x4FE; /* 25 C = 0x4FE */
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
> @@ -491,6 +492,7 @@ static const struct iio_chan_spec adis16209_channels[] = {
>  		.modified = 1,
>  		.channel2 = IIO_MOD_X,
>  		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
> +		IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = rot,
>  		.scan_index = ADIS16209_SCAN_ROT,
>  		.scan_type = {
> 
