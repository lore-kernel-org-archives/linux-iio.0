Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57399 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaJDKZ3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 06:25:29 -0400
Message-ID: <542FCB17.8040700@kernel.org>
Date: Sat, 04 Oct 2014 11:25:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/7] iio:magnetometer: Removed unnecessary parameter on
 common_probe function
References: <1412350541-29431-1-git-send-email-denis.ciocca@st.com> <1412350541-29431-4-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1412350541-29431-4-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 16:35, Denis CIOCCA wrote:
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied
> ---
>  drivers/iio/magnetometer/st_magn.h      | 3 +--
>  drivers/iio/magnetometer/st_magn_core.c | 5 ++---
>  drivers/iio/magnetometer/st_magn_i2c.c  | 2 +-
>  drivers/iio/magnetometer/st_magn_spi.c  | 2 +-
>  4 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
> index 694e33e..7e81d00 100644
> --- a/drivers/iio/magnetometer/st_magn.h
> +++ b/drivers/iio/magnetometer/st_magn.h
> @@ -18,8 +18,7 @@
>  #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
>  #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
>  
> -int st_magn_common_probe(struct iio_dev *indio_dev,
> -					struct st_sensors_platform_data *pdata);
> +int st_magn_common_probe(struct iio_dev *indio_dev);
>  void st_magn_common_remove(struct iio_dev *indio_dev);
>  
>  #ifdef CONFIG_IIO_BUFFER
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index b422620..8ade473 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -361,8 +361,7 @@ static const struct iio_info magn_info = {
>  	.write_raw = &st_magn_write_raw,
>  };
>  
> -int st_magn_common_probe(struct iio_dev *indio_dev,
> -					struct st_sensors_platform_data *pdata)
> +int st_magn_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *mdata = iio_priv(indio_dev);
>  	int irq = mdata->get_irq_data_ready(indio_dev);
> @@ -388,7 +387,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
>  					&mdata->sensor_settings->fs.fs_avl[0];
>  	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
>  
> -	err = st_sensors_init_sensor(indio_dev, pdata);
> +	err = st_sensors_init_sensor(indio_dev, NULL);
>  	if (err < 0)
>  		return err;
>  
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index 6892500..f8a6823 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -56,7 +56,7 @@ static int st_magn_i2c_probe(struct i2c_client *client,
>  
>  	st_sensors_i2c_configure(indio_dev, client, mdata);
>  
> -	err = st_magn_common_probe(indio_dev, NULL);
> +	err = st_magn_common_probe(indio_dev);
>  	if (err < 0)
>  		return err;
>  
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index a6143ea..f642142 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -33,7 +33,7 @@ static int st_magn_spi_probe(struct spi_device *spi)
>  
>  	st_sensors_spi_configure(indio_dev, spi, mdata);
>  
> -	err = st_magn_common_probe(indio_dev, NULL);
> +	err = st_magn_common_probe(indio_dev);
>  	if (err < 0)
>  		return err;
>  
> 
