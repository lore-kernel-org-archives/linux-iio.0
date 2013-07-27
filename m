Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53545 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab3G0Klb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:41:31 -0400
Message-ID: <51F3B1EB.4020605@kernel.org>
Date: Sat, 27 Jul 2013 12:41:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: accel: kxsd9: Use devm_iio_device_alloc
References: <1374562030-28621-1-git-send-email-sachin.kamat@linaro.org> <1374562030-28621-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374562030-28621-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/13 07:47, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/accel/kxsd9.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 7229645..709c132 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -224,11 +224,10 @@ static int kxsd9_probe(struct spi_device *spi)
>  	struct kxsd9_state *st;
>  	int ret;
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
>  	st = iio_priv(indio_dev);
>  	spi_set_drvdata(spi, indio_dev);
>  
> @@ -247,20 +246,14 @@ static int kxsd9_probe(struct spi_device *spi)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	return 0;
> -
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
> -	return ret;
>  }
>  
>  static int kxsd9_remove(struct spi_device *spi)
>  {
>  	iio_device_unregister(spi_get_drvdata(spi));
> -	iio_device_free(spi_get_drvdata(spi));
>  
>  	return 0;
>  }
> 
