Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-011.synserver.de ([212.40.185.11]:1266 "EHLO
	smtp-out-008.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932414AbcBIUMb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 15:12:31 -0500
Subject: Re: [PATCH v2 3/4] iio: imu: inv_mpu6050: Separate driver into core
 and i2c functionality.
To: Adriana Reus <adriana.reus@intel.com>, jic23@kernel.org
References: <1454577628-12708-1-git-send-email-adriana.reus@intel.com>
 <1454577628-12708-4-git-send-email-adriana.reus@intel.com>
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, lucas.de.marchi@gmail.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56BA4753.5030502@metafoo.de>
Date: Tue, 9 Feb 2016 21:08:51 +0100
MIME-Version: 1.0
In-Reply-To: <1454577628-12708-4-git-send-email-adriana.reus@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/04/2016 10:20 AM, Adriana Reus wrote:
[...]
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -4,11 +4,9 @@
>  
>  config INV_MPU6050_IIO
>  	tristate "Invensense MPU6050 devices"
> -	depends on I2C && SYSFS
> +	depends on SYSFS

This does not work 'select' overwrites 'depends'. So if the users selects
INV_MPU6050_I2C this will work even though SYSFS is not available and you'll
get compile errors. But then again I'm not sure how we could end up with IIO
enabled and SYSFS not, so maybe just drop that line in a cleanup patch.

The other thing is that INV_MPU6050_IIO is user selectable, but doesn't
actually provide any functionality. My personal preference would be to make
this non user selectable, like we do for the other IIO drivers with similar
structure.

>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
[...]
[...]
> +static struct i2c_driver inv_mpu_driver = {
> +	.probe		=	inv_mpu_probe,
> +	.remove		=	inv_mpu_remove,
> +	.id_table	=	inv_mpu_id,
> +	.driver = {
> +		.owner	=	THIS_MODULE,

Drop the owner flag field, it wasn't part of the st

> +		.acpi_match_table = ACPI_PTR(inv_acpi_match),
> +		.name	=	"inv-mpu6050 i2c driver",
> +		.pm     =       &inv_mpu_pmops,
> +	},
> +};

