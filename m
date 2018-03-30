Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39472 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3KA7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Mar 2018 06:00:59 -0400
Date: Fri, 30 Mar 2018 11:00:56 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: imu: inv_mpu6050: clean set_power_itg and fix
 usage
Message-ID: <20180330110056.7c4cc691@archlinux>
In-Reply-To: <CY4PR1201MB01847FB4C7079B9ED2FD5773C4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB01847FB4C7079B9ED2FD5773C4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Mar 2018 13:59:03 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Rewrite set_power_itg in a more clean way (failing now don't update
> the reference counter) and fix usage in init function (setting
> power on one time is sufficient to ensure chip is effectively on).

I agree the new structure is an improvement, but I'm not sure
I agree with the description.

For starters please make it clear the reference counter bit
only applies to the decrement case (I believe)...

Few other comments inline.

Thanks and definitely good to clean up this slightly confusing code
and error paths.

Jonathan


> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 44 ++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 7d64be3..9f97f4f 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -185,26 +185,29 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>  
>  int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>  {
> -	int result = 0;
> +	int result;
>  
>  	if (power_on) {
> -		if (!st->powerup_count)
> +		if (st->powerup_count == 0) {

Why this change - they are the same test? Should be mentioned in the patch
description at least.


>  			result = regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
> -		if (!result)
> -			st->powerup_count++;
So previously it was incremented only if result == 0 which was
true if either the regmap_write was fine or the value was already 0...

This doesn't match with your patch description.


> +			if (result)
> +				return result;
> +			usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> +				     INV_MPU6050_REG_UP_TIME_MAX);
> +		}
> +		st->powerup_count++;
>  	} else {
> -		st->powerup_count--;
> -		if (!st->powerup_count)
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
> +	dev_dbg(regmap_get_device(st->map), "set power %d, count=%u\n",
> +		power_on, st->powerup_count);
>  
>  	return 0;
>  }
> @@ -850,14 +853,11 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>  	msleep(INV_MPU6050_POWER_UP_TIME);
>  
>  	/*
> -	 * toggle power state. After reset, the sleep bit could be on
> -	 * or off depending on the OTP settings. Toggling power would
> +	 * toggle power on. After reset, the sleep bit could be on

Toggle implies an off on sequence so can't be used here if you are
just turning on.

> +	 * or off depending on the OTP settings. Toggling power on
>  	 * make it in a definite state as well as making the hardware
>  	 * state align with the software state
>  	 */
> -	result = inv_mpu6050_set_power_itg(st, false);
> -	if (result)
> -		return result;
>  	result = inv_mpu6050_set_power_itg(st, true);
>  	if (result)
>  		return result;
> @@ -865,13 +865,21 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
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
return inv_mpu6050_set_power_itg.

> +	if (result)
>  		return result;
>  
>  	return 0;
> +
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
> +	return result;
>  }
>  
>  int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,

