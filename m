Return-Path: <JManeyrol@invensense.com>
Subject: Re: [PATCH v3 1/4] iio: imu: inv_mpu6050: fix error path not turning
 chip back off
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org
References: <1523952442-20104-1-git-send-email-jmaneyrol@invensense.com>
 <20180421160756.4df8cd6c@archlinux>
From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Message-ID: <1dff6674-e898-cd1e-9f74-14d2921e1519@invensense.com>
Date: Mon, 23 Apr 2018 12:29:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180421160756.4df8cd6c@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 21/04/2018 17:07, Jonathan Cameron wrote:
> On Tue, 17 Apr 2018 10:07:19 +0200
> Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:
> 
>> Some functions are turning the chip on and not back off in error
>> path. With set_power function using a reference counter that
>> would keep the chip on forever.
> No sign off so I can't apply.
> 
> Also a minor thing I noticed inline (unconnected to the patch)
> 
> Thanks,
> 
> Jonathan

Sorry for the inconvenient, my fault. I am resending the series 
including the fix you mentioned.

JB
> 
>> ---
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 12 ++++++---
>>   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 35 ++++++++++++++++++---------
>>   2 files changed, 32 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> index 20b94d9..ba2f08e 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> @@ -268,27 +268,31 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
>>   	d = (INV_MPU6050_FSR_2000DPS << INV_MPU6050_GYRO_CONFIG_FSR_SHIFT);
>>   	result = regmap_write(st->map, st->reg->gyro_config, d);
>>   	if (result)
>> -		return result;
>> +		goto error_power_off;
>>   
>>   	result = inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
>>   	if (result)
>> -		return result;
>> +		goto error_power_off;
>>   
>>   	d = INV_MPU6050_ONE_K_HZ / INV_MPU6050_INIT_FIFO_RATE - 1;
>>   	result = regmap_write(st->map, st->reg->sample_rate_div, d);
>>   	if (result)
>> -		return result;
>> +		goto error_power_off;
>>   
>>   	d = (INV_MPU6050_FS_02G << INV_MPU6050_ACCL_CONFIG_FSR_SHIFT);
>>   	result = regmap_write(st->map, st->reg->accl_config, d);
>>   	if (result)
>> -		return result;
>> +		goto error_power_off;
>>   
>>   	memcpy(&st->chip_config, hw_info[st->chip_type].config,
>>   	       sizeof(struct inv_mpu6050_chip_config));
>>   	result = inv_mpu6050_set_power_itg(st, false);
>>   
>>   	return result;
> 
> Whilst you are here why not combine the two lines
> above and avoid assigning result...
> 
>> +
>> +error_power_off:
>> +	inv_mpu6050_set_power_itg(st, false);
>> +	return result;
>>   }
>>   
>>   static int inv_mpu6050_sensor_set(struct inv_mpu6050_state  *st, int reg,
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>> index f963f9f..27aa976 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
>> @@ -53,45 +53,58 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>>   			result = inv_mpu6050_switch_engine(st, true,
>>   					INV_MPU6050_BIT_PWR_GYRO_STBY);
>>   			if (result)
>> -				return result;
>> +				goto error_power_off;
>>   		}
>>   		if (st->chip_config.accl_fifo_enable) {
>>   			result = inv_mpu6050_switch_engine(st, true,
>>   					INV_MPU6050_BIT_PWR_ACCL_STBY);
>>   			if (result)
>> -				return result;
>> +				goto error_gyro_off;
>>   		}
>>   		result = inv_reset_fifo(indio_dev);
>>   		if (result)
>> -			return result;
>> +			goto error_accl_off;
>>   	} else {
>>   		result = regmap_write(st->map, st->reg->fifo_en, 0);
>>   		if (result)
>> -			return result;
>> +			goto error_accl_off;
>>   
>>   		result = regmap_write(st->map, st->reg->int_enable, 0);
>>   		if (result)
>> -			return result;
>> +			goto error_accl_off;
>>   
>>   		result = regmap_write(st->map, st->reg->user_ctrl, 0);
>>   		if (result)
>> -			return result;
>> +			goto error_accl_off;
>>   
>>   		result = inv_mpu6050_switch_engine(st, false,
>> -					INV_MPU6050_BIT_PWR_GYRO_STBY);
>> +					INV_MPU6050_BIT_PWR_ACCL_STBY);
>>   		if (result)
>> -			return result;
>> +			goto error_accl_off;
>>   
>>   		result = inv_mpu6050_switch_engine(st, false,
>> -					INV_MPU6050_BIT_PWR_ACCL_STBY);
>> +					INV_MPU6050_BIT_PWR_GYRO_STBY);
>>   		if (result)
>> -			return result;
>> +			goto error_gyro_off;
>> +
>>   		result = inv_mpu6050_set_power_itg(st, false);
>>   		if (result)
>> -			return result;
>> +			goto error_power_off;
>>   	}
>>   
>>   	return 0;
>> +
>> +error_accl_off:
>> +	if (st->chip_config.accl_fifo_enable)
>> +		inv_mpu6050_switch_engine(st, false,
>> +					  INV_MPU6050_BIT_PWR_ACCL_STBY);
>> +error_gyro_off:
>> +	if (st->chip_config.gyro_fifo_enable)
>> +		inv_mpu6050_switch_engine(st, false,
>> +					  INV_MPU6050_BIT_PWR_GYRO_STBY);
>> +error_power_off:
>> +	inv_mpu6050_set_power_itg(st, false);
>> +	return result;
>>   }
>>   
>>   /**
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
