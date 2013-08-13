Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56922 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758677Ab3HMRfG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2013 13:35:06 -0400
Message-ID: <520A7C57.5000409@kernel.org>
Date: Tue, 13 Aug 2013 19:35:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/9] iio: gyro: adis16130: Use devm_iio_device_alloc
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org> <1376375675-11595-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/13/13 07:34, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/gyro/adis16130.c |   23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16130.c b/drivers/iio/gyro/adis16130.c
> index 129acdf..ac66fc1 100644
> --- a/drivers/iio/gyro/adis16130.c
> +++ b/drivers/iio/gyro/adis16130.c
> @@ -148,16 +148,13 @@ static const struct iio_info adis16130_info = {
>  
>  static int adis16130_probe(struct spi_device *spi)
>  {
> -	int ret;
>  	struct adis16130_state *st;
>  	struct iio_dev *indio_dev;
>  
>  	/* setup the industrialio driver allocated elements */
> -	indio_dev = iio_device_alloc(sizeof(*st));
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  	st = iio_priv(indio_dev);
>  	/* this is only used for removal purposes */
>  	spi_set_drvdata(spi, indio_dev);
> @@ -170,24 +167,12 @@ static int adis16130_probe(struct spi_device *spi)
>  	indio_dev->info = &adis16130_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_free_dev;
> -
> -	return 0;
> -
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -
> -error_ret:
> -	return ret;
> +	return iio_device_register(indio_dev);
>  }
>  
>  static int adis16130_remove(struct spi_device *spi)
>  {
>  	iio_device_unregister(spi_get_drvdata(spi));
> -	iio_device_free(spi_get_drvdata(spi));
> -
>  	return 0;
>  }
>  
> 
