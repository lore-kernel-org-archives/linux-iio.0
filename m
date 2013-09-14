Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39736 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab3INJ4Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:56:25 -0400
Message-ID: <523440E7.2060700@kernel.org>
Date: Sat, 14 Sep 2013 11:56:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 06/10] staging: iio: ade7753: Use devm_iio_device_alloc
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org> <1378893325-31764-6-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-6-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 10:55, Sachin Kamat wrote:
> devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Barry Song <21cnbao@gmail.com>
applied
> ---
>  drivers/staging/iio/meter/ade7753.c |   19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index f0bba33..6200335 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -497,11 +497,9 @@ static int ade7753_probe(struct spi_device *spi)
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
> @@ -517,19 +515,13 @@ static int ade7753_probe(struct spi_device *spi)
>  	/* Get the device into a sane initial state */
>  	ret = ade7753_initial_setup(indio_dev);
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
> -
> -error_ret:
> -	return ret;
>  }
>  
>  /* fixme, confirm ordering in this function */
> @@ -539,7 +531,6 @@ static int ade7753_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	ade7753_stop_device(&indio_dev->dev);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
