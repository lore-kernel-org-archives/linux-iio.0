Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46801 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeJPASY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Oct 2018 20:18:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id r64-v6so9936022pfb.13
        for <linux-iio@vger.kernel.org>; Mon, 15 Oct 2018 09:32:26 -0700 (PDT)
Subject: Re: [PATCH] iio: st_sensors: miscellaneous cleanup
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20181015002705.19748-1-martin@martingkelly.com>
 <20181015170300.00001867@huawei.com>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <bec246b0-f173-3861-acf1-1a2c59cd2d96@martingkelly.com>
Date: Mon, 15 Oct 2018 09:32:24 -0700
MIME-Version: 1.0
In-Reply-To: <20181015170300.00001867@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/15/18 9:03 AM, Jonathan Cameron wrote:
> On Sun, 14 Oct 2018 17:27:05 -0700
> Martin Kelly <martin@martingkelly.com> wrote:
> 
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> Miscellaneous cleanup to fix minor consistency, grammar, and spelling
>> issues.
>>
>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> Hi Martin,
> 
> Always nice to tidy up the corners.
> 
> A few comments inline...
> 
>> ---
>>   drivers/iio/common/st_sensors/st_sensors_core.c    | 4 ++--
>>   drivers/iio/common/st_sensors/st_sensors_trigger.c | 4 ++--
>>   drivers/iio/magnetometer/st_magn_core.c            | 6 +++---
>>   3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
>> index 26fbd1bd9413..82882bc505f5 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
>> @@ -133,7 +133,7 @@ static int st_sensors_match_fs(struct st_sensor_settings *sensor_settings,
>>   
>>   	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
>>   		if (sensor_settings->fs.fs_avl[i].num == 0)
>> -			goto st_sensors_match_odr_error;
>> +			goto st_sensors_match_fs_error;
>>   
>>   		if (sensor_settings->fs.fs_avl[i].num == fs) {
>>   			*index_fs_avl = i;
>> @@ -142,7 +142,7 @@ static int st_sensors_match_fs(struct st_sensor_settings *sensor_settings,
>>   		}
>>   	}
>>   
>> -st_sensors_match_odr_error:
>> +st_sensors_match_fs_error:
>>   	return ret;
> This goto seems a little pointless in general. Let's just directly return instead of coming here
> in the first place.
> 

I think the goto is in place in case later logic is added that needs 
explicit cleanup. However, it's fine to just add that logic later, so 
it's a judgment call. If you prefer, I'll change it to an explicit return.

>>   }
>>   
>> diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
>> index fdcc5a891958..224596b0e189 100644
>> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
>> @@ -104,7 +104,7 @@ static irqreturn_t st_sensors_irq_thread(int irq, void *p)
>>   		return IRQ_HANDLED;
>>   
>>   	/*
>> -	 * If we are using egde IRQs, new samples arrived while processing
>> +	 * If we are using edge IRQs, new samples arrived while processing
>>   	 * the IRQ and those may be missed unless we pick them here, so poll
>>   	 * again. If the sensor delivery frequency is very high, this thread
>>   	 * turns into a polled loop handler.
>> @@ -148,7 +148,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
>>   		if (!sdata->sensor_settings->drdy_irq.addr_ihl) {
>>   			dev_err(&indio_dev->dev,
>>   				"falling/low specified for IRQ "
>> -				"but hardware only support rising/high: "
>> +				"but hardware supports only rising/high: "
> Either of those two is fine to my mind so please leave this one alone.
> 
> Good thing we never adopted an English language guide for the kernel ;)
> 

This is a case in which I wouldn't issue a standalone patch just for it, 
but since I'm fixing other things, I might as well fix this too. There 
are two grammar issues here, one more important than the other:

(1) "hardware support" --> "hardware supports". This is the main one I 
wanted to fix.

(2) While I'm at it, technically the hardware "only supports rising/high 
interrupts" means the *only* thing it supports is rising/high 
interrupts, while we actually want to say that the only type of 
*interrupt* it supports is rising/high. "supports only" does that.

Again, these things are minor, so if you'd like to fix (1), (2), or 
neither, it's all fine with me. Just let me know how to proceed.

>>   				"will request rising/high\n");
>>   			if (irq_trig == IRQF_TRIGGER_FALLING)
>>   				irq_trig = IRQF_TRIGGER_RISING;
>> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
>> index 72f6d1335a04..880c11c7f1cb 100644
>> --- a/drivers/iio/magnetometer/st_magn_core.c
>> +++ b/drivers/iio/magnetometer/st_magn_core.c
>> @@ -29,9 +29,9 @@
>>   #define ST_MAGN_NUMBER_DATA_CHANNELS		3
>>   
>>   /* DEFAULT VALUE FOR SENSORS */
>> -#define ST_MAGN_DEFAULT_OUT_X_H_ADDR		0X03
>> -#define ST_MAGN_DEFAULT_OUT_Y_H_ADDR		0X07
>> -#define ST_MAGN_DEFAULT_OUT_Z_H_ADDR		0X05
>> +#define ST_MAGN_DEFAULT_OUT_X_H_ADDR		0x03
>> +#define ST_MAGN_DEFAULT_OUT_Y_H_ADDR		0x07
>> +#define ST_MAGN_DEFAULT_OUT_Z_H_ADDR		0x05
>>   
>>   /* FULLSCALE */
>>   #define ST_MAGN_FS_AVL_1300MG			1300
> 
> 
