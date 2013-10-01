Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51855 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab3JAIIv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:08:51 -0400
Message-ID: <524A913F.7080507@kernel.org>
Date: Tue, 01 Oct 2013 10:09:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 19/25] staging:iio:ad7280a: Report scale as fractional
 value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-19-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-19-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied
> ---
>  drivers/staging/iio/adc/ad7280a.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index e7191e4..8209fa5 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -783,7 +783,6 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad7280_state *st = iio_priv(indio_dev);
> -	unsigned int scale_uv;
>  	int ret;
>  
>  	switch (m) {
> @@ -804,13 +803,12 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6)
> -			scale_uv = (4000 * 1000) >> AD7280A_BITS;
> +			*val = 4000;
>  		else
> -			scale_uv = (5000 * 1000) >> AD7280A_BITS;
> +			*val = 5000;
>  
> -		*val =  scale_uv / 1000;
> -		*val2 = (scale_uv % 1000) * 1000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val2 = AD7280A_BITS;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
>  	return -EINVAL;
>  }
> 
