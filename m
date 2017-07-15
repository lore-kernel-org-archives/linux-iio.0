Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51270 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdGOMIE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jul 2017 08:08:04 -0400
Date: Sat, 15 Jul 2017 13:07:59 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio: imu: inv_mpu6050: rewrite and clean read raw
 for channel data
Message-ID: <20170715130759.257ce9de@jic23.retrosnub.co.uk>
In-Reply-To: <CY4PR1201MB0184542165F3048A06C0E8A5C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB0184542165F3048A06C0E8A5C4AC0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Jul 2017 13:35:25 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Factorize reading channel data in its own function and use a single
> return path at the end of the global read_raw function.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Comments are more about the original code you have factored out but
there is room for improvement and I was reading it so bad luck ;)

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 150 ++++++++++++++++-------------
>  1 file changed, 84 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 5290e59..c46740f 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -332,72 +332,80 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
>  	return IIO_VAL_INT;
>  }
>  
> +static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
> +					 struct iio_chan_spec const *chan,
> +					 int *val)
> +{
> +	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +	int result;
> +	int ret = IIO_VAL_INT;
> +
> +	result = iio_device_claim_direct_mode(indio_dev);
> +	if (result)
> +		return result;
This feels rather inconsistent.  Why not use ret here?
> +	result = inv_mpu6050_set_power_itg(st, true);
> +	if (result)
> +		goto error_release;
> +
> +	switch (chan->type) {
> +	case IIO_ANGL_VEL:
> +		result = inv_mpu6050_switch_engine(st, true,
> +				INV_MPU6050_BIT_PWR_GYRO_STBY);
> +		if (result)
> +			goto error_power_off;
> +		ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
> +					      chan->channel2, val);
Ah, so this is about preserving error codes.
Go the simple if more verbose way

ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
			      chan->channel2, val);
if (ret) {
	/* Ensure first error is reported */
	inv_mpu6050_switch_engine(st, false,
				INV_MPU6050_BIT_PWR_GYRO_STBY);
	goto error_power_off;
}
ret = inv_mpu6050_switch_engine(st, false,
				INV_MPU6050_BIT_PWR_GYRO_STBY);
if (ret)
	goto error_power_off;

Ah.  This is existing code just moved. Ideal is probably this patch
unchanged, then a follow up simplifying this convoluted logic.

> +		result = inv_mpu6050_switch_engine(st, false,
> +				INV_MPU6050_BIT_PWR_GYRO_STBY);
> +		if (result)
> +			goto error_power_off;
> +		break;
> +	case IIO_ACCEL:
> +		result = inv_mpu6050_switch_engine(st, true,
> +				INV_MPU6050_BIT_PWR_ACCL_STBY);
> +		if (result)
> +			goto error_power_off;
> +		ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
> +					      chan->channel2, val);
> +		result = inv_mpu6050_switch_engine(st, false,
> +				INV_MPU6050_BIT_PWR_ACCL_STBY);
> +		if (result)
> +			goto error_power_off;
> +		break;
> +	case IIO_TEMP:
> +		/* wait for stablization */
> +		msleep(INV_MPU6050_SENSOR_UP_TIME);
> +		ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
> +					      IIO_MOD_X, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +error_power_off:
> +	result |= inv_mpu6050_set_power_itg(st, false);
Never a good idea.  It's more than possible result will
now be the or of two different errors giving
complete garbage to userspace.  If it's not possible now
some future change in the underlying library calls may make
it possible.

