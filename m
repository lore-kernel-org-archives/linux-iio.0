Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752137AbeDHQmY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Apr 2018 12:42:24 -0400
Date: Sun, 8 Apr 2018 17:42:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Douglas Fischer <fischerdouglasc@gmail.com>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: Re: [PATCH] iio: imu: Add mpu9255 support to mpu6050 driver
Message-ID: <20180408174219.3147cfae@archlinux>
In-Reply-To: <20180402184200.0aa65204@Constantine>
References: <20180402184200.0aa65204@Constantine>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 2 Apr 2018 18:42:00 -0400
Douglas Fischer <fischerdouglasc@gmail.com> wrote:

> Added support for the mpu9255 IMU to the mpu6050 driver. The
> register map is the same as the other chips; the only driver
> difference is the compatible string and the WHOAMI register
> value.
> 
> Signed-off-by: Douglas Fischer <fischerdouglasc@gmail.com>
Looks good to me.  I'd like to give some time for Jean-Baptiste/others
to confirm they are happy with this as well though.

Give me a bump if I seem to have lost it in a couple of
weeks time.

Thanks.  It's interesting to note that all the manufacturer's
interfaces finally seem to be stabilizing across generations.
The days of large changes every version seem to finally
be behind us.

Jonathan

> ---
> 
> diff -uprN linux-4.16.orig/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt linux-4.16/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
> --- linux-4.16.orig/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt	2018-04-01 17:20:27.000000000 -0400
> +++ linux-4.16/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt	2018-04-02 18:31:38.342464417 -0400
> @@ -8,6 +8,7 @@ Required properties:
>   		"invensense,mpu6500"
>  		"invensense,mpu9150"
>  		"invensense,mpu9250"
> +		"invensense,mpu9255"
>  		"invensense,icm20608"
>   - reg : the I2C address of the sensor
>   - interrupt-parent : should be the phandle for the interrupt controller
> diff -uprN linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> --- linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c	2018-04-01 17:20:27.000000000 -0400
> +++ linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c	2018-04-02 18:31:38.345464417 -0400
> @@ -121,6 +121,12 @@ static const struct inv_mpu6050_hw hw_in
>  		.config = &chip_config_6050,
>  	},
>  	{
> +		.whoami = INV_MPU9255_WHOAMI_VALUE,
> +		.name = "MPU9255",
> +		.reg = &reg_set_6500,
> +		.config = &chip_config_6050,
> +	},
> +	{
>  		.whoami = INV_ICM20608_WHOAMI_VALUE,
>  		.name = "ICM20608",
>  		.reg = &reg_set_6500,
> diff -uprN linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> --- linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c	2018-04-01 17:20:27.000000000 -0400
> +++ linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c	2018-04-02 18:31:38.348464417 -0400
> @@ -179,6 +179,7 @@ static const struct i2c_device_id inv_mp
>  	{"mpu6500", INV_MPU6500},
>  	{"mpu9150", INV_MPU9150},
>  	{"mpu9250", INV_MPU9250},
> +	{"mpu9255", INV_MPU9255},
>  	{"icm20608", INV_ICM20608},
>  	{}
>  };
> @@ -203,6 +204,10 @@ static const struct of_device_id inv_of_
>  		.data = (void *)INV_MPU9250
>  	},
>  	{
> +		.compatible = "invensense,mpu9255",
> +		.data = (void *)INV_MPU9255
> +	},
> +	{
>  		.compatible = "invensense,icm20608",
>  		.data = (void *)INV_ICM20608
>  	},
> diff -uprN linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> --- linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h	2018-04-01 17:20:27.000000000 -0400
> +++ linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h	2018-04-02 18:31:38.351464416 -0400
> @@ -74,6 +74,7 @@ enum inv_devices {
>  	INV_MPU6000,
>  	INV_MPU9150,
>  	INV_MPU9250,
> +	INV_MPU9255,
>  	INV_ICM20608,
>  	INV_NUM_PARTS
>  };
> @@ -232,6 +233,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6500_WHOAMI_VALUE		0x70
>  #define INV_MPU9150_WHOAMI_VALUE		0x68
>  #define INV_MPU9250_WHOAMI_VALUE		0x71
> +#define INV_MPU9255_WHOAMI_VALUE		0x73
>  #define INV_ICM20608_WHOAMI_VALUE		0xAF
>  
>  /* scan element definition */
> diff -uprN linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> --- linux-4.16.orig/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c	2018-04-01 17:20:27.000000000 -0400
> +++ linux-4.16/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c	2018-04-02 18:31:38.356464416 -0400
> @@ -83,6 +83,7 @@ static const struct spi_device_id inv_mp
>  	{"mpu6500", INV_MPU6500},
>  	{"mpu9150", INV_MPU9150},
>  	{"mpu9250", INV_MPU9250},
> +	{"mpu9255", INV_MPU9255},
>  	{"icm20608", INV_ICM20608},
>  	{}
>  };
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

