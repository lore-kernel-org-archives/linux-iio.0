Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55830 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab3KWMZW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 07:25:22 -0500
Message-ID: <5290AD01.2060203@kernel.org>
Date: Sat, 23 Nov 2013 13:26:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de, Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Subject: Re: [PATCH 05/33] iio: adc: twl6030-gpadc: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-6-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Hmm.. Interesting case, but I suspect a bug is hiding in the original driver.
Would definitely expect the unregister to be before the disable_irq.
> ---
>  drivers/iio/adc/twl6030-gpadc.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index 53e1c64..d1ef33c 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -948,15 +948,12 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  	indio_dev->channels = pdata->iio_channels;
>  	indio_dev->num_channels = pdata->nchannels;
>  
> -	return iio_device_register(indio_dev);
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
>  }
>  
>  static int twl6030_gpadc_remove(struct platform_device *pdev)
>  {
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> -
>  	twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
> -	iio_device_unregister(indio_dev);
>  
>  	return 0;
>  }
> 
