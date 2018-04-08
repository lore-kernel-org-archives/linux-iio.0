Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:57568 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeDHQZc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Apr 2018 12:25:32 -0400
Date: Sun, 8 Apr 2018 17:25:28 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: rewrite and clean read raw for
 channel data
Message-ID: <20180408172528.7621a943@archlinux>
In-Reply-To: <CY4PR1201MB0184D044234A1EFE66849546C4BA0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB0184D044234A1EFE66849546C4BA0@CY4PR1201MB0184.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 6 Apr 2018 08:22:43 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Factorize reading channel data in its own function and use a single
> return path at the end of the global read_raw function.
Why this single return path?  I don't see it added anything...

> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Hmm. I really don't like how this was originally done.  It makes
for some very complex and hard to verify code.

Now you have it factored out, please also tidy up the function
to make it do more normal error handling etc.

I should have picked up on how nasty this is originally.
Particularly that |= for result. 


> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 158 ++++++++++++++++-------------
>  1 file changed, 87 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 7d64be3..27fe86c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -314,73 +314,81 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
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
Two options here.

Personally I prefer having a single variable for returns throughout.
Others prefer to separate the 'good' and 'bad' possible returns.
If you want to do that, call "result" "error" then it is obvious
that is what you are doing.

> +
> +	result = iio_device_claim_direct_mode(indio_dev);
> +	if (result)
> +		return result;
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

This can return an error, but you have no handling for it. I want
to see this error, not a different one if this is followed by
problems in the switch_engine.


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

Same as above.

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
Never do an or with error variables, it makes for code that is
very hard to review and very likely to be broken some time
in the future by someone who didn't check all the combinations
that can occur.

> +error_release:
> +	iio_device_release_direct_mode(indio_dev);
> +	if (result)
> +		return result;
> +
> +	return ret;
> +}
> +
>  static int
>  inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  		     struct iio_chan_spec const *chan,
>  		     int *val, int *val2, long mask)
>  {
>  	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
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
> @@ -388,32 +396,36 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
>  			*val  = 0;
>  			*val2 = gyro_scale_6050[st->chip_config.fsr];
>  			mutex_unlock(&st->lock);
> -
> -			return IIO_VAL_INT_PLUS_NANO;
> +			ret = IIO_VAL_INT_PLUS_NANO;
> +			break;
>  		case IIO_ACCEL:
>  			mutex_lock(&st->lock);
>  			*val = 0;
>  			*val2 = accel_scale[st->chip_config.accl_fs];
>  			mutex_unlock(&st->lock);
> -
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
>  		case IIO_TEMP:
>  			*val = 0;
>  			*val2 = INV_MPU6050_TEMP_SCALE;
> -
> -			return IIO_VAL_INT_PLUS_MICRO;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			break;
>  		}
> +		break;
>  	case IIO_CHAN_INFO_OFFSET:
>  		switch (chan->type) {
>  		case IIO_TEMP:
>  			*val = INV_MPU6050_TEMP_OFFSET;
> -
> -			return IIO_VAL_INT;
> +			ret = IIO_VAL_INT;
> +			break;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			break;
>  		}
> +		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		switch (chan->type) {
>  		case IIO_ANGL_VEL:
> @@ -421,20 +433,24 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
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
> -
Hmm. Error handling was originally wrong here and in some of the
other cases, good to clear that up..

> +			break;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			break;
>  		}
> +		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		break;
>  	}
> +
> +	return ret;
Don't do this.  Direct returns preferred whenever there isn't any shared
cleanup to do.

>  }
>  
>  static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st, int val)

