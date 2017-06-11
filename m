Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42063 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbdFKNFM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Jun 2017 09:05:12 -0400
Date: Sun, 11 Jun 2017 14:05:09 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] iio: imu: inv_mpu6050: fix error path not
 turning chip back off
Message-ID: <20170611140509.2a3a5b76@jic23.retrosnub.co.uk>
In-Reply-To: <BLUPR12MB06570968D375DF9CD073BDA4C4C80@BLUPR12MB0657.namprd12.prod.outlook.com>
References: <BLUPR12MB06570968D375DF9CD073BDA4C4C80@BLUPR12MB0657.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 7 Jun 2017 13:43:21 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Some functions are turning the chip on and not back off in error
> path. With set_power function using a reference counter this is
> keeping the chip on forever.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Hi Jean-Baptiste,

This one doesn't apply to the current state of the testing tree.
It's dependant on a patch working it's way through the stable path.

As such I'll have to stop here for now with this series. Please give
me a bump if it looks like I've forgotten about it, once that patch
makes it's way through.

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 12 ++++++++----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 23 +++++++++++++++--------
>  2 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 64af12c..4db6ed5 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -262,27 +262,31 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>  	d = (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
>  	result = regmap_write(st->map, st->reg->gyro_config, d);
>  	if (result)
> -		return result;
> +		goto error_power_off;
>  
>  	result = inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
>  	if (result)
> -		return result;
> +		goto error_power_off;
>  
>  	d = INV_MPU6050_ONE_K_HZ / INV_MPU6050_INIT_FIFO_RATE - 1;
>  	result = regmap_write(st->map, st->reg->sample_rate_div, d);
>  	if (result)
> -		return result;
> +		goto error_power_off;
>  
>  	d = (INV_MPU6050_FS_02G << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
>  	result = regmap_write(st->map, st->reg->accl_config, d);
>  	if (result)
> -		return result;
> +		goto error_power_off;
>  
>  	memcpy(&st->chip_config, hw_info[st->chip_type].config,
>  	       sizeof(struct inv_mpu6050_chip_config));
>  	result = inv_mpu6050_set_power_itg(st, false);
>  
>  	return result;
> +
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
> +	return result;
>  }
>  
>  static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, int reg,
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 540070f..85c2732 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -53,45 +53,52 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  			result = inv_mpu6050_switch_engine(st, true,
>  					INV_MPU6050_BIT_PWR_GYRO_STBY);
>  			if (result)
> -				return result;
> +				goto error_power_off;
>  		}
>  		if (st->chip_config.accl_fifo_enable) {
>  			result = inv_mpu6050_switch_engine(st, true,
>  					INV_MPU6050_BIT_PWR_ACCL_STBY);
>  			if (result)
> -				return result;
> +				goto error_power_off;
>  		}
>  		result = inv_reset_fifo(indio_dev);
>  		if (result)
> -			return result;
> +			goto error_power_off;
>  	} else {
>  		result = regmap_write(st->map, st->reg->fifo_en, 0);
>  		if (result)
> -			return result;
> +			goto error_power_off;
>  
>  		result = regmap_write(st->map, st->reg->int_enable, 0);
>  		if (result)
> -			return result;
> +			goto error_power_off;
>  
>  		result = regmap_write(st->map, st->reg->user_ctrl, 0);
>  		if (result)
> -			return result;
> +			goto error_power_off;
>  
>  		result = inv_mpu6050_switch_engine(st, false,
>  					INV_MPU6050_BIT_PWR_GYRO_STBY);
>  		if (result)
> -			return result;
> +			goto error_power_off;
> +		st->chip_config.gyro_fifo_enable = false;
>  
>  		result = inv_mpu6050_switch_engine(st, false,
>  					INV_MPU6050_BIT_PWR_ACCL_STBY);
>  		if (result)
> -			return result;
> +			goto error_power_off;
> +		st->chip_config.accl_fifo_enable = false;
> +
>  		result = inv_mpu6050_set_power_itg(st, false);
>  		if (result)
>  			return result;
>  	}
>  
>  	return 0;
> +
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
> +	return result;
>  }
>  
>  /**

