Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55408 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761112Ab3JPRLr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:11:47 -0400
Message-ID: <525ED709.5080502@kernel.org>
Date: Wed, 16 Oct 2013 19:12:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/17] iio:ad7266: Remove redundant call to iio_sw_preenable()
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
> so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/adc/ad7266.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index f5723cb..58e9455 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -61,17 +61,7 @@ static int ad7266_powerdown(struct ad7266_state *st)
>  static int ad7266_preenable(struct iio_dev *indio_dev)
>  {
>  	struct ad7266_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = ad7266_wakeup(st);
> -	if (ret)
> -		return ret;
> -
> -	ret = iio_sw_buffer_preenable(indio_dev);
> -	if (ret)
> -		ad7266_powerdown(st);
> -
> -	return ret;
> +	return ad7266_wakeup(st);
>  }
>  
>  static int ad7266_postdisable(struct iio_dev *indio_dev)
> 
