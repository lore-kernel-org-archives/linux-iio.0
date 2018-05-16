Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0074.outbound.protection.outlook.com ([104.47.38.74]:7424
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751153AbeEPQUC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 May 2018 12:20:02 -0400
Subject: Re: [PATCH 2/5] iio: imu: inv_mpu6050: switch to use sample rate
 divider
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org
References: <1526331955-11869-1-git-send-email-jmaneyrol@invensense.com>
 <1526331955-11869-2-git-send-email-jmaneyrol@invensense.com>
 <4bd03345-1805-a87a-3222-9156b6a1137c@xevo.com>
 <e4e65547-d774-8c82-c5fb-cac302f86c29@invensense.com>
From: Martin Kelly <mkelly@xevo.com>
Message-ID: <bf00f3f5-2da0-0190-af1c-499b3de4fa03@xevo.com>
Date: Wed, 16 May 2018 09:19:52 -0700
MIME-Version: 1.0
In-Reply-To: <e4e65547-d774-8c82-c5fb-cac302f86c29@invensense.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/16/2018 12:08 AM, Jean-Baptiste Maneyrol wrote:
> 
> 
> On 15/05/2018 21:08, Martin Kelly wrote:
>> CAUTION: This email originated from outside of the organization. 
>> Please make sure the sender is who they say they are and do not click 
>> links or open attachments unless you recognize the sender and know the 
>> content is safe.
>>
>>
>> On 05/14/2018 02:05 PM, Jean-Baptiste Maneyrol wrote:
>>> Instead of storing fifo rate in Hz, store the chip internal sample
>>> rate divider. This will be more useful for timestamping. There
>>> are both equivalent.
>>>
>>> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>>> ---
>>>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 15 +++++++++------
>>>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++--
>>>   2 files changed, 11 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c 
>>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> index 1e7e750..9e5c5e7 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> @@ -82,7 +82,7 @@ static const struct inv_mpu6050_reg_map 
>>> reg_set_6050 = {
>>>   static const struct inv_mpu6050_chip_config chip_config_6050 = {
>>>       .fsr = INV_MPU6050_FSR_2000DPS,
>>>       .lpf = INV_MPU6050_FILTER_20HZ,
>>> -     .fifo_rate = INV_MPU6050_INIT_FIFO_RATE,
>>> +     .divider = (INV_MPU6050_ONE_K_HZ / INV_MPU6050_INIT_FIFO_RATE) 
>>> - 1,
>>>       .gyro_fifo_enable = false,
>>>       .accl_fifo_enable = false,
>>>       .accl_fs = INV_MPU6050_FS_02G,
>>> @@ -628,7 +628,7 @@ static ssize_t
>>>   inv_mpu6050_fifo_rate_store(struct device *dev, struct 
>>> device_attribute *attr,
>>>                           const char *buf, size_t count)
>>>   {
>>> -     s32 fifo_rate;
>>> +     int fifo_rate;
>>>       u8 d;
>>
>> Since the divider is a u8, I think the fifo_rate should also be unsigned
>> (I think u8 would fit it, but unsigned int should be fine too).
> fifo_rate is taken from sysfs entry using kstrtoint which requires a 
> signed int. The user can enter any number, even negative ones. Using a 
> signed integer for reading the entry enables to catch negative number 
> and return EINVAL for them.
> 

Yes, you are right. In this case we have a check for the range 4-1000, 
so the division will be safe. I suspect the compiler will generate a 
warning here about mixing types, but I think it's not turned on.

>>
>>>       int result;
>>>       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>> @@ -644,8 +644,12 @@ inv_mpu6050_fifo_rate_store(struct device *dev, 
>>> struct device_attribute *attr,
>>>       if (result)
>>>               return result;
>>>
>>> +     /* compute freq divider and update fifo rate in case of 
>>> truncation */
>>> +     d = INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
>>> +     fifo_rate = INV_MPU6050_ONE_K_HZ / (d + 1);
>>> +
>>
>> I don't quite understand why we need to set fifo_rate again. Could you
>> explain?
> Since fifo_rate is an arbitrary number coming from userspace, it can be 
> a rate that is not supported by the chip (not a divider of 1KHz). For 
> dealing with this case, I compute first the divider using provided 
> value. This computation will return a truncated number that is not 
> providing necessary the fifo rate asked if it is not supported. So I 
> compute back the fifo rate using this divider to store the real value.
> 

Yes, makes sense. If the user gives an evenly divisible number, they 
will be the same, but if not, we need to calculate in the way you do.

>>
>>>       mutex_lock(&st->lock);
>>> -     if (fifo_rate == st->chip_config.fifo_rate) {
>>> +     if (d == st->chip_config.divider) {
>>>               result = 0;
>>>               goto fifo_rate_fail_unlock;
>>>       }
>>> @@ -653,11 +657,10 @@ inv_mpu6050_fifo_rate_store(struct device *dev, 
>>> struct device_attribute *attr,
>>>       if (result)
>>>               goto fifo_rate_fail_unlock;
>>>
>>> -     d = INV_MPU6050_ONE_K_HZ / fifo_rate - 1;
>>>       result = regmap_write(st->map, st->reg->sample_rate_div, d);
>>>       if (result)
>>>               goto fifo_rate_fail_power_off;
>>> -     st->chip_config.fifo_rate = fifo_rate;
>>> +     st->chip_config.divider = d;
>>>
>>>       result = inv_mpu6050_set_lpf(st, fifo_rate);
>>>       if (result)
>>> @@ -685,7 +688,7 @@ inv_fifo_rate_show(struct device *dev, struct 
>>> device_attribute *attr,
>>>       unsigned fifo_rate;
>>>
>>>       mutex_lock(&st->lock);
>>> -     fifo_rate = st->chip_config.fifo_rate;
>>> +     fifo_rate = INV_MPU6050_ONE_K_HZ / (st->chip_config.divider + 1);
>>
>> Since we use this same line twice, I think it would be useful to put it
>> in a function inv_calculate_fifo_rate(u8 divider) or similar.
> That is indeed possible.
> 
>>
>>>       mutex_unlock(&st->lock);
>>>
>>>       return scnprintf(buf, PAGE_SIZE, "%u\n", fifo_rate);
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h 
>>> b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> index a92ddd4..8d9044c 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
>>> @@ -86,7 +86,7 @@ enum inv_devices {
>>>    *  @accl_fs:               accel full scale range.
>>>    *  @accl_fifo_enable:      enable accel data output
>>>    *  @gyro_fifo_enable:      enable gyro data output
>>> - *  @fifo_rate:              FIFO update rate.
>>> + *  @divider:                sample rate divider.
>>>    */
>>>   struct inv_mpu6050_chip_config {
>>>       unsigned int fsr:2;
>>> @@ -94,7 +94,7 @@ struct inv_mpu6050_chip_config {
>>>       unsigned int accl_fs:2;
>>>       unsigned int accl_fifo_enable:1;
>>>       unsigned int gyro_fifo_enable:1;
>>> -     u16 fifo_rate;
>>> +     u8 divider;
>>>       u8 user_ctrl;
>>>   };
>>>
>>>
