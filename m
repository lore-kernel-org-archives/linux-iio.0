Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57487 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933646AbcBYTy7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Feb 2016 14:54:59 -0500
Subject: Re: [PATCH 2/5] iio: imu: mpu6050: fix INV_MPU6050_REG_UP_TIME delay
To: Matt Ranostay <matt.ranostay@intel.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
 <1456177151-15881-3-git-send-email-matt.ranostay@intel.com>
Cc: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	adriana.reus@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CF5C10.30507@kernel.org>
Date: Thu, 25 Feb 2016 19:54:56 +0000
MIME-Version: 1.0
In-Reply-To: <1456177151-15881-3-git-send-email-matt.ranostay@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/02/16 21:39, Matt Ranostay wrote:
> replace msleep(INV_MPU6050_REG_UP_TIME) with usleep_range calls
> due to fact the wait time is under 20 milliseconds.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
Applied.
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 3 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 3 ++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 7 ++++++-
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 4324328fd304..6d4b19dd16f8 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -148,7 +148,8 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>  		return result;
>  
>  	if (power_on)
> -		msleep(INV_MPU6050_REG_UP_TIME);
> +		usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> +			     INV_MPU6050_REG_UP_TIME_MAX);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index af400dd892a9..37cc16d3fca3 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -68,7 +68,8 @@ static int inv_mpu6050_select_bypass(struct i2c_adapter *adap, void *mux_priv,
>  		if (ret)
>  			goto write_error;
>  
> -		msleep(INV_MPU6050_REG_UP_TIME);
> +		usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> +			     INV_MPU6050_REG_UP_TIME_MAX);
>  	}
>  	if (!ret) {
>  		st->powerup_count++;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index fcc2f3dfdfa8..243324dd78de 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -172,10 +172,15 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR   6
>  #define INV_MPU6050_FIFO_COUNT_BYTE          2
>  #define INV_MPU6050_FIFO_THRESHOLD           500
> +
> +/* delay time in milliseconds */
>  #define INV_MPU6050_POWER_UP_TIME            100
>  #define INV_MPU6050_TEMP_UP_TIME             100
>  #define INV_MPU6050_SENSOR_UP_TIME           30
> -#define INV_MPU6050_REG_UP_TIME              5
> +
> +/* delay time in microseconds */
> +#define INV_MPU6050_REG_UP_TIME_MIN          5000
> +#define INV_MPU6050_REG_UP_TIME_MAX          10000
>  
>  #define INV_MPU6050_TEMP_OFFSET	             12421
>  #define INV_MPU6050_TEMP_SCALE               2941
> 

