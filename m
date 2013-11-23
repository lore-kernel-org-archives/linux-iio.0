Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55940 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab3KWMaj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 07:30:39 -0500
Message-ID: <5290AE44.9070105@kernel.org>
Date: Sat, 23 Nov 2013 13:31:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 06/33] iio: adc: viperboard: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-7-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
This one is fine.

Applied to the togreg branch of iio.git

Thanks.
> ---
>  drivers/iio/adc/viperboard_adc.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
> index 09727a7..674b333 100644
> --- a/drivers/iio/adc/viperboard_adc.c
> +++ b/drivers/iio/adc/viperboard_adc.c
> @@ -139,7 +139,7 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
>  	indio_dev->channels = vprbrd_adc_iio_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(vprbrd_adc_iio_channels);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "could not register iio (adc)");
>  		return ret;
> @@ -150,22 +150,12 @@ static int vprbrd_adc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int vprbrd_adc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
>  static struct platform_driver vprbrd_adc_driver = {
>  	.driver = {
>  		.name	= "viperboard-adc",
>  		.owner	= THIS_MODULE,
>  	},
>  	.probe		= vprbrd_adc_probe,
> -	.remove		= vprbrd_adc_remove,
>  };
>  
>  module_platform_driver(vprbrd_adc_driver);
> 
