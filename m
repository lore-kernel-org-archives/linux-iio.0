Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbdFCISF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 04:18:05 -0400
Date: Sat, 3 Jun 2017 09:18:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: rewrite and fix use of
 set_power function
Message-ID: <20170603091801.11260840@kernel.org>
In-Reply-To: <CY1PR12MB0666A0FFA6903C162D23345EC4F70@CY1PR12MB0666.namprd12.prod.outlook.com>
References: <CY1PR12MB0666A0FFA6903C162D23345EC4F70@CY1PR12MB0666.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2 Jun 2017 16:22:42 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Rewrite clean set_power function with reference counter.
> Use the function in i2c mux instead of having it rewritten and
Maybe 'Use this function...'  I was expecting some generic
magic power control function to be provided by the generic
i2c mux code!
> fix error paths using it to ensure correct reference count.
> Delete double function declaration in header file.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Again a few stray bits in here that should have been in separate patches.
I'd also like your assessment on whether the bugs fixed here are
significant enough to warrant a stable tag or not.

Please also put fixes tags for any patches that are fixing bugs.
It makes it easy for the stable maintainers to known when they
apply and for others to assess the necessity for backporting.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 70 +++++++++++++++++++-----------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 34 +++++----------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
>  3 files changed, 57 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 5a0db5a..9502ee4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -182,28 +182,36 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>  	return 0;
>  }
>  
> +/**
> + *  inv_mpu6050_set_power_itg() - Power on/off chip using a reference counter.
> + *
If doing kernel doc comment (which is great) please make them complete.
The parameters need documenting as well.
> + *  powerup_count is not updated if the function fails.
> + */
>  int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>  {
> -	int result = 0;
> +	int result;
>  
>  	if (power_on) {
> -		if (!st->powerup_count)
> +		if (!st->powerup_count) {
>  			result = regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
> -		if (!result)
> -			st->powerup_count++;
> +			if (result)
> +				return result;
> +			usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> +				     INV_MPU6050_REG_UP_TIME_MAX);
> +		}
> +		st->powerup_count++;
>  	} else {
> -		st->powerup_count--;
> -		if (!st->powerup_count)
> +		/* turn chip off if there is only 1 power up demand remaining */
> +		if (st->powerup_count == 1) {
>  			result = regmap_write(st->map, st->reg->pwr_mgmt_1,
>  					      INV_MPU6050_BIT_SLEEP);
> +			if (result)
> +				return result;
> +		}
> +		st->powerup_count--;
>  	}
> -
> -	if (result)
> -		return result;
> -
> -	if (power_on)
> -		usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> -			     INV_MPU6050_REG_UP_TIME_MAX);
> +	dev_dbg(regmap_get_device(st->map), "power-up count: %u\n",
> +		st->powerup_count);
>  
>  	return 0;
>  }
> @@ -227,30 +235,38 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>  	result = inv_mpu6050_set_power_itg(st, true);
>  	if (result)
>  		return result;
> +
Whitespace changes belong in their own separate patches (after all those
are really easy to review ;)
>  	d = (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
>  	result = regmap_write(st->map, st->reg->gyro_config, d);
>  	if (result)
> -		return result;
> +		goto error_power_off;
>  
>  	d = INV_MPU6050_FILTER_20HZ;
>  	result = regmap_write(st->map, st->reg->lpf, d);
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
> +
>  	result = inv_mpu6050_set_power_itg(st, false);
> +	if (result)
> +		return result;
return result boils down to the same thing I think...
(should be 0 in all the non error paths).
> +
> +	return 0;
>  
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
>  	return result;
>  }
>  
> @@ -792,14 +808,10 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	}
>  
>  	/*
> -	 * toggle power state. After reset, the sleep bit could be on
> -	 * or off depending on the OTP settings. Toggling power would
> -	 * make it in a definite state as well as making the hardware
> -	 * state align with the software state
> +	 * After reset, the sleep bit could be on or off depending on the OTP
> +	 * settings. Turning power on make the chip in a definite state as well
> +	 * as making the hardware state align with the software state.
>  	 */
> -	result = inv_mpu6050_set_power_itg(st, false);
> -	if (result)
> -		return result;
>  	result = inv_mpu6050_set_power_itg(st, true);
>  	if (result)
>  		return result;
> @@ -807,13 +819,21 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	result = inv_mpu6050_switch_engine(st, false,
>  					   INV_MPU6050_BIT_PWR_ACCL_STBY);
>  	if (result)
> -		return result;
> +		goto error_power_off;
>  	result = inv_mpu6050_switch_engine(st, false,
>  					   INV_MPU6050_BIT_PWR_GYRO_STBY);
>  	if (result)
> +		goto error_power_off;
> +
> +	result = inv_mpu6050_set_power_itg(st, false);
> +	if (result)
>  		return result;
again, return result directly should give 0 in the non error case (I think)
>  
>  	return 0;
> +
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
> +	return result;
>  }
>  
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index fcd7a92..faca69d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -29,27 +29,18 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  {
>  	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> -	int ret = 0;
> +	int ret;
>  
> -	/* Use the same mutex which was used everywhere to protect power-op */
>  	mutex_lock(&st->lock);
> -	if (!st->powerup_count) {
> -		ret = regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
> -		if (ret)
> -			goto write_error;
>  
> -		usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> -			     INV_MPU6050_REG_UP_TIME_MAX);
> -	}
> -	if (!ret) {
> -		st->powerup_count++;
> -		ret = regmap_write(st->map, st->reg->int_pin_cfg,
> -				   INV_MPU6050_INT_PIN_CFG |
> -				   INV_MPU6050_BIT_BYPASS_EN);
> -	}
> -write_error:
> -	mutex_unlock(&st->lock);
> +	ret = inv_mpu6050_set_power_itg(st, true);
> +	if (ret)
> +		goto error_unlock;
> +	ret = regmap_write(st->map, st->reg->int_pin_cfg,
> +			   INV_MPU6050_INT_PIN_CFG | INV_MPU6050_BIT_BYPASS_EN);
>  
> +error_unlock:
> +	mutex_unlock(&st->lock);
>  	return ret;
>  }
>  
> @@ -59,12 +50,11 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->lock);
> -	/* It doesn't really mattter, if any of the calls fails */
> +
> +	/* It doesn't really matter, if any of the calls fails */
Typo fixes should be in a patch with no code changes...  Please aim for the 
'complex' patches to be as minimal as possible.  Leave the 'cruft' for
separate patches in the series.
>  	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
> -	st->powerup_count--;
> -	if (!st->powerup_count)
> -		regmap_write(st->map, st->reg->pwr_mgmt_1,
> -			     INV_MPU6050_BIT_SLEEP);
> +	inv_mpu6050_set_power_itg(st, false);
> +
>  	mutex_unlock(&st->lock);
>  
>  	return 0;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 713fa7b..d07795d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -295,5 +295,4 @@ enum inv_mpu6050_clock_sel_e {
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
>  int inv_mpu_core_remove(struct device *dev);
> -int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
>  extern const struct dev_pm_ops inv_mpu_pmops;

