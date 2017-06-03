Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbdFCIlt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 04:41:49 -0400
Date: Sat, 3 Jun 2017 09:41:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: add accel lpf setting for
 chip >= MPU6500
Message-ID: <20170603094114.7705b6f3@jic23.retrosnub.co.uk>
In-Reply-To: <BLUPR12MB065724FCF3F5B2401A52B2D9C4F30@BLUPR12MB0657.namprd12.prod.outlook.com>
References: <BLUPR12MB065724FCF3F5B2401A52B2D9C4F30@BLUPR12MB0657.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 29 May 2017 09:59:40 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Starting from MPU6500, accelerometer dlpf is set in a separate
> register named ACCEL_CONFIG_2.
> Add this new register in the map and set it for the corresponding
> chips.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Cc: stable@vger.kernel.org
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 39 +++++++++++++++++++++++++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  3 +++
>  2 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 96dabbd..88a7c5d 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -41,6 +41,7 @@
>  static const struct inv_mpu6050_reg_map reg_set_6500 = {
>  	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
>  	.lpf                    = INV_MPU6050_REG_CONFIG,
> +	.accel_lpf              = INV_MPU6500_REG_ACCEL_CONFIG_2,
>  	.user_ctrl              = INV_MPU6050_REG_USER_CTRL,
>  	.fifo_en                = INV_MPU6050_REG_FIFO_EN,
>  	.gyro_config            = INV_MPU6050_REG_GYRO_CONFIG,
> @@ -211,6 +212,37 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
>  EXPORT_SYMBOL_GPL(inv_mpu6050_set_power_itg);
>  
>  /**
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
> +	switch (st->chip_type) {
> +	case INV_MPU6050:
> +	case INV_MPU6000:
> +	case INV_MPU9150:
> +		/* old chips, nothing to do */
> +		result = 0;
> +		break;
> +	default:
> +		/* set accel lpf */
> +		result = regmap_write(st->map, st->reg->accel_lpf, val);
> +		break;
> +	}
> +
> +	return result;
> +}
> +
> +/**
>   *  inv_mpu6050_init_config() - Initialize hardware, disable FIFO.
>   *
>   *  Initial configuration:
> @@ -233,8 +265,7 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>  	if (result)
>  		return result;
>  
> -	d = INV_MPU6050_FILTER_20HZ;
> -	result = regmap_write(st->map, st->reg->lpf, d);
> +	result = inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
>  	if (result)
>  		return result;
>  
> @@ -537,6 +568,8 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>   *                  would be alising. This function basically search for the
>   *                  correct low pass parameters based on the fifo rate, e.g,
>   *                  sampling frequency.
> + *
> + *  lpf is set automatically when setting sampling rate to avoid any aliases.
>   */
>  static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>  {
> @@ -552,7 +585,7 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>  	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
>  		i++;
>  	data = d[i];
> -	result = regmap_write(st->map, st->reg->lpf, data);
> +	result = inv_mpu6050_set_lpf_regs(st, data);
>  	if (result)
>  		return result;
>  	st->chip_config.lpf = data;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index ef13de7..953a0c0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -28,6 +28,7 @@
>   *  struct inv_mpu6050_reg_map - Notable registers.
>   *  @sample_rate_div:	Divider applied to gyro output rate.
>   *  @lpf:		Configures internal low pass filter.
> + *  @accel_lpf:		Configures accelerometer low pass filter.
>   *  @user_ctrl:		Enables/resets the FIFO.
>   *  @fifo_en:		Determines which data will appear in FIFO.
>   *  @gyro_config:	gyro config register.
> @@ -47,6 +48,7 @@
>  struct inv_mpu6050_reg_map {
>  	u8 sample_rate_div;
>  	u8 lpf;
> +	u8 accel_lpf;
>  	u8 user_ctrl;
>  	u8 fifo_en;
>  	u8 gyro_config;
> @@ -188,6 +190,7 @@ struct inv_mpu6050_state {
>  #define INV_MPU6050_FIFO_THRESHOLD           500
>  
>  /* mpu6500 registers */
> +#define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
>  #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
>  
>  /* delay time in milliseconds */

