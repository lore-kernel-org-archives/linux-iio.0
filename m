Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51903 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab3JAIKt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:10:49 -0400
Message-ID: <524A91B4.8050701@kernel.org>
Date: Tue, 01 Oct 2013 10:11:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 22/25] staging:iio:ad799x: Report scale as fractional
 value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-22-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-22-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied
> ---
>  drivers/staging/iio/adc/ad799x_core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
> index 3f5142b..eb6a690 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c
> +++ b/drivers/staging/iio/adc/ad799x_core.c
> @@ -163,7 +163,6 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>  {
>  	int ret;
>  	struct ad799x_state *st = iio_priv(indio_dev);
> -	unsigned int scale_uv;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -180,10 +179,9 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>  			RES_MASK(chan->scan_type.realbits);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = (st->int_vref_mv * 1000) >> chan->scan_type.realbits;
> -		*val =  scale_uv / 1000;
> -		*val2 = (scale_uv % 1000) * 1000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = st->int_vref_mv;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
>  	return -EINVAL;
>  }
> 
