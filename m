Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58606 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346Ab3KWRDZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:03:25 -0500
Message-ID: <5290EE32.3090702@kernel.org>
Date: Sat, 23 Nov 2013 18:04:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 15/33] staging: iio: ad7816: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-16-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-16-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied.
> ---
>  drivers/staging/iio/adc/ad7816.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 9f48e5c..2369cf2 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -412,7 +412,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  			return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi_dev->dev, indio_dev);
>  	if (ret)
>  		return ret;
>  
> @@ -422,15 +422,6 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	return 0;
>  }
>  
> -static int ad7816_remove(struct spi_device *spi_dev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(&spi_dev->dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> -}
> -
>  static const struct spi_device_id ad7816_id[] = {
>  	{ "ad7816", 0 },
>  	{ "ad7817", 0 },
> @@ -446,7 +437,6 @@ static struct spi_driver ad7816_driver = {
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = ad7816_probe,
> -	.remove = ad7816_remove,
>  	.id_table = ad7816_id,
>  };
>  module_spi_driver(ad7816_driver);
> 
