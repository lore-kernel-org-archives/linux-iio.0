Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51553 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab3JAHyY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 03:54:24 -0400
Message-ID: <524A8DDB.6020107@kernel.org>
Date: Tue, 01 Oct 2013 09:54:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/25] iio:ad5764: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-10-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Also fix a off by one error in the comment describing the transfer function.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/dac/ad5764.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5764.c b/drivers/iio/dac/ad5764.c
> index df7e028..a8ff5b2 100644
> --- a/drivers/iio/dac/ad5764.c
> +++ b/drivers/iio/dac/ad5764.c
> @@ -217,7 +217,6 @@ static int ad5764_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long info)
>  {
>  	struct ad5764_state *st = iio_priv(indio_dev);
> -	unsigned long scale_uv;
>  	unsigned int reg;
>  	int vref;
>  	int ret;
> @@ -245,15 +244,14 @@ static int ad5764_read_raw(struct iio_dev *indio_dev,
>  		*val = sign_extend32(*val, 5);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		/* vout = 4 * vref + ((dac_code / 65535) - 0.5) */
> +		/* vout = 4 * vref + ((dac_code / 65536) - 0.5) */
>  		vref = ad5764_get_channel_vref(st, chan->channel);
>  		if (vref < 0)
>  			return vref;
>  
> -		scale_uv = (vref * 4 * 100) >> chan->scan_type.realbits;
> -		*val = scale_uv / 100000;
> -		*val2 = (scale_uv % 100000) * 10;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = vref * 4 / 1000;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = -(1 << chan->scan_type.realbits) / 2;
>  		return IIO_VAL_INT;
> 
