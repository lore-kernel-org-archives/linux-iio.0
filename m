Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39619 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab3INJqd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:46:33 -0400
Message-ID: <52343E97.3010400@kernel.org>
Date: Sat, 14 Sep 2013 11:46:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Graff Yang <graff.yang@gmail.com>
Subject: Re: [PATCH 02/10] staging: iio: ad2s1200: Use devm_* APIs
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org> <1378893325-31764-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 10:55, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> This patch also fixes the missing gpio_free call in remove.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Graff Yang <graff.yang@gmail.com>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/resolver/ad2s1200.c |   24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 7122116..76f6d65 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -107,16 +107,16 @@ static int ad2s1200_probe(struct spi_device *spi)
>  	unsigned short *pins = spi->dev.platform_data;
>  
>  	for (pn = 0; pn < AD2S1200_PN; pn++)
> -		if (gpio_request_one(pins[pn], GPIOF_DIR_OUT, DRV_NAME)) {
> +		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
> +					    DRV_NAME);
> +		if (ret) {
>  			pr_err("%s: request gpio pin %d failed\n",
>  						DRV_NAME, pins[pn]);
> -			goto error_ret;
> +			return ret;
>  		}
> -	indio_dev = iio_device_alloc(sizeof(*st));
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  	spi_set_drvdata(spi, indio_dev);
>  	st = iio_priv(indio_dev);
>  	mutex_init(&st->lock);
> @@ -133,26 +133,18 @@ static int ad2s1200_probe(struct spi_device *spi)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	spi->max_speed_hz = AD2S1200_HZ;
>  	spi->mode = SPI_MODE_3;
>  	spi_setup(spi);
>  
>  	return 0;
> -
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
> -	for (--pn; pn >= 0; pn--)
> -		gpio_free(pins[pn]);
> -	return ret;
>  }
>  
>  static int ad2s1200_remove(struct spi_device *spi)
>  {
>  	iio_device_unregister(spi_get_drvdata(spi));
> -	iio_device_free(spi_get_drvdata(spi));
>  
>  	return 0;
>  }
> 
