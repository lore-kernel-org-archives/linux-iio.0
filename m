Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34831 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbbCHLGv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 07:06:51 -0400
Message-ID: <54FC2D48.6000300@kernel.org>
Date: Sun, 08 Mar 2015 11:06:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Suman, Viorel" <viorel.suman@intel.com>,
	"Reus, Adriana" <adriana.reus@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
	Ge Gao <ggao@invensense.com>
Subject: Re: [PATCH] iio:inv-mpu6050: Fix inconsistency for the scale channel
References: <1424702451-1299-1-git-send-email-adriana.reus@intel.com> <2FFB68359810C64CBFB43927F67FC93F48873F58@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2FFB68359810C64CBFB43927F67FC93F48873F58@IRSMSX102.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/03/15 13:57, Suman, Viorel wrote:
> 
>> -----Original Message-----
>> From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
>> owner@vger.kernel.org] On Behalf Of Adriana Reus
>> Sent: Monday, February 23, 2015 4:41 PM
>> To: jic23@kernel.org; linux-iio@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; Pandruvada, Srinivas; Reus, Adriana
>> Subject: [PATCH] iio:inv-mpu6050: Fix inconsistency for the scale channel
>>
>> Fix inconsistency in the semantics of the scale attribute.
>> For scale the write_raw function was considering the scale table index and
>> writing the appropriate value into the range register, while for read_raw it
>> was outputting the actual scale.
>> Fix this behaviour and adhere to the iio ABI specification.
>>
>> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> 
> Reviewed-by: Viorel Suman <viorel.suman@intel.com>
Good catch.  I'd just like to give Ge an opportunity to comment
before applying it.

Please do CC the original driver author as often they've moved on to
other stuff and aren't actively reading linux-iio anymore.

Jonathan
> 
>> ---
>>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 56 ++++++++++++++++--
>> ------------
>>  1 file changed, 30 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> index 9be9b20..4cf056d 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> @@ -401,42 +401,46 @@ error_read_raw:
>>  	}
>>  }
>>
>> -static int inv_mpu6050_write_fsr(struct inv_mpu6050_state *st, int fsr)
>> +static int inv_mpu6050_write_gyro_scale(struct inv_mpu6050_state *st,
>> +int val)
>>  {
>> -	int result;
>> +	int result, i;
>>  	u8 d;
>>
>> -	if (fsr < 0 || fsr > INV_MPU6050_MAX_GYRO_FS_PARAM)
>> -		return -EINVAL;
>> -	if (fsr == st->chip_config.fsr)
>> -		return 0;
>> +	for (i = 0; i < ARRAY_SIZE(gyro_scale_6050); ++i) {
>> +		if (gyro_scale_6050[i] == val) {
>> +			d = (i <<
>> INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
>> +			result = inv_mpu6050_write_reg(st,
>> +					st->reg->gyro_config, d);
>> +			if (result)
>> +				return result;
>>
>> -	d = (fsr << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
>> -	result = inv_mpu6050_write_reg(st, st->reg->gyro_config, d);
>> -	if (result)
>> -		return result;
>> -	st->chip_config.fsr = fsr;
>> +			st->chip_config.fsr = i;
>> +			return 0;
>> +		}
>> +	}
>>
>> -	return 0;
>> +	return -EINVAL;
>>  }
>>
>> -static int inv_mpu6050_write_accel_fs(struct inv_mpu6050_state *st, int
>> fs)
>> +static int inv_mpu6050_write_accel_scale(struct inv_mpu6050_state *st,
>> +int val)
>>  {
>> -	int result;
>> +	int result, i;
>>  	u8 d;
>>
>> -	if (fs < 0 || fs > INV_MPU6050_MAX_ACCL_FS_PARAM)
>> -		return -EINVAL;
>> -	if (fs == st->chip_config.accl_fs)
>> -		return 0;
>> +	for (i = 0; i < ARRAY_SIZE(accel_scale); ++i) {
>> +		if (accel_scale[i] == val) {
>> +			d = (i << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
>> +			result = inv_mpu6050_write_reg(st,
>> +					st->reg->accl_config, d);
>> +			if (result)
>> +				return result;
>>
>> -	d = (fs << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
>> -	result = inv_mpu6050_write_reg(st, st->reg->accl_config, d);
>> -	if (result)
>> -		return result;
>> -	st->chip_config.accl_fs = fs;
>> +			st->chip_config.accl_fs = i;
>> +			return 0;
>> +		}
>> +	}
>>
>> -	return 0;
>> +	return -EINVAL;
>>  }
>>
>>  static int inv_mpu6050_write_raw(struct iio_dev *indio_dev, @@ -463,10
>> +467,10 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>>  	case IIO_CHAN_INFO_SCALE:
>>  		switch (chan->type) {
>>  		case IIO_ANGL_VEL:
>> -			result = inv_mpu6050_write_fsr(st, val);
>> +			result = inv_mpu6050_write_gyro_scale(st, val2);
>>  			break;
>>  		case IIO_ACCEL:
>> -			result = inv_mpu6050_write_accel_fs(st, val);
>> +			result = inv_mpu6050_write_accel_scale(st, val2);
>>  			break;
>>  		default:
>>  			result = -EINVAL;
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info
>> at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

