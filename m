Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51893 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab3JAIKU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:10:20 -0400
Message-ID: <524A9197.40707@kernel.org>
Date: Tue, 01 Oct 2013 10:10:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 21/25] staging:iio:ad7780: Report scale as fractional
 value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-21-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-21-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
applied
> ---
>  drivers/staging/iio/adc/ad7780.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 4f2522a..273add3 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -90,17 +90,14 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad7780_state *st = iio_priv(indio_dev);
> -	unsigned long scale_uv;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
>  		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = (st->int_vref_mv * 100000 * st->gain)
> -			>> (chan->scan_type.realbits - 1);
> -		*val =  scale_uv / 100000;
> -		*val2 = (scale_uv % 100000) * 10;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = st->int_vref_mv * st->gain;
> +		*val2 = chan->scan_type.realbits - 1;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val -= (1 << (chan->scan_type.realbits - 1));
>  		return IIO_VAL_INT;
> 
