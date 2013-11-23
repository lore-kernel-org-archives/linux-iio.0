Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56165 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab3KWMoS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 07:44:18 -0500
Message-ID: <5290B177.5020202@kernel.org>
Date: Sat, 23 Nov 2013 13:45:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 12/33] iio: gyro: adxrs450: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-13-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-13-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

There is a suspicious ordering in the probe. I would expect the device
to be in a sane state before the being exposed to userspace.

Lars, could you follow this up?

thanks
> ---
>  drivers/iio/gyro/adxrs450.c |   14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
> index 1e546ba..eb0e08e 100644
> --- a/drivers/iio/gyro/adxrs450.c
> +++ b/drivers/iio/gyro/adxrs450.c
> @@ -434,23 +434,14 @@ static int adxrs450_probe(struct spi_device *spi)
>  	indio_dev->num_channels = ARRAY_SIZE(adxrs450_channels);
>  	indio_dev->name = spi->dev.driver->name;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
>  		return ret;
>  
>  	/* Get the device into a sane initial state */
>  	ret = adxrs450_initial_setup(indio_dev);
>  	if (ret)
> -		goto error_initial;
> -	return 0;
> -error_initial:
> -	iio_device_unregister(indio_dev);
> -	return ret;
> -}
> -
> -static int adxrs450_remove(struct spi_device *spi)
> -{
> -	iio_device_unregister(spi_get_drvdata(spi));
> +		return ret;
>  
>  	return 0;
>  }
> @@ -468,7 +459,6 @@ static struct spi_driver adxrs450_driver = {
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = adxrs450_probe,
> -	.remove = adxrs450_remove,
>  	.id_table	= adxrs450_id,
>  };
>  module_spi_driver(adxrs450_driver);
> 
