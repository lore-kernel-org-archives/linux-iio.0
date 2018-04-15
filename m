Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752527AbeDOTO0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 15:14:26 -0400
Date: Sun, 15 Apr 2018 20:14:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: imu: inv_mpu6050: clean set_power_itg and
 fix usage
Message-ID: <20180415201421.38ffe5ec@archlinux>
In-Reply-To: <12a18bf0-3187-29b8-4b42-11dd930a9c4f@invensense.com>
References: <12a18bf0-3187-29b8-4b42-11dd930a9c4f@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 9 Apr 2018 11:37:55 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Rewrite set_power_itg. Failing when turning power off is
> no more decreasing the counter now and sleeping only happens
> when effectively turning the chip on. Fix also usage in init
> function (setting power on one time is sufficient to ensure
> chip is effectively on).
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 44 
> ++++++++++++++++--------------
>   1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c 
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 7d64be3..f17fbfa 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -185,26 +185,29 @@ int inv_mpu6050_switch_engine(struct 
> inv_mpu6050_state *st, bool en, u32 mask)
Wrapped here so patch won't apply. Please resend and do a quick
sanity check that you can apply the result.

Thanks,

Jonathan

> 
>   int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>   {
> -	int result = 0;
> +	int result;
> 
>   	if (power_on) {
> -		if (!st->powerup_count)
> +		if (!st->powerup_count) {
>   			result = regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
> -		if (!result)
> -			st->powerup_count++;
> +			if (result)
> +				return result;
> +			usleep_range(INV_MPU6050_REG_UP_TIME_MIN,
> +				     INV_MPU6050_REG_UP_TIME_MAX);
> +		}
> +		st->powerup_count++;
>   	} else {
> -		st->powerup_count--;
> -		if (!st->powerup_count)
> +		if (st->powerup_count == 1) {
>   			result = regmap_write(st->map, st->reg->pwr_mgmt_1,
>   					      INV_MPU6050_BIT_SLEEP);
> +			if (result)
> +				return result;
> +		}
> +		st->powerup_count--;
>   	}
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
>   	return 0;
>   }
> @@ -850,14 +853,11 @@ static int inv_check_and_setup_chip(struct 
> inv_mpu6050_state *st)
>   	msleep(INV_MPU6050_POWER_UP_TIME);
> 
>   	/*
> -	 * toggle power state. After reset, the sleep bit could be on
> -	 * or off depending on the OTP settings. Toggling power would
> +	 * Turn power on. After reset, the sleep bit could be on
> +	 * or off depending on the OTP settings. Turning power on
>   	 * make it in a definite state as well as making the hardware
>   	 * state align with the software state
>   	 */
> -	result = inv_mpu6050_set_power_itg(st, false);
> -	if (result)
> -		return result;
>   	result = inv_mpu6050_set_power_itg(st, true);
>   	if (result)
>   		return result;
> @@ -865,13 +865,17 @@ static int inv_check_and_setup_chip(struct 
> inv_mpu6050_state *st)
>   	result = inv_mpu6050_switch_engine(st, false,
>   					   INV_MPU6050_BIT_PWR_ACCL_STBY);
>   	if (result)
> -		return result;
> +		goto error_power_off;
>   	result = inv_mpu6050_switch_engine(st, false,
>   					   INV_MPU6050_BIT_PWR_GYRO_STBY);
>   	if (result)
> -		return result;
> +		goto error_power_off;
> 
> -	return 0;
> +	return inv_mpu6050_set_power_itg(st, false);
> +
> +error_power_off:
> +	inv_mpu6050_set_power_itg(st, false);
> +	return result;
>   }
> 
>   int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,

