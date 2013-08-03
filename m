Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38219 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab3HCQtO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 12:49:14 -0400
Message-ID: <51FD42A1.4020905@kernel.org>
Date: Sat, 03 Aug 2013 18:49:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: [PATCH 1/6] iio: imu: adis16400: Use devm_iio_device_alloc
References: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375173868-13235-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/13 09:44, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Applied to the togreg branch of iio.git.  Thanks

Jonathan
> ---
> This series compile tested on togreg branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> ---
>  drivers/iio/imu/adis16400_core.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index f60591f..3fb7757 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -871,7 +871,7 @@ static int adis16400_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
> @@ -893,12 +893,12 @@ static int adis16400_probe(struct spi_device *spi)
>  
>  	ret = adis_init(&st->adis, indio_dev, spi, &adis16400_data);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	ret = adis_setup_buffer_and_trigger(&st->adis, indio_dev,
>  			adis16400_trigger_handler);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	/* Get the device into a sane initial state */
>  	ret = adis16400_initial_setup(indio_dev);
> @@ -913,8 +913,6 @@ static int adis16400_probe(struct spi_device *spi)
>  
>  error_cleanup_buffer:
>  	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
> -error_free_dev:
> -	iio_device_free(indio_dev);
>  	return ret;
>  }
>  
> @@ -928,8 +926,6 @@ static int adis16400_remove(struct spi_device *spi)
>  
>  	adis_cleanup_buffer_and_trigger(&st->adis, indio_dev);
>  
> -	iio_device_free(indio_dev);
> -
>  	return 0;
>  }
>  
> 
