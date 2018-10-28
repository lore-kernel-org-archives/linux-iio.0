Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeJ2Dgc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 23:36:32 -0400
Date: Sun, 28 Oct 2018 18:50:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <martin@martingkelly.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/4] iio:magnetometer: st_magn: add LSM9DS1 support
Message-ID: <20181028185057.7bbe97ca@archlinux>
In-Reply-To: <20181026023812.29720-2-martin@martingkelly.com>
References: <20181026023812.29720-1-martin@martingkelly.com>
        <20181026023812.29720-2-martin@martingkelly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 Oct 2018 19:38:10 -0700
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> Update the sensor settings to support the LSM9DS1 sensor. Although the
> LSM9DS1 accelerometer and gyroscope are coupled together to use the same
> FIFO, the magnetometer is separate and can be cleanly supported without
> refactoring the existing driver.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
Applied.

Thanks,

Jonathan

> ---
> v2:
> - Rename lsm9ds1 --> lsm9ds1-magn and lsm9ds1_magn, as this is a multi-device
>   chip.
> - Use the register layout of LIS3MDL, as the two chips match.
> - Add I2C compatibility strings.
> 
>  drivers/iio/magnetometer/st_magn.h      | 1 +
>  drivers/iio/magnetometer/st_magn_core.c | 1 +
>  drivers/iio/magnetometer/st_magn_i2c.c  | 5 +++++
>  drivers/iio/magnetometer/st_magn_spi.c  | 5 +++++
>  4 files changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
> index 8fe51ce427bd..bc14ad4f1b26 100644
> --- a/drivers/iio/magnetometer/st_magn.h
> +++ b/drivers/iio/magnetometer/st_magn.h
> @@ -20,6 +20,7 @@
>  #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
>  #define LSM303AGR_MAGN_DEV_NAME		"lsm303agr_magn"
>  #define LIS2MDL_MAGN_DEV_NAME		"lis2mdl"
> +#define LSM9DS1_MAGN_DEV_NAME		"lsm9ds1_magn"
> 
>  int st_magn_common_probe(struct iio_dev *indio_dev);
>  void st_magn_common_remove(struct iio_dev *indio_dev);
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 72f6d1335a04..a186b844d664 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -267,6 +267,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
>  		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
>  		.sensors_supported = {
>  			[0] = LIS3MDL_MAGN_DEV_NAME,
> +			[1] = LSM9DS1_MAGN_DEV_NAME,
>  		},
>  		.ch = (struct iio_chan_spec *)st_magn_2_16bit_channels,
>  		.odr = {
> diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
> index feaa28cf6a77..68650f5f5c19 100644
> --- a/drivers/iio/magnetometer/st_magn_i2c.c
> +++ b/drivers/iio/magnetometer/st_magn_i2c.c
> @@ -44,6 +44,10 @@ static const struct of_device_id st_magn_of_match[] = {
>  		.compatible = "st,lis2mdl",
>  		.data = LIS2MDL_MAGN_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lsm9ds1-magn",
> +		.data = LSM9DS1_MAGN_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_magn_of_match);
> @@ -90,6 +94,7 @@ static const struct i2c_device_id st_magn_id_table[] = {
>  	{ LIS3MDL_MAGN_DEV_NAME },
>  	{ LSM303AGR_MAGN_DEV_NAME },
>  	{ LIS2MDL_MAGN_DEV_NAME },
> +	{ LSM9DS1_MAGN_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index 15bb09267098..cb05fcd9ddfe 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -39,6 +39,10 @@ static const struct of_device_id st_magn_of_match[] = {
>  		.compatible = "st,lis2mdl",
>  		.data = LIS2MDL_MAGN_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lsm9ds1-magn",
> +		.data = LSM9DS1_MAGN_DEV_NAME,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, st_magn_of_match);
> @@ -81,6 +85,7 @@ static const struct spi_device_id st_magn_id_table[] = {
>  	{ LIS3MDL_MAGN_DEV_NAME },
>  	{ LSM303AGR_MAGN_DEV_NAME },
>  	{ LIS2MDL_MAGN_DEV_NAME },
> +	{ LSM9DS1_MAGN_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_magn_id_table);
> --
> 2.11.0
> 
