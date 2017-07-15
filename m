Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51112 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdGOLwh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jul 2017 07:52:37 -0400
Date: Sat, 15 Jul 2017 12:52:32 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/5] iio: imu: inv_mpu6050: clean set_power_itg
 implementation and usage
Message-ID: <20170715125232.124b87cb@jic23.retrosnub.co.uk>
In-Reply-To: <CY4PR1201MB018467288B234DB173B5EE15C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB018467288B234DB173B5EE15C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Jul 2017 13:31:33 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Rewrite set_power_itg in a more clean way (failing now don't update
> the reference counter). Fix usage in init function, use it inside
> i2c mux bypass, and delete double declaration in header file.
I'd have broken this into 3 single purpose patches as it would
have been slightly easier to review done like that.

It's all good stuff so we are just talking process related
issues here to make for a cleaner series rather than actual
code.

Jonathan
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 59 +++++++++++++++++++-----------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 30 +++++----------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
>  3 files changed, 46 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index b1a8159..6f36878 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -183,28 +183,41 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>  	return 0;
>  }
>  
> +/**
> + *  inv_mpu6050_set_power_itg() - Power on/off chip using a reference counter.
> + *  @st: chip state
> + *  @power_on: turn chip on if true, off if false
> + *
> + *  Return error code or 0 if success.
> + *
> + *  powerup_count is not updated if the function fails.
I don't think this comment (last line) is really needed.  Not doing this
was really a bug before - it is now doing what one would expect to happen.
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
>  
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
This is indeed much cleaner!  Good.

> @@ -851,14 +864,10 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	msleep(INV_MPU6050_POWER_UP_TIME);
>  
>  	/*
> -	 * toggle power state. After reset, the sleep bit could be on
> -	 * or off depending on the OTP settings. Toggling power would
> -	 * make it in a definite state as well as making the hardware
> -	 * state align with the software state
> +	 * After reset, the sleep bit could be on or off depending on the OTP
> +	 * settings. Turning power on make the chip in a definite state as well
Turning the power on will put the chip in a definite state as well
as aligning the hardware and software states.
(might as well tidy this language up whilst you are here ;)
> +	 * as making the hardware state align with the software state.
>  	 */
> -	result = inv_mpu6050_set_power_itg(st, false);
> -	if (result)
> -		return result;
>  	result = inv_mpu6050_set_power_itg(st, true);
>  	if (result)
>  		return result;
> @@ -866,13 +875,19 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	result = inv_mpu6050_switch_engine(st, false,
>  					   INV_MPU6050_BIT_PWR_ACCL_STBY);
>  	if (result)
> -		return result;
> +		goto error_power_off;
This change fits better within the previous patch perhaps?
>  	result = inv_mpu6050_switch_engine(st, false,
>  					   INV_MPU6050_BIT_PWR_GYRO_STBY);
>  	if (result)
> -		return result;
> +		goto error_power_off;
>  
> -	return 0;
> +	result = inv_mpu6050_set_power_itg(st, false);
> +
> +	return result;
> +
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
> +	return result;
>  }
>  
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index fcd7a92..6ac5375 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -29,25 +29,16 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
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
> -
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
> +	ret = inv_mpu6050_set_power_itg(st, true);
> +	if (ret)
> +		goto error_unlock;
> +	ret = regmap_write(st->map, st->reg->int_pin_cfg,
> +			   INV_MPU6050_INT_PIN_CFG |
> +			   INV_MPU6050_BIT_BYPASS_EN);
> +error_unlock:
>  	mutex_unlock(&st->lock);
A good change, but one that should be a separate follow up patch
this one.
>  
>  	return ret;
> @@ -61,10 +52,7 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  	mutex_lock(&st->lock);
>  	/* It doesn't really mattter, if any of the calls fails */
>  	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
> -	st->powerup_count--;
> -	if (!st->powerup_count)
> -		regmap_write(st->map, st->reg->pwr_mgmt_1,
> -			     INV_MPU6050_BIT_SLEEP);
> +	inv_mpu6050_set_power_itg(st, false);
>  	mutex_unlock(&st->lock);
>  
>  	return 0;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 0657941..c3d6225 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -298,5 +298,4 @@ enum inv_mpu6050_clock_sel_e {
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
>  int inv_mpu_core_remove(struct device *dev);
> -int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
>  extern const struct dev_pm_ops inv_mpu_pmops;

