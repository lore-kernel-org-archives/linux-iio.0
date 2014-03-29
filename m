Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47560 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbaC2Ko7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Mar 2014 06:44:59 -0400
Message-ID: <5336A470.6070402@kernel.org>
Date: Sat, 29 Mar 2014 10:46:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [Patch v1 1/4] iio: imu: inv_mpu6050: Add compatibity with MPU6500
References: <1395248203-17027-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1395248203-17027-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/03/14 16:56, Srinivas Pandruvada wrote:
> Adding MPU6500 in target list for this driver.
>
> Description:
> Source
> Document: MPU-6500 Register Map and Descriptions Revision 2.1
> Section 3: Register Map
>
> This section describes difference in terms device programmability
> bewteen MPU6050 and MPU6500.
> These are different registers, which differs between MPU6050 and
> MPU6500.
>
> Addr	Name
> ---------------------
> 1E 	LP_ACCEL_ODR
> 6C	PWR_MGMT_2
> 77	XA_OFFSET_H
> 78	XA_OFFSET_L
> 7A	YA_OFFSET_H
> 7B	YA_OFFSET_L
> 7D	ZA_OFFSET_H
> 7E	ZA_OFFSET_L
>
> But the current MPU6050 driver doesn't use registers which are different
> except PWR_MGMT_2. The difference is support of "LP_WAKE_CTRL" at bit6-7
> in MPU6050 mode. In MPU6500 they are not defined.
> In current mpu6050 driver, only values used for this register are for
> standby mode for gyro and accelerometer.
> In both case frequency of wakeups is set to default and not using
> bit 6-7.
>
> So this driver van as well support MPU6500. In addition MPU6500 can
> run MPU6050 mode by changing device trim settings.
>
> So changing config comments to allow MPU6500 to use this driver.
> When ths driver is enhanced to support more functions, i2c driver
> data INV_MPU6500 or "WHO_AM_I" register can be used to add additional
> functionality.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git - initially pushed out as the testing branch.

Thanks,

Jonathan
> ---
>   drivers/iio/imu/inv_mpu6050/Kconfig        | 2 ++
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 1 +
>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 1 +
>   3 files changed, 4 insertions(+)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index 361b232..2d0608b 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -9,6 +9,8 @@ config INV_MPU6050_IIO
>   	select IIO_TRIGGERED_BUFFER
>   	help
>   	  This driver supports the Invensense MPU6050 devices.
> +	  This driver can also support MPU6500 in MPU6050 compatibility mode
> +	  and also in MPU6500 mode with some limitations.
>   	  It is a gyroscope/accelerometer combo device.
>   	  This driver can be built as a module. The module will be called
>   	  inv-mpu6050.
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index df7f1e1..52d688b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -765,6 +765,7 @@ static SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);
>    */
>   static const struct i2c_device_id inv_mpu_id[] = {
>   	{"mpu6050", INV_MPU6050},
> +	{"mpu6500", INV_MPU6500},
>   	{}
>   };
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index f383955..4ddfd03 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -59,6 +59,7 @@ struct inv_mpu6050_reg_map {
>   /*device enum */
>   enum inv_devices {
>   	INV_MPU6050,
> +	INV_MPU6500,
>   	INV_NUM_PARTS
>   };
>
>

