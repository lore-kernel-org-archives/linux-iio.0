Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37076 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbdEUMJN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 08:09:13 -0400
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add accel lpf register setting for
 chip >= MPU6500
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        linux-iio <linux-iio@vger.kernel.org>
References: <BLUPR12MB065762A82F5B262968B67FA9C4E60@BLUPR12MB0657.namprd12.prod.outlook.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bd066212-0e24-453c-84ba-6deb0fb3c72d@kernel.org>
Date: Sun, 21 May 2017 13:09:11 +0100
MIME-Version: 1.0
In-Reply-To: <BLUPR12MB065762A82F5B262968B67FA9C4E60@BLUPR12MB0657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/05/17 14:12, Jean-Baptiste Maneyrol wrote:
> Starting from MPU6500, accelerometer dlpf is set in a separate register
> named ACCEL_CONFIG_2.
> Add this new register in the map and set it for the corresponding chips.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Perhaps a fixes tag as we presumably want this to go to stable?  Can see some rather
unexpected results occurring without it.

Hmm. Question to follow up is should we split the ABI to allow separate control.
Ideally we probably should but technically it'd be an unnecessary userspace
interface change.  The question is whether we'd actually break anything?

I'd certainly prefer to see the two separate attributes to control the different
low pass filters.

Jonathan

> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 32 +++++++++++++++++++++++++++---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  3 +++
>   2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 96dabbd..605b9da4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -41,6 +41,7 @@
>   static const struct inv_mpu6050_reg_map reg_set_6500 = {
>   	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
>   	.lpf                    = INV_MPU6050_REG_CONFIG,
> +	.accel_lpf              = INV_MPU6500_REG_ACCEL_CONFIG_2,
>   	.user_ctrl              = INV_MPU6050_REG_USER_CTRL,
>   	.fifo_en                = INV_MPU6050_REG_FIFO_EN,
>   	.gyro_config            = INV_MPU6050_REG_GYRO_CONFIG,
> @@ -211,6 +212,32 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>   EXPORT_SYMBOL_GPL(inv_mpu6050_set_power_itg);
>   
>   /**
> + *  inv_mpu6050_set_lpf_regs() - set low pass filter registers, chip dependent
> + *
> + *  MPU60xx/MPU9150 use only 1 register for accelerometer + gyroscope
> + *  MPU6500 and above have a dedicated register for accelerometer
> + */
> +static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
> +				    enum inv_mpu6050_filter_e val)
> +{
> +	int result;
> +
> +	result = regmap_write(st->map, st->reg->lpf, val);
> +	if (result)
> +		return result;
> +
> +	/* set accel lpf for chip >= MPU6500 */
> +	if (st->chip_type != INV_MPU6050 && st->chip_type != INV_MPU6000 &&
> +			st->chip_type != INV_MPU9150) {
I'd prefer a switch for this as it'll end up slightly easier to follow
> +		result = regmap_write(st->map, st->reg->accel_lpf, val);
> +		if (result)
> +			return result;
return directly
> +	}
> +
> +	return 0;
> +}
> +
> +/**
>    *  inv_mpu6050_init_config() - Initialize hardware, disable FIFO.
>    *
>    *  Initial configuration:
> @@ -233,8 +260,7 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>   	if (result)
>   		return result;
>   
> -	d = INV_MPU6050_FILTER_20HZ;
> -	result = regmap_write(st->map, st->reg->lpf, d);
> +	result = inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
>   	if (result)
>   		return result;
>   
> @@ -552,7 +578,7 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>   	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
>   		i++;
>   	data = d[i];
> -	result = regmap_write(st->map, st->reg->lpf, data);
> +	result = inv_mpu6050_set_lpf_regs(st, data);
>   	if (result)
>   		return result;
>   	st->chip_config.lpf = data;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index ef13de7..953a0c0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -28,6 +28,7 @@
>    *  struct inv_mpu6050_reg_map - Notable registers.
>    *  @sample_rate_div:	Divider applied to gyro output rate.
>    *  @lpf:		Configures internal low pass filter.
> + *  @accel_lpf:		Configures accelerometer low pass filter.
>    *  @user_ctrl:		Enables/resets the FIFO.
>    *  @fifo_en:		Determines which data will appear in FIFO.
>    *  @gyro_config:	gyro config register.
> @@ -47,6 +48,7 @@
>   struct inv_mpu6050_reg_map {
>   	u8 sample_rate_div;
>   	u8 lpf;
> +	u8 accel_lpf;
>   	u8 user_ctrl;
>   	u8 fifo_en;
>   	u8 gyro_config;
> @@ -188,6 +190,7 @@ struct inv_mpu6050_state {
>   #define INV_MPU6050_FIFO_THRESHOLD           500
>   
>   /* mpu6500 registers */
> +#define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
>   #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
>   
>   /* delay time in milliseconds */
> 

