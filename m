Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56142 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab3KWMmk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 07:42:40 -0500
Message-ID: <5290B115.3040106@kernel.org>
Date: Sat, 23 Nov 2013 13:43:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 11/33] iio: gyro: adis16130: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-12-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-12-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Suprisingly, this device doesn't seem to have any low power mode
or similar, hence applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/iio/gyro/adis16130.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
> index 445c2ae..8d08c7e 100644
> --- a/drivers/iio/gyro/adis16130.c
> +++ b/drivers/iio/gyro/adis16130.c
> @@ -161,13 +161,7 @@ static int adis16130_probe(struct spi_device *spi)
>  	indio_dev->info = &adis16130_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int adis16130_remove(struct spi_device *spi)
> -{
> -	iio_device_unregister(spi_get_drvdata(spi));
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static struct spi_driver adis16130_driver = {
> @@ -176,7 +170,6 @@ static struct spi_driver adis16130_driver = {
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = adis16130_probe,
> -	.remove = adis16130_remove,
>  };
>  module_spi_driver(adis16130_driver);
>  
> 
