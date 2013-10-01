Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51484 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3JAHuW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 03:50:22 -0400
Message-ID: <524A8CE9.70000@kernel.org>
Date: Tue, 01 Oct 2013 09:50:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/25] iio:ad5421: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-4-git-send-email-lars@metafoo.de>
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
>  drivers/iio/dac/ad5421.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
> index 1f78b14..567c4bd 100644
> --- a/drivers/iio/dac/ad5421.c
> +++ b/drivers/iio/dac/ad5421.c
> @@ -281,18 +281,11 @@ static inline unsigned int ad5421_get_offset(struct ad5421_state *st)
>  	return (min * (1 << 16)) / (max - min);
>  }
>  
> -static inline unsigned int ad5421_get_scale(struct ad5421_state *st)
> -{
> -	unsigned int min, max;
> -
> -	ad5421_get_current_min_max(st, &min, &max);
> -	return ((max - min) * 1000) / (1 << 16);
> -}
> -
>  static int ad5421_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long m)
>  {
>  	struct ad5421_state *st = iio_priv(indio_dev);
> +	unsigned int min, max;
>  	int ret;
>  
>  	if (chan->type != IIO_CURRENT)
> @@ -306,9 +299,10 @@ static int ad5421_read_raw(struct iio_dev *indio_dev,
>  		*val = ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
> -		*val2 = ad5421_get_scale(st);
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		ad5421_get_current_min_max(st, &min, &max);
> +		*val = max - min;
> +		*val2 = (1 << 16) * 1000;
> +		return IIO_VAL_FRACTIONAL;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = ad5421_get_offset(st);
>  		return IIO_VAL_INT;
> 
