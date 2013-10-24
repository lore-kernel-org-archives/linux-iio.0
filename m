Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35646 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128Ab3JXMsV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 08:48:21 -0400
Message-ID: <52692552.2070901@kernel.org>
Date: Thu, 24 Oct 2013 14:49:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/9] iio: adc: twl6030-gpadc: Remove redundant code
References: <1382615615-20153-1-git-send-email-sachin.kamat@linaro.org> <1382615615-20153-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382615615-20153-4-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/13 12:53, Sachin Kamat wrote:
> The if check is redundant as the value obtained from
> iio_device_register() is already in the required format.
> Hence return the function directly.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied
> ---
>  drivers/iio/adc/twl6030-gpadc.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index 0ea96c0..5d13f8b 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -948,9 +948,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  	indio_dev->channels = pdata->iio_channels;
>  	indio_dev->num_channels = pdata->nchannels;
>  
> -	ret = iio_device_register(indio_dev);
> -
> -	return ret;
> +	return iio_device_register(indio_dev);
>  }
>  
>  static int twl6030_gpadc_remove(struct platform_device *pdev)
> 
