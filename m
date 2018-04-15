Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752527AbeDOTPJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 15:15:09 -0400
Date: Sun, 15 Apr 2018 20:15:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: imu: inv_mpu6050: use set_power_itg
 function in i2c mux
Message-ID: <20180415201505.746f2e01@archlinux>
In-Reply-To: <abc44b08-65d7-d17e-bb13-a6e68c6a97ca@invensense.com>
References: <abc44b08-65d7-d17e-bb13-a6e68c6a97ca@invensense.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 9 Apr 2018 11:44:28 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Set power function is rewritten manually inside i2c mux select.
> Better use the already identical existing function.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Again, odd wrapping in the patch will prevent it apply.

Please fixup and resend.

Thanks,

Jonathan

> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 33 
> ++++++++++++-------------------
>   1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c 
> b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index fcd7a92..8a8a5bd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -29,25 +29,19 @@ static int inv_mpu6050_select_bypass(struct 
> i2c_mux_core *muxc, u32 chan_id)
>   {
>   	struct iio_dev *indio_dev = i2c_mux_priv(muxc);
>   	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> -	int ret = 0;
> +	int ret;
> 
> -	/* Use the same mutex which was used everywhere to protect power-op */
>   	mutex_lock(&st->lock);
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
> +	ret = inv_mpu6050_set_power_itg(st, true);
> +	if (ret)
> +		goto error_unlock;
> +
> +	ret = regmap_write(st->map, st->reg->int_pin_cfg,
> +			   INV_MPU6050_INT_PIN_CFG |
> +			   INV_MPU6050_BIT_BYPASS_EN);
> +
> +error_unlock:
>   	mutex_unlock(&st->lock);
> 
>   	return ret;
> @@ -59,12 +53,11 @@ static int inv_mpu6050_deselect_bypass(struct 
> i2c_mux_core *muxc, u32 chan_id)
>   	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> 
>   	mutex_lock(&st->lock);
> +
>   	/* It doesn't really mattter, if any of the calls fails */
>   	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
> -	st->powerup_count--;
> -	if (!st->powerup_count)
> -		regmap_write(st->map, st->reg->pwr_mgmt_1,
> -			     INV_MPU6050_BIT_SLEEP);
> +	inv_mpu6050_set_power_itg(st, false);
> +
>   	mutex_unlock(&st->lock);
> 
>   	return 0;

