Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53081 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3G0KEN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:04:13 -0400
Message-ID: <51F3A92F.3090901@kernel.org>
Date: Sat, 27 Jul 2013 12:04:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Milo Kim <milo.kim@ti.com>
Subject: Re: [PATCH 07/11] iio: adc: lp8788_adc: Use devm_* APIs
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org> <1374569897-3858-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-8-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/13 09:58, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Milo Kim <milo.kim@ti.com>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/adc/lp8788_adc.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
> index 62bc39e..5c8c915 100644
> --- a/drivers/iio/adc/lp8788_adc.c
> +++ b/drivers/iio/adc/lp8788_adc.c
> @@ -194,7 +194,7 @@ static int lp8788_adc_probe(struct platform_device *pdev)
>  	struct lp8788_adc *adc;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*adc));
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -205,7 +205,7 @@ static int lp8788_adc_probe(struct platform_device *pdev)
>  	indio_dev->dev.of_node = pdev->dev.of_node;
>  	ret = lp8788_iio_map_register(indio_dev, lp->pdata, adc);
>  	if (ret)
> -		goto err_iio_map;
> +		return ret;
>  
>  	mutex_init(&adc->lock);
>  
> @@ -226,8 +226,6 @@ static int lp8788_adc_probe(struct platform_device *pdev)
>  
>  err_iio_device:
>  	iio_map_array_unregister(indio_dev);
> -err_iio_map:
> -	iio_device_free(indio_dev);
>  	return ret;
>  }
>  
> @@ -237,7 +235,6 @@ static int lp8788_adc_remove(struct platform_device *pdev)
>  
>  	iio_device_unregister(indio_dev);
>  	iio_map_array_unregister(indio_dev);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
