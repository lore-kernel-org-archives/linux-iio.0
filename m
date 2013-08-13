Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57178 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756819Ab3HMRmh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2013 13:42:37 -0400
Message-ID: <520A7E1B.60805@kernel.org>
Date: Tue, 13 Aug 2013 19:42:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 9/9] iio: gyro: adis16060_core: Use devm_iio_device_alloc
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org> <1376375675-11595-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-9-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/13/13 07:34, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks again for doing all these.

Jonathan
> ---
>  drivers/staging/iio/gyro/adis16060_core.c |   17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
> index c67d3a8..6d3d771 100644
> --- a/drivers/staging/iio/gyro/adis16060_core.c
> +++ b/drivers/staging/iio/gyro/adis16060_core.c
> @@ -151,11 +151,9 @@ static int adis16060_r_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  
>  	/* setup the industrialio driver allocated elements */
> -	indio_dev = iio_device_alloc(sizeof(*st));
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  	/* this is only used for removal purposes */
>  	spi_set_drvdata(spi, indio_dev);
>  	st = iio_priv(indio_dev);
> @@ -171,23 +169,16 @@ static int adis16060_r_probe(struct spi_device *spi)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	adis16060_iio_dev = indio_dev;
>  	return 0;
> -
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
> -	return ret;
>  }
>  
>  /* fixme, confirm ordering in this function */
>  static int adis16060_r_remove(struct spi_device *spi)
>  {
>  	iio_device_unregister(spi_get_drvdata(spi));
> -	iio_device_free(spi_get_drvdata(spi));
> -
>  	return 0;
>  }
>  
> 
