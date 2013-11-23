Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56004 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab3KWMd7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 07:33:59 -0500
Message-ID: <5290AF0C.2050508@kernel.org>
Date: Sat, 23 Nov 2013 13:35:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 08/33] iio: dac: ad5755: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-9-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-9-git-send-email-sachin.kamat@linaro.org>
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
>  drivers/iio/dac/ad5755.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 9a78d5a..ee1e95a 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -589,16 +589,7 @@ static int ad5755_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	return iio_device_register(indio_dev);
> -}
> -
> -static int ad5755_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id ad5755_id[] = {
> @@ -617,7 +608,6 @@ static struct spi_driver ad5755_driver = {
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = ad5755_probe,
> -	.remove = ad5755_remove,
>  	.id_table = ad5755_id,
>  };
>  module_spi_driver(ad5755_driver);
> 
