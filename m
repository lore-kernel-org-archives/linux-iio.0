Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59090 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab3KWRfT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:35:19 -0500
Message-ID: <5290F5AB.10407@kernel.org>
Date: Sat, 23 Nov 2013 18:36:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 31/33] staging: iio: ad2s1200: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-32-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-32-git-send-email-sachin.kamat@linaro.org>
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
>  drivers/staging/iio/resolver/ad2s1200.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 62d3017..36eedd8 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -131,7 +131,7 @@ static int ad2s1200_probe(struct spi_device *spi)
>  	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
>  		return ret;
>  
> @@ -142,13 +142,6 @@ static int ad2s1200_probe(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static int ad2s1200_remove(struct spi_device *spi)
> -{
> -	iio_device_unregister(spi_get_drvdata(spi));
> -
> -	return 0;
> -}
> -
>  static const struct spi_device_id ad2s1200_id[] = {
>  	{ "ad2s1200" },
>  	{ "ad2s1205" },
> @@ -162,7 +155,6 @@ static struct spi_driver ad2s1200_driver = {
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = ad2s1200_probe,
> -	.remove = ad2s1200_remove,
>  	.id_table = ad2s1200_id,
>  };
>  module_spi_driver(ad2s1200_driver);
> 
