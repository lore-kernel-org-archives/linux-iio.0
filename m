Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58137 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3IGUCI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2013 16:02:08 -0400
Message-ID: <522B9459.9090701@kernel.org>
Date: Sat, 07 Sep 2013 22:02:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 05/12] staging: iio: ad9834: Use devm_* APIs
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org> <1378373397-22919-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-5-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/13 10:29, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/frequency/ad9834.c |   29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 5cba3c0..2562b22 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -327,14 +327,14 @@ static int ad9834_probe(struct spi_device *spi)
>  		return -ENODEV;
>  	}
>  
> -	reg = regulator_get(&spi->dev, "vcc");
> +	reg = devm_regulator_get(&spi->dev, "vcc");
>  	if (!IS_ERR(reg)) {
>  		ret = regulator_enable(reg);
>  		if (ret)
> -			goto error_put_reg;
> +			return ret;
>  	}
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (indio_dev == NULL) {
>  		ret = -ENOMEM;
>  		goto error_disable_reg;
> @@ -388,39 +388,35 @@ static int ad9834_probe(struct spi_device *spi)
>  	ret = spi_sync(st->spi, &st->msg);
>  	if (ret) {
>  		dev_err(&spi->dev, "device init failed\n");
> -		goto error_free_device;
> +		goto error_disable_reg;
>  	}
>  
>  	ret = ad9834_write_frequency(st, AD9834_REG_FREQ0, pdata->freq0);
>  	if (ret)
> -		goto error_free_device;
> +		goto error_disable_reg;
>  
>  	ret = ad9834_write_frequency(st, AD9834_REG_FREQ1, pdata->freq1);
>  	if (ret)
> -		goto error_free_device;
> +		goto error_disable_reg;
>  
>  	ret = ad9834_write_phase(st, AD9834_REG_PHASE0, pdata->phase0);
>  	if (ret)
> -		goto error_free_device;
> +		goto error_disable_reg;
>  
>  	ret = ad9834_write_phase(st, AD9834_REG_PHASE1, pdata->phase1);
>  	if (ret)
> -		goto error_free_device;
> +		goto error_disable_reg;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_device;
> +		goto error_disable_reg;
>  
>  	return 0;
>  
> -error_free_device:
> -	iio_device_free(indio_dev);
>  error_disable_reg:
>  	if (!IS_ERR(reg))
>  		regulator_disable(reg);
> -error_put_reg:
> -	if (!IS_ERR(reg))
> -		regulator_put(reg);
> +
>  	return ret;
>  }
>  
> @@ -430,11 +426,8 @@ static int ad9834_remove(struct spi_device *spi)
>  	struct ad9834_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (!IS_ERR(st->reg)) {
> +	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> -		regulator_put(st->reg);
> -	}
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
