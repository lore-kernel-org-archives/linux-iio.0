Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51434 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580Ab3JAHpr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 03:45:47 -0400
Message-ID: <524A8BD6.1000303@kernel.org>
Date: Tue, 01 Oct 2013 09:46:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/25] iio:ad5064: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-1-git-send-email-lars@metafoo.de>
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
>  drivers/iio/dac/ad5064.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
> index b18e8c4..cb9c636 100644
> --- a/drivers/iio/dac/ad5064.c
> +++ b/drivers/iio/dac/ad5064.c
> @@ -239,10 +239,9 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
>  		if (scale_uv < 0)
>  			return scale_uv;
>  
> -		scale_uv = (scale_uv * 100) >> chan->scan_type.realbits;
> -		*val =  scale_uv / 100000;
> -		*val2 = (scale_uv % 100000) * 10;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = scale_uv / 1000;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
>  		break;
>  	}
> 
