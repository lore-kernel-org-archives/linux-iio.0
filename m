Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59129 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab3KWRgf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:36:35 -0500
Message-ID: <5290F5F8.6020508@kernel.org>
Date: Sat, 23 Nov 2013 18:37:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 32/33] staging: iio: ad2s90: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-33-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-33-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/staging/iio/resolver/ad2s90.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index e24c589..a18ebe2 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -79,7 +79,7 @@ static int ad2s90_probe(struct spi_device *spi)
>  	indio_dev->num_channels = 1;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
>  		return ret;
>  
> @@ -91,13 +91,6 @@ static int ad2s90_probe(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static int ad2s90_remove(struct spi_device *spi)
> -{
> -	iio_device_unregister(spi_get_drvdata(spi));
> -
> -	return 0;
> -}
> -
>  static const struct spi_device_id ad2s90_id[] = {
>  	{ "ad2s90" },
>  	{}
> @@ -110,7 +103,6 @@ static struct spi_driver ad2s90_driver = {
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = ad2s90_probe,
> -	.remove = ad2s90_remove,
>  	.id_table = ad2s90_id,
>  };
>  module_spi_driver(ad2s90_driver);
> 
