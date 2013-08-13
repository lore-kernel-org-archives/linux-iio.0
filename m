Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56935 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758856Ab3HMRfW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2013 13:35:22 -0400
Message-ID: <520A7C68.1010007@kernel.org>
Date: Tue, 13 Aug 2013 19:35:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/9] iio: gyro: adis16136: Use devm_iio_device_alloc
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org> <1376375675-11595-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-3-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/13/13 07:34, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/iio/gyro/adis16136.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index 058e6d5..591bd55 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -497,7 +497,7 @@ static int adis16136_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*adis16136));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adis16136));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
> @@ -515,11 +515,11 @@ static int adis16136_probe(struct spi_device *spi)
>  
>  	ret = adis_init(&adis16136->adis, indio_dev, spi, &adis16136_data);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	ret = adis_setup_buffer_and_trigger(&adis16136->adis, indio_dev, NULL);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	ret = adis16136_initial_setup(indio_dev);
>  	if (ret)
> @@ -537,8 +537,6 @@ error_stop_device:
>  	adis16136_stop_device(indio_dev);
>  error_cleanup_buffer:
>  	adis_cleanup_buffer_and_trigger(&adis16136->adis, indio_dev);
> -error_free_dev:
> -	iio_device_free(indio_dev);
>  	return ret;
>  }
>  
> @@ -552,8 +550,6 @@ static int adis16136_remove(struct spi_device *spi)
>  
>  	adis_cleanup_buffer_and_trigger(&adis16136->adis, indio_dev);
>  
> -	iio_device_free(indio_dev);
> -
>  	return 0;
>  }
>  
> 
