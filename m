Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44982 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbaBOM1m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Feb 2014 07:27:42 -0500
Message-ID: <52FF5D61.4080506@kernel.org>
Date: Sat, 15 Feb 2014 12:28:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <GGao@invensense.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] iio: imu: inv_mpu6050: Add basic support for mpu9150
References: <1391596475-21986-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <52F623AA.6020905@kernel.org> <E7747D604FBC9F43A71AA431AFF44762104C3FB8@IUSEXCH01.invcorp.invensense.com> <201402101939.46467.manuel.stahl@iis.fraunhofer.de> <E7747D604FBC9F43A71AA431AFF44762104C57AF@IUSEXCH01.invcorp.invensense.com>
In-Reply-To: <E7747D604FBC9F43A71AA431AFF44762104C57AF@IUSEXCH01.invcorp.invensense.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/02/14 19:12, Ge Gao wrote:
> One of the concern of this primary bus usage is that if the MPU9150
> is in sleep mode, the bypass mode won't work. The standalone primary
> bus driver won't be able to access the AKM8975 compass. There is some
> dependency between the two and the standalone AK8975 driver won't be
> standalone. For the bypass mode problem you mentioned, it might be
> VDDIO? It will depend on your PCB routings.
>
Perhaps this bus interaction needs to be apparent in the driver.  It's
a little hideous, but how about a i2 bus multiplexer with only one output?

That might allow such dependencies to be represented.

Wolfram, what do you think?

In short we have a device that sits on an i2c bus and supports its own
i2c bus (mainly so that the internal processor can use data from devices
on that bus) including support for passing the bus straight through.
The issues is the dependencies when the intermediate device is sleeping
for example.

