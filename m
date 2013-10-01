Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51535 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab3JAHxJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 03:53:09 -0400
Message-ID: <524A8D91.2080807@kernel.org>
Date: Tue, 01 Oct 2013 09:53:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 08/25] iio:ad5686: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-8-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied
> ---
>  drivers/iio/dac/ad5686.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index f472b48..30e506e 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -201,7 +201,6 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
> -	unsigned long scale_uv;
>  	int ret;
>  
>  	switch (m) {
> @@ -214,12 +213,9 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  		*val = ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = (st->vref_mv * 100000)
> -			>> (chan->scan_type.realbits);
> -		*val =  scale_uv / 100000;
> -		*val2 = (scale_uv % 100000) * 10;
> -		return IIO_VAL_INT_PLUS_MICRO;
> -
> +		*val = st->vref_mv;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
>  	return -EINVAL;
>  }
> 
