Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51451 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab3JAHsI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 03:48:08 -0400
Message-ID: <524A8C63.6030900@kernel.org>
Date: Tue, 01 Oct 2013 09:48:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 02/25] iio:ad5360: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-2-git-send-email-lars@metafoo.de>
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
>  drivers/iio/dac/ad5360.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> index d2da71e..b968af5 100644
> --- a/drivers/iio/dac/ad5360.c
> +++ b/drivers/iio/dac/ad5360.c
> @@ -379,15 +379,14 @@ static int ad5360_read_raw(struct iio_dev *indio_dev,
>  		*val = ret >> chan->scan_type.shift;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		/* vout = 4 * vref * dac_code */
> -		scale_uv = ad5360_get_channel_vref(st, chan->channel) * 4 * 100;
> +		scale_uv = ad5360_get_channel_vref(st, chan->channel);
>  		if (scale_uv < 0)
>  			return scale_uv;
>  
> -		scale_uv >>= (chan->scan_type.realbits);
> -		*val =  scale_uv / 100000;
> -		*val2 = (scale_uv % 100000) * 10;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		/* vout = 4 * vref * dac_code */
> +		*val = scale_uv * 4 / 1000;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		ret = ad5360_read(indio_dev, AD5360_READBACK_OFFSET,
>  			chan->address);
> 
