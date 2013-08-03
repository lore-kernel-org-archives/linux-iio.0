Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38200 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab3HCQpq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Aug 2013 12:45:46 -0400
Message-ID: <51FD41D2.7000405@kernel.org>
Date: Sat, 03 Aug 2013 18:45:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk, denis.ciocca@st.com
Subject: Re: [PATCH 2/2] iio: magnetometer: st_magn: Use devm_iio_device_alloc
References: <1375438128-23219-1-git-send-email-sachin.kamat@linaro.org> <1375438128-23219-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375438128-23219-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/13 11:08, Sachin Kamat wrote:
> Using devm_iio_device_alloc makes code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git

Thanks for getting all of these done.

Whilst this sort of change is kind of simple, the reduction in
complexity makes my life as maintainer easier in the long
run so I am very much in favour!

Also getting rid of all cases like you are doing means
that best practice is obvious to anyone writing new drivers.

> ---
>  drivers/iio/magnetometer/st_magn_core.c |    1 -
>  drivers/iio/magnetometer/st_magn_i2c.c  |   15 ++++-----------
>  drivers/iio/magnetometer/st_magn_spi.c  |   15 ++++-----------
>  3 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 7cd784f..e8d2849 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -407,7 +407,6 @@ void st_magn_common_remove(struct iio_dev *indio_dev)
>  		st_sensors_deallocate_trigger(indio_dev);
>  		st_magn_deallocate_ring(indio_dev);
>  	}
> -	iio_device_free(indio_dev);
>  }
>  EXPORT_SYMBOL(st_magn_common_remove);
>  
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index 1bed117..892e0fe 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -25,11 +25,9 @@ static int st_magn_i2c_probe(struct i2c_client *client,
>  	struct st_sensor_data *mdata;
>  	int err;
>  
> -	indio_dev = iio_device_alloc(sizeof(*mdata));
> -	if (indio_dev == NULL) {
> -		err = -ENOMEM;
> -		goto iio_device_alloc_error;
> -	}
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mdata));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  
>  	mdata = iio_priv(indio_dev);
>  	mdata->dev = &client->dev;
> @@ -38,14 +36,9 @@ static int st_magn_i2c_probe(struct i2c_client *client,
>  
>  	err = st_magn_common_probe(indio_dev, NULL);
>  	if (err < 0)
> -		goto st_magn_common_probe_error;
> +		return err;
>  
>  	return 0;
> -
> -st_magn_common_probe_error:
> -	iio_device_free(indio_dev);
> -iio_device_alloc_error:
> -	return err;
>  }
>  
>  static int st_magn_i2c_remove(struct i2c_client *client)
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index a2333a1..a6143ea 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -24,11 +24,9 @@ static int st_magn_spi_probe(struct spi_device *spi)
>  	struct st_sensor_data *mdata;
>  	int err;
>  
> -	indio_dev = iio_device_alloc(sizeof(*mdata));
> -	if (indio_dev == NULL) {
> -		err = -ENOMEM;
> -		goto iio_device_alloc_error;
> -	}
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*mdata));
> +	if (!indio_dev)
> +		return -ENOMEM;
>  
>  	mdata = iio_priv(indio_dev);
>  	mdata->dev = &spi->dev;
> @@ -37,14 +35,9 @@ static int st_magn_spi_probe(struct spi_device *spi)
>  
>  	err = st_magn_common_probe(indio_dev, NULL);
>  	if (err < 0)
> -		goto st_magn_common_probe_error;
> +		return err;
>  
>  	return 0;
> -
> -st_magn_common_probe_error:
> -	iio_device_free(indio_dev);
> -iio_device_alloc_error:
> -	return err;
>  }
>  
>  static int st_magn_spi_remove(struct spi_device *spi)
> 
