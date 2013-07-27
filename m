Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53109 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3G0KFj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:05:39 -0400
Message-ID: <51F3A985.1000406@kernel.org>
Date: Sat, 27 Jul 2013 12:05:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Oskar Andero <oskar.andero@gmail.com>
Subject: Re: [PATCH 08/11] iio: adc: mcp320x: Use devm_* APIs
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org> <1374569897-3858-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569897-3858-9-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/13 09:58, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Oskar Andero <oskar.andero@gmail.com>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/adc/mcp320x.c |   18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index ebc0159..28a086e 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -169,7 +169,7 @@ static int mcp320x_probe(struct spi_device *spi)
>  	const struct mcp3208_chip_info *chip_info;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*adc));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> @@ -193,15 +193,13 @@ static int mcp320x_probe(struct spi_device *spi)
>  	spi_message_init_with_transfers(&adc->msg, adc->transfer,
>  					ARRAY_SIZE(adc->transfer));
>  
> -	adc->reg = regulator_get(&spi->dev, "vref");
> -	if (IS_ERR(adc->reg)) {
> -		ret = PTR_ERR(adc->reg);
> -		goto iio_free;
> -	}
> +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> +	if (IS_ERR(adc->reg))
> +		return PTR_ERR(adc->reg);
>  
>  	ret = regulator_enable(adc->reg);
>  	if (ret < 0)
> -		goto reg_free;
> +		return ret;
>  
>  	mutex_init(&adc->lock);
>  
> @@ -213,10 +211,6 @@ static int mcp320x_probe(struct spi_device *spi)
>  
>  reg_disable:
>  	regulator_disable(adc->reg);
> -reg_free:
> -	regulator_put(adc->reg);
> -iio_free:
> -	iio_device_free(indio_dev);
>  
>  	return ret;
>  }
> @@ -228,8 +222,6 @@ static int mcp320x_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	regulator_disable(adc->reg);
> -	regulator_put(adc->reg);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
