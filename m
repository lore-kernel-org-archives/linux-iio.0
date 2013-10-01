Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51931 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab3JAIMJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:12:09 -0400
Message-ID: <524A9204.8000501@kernel.org>
Date: Tue, 01 Oct 2013 10:12:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 23/25] staging:iio:ad7746: Report scale as fractional
 value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-23-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-23-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Should probably mention the tidying up in the commit message, but it is
trivial so I won't bother changing it ;)

Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/cdc/ad7746.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 75a533b..862d68d 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -656,20 +656,21 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		switch (chan->type) {
>  		case IIO_CAPACITANCE:
>  			/* 8.192pf / 2^24 */
> -			*val2 = 488;
>  			*val =  0;
> +			*val2 = 488;
> +			ret = IIO_VAL_INT_PLUS_NANO;
>  			break;
>  		case IIO_VOLTAGE:
>  			/* 1170mV / 2^23 */
> -			*val2 = 139475;
> -			*val =  0;
> +			*val = 1170;
> +			*val2 = 23;
> +			ret = IIO_VAL_FRACTIONAL_LOG2;
>  			break;
>  		default:
> -			ret =  -EINVAL;
> -			goto out;
> +			ret = -EINVAL;
> +			break;
>  		}
>  
> -		ret = IIO_VAL_INT_PLUS_NANO;
>  		break;
>  	default:
>  		ret = -EINVAL;
> 
