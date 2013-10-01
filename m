Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51688 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab3JAIDV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:03:21 -0400
Message-ID: <524A8FF1.8000205@kernel.org>
Date: Tue, 01 Oct 2013 10:03:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH 12/25] iio:max517: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-12-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

This one should have had a cc for Roland so I've added it now.

Roland, shout if you have any comments on this! Whilst it is my
tree I'll probably not send another pull request to Greg until
the weekend.

Thanks,

Jonathan
> ---
>  drivers/iio/dac/max517.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
> index 83adcbf..d26be14 100644
> --- a/drivers/iio/dac/max517.c
> +++ b/drivers/iio/dac/max517.c
> @@ -82,15 +82,13 @@ static int max517_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct max517_data *data = iio_priv(indio_dev);
> -	unsigned int scale_uv;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_SCALE:
>  		/* Corresponds to Vref / 2^(bits) */
> -		scale_uv = (data->vref_mv[chan->channel] * 1000) >> 8;
> -		*val =  scale_uv / 1000000;
> -		*val2 = scale_uv % 1000000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = data->vref_mv[chan->channel];
> +		*val2 = 8;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
>  		break;
>  	}
> 
