Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58921 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526Ab3KWRUx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Nov 2013 12:20:53 -0500
Message-ID: <5290F24A.8070002@kernel.org>
Date: Sat, 23 Nov 2013 18:22:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 25/33] staging: iio: adis16060: Use devm_iio_device_register
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-26-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-26-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> devm_iio_device_register simplifies the code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
A simple device so this one is fine.

Applied to the togreg branch of iio.git

> ---
>  drivers/staging/iio/gyro/adis16060_core.c |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
> index 6d3d771..d5d395c 100644
> --- a/drivers/staging/iio/gyro/adis16060_core.c
> +++ b/drivers/staging/iio/gyro/adis16060_core.c
> @@ -167,7 +167,7 @@ static int adis16060_r_probe(struct spi_device *spi)
>  	indio_dev->channels = adis16060_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adis16060_channels);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)
>  		return ret;
>  
> @@ -175,13 +175,6 @@ static int adis16060_r_probe(struct spi_device *spi)
>  	return 0;
>  }
>  
> -/* fixme, confirm ordering in this function */
> -static int adis16060_r_remove(struct spi_device *spi)
> -{
> -	iio_device_unregister(spi_get_drvdata(spi));
> -	return 0;
> -}
> -
>  static int adis16060_w_probe(struct spi_device *spi)
>  {
>  	int ret;
> @@ -211,7 +204,6 @@ static struct spi_driver adis16060_r_driver = {
>  		.owner = THIS_MODULE,
>  	},
>  	.probe = adis16060_r_probe,
> -	.remove = adis16060_r_remove,
>  };
>  
>  static struct spi_driver adis16060_w_driver = {
> 
