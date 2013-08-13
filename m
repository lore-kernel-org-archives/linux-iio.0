Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:37696 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753983Ab3HMJD3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2013 05:03:29 -0400
Message-ID: <5209F66C.8070105@metafoo.de>
Date: Tue, 13 Aug 2013 11:03:40 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 1/9] iio: gyro: adis16080: Use devm_iio_device_alloc
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/13/2013 08:34 AM, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>

All the adis* patches in this series:

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
> This series compile tested on togreg branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> ---
>   drivers/iio/gyro/adis16080.c |   21 ++++-----------------
>   1 file changed, 4 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
> index e1bb5f9..e9ec022 100644
> --- a/drivers/iio/gyro/adis16080.c
> +++ b/drivers/iio/gyro/adis16080.c
> @@ -192,16 +192,13 @@ static const struct adis16080_chip_info adis16080_chip_info[] = {
>   static int adis16080_probe(struct spi_device *spi)
>   {
>   	const struct spi_device_id *id = spi_get_device_id(spi);
> -	int ret;
>   	struct adis16080_state *st;
>   	struct iio_dev *indio_dev;
>
>   	/* setup the industrialio driver allocated elements */
> -	indio_dev = iio_device_alloc(sizeof(*st));
> -	if (indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
>   	st = iio_priv(indio_dev);
>   	/* this is only used for removal purposes */
>   	spi_set_drvdata(spi, indio_dev);
> @@ -217,22 +214,12 @@ static int adis16080_probe(struct spi_device *spi)
>   	indio_dev->info = &adis16080_info;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_free_dev;
> -	return 0;
> -
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -error_ret:
> -	return ret;
> +	return iio_device_register(indio_dev);
>   }
>
>   static int adis16080_remove(struct spi_device *spi)
>   {
>   	iio_device_unregister(spi_get_drvdata(spi));
> -	iio_device_free(spi_get_drvdata(spi));
> -
>   	return 0;
>   }
>
>

