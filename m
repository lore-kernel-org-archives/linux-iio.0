Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55543 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761010Ab3JPROr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:14:47 -0400
Message-ID: <525ED7BB.1090302@kernel.org>
Date: Wed, 16 Oct 2013 19:15:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 13/17] staging:iio:mxs-lradc: Remove redundant call to
 iio_sw_buffer_preenable()
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-13-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
> so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Marek Vasut <marex@denx.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index dfd1bc1..1bb03e1 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -1041,10 +1041,6 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
>  		goto err_mem;
>  	}
>  
> -	ret = iio_sw_buffer_preenable(iio);
> -	if (ret < 0)
> -		goto err_buf;
> -
>  	if (lradc->soc == IMX28_LRADC)
>  		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
>  							LRADC_CTRL1);
> @@ -1069,8 +1065,6 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
>  
>  	return 0;
>  
> -err_buf:
> -	kfree(lradc->buffer);
>  err_mem:
>  	mutex_unlock(&lradc->lock);
>  	return ret;
> 