If you are trying to hold an error code then have a separate
error path which does so.
> +error_release:
> +	iio_device_release_direct_mode(indio_dev);
> +	if (result)
> +		return result;
> +
> +	return ret;
> +}
> +
>  static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  				struct iio_chan_spec const *chan,
>  				int *val, int *val2, long mask)
>  {
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
> -	int ret = 0;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -	{
> -		int result;
> -
> -		ret = IIO_VAL_INT;
>  		mutex_lock(&st->lock);
> -		result = iio_device_claim_direct_mode(indio_dev);
> -		if (result)
> -			goto error_read_raw_unlock;
> -		result = inv_mpu6050_set_power_itg(st, true);
> -		if (result)
> -			goto error_read_raw_release;
> -		switch (chan->type) {
> -		case IIO_ANGL_VEL:
> -			result = inv_mpu6050_switch_engine(st, true,
> -					INV_MPU6050_BIT_PWR_GYRO_STBY);
> -			if (result)
> -				goto error_read_raw_power_off;
> -			ret = inv_mpu6050_sensor_show(st, st->reg->raw_gyro,
> -						      chan->channel2, val);
> -			result = inv_mpu6050_switch_engine(st, false,
> -					INV_MPU6050_BIT_PWR_GYRO_STBY);
> -			if (result)
> -				goto error_read_raw_power_off;
> -			break;
> -		case IIO_ACCEL:
> -			result = inv_mpu6050_switch_engine(st, true,
> -					INV_MPU6050_BIT_PWR_ACCL_STBY);
> -			if (result)
> -				goto error_read_raw_power_off;
> -			ret = inv_mpu6050_sensor_show(st, st->reg->raw_accl,
> -						      chan->channel2, val);
> -			result = inv_mpu6050_switch_engine(st, false,
> -					INV_MPU6050_BIT_PWR_ACCL_STBY);
> -			if (result)
> -				goto error_read_raw_power_off;
> -			break;
> -		case IIO_TEMP:
> -			/* wait for stablization */
> -			msleep(INV_MPU6050_SENSOR_UP_TIME);
> -			ret = inv_mpu6050_sensor_show(st, st->reg->temperature,
> -						IIO_MOD_X, val);
> -			break;
> -		default:
> -			ret = -EINVAL;
> -			break;
> -		}
> -error_read_raw_power_off:
> -		result |= inv_mpu6050_set_power_itg(st, false);
> -error_read_raw_release:
> -		iio_device_release_direct_mode(indio_dev);
> -error_read_raw_unlock:
> +		ret = inv_mpu6050_read_channel_data(indio_dev, chan, val);
>  		mutex_unlock(&st->lock);
> -		if (result)
> -			return result;
> -
> -		return ret;
> -	}
> +		break;
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_ANGL_VEL:
> @@ -405,27 +413,33 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  			*val  = 0;
>  			*val2 = gyro_scale_6050[st->chip_config.fsr];
>  			mutex_unlock(&st->lock);
> -			return IIO_VAL_INT_PLUS_NANO;
> +			ret = IIO_VAL_INT_PLUS_NANO;
> +			break;
>  		case IIO_ACCEL:
>  			mutex_lock(&st->lock);
>  			*val = 0;
>  			*val2 = accel_scale[st->chip_config.accl_fs];
>  			mutex_unlock(&st->lock);
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
>  		case IIO_TEMP:
>  			*val = 0;
>  			*val2 = INV_MPU6050_TEMP_SCALE;
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			break;
>  		}
>  	case IIO_CHAN_INFO_OFFSET:
>  		switch (chan->type) {
>  		case IIO_TEMP:
>  			*val = INV_MPU6050_TEMP_OFFSET;
> -			return IIO_VAL_INT;
> +			ret = IIO_VAL_INT;
> +			break;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			break;
>  		}
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
> @@ -434,19 +448,23 @@ static int inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
>  						chan->channel2, val);
>  			mutex_unlock(&st->lock);
> -			return IIO_VAL_INT;
> +			break;
>  		case IIO_ACCEL:
>  			mutex_lock(&st->lock);
>  			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
>  						chan->channel2, val);
>  			mutex_unlock(&st->lock);
> -			return IIO_VAL_INT;
> +			break;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			break;
>  		}
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
No, direct returns in kernel always preferred if there is
not cleanup to do like here.
> +		break;
>  	}
> +
> +	return ret;
>  }
>  
>  static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)

