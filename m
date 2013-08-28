Return-Path: <jic23@kernel.org>
Message-ID: <521E4DAB.1090403@kernel.org>
Date: Wed, 28 Aug 2013 20:21:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk, lars@metafoo.de
Subject: Re: [PATCH 1/8] staging: iio: adis16201: Use devm_iio_device_alloc
References: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/24/13 19:48, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
All 8 patches in this series applied.

Thanks for all your work on these!

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201_core.c |   17 ++++++-----------
>  1 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
> index ab8ec7a..2105576 100644
> --- a/drivers/staging/iio/accel/adis16201_core.c
> +++ b/drivers/staging/iio/accel/adis16201_core.c
> @@ -182,11 +182,10 @@ static int adis16201_probe(struct spi_device *spi)
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
> +
>  	st = iio_priv(indio_dev);
>  	/* this is only used for removal purposes */
>  	spi_set_drvdata(spi, indio_dev);
> @@ -201,10 +200,10 @@ static int adis16201_probe(struct spi_device *spi)
>  
>  	ret = adis_init(st, indio_dev, spi, &adis16201_data);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	/* Get the device into a sane initial state */
>  	ret = adis_initial_startup(st);
> @@ -218,9 +217,6 @@ static int adis16201_probe(struct spi_device *spi)
>  
>  error_cleanup_buffer_trigger:
>  	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
>  	return ret;
>  }
>  
> @@ -231,7 +227,6 @@ static int adis16201_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	adis_cleanup_buffer_and_trigger(st, indio_dev);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
