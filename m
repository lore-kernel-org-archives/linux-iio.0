Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934277AbdEXTNh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 15:13:37 -0400
Date: Wed, 24 May 2017 20:13:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: add accel lpf register setting
 for chip >= MPU6500
Message-ID: <20170524201335.4a7395d2@kernel.org>
In-Reply-To: <BLUPR12MB06571A155282C251F913FBAEC4F80@BLUPR12MB0657.namprd12.prod.outlook.com>
References: <BLUPR12MB065762A82F5B262968B67FA9C4E60@BLUPR12MB0657.namprd12.prod.outlook.com>
        <bd066212-0e24-453c-84ba-6deb0fb3c72d@kernel.org>
        <BLUPR12MB06571A155282C251F913FBAEC4F80@BLUPR12MB0657.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 22 May 2017 12:49:50 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> >From: Jonathan Cameron <jic23@kernel.org>
> >Sent: Sunday, May 21, 2017 14:09
> >To: Jean-Baptiste Maneyrol; linux-iio
> >Subject: Re: [PATCH] iio: imu: inv_mpu6050: add accel lpf register setting for chip >= MPU6500
> >    
> >On 16/05/17 14:12, Jean-Baptiste Maneyrol wrote:  
> >> Starting from MPU6500, accelerometer dlpf is set in a separate register
> >> named ACCEL_CONFIG_2.
> >> Add this new register in the map and set it for the corresponding chips.
> >> 
> >> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>  
> >Perhaps a fixes tag as we presumably want this to go to stable?  Can see some rather
> >unexpected results occurring without it.
> >
> >Hmm. Question to follow up is should we split the ABI to allow separate control.
> >Ideally we probably should but technically it'd be an unnecessary userspace
> >interface change.  The question is whether we'd actually break anything?
> >
> >I'd certainly prefer to see the two separate attributes to control the different
> >low pass filters.
> >
> >Jonathan
> >  
> Hello,
> 
> here is a reworked patch with a switch/case below.
> 
> There is no attribute currently to set lpf setting. It is automatically set with the
> correct value when setting the sampling rate (to avoid any aliases issues).
> Since there is only 1 frequency for the chip (meaning a unique frequency for
> both accel and gyro), there is no real need to set apart the accelerometer lpf value.
> Better have the same behavior for both gyro and accel lpf settings, setting them
> both when changing the sampling rate.
Fair enough.  Thanks for the explanation.  Please add a comment in the code
to this effect.
> 
> That would be a good thing to send this into stable release.
> If I need to do something, please tell me how to do it.
Please post new versions as a separate email titled
[PATCH v2] iio:...

It makes it easy for people to see there is a new version without searching
in the thread and also makes it trivial to apply without hand editing.

I'll sort out flagging it for stable.  If you can figure out a suitable
fixes tag that would be good, though here I guess there may be
not clear answer to that question.  I can't remember what devices were
supported when!

Jonathan
> 
> Thanks.
> Jean-Baptiste
> 
> 
> From 8db0b6b626c7e640590df8f271de7e8e2b409f15 Mon Sep 17 00:00:00 2001
> From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> Date: Mon, 22 May 2017 14:45:21 +0200
> Subject: [PATCH] iio: imu: inv_mpu6050: add accel lpf setting for chip >=
>  MPU6500
> 
> Starting from MPU6500, accelerometer dlpf is set in a separate register
> named ACCEL_CONFIG_2.
> Add this new register in the map and set it for the corresponding chips.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 37 +++++++++++++++++++++++++++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  3 +++
>  2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 96dabbd..299755a 100644
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
> @@ -552,7 +583,7 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
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

