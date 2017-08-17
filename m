Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752027AbdHQOxD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Aug 2017 10:53:03 -0400
Date: Thu, 17 Aug 2017 15:52:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi@st.com
Subject: Re: [PATCH 3/4] iio: magnetometer: add support to LIS2MDL
Message-ID: <20170817155257.1871a2c4@archlinux>
In-Reply-To: <20170816170253.8382-4-lorenzo.bianconi@st.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com>
        <20170816170253.8382-4-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 16 Aug 2017 19:02:52 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> add support to STMicroelectronics LIS2MDL magnetometer in
> st_magn framework
> 
> http://www.st.com/resource/en/datasheet/lis2mdl.pdf
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
There was no dependency really between patches 1 and 2 (fixes) and the new
support.  I would have slightly preferred them as two series.

Anyhow, applied to the togreg branch of iio.git and pushed out as
testing.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/st_magn.h      | 1 +
>  drivers/iio/magnetometer/st_magn_core.c | 1 +
>  drivers/iio/magnetometer/st_magn_i2c.c  | 5 +++++
>  drivers/iio/magnetometer/st_magn_spi.c  | 5 +++++
>  4 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
> index 9daca4681922..8fe51ce427bd 100644
> --- a/drivers/iio/magnetometer/st_magn.h
> +++ b/drivers/iio/magnetometer/st_magn.h
> @@ -19,6 +19,7 @@
>  #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
>  #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
>  #define LSM303AGR_MAGN_DEV_NAME		"lsm303agr_magn"
> +#define LIS2MDL_MAGN_DEV_NAME		"lis2mdl"
>  
>  int st_magn_common_probe(struct iio_dev *indio_dev);
>  void st_magn_common_remove(struct iio_dev *indio_dev);
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index cd89962f2de3..e68368b5b2a3 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -323,6 +323,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  		.wai_addr = 0x4f,
>  		.sensors_supported = {
>  			[0] = LSM303AGR_MAGN_DEV_NAME,
> +			[1] = LIS2MDL_MAGN_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_magn_3_16bit_channels,
>  		.odr = {
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index 6a6c8121ac2c..feaa28cf6a77 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -40,6 +40,10 @@ static const struct of_device_id st_magn_of_match[] = {
>  		.compatible = "st,lsm303agr-magn",
>  		.data = LSM303AGR_MAGN_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis2mdl",
> +		.data = LIS2MDL_MAGN_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_magn_of_match);
> @@ -85,6 +89,7 @@ static const struct i2c_device_id st_magn_id_table[] = {
>  	{ LSM303DLM_MAGN_DEV_NAME },
>  	{ LIS3MDL_MAGN_DEV_NAME },
>  	{ LSM303AGR_MAGN_DEV_NAME },
> +	{ LIS2MDL_MAGN_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index 1ea64dd318aa..7b7cd08fcc32 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -33,6 +33,10 @@ static const struct of_device_id st_magn_of_match[] = {
>  		.compatible = "st,lsm303agr-magn",
>  		.data = LSM303AGR_MAGN_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lis2mdl",
> +		.data = LIS2MDL_MAGN_DEV_NAME,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, st_magn_of_match);
> @@ -74,6 +78,7 @@ static int st_magn_spi_remove(struct spi_device *spi)
>  static const struct spi_device_id st_magn_id_table[] = {
>  	{ LIS3MDL_MAGN_DEV_NAME },
>  	{ LSM303AGR_MAGN_DEV_NAME },
> +	{ LIS2MDL_MAGN_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_magn_id_table);

