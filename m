Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34012 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757938AbeD1Ps5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Apr 2018 11:48:57 -0400
Date: Sat, 28 Apr 2018 16:48:54 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/4] iio: imu: inv_mpu6050: fix error path not
 turning chip back off
Message-ID: <20180428164854.3b94c53f@archlinux>
In-Reply-To: <1524479613-23954-1-git-send-email-jmaneyrol@invensense.com>
References: <1524479613-23954-1-git-send-email-jmaneyrol@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 23 Apr 2018 12:33:30 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Some functions are turning the chip on and not back off in error
> path. With set_power function using a reference counter that
> would keep the chip on forever.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 13 ++++++----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 35 ++++++++++++++++++---------
>  2 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index e73c88c..5062fbe 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -273,21 +273,21 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
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
>  	result = regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);
>  	if (result)
> @@ -295,8 +295,11 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>  
>  	memcpy(&st->chip_config, hw_info[st->chip_type].config,
>  	       sizeof(struct inv_mpu6050_chip_config));
> -	result = inv_mpu6050_set_power_itg(st, false);
>  
> +	return inv_mpu6050_set_power_itg(st, false);
> +
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
>  	return result;
>  }
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index b8c5584..fc8843c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -53,45 +53,58 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
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
> +				goto error_gyro_off;
>  		}
>  		result = inv_reset_fifo(indio_dev);
>  		if (result)
> -			return result;
> +			goto error_accl_off;
>  	} else {
>  		result = regmap_write(st->map, st->reg->fifo_en, 0);
>  		if (result)
> -			return result;
> +			goto error_accl_off;
>  
>  		result = regmap_write(st->map, st->reg->int_enable, 0);
>  		if (result)
> -			return result;
> +			goto error_accl_off;
>  
>  		result = regmap_write(st->map, st->reg->user_ctrl, 0);
>  		if (result)
> -			return result;
> +			goto error_accl_off;
>  
>  		result = inv_mpu6050_switch_engine(st, false,
> -					INV_MPU6050_BIT_PWR_GYRO_STBY);
> +					INV_MPU6050_BIT_PWR_ACCL_STBY);
>  		if (result)
> -			return result;
> +			goto error_accl_off;
>  
>  		result = inv_mpu6050_switch_engine(st, false,
> -					INV_MPU6050_BIT_PWR_ACCL_STBY);
> +					INV_MPU6050_BIT_PWR_GYRO_STBY);
>  		if (result)
> -			return result;
> +			goto error_gyro_off;
> +
>  		result = inv_mpu6050_set_power_itg(st, false);
>  		if (result)
> -			return result;
> +			goto error_power_off;
>  	}
>  
>  	return 0;
> +
> +error_accl_off:
> +	if (st->chip_config.accl_fifo_enable)
> +		inv_mpu6050_switch_engine(st, false,
> +					  INV_MPU6050_BIT_PWR_ACCL_STBY);
> +error_gyro_off:
> +	if (st->chip_config.gyro_fifo_enable)
> +		inv_mpu6050_switch_engine(st, false,
> +					  INV_MPU6050_BIT_PWR_GYRO_STBY);
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
> +	return result;
>  }
>  
>  /**

