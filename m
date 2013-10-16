Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55450 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761010Ab3JPRMg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:12:36 -0400
Message-ID: <525ED73A.404@kernel.org>
Date: Wed, 16 Oct 2013 19:13:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>
Subject: Re: [PATCH 06/17] iio:ti_am335x: Remove redundant call to iio_sw_buffer_preenable()
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-6-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer
> core, so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 8fb5429..ef54d8a 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -166,7 +166,7 @@ static int tiadc_buffer_preenable(struct iio_dev *indio_dev)
>  	for (i = 0; i < fifo1count; i++)
>  		read = tiadc_readl(adc_dev, REG_FIFO1);
>  
> -	return iio_sw_buffer_preenable(indio_dev);
> +	return 0;
>  }
>  
>  static int tiadc_buffer_postenable(struct iio_dev *indio_dev)
> 
