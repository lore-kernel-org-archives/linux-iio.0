Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45255 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaLZMjK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 07:39:10 -0500
Message-ID: <549D56ED.6080106@kernel.org>
Date: Fri, 26 Dec 2014 12:39:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: inv_mpu6050: ACPI enumeration
References: <1418678363-22437-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1418678363-22437-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1418678363-22437-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/12/14 21:19, Srinivas Pandruvada wrote:
> Added changes so that the module can be enumerated via ACPI.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
As this one stands on it's own.

Applied to the togreg branch of iio.git.

Thanks

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 6d2c115..f73e60b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -24,6 +24,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/iio/iio.h>
>  #include <linux/i2c-mux.h>
> +#include <linux/acpi.h>
>  #include "inv_mpu_iio.h"
>  
>  /*
> @@ -875,6 +876,13 @@ static const struct i2c_device_id inv_mpu_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
>  
> +static const struct acpi_device_id inv_acpi_match[] = {
> +	{"INVN6500", 0},
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
> +
>  static struct i2c_driver inv_mpu_driver = {
>  	.probe		=	inv_mpu_probe,
>  	.remove		=	inv_mpu_remove,
> @@ -883,6 +891,7 @@ static struct i2c_driver inv_mpu_driver = {
>  		.owner	=	THIS_MODULE,
>  		.name	=	"inv-mpu6050",
>  		.pm     =       INV_MPU6050_PMOPS,
> +		.acpi_match_table = ACPI_PTR(inv_acpi_match),
>  	},
>  };
>  
> 

