Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51831 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3JAIIU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:08:20 -0400
Message-ID: <524A911F.4040201@kernel.org>
Date: Tue, 01 Oct 2013 10:08:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/25] iio:max1363: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-18-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-18-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/adc/max1363.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index b4bc166..2b34d2f 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -397,7 +397,6 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	int ret;
> -	unsigned long scale_uv;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -406,10 +405,9 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = st->vref_uv >> st->chip_info->bits;
> -		*val = scale_uv / 1000;
> -		*val2 = (scale_uv % 1000) * 1000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = st->vref_uv / 1000;
> +		*val2 = st->chip_info->bits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
>  		return -EINVAL;
>  	}
> 
