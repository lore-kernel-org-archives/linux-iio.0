Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39480 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbeC3KCL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Mar 2018 06:02:11 -0400
Date: Fri, 30 Mar 2018 11:02:09 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: imu: inv_mpu6050: use set_power_itg function
 in i2c mux
Message-ID: <20180330110209.1f8ec642@archlinux>
In-Reply-To: <CY4PR1201MB018412CC56073D8F1F70CFEAC4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB018412CC56073D8F1F70CFEAC4AD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Mar 2018 14:00:17 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Set power function is rewritten manually inside i2c mux select.
> Better use the already identical existing function.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Looks good, will pick up when patch 1 is sorted.

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 33 ++++++++++++-------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index fcd7a92..8a8a5bd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -29,25 +29,19 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
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
> +	ret = inv_mpu6050_set_power_itg(st, true);
> +	if (ret)
> +		goto error_unlock;
> +
> +	ret = regmap_write(st->map, st->reg->int_pin_cfg,
> +			   INV_MPU6050_INT_PIN_CFG |
> +			   INV_MPU6050_BIT_BYPASS_EN);
> +
> +error_unlock:
>  	mutex_unlock(&st->lock);
>  
>  	return ret;
> @@ -59,12 +53,11 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
>  	mutex_lock(&st->lock);
> +
>  	/* It doesn't really mattter, if any of the calls fails */
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

