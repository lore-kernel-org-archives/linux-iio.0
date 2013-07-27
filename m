Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53610 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab3G0KsP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:48:15 -0400
Message-ID: <51F3B381.9030208@kernel.org>
Date: Sat, 27 Jul 2013 12:48:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, rachna@ti.com
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: Use devm_iio_device_alloc
References: <1374569212-26143-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569212-26143-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/13 09:46, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Rachna Patil <rachna@ti.com>
Applied to the togreg branch of iio.git.

Thanks
> ---
>  drivers/iio/adc/ti_am335x_adc.c |   13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 4427e8e..a2bf109 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -201,11 +201,11 @@ static int tiadc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	indio_dev = iio_device_alloc(sizeof(struct tiadc_device));
> +	indio_dev = devm_iio_device_alloc(&pdev->dev,
> +					  sizeof(struct tiadc_device));
>  	if (indio_dev == NULL) {
>  		dev_err(&pdev->dev, "failed to allocate iio device\n");
> -		err = -ENOMEM;
> -		goto err_ret;
> +		return -ENOMEM;
>  	}
>  	adc_dev = iio_priv(indio_dev);
>  
> @@ -226,7 +226,7 @@ static int tiadc_probe(struct platform_device *pdev)
>  
>  	err = tiadc_channel_init(indio_dev, adc_dev->channels);
>  	if (err < 0)
> -		goto err_free_device;
> +		return err;
>  
>  	err = iio_device_register(indio_dev);
>  	if (err)
> @@ -238,9 +238,6 @@ static int tiadc_probe(struct platform_device *pdev)
>  
>  err_free_channels:
>  	tiadc_channels_remove(indio_dev);
> -err_free_device:
> -	iio_device_free(indio_dev);
> -err_ret:
>  	return err;
>  }
>  
> @@ -256,8 +253,6 @@ static int tiadc_remove(struct platform_device *pdev)
>  	step_en = get_adc_step_mask(adc_dev);
>  	am335x_tsc_se_clr(adc_dev->mfd_tscadc, step_en);
>  
> -	iio_device_free(indio_dev);
> -
>  	return 0;
>  }
>  
> 
