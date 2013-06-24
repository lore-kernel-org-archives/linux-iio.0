Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:58283 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752474Ab3FXGaT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 24 Jun 2013 02:30:19 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Mon, 24 Jun 2013 08:30:03 +0200
Subject: Re: [PATCH 5/5] iio: reword help text of several IIO_ST drivers
Message-ID: <3381694.P0QkDB0nbp@ctocwl0124>
References: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net>
 <1372022900-18670-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372022900-18670-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Acked-by: "Denis Ciocca" <denis.ciocca@st.com>

On Sunday, June 23, 2013 11:28:20 PM Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Denis Ciocca <denis.ciocca@st.com>
> ---
>  drivers/iio/accel/Kconfig        | 4 ++--
>  drivers/iio/gyro/Kconfig         | 4 ++--
>  drivers/iio/magnetometer/Kconfig | 4 ++--
>  drivers/iio/pressure/Kconfig     | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 719d83f..a002675 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -33,8 +33,8 @@ config IIO_ST_ACCEL_3AXIS
>  	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
>  	  LIS331DLH, LSM303DL, LSM303DLM, LSM330.
> 
> -	  This driver can also be built as a module. If so, will be created
> -	  these modules:
> +	  This driver can also be built as a module. If so, these modules
> +	  will be created:
>  	  - st_accel (core functions for the driver [it is mandatory]);
>  	  - st_accel_i2c (necessary for the I2C devices [optional*]);
>  	  - st_accel_spi (necessary for the SPI devices [optional*]);
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 8498e9d..1fdcc84 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -58,8 +58,8 @@ config IIO_ST_GYRO_3AXIS
>  	  Say yes here to build support for STMicroelectronics gyroscopes:
>  	  L3G4200D, LSM330DL, L3GD20, L3GD20H, LSM330DLC, L3G4IS, LSM330.
> 
> -	  This driver can also be built as a module. If so, will be created
> -	  these modules:
> +	  This driver can also be built as a module. If so, these modules
> +	  will be created:
>  	  - st_gyro (core functions for the driver [it is mandatory]);
>  	  - st_gyro_i2c (necessary for the I2C devices [optional*]);
>  	  - st_gyro_spi (necessary for the SPI devices [optional*]);
> diff --git a/drivers/iio/magnetometer/Kconfig
> b/drivers/iio/magnetometer/Kconfig index c332b0a..4d55b1b 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -36,8 +36,8 @@ config IIO_ST_MAGN_3AXIS
>  	  Say yes here to build support for STMicroelectronics magnetometers:
>  	  LSM303DLHC, LSM303DLM, LIS3MDL.
> 
> -	  This driver can also be built as a module. If so, will be created
> -	  these modules:
> +	  This driver can also be built as a module. If so, these modules
> +	  will be created:
>  	  - st_magn (core functions for the driver [it is mandatory]);
>  	  - st_magn_i2c (necessary for the I2C devices [optional*]);
>  	  - st_magn_spi (necessary for the SPI devices [optional*]);
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 3cba7f5..56ae890 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -14,8 +14,8 @@ config IIO_ST_PRESS
>  	  Say yes here to build support for STMicroelectronics pressure
>  	  sensors: LPS331AP.
> 
> -	  This driver can also be built as a module. If so, will be created
> -	  these modules:
> +	  This driver can also be built as a module. If so, these modules
> +	  will be created:
>  	  - st_pressure (core functions for the driver [it is mandatory]);
>  	  - st_pressure_i2c (necessary for the I2C devices [optional*]);
>  	  - st_pressure_spi (necessary for the SPI devices [optional*]);