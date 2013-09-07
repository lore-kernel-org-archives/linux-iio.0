Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58156 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab3IGUDS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2013 16:03:18 -0400
Message-ID: <522B949F.6070008@kernel.org>
Date: Sat, 07 Sep 2013 22:03:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 07/12] staging: iio: ad9852: Use devm_iio_device_alloc
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org> <1378373397-22919-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-7-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/13 10:29, Sachin Kamat wrote:
> devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied
> ---
>  drivers/staging/iio/frequency/ad9852.c |   17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9852.c b/drivers/staging/iio/frequency/ad9852.c
> index 1344031..4be2cf8 100644
> --- a/drivers/staging/iio/frequency/ad9852.c
> +++ b/drivers/staging/iio/frequency/ad9852.c
> @@ -229,11 +229,9 @@ static int ad9852_probe(struct spi_device *spi)
>  	struct iio_dev *idev;
>  	int ret = 0;
>  
> -	idev = iio_device_alloc(sizeof(*st));
> -	if (idev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	idev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!idev)
> +		return -ENOMEM;
>  	st = iio_priv(idev);
>  	spi_set_drvdata(spi, idev);
>  	mutex_init(&st->lock);
> @@ -245,7 +243,7 @@ static int ad9852_probe(struct spi_device *spi)
>  
>  	ret = iio_device_register(idev);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  	spi->max_speed_hz = 2000000;
>  	spi->mode = SPI_MODE_3;
>  	spi->bits_per_word = 8;
> @@ -253,18 +251,11 @@ static int ad9852_probe(struct spi_device *spi)
>  	ad9852_init(st);
>  
>  	return 0;
> -
> -error_free_dev:
> -	iio_device_free(idev);
> -
> -error_ret:
> -	return ret;
>  }
>  
>  static int ad9852_remove(struct spi_device *spi)
>  {
>  	iio_device_unregister(spi_get_drvdata(spi));
> -	iio_device_free(spi_get_drvdata(spi));
>  
>  	return 0;
>  }
> 
