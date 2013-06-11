Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55470 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab3FKTe1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2013 15:34:27 -0400
Message-ID: <51B77BC2.9090705@kernel.org>
Date: Tue, 11 Jun 2013 20:34:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] staging:iio:adis16130: Report scale and offset
References: <1370872815-14386-1-git-send-email-lars@metafoo.de> <1370872815-14386-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1370872815-14386-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/10/2013 03:00 PM, Lars-Peter Clausen wrote:
> Report scale and offset for the temperature and voltage channels.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git. Thanks.
> ---
>  drivers/staging/iio/gyro/adis16130_core.c | 57 +++++++++++++++++++++++++------
>  1 file changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
> index 2537f59..8979435 100644
> --- a/drivers/staging/iio/gyro/adis16130_core.c
> +++ b/drivers/staging/iio/gyro/adis16130_core.c
> @@ -78,14 +78,47 @@ static int adis16130_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  	u32 temp;
>  
> -	/* Take the iio_dev status lock */
> -	mutex_lock(&indio_dev->mlock);
> -	ret =  adis16130_spi_read(indio_dev, chan->address, &temp);
> -	mutex_unlock(&indio_dev->mlock);
> -	if (ret)
> -		return ret;
> -	*val = temp;
> -	return IIO_VAL_INT;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/* Take the iio_dev status lock */
> +		mutex_lock(&indio_dev->mlock);
> +		ret = adis16130_spi_read(indio_dev, chan->address, &temp);
> +		mutex_unlock(&indio_dev->mlock);
> +		if (ret)
> +			return ret;
> +		*val = temp;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			/* 0 degree = 838860, 250 degree = 14260608 */
> +			*val = 250;
> +			*val2 = 336440817; /* RAD_TO_DEGREE(14260608 - 8388608) */
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_TEMP:
> +			/* 0C = 8036283, 105C = 9516048 */
> +			*val = 105000;
> +			*val2 = 9516048 - 8036283;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_ANGL_VEL:
> +			*val = -8388608;
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val = -8036283;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	}
> +
> +	return -EINVAL;
>  }
>  
>  static const struct iio_chan_spec adis16130_channels[] = {
> @@ -93,13 +126,17 @@ static const struct iio_chan_spec adis16130_channels[] = {
>  		.type = IIO_ANGL_VEL,
>  		.modified = 1,
>  		.channel2 = IIO_MOD_Z,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_OFFSET),
>  		.address = ADIS16130_RATEDATA,
>  	}, {
>  		.type = IIO_TEMP,
>  		.indexed = 1,
>  		.channel = 0,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_OFFSET),
>  		.address = ADIS16130_TEMPDATA,
>  	}
>  };
> 
