Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58843 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517Ab3KWRQE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:16:04 -0500
Message-ID: <5290F129.1080206@kernel.org>
Date: Sat, 23 Nov 2013 18:17:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 22/33] staging: iio: ad9852: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-23-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-23-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
This one has a power down mode that should be called afterwards.
Also the probe is clearly in an 'interesting' order so lets leave it alone for now.

> ---
>  drivers/staging/iio/frequency/ad9852.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9852.c b/drivers/staging/iio/frequency/ad9852.c
> index 11e4367..af2f2cc 100644
> --- a/drivers/staging/iio/frequency/ad9852.c
> +++ b/drivers/staging/iio/frequency/ad9852.c
> @@ -218,7 +218,7 @@ static int ad9852_probe(struct spi_device *spi)
>  	idev->info = &ad9852_info;
>  	idev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_device_register(idev);
> +	ret = devm_iio_device_register(&spi->dev, idev);
>  	if (ret)
>  		return ret;
>  	spi->max_speed_hz = 2000000;
> @@ -230,20 +230,12 @@ static int ad9852_probe(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static int ad9852_remove(struct spi_device *spi)
> -{
> -	iio_device_unregister(spi_get_drvdata(spi));
> -
> -	return 0;
> -}
> -
>  static struct spi_driver ad9852_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = ad9852_probe,
> -	.remove = ad9852_remove,
>  };
>  module_spi_driver(ad9852_driver);
>  
> 
