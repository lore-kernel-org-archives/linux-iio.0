Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53192 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3G0KKj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:10:39 -0400
Message-ID: <51F3AAAE.8060103@kernel.org>
Date: Sat, 27 Jul 2013 12:10:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH 11/11] iio: adc: viperboard_adc: Use devm_iio_device_alloc
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org> <1374569897-3858-12-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-12-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/13 09:58, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lars Poeschel <poeschel@lemonage.de>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/adc/viperboard_adc.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
> index 56ac481..09727a7 100644
> --- a/drivers/iio/adc/viperboard_adc.c
> +++ b/drivers/iio/adc/viperboard_adc.c
> @@ -124,7 +124,7 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
>  	int ret;
>  
>  	/* registering iio */
> -	indio_dev = iio_device_alloc(sizeof(*adc));
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
>  	if (!indio_dev) {
>  		dev_err(&pdev->dev, "failed allocating iio device\n");
>  		return -ENOMEM;
> @@ -142,16 +142,12 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "could not register iio (adc)");
> -		goto error;
> +		return ret;
>  	}
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	return 0;
> -
> -error:
> -	iio_device_free(indio_dev);
> -	return ret;
>  }
>  
>  static int vprbrd_adc_remove(struct platform_device *pdev)
> @@ -159,7 +155,6 @@ static int vprbrd_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  
>  	iio_device_unregister(indio_dev);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
