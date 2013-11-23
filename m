Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58790 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346Ab3KWRM5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:12:57 -0500
Message-ID: <5290F06E.1060101@kernel.org>
Date: Sat, 23 Nov 2013 18:14:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 20/33] staging: iio: ad5930: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-21-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-21-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Another device with a power down mode that I'd expect to see called.
I supose for output devices one might just leave them running in
an uncontrolled fashion, but that ought to be configurable.


> ---
>  drivers/staging/iio/frequency/ad5930.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad5930.c b/drivers/staging/iio/frequency/ad5930.c
> index a4aeee6..662cfb9 100644
> --- a/drivers/staging/iio/frequency/ad5930.c
> +++ b/drivers/staging/iio/frequency/ad5930.c
> @@ -106,7 +106,7 @@ static int ad5930_probe(struct spi_device *spi)
>  	idev->info = &ad5930_info;
>  	idev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_device_register(idev);
> +	ret = devm_iio_device_register(&spi->dev, idev);
>  	if (ret)
>  		return ret;
>  	spi->max_speed_hz = 2000000;
> @@ -117,20 +117,12 @@ static int ad5930_probe(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static int ad5930_remove(struct spi_device *spi)
> -{
> -	iio_device_unregister(spi_get_drvdata(spi));
> -
> -	return 0;
> -}
> -
>  static struct spi_driver ad5930_driver = {
>  	.driver = {
>  		.name = DRV_NAME,
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = ad5930_probe,
> -	.remove = ad5930_remove,
>  };
>  module_spi_driver(ad5930_driver);
>  
> 
