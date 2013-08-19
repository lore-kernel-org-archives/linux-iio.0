Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53304 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab3HSSfj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 14:35:39 -0400
Message-ID: <5212738C.9010305@kernel.org>
Date: Mon, 19 Aug 2013 20:35:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de, jic23@cam.ac.uk
Subject: Re: [PATCH 12/14] iio: dac: ad5791: Use devm_* APIs
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org> <1376912305-6423-12-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-12-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/19/13 12:38, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/dac/ad5791.c |   35 +++++++++--------------------------
>  1 file changed, 9 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index 97c1e5d..ce74589 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -349,17 +349,15 @@ static int ad5791_probe(struct spi_device *spi)
>  	struct ad5791_state *st;
>  	int ret, pos_voltage_uv = 0, neg_voltage_uv = 0;
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
> -	st->reg_vdd = regulator_get(&spi->dev, "vdd");
> +	st->reg_vdd = devm_regulator_get(&spi->dev, "vdd");
>  	if (!IS_ERR(st->reg_vdd)) {
>  		ret = regulator_enable(st->reg_vdd);
>  		if (ret)
> -			goto error_put_reg_pos;
> +			return ret;
>  
>  		ret = regulator_get_voltage(st->reg_vdd);
>  		if (ret < 0)
> @@ -368,11 +366,11 @@ static int ad5791_probe(struct spi_device *spi)
>  		pos_voltage_uv = ret;
>  	}
>  
> -	st->reg_vss = regulator_get(&spi->dev, "vss");
> +	st->reg_vss = devm_regulator_get(&spi->dev, "vss");
>  	if (!IS_ERR(st->reg_vss)) {
>  		ret = regulator_enable(st->reg_vss);
>  		if (ret)
> -			goto error_put_reg_neg;
> +			goto error_disable_reg_pos;
>  
>  		ret = regulator_get_voltage(st->reg_vss);
>  		if (ret < 0)
> @@ -428,19 +426,9 @@ static int ad5791_probe(struct spi_device *spi)
>  error_disable_reg_neg:
>  	if (!IS_ERR(st->reg_vss))
>  		regulator_disable(st->reg_vss);
> -error_put_reg_neg:
> -	if (!IS_ERR(st->reg_vss))
> -		regulator_put(st->reg_vss);
> -
>  error_disable_reg_pos:
>  	if (!IS_ERR(st->reg_vdd))
>  		regulator_disable(st->reg_vdd);
> -error_put_reg_pos:
> -	if (!IS_ERR(st->reg_vdd))
> -		regulator_put(st->reg_vdd);
> -	iio_device_free(indio_dev);
> -error_ret:
> -
>  	return ret;
>  }
>  
> @@ -450,16 +438,11 @@ static int ad5791_remove(struct spi_device *spi)
>  	struct ad5791_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	if (!IS_ERR(st->reg_vdd)) {
> +	if (!IS_ERR(st->reg_vdd))
>  		regulator_disable(st->reg_vdd);
> -		regulator_put(st->reg_vdd);
> -	}
>  
> -	if (!IS_ERR(st->reg_vss)) {
> +	if (!IS_ERR(st->reg_vss))
>  		regulator_disable(st->reg_vss);
> -		regulator_put(st->reg_vss);
> -	}
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
