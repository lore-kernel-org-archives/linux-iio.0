Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51946 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab3JAIMo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:12:44 -0400
Message-ID: <524A9227.7040103@kernel.org>
Date: Tue, 01 Oct 2013 10:13:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 24/25] staging:iio:spear_adc: Report scale as fractional
 value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-24-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-24-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Stefan Roese <sr@denx.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/adc/spear_adc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
> index 20f2d55..657e01b 100644
> --- a/drivers/staging/iio/adc/spear_adc.c
> +++ b/drivers/staging/iio/adc/spear_adc.c
> @@ -168,10 +168,9 @@ static int spear_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_mv = (info->vref_external * 1000) >> DATA_BITS;
> -		*val =  scale_mv / 1000;
> -		*val2 = (scale_mv % 1000) * 1000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = info->vref_external;
> +		*val2 = DATA_BITS;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
>  
>  	return -EINVAL;
> 
