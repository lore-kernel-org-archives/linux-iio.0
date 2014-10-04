Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57392 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaJDKZD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 06:25:03 -0400
Message-ID: <542FCAFD.2090200@kernel.org>
Date: Sat, 04 Oct 2014 11:25:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/7] iio:accel: Removed unnecessary parameter on common_probe
 function
References: <1412350541-29431-1-git-send-email-denis.ciocca@st.com> <1412350541-29431-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1412350541-29431-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 16:35, Denis CIOCCA wrote:
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied
> ---
>  drivers/iio/accel/st_accel.h      | 3 +--
>  drivers/iio/accel/st_accel_core.c | 9 ++++-----
>  drivers/iio/accel/st_accel_i2c.c  | 2 +-
>  drivers/iio/accel/st_accel_spi.c  | 2 +-
>  4 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index c387763..fa96460 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -33,8 +33,7 @@ static const struct st_sensors_platform_data default_accel_pdata = {
>  	.drdy_int_pin = 1,
>  };
>  
> -int st_accel_common_probe(struct iio_dev *indio_dev,
> -					struct st_sensors_platform_data *pdata);
> +int st_accel_common_probe(struct iio_dev *indio_dev);
>  void st_accel_common_remove(struct iio_dev *indio_dev);
>  
>  #ifdef CONFIG_IIO_BUFFER
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 7cbdfae..53f3262 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -457,8 +457,7 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
>  #define ST_ACCEL_TRIGGER_OPS NULL
>  #endif
>  
> -int st_accel_common_probe(struct iio_dev *indio_dev,
> -				struct st_sensors_platform_data *plat_data)
> +int st_accel_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  	int irq = adata->get_irq_data_ready(indio_dev);
> @@ -484,11 +483,11 @@ int st_accel_common_probe(struct iio_dev *indio_dev,
>  					&adata->sensor_settings->fs.fs_avl[0];
>  	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
>  
> -	if (!plat_data)
> -		plat_data =
> +	if (!adata->dev->platform_data)
> +		adata->dev->platform_data =
>  			(struct st_sensors_platform_data *)&default_accel_pdata;
>  
> -	err = st_sensors_init_sensor(indio_dev, plat_data);
> +	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
>  	if (err < 0)
>  		return err;
>  
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 7164aef..40adc7e 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -84,7 +84,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
>  
>  	st_sensors_i2c_configure(indio_dev, client, adata);
>  
> -	err = st_accel_common_probe(indio_dev, client->dev.platform_data);
> +	err = st_accel_common_probe(indio_dev);
>  	if (err < 0)
>  		return err;
>  
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index 1956396..2090d80 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -33,7 +33,7 @@ static int st_accel_spi_probe(struct spi_device *spi)
>  
>  	st_sensors_spi_configure(indio_dev, spi, adata);
>  
> -	err = st_accel_common_probe(indio_dev, spi->dev.platform_data);
> +	err = st_accel_common_probe(indio_dev);
>  	if (err < 0)
>  		return err;
>  
> 
