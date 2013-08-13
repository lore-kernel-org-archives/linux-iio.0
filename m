Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56980 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759005Ab3HMRhK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2013 13:37:10 -0400
Message-ID: <520A7CD4.30808@kernel.org>
Date: Tue, 13 Aug 2013 19:37:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 4/9] iio: gyro: adis16260: Use devm_iio_device_alloc
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org> <1376375675-11595-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-4-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/13/13 07:34, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied.
(getting lazy with my messages.  One day I'll get around to automating them automate them).
> ---
>  drivers/iio/gyro/adis16260.c |   16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> index b4cf800..0654116 100644
> --- a/drivers/iio/gyro/adis16260.c
> +++ b/drivers/iio/gyro/adis16260.c
> @@ -343,11 +343,9 @@ static int adis16260_probe(struct spi_device *spi)
>  	int ret;
>  
>  	/* setup the industrialio driver allocated elements */
> -	indio_dev = iio_device_alloc(sizeof(*adis));
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adis));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  	adis = iio_priv(indio_dev);
>  	/* this is only used for removal purposes */
>  	spi_set_drvdata(spi, indio_dev);
> @@ -361,11 +359,11 @@ static int adis16260_probe(struct spi_device *spi)
>  
>  	ret = adis_init(adis, indio_dev, spi, &adis16260_data);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	ret = adis_setup_buffer_and_trigger(adis, indio_dev, NULL);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	/* Get the device into a sane initial state */
>  	ret = adis_initial_startup(adis);
> @@ -379,9 +377,6 @@ static int adis16260_probe(struct spi_device *spi)
>  
>  error_cleanup_buffer_trigger:
>  	adis_cleanup_buffer_and_trigger(adis, indio_dev);
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
>  	return ret;
>  }
>  
> @@ -393,7 +388,6 @@ static int adis16260_remove(struct spi_device *spi)
>  	iio_device_unregister(indio_dev);
>  	adis16260_stop_device(indio_dev);
>  	adis_cleanup_buffer_and_trigger(adis, indio_dev);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
