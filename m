Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51878 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab3JAIJj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:09:39 -0400
Message-ID: <524A916E.3040302@kernel.org>
Date: Tue, 01 Oct 2013 10:10:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 20/25] staging:iio:ad7606: Report scale as fractional
 value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-20-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-20-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>  drivers/staging/iio/adc/ad7606_core.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index f042027..2083673 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -85,7 +85,6 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  {
>  	int ret;
>  	struct ad7606_state *st = iio_priv(indio_dev);
> -	unsigned int scale_uv;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -101,11 +100,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
>  		*val = (short) ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = (st->range * 1000 * 2)
> -			>> st->chip_info->channels[0].scan_type.realbits;
> -		*val =  scale_uv / 1000;
> -		*val2 = (scale_uv % 1000) * 1000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = st->range * 2;
> +		*val2 = st->chip_info->channels[0].scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
>  	return -EINVAL;
>  }
> 
