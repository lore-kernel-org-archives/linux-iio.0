Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39185 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab3HCTBi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 15:01:38 -0400
Message-ID: <51FD61AA.7090805@kernel.org>
Date: Sat, 03 Aug 2013 21:01:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: Re: [PATCH 2/3] iio: frequency: ad9523: Use devm_* APIs
References: <1375165463-23453-1-git-send-email-sachin.kamat@linaro.org> <1375165463-23453-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375165463-23453-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/13 07:24, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/frequency/ad9523.c |   17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
> index 92276de..7c5245d 100644
> --- a/drivers/iio/frequency/ad9523.c
> +++ b/drivers/iio/frequency/ad9523.c
> @@ -961,17 +961,17 @@ static int ad9523_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
>  
> -	st->reg = regulator_get(&spi->dev, "vcc");
> +	st->reg = devm_regulator_get(&spi->dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
> -			goto error_put_reg;
> +			return ret;
>  	}
>  
>  	spi_set_drvdata(spi, indio_dev);
> @@ -1001,11 +1001,6 @@ static int ad9523_probe(struct spi_device *spi)
>  error_disable_reg:
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> -error_put_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_put(st->reg);
> -
> -	iio_device_free(indio_dev);
>  
>  	return ret;
>  }
> @@ -1017,12 +1012,8 @@ static int ad9523_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	if (!IS_ERR(st->reg)) {
> +	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> -		regulator_put(st->reg);
> -	}
> -
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
