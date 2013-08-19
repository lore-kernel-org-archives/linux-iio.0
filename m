Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53328 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3HSSgo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 14:36:44 -0400
Message-ID: <521273CD.3010000@kernel.org>
Date: Mon, 19 Aug 2013 20:36:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de, jic23@cam.ac.uk
Subject: Re: [PATCH 13/14] iio: dac: ad7303: Use devm_* APIs
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org> <1376912305-6423-13-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-13-git-send-email-sachin.kamat@linaro.org>
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
>  drivers/iio/dac/ad7303.c |   31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index d546f50..ed2d276 100644
> --- a/drivers/iio/dac/ad7303.c
> +++ b/drivers/iio/dac/ad7303.c
> @@ -203,7 +203,7 @@ static int ad7303_probe(struct spi_device *spi)
>  	bool ext_ref;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  
> @@ -212,15 +212,13 @@ static int ad7303_probe(struct spi_device *spi)
>  
>  	st->spi = spi;
>  
> -	st->vdd_reg = regulator_get(&spi->dev, "Vdd");
> -	if (IS_ERR(st->vdd_reg)) {
> -		ret = PTR_ERR(st->vdd_reg);
> -		goto err_free;
> -	}
> +	st->vdd_reg = devm_regulator_get(&spi->dev, "Vdd");
> +	if (IS_ERR(st->vdd_reg))
> +		return PTR_ERR(st->vdd_reg);
>  
>  	ret = regulator_enable(st->vdd_reg);
>  	if (ret)
> -		goto err_put_vdd_reg;
> +		return ret;
>  
>  	if (spi->dev.of_node) {
>  		ext_ref = of_property_read_bool(spi->dev.of_node,
> @@ -234,7 +232,7 @@ static int ad7303_probe(struct spi_device *spi)
>  	}
>  
>  	if (ext_ref) {
> -		st->vref_reg = regulator_get(&spi->dev, "REF");
> +		st->vref_reg = devm_regulator_get(&spi->dev, "REF");
>  		if (IS_ERR(st->vref_reg)) {
>  			ret = PTR_ERR(st->vref_reg);
>  			goto err_disable_vdd_reg;
> @@ -242,7 +240,7 @@ static int ad7303_probe(struct spi_device *spi)
>  
>  		ret = regulator_enable(st->vref_reg);
>  		if (ret)
> -			goto err_put_vref_reg;
> +			goto err_disable_vdd_reg;
>  
>  		st->config |= AD7303_CFG_EXTERNAL_VREF;
>  	}
> @@ -263,16 +261,8 @@ static int ad7303_probe(struct spi_device *spi)
>  err_disable_vref_reg:
>  	if (st->vref_reg)
>  		regulator_disable(st->vref_reg);
> -err_put_vref_reg:
> -	if (st->vref_reg)
> -		regulator_put(st->vref_reg);
>  err_disable_vdd_reg:
>  	regulator_disable(st->vdd_reg);
> -err_put_vdd_reg:
> -	regulator_put(st->vdd_reg);
> -err_free:
> -	iio_device_free(indio_dev);
> -
>  	return ret;
>  }
>  
> @@ -283,14 +273,9 @@ static int ad7303_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	if (st->vref_reg) {
> +	if (st->vref_reg)
>  		regulator_disable(st->vref_reg);
> -		regulator_put(st->vref_reg);
> -	}
>  	regulator_disable(st->vdd_reg);
> -	regulator_put(st->vdd_reg);
> -
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
