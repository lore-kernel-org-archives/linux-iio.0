Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53127 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab3HSSZh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 14:25:37 -0400
Message-ID: <52127132.7000600@kernel.org>
Date: Mon, 19 Aug 2013 20:25:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de, jic23@cam.ac.uk
Subject: Re: [PATCH 05/14] iio: dac: ad5446: Use devm_* APIs
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org> <1376912305-6423-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-5-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/19/13 12:38, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/dac/ad5446.c |   19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index cae8f60..96e9ed4 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -220,11 +220,11 @@ static int ad5446_probe(struct device *dev, const char *name,
>  	struct regulator *reg;
>  	int ret, voltage_uv = 0;
>  
> -	reg = regulator_get(dev, "vcc");
> +	reg = devm_regulator_get(dev, "vcc");
>  	if (!IS_ERR(reg)) {
>  		ret = regulator_enable(reg);
>  		if (ret)
> -			goto error_put_reg;
> +			return ret;
>  
>  		ret = regulator_get_voltage(reg);
>  		if (ret < 0)
> @@ -233,7 +233,7 @@ static int ad5446_probe(struct device *dev, const char *name,
>  		voltage_uv = ret;
>  	}
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (indio_dev == NULL) {
>  		ret = -ENOMEM;
>  		goto error_disable_reg;
> @@ -264,19 +264,13 @@ static int ad5446_probe(struct device *dev, const char *name,
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
> -
>  	return ret;
>  }
>  
> @@ -286,11 +280,8 @@ static int ad5446_remove(struct device *dev)
>  	struct ad5446_state *st = iio_priv(indio_dev);
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