> Thanks.
>
> Ge
>
>
> -----Original Message-----
> From: Manuel Stahl [mailto:manuel.stahl@iis.fraunhofer.de]
> Sent: Monday, February 10, 2014 10:40 AM
> To: Ge Gao
> Cc: Jonathan Cameron; linux-iio@vger.kernel.org
> Subject: Re: [PATCH 3/3] iio: imu: inv_mpu6050: Add basic support for mpu9150
>
> Hi Ge,
>
> thanks for your approval. You're right, that the compass should be accessed internally. Actually I had some problems with the bypass mode (I can not disable it, but might be a problem of the PCB), so I started with the minimal approach.
>
> Best regards,
> Manuel Stahl
>
> Am Montag, 10. Februar 2014, 19:20:59 schrieb Ge Gao:
>> This is looks fine to me. It is used for primary bus for compass. However, the actual use for MPU9150 is through a secondary bus interface for MPU9150. This interface send a fixed preprogrammed command to AK8975 compass to make it work. The compass result can be read through registers located in MPU9150.
>>
>> Thanks.
>>
>> Best Regards,
>>
>> Ge GAO
>>
>>
>> -----Original Message-----
>> From: Jonathan Cameron [mailto:jic23@kernel.org]
>> Sent: Saturday, February 08, 2014 4:32 AM
>> To: Manuel Stahl; jic23@cam.ac.uk
>> Cc: Ge Gao; linux-iio@vger.kernel.org
>> Subject: Re: [PATCH 3/3] iio: imu: inv_mpu6050: Add basic support for
>> mpu9150
>>
>> On 05/02/14 10:34, Manuel Stahl wrote:
>>> The magnetometer included in the mpu9150 will be exported to the I2C
>>> bus at address 0x0C and can be accessed by the IIO driver ak8975.
>>>
>>> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
>> This looks straight forward to me, but I'll let it sit for a few days to give Ge an oportunity to comment.
>>
>> Jonathan
>>
>>> ---
>>>    drivers/iio/imu/inv_mpu6050/Kconfig        |  6 ++++--
>>>    drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 21 ++++++++++++++++++++-
>>>    drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++++
>>>    3 files changed, 28 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig
>>> b/drivers/iio/imu/inv_mpu6050/Kconfig
>>> index 361b232..9843f9e 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
>>> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
>>> @@ -3,12 +3,14 @@
>>>    #
>>>
>>>    config INV_MPU6050_IIO
>>> -	tristate "Invensense MPU6050 devices"
>>> +	tristate "Invensense MPU6050 and MPU9150 devices"
>>>    	depends on I2C && SYSFS
>>>    	select IIO_BUFFER
>>>    	select IIO_TRIGGERED_BUFFER
>>>    	help
>>> -	  This driver supports the Invensense MPU6050 devices.
>>> +	  This driver supports the Invensense MPU6050 and MPU9150 devices.
>>>    	  It is a gyroscope/accelerometer combo device.
>>> +	  The MPU9150 has an additional magnetometer, but this is currently
>>> +	  only exported as a separate device on I2C address 0x0C.
>>>    	  This driver can be built as a module. The module will be called
>>>    	  inv-mpu6050.
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> index fda1ee2..a121b5c 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> @@ -71,6 +71,12 @@ static const struct inv_mpu6050_hw hw_info[INV_NUM_PARTS] = {
>>>    		.reg = &reg_set_6050,
>>>    		.config = &chip_config_6050,
>>>    	},
>>> +	{
>>> +		.num_reg = 118,
>>> +		.name = "MPU9150",
>>> +		.reg = &reg_set_6050,
>>> +		.config = &chip_config_6050,
>>> +	},
>>>    };
>>>
>>>    int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg,
>>> u8
>>> d) @@ -616,7 +622,12 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
>>>    {
>>>    	int result;
>>>
>>> -	st->chip_type = INV_MPU6050;
>>> +	st->chip_type = (unsigned)id->driver_data;
>>> +	if (st->chip_type >= INV_NUM_PARTS) {
>>> +		dev_err(&st->client->dev,
>>> +			"Invalid chip type: %s.\n", id->name);
>>> +		return -ENODEV;
>>> +	}
>>>    	st->hw  = &hw_info[st->chip_type];
>>>    	st->reg = hw_info[st->chip_type].reg;
>>>
>>> @@ -646,6 +657,11 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
>>>    	if (result)
>>>    		return result;
>>>
>>> +	/* set to bypass mode */
>>> +	result = inv_mpu6050_write_reg(st, INV_MPU6050_REG_INT_PIN_CFG,
>>> +			INV_MPU6050_BIT_BYPASS_EN);
>>> +	if (result)
>>> +		return result;
>>>    	return 0;
>>>    }
>>>
>>> @@ -719,6 +735,8 @@ static int inv_mpu_probe(struct i2c_client *client,
>>>    		goto out_remove_trigger;
>>>    	}
>>>
>>> +	dev_info(&st->client->dev, "IMU %s found\n", id->name);
>>> +
>>>    	return 0;
>>>
>>>    out_remove_trigger:
>>> @@ -765,6 +783,7 @@ static SIMPLE_DEV_PM_OPS(inv_mpu_pmops, inv_mpu_suspend, inv_mpu_resume);
>>>     */
>>>    static const struct i2c_device_id inv_mpu_id[] = {
>>>    	{"mpu6050", INV_MPU6050},
>>> +	{"mpu9150", INV_MPU9150},
>>>    	{}
>>>    };
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> index 0ab382b..d91b1e4 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> @@ -59,6 +59,7 @@ struct inv_mpu6050_reg_map {
>>>    /*device enum */
>>>    enum inv_devices {
>>>    	INV_MPU6050,
>>> +	INV_MPU9150,
>>>    	INV_NUM_PARTS
>>>    };
>>>
>>> @@ -132,6 +133,9 @@ struct inv_mpu6050_state {
>>>    #define INV_MPU6050_BIT_ACCEL_OUT           0x08
>>>    #define INV_MPU6050_BITS_GYRO_OUT           0x70
>>>
>>> +#define INV_MPU6050_REG_INT_PIN_CFG         0x37
>>> +#define INV_MPU6050_BIT_BYPASS_EN           0x02
>>> +
>>>    #define INV_MPU6050_REG_INT_ENABLE          0x38
>>>    #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
>>>    #define INV_MPU6050_BIT_DMP_INT_EN          0x02
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

