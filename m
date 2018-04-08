Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:57368 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeDHQMc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Apr 2018 12:12:32 -0400
Date: Sun, 8 Apr 2018 17:12:29 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: fix error path not turning chip
 back off
Message-ID: <20180408171229.3e3407f8@archlinux>
In-Reply-To: <CY4PR1201MB0184E3B55121DA4A686A6391C4BB0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB0184E3B55121DA4A686A6391C4BB0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 5 Apr 2018 16:17:00 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Some functions are turning the chip on and not back off in error
> path. With set_power function using a reference counter that
> would keep the chip on forever.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Hmm. We are always in 'best try' territory when we get an error in
these sorts of functions (as chances are it means the chip is dead
and we have no idea what will happen next)... Still there are
in some sense, correct things to do to undo anything that did succeed
etc. That requires better balance than the big hammer of turn
everything off that you have deployed here.

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 12 ++++++++----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 25 ++++++++++++++++---------
>  2 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 7d64be3..18c8866 100644
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
> index f963f9f..770b93a 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -53,45 +53,52 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  			result = inv_mpu6050_switch_engine(st, true,
>  					INV_MPU6050_BIT_PWR_GYRO_STBY);
>  			if (result)
> -				return result;
> +				goto error_power_off;
Here you are turning off things you never turned on.  I would definitely
prefer the error handling to match up.  I know these are effectively 
idempotent so it doesn't matter in reality but from a code structure
point of view it would definitely be cleaner to do it 'right'.

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
Why?  As far as I can tell this function didn't power it up in this path?
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
>  
>  		result = inv_mpu6050_switch_engine(st, false,
>  					INV_MPU6050_BIT_PWR_ACCL_STBY);
>  		if (result)
> -			return result;
> +			goto error_power_off;
> +
>  		result = inv_mpu6050_set_power_itg(st, false);
>  		if (result)
> -			return result;
> +			goto error_power_off;
>  	}
>  
>  	return 0;
> +
> +error_power_off:
> +	inv_mpu6050_switch_engine(st, false, INV_MPU6050_BIT_PWR_GYRO_STBY);
> +	inv_mpu6050_switch_engine(st, false, INV_MPU6050_BIT_PWR_ACCL_STBY);
> +	inv_mpu6050_set_power_itg(st, false);
> +	return result;
>  }
>  
>  /**

