Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39756 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab3INJ4u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:56:50 -0400
Message-ID: <523440FF.6080900@kernel.org>
Date: Sat, 14 Sep 2013 11:57:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 09/10] staging: iio: ade7759: Use devm_iio_device_alloc
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org> <1378893325-31764-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-9-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 10:55, Sachin Kamat wrote:
> devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Barry Song <21cnbao@gmail.com>
Applied to the togreg branch of iio.git
> ---
>  drivers/staging/iio/meter/ade7759.c |   18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
> index c1a3a5d..145f896 100644
> --- a/drivers/staging/iio/meter/ade7759.c
> +++ b/drivers/staging/iio/meter/ade7759.c
> @@ -444,11 +444,9 @@ static int ade7759_probe(struct spi_device *spi)
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
>  
> @@ -463,18 +461,13 @@ static int ade7759_probe(struct spi_device *spi)
>  	/* Get the device into a sane initial state */
>  	ret = ade7759_initial_setup(indio_dev);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	return 0;
> -
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
> -	return ret;
>  }
>  
>  /* fixme, confirm ordering in this function */
> @@ -484,7 +477,6 @@ static int ade7759_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	ade7759_stop_device(&indio_dev->dev);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
