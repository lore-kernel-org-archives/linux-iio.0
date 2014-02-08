Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41534 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbaBHM1d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 07:27:33 -0500
Message-ID: <52F622D2.4090208@kernel.org>
Date: Sat, 08 Feb 2014 12:28:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>, jic23@cam.ac.uk
CC: Ge Gao <ggao@invensense.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: mpu6050: Move config entry into IMU menu
References: <1391596475-21986-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1391596475-21986-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/14 10:34, Manuel Stahl wrote:
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Applied to the togreg branch of iio.igt

Thanks,
> ---
>   drivers/iio/imu/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index 663e88a..2b0e451 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -25,6 +25,8 @@ config ADIS16480
>   	  Say yes here to build support for Analog Devices ADIS16375, ADIS16480,
>   	  ADIS16485, ADIS16488 inertial sensors.
>
> +source "drivers/iio/imu/inv_mpu6050/Kconfig"
> +
>   endmenu
>
>   config IIO_ADIS_LIB
> @@ -38,5 +40,3 @@ config IIO_ADIS_LIB_BUFFER
>   	help
>   	  A set of buffer helper functions for the Analog Devices ADIS* device
>   	  family.
> -
> -source "drivers/iio/imu/inv_mpu6050/Kconfig"
>

