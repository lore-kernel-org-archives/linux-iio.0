Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55993 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab3KWMdB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 07:33:01 -0500
Message-ID: <5290AED2.30500@kernel.org>
Date: Sat, 23 Nov 2013 13:34:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 07/33] iio: dac: ad5421: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-8-git-send-email-sachin.kamat@linaro.org>
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
>  drivers/iio/dac/ad5421.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5421.c b/drivers/iio/dac/ad5421.c
> index 3eeaa82..7d1e908 100644
> --- a/drivers/iio/dac/ad5421.c
> +++ b/drivers/iio/dac/ad5421.c
> @@ -514,16 +514,7 @@ static int ad5421_probe(struct spi_device *spi)
>  			return ret;
>  	}
>  
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int ad5421_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static struct spi_driver ad5421_driver = {
> @@ -532,7 +523,6 @@ static struct spi_driver ad5421_driver = {
>  		   .owner = THIS_MODULE,
>  	},
>  	.probe = ad5421_probe,
> -	.remove = ad5421_remove,
>  };
>  module_spi_driver(ad5421_driver);
>  
> 
