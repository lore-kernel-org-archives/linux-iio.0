Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53557 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab3G0KmZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:42:25 -0400
Message-ID: <51F3B223.1050001@kernel.org>
Date: Sat, 27 Jul 2013 12:42:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH 3/4] iio: accel: st_accel: Use devm_iio_device_alloc
References: <1374562030-28621-1-git-send-email-sachin.kamat@linaro.org> <1374562030-28621-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374562030-28621-3-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/13 07:47, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/accel/st_accel_core.c |    1 -
>  drivers/iio/accel/st_accel_i2c.c  |   15 ++++-----------
>  drivers/iio/accel/st_accel_spi.c  |   15 ++++-----------
>  3 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index aef3c9b..1458343 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -517,7 +517,6 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
>  		st_sensors_deallocate_trigger(indio_dev);
>  		st_accel_deallocate_ring(indio_dev);
>  	}
> -	iio_device_free(indio_dev);
>  }
>  EXPORT_SYMBOL(st_accel_common_remove);
>  
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 58d164d..d7bedbd 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -25,11 +25,9 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  	struct st_sensor_data *adata;
>  	int err;
>  
> -	indio_dev = iio_device_alloc(sizeof(*adata));
> -	if (indio_dev == NULL) {
> -		err = -ENOMEM;
> -		goto iio_device_alloc_error;
> -	}
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  
>  	adata = iio_priv(indio_dev);
>  	adata->dev = &client->dev;
> @@ -38,14 +36,9 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  
>  	err = st_accel_common_probe(indio_dev, client->dev.platform_data);
>  	if (err < 0)
> -		goto st_accel_common_probe_error;
> +		return err;
>  
>  	return 0;
> -
> -st_accel_common_probe_error:
> -	iio_device_free(indio_dev);
> -iio_device_alloc_error:
> -	return err;
>  }
>  
>  static int st_accel_i2c_remove(struct i2c_client *client)
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index 21ed929..1956396 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -24,11 +24,9 @@ static int st_accel_spi_probe(struct spi_device *spi)
>  	struct st_sensor_data *adata;
>  	int err;
>  
> -	indio_dev = iio_device_alloc(sizeof(*adata));
> -	if (indio_dev == NULL) {
> -		err = -ENOMEM;
> -		goto iio_device_alloc_error;
> -	}
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adata));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  
>  	adata = iio_priv(indio_dev);
>  	adata->dev = &spi->dev;
> @@ -37,14 +35,9 @@ static int st_accel_spi_probe(struct spi_device *spi)
>  
>  	err = st_accel_common_probe(indio_dev, spi->dev.platform_data);
>  	if (err < 0)
> -		goto st_accel_common_probe_error;
> +		return err;
>  
>  	return 0;
> -
> -st_accel_common_probe_error:
> -	iio_device_free(indio_dev);
> -iio_device_alloc_error:
> -	return err;
>  }
>  
>  static int st_accel_spi_remove(struct spi_device *spi)
> 
