Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53091 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab3HSSXC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 14:23:02 -0400
Message-ID: <52127097.3090203@kernel.org>
Date: Mon, 19 Aug 2013 20:23:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de, jic23@cam.ac.uk
Subject: Re: [PATCH 02/14] iio: dac: ad5360: Use devm_* APIs
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org> <1376912305-6423-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376912305-6423-2-git-send-email-sachin.kamat@linaro.org>
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
>  drivers/iio/dac/ad5360.c |   15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> index 80923af..d2da71e 100644
> --- a/drivers/iio/dac/ad5360.c
> +++ b/drivers/iio/dac/ad5360.c
> @@ -459,7 +459,7 @@ static int ad5360_probe(struct spi_device *spi)
>  	unsigned int i;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (indio_dev == NULL) {
>  		dev_err(&spi->dev, "Failed to allocate iio device\n");
>  		return  -ENOMEM;
> @@ -480,13 +480,13 @@ static int ad5360_probe(struct spi_device *spi)
>  	ret = ad5360_alloc_channels(indio_dev);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to allocate channel spec: %d\n", ret);
> -		goto error_free;
> +		return ret;
>  	}
>  
>  	for (i = 0; i < st->chip_info->num_vrefs; ++i)
>  		st->vref_reg[i].supply = ad5360_vref_name[i];
>  
> -	ret = regulator_bulk_get(&st->spi->dev, st->chip_info->num_vrefs,
> +	ret = devm_regulator_bulk_get(&st->spi->dev, st->chip_info->num_vrefs,
>  		st->vref_reg);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to request vref regulators: %d\n", ret);
> @@ -496,7 +496,7 @@ static int ad5360_probe(struct spi_device *spi)
>  	ret = regulator_bulk_enable(st->chip_info->num_vrefs, st->vref_reg);
>  	if (ret) {
>  		dev_err(&spi->dev, "Failed to enable vref regulators: %d\n", ret);
> -		goto error_free_reg;
> +		goto error_free_channels;
>  	}
>  
>  	ret = iio_device_register(indio_dev);
> @@ -509,12 +509,8 @@ static int ad5360_probe(struct spi_device *spi)
>  
>  error_disable_reg:
>  	regulator_bulk_disable(st->chip_info->num_vrefs, st->vref_reg);
> -error_free_reg:
> -	regulator_bulk_free(st->chip_info->num_vrefs, st->vref_reg);
>  error_free_channels:
>  	kfree(indio_dev->channels);
> -error_free:
> -	iio_device_free(indio_dev);
>  
>  	return ret;
>  }
> @@ -529,9 +525,6 @@ static int ad5360_remove(struct spi_device *spi)
>  	kfree(indio_dev->channels);
>  
>  	regulator_bulk_disable(st->chip_info->num_vrefs, st->vref_reg);
> -	regulator_bulk_free(st->chip_info->num_vrefs, st->vref_reg);
> -
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
