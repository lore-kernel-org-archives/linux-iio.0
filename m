Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <534B461A.8040408@linux.intel.com>
Date: Sun, 13 Apr 2014 19:21:14 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
 Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch v1 2/4] iio: imu: inv_mpu6050: Enable default bypass mode
References: <1395248203-17027-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1395248203-17027-2-git-send-email-srinivas.pandruvada@linux.intel.com> <5336A540.7060309@kernel.org> <53487997.3070906@linux.intel.com> <53496992.7070808@kernel.org>
In-Reply-To: <53496992.7070808@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>


On 04/12/2014 09:28 AM, Jonathan Cameron wrote:
> On 12/04/14 00:24, Srinivas Pandruvada wrote:
>> On 03/29/2014 03:49 AM, Jonathan Cameron wrote:
>>> On 19/03/14 16:56, Srinivas Pandruvada wrote:
>>>> This chip has two modes to control secondary sensor attached to it.
>>>> One is master mode and another is bypass mode. In master mode
>>>> MPU6500 will directly communicates to the secondary sensor device
>>>> attached to it. This can support very few secondary devices in this
>>>> mode.
>>>> But when configured in bypass mode the i2c lines are directly 
>>>> connected
>>>> to host i2c bus controller.
>>>> Since in master mode it can only support few devices and they are not
>>>> implemented in this driver, set the default mode to bypass mode.
>>>> When some multiplexer is implemented to use MPU6050 master mode,
>>>> this mode can be enabled when requested.
>>>>
>>>> Signed-off-by: Srinivas Pandruvada 
>>>> <srinivas.pandruvada@linux.intel.com>
>>> To my understanding this still doesn't deal with the fact that devices
>>> on the slave bus are not connected if this driver is not loaded or has
>>> gone to sleep.  Hence this needs as previously discussed to be done as
>>> a single input, single output i2c mux.  That way the kernel 'knows'
>>> there is something inbetween that needs to be in the correct state.
>>>
>>
>> I am looking at a way to implement multiplexing 1:1 as suggested in 
>> email chains.
>> The problem I have:
>> My two slave devices (MPU6XXX and AK8963 enumerated via ACPI. So they 
>> i2clients are already tied to the I2C adapter.
> So the ACPI has no description of the fact that the ak8963 is 
> connected through the
> MPU device.  That's irritating.
>
>> We don't have a board setup file in PC like platform.
>> I have implemented in mux in MPU6XXX driver. But AK8963 driver is not
>> aware about mux adapter, it will not call my mux select function. So
>> I feel that we need to have a board setup file, to correctly create
>> i2C clients attaching to correct adapter for using this design. Is
>> this correct?
> It ought to be possible to do it from ACPI enumeration but
> only if there is some representation of the topology from ACPI.
> Otherwise we will need to represent this weirdness somewhere...
>
The ACPI definition currently defined for non-bypass mode for Win8 
driver in popular Asus T100 tablet.
I will hold onto my MPU6XXX patches for sometimes, till I find a way to 
introduce this weirdness somewhere in T100 specific platform driver.

Thanks,
Srinivas
>>
>> Thanks,
>> Srinivas
>>
>>
>>
>>
>>> Jonathan
>>>> ---
>>>>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 ++++++++++++++++++-
>>>>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++++
>>>>   2 files changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c 
>>>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>>> index 52d688b..744eba4 100644
>>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>>> @@ -53,6 +53,7 @@ static const struct inv_mpu6050_reg_map 
>>>> reg_set_6050 = {
>>>>       .int_enable             = INV_MPU6050_REG_INT_ENABLE,
>>>>       .pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
>>>>       .pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
>>>> +    .int_pin_cfg        = INV_MPU6050_REG_INT_PIN_CFG,
>>>>   };
>>>>
>>>>   static const struct inv_mpu6050_chip_config chip_config_6050 = {
>>>> @@ -608,6 +609,20 @@ static const struct iio_info mpu_info = {
>>>>       .validate_trigger = inv_mpu6050_validate_trigger,
>>>>   };
>>>>
>>>> +static int inv_set_bypass_status(struct inv_mpu6050_state *st, 
>>>> bool enable)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    if (enable)
>>>> +        ret = inv_mpu6050_write_reg(st, st->reg->int_pin_cfg,
>>>> +                    st->client->irq |
>>>> +                        INV_MPU6050_BIT_BYPASS_EN);
>>>> +    else
>>>> +        ret = inv_mpu6050_write_reg(st, st->reg->int_pin_cfg,
>>>> +                    st->client->irq);
>>>> +    return ret;
>>>> +}
>>>> +
>>>>   /**
>>>>    *  inv_check_and_setup_chip() - check and setup chip.
>>>>    */
>>>> @@ -646,7 +661,9 @@ static int inv_check_and_setup_chip(struct 
>>>> inv_mpu6050_state *st,
>>>>       if (result)
>>>>           return result;
>>>>
>>>> -    return 0;
>>>> +    result = inv_set_bypass_status(st, true);
>>>> +
>>>> +    return result;
>>>>   }
>>>>
>>>>   /**
>>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h 
>>>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>>> index 4ddfd03..591ac2e 100644
>>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>>> @@ -54,6 +54,7 @@ struct inv_mpu6050_reg_map {
>>>>       u8 int_enable;
>>>>       u8 pwr_mgmt_1;
>>>>       u8 pwr_mgmt_2;
>>>> +    u8 int_pin_cfg;
>>>>   };
>>>>
>>>>   /*device enum */
>>>> @@ -186,6 +187,9 @@ struct inv_mpu6050_state {
>>>>   #define INV_MPU6050_MIN_FIFO_RATE 4
>>>>   #define INV_MPU6050_ONE_K_HZ 1000
>>>>
>>>> +#define INV_MPU6050_REG_INT_PIN_CFG        0x37
>>>> +#define INV_MPU6050_BIT_BYPASS_EN        0x2
>>>> +
>>>>   /* scan element definition */
>>>>   enum inv_mpu6050_scan {
>>>>       INV_MPU6050_SCAN_ACCL_X,
>>>>
>>>
>>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
