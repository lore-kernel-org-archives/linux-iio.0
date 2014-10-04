Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57401 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaJDKZw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Oct 2014 06:25:52 -0400
Message-ID: <542FCB2E.80208@kernel.org>
Date: Sat, 04 Oct 2014 11:25:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/7] iio:pressure: Removed unnecessary parameter on common_probe
 function
References: <1412350541-29431-1-git-send-email-denis.ciocca@st.com> <1412350541-29431-5-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1412350541-29431-5-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/10/14 16:35, Denis CIOCCA wrote:
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied
> ---
>  drivers/iio/pressure/st_pressure.h      | 3 +--
>  drivers/iio/pressure/st_pressure_core.c | 9 ++++-----
>  drivers/iio/pressure/st_pressure_i2c.c  | 2 +-
>  drivers/iio/pressure/st_pressure_spi.c  | 2 +-
>  4 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
> index 242943c..f5f4149 100644
> --- a/drivers/iio/pressure/st_pressure.h
> +++ b/drivers/iio/pressure/st_pressure.h
> @@ -26,8 +26,7 @@ static const struct st_sensors_platform_data default_press_pdata = {
>  	.drdy_int_pin = 1,
>  };
>  
> -int st_press_common_probe(struct iio_dev *indio_dev,
> -					struct st_sensors_platform_data *pdata);
> +int st_press_common_probe(struct iio_dev *indio_dev);
>  void st_press_common_remove(struct iio_dev *indio_dev);
>  
>  #ifdef CONFIG_IIO_BUFFER
> diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 9563118..ee2ef7d 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -409,8 +409,7 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
>  #define ST_PRESS_TRIGGER_OPS NULL
>  #endif
>  
> -int st_press_common_probe(struct iio_dev *indio_dev,
> -				struct st_sensors_platform_data *plat_data)
> +int st_press_common_probe(struct iio_dev *indio_dev)
>  {
>  	struct st_sensor_data *pdata = iio_priv(indio_dev);
>  	int irq = pdata->get_irq_data_ready(indio_dev);
> @@ -439,11 +438,11 @@ int st_press_common_probe(struct iio_dev *indio_dev,
>  	pdata->odr = pdata->sensor_settings->odr.odr_avl[0].hz;
>  
>  	/* Some devices don't support a data ready pin. */
> -	if (!plat_data && pdata->sensor_settings->drdy_irq.addr)
> -		plat_data =
> +	if (!pdata->dev->platform_data && pdata->sensor_settings->drdy_irq.addr)
> +		pdata->dev->platform_data =
>  			(struct st_sensors_platform_data *)&default_press_pdata;
>  
> -	err = st_sensors_init_sensor(indio_dev, plat_data);
> +	err = st_sensors_init_sensor(indio_dev, pdata->dev->platform_data);
>  	if (err < 0)
>  		return err;
>  
> diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index acaf165..dd73351 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -56,7 +56,7 @@ static int st_press_i2c_probe(struct i2c_client *client,
>  
>  	st_sensors_i2c_configure(indio_dev, client, pdata);
>  
> -	err = st_press_common_probe(indio_dev, client->dev.platform_data);
> +	err = st_press_common_probe(indio_dev);
>  	if (err < 0)
>  		return err;
>  
> diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index f45d430..98c3e8e 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -33,7 +33,7 @@ static int st_press_spi_probe(struct spi_device *spi)
>  
>  	st_sensors_spi_configure(indio_dev, spi, pdata);
>  
> -	err = st_press_common_probe(indio_dev, spi->dev.platform_data);
> +	err = st_press_common_probe(indio_dev);
>  	if (err < 0)
>  		return err;
>  
> 
