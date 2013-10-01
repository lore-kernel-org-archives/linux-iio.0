Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51709 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab3JAIEt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:04:49 -0400
Message-ID: <524A904C.8080006@kernel.org>
Date: Tue, 01 Oct 2013 10:05:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 14/25] iio:ad7266: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-14-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/adc/ad7266.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 656aa3e..f5723cb 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -27,7 +27,7 @@
>  struct ad7266_state {
>  	struct spi_device	*spi;
>  	struct regulator	*reg;
> -	unsigned long		vref_uv;
> +	unsigned long		vref_mv;
>  
>  	struct spi_transfer	single_xfer[3];
>  	struct spi_message	single_msg;
> @@ -156,7 +156,7 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long m)
>  {
>  	struct ad7266_state *st = iio_priv(indio_dev);
> -	unsigned long scale_uv;
> +	unsigned long scale_mv;
>  	int ret;
>  
>  	switch (m) {
> @@ -174,16 +174,15 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = (st->vref_uv * 100);
> +		scale_mv = st->vref_mv;
>  		if (st->mode == AD7266_MODE_DIFF)
> -			scale_uv *= 2;
> +			scale_mv *= 2;
>  		if (st->range == AD7266_RANGE_2VREF)
> -			scale_uv *= 2;
> +			scale_mv *= 2;
>  
> -		scale_uv >>= chan->scan_type.realbits;
> -		*val =  scale_uv / 100000;
> -		*val2 = (scale_uv % 100000) * 10;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = scale_mv;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_OFFSET:
>  		if (st->range == AD7266_RANGE_2VREF &&
>  			st->mode != AD7266_MODE_DIFF)
> @@ -414,10 +413,10 @@ static int ad7266_probe(struct spi_device *spi)
>  		if (ret < 0)
>  			goto error_disable_reg;
>  
> -		st->vref_uv = ret;
> +		st->vref_mv = ret / 1000;
>  	} else {
>  		/* Use internal reference */
> -		st->vref_uv = 2500000;
> +		st->vref_mv = 2500;
>  	}
>  
>  	if (pdata) {
> 
