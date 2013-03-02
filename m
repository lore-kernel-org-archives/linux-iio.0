Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36686 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3CBQaa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:30:30 -0500
Message-ID: <51322924.7010001@kernel.org>
Date: Sat, 02 Mar 2013 16:30:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Ge Gao <ggao@invensense.com>
Subject: Re: [PATCH] iio/imu: inv_mpu6050 depends on IIO_BUFFER
References: <1362151286-7338-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1362151286-7338-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/01/2013 03:21 PM, Guenter Roeck wrote:
> Fix:
> 
> drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c: In function ‘inv_mpu6050_read_fifo’:
> drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c:176:3: error: implicit declaration of
> function ‘iio_push_to_buffers’ [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Thanks, applied to togreg branch of iio.git

> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index b5cfa3a..361b232 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -5,6 +5,7 @@
>  config INV_MPU6050_IIO
>  	tristate "Invensense MPU6050 devices"
>  	depends on I2C && SYSFS
> +	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  This driver supports the Invensense MPU6050 devices.
> 
