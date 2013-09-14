Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39786 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab3INKAB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 06:00:01 -0400
Message-ID: <523441BF.7020103@kernel.org>
Date: Sat, 14 Sep 2013 12:00:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 10/10] staging: iio: ade7854: Use devm_iio_device_alloc
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org> <1378893325-31764-10-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-10-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 10:55, Sachin Kamat wrote:
> devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Barry Song <21cnbao@gmail.com>
Applied with a little fuzz to the togreg branch of iio.git
(due to some string handling updates that went in recently)

> ---
>  drivers/staging/iio/meter/ade7854-i2c.c |    4 +---
>  drivers/staging/iio/meter/ade7854-spi.c |    4 +---
>  drivers/staging/iio/meter/ade7854.c     |    6 +-----
>  3 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
> index db9ef6c..5b33c7f 100644
> --- a/drivers/staging/iio/meter/ade7854-i2c.c
> +++ b/drivers/staging/iio/meter/ade7854-i2c.c
> @@ -208,7 +208,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
>  	struct ade7854_state *st;
>  	struct iio_dev *indio_dev;
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
> @@ -225,8 +225,6 @@ static int ade7854_i2c_probe(struct i2c_client *client,
>  	st->irq = client->irq;
>  
>  	ret = ade7854_probe(indio_dev, &client->dev);
> -	if (ret)
> -		iio_device_free(indio_dev);
>  
>  	return ret;
>  }
> diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
> index 4c6d204..94f73bb 100644
> --- a/drivers/staging/iio/meter/ade7854-spi.c
> +++ b/drivers/staging/iio/meter/ade7854-spi.c
> @@ -278,7 +278,7 @@ static int ade7854_spi_probe(struct spi_device *spi)
>  	struct ade7854_state *st;
>  	struct iio_dev *indio_dev;
>  
> -	indio_dev = iio_device_alloc(sizeof(*st));
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (indio_dev == NULL)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
> @@ -296,8 +296,6 @@ static int ade7854_spi_probe(struct spi_device *spi)
>  
>  
>  	ret = ade7854_probe(indio_dev, &spi->dev);
> -	if (ret)
> -		iio_device_free(indio_dev);
>  
>  	return ret;
>  }
> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
> index 8e068ab..d620bbd 100644
> --- a/drivers/staging/iio/meter/ade7854.c
> +++ b/drivers/staging/iio/meter/ade7854.c
> @@ -550,7 +550,7 @@ int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_dev;
> +		return ret;
>  
>  	/* Get the device into a sane initial state */
>  	ret = ade7854_initial_setup(indio_dev);
> @@ -561,9 +561,6 @@ int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
>  
>  error_unreg_dev:
>  	iio_device_unregister(indio_dev);
> -error_free_dev:
> -	iio_device_free(indio_dev);
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL(ade7854_probe);
> @@ -571,7 +568,6 @@ EXPORT_SYMBOL(ade7854_probe);
>  int ade7854_remove(struct iio_dev *indio_dev)
>  {
>  	iio_device_unregister(indio_dev);
> -	iio_device_free(indio_dev);
>  
>  	return 0;
>  }
> 
