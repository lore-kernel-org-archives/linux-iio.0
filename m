Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55436 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761005Ab3JPRMX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:12:23 -0400
Message-ID: <525ED72A.6050405@kernel.org>
Date: Wed, 16 Oct 2013 19:12:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 05/17] iio:ad_sigma_delta: Remove redundant call to iio_sw_buffer_preenable().
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
> so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 2b59112..e6fbd3e 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -397,7 +397,6 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  }
>  
>  static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
> -	.preenable = &iio_sw_buffer_preenable,
>  	.postenable = &ad_sd_buffer_postenable,
>  	.predisable = &iio_triggered_buffer_predisable,
>  	.postdisable = &ad_sd_buffer_postdisable,
> 
