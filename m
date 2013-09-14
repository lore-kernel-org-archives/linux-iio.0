Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39691 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab3INJvm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:51:42 -0400
Message-ID: <52343FCC.4000608@kernel.org>
Date: Sat, 14 Sep 2013 11:51:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Graff Yang <graff.yang@gmail.com>
Subject: Re: [PATCH 04/10] staging: iio: ad2s1210: Use devm_iio_device_alloc
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org> <1378893325-31764-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-4-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 10:55, Sachin Kamat wrote:
> devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Graff Yang <graff.yang@gmail.com>
Applied
> ---
>  drivers/staging/iio/resolver/ad2s1210.c |   14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 2b0c8e5..6966d5f 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -669,16 +669,14 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	if (spi->dev.platform_data == NULL)
>  		return -EINVAL;
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  	st = iio_priv(indio_dev);
>  	st->pdata = spi->dev.platform_data;
>  	ret = ad2s1210_setup_gpios(st);
>  	if (ret < 0)
> -		goto error_free_dev;
> +		return ret;
>  
>  	spi_set_drvdata(spi, indio_dev);
>  
> @@ -709,9 +707,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  
>  error_free_gpios:
>  	ad2s1210_free_gpios(st);
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
>  	return ret;
>  }
>  
> @@ -721,7 +716,6 @@ static int ad2s1210_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	ad2s1210_free_gpios(iio_priv(indio_dev));
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
