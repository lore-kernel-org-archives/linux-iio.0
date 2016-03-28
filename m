Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44224 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbcC1JDT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 05:03:19 -0400
Subject: Re: [PATCH 8/8] iio: imu: Fix inv_mpu6050 dependencies
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
References: <1458945655-5027-1-git-send-email-richard@nod.at>
 <1458945655-5027-8-git-send-email-richard@nod.at>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8F354.3050207@kernel.org>
Date: Mon, 28 Mar 2016 10:03:16 +0100
MIME-Version: 1.0
In-Reply-To: <1458945655-5027-8-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/03/16 22:40, Richard Weinberger wrote:
> Not all archs have io memory.
> Instead of selecting I2C_MUX (and bypassing the HAS_IOMEM dependency)
> depend directly on it.
> 
> Fixes the following kconfig warning:
> warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_I2C) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
> And this build error:
> ERROR: "devm_ioremap_resource" [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
> ERROR: "of_address_to_resource" [drivers/i2c/muxes/i2c-mux-reg.ko] undefined!
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Signed-off-by: Richard Weinberger <richard@nod.at>
Applied to the fixes-togreg-post-rc1 branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index a7f557a..847455a 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -9,9 +9,8 @@ config INV_MPU6050_IIO
>  
>  config INV_MPU6050_I2C
>  	tristate "Invensense MPU6050 devices (I2C)"
> -	depends on I2C
> +	depends on I2C_MUX
>  	select INV_MPU6050_IIO
> -	select I2C_MUX
>  	select REGMAP_I2C
>  	help
>  	  This driver supports the Invensense MPU6050 devices.
> 

