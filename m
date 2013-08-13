Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57010 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759030Ab3HMRiS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2013 13:38:18 -0400
Message-ID: <520A7D17.4030304@kernel.org>
Date: Tue, 13 Aug 2013 19:38:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 5/9] iio: gyro: adxrs450: Use devm_iio_device_alloc
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org> <1376375675-11595-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-5-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/13/13 07:34, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied.
> ---
>  drivers/iio/gyro/adxrs450.c |   15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
> index 8bd72b4..6dab299 100644
> --- a/drivers/iio/gyro/adxrs450.c
> +++ b/drivers/iio/gyro/adxrs450.c
> @@ -426,11 +426,9 @@ static int adxrs450_probe(struct spi_device *spi)
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
>  	st = iio_priv(indio_dev);
>  	st->us = spi;
>  	mutex_init(&st->buf_lock);
> @@ -447,7 +445,7 @@ static int adxrs450_probe(struct spi_device *spi)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	/* Get the device into a sane initial state */
>  	ret = adxrs450_initial_setup(indio_dev);
> @@ -456,17 +454,12 @@ static int adxrs450_probe(struct spi_device *spi)
>  	return 0;
>  error_initial:
>  	iio_device_unregister(indio_dev);
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -
> -error_ret:
>  	return ret;
>  }
>  
>  static int adxrs450_remove(struct spi_device *spi)
>  {
>  	iio_device_unregister(spi_get_drvdata(spi));
> -	iio_device_free(spi_get_drvdata(spi));
>  
>  	return 0;
>  }
> 
